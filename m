Return-Path: <linux-kernel+bounces-134237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7677089AF5E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044B71F21F7D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E91DDEB;
	Sun,  7 Apr 2024 08:04:36 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4879B10A0E;
	Sun,  7 Apr 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477076; cv=none; b=AkanqI2w7dJPrgC8SCySy5iqtZdTkdUCLRo+MmUEnhRVrTicqhAc7FMF4OLiL0OCUN6GkDDs6ZIgOCO/ZKE1PK3aj9KNoSX0WNglXtdkzryC5mcd1aaAf7U/4fzbf2IfXDFZVlT50ZqHhhuh32FYfErwavEDutax/WSy53V6Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477076; c=relaxed/simple;
	bh=VPqPS0Bzta0dJTTeMbgngQfNBAP6XJRXGO4YboGNlP0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AarMIcvhe8Lvz1S3S09vznpekH6mIwl5s7r7021dYx43rDtHDz/oq6SBoiEh2oVPqWcKwri+/42rR9F1+qUDQ3BHU26UiTPrpEnDyCI/DYBhxuPDXcL7CeUJAmKI2iYzvexAPAxrw/eHQsaVpk6lDobXUgsBqMauhxkNRXDYf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VC4S72FXlz1h5tn;
	Sun,  7 Apr 2024 16:01:43 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 460A21A0172;
	Sun,  7 Apr 2024 16:04:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 16:04:31 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH v2 6/9] crypto: hisilicon - Adjust debugfs creation and release order
Date: Sun, 7 Apr 2024 15:59:57 +0800
Message-ID: <20240407080000.673435-7-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240407080000.673435-1-huangchenghai2@huawei.com>
References: <20240407080000.673435-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500025.china.huawei.com (7.221.188.170)

There is a scenario where the file directory is created but the
file memory is not set. In this case, if a user accesses the
file, an error occurs.

So during the creation process of debugfs, memory should be
allocated first before creating the directory. In the release
process, the directory should be deleted first before releasing
the memory to avoid the situation where the memory does not
exist when accessing the directory.

In addition, the directory released by the debugfs is a global
variable. When the debugfs of an accelerator fails to be
initialized, releasing the directory of the global variable
affects the debugfs initialization of other accelerators.
The debugfs root directory released by debugfs init should be a
member of qm, not a global variable.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 21 ++++++++++----------
 drivers/crypto/hisilicon/sec2/sec_main.c  | 23 +++++++++++-----------
 drivers/crypto/hisilicon/zip/zip_main.c   | 24 +++++++++++------------
 3 files changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index d93aa6630a57..25b44416da45 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -1074,41 +1074,40 @@ static int hpre_debugfs_init(struct hisi_qm *qm)
 	struct device *dev = &qm->pdev->dev;
 	int ret;
 
-	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
-						  hpre_debugfs_root);
-
-	qm->debug.sqe_mask_offset = HPRE_SQE_MASK_OFFSET;
-	qm->debug.sqe_mask_len = HPRE_SQE_MASK_LEN;
 	ret = hisi_qm_regs_debugfs_init(qm, hpre_diff_regs, ARRAY_SIZE(hpre_diff_regs));
 	if (ret) {
 		dev_warn(dev, "Failed to init HPRE diff regs!\n");
-		goto debugfs_remove;
+		return ret;
 	}
 
+	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
+							hpre_debugfs_root);
+	qm->debug.sqe_mask_offset = HPRE_SQE_MASK_OFFSET;
+	qm->debug.sqe_mask_len = HPRE_SQE_MASK_LEN;
+
 	hisi_qm_debug_init(qm);
 
 	if (qm->pdev->device == PCI_DEVICE_ID_HUAWEI_HPRE_PF) {
 		ret = hpre_ctrl_debug_init(qm);
 		if (ret)
-			goto failed_to_create;
+			goto debugfs_remove;
 	}
 
 	hpre_dfx_debug_init(qm);
 
 	return 0;
 
