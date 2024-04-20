Return-Path: <linux-kernel+bounces-152372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0F8ABD0A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6095D1C2074D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32947A58;
	Sat, 20 Apr 2024 20:09:06 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CA5374F7;
	Sat, 20 Apr 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643746; cv=none; b=kJX25dh7P2LEJIO5IVp1Ka4/0mb6huDzUfEXIWDAw+9WY16s9LJcuDlXKnogmxRVk7P+yJjEDyclfYd7ovOaLRht1G65Ng/WZY2ebWuF/YsSGrGAdqbX2tYx2SYfmNpMoVAoXnfZBUeX9wJvrbwRWY6it+JQEIk4CtmOa1s4Lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643746; c=relaxed/simple;
	bh=NRJ6iqRtJPQzhm+uZTGBeb1nQEvmOrudm7MhknkvQcE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=s8NlqfJv3X6PBkEsWuz2ZyePeuKyPXe1fowBMW2HNC22AZjzftzfvj7bhJpUqSFnXr4MWoSZ9BHxownXsWFSe2KcdmZgwygmxAOzU9vMeo/AQi2om9FrIH6o6ZbMwsyCzdruI3xC+b7sbFAgsg+3s2sUQTlm5g03ltUCSwVMWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D459E30008CA3;
	Sat, 20 Apr 2024 22:09:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id CE71A10C1B1; Sat, 20 Apr 2024 22:09:02 +0200 (CEST)
Message-ID: <b11792137186f5a6794f12fdf891d0c6d51b3557.1713608122.git.lukas@wunner.de>
In-Reply-To: <cover.1713608122.git.lukas@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 20 Apr 2024 22:00:06 +0200
Subject: [PATCH 6/6] scsi: Use device_show_string() helper for sysfs
 attributes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Anil Gurumurthy <anil.gurumurthy@qlogic.com>, Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, Nilesh Javali <njavali@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com, Don Brace <don.brace@microchip.com>, storagedev@microchip.com, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Deduplicate sysfs ->show() callbacks which expose a string at a static
memory location.  Use the newly introduced device_show_string() helper
in the driver core instead by declaring those sysfs attributes with
DEVICE_STRING_ATTR_RO().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/scsi/bfa/bfad_attr.c             | 28 ++++++------------------
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 11 ++--------
 drivers/scsi/mvsas/mv_init.c             | 10 ++-------
 drivers/scsi/qla2xxx/qla_attr.c          | 11 ++--------
 drivers/scsi/smartpqi/smartpqi_init.c    | 11 +++-------
 5 files changed, 16 insertions(+), 55 deletions(-)

diff --git a/drivers/scsi/bfa/bfad_attr.c b/drivers/scsi/bfa/bfad_attr.c
index e96e4b6df265..54bc1539e1e9 100644
--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -853,13 +853,6 @@ bfad_im_hw_version_show(struct device *dev, struct device_attribute *attr,
 	return sysfs_emit(buf, "%s\n", hw_ver);
 }
 
-static ssize_t
-bfad_im_drv_version_show(struct device *dev, struct device_attribute *attr,
-				char *buf)
-{
-	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_VERSION);
-}
-
 static ssize_t
 bfad_im_optionrom_version_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
@@ -901,13 +894,6 @@ bfad_im_num_of_ports_show(struct device *dev, struct device_attribute *attr,
 			bfa_get_nports(&bfad->bfa));
 }
 
-static ssize_t
-bfad_im_drv_name_show(struct device *dev, struct device_attribute *attr,
-				char *buf)
-{
-	return sysfs_emit(buf, "%s\n", BFAD_DRIVER_NAME);
-}
-
 static ssize_t
 bfad_im_num_of_discovered_ports_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -944,15 +930,15 @@ static          DEVICE_ATTR(symbolic_name, S_IRUGO,
 				bfad_im_symbolic_name_show, NULL);
 static          DEVICE_ATTR(hardware_version, S_IRUGO,
 				bfad_im_hw_version_show, NULL);
