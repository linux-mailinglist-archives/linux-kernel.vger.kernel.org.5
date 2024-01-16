Return-Path: <linux-kernel+bounces-26986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05CC82E8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC95D1F23A06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230E1CF99;
	Tue, 16 Jan 2024 04:52:40 +0000 (UTC)
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8B11C288;
	Tue, 16 Jan 2024 04:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="147894816"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="147894816"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:26 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E38ED6186;
	Tue, 16 Jan 2024 13:52:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id B776DD3F08;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 425CA6B4C6;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B31571A0070;
	Tue, 16 Jan 2024 12:52:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH 29/42] drivers/scsi/mpt3sas: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:38 +0800
Message-Id: <20240116045151.3940401-27-lizhijian@fujitsu.com>
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
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--23.447300-10.000000
X-TMASE-MatchedRID: APZBv0eB5fI4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtptIv0A3hSOW65d/qNNaLIkxrdsXS7GN2SXd9LOVu4KPfCrUlDnEXiSca+Jn8RypgsDdt
	9bAWFhkAgrlr7+3X3c1i1obzNdfwPpHzzvfxlA9R1qGr6sYOf/W+HVwTKSJIbB1z1KvCXwaP7yO
	Wod/KQ1yicbDtMS+S90CabJqrYNnB8TzIzimOwPVnRXm1iHN1bEQdG7H66TyOk/y0w7JiZo
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2825:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2850:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2873:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2893:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2912:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2932:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2952:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2971:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:2990:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3012:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3034:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3055:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3077:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3097:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3133:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3170:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3198:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3320:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3407:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3828:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3848:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:3996:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:4018:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/mpt3sas/mpt3sas_ctl.c:4056:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Sathya Prakash <sathya.prakash@broadcom.com>
CC: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
CC: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: MPT-FusionLinux.pdl@broadcom.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/mpt3sas/mpt3sas_ctl.c | 60 +++++++++++++++---------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index efdb8178db32..e7d7408ce773 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -2822,7 +2822,7 @@ version_fw_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
 	    (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
 	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -2847,7 +2847,7 @@ version_bios_show(struct device *cdev, struct device_attribute *attr,
 
 	u32 version = le32_to_cpu(ioc->bios_pg3.BiosVersion);
 
-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (version & 0xFF000000) >> 24,
 	    (version & 0x00FF0000) >> 16,
 	    (version & 0x0000FF00) >> 8,
@@ -2870,8 +2870,8 @@ version_mpi_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%03x.%02x\n",
-	    ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
+	return sysfs_emit(buf, "%03x.%02x\n",
+			  ioc->facts.MsgVersion, ioc->facts.HeaderVersion >> 8);
 }
 static DEVICE_ATTR_RO(version_mpi);
 
@@ -2890,7 +2890,7 @@ version_product_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.ChipName);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.ChipName);
 }
 static DEVICE_ATTR_RO(version_product);
 
@@ -2909,7 +2909,7 @@ version_nvdata_persistent_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
+	return sysfs_emit(buf, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionPersistent.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_persistent);
@@ -2929,7 +2929,7 @@ version_nvdata_default_show(struct device *cdev, struct device_attribute
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n",
+	return sysfs_emit(buf, "%08xh\n",
 	    le32_to_cpu(ioc->iounit_pg0.NvdataVersionDefault.Word));
 }
 static DEVICE_ATTR_RO(version_nvdata_default);
@@ -2949,7 +2949,7 @@ board_name_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardName);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardName);
 }
 static DEVICE_ATTR_RO(board_name);
 
@@ -2968,7 +2968,7 @@ board_assembly_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardAssembly);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardAssembly);
 }
 static DEVICE_ATTR_RO(board_assembly);
 
@@ -2987,7 +2987,7 @@ board_tracer_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, 16, "%s\n", ioc->manu_pg0.BoardTracerNumber);
+	return sysfs_emit(buf, "%s\n", ioc->manu_pg0.BoardTracerNumber);
 }
 static DEVICE_ATTR_RO(board_tracer);
 
