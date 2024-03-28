Return-Path: <linux-kernel+bounces-114749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0F08890F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725821C2CF39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225AC1B6FDF;
	Mon, 25 Mar 2024 00:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uJZkUhAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D22745C2;
	Sun, 24 Mar 2024 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323336; cv=none; b=FfSRRK00+Xg1OFr6bdu1L5J0z8P01FeK5wvbqoA7QSaF0Nrdd55mURlKI9C+yOKy5Do4dCoKfERKKlcPs6tnrURDE1OmMPFtvZzUM90y0DFTFbpqEgSGzX+XB2TK82+tnWUjlqHfbx5urX1hKo2XS/fPhAF8sn77UqHhiHb/78c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323336; c=relaxed/simple;
	bh=AlVLB2kkcZvN1L50r41nkoVt8ZMr4jbyk5yP/1fZ3hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mx6G4cC/lGgU8UzDqQzCO723EgtCpgkPxIMwodzr9SqhJt4jhy+uw5KtWQPKpPoREOk4m9kF3OLiPHK1/ytG+WFU0G0W5iFxjsRoc3266+Opbs+6HME1Lp6r1YoNh4cHtyzps5ibqLf3oGAt/wWotcgRyfPynJaWWvpsATIsEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uJZkUhAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14270C433F1;
	Sun, 24 Mar 2024 23:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323334;
	bh=AlVLB2kkcZvN1L50r41nkoVt8ZMr4jbyk5yP/1fZ3hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uJZkUhAJNy9HEOEYlNhTPQlSxAQFNBbUy/W2ssoFtYx+zkYx0fboQp7uNZ3ygoEw+
	 nvseyKaqRpfDvDiWqkaBz7b1c8v5iiKJH1YXMzaE8lmgmkJBFrgD/4lpMZDnay3u04
	 J0pjshGvEHhux9IAF4Ps681CvZ0Y7UmIjklRG1FPqg5EhCYGRBR+frMf83TPm92XdQ
	 sL/Z+Cn3ITKp1rEa4TvgHD4YMl2+KXQasgEmusIKzE24kk+8c5yhfeIO1WR+OF0SBe
	 OuNLt+Wah0nZ2D1eEQ1OYU6m7dXDZ95ZVcS37+mTWQIlhGsdAoXoVEGvRV1NIZy+S2
	 1Z8xvjSm4jWpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 035/317] s390/dasd: add copy pair setup
Date: Sun, 24 Mar 2024 19:30:15 -0400
Message-ID: <20240324233458.1352854-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit a91ff09d39f9b6545254839ac91f1ff7bd21d39e ]

A copy relation that is configured on the storage server side needs to be
enabled separately in the device driver. A sysfs interface is created
that allows userspace tooling to control such setup.

The following sysfs entries are added to store and read copy relation
information:

copy_pair
    - Add/Delete a copy pair relation to the DASD device driver
    - Query all previously added copy pair relations
copy_role
    - Query the copy pair role of the device

To add a copy pair to the DASD device driver it has to be specified
through the sysfs attribute copy_pair. Only one secondary device can be
specified at a time together with the primary device. Both, secondary
and primary can be used equally to define the copy pair.
The secondary devices have to be offline when adding the copy relation.
The primary device needs to be specified first followed by the comma
separated secondary device.
Read from the copy_pair attribute to get the current setup and write
"clear" to the attribute to delete any existing setup.

Example:
$ echo 0.0.9700,0.0.9740 > /sys/bus/ccw/devices/0.0.9700/copy_pair
$ cat /sys/bus/ccw/devices/0.0.9700/copy_pair
0.0.9700,0.0.9740

During device online processing the required data will be read from the
storage server and the information will be compared to the setup
requested through the copy_pair attribute. The registration of the
primary and secondary device will be handled accordingly.
A blockdevice is only allocated for copy relation primary devices.

To query the copy role of a device read from the copy_role sysfs
attribute. Possible values are primary, secondary, and none.