-static          DEVICE_ATTR(driver_version, S_IRUGO,
-				bfad_im_drv_version_show, NULL);
+static		DEVICE_STRING_ATTR_RO(driver_version, S_IRUGO,
+				BFAD_DRIVER_VERSION);
 static          DEVICE_ATTR(option_rom_version, S_IRUGO,
 				bfad_im_optionrom_version_show, NULL);
 static          DEVICE_ATTR(firmware_version, S_IRUGO,
 				bfad_im_fw_version_show, NULL);
 static          DEVICE_ATTR(number_of_ports, S_IRUGO,
 				bfad_im_num_of_ports_show, NULL);
-static          DEVICE_ATTR(driver_name, S_IRUGO, bfad_im_drv_name_show, NULL);
+static		DEVICE_STRING_ATTR_RO(driver_name, S_IRUGO, BFAD_DRIVER_NAME);
 static          DEVICE_ATTR(number_of_discovered_ports, S_IRUGO,
 				bfad_im_num_of_discovered_ports_show, NULL);
 
@@ -963,11 +949,11 @@ static struct attribute *bfad_im_host_attrs[] = {
 	&dev_attr_node_name.attr,
 	&dev_attr_symbolic_name.attr,
 	&dev_attr_hardware_version.attr,
-	&dev_attr_driver_version.attr,
+	&dev_attr_driver_version.attr.attr,
 	&dev_attr_option_rom_version.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_number_of_ports.attr,
-	&dev_attr_driver_name.attr,
+	&dev_attr_driver_name.attr.attr,
 	&dev_attr_number_of_discovered_ports.attr,
 	NULL,
 };
@@ -988,11 +974,11 @@ static struct attribute *bfad_im_vport_attrs[] = {
 	&dev_attr_node_name.attr,
 	&dev_attr_symbolic_name.attr,
 	&dev_attr_hardware_version.attr,
-	&dev_attr_driver_version.attr,
+	&dev_attr_driver_version.attr.attr,
 	&dev_attr_option_rom_version.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_number_of_ports.attr,
-	&dev_attr_driver_name.attr,
+	&dev_attr_driver_name.attr.attr,
 	&dev_attr_number_of_discovered_ports.attr,
 	NULL,
 };
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 68b99924ee4f..2fca17cf8b51 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3613,12 +3613,6 @@ static void ibmvscsis_remove(struct vio_dev *vdev)
 	kfree(vscsi);
 }
 
-static ssize_t system_id_show(struct device *dev,
-			      struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%s\n", system_id);
-}
-
 static ssize_t partition_number_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