@@ -3009,7 +3009,7 @@ io_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR_RO(io_delay);
 
@@ -3031,7 +3031,7 @@ device_delay_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR_RO(device_delay);
 
@@ -3052,7 +3052,7 @@ fw_queue_depth_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->facts.RequestCredit);
+	return sysfs_emit(buf, "%02d\n", ioc->facts.RequestCredit);
 }
 static DEVICE_ATTR_RO(fw_queue_depth);
 
@@ -3074,7 +3074,7 @@ host_sas_address_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 	    (unsigned long long)ioc->sas_hba.sas_address);
 }
 static DEVICE_ATTR_RO(host_sas_address);
@@ -3094,7 +3094,7 @@ logging_level_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->logging_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->logging_level);
 }
 static ssize_t
 logging_level_store(struct device *cdev, struct device_attribute *attr,
@@ -3130,7 +3130,7 @@ fwfault_debug_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->fwfault_debug);
+	return sysfs_emit(buf, "%d\n", ioc->fwfault_debug);
 }
 static ssize_t
 fwfault_debug_store(struct device *cdev, struct device_attribute *attr,
@@ -3167,7 +3167,7 @@ ioc_reset_count_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->ioc_reset_count);
+	return sysfs_emit(buf, "%d\n", ioc->ioc_reset_count);
 }
 static DEVICE_ATTR_RO(ioc_reset_count);
 
@@ -3195,7 +3195,7 @@ reply_queue_count_show(struct device *cdev,
 	else
 		reply_queue_count = 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", reply_queue_count);
+	return sysfs_emit(buf, "%d\n", reply_queue_count);
 }
 static DEVICE_ATTR_RO(reply_queue_count);
 
@@ -3260,7 +3260,7 @@ BRM_status_show(struct device *cdev, struct device_attribute *attr,
 
 	/* BRM status is in bit zero of GPIOVal[24] */
 	backup_rail_monitor_status = le16_to_cpu(io_unit_pg3.GPIOVal[24]);
-	rc = snprintf(buf, PAGE_SIZE, "%d\n", (backup_rail_monitor_status & 1));
+	rc = sysfs_emit(buf, "%d\n", (backup_rail_monitor_status & 1));
 
  out:
 	mutex_unlock(&ioc->pci_access_mutex);
@@ -3317,7 +3317,7 @@ host_trace_buffer_size_show(struct device *cdev,
 		size = le32_to_cpu(request_data->Size);
 
 	ioc->ring_buffer_sz = size;
-	return snprintf(buf, PAGE_SIZE, "%d\n", size);
+	return sysfs_emit(buf, "%d\n", size);
 }
 static DEVICE_ATTR_RO(host_trace_buffer_size);
 
@@ -3404,12 +3404,12 @@ host_trace_buffer_enable_show(struct device *cdev,
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
@@ -3825,7 +3825,7 @@ drv_support_bitmap_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "0x%08x\n", ioc->drv_support_bitmap);
+	return sysfs_emit(buf, "0x%08x\n", ioc->drv_support_bitmap);
 }
 static DEVICE_ATTR_RO(drv_support_bitmap);
 
@@ -3845,7 +3845,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", ioc->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", ioc->enable_sdev_max_qd);
 }
 
 /**
@@ -3993,7 +3993,7 @@ sas_address_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "0x%016llx\n",
+	return sysfs_emit(buf, "0x%016llx\n",
 	    (unsigned long long)sas_device_priv_data->sas_target->sas_address);
 }
 static DEVICE_ATTR_RO(sas_address);
@@ -4015,8 +4015,8 @@ sas_device_handle_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_device *sdev = to_scsi_device(dev);
 	struct MPT3SAS_DEVICE *sas_device_priv_data = sdev->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04x\n",
-	    sas_device_priv_data->sas_target->handle);
+	return sysfs_emit(buf, "0x%04x\n",
+			  sas_device_priv_data->sas_target->handle);
 }
 static DEVICE_ATTR_RO(sas_device_handle);
 
@@ -4053,8 +4053,8 @@ sas_ncq_prio_enable_show(struct device *dev,
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


