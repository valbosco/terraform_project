provider "google" {
  credentials = "${file("Terraform-GCP-3cc8b0297c25.json")}"
  project     = "terraform-gcp-246604"
  region      = "asia-south1"
  zone        = "asia-south1-a"
  
}

resource "google_compute_instance" "vm_instance" {
    name = "terraform-instance"
    machine_type = "f1-micro"

    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-9"
        }
    }
    network_interface{
        # a default network is created for all GCP
        network = "${google_compute_network.vpc_instance.self_link}"
        access_config { }
    }
}

resource "google_compute_network" "vpc_instance" {
  name = "terraform-network"
  auto_create_subnetworks = "true"
}