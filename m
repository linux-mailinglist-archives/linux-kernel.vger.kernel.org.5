Return-Path: <linux-kernel+bounces-27000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB38382E8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CD6284E22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8132D1E88F;
	Tue, 16 Jan 2024 04:53:37 +0000 (UTC)
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4417125AF;
	Tue, 16 Jan 2024 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="133883812"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="133883812"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:21 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 857C9D6187;
	Tue, 16 Jan 2024 13:52:18 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id B8082C5CCD;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5A693200A56C5;
	Tue, 16 Jan 2024 13:52:17 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id D7F801A015F;
	Tue, 16 Jan 2024 12:52:16 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH 12/42] drivers/message/fusion: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:21 +0800
Message-Id: <20240116045151.3940401-10-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--13.896000-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPk0No1mkr2A1hM0AWQBBcXdpRSkbxKeJc4rMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUg9x
	e4gtUJtptIv0A3hSOW84WYLmQfXYmpoPHQXywp1eXd9LOVu4KPfCrUlDnEXiSuzdiHYg4JjP+tn
	MvnQl+U2tLgqAV+5PDAPNERLsv2l+XBXaJoB9JZxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7tjlq
	sM06ZRaAhkNqYwTSAYqd+5N1jjBA8gQRSDx83t5xYVzI3UCCaY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/message/fusion/mptscsih.c:3100:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3116:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3132:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3145:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3159:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3173:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3186:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3198:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3211:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3224:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3237:8-16: WARNING: please use sysfs_emit
> ./drivers/message/fusion/mptscsih.c:3250:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Sathya Prakash <sathya.prakash@broadcom.com>
CC: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
CC: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
CC: MPT-FusionLinux.pdl@broadcom.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/message/fusion/mptscsih.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 9080a73b4ea6..24063b201699 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -3097,7 +3097,7 @@ mptscsih_version_fw_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02d.%02d.%02d.%02d\n",
+	return sysfs_emit(buf, "%02d.%02d.%02d.%02d\n",
 	    (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
 	    (ioc->facts.FWVersion.Word & 0x00FF0000) >> 16,
 	    (ioc->facts.FWVersion.Word & 0x0000FF00) >> 8,
@@ -3113,7 +3113,7 @@ mptscsih_version_bios_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
+	return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
 	    (ioc->biosVersion & 0xFF000000) >> 24,
 	    (ioc->biosVersion & 0x00FF0000) >> 16,
 	    (ioc->biosVersion & 0x0000FF00) >> 8,
@@ -3129,7 +3129,7 @@ mptscsih_version_mpi_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%03x\n", ioc->facts.MsgVersion);
+	return sysfs_emit(buf, "%03x\n", ioc->facts.MsgVersion);
 }
 static DEVICE_ATTR(version_mpi, S_IRUGO, mptscsih_version_mpi_show, NULL);
 
@@ -3142,7 +3142,7 @@ char *buf)
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->prod_name);
+	return sysfs_emit(buf, "%s\n", ioc->prod_name);
 }
 static DEVICE_ATTR(version_product, S_IRUGO,
     mptscsih_version_product_show, NULL);
@@ -3156,8 +3156,7 @@ mptscsih_version_nvdata_persistent_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02xh\n",
-	    ioc->nvdata_version_persistent);
+	return sysfs_emit(buf, "%02xh\n", ioc->nvdata_version_persistent);
 }
 static DEVICE_ATTR(version_nvdata_persistent, S_IRUGO,
     mptscsih_version_nvdata_persistent_show, NULL);
@@ -3170,7 +3169,7 @@ mptscsih_version_nvdata_default_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02xh\n",ioc->nvdata_version_default);
+	return sysfs_emit(buf, "%02xh\n",ioc->nvdata_version_default);
 }
 static DEVICE_ATTR(version_nvdata_default, S_IRUGO,
     mptscsih_version_nvdata_default_show, NULL);
@@ -3183,7 +3182,7 @@ mptscsih_board_name_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_name);
+	return sysfs_emit(buf, "%s\n", ioc->board_name);
 }
 static DEVICE_ATTR(board_name, S_IRUGO, mptscsih_board_name_show, NULL);
 
@@ -3195,7 +3194,7 @@ mptscsih_board_assembly_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_assembly);
+	return sysfs_emit(buf, "%s\n", ioc->board_assembly);
 }
 static DEVICE_ATTR(board_assembly, S_IRUGO,
     mptscsih_board_assembly_show, NULL);
@@ -3208,7 +3207,7 @@ mptscsih_board_tracer_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_tracer);
+	return sysfs_emit(buf, "%s\n", ioc->board_tracer);
 }
 static DEVICE_ATTR(board_tracer, S_IRUGO,
     mptscsih_board_tracer_show, NULL);
@@ -3221,7 +3220,7 @@ mptscsih_io_delay_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR(io_delay, S_IRUGO,
     mptscsih_io_delay_show, NULL);
@@ -3234,7 +3233,7 @@ mptscsih_device_delay_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR(device_delay, S_IRUGO,
     mptscsih_device_delay_show, NULL);
@@ -3247,7 +3246,7 @@ mptscsih_debug_level_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->debug_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->debug_level);
 }
 static ssize_t
 mptscsih_debug_level_store(struct device *dev, struct device_attribute *attr,
-- 
2.29.2


