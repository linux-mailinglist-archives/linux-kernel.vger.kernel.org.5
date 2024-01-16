Return-Path: <linux-kernel+bounces-26988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C27682E8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 06:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C324D1C224AA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC5F1CFA8;
	Tue, 16 Jan 2024 04:52:40 +0000 (UTC)
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB31C695;
	Tue, 16 Jan 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="134244468"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="134244468"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:30 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id EAB19D5027;
	Tue, 16 Jan 2024 13:52:27 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 35BDAD3F0C;
	Tue, 16 Jan 2024 13:52:27 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id B84E0200A7685;
	Tue, 16 Jan 2024 13:52:26 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 41B171A0070;
	Tue, 16 Jan 2024 12:52:26 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [PATCH 40/42] drivers/scsi/snic/snic_attrs: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:49 +0800
Message-Id: <20240116045151.3940401-38-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--15.843000-10.000000
X-TMASE-MatchedRID: i5zBIT546Mc4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4QjYlErXRAnoLdBFrfY9r2n0swHSFcVJ6MC5DTEMxpeQfiq
	1gj2xET8vYRhsicUjm84WYLmQfXYmFZzhICPDv1zfSQNpZkETVAv/9UzFeXITGxDxAG8HwlajxY
	yRBa/qJcFwgTvxipFajoczmuoPCq3jsutR+QmP0N8aX0oz9KYehB2W+CYlDhFtqNG73mqQ0w521
	VKzZ7kU
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/snic/snic_attrs.c:16:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/snic/snic_attrs.c:26:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/snic/snic_attrs.c:35:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/snic/snic_attrs.c:48:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Karan Tilak Kumar <kartilak@cisco.com>
CC: Sesidhar Baddela <sebaddel@cisco.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/snic/snic_attrs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/snic/snic_attrs.c b/drivers/scsi/snic/snic_attrs.c
index 3ddbdbc3ded1..03921618182d 100644
--- a/drivers/scsi/snic/snic_attrs.c
+++ b/drivers/scsi/snic/snic_attrs.c
@@ -13,7 +13,7 @@ snic_show_sym_name(struct device *dev,
 {
 	struct snic *snic = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", snic->name);
+	return sysfs_emit(buf, "%s\n", snic->name);
 }
 
 static ssize_t
@@ -23,7 +23,7 @@ snic_show_state(struct device *dev,
 {
 	struct snic *snic = shost_priv(class_to_shost(dev));
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 			snic_state_str[snic_get_state(snic)]);
 }
 
@@ -32,7 +32,7 @@ snic_show_drv_version(struct device *dev,
 		      struct device_attribute *attr,
 		      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", SNIC_DRV_VERSION);
+	return sysfs_emit(buf, "%s\n", SNIC_DRV_VERSION);
 }
 
 static ssize_t
@@ -45,8 +45,8 @@ snic_show_link_state(struct device *dev,
 	if (snic->config.xpt_type == SNIC_DAS)
 		snic->link_status = svnic_dev_link_status(snic->vdev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			(snic->link_status) ? "Link Up" : "Link Down");
+	return sysfs_emit(buf, "%s\n",
+			  (snic->link_status) ? "Link Up" : "Link Down");
 }
 
 static DEVICE_ATTR(snic_sym_name, S_IRUGO, snic_show_sym_name, NULL);
-- 
2.29.2


