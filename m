Return-Path: <linux-kernel+bounces-107107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D966F87F790
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0960F1C216A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB153814;
	Tue, 19 Mar 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oDjzxLac"
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8851C45;
	Tue, 19 Mar 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710830020; cv=none; b=TiO3DhjcAfCNhsgrP6JoNIQvgLIJo5j3d8QuCci3XvmiUfzxlj7CO4b+Lak+yUokvbA+IWnKMHbqLgiBfFwvYflli8Sl4q+awtecnwKPWObbF4UiVdPg7mIk0KrLJKd3XY0P/1tAEH60wDDv+GXtlqkKZ3sKL79Gv8OnWcUozvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710830020; c=relaxed/simple;
	bh=4PeghrYAkJkKJ07klpjA0g5ciCp0/essXeq/WQpnC58=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=reO4QZOiK9pD+ckoa/EEDDvCStpESqFLTjQC2MyBN4medMRB/rAX0bvuOzEu4uVtCv0ZMtLcZwphwgv7jTPob2MMagodEKCONsv9MvQoZ3esEb5meCQUuJzgQtDdttppmjRNVZT61BUpWc2ee3J+O43MzodTYjh5tP2sUI0M7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oDjzxLac; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710830018; x=1742366018;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4PeghrYAkJkKJ07klpjA0g5ciCp0/essXeq/WQpnC58=;
  b=oDjzxLacKTYDUDrLwCkZ5JJRP3Xx3juq3pcZ1qUp8CeLt2uJlCaWOGnK
   GF1bx0UTfJzsvs/A6no5y8NTPj7SqIpB+2BQ08qpbeArM51mpT8foFal8
   uHE15JGz7+r/RJ1ncaikm5eiiD9C+IfufrBHwIa+pzauNYfJDFOd/GQKl
   L88UO/ohNFWPXTF/c9kYGs7k43MUOCbbbsU+v7SY+TGdhu9yxDuPZ+V0y
   6aHcDlohtYHcR6lZLh55ONWCdU2tedYb9mzaPHPqophxCsYyaPec/5PG3
   ylac2ytLZsC3d4SA826hqsHo3t/mauU+bylOzfaZCacV3xPsoRowzhAIW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="131490901"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="131490901"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:25 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id AE48AD9F00;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id E8892F933;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 75257E2B0A;
	Tue, 19 Mar 2024 15:32:20 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BDA171A006B;
	Tue, 19 Mar 2024 14:32:19 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 01/25] scsi: aacraid: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:08 +0800
Message-Id: <20240319063132.1588443-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28260.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28260.005
X-TMASE-Result: 10--12.901200-10.000000
X-TMASE-MatchedRID: FY3Fgmk8TgkbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u8oJgWvWZKR0GluHEj++VqUhQ6
	YZNvnIb+Ekt/L8HtAJ785xNkZcrN2ePWEUnWb98FBDn6Fjq77jvioIsi7Sa0gwLkNMQzGl5B+Kr
	WCPbERPyqq0O5S3DJ8eQdJcJ6RxJSmg8dBfLCnV2/6CCblACLhJScvOTX4jHN3de2OoBqgwiRM9
	pS/s/NILp20O7VwpBaIqlZh0Y0wYRLcDqfEqfizv0DcGXX8NxWnRzlrI6bygz64b06vmARfGEG9
	aBmVf7zi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq/7nw37K75lFhfMyQcrQKrzYC7kGoI7IiaV737
	3dnt5UgPNaS1D9v78
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() and scnprintf() will be converted as well if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/aacraid/linit.c | 78 ++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 68f4dbcfff49..a9c7e3e0ca33 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -558,11 +558,11 @@ static ssize_t aac_show_raid_level(struct device *dev, struct device_attribute *
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct aac_dev *aac = (struct aac_dev *)(sdev->host->hostdata);
 	if (sdev_channel(sdev) != CONTAINER_CHANNEL)
-		return snprintf(buf, PAGE_SIZE, sdev->no_uld_attach
-		  ? "Hidden\n" :
+		return sysfs_emit(buf, sdev->no_uld_attach ? "Hidden\n" :
 		  ((aac->jbod && (sdev->type == TYPE_DISK)) ? "JBOD\n" : ""));
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-	  get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
+
+	return sysfs_emit(buf, "%s\n",
+			  get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
 }
 
 static struct device_attribute aac_raid_level_attr = {
@@ -585,12 +585,12 @@ static ssize_t aac_show_unique_id(struct device *dev,
 	if (sdev_channel(sdev) == CONTAINER_CHANNEL)
 		memcpy(sn, aac->fsa_dev[sdev_id(sdev)].identifier, sizeof(sn));
 
-	return snprintf(buf, 16 * 2 + 2,
-		"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
-		sn[0], sn[1], sn[2], sn[3],
-		sn[4], sn[5], sn[6], sn[7],
-		sn[8], sn[9], sn[10], sn[11],
-		sn[12], sn[13], sn[14], sn[15]);
+	return sysfs_emit(buf,
+			  "%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
+			  sn[0], sn[1], sn[2], sn[3],
+			  sn[4], sn[5], sn[6], sn[7],
+			  sn[8], sn[9], sn[10], sn[11],
+			  sn[12], sn[13], sn[14], sn[15]);
 }
 
 static struct device_attribute aac_unique_id_attr = {
@@ -1195,10 +1195,9 @@ static ssize_t aac_show_model(struct device *device,
 			++cp;
 		while (*cp == ' ')
 			++cp;
-		len = snprintf(buf, PAGE_SIZE, "%s\n", cp);
+		len = sysfs_emit(buf, "%s\n", cp);
 	} else
-		len = snprintf(buf, PAGE_SIZE, "%s\n",
-		  aac_drivers[dev->cardtype].model);
+		len = sysfs_emit(buf, "%s\n", aac_drivers[dev->cardtype].model);
 	return len;
 }
 
@@ -1214,12 +1213,11 @@ static ssize_t aac_show_vendor(struct device *device,
 		char *cp = sup_adap_info->adapter_type_text;
 		while (*cp && *cp != ' ')
 			++cp;
-		len = snprintf(buf, PAGE_SIZE, "%.*s\n",
-			(int)(cp - (char *)sup_adap_info->adapter_type_text),
-					sup_adap_info->adapter_type_text);
+		len = sysfs_emit(buf, "%.*s\n",
+			 (int)(cp - (char *)sup_adap_info->adapter_type_text),
+			 sup_adap_info->adapter_type_text);
 	} else
-		len = snprintf(buf, PAGE_SIZE, "%s\n",
-			aac_drivers[dev->cardtype].vname);
+		len = sysfs_emit(buf, "%s\n", aac_drivers[dev->cardtype].vname);
 	return len;
 }
 
@@ -1230,23 +1228,19 @@ static ssize_t aac_show_flags(struct device *cdev,
 	struct aac_dev *dev = (struct aac_dev*)class_to_shost(cdev)->hostdata;
 
 	if (nblank(dprintk(x)))
-		len = snprintf(buf, PAGE_SIZE, "dprintk\n");
+		len = sysfs_emit(buf, "dprintk\n");
 #ifdef AAC_DETAILED_STATUS_INFO
-	len += scnprintf(buf + len, PAGE_SIZE - len,
-			 "AAC_DETAILED_STATUS_INFO\n");
+	len += sysfs_emit_at(buf, len, "AAC_DETAILED_STATUS_INFO\n");
 #endif
 	if (dev->raw_io_interface && dev->raw_io_64)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "SAI_READ_CAPACITY_16\n");
+		len += sysfs_emit_at(buf, len, "SAI_READ_CAPACITY_16\n");
 	if (dev->jbod)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "SUPPORTED_JBOD\n");
+		len += sysfs_emit_at(buf, len, "SUPPORTED_JBOD\n");
 	if (dev->supplement_adapter_info.supported_options2 &
 		AAC_OPTION_POWER_MANAGEMENT)
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-				 "SUPPORTED_POWER_MANAGEMENT\n");
+		len += sysfs_emit_at(buf, len, "SUPPORTED_POWER_MANAGEMENT\n");
 	if (dev->msi)
