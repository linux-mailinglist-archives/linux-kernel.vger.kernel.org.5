Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA8801BB1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjLBJU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjLBJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:20:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13571181;
        Sat,  2 Dec 2023 01:20:58 -0800 (PST)
Received: from dggpeml500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sj46V20rnzMnZj;
        Sat,  2 Dec 2023 17:16:02 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 2 Dec 2023 17:20:56 +0800
From:   Zhiqi Song <songzhiqi1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <fanghao11@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <shenyang39@huawei.com>
Subject: [PATCH 3/5] crypto: hisilicon/hpre - save capability registers in probe process
Date:   Sat, 2 Dec 2023 17:17:20 +0800
Message-ID: <20231202091722.1974582-4-songzhiqi1@huawei.com>
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

Pre-store the valid value of hpre alg support related capability
register in hpre_qm_init(), which will be called by hpre_probe().
It can reduce the number of capability register queries and avoid
obtaining incorrect values in abnormal scenarios, such as reset
failed and the memory space disabled.

Fixes: f214d59a0603 ("crypto: hisilicon/hpre - support hpre capability")
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_main.c | 82 ++++++++++++++++++-----
 1 file changed, 64 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 84c92d85d23d..3255b2a070c7 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -226,6 +226,20 @@ static const struct hisi_qm_cap_info hpre_basic_info[] = {
 	{HPRE_CORE10_ALG_BITMAP_CAP, 0x3170, 0, GENMASK(31, 0), 0x0, 0x10, 0x10}
 };
 
