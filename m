Return-Path: <linux-kernel+bounces-57650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263A84DBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F2C1F25028
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB366F50F;
	Thu,  8 Feb 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNxilidQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061A76F50E;
	Thu,  8 Feb 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381929; cv=none; b=PuxU7Pxv8ALkJrMwC54G/g7fmS8kZSFVl/gmehvS2cPweZNg4BHkWC7nRgtuw7/xCWA9pXR9nCeiCVn29ZnycXpWdcwF9uR1B1NLLrOVEWz1Ave+kGxlO+DIkIizH9SQYYmk/Sh1yQ+rYBYSYH7INXwBFGaUuXZEnj6Beg9xMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381929; c=relaxed/simple;
	bh=Z2CP+O5Bv9LbkXXAh5F8xDT7ZCfBYn4Mn2nqmn37ldw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYDKVCT2vptlHlrH7QLbHOwo6FAmqL9d9/BxBKk+35znhSBiNNRl2NIEFDOC2sZDM0LKk72Oeqf47l/bSBBGqqD458/YszqNlXm8lH4jFFv9zMoyRv/G9c3RvwiD2ecf+L8QIx26pd3BwpaMFzyWn6JeTleHjh27OS0H93R4UZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNxilidQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721C2C43394;
	Thu,  8 Feb 2024 08:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707381928;
	bh=Z2CP+O5Bv9LbkXXAh5F8xDT7ZCfBYn4Mn2nqmn37ldw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNxilidQzOvdSPg22Q6azfmgMcS4E2C/rBzHDGxIpkSY0f83QhtuhCxMwfxhldgwD
	 LLbe9tmty92PjuqBCqdNdX07LGA02ZVepLkQPlqK4Pfzcr65X1l/8FBnE2oNX+TwhX
	 /N85C1wBdDetTek4BewQukeCTSDFf17sBn9sZBWRiYR5Z+gRMj5Hj3MrA1TOD42KQ7
	 UUPKr5jWJqoEIbhv7mP45UDHfVqoJYLDp0sXWqYoYuIpBghDBjSgDSC4V3w9skguj7
	 RzgIZMAGtlAcIXi69/qOqKosBgbeQwHSbLBRT2IpItV/g9NnoEItd1iny1Cfk6lgmP
	 jmNIqcBhhhSdg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 04/10] scsi: aacraid: linit: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date: Thu,  8 Feb 2024 08:44:16 +0000
Message-ID: <20240208084512.3803250-5-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240208084512.3803250-1-lee@kernel.org>
References: <20240208084512.3803250-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Signed-off-by: Lee Jones <lee@kernel.org>
---
Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/aacraid/linit.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 68f4dbcfff492..69526e2bd2e78 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -558,11 +558,9 @@ static ssize_t aac_show_raid_level(struct device *dev, struct device_attribute *
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct aac_dev *aac = (struct aac_dev *)(sdev->host->hostdata);
 	if (sdev_channel(sdev) != CONTAINER_CHANNEL)
-		return snprintf(buf, PAGE_SIZE, sdev->no_uld_attach
-		  ? "Hidden\n" :
+		return sysfs_emit(buf, sdev->no_uld_attach ? "Hidden\n" :
 		  ((aac->jbod && (sdev->type == TYPE_DISK)) ? "JBOD\n" : ""));
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-	  get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
+	return sysfs_emit(buf, "%s\n", get_container_type(aac->fsa_dev[sdev_id(sdev)].type));
 }
 
 static struct device_attribute aac_raid_level_attr = {
@@ -1195,10 +1193,9 @@ static ssize_t aac_show_model(struct device *device,
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
 
@@ -1214,12 +1211,11 @@ static ssize_t aac_show_vendor(struct device *device,
 		char *cp = sup_adap_info->adapter_type_text;
 		while (*cp && *cp != ' ')
 			++cp;
-		len = snprintf(buf, PAGE_SIZE, "%.*s\n",
+		len = sysfs_emit(buf, "%.*s\n",
 			(int)(cp - (char *)sup_adap_info->adapter_type_text),
 					sup_adap_info->adapter_type_text);
 	} else
-		len = snprintf(buf, PAGE_SIZE, "%s\n",
-			aac_drivers[dev->cardtype].vname);
+		len = sysfs_emit(buf, "%s\n", aac_drivers[dev->cardtype].vname);
 	return len;
 }
 
@@ -1230,7 +1226,7 @@ static ssize_t aac_show_flags(struct device *cdev,
 	struct aac_dev *dev = (struct aac_dev*)class_to_shost(cdev)->hostdata;
 
 	if (nblank(dprintk(x)))
-		len = snprintf(buf, PAGE_SIZE, "dprintk\n");
+		len = sysfs_emit(buf, "dprintk\n");
 #ifdef AAC_DETAILED_STATUS_INFO
 	len += scnprintf(buf + len, PAGE_SIZE - len,
 			 "AAC_DETAILED_STATUS_INFO\n");
@@ -1258,7 +1254,7 @@ static ssize_t aac_show_kernel_version(struct device *device,
 	int len, tmp;
 
 	tmp = le32_to_cpu(dev->adapter_info.kernelrev);
-	len = snprintf(buf, PAGE_SIZE, "%d.%d-%d[%d]\n",
+	len = sysfs_emit(buf, "%d.%d-%d[%d]\n",
 	  tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
 	  le32_to_cpu(dev->adapter_info.kernelbuild));
 	return len;
@@ -1272,7 +1268,7 @@ static ssize_t aac_show_monitor_version(struct device *device,
 	int len, tmp;
 
 	tmp = le32_to_cpu(dev->adapter_info.monitorrev);
-	len = snprintf(buf, PAGE_SIZE, "%d.%d-%d[%d]\n",
+	len = sysfs_emit(buf, "%d.%d-%d[%d]\n",
 	  tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
 	  le32_to_cpu(dev->adapter_info.monitorbuild));
 	return len;
@@ -1286,7 +1282,7 @@ static ssize_t aac_show_bios_version(struct device *device,
 	int len, tmp;
 
 	tmp = le32_to_cpu(dev->adapter_info.biosrev);
-	len = snprintf(buf, PAGE_SIZE, "%d.%d-%d[%d]\n",
+	len = sysfs_emit(buf, "%d.%d-%d[%d]\n",
 	  tmp >> 24, (tmp >> 16) & 0xff, tmp & 0xff,
 	  le32_to_cpu(dev->adapter_info.biosbuild));
 	return len;
@@ -1296,7 +1292,7 @@ static ssize_t aac_show_driver_version(struct device *device,
 					struct device_attribute *attr,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", aac_driver_version);
+	return sysfs_emit(buf, "%s\n", aac_driver_version);
 }
 
 static ssize_t aac_show_serial_number(struct device *device,
@@ -1322,15 +1318,13 @@ static ssize_t aac_show_serial_number(struct device *device,
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
@@ -1360,7 +1354,7 @@ static ssize_t aac_show_reset_adapter(struct device *device,
 	tmp = aac_adapter_check_health(dev);
 	if ((tmp == 0) && dev->in_reset)
 		tmp = -EBUSY;
-	len = snprintf(buf, PAGE_SIZE, "0x%x\n", tmp);
+	len = sysfs_emit(buf, "0x%x\n", tmp);
 	return len;
 }
 
-- 
2.43.0.594.gd9cf4e227d-goog


