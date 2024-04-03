Return-Path: <linux-kernel+bounces-129497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C821896BA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7ADB26C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE9113A271;
	Wed,  3 Apr 2024 10:05:44 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E385513D608;
	Wed,  3 Apr 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138744; cv=none; b=Xlb9h66Dz1LdAtjjDK4p5dUocuX5jm1G3XFLj/7CozFr8TJetv0+WwI03cIxJKnSaCuXnD/TWa74P1xeSc4WfVb9Bj3FDQtZI9F5YweYYfIQYn0sq2ezHz28wFq+wV5QR07gtjCMc7JyjmikMD6Za+1DT1EiUZqvt3xjUIIp2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138744; c=relaxed/simple;
	bh=++KmhkVlJWSJfuF/zNHx0aZJjBMmyIcXJtFKVGxHn2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ne8DBHYv47n7ZBW0jRs33RobZQUt2WMpoVpXqZd77TQxe8Zg9G2Z+E8pNOgLlsQvqUK0h707IvwJZXPgSijSNh+IWYDkdMAVRnqkqJiFPDMhd+0gJxxfGsPrana+UKsFbSMEgu+mEx8wbcJX6hDe2Prc1h7OgpINktt5Aute+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V8gLJ061zz1JB5L;
	Wed,  3 Apr 2024 18:03:20 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BB6C18007D;
	Wed,  3 Apr 2024 18:05:28 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 3 Apr 2024 18:05:28 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 6/9] crypto: hisilicon - Adjust debugfs creation and release order
Date: Wed, 3 Apr 2024 18:00:59 +0800
Message-ID: <20240403100102.2735306-7-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240403100102.2735306-1-huangchenghai2@huawei.com>
References: <20240403100102.2735306-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200003.china.huawei.com (7.185.36.122)

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