+enum hpre_pre_store_cap_idx {
+	HPRE_CLUSTER_NUM_CAP_IDX = 0x0,
+	HPRE_CORE_ENABLE_BITMAP_CAP_IDX,
+	HPRE_DRV_ALG_BITMAP_CAP_IDX,
+	HPRE_DEV_ALG_BITMAP_CAP_IDX,
+};
+
+static const u32 hpre_pre_store_caps[] = {
+	HPRE_CLUSTER_NUM_CAP,
+	HPRE_CORE_ENABLE_BITMAP_CAP,
+	HPRE_DRV_ALG_BITMAP_CAP,
+	HPRE_DEV_ALG_BITMAP_CAP,
+};
+
 static const struct hpre_hw_error hpre_hw_errors[] = {
 	{
 		.int_msk = BIT(0),
@@ -348,7 +362,7 @@ bool hpre_check_alg_support(struct hisi_qm *qm, u32 alg)
 {
 	u32 cap_val;
 
-	cap_val = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_DRV_ALG_BITMAP_CAP, qm->cap_ver);
+	cap_val = qm->cap_tables.dev_cap_table[HPRE_DRV_ALG_BITMAP_CAP_IDX].cap_val;
 	if (alg & cap_val)
 		return true;
 
@@ -424,16 +438,6 @@ static u32 vfs_num;
 module_param_cb(vfs_num, &vfs_num_ops, &vfs_num, 0444);
 MODULE_PARM_DESC(vfs_num, "Number of VFs to enable(1-63), 0(default)");
 
-static inline int hpre_cluster_num(struct hisi_qm *qm)
-{
-	return hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CLUSTER_NUM_CAP, qm->cap_ver);
-}
-
-static inline int hpre_cluster_core_mask(struct hisi_qm *qm)
-{
-	return hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_CORE_ENABLE_BITMAP_CAP, qm->cap_ver);
-}
-
 struct hisi_qp *hpre_create_qp(u8 type)
 {
 	int node = cpu_to_node(smp_processor_id());
@@ -500,13 +504,15 @@ static int hpre_cfg_by_dsm(struct hisi_qm *qm)
 
 static int hpre_set_cluster(struct hisi_qm *qm)
 {
-	u32 cluster_core_mask = hpre_cluster_core_mask(qm);
-	u8 clusters_num = hpre_cluster_num(qm);
 	struct device *dev = &qm->pdev->dev;
 	unsigned long offset;
+	u32 cluster_core_mask;
+	u8 clusters_num;
 	u32 val = 0;
 	int ret, i;
 
+	cluster_core_mask = qm->cap_tables.dev_cap_table[HPRE_CORE_ENABLE_BITMAP_CAP_IDX].cap_val;
+	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
 	for (i = 0; i < clusters_num; i++) {
 		offset = i * HPRE_CLSTR_ADDR_INTRVL;
 
@@ -701,11 +707,12 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 
 static void hpre_cnt_regs_clear(struct hisi_qm *qm)
 {
-	u8 clusters_num = hpre_cluster_num(qm);
 	unsigned long offset;
+	u8 clusters_num;
 	int i;
 
 	/* clear clusterX/cluster_ctrl */
+	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
 	for (i = 0; i < clusters_num; i++) {
 		offset = HPRE_CLSTR_BASE + i * HPRE_CLSTR_ADDR_INTRVL;
 		writel(0x0, qm->io_base + offset + HPRE_CLUSTER_INQURY);
@@ -992,13 +999,14 @@ static int hpre_pf_comm_regs_debugfs_init(struct hisi_qm *qm)
 
 static int hpre_cluster_debugfs_init(struct hisi_qm *qm)
 {
-	u8 clusters_num = hpre_cluster_num(qm);
 	struct device *dev = &qm->pdev->dev;
 	char buf[HPRE_DBGFS_VAL_MAX_LEN];
 	struct debugfs_regset32 *regset;
 	struct dentry *tmp_d;
+	u8 clusters_num;
 	int i, ret;
 
+	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
 	for (i = 0; i < clusters_num; i++) {
 		ret = snprintf(buf, HPRE_DBGFS_VAL_MAX_LEN, "cluster%d", i);
 		if (ret >= HPRE_DBGFS_VAL_MAX_LEN)
@@ -1103,6 +1111,34 @@ static void hpre_debugfs_exit(struct hisi_qm *qm)
 	debugfs_remove_recursive(qm->debug.debug_root);
 }
 
+static int hpre_pre_store_cap_reg(struct hisi_qm *qm)
+{
+	struct hisi_qm_cap_record *hpre_cap;
+	struct device *dev = &qm->pdev->dev;
+	size_t i, size;
+
+	size = ARRAY_SIZE(hpre_pre_store_caps);
+	hpre_cap = devm_kzalloc(dev, sizeof(*hpre_cap) * size, GFP_KERNEL);
+	if (!hpre_cap)
+		return -ENOMEM;
+
+	for (i = 0; i < size; i++) {
+		hpre_cap[i].type = hpre_pre_store_caps[i];
+		hpre_cap[i].cap_val = hisi_qm_get_hw_info(qm, hpre_basic_info,
+				      hpre_pre_store_caps[i], qm->cap_ver);
+	}
+
+	if (hpre_cap[HPRE_CLUSTER_NUM_CAP_IDX].cap_val > HPRE_CLUSTERS_NUM_MAX) {
+		dev_err(dev, "Device cluster num %u is out of range for driver supports %d!\n",
+			hpre_cap[HPRE_CLUSTER_NUM_CAP_IDX].cap_val, HPRE_CLUSTERS_NUM_MAX);
+		return -EINVAL;
+	}
+
+	qm->cap_tables.dev_cap_table = hpre_cap;
+
+	return 0;
+}
+
 static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 {
 	u64 alg_msk;
@@ -1136,7 +1172,15 @@ static int hpre_qm_init(struct hisi_qm *qm, struct pci_dev *pdev)
 		return ret;
 	}
 
-	alg_msk = hisi_qm_get_hw_info(qm, hpre_basic_info, HPRE_DEV_ALG_BITMAP_CAP, qm->cap_ver);
+	/* Fetch and save the value of capability registers */
+	ret = hpre_pre_store_cap_reg(qm);
+	if (ret) {
+		pci_err(pdev, "Failed to pre-store capability registers!\n");
+		hisi_qm_uninit(qm);
+		return ret;
+	}
+
+	alg_msk = qm->cap_tables.dev_cap_table[HPRE_DEV_ALG_BITMAP_CAP_IDX].cap_val;
 	ret = hisi_qm_set_algs(qm, alg_msk, hpre_dev_algs, ARRAY_SIZE(hpre_dev_algs));
 	if (ret) {
 		pci_err(pdev, "Failed to set hpre algs!\n");
@@ -1150,11 +1194,12 @@ static int hpre_show_last_regs_init(struct hisi_qm *qm)
 {
 	int cluster_dfx_regs_num =  ARRAY_SIZE(hpre_cluster_dfx_regs);
 	int com_dfx_regs_num = ARRAY_SIZE(hpre_com_dfx_regs);
-	u8 clusters_num = hpre_cluster_num(qm);
 	struct qm_debug *debug = &qm->debug;
 	void __iomem *io_base;
+	u8 clusters_num;
 	int i, j, idx;
 
+	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
 	debug->last_words = kcalloc(cluster_dfx_regs_num * clusters_num +
 			com_dfx_regs_num, sizeof(unsigned int), GFP_KERNEL);
 	if (!debug->last_words)
@@ -1191,10 +1236,10 @@ static void hpre_show_last_dfx_regs(struct hisi_qm *qm)
 {
 	int cluster_dfx_regs_num =  ARRAY_SIZE(hpre_cluster_dfx_regs);
 	int com_dfx_regs_num = ARRAY_SIZE(hpre_com_dfx_regs);
-	u8 clusters_num = hpre_cluster_num(qm);
 	struct qm_debug *debug = &qm->debug;
 	struct pci_dev *pdev = qm->pdev;
 	void __iomem *io_base;
+	u8 clusters_num;
 	int i, j, idx;
 	u32 val;
 
@@ -1209,6 +1254,7 @@ static void hpre_show_last_dfx_regs(struct hisi_qm *qm)
 			  hpre_com_dfx_regs[i].name, debug->last_words[i], val);
 	}
 
+	clusters_num = qm->cap_tables.dev_cap_table[HPRE_CLUSTER_NUM_CAP_IDX].cap_val;
 	for (i = 0; i < clusters_num; i++) {
 		io_base = qm->io_base + hpre_cluster_offsets[i];
 		for (j = 0; j <  cluster_dfx_regs_num; j++) {
-- 
2.30.0

