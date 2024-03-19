Return-Path: <linux-kernel+bounces-107089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F6887F770
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7DB1C21115
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59787CF03;
	Tue, 19 Mar 2024 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UUQRcH8v"
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2C50A6B;
	Tue, 19 Mar 2024 06:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710829954; cv=none; b=HoGGdzrFVwSR0/MwgnajxFinrsBmwC2ko4bxdqzTxam0CU7D3RUbi6kgCKBddxpz+kTIkK3QkqhUmybaCuvexJ60m+gFinusAgERKSXHQq2M0XH+g+rbj2ITBmICWCouRw2wGHRxI6CT87sZdrVgN6Dj0xOWwRY4e3ksfGcmpHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710829954; c=relaxed/simple;
	bh=0b2qgSBqgSzkHwDXgqHElPgOfM/2DWLifKS11fB9qg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Say6MmiYQsGli29FfVWn7j5jORKNdMYTymbG/7OrGZ14dnUWAU3sLFqeNCf65WnmG0Y9IZMQG1rNb2kH0Vde7GNCmTbuzj1BBITjTsL9qoq1WuvincFz1Gn5rVUbm/Ybw5Cw4jbqxoe2ENZ51BIjsXMIihjmTLcutQHL4+VlJHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UUQRcH8v; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710829952; x=1742365952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0b2qgSBqgSzkHwDXgqHElPgOfM/2DWLifKS11fB9qg0=;
  b=UUQRcH8vUzzAvoXcLgQ/jrYKghLKtRpDZaEamKpko5G04cZExMhouqSj
   Yd4ccoS0xwdyxRJllqm9wRbsF7BPLmGXZXGBI/qwtqYcMIN68j23mM5yS
   505tFmDJl0qXTTt19HgkcMwEtwZPOr39e+0utgdvZ10wlLRJOZYNZ1pFk
   ZD1ku8Bq5RsTt6BhGhUSA3RyI9eASw4hZBcVVoOwwSsrNoZYlBV+Rr6I7
   PI8TsSKyP2OTaGbsJAncJCH2PNdHaNfJHFXh3pcR5V2QdTRgkK1zIVxMv
   WUJ70eqU1Uv7aO09EquujGSqy+afp+raNxuFT+1jIoQq44Aa4GpIhag4k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="154551203"
X-IronPort-AV: E=Sophos;i="6.07,136,1708354800"; 
   d="scan'208";a="154551203"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 15:32:27 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id EF065D4800;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 21987C5205;
	Tue, 19 Mar 2024 15:32:24 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A4E9E228818;
	Tue, 19 Mar 2024 15:32:23 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 12AB91A006E;
	Tue, 19 Mar 2024 14:32:23 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2 10/25] scsi: qla4xxx: Convert sprintf() family to sysfs_emit() family
Date: Tue, 19 Mar 2024 14:31:17 +0800
Message-Id: <20240319063132.1588443-10-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--11.994500-10.000000
X-TMASE-MatchedRID: ujgZRN8RQFMbO59FK9BdmJiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQXVX
	Q3/qdw5yDiqGKKMcNgRhoUIS5GGeEs1HQN/TlJ3ZOIQ9GP2P2u/iwxLjNbuPBWO0yVK/5LmcQiM
	ingSlKoKMx5HzfQifbPE41045MrHXFDCN/1eC4ASdVNZaI2n6/8E5XPQnBzGXq8KsbROd9VSD3F
	7iC1Qm2iWQSYYFGzuMXnkq6nWMKnzGt2xdLsY3ZJd30s5W7go90MQw+++ihy+fvSnHBLeDKqcN7
	Wy+6vTToO4V4RSl8odH9XJtpa3/0+UWmx8yAzoMdo0n+JPFcJp9LQinZ4QefPcjNeVeWlqY+gtH
	j7OwNO31Kzk40dEY9ZGcndTn6RXdaOfWGmAu2+yAU4siFHdrrNyHn7HzWfNa
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

CC: Nilesh Javali <njavali@marvell.com>
CC: Manish Rangankar <mrangankar@marvell.com>
CC: GR-QLogic-Storage-Upstream@marvell.com
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/scsi/qla4xxx/ql4_attr.c | 54 +++++++++++++++++----------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_attr.c b/drivers/scsi/qla4xxx/ql4_attr.c
index abfa6ef60480..f250f13506e7 100644
--- a/drivers/scsi/qla4xxx/ql4_attr.c
+++ b/drivers/scsi/qla4xxx/ql4_attr.c
@@ -156,13 +156,13 @@ qla4xxx_fw_version_show(struct device *dev,
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
 	if (is_qla80XX(ha))
-		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d (%x)\n",
-				ha->fw_info.fw_major, ha->fw_info.fw_minor,
-				ha->fw_info.fw_patch, ha->fw_info.fw_build);
+		return sysfs_emit(buf, "%d.%02d.%02d (%x)\n",
+				  ha->fw_info.fw_major, ha->fw_info.fw_minor,
+				  ha->fw_info.fw_patch, ha->fw_info.fw_build);
 	else
