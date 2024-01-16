Return-Path: <linux-kernel+bounces-26982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8282E8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88BAA283872
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC38D1C68D;
	Tue, 16 Jan 2024 04:52:36 +0000 (UTC)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E793134D7;
	Tue, 16 Jan 2024 04:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="125018779"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="125018779"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:26 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6992FD7AC6;
	Tue, 16 Jan 2024 13:52:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 96BF0BF3E1;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 23F11200A571F;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 457121A0160;
	Tue, 16 Jan 2024 12:52:22 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH 28/42] drivers/scsi/megaraid: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:37 +0800
Message-Id: <20240116045151.3940401-26-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--13.640000-10.000000
X-TMASE-MatchedRID: /HyfiRbsgEU4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckMWl
	hj9iHeVpPG/R1GUal1VM0AWQBBcXdpRSkbxKeJc4LdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET/NAIHvYUto2qKy6bttPkB+0FQxfjRHOzgRW4LR41Fi8iUnLzk1+Ixzd3XtjqAaoMJUfP
	E7He1RweLzNWBegCW2wgn7iDBesS0gBwKKRHe+r2rtiS8aKA00N8teWEVLok9FpoERaMiOMdhR2
	K6sbuJw60xzOfqTO38=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/megaraid/megaraid_sas_base.c:3336:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/megaraid/megaraid_sas_base.c:3382:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/megaraid/megaraid_sas_base.c:3389:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/megaraid/megaraid_sas_base.c:3399:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/megaraid/megaraid_sas_base.c:3409:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/megaraid/megaraid_sas_base.c:3419:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/megaraid/megaraid_sas_base.c:3473:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Kashyap Desai <kashyap.desai@broadcom.com>
CC: Sumit Saxena <sumit.saxena@broadcom.com>
CC: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC: Chandrakanth patil <chandrakanth.patil@broadcom.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: megaraidlinux.pdl@broadcom.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3d4f13da1ae8..4e4414df1935 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3333,7 +3333,7 @@ fw_crash_buffer_size_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)
+	return sysfs_emit(buf, "%ld\n", (unsigned long)
 		((instance->fw_crash_buffer_size) * 1024 * 1024)/PAGE_SIZE);
 }
 
@@ -3379,14 +3379,14 @@ fw_crash_state_show(struct device *cdev,
 	struct megasas_instance *instance =
 		(struct megasas_instance *) shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->fw_crash_state);
+	return sysfs_emit(buf, "%d\n", instance->fw_crash_state);
 }
 
 static ssize_t
 page_size_show(struct device *cdev,
 	struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", (unsigned long)PAGE_SIZE - 1);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)PAGE_SIZE - 1);
 }
 
 static ssize_t
@@ -3396,7 +3396,7 @@ ldio_outstanding_show(struct device *cdev, struct device_attribute *attr,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->ldio_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->ldio_outstanding));
 }
 
 static ssize_t
@@ -3406,7 +3406,7 @@ fw_cmds_outstanding_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&instance->fw_outstanding));
+	return sysfs_emit(buf, "%d\n", atomic_read(&instance->fw_outstanding));
 }
 
 static ssize_t
@@ -3416,7 +3416,7 @@ enable_sdev_max_qd_show(struct device *cdev,
 	struct Scsi_Host *shost = class_to_shost(cdev);
 	struct megasas_instance *instance = (struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", instance->enable_sdev_max_qd);
+	return sysfs_emit(buf, "%d\n", instance->enable_sdev_max_qd);
 }
 
 static ssize_t
@@ -3470,8 +3470,7 @@ raid_map_id_show(struct device *cdev, struct device_attribute *attr,
 	struct megasas_instance *instance =
 			(struct megasas_instance *)shost->hostdata;
 
-	return snprintf(buf, PAGE_SIZE, "%ld\n",
-			(unsigned long)instance->map_id);
+	return sysfs_emit(buf, "%ld\n", (unsigned long)instance->map_id);
 }
 
 static DEVICE_ATTR_RW(fw_crash_buffer);
-- 
2.29.2


