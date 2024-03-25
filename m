Return-Path: <linux-kernel+bounces-117123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5B988A791
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511781C60C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ACA13F004;
	Mon, 25 Mar 2024 13:18:00 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE3517164C;
	Mon, 25 Mar 2024 13:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372680; cv=none; b=KGjrZFZBC31BDRcHKNzxVd3vkA+NGyDwRQrRCvjX6iDUeGfZ2oQfrotACSgFDgDLDSen60n/iEOnVdk8lUl1EmtdWBFl+IILyFacPjhgMTLAHgyVaiG/9QaAJin0m/ltiB4xt/vJjSIeAQGpiVA7Bcr99VF4+gF3ibS2qIJ47og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372680; c=relaxed/simple;
	bh=YKTmuKf8u74lvEbPO5g1Z9vFdswBOamJg74EextIaFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aWYVOFv1+RFZHJpX9BGTXlkzqrWfteOBfl1uJHNHRoOczw07FsTcmnyMStC57zkJwoXCLH2UP+IwH57a34U5uBObYnaFH9O6jKC668HBUR7ZbWhgu2dVSORqUFSGufLefrsQwEhe3kkr0oBrcvbQGuehrXW16jFGHl4SOJwE2Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V3D1t6KfMz2BhdD;
	Mon, 25 Mar 2024 21:15:14 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE471A016C;
	Mon, 25 Mar 2024 21:17:52 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 21:17:51 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <yanaijie@huawei.com>, <dlemoal@kernel.org>,
	<chenxiang66@hisilicon.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@huawei.com>, <liyihang9@huawei.com>,
	<yangxingui@huawei.com>
Subject: [PATCH] scsi: libsas: Add SMP request allocation handler callback
Date: Mon, 25 Mar 2024 21:17:51 +0800
Message-ID: <20240325131751.1840329-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)

This series [1] reducing the kmalloc() minimum alignment on arm64 to 8
(from 128).

The hisi_sas has special requirements on the memory address alignment
(must be 16-byte-aligned) of the command request frame, so add a SMP
request allocation callback and fill it in for the hisi_sas driver.

Link: https://lkml.kernel.org/r/20230612153201.554742-1-catalin.marinas@arm.com [1]
Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c | 14 ++++++++++++
 drivers/scsi/libsas/sas_expander.c    | 31 ++++++++++++++++++---------
 include/scsi/libsas.h                 |  3 +++
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 097dfe4b620d..40329558d435 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2031,6 +2031,19 @@ static int hisi_sas_write_gpio(struct sas_ha_struct *sha, u8 reg_type,
 				reg_index, reg_count, write_data);
 }
 
+static void *hisi_sas_alloc_smp_req(int size)
+{
+	u8 *p;
+
+	/* The address must be 16-byte-aligned. */
+	size = ALIGN(size, ARCH_DMA_MINALIGN);
+	p = kzalloc(size, GFP_KERNEL);
+	if (p)
+		p[0] = SMP_REQUEST;
+
+	return p;
+}
+
 static void hisi_sas_phy_disconnected(struct hisi_sas_phy *phy)
 {
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
@@ -2130,6 +2143,7 @@ static struct sas_domain_function_template hisi_sas_transport_ops = {
 	.lldd_write_gpio	= hisi_sas_write_gpio,
 	.lldd_tmf_aborted	= hisi_sas_tmf_aborted,
 	.lldd_abort_timeout	= hisi_sas_internal_abort_timeout,
+	.lldd_alloc_smp_req	= hisi_sas_alloc_smp_req,
 };
 
 void hisi_sas_init_mem(struct hisi_hba *hisi_hba)
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..0fd0507f7fc6 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -141,6 +141,17 @@ static inline void *alloc_smp_req(int size)
 	return p;
 }
 
+static void *sas_alloc_smp_req(struct domain_device *dev, int size)
+{
+	struct sas_internal *i =
+		to_sas_internal(dev->port->ha->shost->transportt);
+
+	if (i->dft->lldd_alloc_smp_req)
+		return i->dft->lldd_alloc_smp_req(size);
+
+	return alloc_smp_req(size);
+}
+
 static inline void *alloc_smp_resp(int size)
 {
 	return kzalloc(size, GFP_KERNEL);
@@ -377,7 +388,7 @@ int sas_ex_phy_discover(struct domain_device *dev, int single)
 	u8   *disc_req;
 	struct smp_disc_resp *disc_resp;
 
-	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE);
+	disc_req = sas_alloc_smp_req(dev, DISCOVER_REQ_SIZE);
 	if (!disc_req)
 		return -ENOMEM;
 
