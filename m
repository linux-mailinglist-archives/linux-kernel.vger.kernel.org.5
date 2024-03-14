Return-Path: <linux-kernel+bounces-103031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 784D087BA28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11001F22080
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA846CDBF;
	Thu, 14 Mar 2024 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="e9KyJ4Rf"
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8D6BFD2;
	Thu, 14 Mar 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407678; cv=none; b=DxWmV4jJzN5oR0BcZ0kc2P7HwTaLxDncZn92LwuWM171aRy1Oh58BRFipFSo1ZqHTOYHvcmbgu3yfkYv5frDiE/EZZfPJ5wHSiYFUxdTEXBRx35C6RyThfw3cRk/mrLBJ8KxvN4OsJpkP2+gk3zAcm7vGmAHFaq7D4XcESKtu5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407678; c=relaxed/simple;
	bh=PYZ4NePPHsN3d9b+NJwqBkFE1ABY+nJt1UpuoxX2paY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lkRcpKR/ov/VpaH+MCoQIG7uHaz6BYLE+emcrkb1iDGYjOCNUcVapNcr0YMpSeJyY+1kpixwZwL/2L1H9D3tWUdx38DIXX5+FGEPLPvKEE56fRW6hTLuoIzUfI9NjTnLLsJ0IDiiUWsMBmAsP8vQtItQiLxy0r4E3nKgVe/YMIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=e9KyJ4Rf; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710407677; x=1741943677;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PYZ4NePPHsN3d9b+NJwqBkFE1ABY+nJt1UpuoxX2paY=;
  b=e9KyJ4RfaHHWnM4yPIx0RSvDB6jGK+Y8hOi2zaDCO2zFdrJbHiLctQ8/
   tdEMZBWB+SODnv9v2CmODPNaSByG2OCrAy+tMsp4pGEwhrZanagqd1kx0
   CzsifIacQZz68SDJfqzCRAxl80v+H9adIcRW2narBwf/52dqSCGwu96FA
   y0trxcQw3J4eXXVLiWSHYpVHWPwT4gj4nFf/F/18oAd67ipLh53YqjCQB
   8kiqLZoeE5DNSXRVdoGctmpB5ffJppe1jnwzUEMIPYc2MUFbf0C3t0ou/
   v0+9EUTY7DoNUE2eL+R6v+BL86F3ydbUhdStHXpONwMeQnVdGCUh70xKt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="151709642"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="151709642"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:14:33 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 49689DD933;
	Thu, 14 Mar 2024 18:14:30 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 724B925158;
	Thu, 14 Mar 2024 18:14:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 131B06B4C5;
	Thu, 14 Mar 2024 18:14:29 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 806671A006B;
	Thu, 14 Mar 2024 17:14:28 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH v2] scsi: message: fusion: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 17:14:23 +0800
Message-Id: <20240314091423.1323600-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--11.657400-10.000000
X-TMASE-MatchedRID: z2BzWfwZiWs4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSrMZ+BqQt2NpBHuVYxc8DW3hh5KUdlgWiKqF
	q1hn3Eb3d+/nM3Koh0iaTw03n/wYO7HqxUUCs8WpO5y1KmK5bJRSLgSFq3TnjoxCLfriDzziDtx
	8lDD0Wx5fzUkBpc072D+3TgzUiCNlgNUdcYnHhO4DCiwMF64/BtwN0VDeaZaP4V3z98vLukSWV0
	qXgzOhKoUVG/E9QDuidqC2fLtk9xB8TzIzimOwPC24oEZ6SpSkj80Za3RRg8KUmPK/2Ez0/rYyf
	EnVQ5+VATC81Ak4PiZyfz8gNjrHPFjO3sMWMTDI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Sathya Prakash <sathya.prakash@broadcom.com>
