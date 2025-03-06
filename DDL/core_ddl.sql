-- Core DDL
-- number of tables 12

CREATE OR REPLACE TABLE dev_db.core_dna.LOB (
    LOB_ID INT PRIMARY KEY,
    Line_of_business VARCHAR(50)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Car (
    car_id INT PRIMARY KEY,
    LOB_ID INT,
    car_name VARCHAR(50),
    --PRIMARY KEY (car_id, LOB_ID),
    FOREIGN KEY (LOB_ID) REFERENCES dev_db.core_dna.LOB(LOB_ID)
);

CREATE OR REPLACE TABLE dev_db.core_dna.car_Model (
    model_id INT ,
    model_name VARCHAR(50),
    car_id INT,
    LOB_ID INT,
    PRIMARY KEY (model_id),
    FOREIGN KEY (car_id) REFERENCES dev_db.core_dna.Car(car_id),
    FOREIGN KEY (LOB_ID) REFERENCES dev_db.core_dna.LOB(LOB_ID)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Division (
    division_id INT PRIMARY KEY,
    division_name VARCHAR(50),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES dev_db.core_dna.Region(region_id)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Dealer (
    dealer_code INT PRIMARY KEY,
    dealer_name VARCHAR(50),
    partner_type VARCHAR(50),
    division_id INT,
    FOREIGN KEY (division_id) REFERENCES dev_db.core_dna.Division(division_id)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Job_card (
    job_card_number INT PRIMARY KEY,
    JC_open_days INT,
    job_card_start_date TIMESTAMP_NTZ(9),
    job_card_end_date TIMESTAMP_NTZ(9),
    KM_run INT,
    dealer_code INT,
    model_id INT,
    service_id INT,
    FOREIGN KEY (dealer_code) REFERENCES dev_db.core_dna.Dealer(dealer_code),
    FOREIGN KEY (model_id) REFERENCES dev_db.core_dna.car_Model(model_id),
    FOREIGN KEY (service_id) REFERENCES dev_db.core_dna.Service(service_id)
);

CREATE OR REPLACE TABLE dev_db.core_dna.part_category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Parts (
    part_no INT PRIMARY KEY,
    part_desc VARCHAR(50),
    category_id INT,
    TM_part_indicator VARCHAR(50),
    TM_spare_amount INT,
    spare_amount INT,
    FOREIGN KEY (category_id) REFERENCES dev_db.core_dna.part_category(category_id)
);

CREATE OR REPLACE TABLE dev_db.core_dna.service (
    service_id INT PRIMARY KEY,
    service_type VARCHAR(50)
);

CREATE OR REPLACE TABLE dev_db.core_dna.Invoice_line (
    invoice_number INT PRIMARY KEY,
    job_card_number INT,
    invoice_date TIMESTAMP_NTZ(9),
    invoice_status VARCHAR(50),
    FOREIGN KEY (job_card_number) REFERENCES dev_db.core_dna.Job_card(job_card_number)
);

CREATE OR REPLACE TABLE dev_db.core_dna.invoice_line_item_details (
    invoice_line_item_id INT PRIMARY KEY,
    tm_spare_amount INT,
    sold_qty INT,
    part_id INT,
    spare_amount INT,
    invoice_number INT,
    job_card_number INT,
    part_no INT,
    FOREIGN KEY (invoice_number) REFERENCES dev_db.core_dna.Invoice_line(invoice_number),
    FOREIGN KEY (job_card_number) REFERENCES dev_db.core_dna.Job_card(job_card_number),
    FOREIGN KEY (part_no) REFERENCES dev_db.core_dna.Parts(part_no)
);