-failed_to_create:
-	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
 debugfs_remove:
 	debugfs_remove_recursive(qm->debug.debug_root);
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
 	return ret;
 }
 
 static void hpre_debugfs_exit(struct hisi_qm *qm)
 {
-	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
-
 	debugfs_remove_recursive(qm->debug.debug_root);
+
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hpre_diff_regs));
 }
 
 static int hpre_pre_store_cap_reg(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index f4e10741610f..853b1cb85016 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -901,37 +901,36 @@ static int sec_debugfs_init(struct hisi_qm *qm)
 	struct device *dev = &qm->pdev->dev;
 	int ret;
 
-	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
-						  sec_debugfs_root);
-	qm->debug.sqe_mask_offset = SEC_SQE_MASK_OFFSET;
-	qm->debug.sqe_mask_len = SEC_SQE_MASK_LEN;
-
 	ret = hisi_qm_regs_debugfs_init(qm, sec_diff_regs, ARRAY_SIZE(sec_diff_regs));
 	if (ret) {
 		dev_warn(dev, "Failed to init SEC diff regs!\n");
-		goto debugfs_remove;
+		return ret;
 	}
 
+	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
+							sec_debugfs_root);
+	qm->debug.sqe_mask_offset = SEC_SQE_MASK_OFFSET;
+	qm->debug.sqe_mask_len = SEC_SQE_MASK_LEN;
+
 	hisi_qm_debug_init(qm);
 
 	ret = sec_debug_init(qm);
 	if (ret)
-		goto failed_to_create;
+		goto debugfs_remove;
 
 	return 0;
 
-failed_to_create:
-	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
 debugfs_remove:
-	debugfs_remove_recursive(sec_debugfs_root);
+	debugfs_remove_recursive(qm->debug.debug_root);
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
 	return ret;
 }
 
 static void sec_debugfs_exit(struct hisi_qm *qm)
 {
-	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
-
 	debugfs_remove_recursive(qm->debug.debug_root);
+
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(sec_diff_regs));
 }
 
 static int sec_show_last_regs_init(struct hisi_qm *qm)
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 732b6c308c48..399b681ee423 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -886,36 +886,34 @@ static int hisi_zip_ctrl_debug_init(struct hisi_qm *qm)
 static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
-	struct dentry *dev_d;
 	int ret;
 
-	dev_d = debugfs_create_dir(dev_name(dev), hzip_debugfs_root);
-
-	qm->debug.sqe_mask_offset = HZIP_SQE_MASK_OFFSET;
-	qm->debug.sqe_mask_len = HZIP_SQE_MASK_LEN;
-	qm->debug.debug_root = dev_d;
 	ret = hisi_qm_regs_debugfs_init(qm, hzip_diff_regs, ARRAY_SIZE(hzip_diff_regs));
 	if (ret) {
 		dev_warn(dev, "Failed to init ZIP diff regs!\n");
-		goto debugfs_remove;
+		return ret;
 	}
 
+	qm->debug.sqe_mask_offset = HZIP_SQE_MASK_OFFSET;
+	qm->debug.sqe_mask_len = HZIP_SQE_MASK_LEN;
+	qm->debug.debug_root = debugfs_create_dir(dev_name(dev),
+							hzip_debugfs_root);
+
 	hisi_qm_debug_init(qm);
 
 	if (qm->fun_type == QM_HW_PF) {
 		ret = hisi_zip_ctrl_debug_init(qm);
 		if (ret)
-			goto failed_to_create;
+			goto debugfs_remove;
 	}
 
 	hisi_zip_dfx_debug_init(qm);
 
 	return 0;
 
-failed_to_create:
-	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
 debugfs_remove:
-	debugfs_remove_recursive(hzip_debugfs_root);
+	debugfs_remove_recursive(qm->debug.debug_root);
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
 	return ret;
 }
 
@@ -939,10 +937,10 @@ static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 
 static void hisi_zip_debugfs_exit(struct hisi_qm *qm)
 {
-	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
-
 	debugfs_remove_recursive(qm->debug.debug_root);
 
+	hisi_qm_regs_debugfs_uninit(qm, ARRAY_SIZE(hzip_diff_regs));
+
 	if (qm->fun_type == QM_HW_PF) {
 		hisi_zip_debug_regs_clear(qm);
 		qm->debug.curr_qm_qp_num = 0;
-- 
2.30.0


