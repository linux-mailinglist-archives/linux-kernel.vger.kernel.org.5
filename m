Return-Path: <linux-kernel+bounces-26974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7B82E8B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7D4B22C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A61B80A;
	Tue, 16 Jan 2024 04:52:32 +0000 (UTC)
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CE10A2D;
	Tue, 16 Jan 2024 04:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146510858"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146510858"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:25 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 58FD8D9D96;
	Tue, 16 Jan 2024 13:52:23 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4E064BF3E1;
	Tue, 16 Jan 2024 13:52:22 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E4343200A7693;
	Tue, 16 Jan 2024 13:52:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 89A2D1A015F;
	Tue, 16 Jan 2024 12:52:21 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Michael Cyr <mikecyr@linux.ibm.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH 26/42] drivers/scsi/ibmvscsi_tgt: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:35 +0800
Message-Id: <20240116045151.3940401-24-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--7.569600-10.000000
X-TMASE-MatchedRID: /HyfiRbsgEU4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4dL4Vi2vvkbTrMZ+BqQt2NrBOVz0Jwcxl6vCrG0TnfVUT85
	+SH/4Avhevs1eD+lKBH0fuNpVKhqA3H7LcTAG9qsAPmNKDWsW0BSN/rCvqoYAd6kz8j616pyjxY
	yRBa/qJShNCXvA0fw+5MIx11wv+CM7AFczfjr/7A6F5KeXydnAF/31Msza5bSY7PnyToWaPMvAH
	ZF2Qi5GQ0Ax55YWhzQ=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3619:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3625:8-16: WARNING: please use sysfs_emit
> ./drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c:3633:8-16: WARNING: please use sysfs_emit

No functional change intended

CC: Michael Cyr <mikecyr@linux.ibm.com>
CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
CC: "Martin K. Petersen" <martin.petersen@oracle.com>
CC: linux-scsi@vger.kernel.org
CC: target-devel@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index 4dc411a58107..071dd3c4dcf8 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3616,13 +3616,13 @@ static void ibmvscsis_remove(struct vio_dev *vdev)
 static ssize_t system_id_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", system_id);
+	return sysfs_emit(buf, "%s\n", system_id);
 }
 
 static ssize_t partition_number_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%x\n", partition_number);
+	return sysfs_emit(buf, "%x\n", partition_number);
 }
 
 static ssize_t unit_address_show(struct device *dev,
@@ -3630,7 +3630,7 @@ static ssize_t unit_address_show(struct device *dev,
 {
 	struct scsi_info *vscsi = container_of(dev, struct scsi_info, dev);
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", vscsi->dma_dev->unit_address);
+	return sysfs_emit(buf, "%x\n", vscsi->dma_dev->unit_address);
 }
 
 static int ibmvscsis_get_system_info(void)
-- 
2.29.2