@@ -3982,8 +3976,7 @@ static const struct target_core_fabric_ops ibmvscsis_ops = {
 
 static void ibmvscsis_dev_release(struct device *dev) {};
 
-static struct device_attribute dev_attr_system_id =
-	__ATTR(system_id, S_IRUGO, system_id_show, NULL);
+static DEVICE_STRING_ATTR_RO(system_id, S_IRUGO, system_id);
 
 static struct device_attribute dev_attr_partition_number =
 	__ATTR(partition_number, S_IRUGO, partition_number_show, NULL);
@@ -3992,7 +3985,7 @@ static struct device_attribute dev_attr_unit_address =
 	__ATTR(unit_address, S_IRUGO, unit_address_show, NULL);
 
 static struct attribute *ibmvscsis_dev_attrs[] = {
-	&dev_attr_system_id.attr,
+	&dev_attr_system_id.attr.attr,
 	&dev_attr_partition_number.attr,
 	&dev_attr_unit_address.attr,
 };
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 43ebb331e216..2a25d574feb9 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -691,13 +691,7 @@ static struct pci_driver mvs_pci_driver = {
 	.remove		= mvs_pci_remove,
 };
 
-static ssize_t driver_version_show(struct device *cdev,
-				   struct device_attribute *attr, char *buffer)
-{
-	return sysfs_emit(buffer, "%s\n", DRV_VERSION);
-}
-
-static DEVICE_ATTR_RO(driver_version);
+static DEVICE_STRING_ATTR_RO(driver_version, 0444, DRV_VERSION);
 
 static ssize_t interrupt_coalescing_store(struct device *cdev,
 					  struct device_attribute *attr,
@@ -772,7 +766,7 @@ static void __exit mvs_exit(void)
 }
 
 static struct attribute *mvst_host_attrs[] = {
-	&dev_attr_driver_version.attr,
+	&dev_attr_driver_version.attr.attr,
 	&dev_attr_interrupt_coalescing.attr,
 	NULL,
 };
diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 44449c70a375..d4b420aef4a8 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -1067,13 +1067,6 @@ qla2x00_free_sysfs_attr(scsi_qla_host_t *vha, bool stop_beacon)
 
 /* Scsi_Host attributes. */
 
-static ssize_t
-qla2x00_driver_version_show(struct device *dev,
-			  struct device_attribute *attr, char *buf)
-{
-	return scnprintf(buf, PAGE_SIZE, "%s\n", qla2x00_version_str);
-}
-
 static ssize_t
 qla2x00_fw_version_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -2412,7 +2405,7 @@ qla2x00_dport_diagnostics_show(struct device *dev,
 static DEVICE_ATTR(dport_diagnostics, 0444,
 	   qla2x00_dport_diagnostics_show, NULL);
 
-static DEVICE_ATTR(driver_version, S_IRUGO, qla2x00_driver_version_show, NULL);
+static DEVICE_STRING_ATTR_RO(driver_version, S_IRUGO, qla2x00_version_str);
 static DEVICE_ATTR(fw_version, S_IRUGO, qla2x00_fw_version_show, NULL);
 static DEVICE_ATTR(serial_num, S_IRUGO, qla2x00_serial_num_show, NULL);
 static DEVICE_ATTR(isp_name, S_IRUGO, qla2x00_isp_name_show, NULL);
@@ -2478,7 +2471,7 @@ static DEVICE_ATTR(port_no, 0444, qla2x00_port_no_show, NULL);
 static DEVICE_ATTR(fw_attr, 0444, qla2x00_fw_attr_show, NULL);
 
 static struct attribute *qla2x00_host_attrs[] = {
-	&dev_attr_driver_version.attr,
+	&dev_attr_driver_version.attr.attr,
 	&dev_attr_fw_version.attr,
 	&dev_attr_serial_num.attr,
 	&dev_attr_isp_name.attr,
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 385180c98be4..f11cf590b2a9 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6892,12 +6892,6 @@ static ssize_t pqi_firmware_version_show(struct device *dev,
 	return scnprintf(buffer, PAGE_SIZE, "%s\n", ctrl_info->firmware_version);
 }
 
-static ssize_t pqi_driver_version_show(struct device *dev,
-	struct device_attribute *attr, char *buffer)
-{
-	return scnprintf(buffer, PAGE_SIZE, "%s\n", DRIVER_VERSION BUILD_TIMESTAMP);
-}
-
 static ssize_t pqi_serial_number_show(struct device *dev,
 	struct device_attribute *attr, char *buffer)
 {
@@ -7066,7 +7060,8 @@ static ssize_t pqi_host_enable_r6_writes_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(driver_version, 0444, pqi_driver_version_show, NULL);
+static DEVICE_STRING_ATTR_RO(driver_version, 0444,
+	DRIVER_VERSION BUILD_TIMESTAMP);
 static DEVICE_ATTR(firmware_version, 0444, pqi_firmware_version_show, NULL);
 static DEVICE_ATTR(model, 0444, pqi_model_show, NULL);
 static DEVICE_ATTR(serial_number, 0444, pqi_serial_number_show, NULL);
@@ -7083,7 +7078,7 @@ static DEVICE_ATTR(enable_r6_writes, 0644,
 	pqi_host_enable_r6_writes_show, pqi_host_enable_r6_writes_store);
 
 static struct attribute *pqi_shost_attrs[] = {
-	&dev_attr_driver_version.attr,
+	&dev_attr_driver_version.attr.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_model.attr,
 	&dev_attr_serial_number.attr,
-- 
2.43.0