-		return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
-				ha->fw_info.fw_major, ha->fw_info.fw_minor,
-				ha->fw_info.fw_patch, ha->fw_info.fw_build);
+		return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
+				  ha->fw_info.fw_major, ha->fw_info.fw_minor,
+				  ha->fw_info.fw_patch, ha->fw_info.fw_build);
 }
 
 static ssize_t
@@ -170,7 +170,7 @@ qla4xxx_serial_num_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->serial_number);
+	return sysfs_emit(buf, "%s\n", ha->serial_number);
 }
 
 static ssize_t
@@ -178,8 +178,8 @@ qla4xxx_iscsi_version_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%d.%02d\n", ha->fw_info.iscsi_major,
-			ha->fw_info.iscsi_minor);
+	return sysfs_emit(buf, "%d.%02d\n", ha->fw_info.iscsi_major,
+			  ha->fw_info.iscsi_minor);
 }
 
 static ssize_t
@@ -187,9 +187,11 @@ qla4xxx_optrom_version_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
-			ha->fw_info.bootload_major, ha->fw_info.bootload_minor,
-			ha->fw_info.bootload_patch, ha->fw_info.bootload_build);
+	return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
+			  ha->fw_info.bootload_major,
+			  ha->fw_info.bootload_minor,
+			  ha->fw_info.bootload_patch,
+			  ha->fw_info.bootload_build);
 }
 
 static ssize_t
@@ -197,7 +199,7 @@ qla4xxx_board_id_show(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "0x%08X\n", ha->board_id);
+	return sysfs_emit(buf, "0x%08X\n", ha->board_id);
 }
 
 static ssize_t
@@ -207,8 +209,8 @@ qla4xxx_fw_state_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
 	qla4xxx_get_firmware_state(ha);
-	return snprintf(buf, PAGE_SIZE, "0x%08X%8X\n", ha->firmware_state,
-			ha->addl_fw_state);
+	return sysfs_emit(buf, "0x%08X%8X\n", ha->firmware_state,
+			  ha->addl_fw_state);
 }
 
 static ssize_t
@@ -220,7 +222,7 @@ qla4xxx_phy_port_cnt_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_cnt);
+	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_cnt);
 }
 
 static ssize_t
@@ -232,7 +234,7 @@ qla4xxx_phy_port_num_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_num);
+	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_num);
 }
 
 static ssize_t
@@ -244,7 +246,7 @@ qla4xxx_iscsi_func_cnt_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->iscsi_pci_func_cnt);
+	return sysfs_emit(buf, "0x%04X\n", ha->iscsi_pci_func_cnt);
 }
 
 static ssize_t
@@ -253,7 +255,7 @@ qla4xxx_hba_model_show(struct device *dev, struct device_attribute *attr,
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->model_name);
+	return sysfs_emit(buf, "%s\n", ha->model_name);
 }
 
 static ssize_t
@@ -261,8 +263,8 @@ qla4xxx_fw_timestamp_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s %s\n", ha->fw_info.fw_build_date,
-			ha->fw_info.fw_build_time);
+	return sysfs_emit(buf, "%s %s\n", ha->fw_info.fw_build_date,
+			  ha->fw_info.fw_build_time);
 }
 
 static ssize_t
@@ -270,7 +272,7 @@ qla4xxx_fw_build_user_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.fw_build_user);
+	return sysfs_emit(buf, "%s\n", ha->fw_info.fw_build_user);
 }
 
 static ssize_t
@@ -278,7 +280,7 @@ qla4xxx_fw_ext_timestamp_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.extended_timestamp);
+	return sysfs_emit(buf, "%s\n", ha->fw_info.extended_timestamp);
 }
 
 static ssize_t
@@ -300,7 +302,7 @@ qla4xxx_fw_load_src_show(struct device *dev, struct device_attribute *attr,
 		break;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", load_src);
+	return sysfs_emit(buf, "%s\n", load_src);
 }
 
 static ssize_t
@@ -309,8 +311,8 @@ qla4xxx_fw_uptime_show(struct device *dev, struct device_attribute *attr,
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 	qla4xxx_about_firmware(ha);
-	return snprintf(buf, PAGE_SIZE, "%u.%u secs\n", ha->fw_uptime_secs,
-			ha->fw_uptime_msecs);
+	return sysfs_emit(buf, "%u.%u secs\n", ha->fw_uptime_secs,
+			  ha->fw_uptime_msecs);
 }
 
 static DEVICE_ATTR(fw_version, S_IRUGO, qla4xxx_fw_version_show, NULL);
-- 
2.29.2


