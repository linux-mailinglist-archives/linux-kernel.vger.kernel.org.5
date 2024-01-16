Return-Path: <linux-kernel+bounces-26980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB382E8C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DC1F223FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C51C291;
	Tue, 16 Jan 2024 04:52:36 +0000 (UTC)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BC710A3C;
	Tue, 16 Jan 2024 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146510864"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146510864"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:27 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3E61CD64B1;
	Tue, 16 Jan 2024 13:52:25 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 64578BF4C4;
	Tue, 16 Jan 2024 13:52:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E561D200A56C5;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 743421A0070;
	Tue, 16 Jan 2024 12:52:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Hannes Reinecke <hare@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 31/42] drivers/scsi/myrs: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:40 +0800
Message-Id: <20240116045151.3940401-29-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.004
X-TMASE-Result: 10--8.367900-10.000000
X-TMASE-MatchedRID: 1XqbU0So2KU4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4TBF7stuNMMxLdBFrfY9r2nBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtpqw4mhfH/Cj7xaYlLIzqlbaTkWqXcVprtB9I5g6XEpixgff28UuvIT3EZVcUQp7dZ1gn
	ekL1c23uwlX0g/WxMCp43H9nP9RJd1iVo4TLgcHLqQyAveNtg6Q1Zooh0EhXh7Iyy6sbAxFWRSp
	+vSaR74xb0e/VUxknqAMuqetGVetnyef22ep6XYOwBXM346/+yhd8PXj9ue1lP2heyqFD+YWmTz
	uMGeDTdFU4VE3yU+ZDmaRwPzYxiF
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/myrs.c:1061:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1089:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1193:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1306:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1316:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1391:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1401:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1411:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1421:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:1491:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/myrs.c:942:9-17: WARNING: please use sysfs_emit

No functional change intended