Example:
$ cat /sys/bus/ccw/devices/0.0.9700/copy_role
primary

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20220920192616.808070-4-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3116e62ddef ("s390/dasd: fix double module refcount decrement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_devmap.c | 566 ++++++++++++++++++++++++++++++-
 drivers/s390/block/dasd_eckd.c   |  52 ++-
 drivers/s390/block/dasd_eckd.h   |   2 +-
 drivers/s390/block/dasd_int.h    |  20 ++
 4 files changed, 623 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 2c40fe15da552..6f9f7a0723128 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -26,7 +26,6 @@
 
 /* This is ugly... */
 #define PRINTK_HEADER "dasd_devmap:"
-#define DASD_BUS_ID_SIZE 20
 #define DASD_MAX_PARAMS 256
 
 #include "dasd_int.h"
@@ -50,6 +49,7 @@ struct dasd_devmap {
         unsigned int devindex;
         unsigned short features;
 	struct dasd_device *device;
+	struct dasd_copy_relation *copy;
 };
 
 /*
@@ -130,7 +130,7 @@ __setup ("dasd=", dasd_call_setup);
 /*
  * Read a device busid/devno from a string.
  */
-static int __init dasd_busid(char *str, int *id0, int *id1, int *devno)
+static int dasd_busid(char *str, int *id0, int *id1, int *devno)
 {
 	unsigned int val;
 	char *tok;
@@ -438,16 +438,12 @@ dasd_add_busid(const char *bus_id, int features)
 	return devmap;
 }
 
-/*
- * Find devmap for device with given bus_id.
- */
 static struct dasd_devmap *
-dasd_find_busid(const char *bus_id)
+dasd_find_busid_locked(const char *bus_id)
 {
 	struct dasd_devmap *devmap, *tmp;
 	int hash;
 
-	spin_lock(&dasd_devmap_lock);
 	devmap = ERR_PTR(-ENODEV);
 	hash = dasd_hash_busid(bus_id);
 	list_for_each_entry(tmp, &dasd_hashlists[hash], list) {
@@ -456,6 +452,19 @@ dasd_find_busid(const char *bus_id)
 			break;
 		}
 	}
+	return devmap;
+}
+
+/*
+ * Find devmap for device with given bus_id.
+ */
+static struct dasd_devmap *
+dasd_find_busid(const char *bus_id)
+{
+	struct dasd_devmap *devmap;
+
+	spin_lock(&dasd_devmap_lock);
+	devmap = dasd_find_busid_locked(bus_id);
 	spin_unlock(&dasd_devmap_lock);
 	return devmap;
 }
@@ -584,6 +593,238 @@ dasd_create_device(struct ccw_device *cdev)
 	return device;
 }
 