-		len += scnprintf(buf + len, PAGE_SIZE - len, "PCI_HAS_MSI\n");
+		len += sysfs_emit_at(buf, len, "PCI_HAS_MSI\n");
 	return len;
 }
 
@@ -1258,9 +1252,9 @@ static ssize_t aac_show_kernel_version(struct device *device,
 	int len, tmp;
 
 	tmp = le32_to_cpu(dev->adapter_info.kernelrev);
-	len = snprintf(buf, PAGE_SIZE, "%d.%d-%d[%d]\n",
-	  tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
-	  le32_to_cpu(dev->adapter_info.kernelbuild));
+	len = sysfs_emit(buf, "%d.%d-%d[%d]\n",
+			 tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
+			 le32_to_cpu(dev->adapter_info.kernelbuild));
 	return len;
 }
 
@@ -1272,9 +1266,9 @@ static ssize_t aac_show_monitor_version(struct device *device,
 	int len, tmp;
 
 	tmp = le32_to_cpu(dev->adapter_info.monitorrev);
-	len = snprintf(buf, PAGE_SIZE, "%d.%d-%d[%d]\n",
-	  tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
-	  le32_to_cpu(dev->adapter_info.monitorbuild));
+	len = sysfs_emit(buf, "%d.%d-%d[%d]\n",
+			 tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
+			 le32_to_cpu(dev->adapter_info.monitorbuild));
 	return len;
 }
 
@@ -1286,9 +1280,9 @@ static ssize_t aac_show_bios_version(struct device *device,
 	int len, tmp;
 
 	tmp = le32_to_cpu(dev->adapter_info.biosrev);
-	len = snprintf(buf, PAGE_SIZE, "%d.%d-%d[%d]\n",
-	  tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
-	  le32_to_cpu(dev->adapter_info.biosbuild));
+	len = sysfs_emit(buf, "%d.%d-%d[%d]\n",
+			 tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
+			 le32_to_cpu(dev->adapter_info.biosbuild));
 	return len;
 }
 
@@ -1296,7 +1290,7 @@ static ssize_t aac_show_driver_version(struct device *device,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", aac_driver_version);
+	return sysfs_emit(buf, "%s\n", aac_driver_version);
 }
 
 static ssize_t aac_show_serial_number(struct device *device,
@@ -1322,15 +1316,13 @@ static ssize_t aac_show_serial_number(struct device *device,
 static ssize_t aac_show_max_channel(struct device *device,
 				    struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	  class_to_shost(device)->max_channel);
+	return sysfs_emit(buf, "%d\n", class_to_shost(device)->max_channel);
 }
 
 static ssize_t aac_show_max_id(struct device *device,
 			       struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-	  class_to_shost(device)->max_id);
+	return sysfs_emit(buf, "%d\n", class_to_shost(device)->max_id);
 }
 
 static ssize_t aac_store_reset_adapter(struct device *device,
@@ -1360,7 +1352,7 @@ static ssize_t aac_show_reset_adapter(struct device *device,
 	tmp = aac_adapter_check_health(dev);
 	if ((tmp == 0) && dev->in_reset)
 		tmp = -EBUSY;
-	len = snprintf(buf, PAGE_SIZE, "0x%x\n", tmp);
+	len = sysfs_emit(buf, "0x%x\n", tmp);
 	return len;
 }
 
-- 
2.29.2


