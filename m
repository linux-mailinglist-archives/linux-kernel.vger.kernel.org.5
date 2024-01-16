Return-Path: <linux-kernel+bounces-26979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B0982E8C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A94B235B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62681BF29;
	Tue, 16 Jan 2024 04:52:34 +0000 (UTC)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DC1B7FC;
	Tue, 16 Jan 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146510869"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146510869"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:28 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D0DE87FB66;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 081F7BF3E1;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7F33B200A56FC;
	Tue, 16 Jan 2024 13:52:25 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 0530C1A015F;
	Tue, 16 Jan 2024 12:52:24 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 36/42] drivers/scsi/qla4xxx/ql4_attr: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:45 +0800
Message-Id: <20240116045151.3940401-34-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--14.075100-10.000000
X-TMASE-MatchedRID: HXSqh3WYKfsvKBNTYKG+pZiHtCNYjckMjkDrBOJwwnQ8JmmJxjOaQclB
	Lll1g/6SBNyCmIook0dM0AWQBBcXdpRSkbxKeJc4LdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET/gr0WZ6u+ypUc+YfLo55UjzYigC8AbwLKzRPQ8T4oe5VQtFGrTSjaZL4WYASdGqxQWFL
	7w0dNaotqe5K9KUB7DmchPT8ZI4U8S3A6nxKn4s1Z85UImhNtaCoPXqoZQJeYbEPEAbwfCVqPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrUBY6QPiLuukXoB1ZdXOXl3vW/J18GqmbRRvN/nhGtPBz8wi
	CTvoGIg=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/qla4xxx/ql4_attr.c:159:9-17: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:173:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:181:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:190:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:200:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:210:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:223:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:235:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:247:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:256:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:264:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:273:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:281:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:303:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/qla4xxx/ql4_attr.c:312:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Nilesh Javali <njavali@marvell.com>
CC: Manish Rangankar <mrangankar@marvell.com>
CC: GR-QLogic-Storage-Upstream@marvell.com
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/qla4xxx/ql4_attr.c | 48 ++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_attr.c b/drivers/scsi/qla4xxx/ql4_attr.c
index abfa6ef60480..8d2ff36338c0 100644
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
@@ -187,7 +187,7 @@ qla4xxx_optrom_version_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%d.%02d.%02d.%02d\n",
 			ha->fw_info.bootload_major, ha->fw_info.bootload_minor,
 			ha->fw_info.bootload_patch, ha->fw_info.bootload_build);
 }
@@ -197,7 +197,7 @@ qla4xxx_board_id_show(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "0x%08X\n", ha->board_id);
+	return sysfs_emit(buf, "0x%08X\n", ha->board_id);
 }
 
 static ssize_t
@@ -207,8 +207,8 @@ qla4xxx_fw_state_show(struct device *dev, struct device_attribute *attr,
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
 	qla4xxx_get_firmware_state(ha);
-	return snprintf(buf, PAGE_SIZE, "0x%08X%8X\n", ha->firmware_state,
-			ha->addl_fw_state);
+	return sysfs_emit(buf, "0x%08X%8X\n", ha->firmware_state,
+			  ha->addl_fw_state);
 }
 
 static ssize_t
@@ -220,7 +220,7 @@ qla4xxx_phy_port_cnt_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_cnt);
+	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_cnt);
 }
 
 static ssize_t
@@ -232,7 +232,7 @@ qla4xxx_phy_port_num_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->phy_port_num);
+	return sysfs_emit(buf, "0x%04X\n", ha->phy_port_num);
 }
 
 static ssize_t
@@ -244,7 +244,7 @@ qla4xxx_iscsi_func_cnt_show(struct device *dev, struct device_attribute *attr,
 	if (is_qla40XX(ha))
 		return -ENOSYS;
 
-	return snprintf(buf, PAGE_SIZE, "0x%04X\n", ha->iscsi_pci_func_cnt);
+	return sysfs_emit(buf, "0x%04X\n", ha->iscsi_pci_func_cnt);
 }
 
 static ssize_t
@@ -253,7 +253,7 @@ qla4xxx_hba_model_show(struct device *dev, struct device_attribute *attr,
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->model_name);
+	return sysfs_emit(buf, "%s\n", ha->model_name);
 }
 
 static ssize_t
@@ -261,8 +261,8 @@ qla4xxx_fw_timestamp_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s %s\n", ha->fw_info.fw_build_date,
-			ha->fw_info.fw_build_time);
+	return sysfs_emit(buf, "%s %s\n", ha->fw_info.fw_build_date,
+			  ha->fw_info.fw_build_time);
 }
 
 static ssize_t
@@ -270,7 +270,7 @@ qla4xxx_fw_build_user_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.fw_build_user);
+	return sysfs_emit(buf, "%s\n", ha->fw_info.fw_build_user);
 }
 
 static ssize_t
@@ -278,7 +278,7 @@ qla4xxx_fw_ext_timestamp_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
 	struct scsi_qla_host *ha = to_qla_host(class_to_shost(dev));
-	return snprintf(buf, PAGE_SIZE, "%s\n", ha->fw_info.extended_timestamp);
+	return sysfs_emit(buf, "%s\n", ha->fw_info.extended_timestamp);
 }
 
 static ssize_t
@@ -300,7 +300,7 @@ qla4xxx_fw_load_src_show(struct device *dev, struct device_attribute *attr,
 		break;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", load_src);
+	return sysfs_emit(buf, "%s\n", load_src);
 }
 
 static ssize_t
@@ -309,8 +309,8 @@ qla4xxx_fw_uptime_show(struct device *dev, struct device_attribute *attr,
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