CC: Hannes Reinecke <hare@kernel.org>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/myrs.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index a1eec65a9713..deafe5904055 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -939,7 +939,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");
 
 	if (sdev->channel >= cs->ctlr_info->physchan_present) {
 		struct myrs_ldev_info *ldev_info = sdev->hostdata;
@@ -947,10 +947,10 @@ static ssize_t raid_state_show(struct device *dev,
 
 		name = myrs_devstate_name(ldev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       ldev_info->dev_state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 ldev_info->dev_state);
 	} else {
 		struct myrs_pdev_info *pdev_info;
 		const char *name;
@@ -958,10 +958,10 @@ static ssize_t raid_state_show(struct device *dev,
 		pdev_info = sdev->hostdata;
 		name = myrs_devstate_name(pdev_info->dev_state);
 		if (name)
-			ret = snprintf(buf, 32, "%s\n", name);
+			ret = sysfs_emit(buf, "%s\n", name);
 		else
-			ret = snprintf(buf, 32, "Invalid (%02X)\n",
-				       pdev_info->dev_state);
+			ret = sysfs_emit(buf, "Invalid (%02X)\n",
+					 pdev_info->dev_state);
 	}
 	return ret;
 }
@@ -1058,7 +1058,7 @@ static ssize_t raid_level_show(struct device *dev,
 	const char *name = NULL;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sysfs_emit(buf, "Unknown\n");
 
 	if (sdev->channel >= cs->ctlr_info->physchan_present) {
 		struct myrs_ldev_info *ldev_info;
@@ -1066,13 +1066,13 @@ static ssize_t raid_level_show(struct device *dev,
 		ldev_info = sdev->hostdata;
 		name = myrs_raid_level_name(ldev_info->raid_level);
 		if (!name)
-			return snprintf(buf, 32, "Invalid (%02X)\n",
+			return sysfs_emit(buf, "Invalid (%02X)\n",
 					ldev_info->dev_state);
 
 	} else
 		name = myrs_raid_level_name(MYRS_RAID_PHYSICAL);
 
-	return snprintf(buf, 32, "%s\n", name);
+	return sysfs_emit(buf, "%s\n", name);
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1086,7 +1086,7 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sysfs_emit(buf, "physical device - not rebuilding\n");
 
 	ldev_info = sdev->hostdata;
 	ldev_num = ldev_info->ldev_num;
@@ -1098,11 +1098,11 @@ static ssize_t rebuild_show(struct device *dev,
 		return -EIO;
 	}
 	if (ldev_info->rbld_active) {
-		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
+		return sysfs_emit(buf, "rebuilding block %zu of %zu\n",
 				(size_t)ldev_info->rbld_lba,
 				(size_t)ldev_info->cfg_devsize);
 	} else
-		return snprintf(buf, 32, "not rebuilding\n");
+		return sysfs_emit(buf, "not rebuilding\n");
 }
 
 static ssize_t rebuild_store(struct device *dev,
@@ -1190,7 +1190,7 @@ static ssize_t consistency_check_show(struct device *dev,
 	unsigned short ldev_num;
 
 	if (sdev->channel < cs->ctlr_info->physchan_present)
-		return snprintf(buf, 32, "physical device - not checking\n");
+		return sysfs_emit(buf, "physical device - not checking\n");
 
 	ldev_info = sdev->hostdata;
 	if (!ldev_info)
@@ -1198,11 +1198,11 @@ static ssize_t consistency_check_show(struct device *dev,
 	ldev_num = ldev_info->ldev_num;
 	myrs_get_ldev_info(cs, ldev_num, ldev_info);
 	if (ldev_info->cc_active)
-		return snprintf(buf, 32, "checking block %zu of %zu\n",
-				(size_t)ldev_info->cc_lba,
-				(size_t)ldev_info->cfg_devsize);
+		return sysfs_emit(buf, "checking block %zu of %zu\n",
+				  (size_t)ldev_info->cc_lba,
+				  (size_t)ldev_info->cfg_devsize);
 	else
-		return snprintf(buf, 32, "not checking\n");
+		return sysfs_emit(buf, "not checking\n");
 }
 
 static ssize_t consistency_check_store(struct device *dev,
@@ -1303,7 +1303,7 @@ static ssize_t serial_show(struct device *dev,
 
 	memcpy(serial, cs->ctlr_info->serial_number, 16);
 	serial[16] = '\0';
-	return snprintf(buf, 16, "%s\n", serial);
+	return sysfs_emit(buf, "%s\n", serial);
 }
 static DEVICE_ATTR_RO(serial);
 
@@ -1313,7 +1313,7 @@ static ssize_t ctlr_num_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 20, "%d\n", cs->host->host_no);
+	return sysfs_emit(buf, "%d\n", cs->host->host_no);
 }
 static DEVICE_ATTR_RO(ctlr_num);
 
@@ -1388,7 +1388,7 @@ static ssize_t model_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 28, "%s\n", cs->model_name);
+	return sysfs_emit(buf, "%s\n", cs->model_name);
 }
 static DEVICE_ATTR_RO(model);
 
@@ -1398,7 +1398,7 @@ static ssize_t ctlr_type_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
+	return sysfs_emit(buf, "%d\n", cs->ctlr_info->ctlr_type);
 }
 static DEVICE_ATTR_RO(ctlr_type);
 
@@ -1408,7 +1408,7 @@ static ssize_t cache_size_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+	return sysfs_emit(buf, "%d MB\n", cs->ctlr_info->cache_size_mb);
 }
 static DEVICE_ATTR_RO(cache_size);
 
@@ -1418,10 +1418,10 @@ static ssize_t firmware_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 16, "%d.%02d-%02d\n",
-			cs->ctlr_info->fw_major_version,
-			cs->ctlr_info->fw_minor_version,
-			cs->ctlr_info->fw_turn_number);
+	return sysfs_emit(buf, "%d.%02d-%02d\n",
+			  cs->ctlr_info->fw_major_version,
+			  cs->ctlr_info->fw_minor_version,
+			  cs->ctlr_info->fw_turn_number);
 }
 static DEVICE_ATTR_RO(firmware);
 
@@ -1488,7 +1488,7 @@ static ssize_t disable_enclosure_messages_show(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct myrs_hba *cs = shost_priv(shost);
 
-	return snprintf(buf, 3, "%d\n", cs->disable_enc_msg);
+	return sysfs_emit(buf, "%d\n", cs->disable_enc_msg);
 }
 
 static ssize_t disable_enclosure_messages_store(struct device *dev,
-- 
2.29.2


