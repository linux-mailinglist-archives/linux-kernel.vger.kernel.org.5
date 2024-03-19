Return-Path: <linux-kernel+bounces-107090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DFE87F774
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819E81F23FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0959A7CF32;
	Tue, 19 Mar 2024 06:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Wyze/PQ7"
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DF50279;
	Tue, 19 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829954; cv=none; b=RW2zY87YnnBpjBlll2wwx4fwALLAbOvGois4SwrgAc4P/eYmN3JCVSRnEAX01Yb9UTaqxDBUXarD98Ei4RfrbI9+xIlJIQQmH+sReXnKamGn0sd2kWoDzt6jS++/rjFcXTUs7YSp2zZiTxHetrawYVc5qPYejf9KlJkQbxuSZek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829954; c=relaxed/simple;
	bh=xhFm5S9bv8PdsQiVkORsEXJrFQSOjWeefwiAd+XLuJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scPfZbdX1mHvzt053zd56z+kJf6pmGZPpyAs2qexp9gMBEXdFpbgCYEO8knoBeDOmiz6rfceUGVEyNxwrEAkUgmUCC4Fp4bK9Izu5eTwv2+5kbe2bIIVE/gKjkxbVdCNaY/e6jb1mFLynjztr8CKmQoUCem2Ys9tbZETJwryZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Wyze/PQ7; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829951; x=1742365951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xhFm5S9bv8PdsQiVkORsEXJrFQSOjWeefwiAd+XLuJk=;
  b=Wyze/PQ713Cjj3IKztgqxY3TAWspGnNZZwyiEfzZ5zmmTJiMipHa9JFQ
   Y9bhVquOwvhPcnrbwnOuahhlHda221yrPknE2T+VQr0D4dHSIRxpHfxyJ
   MRlENqv8iVFZVkcsgqGbj88brYJMl1pvTDDsmhlOktVJ2JZR2YXWqnAwV
   uxnCT3o9EvyCBl7YneKfNwjwOCbsHAkwYnISrBgmY/Uv4CAU6JH0UAUuy
   iHIirbzqrce1qeFjUilX8u7NBomyfkiPUpUzY8dihQyvFmfFw15R4QUu3
   6TBjoDWy0DNA5bB4TxQIwkMHZClfOFNWg3n++uLXh7LT5J3QAtB5fu+Ps
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="140310356"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="140310356"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:26 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B5A62A0E05;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6252FF933;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E3EF520097CC5;
	Tue, 19 Mar 2024 15:32:22 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 5941E1A006D;
	Tue, 19 Mar 2024 14:32:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com
Subject: [PATCH v2 08/25] scsi: mpt3sas: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:15 +0800
Message-Id: <20240319063132.1588443-8-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240319063132.1588443-1-lizhijian@fujitsu.com>
References: <20240319063132.1588443-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--16.997600-10.000000
X-TMASE-MatchedRID: QKiaQG5nP+EbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSD3F
	7iC1Qm2m0i/QDeFI5bplCaRSPAyU1p7HSuASUA2oDCiwMF64/BFmTypof4a70qqPvLKmtzi3eAH
	GnweZvi7XjA6blEVJXGa+8lifC91ft1xYHpY/PCRcGHEV0WBxCYasbATu5ay2fIvzHS0qU7WQhP
	PzYpzgDAAzSPOLl0BJ2oLZ8u2T3EHxPMjOKY7A8LbigRnpKlKT4yqD4LKu3A
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

CC: Sathya Prakash <sathya.prakash@broadcom.com>
CC: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
CC: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: MPT-FusionLinux.pdl@broadcom.com
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 85 +++++++++++++++---------------
 1 file changed, 43 insertions(+), 42 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index 1c9fd26195b8..4ac3b13f7025 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2876,11 +2876,11 @@ version_fw_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
-	    (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
-	    (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
-	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
-	    ioc->facts.FWVersion.Word & 0x000000FF);
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
+			  (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
+			  (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
+			  (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
+			  ioc->facts.FWVersion.Word & 0x000000FF);
 }
 static DEVICE_ATTR_RO(version_fw);
 
@@ -2901,11 +2901,11 @@ version_bios_show(struct device *cdev, struct device_attribute *attr,
 
 	u32 version = le32_to_cpu(ioc->bios_pg3.BiosVersion);
 
-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
-	    (version & 0xFF000000) >> 24,
-	    (version & 0x00FF0000) >> 16,
-	    (version & 0x0000FF00) >> 8,
-	    version & 0x000000FF);
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
+			  (version & 0xFF000000) >> 24,
+			  (version & 0x00FF0000) >> 16,
+			  (version & 0x0000FF00) >> 8,
+			  version & 0x000000FF);
 }
 static DEVICE_ATTR_RO(version_bios);
 
@@ -2924,8 +2924,9 @@ version_mpi_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%03x.%02x\n",
-	    ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
+	return sysfs_emit(buf, "%03x.%02x\n",
+			  ioc->facts.MsgVersion,
+			  ioc->facts.HeaderVersion >> 8);
 }
 static DEVICE_ATTR_RO(version_mpi);
 
@@ -2944,7 +2945,7 @@ version_product_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.ChipName);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.ChipName);
 }
 static DEVICE_ATTR_RO(version_product);
 
@@ -2963,8 +2964,8 @@ version_nvdata_persistent_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
-	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
+	return sysfs_emit(buf, "%08xh\n",
+		le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_persistent);
 