@@ -440,7 +451,7 @@ static int sas_ex_general(struct domain_device *dev)
 	int res;
 	int i;
 
-	rg_req = alloc_smp_req(RG_REQ_SIZE);
+	rg_req = sas_alloc_smp_req(dev, RG_REQ_SIZE);
 	if (!rg_req)
 		return -ENOMEM;
 
@@ -519,7 +530,7 @@ static int sas_ex_manuf_info(struct domain_device *dev)
 	u8 *mi_resp;
 	int res;
 
-	mi_req = alloc_smp_req(MI_REQ_SIZE);
+	mi_req = sas_alloc_smp_req(dev, MI_REQ_SIZE);
 	if (!mi_req)
 		return -ENOMEM;
 
@@ -560,7 +571,7 @@ int sas_smp_phy_control(struct domain_device *dev, int phy_id,
 	u8 *pc_resp;
 	int res;
 
-	pc_req = alloc_smp_req(PC_REQ_SIZE);
+	pc_req = sas_alloc_smp_req(dev, PC_REQ_SIZE);
 	if (!pc_req)
 		return -ENOMEM;
 
@@ -642,7 +653,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
 	struct sas_rphy *rphy = dev_to_rphy(phy->dev.parent);
 	struct domain_device *dev = sas_find_dev_by_rphy(rphy);
 
-	req = alloc_smp_req(RPEL_REQ_SIZE);
+	req = sas_alloc_smp_req(dev, RPEL_REQ_SIZE);
 	if (!req)
 		return -ENOMEM;
 
@@ -682,7 +693,7 @@ int sas_get_report_phy_sata(struct domain_device *dev, int phy_id,
 			    struct smp_rps_resp *rps_resp)
 {
 	int res;
-	u8 *rps_req = alloc_smp_req(RPS_REQ_SIZE);
+	u8 *rps_req = sas_alloc_smp_req(dev, RPS_REQ_SIZE);
 	u8 *resp = (u8 *)rps_resp;
 
 	if (!rps_req)
@@ -1344,7 +1355,7 @@ static int sas_configure_present(struct domain_device *dev, int phy_id,
 	*present = 0;
 	*index = 0;
 
-	rri_req = alloc_smp_req(RRI_REQ_SIZE);
+	rri_req = sas_alloc_smp_req(dev, RRI_REQ_SIZE);
 	if (!rri_req)
 		return -ENOMEM;
 
@@ -1412,7 +1423,7 @@ static int sas_configure_set(struct domain_device *dev, int phy_id,
 	u8 *cri_req;
 	u8 *cri_resp;
 
-	cri_req = alloc_smp_req(CRI_REQ_SIZE);
+	cri_req = sas_alloc_smp_req(dev, CRI_REQ_SIZE);
 	if (!cri_req)
 		return -ENOMEM;
 
@@ -1627,7 +1638,7 @@ static int sas_get_phy_discover(struct domain_device *dev,
 	int res;
 	u8 *disc_req;
 
-	disc_req = alloc_smp_req(DISCOVER_REQ_SIZE);
+	disc_req = sas_alloc_smp_req(dev, DISCOVER_REQ_SIZE);
 	if (!disc_req)
 		return -ENOMEM;
 
@@ -1723,7 +1734,7 @@ static int sas_get_ex_change_count(struct domain_device *dev, int *ecc)
 	u8  *rg_req;
 	struct smp_rg_resp  *rg_resp;
 
-	rg_req = alloc_smp_req(RG_REQ_SIZE);
+	rg_req = sas_alloc_smp_req(dev, RG_REQ_SIZE);
 	if (!rg_req)
 		return -ENOMEM;
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index f5257103fdb6..2e6e5f6e50db 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -670,6 +670,9 @@ struct sas_domain_function_template {
 	/* GPIO support */
 	int (*lldd_write_gpio)(struct sas_ha_struct *, u8 reg_type,
 			       u8 reg_index, u8 reg_count, u8 *write_data);
+
+	/* Allocation for SMP request */
+	void *(*lldd_alloc_smp_req)(int size);
 };
 
 extern int sas_register_ha(struct sas_ha_struct *);
-- 
2.33.0