+/*
+ * allocate a PPRC data structure and call the discipline function to fill
+ */
+static int dasd_devmap_get_pprc_status(struct dasd_device *device,
+				       struct dasd_pprc_data_sc4 **data)
+{
+	struct dasd_pprc_data_sc4 *temp;
+
+	if (!device->discipline || !device->discipline->pprc_status) {
+		dev_warn(&device->cdev->dev, "Unable to query copy relation status\n");
+		return -EOPNOTSUPP;
+	}
+	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	/* get PPRC information from storage */
+	if (device->discipline->pprc_status(device, temp)) {
+		dev_warn(&device->cdev->dev, "Error during copy relation status query\n");
+		kfree(temp);
+		return -EINVAL;
+	}
+	*data = temp;
+
+	return 0;
+}
+
+/*
+ * find an entry in a PPRC device_info array by a given UID
+ * depending on the primary/secondary state of the device it has to be
+ * matched with the respective fields
+ */
+static int dasd_devmap_entry_from_pprc_data(struct dasd_pprc_data_sc4 *data,
+					    struct dasd_uid uid,
+					    bool primary)
+{
+	int i;
+
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (primary) {
+			if (data->dev_info[i].prim_cu_ssid == uid.ssid &&
+			    data->dev_info[i].primary == uid.real_unit_addr)
+				return i;
+		} else {
+			if (data->dev_info[i].sec_cu_ssid == uid.ssid &&
+			    data->dev_info[i].secondary == uid.real_unit_addr)
+				return i;
+		}
+	}
+	return -1;
+}
+
+/*
+ * check the consistency of a specified copy relation by checking
+ * the following things:
+ *
+ *   - is the given device part of a copy pair setup
+ *   - does the state of the device match the state in the PPRC status data
+ *   - does the device UID match with the UID in the PPRC status data
+ *   - to prevent misrouted IO check if the given device is present in all
+ *     related PPRC status data
+ */
+static int dasd_devmap_check_copy_relation(struct dasd_device *device,
+					   struct dasd_copy_entry *entry,
+					   struct dasd_pprc_data_sc4 *data,
+					   struct dasd_copy_relation *copy)
+{
+	struct dasd_pprc_data_sc4 *tmp_dat;
+	struct dasd_device *tmp_dev;
+	struct dasd_uid uid;
+	int i, j;
+
+	if (!device->discipline || !device->discipline->get_uid ||
+	    device->discipline->get_uid(device, &uid))
+		return 1;
+
+	i = dasd_devmap_entry_from_pprc_data(data, uid, entry->primary);
+	if (i < 0) {
+		dev_warn(&device->cdev->dev, "Device not part of a copy relation\n");
+		return 1;
+	}
+
+	/* double check which role the current device has */
+	if (entry->primary) {
+		if (data->dev_info[i].flags & 0x80) {
+			dev_warn(&device->cdev->dev, "Copy pair secondary is setup as primary\n");
+			return 1;
+		}
+		if (data->dev_info[i].prim_cu_ssid != uid.ssid ||
+		    data->dev_info[i].primary != uid.real_unit_addr) {
+			dev_warn(&device->cdev->dev,
+				 "Primary device %s does not match copy pair status primary device %04x\n",
+				 dev_name(&device->cdev->dev),
+				 data->dev_info[i].prim_cu_ssid |
+				 data->dev_info[i].primary);
+			return 1;
+		}
+	} else {
+		if (!(data->dev_info[i].flags & 0x80)) {
+			dev_warn(&device->cdev->dev, "Copy pair primary is setup as secondary\n");
+			return 1;
+		}
+		if (data->dev_info[i].sec_cu_ssid != uid.ssid ||
+		    data->dev_info[i].secondary != uid.real_unit_addr) {
+			dev_warn(&device->cdev->dev,
+				 "Secondary device %s does not match copy pair status secondary device %04x\n",
+				 dev_name(&device->cdev->dev),
+				 data->dev_info[i].sec_cu_ssid |
+				 data->dev_info[i].secondary);
+			return 1;
+		}
+	}
+
+	/*
+	 * the current device has to be part of the copy relation of all
+	 * entries to prevent misrouted IO to another copy pair
+	 */
+	for (j = 0; j < DASD_CP_ENTRIES; j++) {
+		if (entry == &copy->entry[j])
+			tmp_dev = device;
+		else
+			tmp_dev = copy->entry[j].device;
+
+		if (!tmp_dev)
+			continue;
+
+		if (dasd_devmap_get_pprc_status(tmp_dev, &tmp_dat))
+			return 1;
+
+		if (dasd_devmap_entry_from_pprc_data(tmp_dat, uid, entry->primary) < 0) {
+			dev_warn(&tmp_dev->cdev->dev,
+				 "Copy pair relation does not contain device: %s\n",
+				 dev_name(&device->cdev->dev));
+			kfree(tmp_dat);
+			return 1;
+		}
+		kfree(tmp_dat);
+	}
+	return 0;
+}
+
+/* delete device from copy relation entry */
+static void dasd_devmap_delete_copy_relation_device(struct dasd_device *device)
+{
+	struct dasd_copy_relation *copy;
+	int i;
+
+	if (!device->copy)
+		return;
+
+	copy = device->copy;
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].device == device)
+			copy->entry[i].device = NULL;
+	}
+	dasd_put_device(device);
+	device->copy = NULL;
+}
+
+/*
+ * read all required information for a copy relation setup and setup the device
+ * accordingly
+ */
+int dasd_devmap_set_device_copy_relation(struct ccw_device *cdev,
+					 bool pprc_enabled)
+{
+	struct dasd_pprc_data_sc4 *data = NULL;
+	struct dasd_copy_entry *entry = NULL;
+	struct dasd_copy_relation *copy;
+	struct dasd_devmap *devmap;
+	struct dasd_device *device;
+	int i, rc = 0;
+
+	devmap = dasd_devmap_from_cdev(cdev);
+	if (IS_ERR(devmap))
+		return PTR_ERR(devmap);
+
+	device = devmap->device;
+	if (!device)
+		return -ENODEV;
+
+	copy = devmap->copy;
+	/* no copy pair setup for this device */
+	if (!copy)
+		goto out;
+
+	rc = dasd_devmap_get_pprc_status(device, &data);
+	if (rc)
+		return rc;
+
+	/* print error if PPRC is requested but not enabled on storage server */
+	if (!pprc_enabled) {
+		dev_err(&cdev->dev, "Copy relation not enabled on storage server\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!data->dev_info[0].state) {
+		dev_warn(&device->cdev->dev, "Copy pair setup requested for device not in copy relation\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	/* find entry */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured &&
+		    strncmp(dev_name(&cdev->dev),
+			    copy->entry[i].busid, DASD_BUS_ID_SIZE) == 0) {
+			entry = &copy->entry[i];
+			break;
+		}
+	}
+	if (!entry) {
+		dev_warn(&device->cdev->dev, "Copy relation entry not found\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	/* check if the copy relation is valid */
+	if (dasd_devmap_check_copy_relation(device, entry, data, copy)) {
+		dev_warn(&device->cdev->dev, "Copy relation faulty\n");
+		rc = -EINVAL;
+		goto out;
+	}
+
+	dasd_get_device(device);
+	copy->entry[i].device = device;
+	device->copy = copy;
+out:
+	kfree(data);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dasd_devmap_set_device_copy_relation);
+
 /*
  * Wait queue for dasd_delete_device waits.
  */
@@ -617,6 +858,8 @@ dasd_delete_device(struct dasd_device *device)
 	dev_set_drvdata(&device->cdev->dev, NULL);
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 
+	/* Removve copy relation */
+	dasd_devmap_delete_copy_relation_device(device);
 	/*
 	 * Drop ref_count by 3, one for the devmap reference, one for
 	 * the cdev reference and one for the passed reference.
@@ -1683,6 +1926,313 @@ dasd_path_fcs_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 static struct kobj_attribute path_fcs_attribute =
 	__ATTR(fc_security, 0444, dasd_path_fcs_show, NULL);
 
+/*
+ * print copy relation in the form
+ * primary,secondary[1] primary,secondary[2], ...
+ */
+static ssize_t
+dasd_copy_pair_show(struct device *dev,
+		    struct device_attribute *attr, char *buf)
+{
+	char prim_busid[DASD_BUS_ID_SIZE];
+	struct dasd_copy_relation *copy;
+	struct dasd_devmap *devmap;
+	int len = 0;
+	int i;
+
+	devmap = dasd_find_busid(dev_name(dev));
+	if (IS_ERR(devmap))
+		return -ENODEV;
+
+	if (!devmap->copy)
+		return -ENODEV;
+
+	copy = devmap->copy;
+	/* find primary */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured && copy->entry[i].primary) {
+			strscpy(prim_busid, copy->entry[i].busid,
+				DASD_BUS_ID_SIZE);
+			break;
+		}
+	}
+	if (!copy->entry[i].primary)
+		goto out;
+
+	/* print all secondary */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured && !copy->entry[i].primary)
+			len += sysfs_emit_at(buf, len, "%s,%s ", prim_busid,
+					     copy->entry[i].busid);
+	}
+
+	len += sysfs_emit_at(buf, len, "\n");
+out:
+	return len;
+}
+
+static int dasd_devmap_set_copy_relation(struct dasd_devmap *devmap,
+					 struct dasd_copy_relation *copy,
+					 char *busid, bool primary)
+{
+	int i;
+
+	/* find free entry */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		/* current bus_id already included, nothing to do */
+		if (copy->entry[i].configured &&
+		    strncmp(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE) == 0)
+			return 0;
+
+		if (!copy->entry[i].configured)
+			break;
+	}
+	if (i == DASD_CP_ENTRIES)
+		return -EINVAL;
+
+	copy->entry[i].configured = true;
+	strscpy(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE);
+	if (primary) {
+		copy->active = &copy->entry[i];
+		copy->entry[i].primary = true;
+	}
+	if (!devmap->copy)
+		devmap->copy = copy;
+
+	return 0;
+}
+
+static void dasd_devmap_del_copy_relation(struct dasd_copy_relation *copy,
+					  char *busid)
+{
+	int i;
+
+	spin_lock(&dasd_devmap_lock);
+	/* find entry */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].configured &&
+		    strncmp(copy->entry[i].busid, busid, DASD_BUS_ID_SIZE) == 0)
+			break;
+	}
+	if (i == DASD_CP_ENTRIES || !copy->entry[i].configured) {
+		spin_unlock(&dasd_devmap_lock);
+		return;
+	}
+
+	copy->entry[i].configured = false;
+	memset(copy->entry[i].busid, 0, DASD_BUS_ID_SIZE);
+	if (copy->active == &copy->entry[i]) {
+		copy->active = NULL;
+		copy->entry[i].primary = false;
+	}
+	spin_unlock(&dasd_devmap_lock);
+}
+
+static int dasd_devmap_clear_copy_relation(struct device *dev)
+{
+	struct dasd_copy_relation *copy;
+	struct dasd_devmap *devmap;
+	int i, rc = 1;
+
+	devmap = dasd_devmap_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(devmap))
+		return 1;
+
+	spin_lock(&dasd_devmap_lock);
+	if (!devmap->copy)
+		goto out;
+
+	copy = devmap->copy;
+	/* first check if all secondary devices are offline*/
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (!copy->entry[i].configured)
+			continue;
+
+		if (copy->entry[i].device == copy->active->device)
+			continue;
+
+		if (copy->entry[i].device)
+			goto out;
+	}
+	/* clear all devmap entries */
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (strlen(copy->entry[i].busid) == 0)
+			continue;
+		if (copy->entry[i].device) {
+			dasd_put_device(copy->entry[i].device);
+			copy->entry[i].device->copy = NULL;
+			copy->entry[i].device = NULL;
+		}
+		devmap = dasd_find_busid_locked(copy->entry[i].busid);
+		devmap->copy = NULL;
+		memset(copy->entry[i].busid, 0, DASD_BUS_ID_SIZE);
+	}
+	kfree(copy);
+	rc = 0;
+out:
+	spin_unlock(&dasd_devmap_lock);
+	return rc;
+}
+
+/*
+ * parse BUSIDs from a copy pair
+ */
+static int dasd_devmap_parse_busid(const char *buf, char *prim_busid,
+				   char *sec_busid)
+{
+	char *primary, *secondary, *tmp, *pt;
+	int id0, id1, id2;
+
+	pt =  kstrdup(buf, GFP_KERNEL);
+	tmp = pt;
+	if (!tmp)
+		return -ENOMEM;
+
+	primary = strsep(&tmp, ",");
+	if (!primary) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	secondary = strsep(&tmp, ",");
+	if (!secondary) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	if (dasd_busid(primary, &id0, &id1, &id2)) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	sprintf(prim_busid, "%01x.%01x.%04x", id0, id1, id2);
+	if (dasd_busid(secondary, &id0, &id1, &id2)) {
+		kfree(pt);
+		return -EINVAL;
+	}
+	sprintf(sec_busid, "%01x.%01x.%04x", id0, id1, id2);
+	kfree(pt);
+
+	return 0;
+}
+
+static ssize_t dasd_copy_pair_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct dasd_devmap *prim_devmap, *sec_devmap;
+	char prim_busid[DASD_BUS_ID_SIZE];
+	char sec_busid[DASD_BUS_ID_SIZE];
+	struct dasd_copy_relation *copy;
+	struct dasd_device *device;
+	bool pprc_enabled;
+	int rc;
+
+	if (strncmp(buf, "clear", strlen("clear")) == 0) {
+		if (dasd_devmap_clear_copy_relation(dev))
+			return -EINVAL;
+		return count;
+	}
+
+	rc = dasd_devmap_parse_busid(buf, prim_busid, sec_busid);
+	if (rc)
+		return rc;
+
+	if (strncmp(dev_name(dev), prim_busid, DASD_BUS_ID_SIZE) != 0 &&
+	    strncmp(dev_name(dev), sec_busid, DASD_BUS_ID_SIZE) != 0)
+		return -EINVAL;
+
+	/* allocate primary devmap if needed */
+	prim_devmap = dasd_find_busid(prim_busid);
+	if (IS_ERR(prim_devmap))
+		prim_devmap = dasd_add_busid(prim_busid, DASD_FEATURE_DEFAULT);
+
+	/* allocate secondary devmap if needed */
+	sec_devmap = dasd_find_busid(sec_busid);
+	if (IS_ERR(sec_devmap))
+		sec_devmap = dasd_add_busid(sec_busid, DASD_FEATURE_DEFAULT);
+
+	/* setting copy relation is only allowed for offline secondary */
+	if (sec_devmap->device)
+		return -EINVAL;
+
+	if (prim_devmap->copy) {
+		copy = prim_devmap->copy;
+	} else if (sec_devmap->copy) {
+		copy = sec_devmap->copy;
+	} else {
+		copy = kzalloc(sizeof(*copy), GFP_KERNEL);
+		if (!copy)
+			return -ENOMEM;
+	}
+	spin_lock(&dasd_devmap_lock);
+	rc = dasd_devmap_set_copy_relation(prim_devmap, copy, prim_busid, true);
+	if (rc) {
+		spin_unlock(&dasd_devmap_lock);
+		return rc;
+	}
+	rc = dasd_devmap_set_copy_relation(sec_devmap, copy, sec_busid, false);
+	if (rc) {
+		spin_unlock(&dasd_devmap_lock);
+		return rc;
+	}
+	spin_unlock(&dasd_devmap_lock);
+
+	/* if primary device is already online call device setup directly */
+	if (prim_devmap->device && !prim_devmap->device->copy) {
+		device = prim_devmap->device;
+		if (device->discipline->pprc_enabled) {
+			pprc_enabled = device->discipline->pprc_enabled(device);
+			rc = dasd_devmap_set_device_copy_relation(device->cdev,
+								  pprc_enabled);
+		} else {
+			rc = -EOPNOTSUPP;
+		}
+	}
+	if (rc) {
+		dasd_devmap_del_copy_relation(copy, prim_busid);
+		dasd_devmap_del_copy_relation(copy, sec_busid);
+		count = rc;
+	}
+
+	return count;
+}
+static DEVICE_ATTR(copy_pair, 0644, dasd_copy_pair_show,
+		   dasd_copy_pair_store);
+
+static ssize_t
+dasd_copy_role_show(struct device *dev,
+		    struct device_attribute *attr, char *buf)
+{
+	struct dasd_copy_relation *copy;
+	struct dasd_device *device;
+	int len, i;
+
+	device = dasd_device_from_cdev(to_ccwdev(dev));
+	if (IS_ERR(device))
+		return -ENODEV;
+
+	if (!device->copy) {
+		len = sysfs_emit(buf, "none\n");
+		goto out;
+	}
+	copy = device->copy;
+	/* only the active device is primary */
+	if (copy->active->device == device) {
+		len = sysfs_emit(buf, "primary\n");
+		goto out;
+	}
+	for (i = 0; i < DASD_CP_ENTRIES; i++) {
+		if (copy->entry[i].device == device) {
+			len = sysfs_emit(buf, "secondary\n");
+			goto out;
+		}
+	}
+	/* not in the list, no COPY role */
+	len = sysfs_emit(buf, "none\n");
+out:
+	dasd_put_device(device);
+	return len;
+}
+static DEVICE_ATTR(copy_role, 0444, dasd_copy_role_show, NULL);
+
 #define DASD_DEFINE_ATTR(_name, _func)					\
 static ssize_t dasd_##_name##_show(struct device *dev,			\
 				   struct device_attribute *attr,	\
