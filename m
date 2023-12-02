Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65108801BB0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjLBJVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjLBJUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:20:53 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C303196;
        Sat,  2 Dec 2023 01:20:58 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Sj4776pMPzSgp2;
        Sat,  2 Dec 2023 17:16:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Dec 2023 17:20:55 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <shenyang39@huawei.com>
Subject: [PATCH 1/5] crypto: hisilicon/qm - add a function to set qm algs
Date:   Sat, 2 Dec 2023 17:17:18 +0800
Message-ID: <20231202091722.1974582-2-songzhiqi1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231202091722.1974582-1-songzhiqi1@huawei.com>
References: <20231202091722.1974582-1-songzhiqi1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenkai Lin <linwenkai6@hisilicon.com>

Extract a public function to set qm algs and remove
the similar code for setting qm algs in each module.

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Hao Fang <fanghao11@huawei.com>
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 42 ++-----------------
 drivers/crypto/hisilicon/qm.c             | 36 +++++++++++++++++
 drivers/crypto/hisilicon/sec2/sec_main.c  | 47 ++++------------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 49 ++++-------------------
 include/linux/hisi_acc_qm.h               |  8 +++-
 5 files changed, 62 insertions(+), 120 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 56777099ef69..84c92d85d23d 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -118,8 +118,6 @@
 #define HPRE_DFX_COMMON2_LEN		0xE
 #define HPRE_DFX_CORE_LEN		0x43
 