@@ -2983,8 +2984,8 @@ version_nvdata_default_show(struct device *cdev, struct device_attribute
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
-	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
+	return sysfs_emit(buf, "%08xh\n",
+		le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_default);
 
@@ -3003,7 +3004,7 @@ board_name_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardName);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardName);
 }
 static DEVICE_ATTR_RO(board_name);
 
@@ -3022,7 +3023,7 @@ board_assembly_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardAssembly);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardAssembly);
 }
 static DEVICE_ATTR_RO(board_assembly);
 
@@ -3041,7 +3042,7 @@ board_tracer_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardTracerNumber);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardTracerNumber);
 }
 static DEVICE_ATTR_RO(board_tracer);
 
@@ -3063,7 +3064,7 @@ io_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR_RO(io_delay);
 
@@ -3085,7 +3086,7 @@ device_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR_RO(device_delay);
 
@@ -3106,7 +3107,7 @@ fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->facts.RequestCredit);
+	return sysfs_emit(buf, "%02d\n", ioc->facts.RequestCredit);
 }
 static DEVICE_ATTR_RO(fw_queue_depth);
 
@@ -3128,8 +3129,8 @@ host_sas_address_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
-	    (unsigned long long)ioc->sas_hba.sas_address);
+	return sysfs_emit(buf, "0x%016llx\n",
+			  (unsigned long long)ioc->sas_hba.sas_address);
 }
 static DEVICE_ATTR_RO(host_sas_address);
 
@@ -3148,7 +3149,7 @@ logging_level_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->logging_level);
 }
 static ssize_t
 logging_level_store(struct device *cdev, struct device_attribute *attr,
@@ -3184,7 +3185,7 @@ fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
+	return sysfs_emit(buf, "%d\n", ioc->fwfault_debug);
 }
 static ssize_t
 fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
@@ -3221,7 +3222,7 @@ ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
+	return sysfs_emit(buf, "%d\n", ioc->ioc_reset_count);
 }
 static DEVICE_ATTR_RO(ioc_reset_count);
 
@@ -3249,7 +3250,7 @@ reply_queue_count_show(struct device *cdev,
 	else
 		reply_queue_count = 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
+	return sysfs_emit(buf, "%d\n", reply_queue_count);
 }
 static DEVICE_ATTR_RO(reply_queue_count);
 
@@ -3314,7 +3315,7 @@ BRM_status_show(struct device *cdev, struct device_attribute *attr,
 
 	/* BRM status is in bit zero of GPIOVal[24] */
 	backup_rail_monitor_status = le16_to_cpu(io_unit_pg3.GPIOVal[24]);
-	rc = snprintf(buf, PAGE_SIZE, "%d\n", (backup_rail_monitor_status & 1));
+	rc = sysfs_emit(buf, "%d\n", (backup_rail_monitor_status & 1));
 
  out:
 	mutex_unlock(&ioc->pci_access_mutex);
@@ -3371,7 +3372,7 @@ host_trace_buffer_size_show(struct device *cdev,
 		size = le32_to_cpu(request_data->Size);
 
 	ioc->ring_buffer_sz = size;
-	return snprintf(buf, PAGE_SIZE, "%d\n", size);
+	return sysfs_emit(buf, "%d\n", size);
 }
 static DEVICE_ATTR_RO(host_trace_buffer_size);
 
@@ -3458,12 +3459,12 @@ host_trace_buffer_enable_show(struct device *cdev,
 	if ((!ioc->diag_buffer[MPI2_DIAG_BUF_TYPE_TRACE]) ||
 	   ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_REGISTERED) == 0))
-		return snprintf(buf, PAGE_SIZE, "off\n");
+		return sysfs_emit(buf, "off\n");
 	else if ((ioc->diag_buffer_status[MPI2_DIAG_BUF_TYPE_TRACE] &
 	    MPT3_DIAG_BUFFER_IS_RELEASED))
-		return snprintf(buf, PAGE_SIZE, "release\n");
+		return sysfs_emit(buf, "release\n");
 	else
-		return snprintf(buf, PAGE_SIZE, "post\n");
+		return sysfs_emit(buf, "post\n");
 }
 
 static ssize_t
@@ -3879,7 +3880,7 @@ drv_support_bitmap_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", ioc->drv_support_bitmap);
+	return sysfs_emit(buf, "0x%08x\n", ioc->drv_support_bitmap);
 }
 static DEVICE_ATTR_RO(drv_support_bitmap);
 
@@ -3899,7 +3900,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", ioc->enable_sdev_max_qd);
 }
 
 /**
@@ -4047,8 +4048,8 @@ sas_address_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
-	    (unsigned long long)sas_device_priv_data->sas_target->sas_address);
+	return sysfs_emit(buf, "0x%016llx\n", (unsigned long long)
+			  sas_device_priv_data->sas_target->sas_address);
 }
 static DEVICE_ATTR_RO(sas_address);
 
@@ -4069,8 +4070,8 @@ sas_device_handle_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
-	    sas_device_priv_data->sas_target->handle);
+	return sysfs_emit(buf, "0x%04x\n",
+			  sas_device_priv_data->sas_target->handle);
 }
 static DEVICE_ATTR_RO(sas_device_handle);
 
@@ -4107,8 +4108,8 @@ sas_ncq_prio_enable_show(struct device *dev,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			sas_device_priv_data->ncq_prio_enable);
+	return sysfs_emit(buf, "%d\n",
+			  sas_device_priv_data->ncq_prio_enable);
 }
 
 static ssize_t
-- 
2.29.2