@@ -1739,6 +2289,8 @@ static struct attribute * dasd_attrs[] = {
 	&dev_attr_hpf.attr,
 	&dev_attr_ese.attr,
 	&dev_attr_fc_security.attr,
+	&dev_attr_copy_pair.attr,
+	&dev_attr_copy_role.attr,
 	NULL,
 };
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 76f861c2ce614..59b11950fb60c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2028,11 +2028,28 @@ static void dasd_eckd_kick_validate_server(struct dasd_device *device)
 		dasd_put_device(device);
 }
 
+/*
+ * return if the device is the copy relation primary if a copy relation is active
+ */
+static int dasd_device_is_primary(struct dasd_device *device)
+{
+	if (!device->copy)
+		return 1;
+
+	if (device->copy->active->device == device)
+		return 1;
+
+	return 0;
+}
+
 static int dasd_eckd_alloc_block(struct dasd_device *device)
 {
 	struct dasd_block *block;
 	struct dasd_uid temp_uid;
 
+	if (!dasd_device_is_primary(device))
+		return 0;
+
 	dasd_eckd_get_uid(device, &temp_uid);
 	if (temp_uid.type == UA_BASE_DEVICE) {
 		block = dasd_alloc_block();
@@ -2047,6 +2064,13 @@ static int dasd_eckd_alloc_block(struct dasd_device *device)
 	return 0;
 }
 
+static bool dasd_eckd_pprc_enabled(struct dasd_device *device)
+{
+	struct dasd_eckd_private *private = device->private;
+
+	return private->rdc_data.facilities.PPRC_enabled;
+}
+
 /*
  * Check device characteristics.
  * If the device is accessible using ECKD discipline, the device is enabled.
@@ -2112,6 +2136,24 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 			device->default_expires = value;
 	}
 
+	/* Read Device Characteristics */
+	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
+					 &private->rdc_data, 64);
+	if (rc) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Read device characteristic failed, rc=%d", rc);
+		goto out_err1;
+	}
+
+	/* setup PPRC for device from devmap */
+	rc = dasd_devmap_set_device_copy_relation(device->cdev,
+						  dasd_eckd_pprc_enabled(device));
+	if (rc) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"copy relation setup failed, rc=%d", rc);
+		goto out_err1;
+	}
+
 	/* check if block device is needed and allocate in case */
 	rc = dasd_eckd_alloc_block(device);
 	if (rc)