CC: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
CC: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
CC: MPT-FusionLinux.pdl@broadcom.com
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/message/fusion/mptscsih.c | 42 +++++++++++++++----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 9080a73b4ea6..df4b2ebd30ec 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -3097,11 +3097,11 @@ mptscsih_version_fw_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
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
 static DEVICE_ATTR(version_fw, S_IRUGO, mptscsih_version_fw_show, NULL);
 
@@ -3113,11 +3113,11 @@ mptscsih_version_bios_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02x.%02x.%02x.%02x\n",
-	    (ioc->biosVersion & 0xFF000000) >> 24,
-	    (ioc->biosVersion & 0x00FF0000) >> 16,
-	    (ioc->biosVersion & 0x0000FF00) >> 8,
-	    ioc->biosVersion & 0x000000FF);
+	return sysfs_emit(buf, "%02x.%02x.%02x.%02x\n",
+			  (ioc->biosVersion & 0xFF000000) >> 24,
+			  (ioc->biosVersion & 0x00FF0000) >> 16,
+			  (ioc->biosVersion & 0x0000FF00) >> 8,
+			  ioc->biosVersion & 0x000000FF);
 }
 static DEVICE_ATTR(version_bios, S_IRUGO, mptscsih_version_bios_show, NULL);
 
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
@@ -3156,8 +3156,8 @@ mptscsih_version_nvdata_persistent_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02xh\n",
-	    ioc->nvdata_version_persistent);
+	return sysfs_emit(buf, "%02xh\n",
+			  ioc->nvdata_version_persistent);
 }
 static DEVICE_ATTR(version_nvdata_persistent, S_IRUGO,
     mptscsih_version_nvdata_persistent_show, NULL);
@@ -3170,7 +3170,7 @@ mptscsih_version_nvdata_default_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02xh\n",ioc->nvdata_version_default);
+	return sysfs_emit(buf, "%02xh\n",ioc->nvdata_version_default);
 }
 static DEVICE_ATTR(version_nvdata_default, S_IRUGO,
     mptscsih_version_nvdata_default_show, NULL);
@@ -3183,7 +3183,7 @@ mptscsih_board_name_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_name);
+	return sysfs_emit(buf, "%s\n", ioc->board_name);
 }
 static DEVICE_ATTR(board_name, S_IRUGO, mptscsih_board_name_show, NULL);
 
@@ -3195,7 +3195,7 @@ mptscsih_board_assembly_show(struct device *dev,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_assembly);
+	return sysfs_emit(buf, "%s\n", ioc->board_assembly);
 }
 static DEVICE_ATTR(board_assembly, S_IRUGO,
     mptscsih_board_assembly_show, NULL);
@@ -3208,7 +3208,7 @@ mptscsih_board_tracer_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ioc->board_tracer);
+	return sysfs_emit(buf, "%s\n", ioc->board_tracer);
 }
 static DEVICE_ATTR(board_tracer, S_IRUGO,
     mptscsih_board_tracer_show, NULL);
@@ -3221,7 +3221,7 @@ mptscsih_io_delay_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->io_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->io_missing_delay);
 }
 static DEVICE_ATTR(io_delay, S_IRUGO,
     mptscsih_io_delay_show, NULL);
@@ -3234,7 +3234,7 @@ mptscsih_device_delay_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%02d\n", ioc->device_missing_delay);
+	return sysfs_emit(buf, "%02d\n", ioc->device_missing_delay);
 }
 static DEVICE_ATTR(device_delay, S_IRUGO,
     mptscsih_device_delay_show, NULL);
@@ -3247,7 +3247,7 @@ mptscsih_debug_level_show(struct device *dev, struct device_attribute *attr,
 	MPT_SCSI_HOST	*hd = shost_priv(host);
 	MPT_ADAPTER *ioc = hd->ioc;
 
-	return snprintf(buf, PAGE_SIZE, "%08xh\n", ioc->debug_level);
+	return sysfs_emit(buf, "%08xh\n", ioc->debug_level);
 }
 static ssize_t
 mptscsih_debug_level_store(struct device *dev, struct device_attribute *attr,
-- 
2.29.2