-#define HPRE_DEV_ALG_MAX_LEN	256
-
 static const char hpre_name[] = "hisi_hpre";
 static struct dentry *hpre_debugfs_root;
 static const struct pci_device_id hpre_dev_ids[] = {
@@ -135,12 +133,7 @@ struct hpre_hw_error {
 	const char *msg;
 };
 
-struct hpre_dev_alg {
-	u32 alg_msk;
-	const char *alg;
-};
-
-static const struct hpre_dev_alg hpre_dev_algs[] = {
+static const struct qm_dev_alg hpre_dev_algs[] = {
 	{
 		.alg_msk = BIT(0),
 		.alg = "rsa\n"
@@ -362,35 +355,6 @@ bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
 	return false;
 }
 
-static int hpre_set_qm_algs(struct hisi_qm *qm)
-{
-	struct device *dev = &qm->pdev->dev;
-	char *algs, *ptr;
-	u32 alg_msk;
-	int i;
-
-	if (!qm->use_sva)
-		return 0;
-
-	algs = devm_kzalloc(dev, HPRE_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
-	if (!algs)
-		return -ENOMEM;
-
-	alg_msk = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_DEV_ALG_BITMAP_CAP, qm->cap_ver);
-
-	for (i = 0; i < ARRAY_SIZE(hpre_dev_algs); i++)
-		if (alg_msk & hpre_dev_algs[i].alg_msk)
-			strcat(algs, hpre_dev_algs[i].alg);
-
-	ptr = strrchr(algs, '\n');
-	if (ptr)
-		*ptr = '\0';
-
-	qm->uacce->algs = algs;
-
-	return 0;
-}
-
 static int hpre_diff_regs_show(struct seq_file *s, void *unused)
 {
 	struct hisi_qm *qm = s->private;
@@ -1141,6 +1105,7 @@ static void hpre_debugfs_exit(struct hisi_qm *qm)
 
 static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
+	u64 alg_msk;
 	int ret;
 
 	if (pdev->revision == QM_HW_V1) {
@@ -1171,7 +1136,8 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	ret = hpre_set_qm_algs(qm);
+	alg_msk = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_DEV_ALG_BITMAP_CAP, qm->cap_ver);
+	ret = hisi_qm_set_algs(qm, alg_msk, hpre_dev_algs, ARRAY_SIZE(hpre_dev_algs));
 	if (ret) {
 		pci_err(pdev, "Failed to set hpre algs!\n");
 		hisi_qm_uninit(qm);
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 7ed079a9c929..4170c24c2ed1 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -234,6 +234,8 @@
 #define QM_QOS_MAX_CIR_U		6
 #define QM_AUTOSUSPEND_DELAY		3000
 
+#define QM_DEV_ALG_MAX_LEN		256
+
 #define QM_MK_CQC_DW3_V1(hop_num, pg_sz, buf_sz, cqe_sz) \
 	(((hop_num) << QM_CQ_HOP_NUM_SHIFT) | \
 	((pg_sz) << QM_CQ_PAGE_SIZE_SHIFT) | \
@@ -749,6 +751,40 @@ static void qm_get_xqc_depth(struct hisi_qm *qm, u16 *low_bits,
 	*high_bits = (depth >> QM_XQ_DEPTH_SHIFT) & QM_XQ_DEPTH_MASK;
 }
 
+int hisi_qm_set_algs(struct hisi_qm *qm, u64 alg_msk, const struct qm_dev_alg *dev_algs,
+		     u32 dev_algs_size)
+{
+	struct device *dev = &qm->pdev->dev;
+	char *algs, *ptr;
+	int i;
+
+	if (!qm->uacce)
+		return 0;
+
+	if (dev_algs_size >= QM_DEV_ALG_MAX_LEN) {
+		dev_err(dev, "algs size %u is equal or larger than %d.\n",
+			dev_algs_size, QM_DEV_ALG_MAX_LEN);
+		return -EINVAL;
+	}
+
+	algs = devm_kzalloc(dev, QM_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
+	if (!algs)
+		return -ENOMEM;
+
+	for (i = 0; i < dev_algs_size; i++)
+		if (alg_msk & dev_algs[i].alg_msk)
+			strcat(algs, dev_algs[i].alg);
+
+	ptr = strrchr(algs, '\n');
+	if (ptr) {
+		*ptr = '\0';
+		qm->uacce->algs = algs;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_set_algs);
+
 static u32 qm_get_irq_num(struct hisi_qm *qm)
 {
 	if (qm->fun_type == QM_HW_PF)
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 0e56a47eb862..2eceab7600ca 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -120,7 +120,6 @@
 					GENMASK_ULL(42, 25))
 #define SEC_AEAD_BITMAP			(GENMASK_ULL(7, 6) | GENMASK_ULL(18, 17) | \
 					GENMASK_ULL(45, 43))
-#define SEC_DEV_ALG_MAX_LEN		256
 
 struct sec_hw_error {
 	u32 int_msk;
@@ -132,11 +131,6 @@ struct sec_dfx_item {
 	u32 offset;
 };
 
-struct sec_dev_alg {
-	u64 alg_msk;
-	const char *algs;
-};
-
 static const char sec_name[] = "hisi_sec2";
 static struct dentry *sec_debugfs_root;
 
@@ -173,15 +167,15 @@ static const struct hisi_qm_cap_info sec_basic_info[] = {
 	{SEC_CORE4_ALG_BITMAP_HIGH, 0x3170, 0, GENMASK(31, 0), 0x3FFF, 0x3FFF, 0x3FFF},
 };
 
-static const struct sec_dev_alg sec_dev_algs[] = { {
+static const struct qm_dev_alg sec_dev_algs[] = { {
 		.alg_msk = SEC_CIPHER_BITMAP,
-		.algs = "cipher\n",
+		.alg = "cipher\n",
 	}, {
 		.alg_msk = SEC_DIGEST_BITMAP,
-		.algs = "digest\n",
+		.alg = "digest\n",
 	}, {
 		.alg_msk = SEC_AEAD_BITMAP,
-		.algs = "aead\n",
+		.alg = "aead\n",
 	},
 };
 
@@ -1077,37 +1071,9 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	return ret;
 }
 
-static int sec_set_qm_algs(struct hisi_qm *qm)
-{
-	struct device *dev = &qm->pdev->dev;
-	char *algs, *ptr;
-	u64 alg_mask;
-	int i;
-
-	if (!qm->use_sva)
-		return 0;
-
-	algs = devm_kzalloc(dev, SEC_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
-	if (!algs)
-		return -ENOMEM;
-
-	alg_mask = sec_get_alg_bitmap(qm, SEC_DEV_ALG_BITMAP_HIGH, SEC_DEV_ALG_BITMAP_LOW);
-
-	for (i = 0; i < ARRAY_SIZE(sec_dev_algs); i++)
-		if (alg_mask & sec_dev_algs[i].alg_msk)
-			strcat(algs, sec_dev_algs[i].algs);
-
-	ptr = strrchr(algs, '\n');
-	if (ptr)
-		*ptr = '\0';
-
-	qm->uacce->algs = algs;
-
-	return 0;
-}
-
 static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
+	u64 alg_msk;
 	int ret;
 
 	qm->pdev = pdev;
@@ -1142,7 +1108,8 @@ static int sec_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	ret = sec_set_qm_algs(qm);
+	alg_msk = sec_get_alg_bitmap(qm, SEC_DEV_ALG_BITMAP_HIGH, SEC_DEV_ALG_BITMAP_LOW);
+	ret = hisi_qm_set_algs(qm, alg_msk, sec_dev_algs, ARRAY_SIZE(sec_dev_algs));
 	if (ret) {
 		pci_err(qm->pdev, "Failed to set sec algs!\n");
 		hisi_qm_uninit(qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 07ab61c113ab..2934de25efa4 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -74,7 +74,6 @@
 #define HZIP_AXI_SHUTDOWN_ENABLE	BIT(14)
 #define HZIP_WR_PORT			BIT(11)
 
-#define HZIP_DEV_ALG_MAX_LEN		256
 #define HZIP_ALG_ZLIB_BIT		GENMASK(1, 0)
 #define HZIP_ALG_GZIP_BIT		GENMASK(3, 2)
 #define HZIP_ALG_DEFLATE_BIT		GENMASK(5, 4)
@@ -128,23 +127,18 @@ struct zip_dfx_item {
 	u32 offset;
 };
 
-struct zip_dev_alg {
-	u32 alg_msk;
-	const char *algs;
-};
-
-static const struct zip_dev_alg zip_dev_algs[] = { {
+static const struct qm_dev_alg zip_dev_algs[] = { {
 		.alg_msk = HZIP_ALG_ZLIB_BIT,
-		.algs = "zlib\n",
+		.alg = "zlib\n",
 	}, {
 		.alg_msk = HZIP_ALG_GZIP_BIT,
-		.algs = "gzip\n",
+		.alg = "gzip\n",
 	}, {
 		.alg_msk = HZIP_ALG_DEFLATE_BIT,
-		.algs = "deflate\n",
+		.alg = "deflate\n",
 	}, {
 		.alg_msk = HZIP_ALG_LZ77_BIT,
-		.algs = "lz77_zstd\n",
+		.alg = "lz77_zstd\n",
 	},
 };
 
@@ -478,35 +472,6 @@ static int hisi_zip_set_high_perf(struct hisi_qm *qm)
 	return ret;
 }
 
-static int hisi_zip_set_qm_algs(struct hisi_qm *qm)
-{
-	struct device *dev = &qm->pdev->dev;
-	char *algs, *ptr;
-	u32 alg_mask;
-	int i;
-
-	if (!qm->use_sva)
-		return 0;
-
-	algs = devm_kzalloc(dev, HZIP_DEV_ALG_MAX_LEN * sizeof(char), GFP_KERNEL);
-	if (!algs)
-		return -ENOMEM;
-
-	alg_mask = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_DEV_ALG_BITMAP, qm->cap_ver);
-
-	for (i = 0; i < ARRAY_SIZE(zip_dev_algs); i++)
-		if (alg_mask & zip_dev_algs[i].alg_msk)
-			strcat(algs, zip_dev_algs[i].algs);
-
-	ptr = strrchr(algs, '\n');
-	if (ptr)
-		*ptr = '\0';
-
-	qm->uacce->algs = algs;
-
-	return 0;
-}
-
 static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
 {
 	u32 val;
@@ -1193,6 +1158,7 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 
 static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
+	u64 alg_msk;
 	int ret;
 
 	qm->pdev = pdev;
@@ -1228,7 +1194,8 @@ static int hisi_zip_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	ret = hisi_zip_set_qm_algs(qm);
+	alg_msk = hisi_qm_get_hw_info(qm, zip_basic_cap_info, ZIP_DEV_ALG_BITMAP, qm->cap_ver);
+	ret = hisi_qm_set_algs(qm, alg_msk, zip_dev_algs, ARRAY_SIZE(zip_dev_algs));
 	if (ret) {
 		pci_err(qm->pdev, "Failed to set zip algs!\n");
 		hisi_qm_uninit(qm);
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index e3c0a1297b2c..cdc979f66dba 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -156,6 +156,11 @@ enum qm_cap_bits {
 	QM_SUPPORT_RPM,
 };
 
+struct qm_dev_alg {
+	u64 alg_msk;
+	const char *alg;
+};
+
 struct dfx_diff_registers {
 	u32 *regs;
 	u32 reg_offset;
@@ -361,7 +366,6 @@ struct hisi_qm {
 	struct work_struct rst_work;
 	struct work_struct cmd_process;
 
-	const char *algs;
 	bool use_sva;
 
 	resource_size_t phys_base;
@@ -559,6 +563,8 @@ void hisi_qm_regs_dump(struct seq_file *s, struct debugfs_regset32 *regset);
 u32 hisi_qm_get_hw_info(struct hisi_qm *qm,
 			const struct hisi_qm_cap_info *info_table,
 			u32 index, bool is_read);
+int hisi_qm_set_algs(struct hisi_qm *qm, u64 alg_msk, const struct qm_dev_alg *dev_algs,
+		     u32 dev_algs_size);
 
 /* Used by VFIO ACC live migration driver */
 struct pci_driver *hisi_sec_get_pf_driver(void);
-- 
2.30.0