@@ -2140,15 +2182,6 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	/* Read Extent Pool Information */
 	dasd_eckd_read_ext_pool_info(device);
 
-	/* Read Device Characteristics */
-	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
-					 &private->rdc_data, 64);
-	if (rc) {
-		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
-				"Read device characteristic failed, rc=%d", rc);
-		goto out_err3;
-	}
-
 	if ((device->features & DASD_FEATURE_USERAW) &&
 	    !(private->rdc_data.facilities.RT_in_LR)) {
 		dev_err(&device->cdev->dev, "The storage server does not "
@@ -6789,6 +6822,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.ese_format = dasd_eckd_ese_format,
 	.ese_read = dasd_eckd_ese_read,
 	.pprc_status = dasd_eckd_query_pprc_status,
+	.pprc_enabled = dasd_eckd_pprc_enabled,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index ed83a9a55191b..4b869c2bd5195 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -267,7 +267,7 @@ struct dasd_eckd_characteristics {
 		unsigned char reserved3:8;
 		unsigned char defect_wr:1;
 		unsigned char XRC_supported:1;
-		unsigned char reserved4:1;
+		unsigned char PPRC_enabled:1;
 		unsigned char striping:1;
 		unsigned char reserved5:4;
 		unsigned char cfw:1;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 2ee8bc035b34a..d743d1d2b38e9 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -291,6 +291,24 @@ struct dasd_pprc_data_sc4 {
 	struct dasd_pprc_dev_info dev_info[5];
 } __packed;
 
+#define DASD_BUS_ID_SIZE 20
+#define DASD_CP_ENTRIES 5
+
+struct dasd_copy_entry {
+	char busid[DASD_BUS_ID_SIZE];
+	struct dasd_device *device;
+	bool primary;
+	bool configured;
+};
+
+struct dasd_copy_relation {
+	struct dasd_copy_entry entry[DASD_CP_ENTRIES];
+	struct dasd_copy_entry *active;
+};
+
+int dasd_devmap_set_device_copy_relation(struct ccw_device *,
+					 bool pprc_enabled);
+
 /*
  * the struct dasd_discipline is
  * sth like a table of virtual functions, if you think of dasd_eckd
@@ -420,6 +438,7 @@ struct dasd_discipline {
 					   struct dasd_ccw_req *, struct irb *);
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
 	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
+	bool (*pprc_enabled)(struct dasd_device *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
@@ -616,6 +635,7 @@ struct dasd_device {
 	struct dasd_profile profile;
 	struct dasd_format_entry format_entry;
 	struct kset *paths_info;
+	struct dasd_copy_relation *copy;
 };
 
 struct dasd_block {
-- 
2.43.0


