Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C54767F46
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjG2Mzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjG2Mz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:55:29 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9FC30CF;
        Sat, 29 Jul 2023 05:55:27 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCkss0wpJzNm5S;
        Sat, 29 Jul 2023 20:52:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 20:55:24 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 2/7] crypto: hisilicon/qm - alloc buffer to set and get xqc
Date:   Sat, 29 Jul 2023 20:52:34 +0800
Message-ID: <20230729125239.25337-3-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230729125239.25337-1-qianweili@huawei.com>
References: <20230729125239.25337-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the temporarily applied memory is used to set or get the xqc
information, the driver releases the memory immediately after the
hardware mailbox operation time exceeds the driver waiting time.
However, the hardware does not cancel the operation, so the hardware
may write data to released memory.

Therefore, when the driver is bound to a device, the driver reserves
memory for the xqc configuration. The subsequent xqc configuration
uses the reserved memory to prevent hardware from accessing the
released memory.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c   |  75 +++---
 drivers/crypto/hisilicon/qm.c        | 331 ++++++++++++---------------
 drivers/crypto/hisilicon/qm_common.h |   5 +-
 include/linux/hisi_acc_qm.h          |  13 ++
 4 files changed, 193 insertions(+), 231 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 2cc1591949db..7e8186fe0512 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -137,8 +137,8 @@ static void dump_show(struct hisi_qm *qm, void *info,
 static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
-	struct qm_sqc *sqc, *sqc_curr;
-	dma_addr_t sqc_dma;
+	struct qm_sqc *sqc_curr;
+	struct qm_sqc sqc;
 	u32 qp_id;
 	int ret;
 
@@ -151,35 +151,29 @@ static int qm_sqc_dump(struct hisi_qm *qm, char *s, char *name)
 		return -EINVAL;
 	}
 
-	sqc = hisi_qm_ctx_alloc(qm, sizeof(*sqc), &sqc_dma);
-	if (IS_ERR(sqc))
-		return PTR_ERR(sqc);
+	ret = qm_set_and_get_xqc(qm, QM_MB_CMD_SQC, &sqc, qp_id, 1);
+	if (!ret) {
+		dump_show(qm, &sqc, sizeof(struct qm_sqc), name);
 
-	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC, sqc_dma, qp_id, 1);
-	if (ret) {
-		down_read(&qm->qps_lock);
-		if (qm->sqc) {
-			sqc_curr = qm->sqc + qp_id;
+		return 0;
+	}
 
-			dump_show(qm, sqc_curr, sizeof(*sqc), "SOFT SQC");
-		}
-		up_read(&qm->qps_lock);
+	down_read(&qm->qps_lock);
+	if (qm->sqc) {
+		sqc_curr = qm->sqc + qp_id;
 
-		goto free_ctx;
+		dump_show(qm, sqc_curr, sizeof(*sqc_curr), "SOFT SQC");
 	}
+	up_read(&qm->qps_lock);
 
-	dump_show(qm, sqc, sizeof(*sqc), name);
-
-free_ctx:
-	hisi_qm_ctx_free(qm, sizeof(*sqc), sqc, &sqc_dma);
 	return 0;
 }
 
 static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
-	struct qm_cqc *cqc, *cqc_curr;
-	dma_addr_t cqc_dma;
+	struct qm_cqc *cqc_curr;
+	struct qm_cqc cqc;
 	u32 qp_id;
 	int ret;
 
@@ -192,34 +186,29 @@ static int qm_cqc_dump(struct hisi_qm *qm, char *s, char *name)
 		return -EINVAL;
 	}
 
-	cqc = hisi_qm_ctx_alloc(qm, sizeof(*cqc), &cqc_dma);
-	if (IS_ERR(cqc))
-		return PTR_ERR(cqc);
+	ret = qm_set_and_get_xqc(qm, QM_MB_CMD_CQC, &cqc, qp_id, 1);
+	if (!ret) {
+		dump_show(qm, &cqc, sizeof(struct qm_cqc), name);
 
-	ret = hisi_qm_mb(qm, QM_MB_CMD_CQC, cqc_dma, qp_id, 1);
-	if (ret) {
-		down_read(&qm->qps_lock);
-		if (qm->cqc) {
-			cqc_curr = qm->cqc + qp_id;
+		return 0;
+	}
 
-			dump_show(qm, cqc_curr, sizeof(*cqc), "SOFT CQC");
-		}
-		up_read(&qm->qps_lock);
+	down_read(&qm->qps_lock);
+	if (qm->cqc) {
+		cqc_curr = qm->cqc + qp_id;
 
-		goto free_ctx;
+		dump_show(qm, cqc_curr, sizeof(*cqc_curr), "SOFT CQC");
 	}
+	up_read(&qm->qps_lock);
 
-	dump_show(qm, cqc, sizeof(*cqc), name);
-
-free_ctx:
-	hisi_qm_ctx_free(qm, sizeof(*cqc), cqc, &cqc_dma);
 	return 0;
 }
 
 static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, char *name)
 {
 	struct device *dev = &qm->pdev->dev;
-	dma_addr_t xeqc_dma;
+	struct qm_aeqc aeqc;
+	struct qm_eqc eqc;
 	size_t size;
 	void *xeqc;
 	int ret;
@@ -233,23 +222,19 @@ static int qm_eqc_aeqc_dump(struct hisi_qm *qm, char *s, char *name)
 	if (!strcmp(name, "EQC")) {
 		cmd = QM_MB_CMD_EQC;
 		size = sizeof(struct qm_eqc);
+		xeqc = &eqc;
 	} else {
 		cmd = QM_MB_CMD_AEQC;
 		size = sizeof(struct qm_aeqc);
+		xeqc = &aeqc;
 	}
 
-	xeqc = hisi_qm_ctx_alloc(qm, size, &xeqc_dma);
-	if (IS_ERR(xeqc))
-		return PTR_ERR(xeqc);
-
-	ret = hisi_qm_mb(qm, cmd, xeqc_dma, 0, 1);
+	ret = qm_set_and_get_xqc(qm, cmd, xeqc, 0, 1);
 	if (ret)
-		goto err_free_ctx;
+		return ret;
 
 	dump_show(qm, xeqc, size, name);
 
-err_free_ctx:
-	hisi_qm_ctx_free(qm, size, xeqc, &xeqc_dma);
 	return ret;
 }
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index ef807a90946b..33b0368fd348 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -48,7 +48,7 @@
 #define QM_QC_PASID_ENABLE_SHIFT	7
 
 #define QM_SQ_TYPE_MASK			GENMASK(3, 0)
-#define QM_SQ_TAIL_IDX(sqc)		((le16_to_cpu((sqc)->w11) >> 6) & 0x1)
+#define QM_SQ_TAIL_IDX(sqc)		((le16_to_cpu((sqc).w11) >> 6) & 0x1)
 
 /* cqc shift */
 #define QM_CQ_HOP_NUM_SHIFT		0
@@ -60,7 +60,7 @@
 
 #define QM_CQE_PHASE(cqe)		(le16_to_cpu((cqe)->w7) & 0x1)
 #define QM_QC_CQE_SIZE			4
-#define QM_CQ_TAIL_IDX(cqc)		((le16_to_cpu((cqc)->w11) >> 6) & 0x1)
+#define QM_CQ_TAIL_IDX(cqc)		((le16_to_cpu((cqc).w11) >> 6) & 0x1)
 
 /* eqc shift */
 #define QM_EQE_AEQE_SIZE		(2UL << 12)
@@ -255,19 +255,6 @@
 #define QM_MK_SQC_DW3_V2(sqe_sz, sq_depth) \
 	((((u32)sq_depth) - 1) | ((u32)ilog2(sqe_sz) << QM_SQ_SQE_SIZE_SHIFT))
 
-#define INIT_QC_COMMON(qc, base, pasid) do {			\
-	(qc)->head = 0;						\
-	(qc)->tail = 0;						\
-	(qc)->base_l = cpu_to_le32(lower_32_bits(base));	\
-	(qc)->base_h = cpu_to_le32(upper_32_bits(base));	\
-	(qc)->dw3 = 0;						\
-	(qc)->w8 = 0;						\
-	(qc)->rsvd0 = 0;					\
-	(qc)->pasid = cpu_to_le16(pasid);			\
-	(qc)->w11 = 0;						\
-	(qc)->rsvd1 = 0;					\
-} while (0)
-
 enum vft_type {
 	SQC_VFT = 0,
 	CQC_VFT,
@@ -754,6 +741,59 @@ static int hisi_qm_mb_read(struct hisi_qm *qm, u64 *base, u8 cmd, u16 queue)
 	return 0;
 }
 
+/* op 0: set xqc information to hardware, 1: get xqc information from hardware. */
+int qm_set_and_get_xqc(struct hisi_qm *qm, u8 cmd, void *xqc, u32 qp_id, bool op)
+{
+	struct hisi_qm *pf_qm = pci_get_drvdata(pci_physfn(qm->pdev));
+	struct qm_mailbox mailbox;
+	dma_addr_t xqc_dma;
+	void *tmp_xqc;
+	size_t size;
+	int ret;
+
+	switch (cmd) {
+	case QM_MB_CMD_SQC:
+		size = sizeof(struct qm_sqc);
+		tmp_xqc = qm->xqc_buf.sqc;
+		xqc_dma = qm->xqc_buf.sqc_dma;
+		break;
+	case QM_MB_CMD_CQC:
+		size = sizeof(struct qm_cqc);
+		tmp_xqc = qm->xqc_buf.cqc;
+		xqc_dma = qm->xqc_buf.cqc_dma;
+		break;
+	case QM_MB_CMD_EQC:
+		size = sizeof(struct qm_eqc);
+		tmp_xqc = qm->xqc_buf.eqc;
+		xqc_dma = qm->xqc_buf.eqc_dma;
+		break;
+	case QM_MB_CMD_AEQC:
+		size = sizeof(struct qm_aeqc);
+		tmp_xqc = qm->xqc_buf.aeqc;
+		xqc_dma = qm->xqc_buf.aeqc_dma;
+		break;
+	}
+
+	/* No need to judge if master OOO is blocked. */
+	if (qm_check_dev_error(pf_qm)) {
+		dev_err(&qm->pdev->dev, "failed to send mailbox since qm is stop!\n");
+		return -EIO;
+	}
+
+	mutex_lock(&qm->mailbox_lock);
+	if (!op)
+		memcpy(tmp_xqc, xqc, size);
+
+	qm_mb_pre_init(&mailbox, cmd, xqc_dma, qp_id, op);
+	ret = qm_mb_nolock(qm, &mailbox);
+	if (!ret && op)
+		memcpy(xqc, tmp_xqc, size);
+
+	mutex_unlock(&qm->mailbox_lock);
+
+	return ret;
+}
+
 static void qm_db_v1(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
 {
 	u64 doorbell;
@@ -1386,45 +1426,6 @@ static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
 	return 0;
 }
 
-void *hisi_qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
-			  dma_addr_t *dma_addr)
-{
-	struct device *dev = &qm->pdev->dev;
-	void *ctx_addr;
-
-	ctx_addr = kzalloc(ctx_size, GFP_KERNEL);
-	if (!ctx_addr)
-		return ERR_PTR(-ENOMEM);
-
-	*dma_addr = dma_map_single(dev, ctx_addr, ctx_size, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, *dma_addr)) {
-		dev_err(dev, "DMA mapping error!\n");
-		kfree(ctx_addr);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	return ctx_addr;
-}
-
-void hisi_qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
-			const void *ctx_addr, dma_addr_t *dma_addr)
-{
-	struct device *dev = &qm->pdev->dev;
-
-	dma_unmap_single(dev, *dma_addr, ctx_size, DMA_FROM_DEVICE);
-	kfree(ctx_addr);
-}
-
-static int qm_dump_sqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
-{
-	return hisi_qm_mb(qm, QM_MB_CMD_SQC, dma_addr, qp_id, 1);
-}
-
-static int qm_dump_cqc_raw(struct hisi_qm *qm, dma_addr_t dma_addr, u16 qp_id)
-{
-	return hisi_qm_mb(qm, QM_MB_CMD_CQC, dma_addr, qp_id, 1);
-}
-
 static void qm_hw_error_init_v1(struct hisi_qm *qm)
 {
 	writel(QM_ABNORMAL_INT_MASK_VALUE, qm->io_base + QM_ABNORMAL_INT_MASK);
@@ -1998,84 +1999,55 @@ static void hisi_qm_release_qp(struct hisi_qp *qp)
 static int qm_sq_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
 {
 	struct hisi_qm *qm = qp->qm;
-	struct device *dev = &qm->pdev->dev;
 	enum qm_hw_ver ver = qm->ver;
-	struct qm_sqc *sqc;
-	dma_addr_t sqc_dma;
-	int ret;
+	struct qm_sqc sqc = {0};
 
-	sqc = kzalloc(sizeof(struct qm_sqc), GFP_KERNEL);
-	if (!sqc)
-		return -ENOMEM;
-
-	INIT_QC_COMMON(sqc, qp->sqe_dma, pasid);
 	if (ver == QM_HW_V1) {
-		sqc->dw3 = cpu_to_le32(QM_MK_SQC_DW3_V1(0, 0, 0, qm->sqe_size));
-		sqc->w8 = cpu_to_le16(qp->sq_depth - 1);
+		sqc.dw3 = cpu_to_le32(QM_MK_SQC_DW3_V1(0, 0, 0, qm->sqe_size));
+		sqc.w8 = cpu_to_le16(qp->sq_depth - 1);
 	} else {
-		sqc->dw3 = cpu_to_le32(QM_MK_SQC_DW3_V2(qm->sqe_size, qp->sq_depth));
-		sqc->w8 = 0; /* rand_qc */
+		sqc.dw3 = cpu_to_le32(QM_MK_SQC_DW3_V2(qm->sqe_size, qp->sq_depth));
+		sqc.w8 = 0; /* rand_qc */
 	}
-	sqc->cq_num = cpu_to_le16(qp_id);
-	sqc->w13 = cpu_to_le16(QM_MK_SQC_W13(0, 1, qp->alg_type));
+	sqc.cq_num = cpu_to_le16(qp_id);
+	sqc.w13 = cpu_to_le16(QM_MK_SQC_W13(0, 1, qp->alg_type));
+	sqc.base_l = cpu_to_le32(lower_32_bits(qp->sqe_dma));
+	sqc.base_h = cpu_to_le32(upper_32_bits(qp->sqe_dma));
+	sqc.pasid = cpu_to_le16(pasid);
 
 	if (ver >= QM_HW_V3 && qm->use_sva && !qp->is_in_kernel)
-		sqc->w11 = cpu_to_le16(QM_QC_PASID_ENABLE <<
+		sqc.w11 = cpu_to_le16(QM_QC_PASID_ENABLE <<
 				       QM_QC_PASID_ENABLE_SHIFT);
 
-	sqc_dma = dma_map_single(dev, sqc, sizeof(struct qm_sqc),
-				 DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, sqc_dma)) {
-		kfree(sqc);
-		return -ENOMEM;
-	}
-
-	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC, sqc_dma, qp_id, 0);
-	dma_unmap_single(dev, sqc_dma, sizeof(struct qm_sqc), DMA_TO_DEVICE);
-	kfree(sqc);
-
-	return ret;
+	return qm_set_and_get_xqc(qm, QM_MB_CMD_SQC, &sqc, qp_id, 0);
 }
 
 static int qm_cq_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
 {
 	struct hisi_qm *qm = qp->qm;
-	struct device *dev = &qm->pdev->dev;
 	enum qm_hw_ver ver = qm->ver;
-	struct qm_cqc *cqc;
-	dma_addr_t cqc_dma;
-	int ret;
-
-	cqc = kzalloc(sizeof(struct qm_cqc), GFP_KERNEL);
-	if (!cqc)
-		return -ENOMEM;
+	struct qm_cqc cqc = {0};
 
-	INIT_QC_COMMON(cqc, qp->cqe_dma, pasid);
+	cqc.base_l = cpu_to_le32(lower_32_bits(qp->cqe_dma));
+	cqc.base_h = cpu_to_le32(upper_32_bits(qp->cqe_dma));
+	cqc.pasid = cpu_to_le16(pasid);
 	if (ver == QM_HW_V1) {
-		cqc->dw3 = cpu_to_le32(QM_MK_CQC_DW3_V1(0, 0, 0,
+		cqc.dw3 = cpu_to_le32(QM_MK_CQC_DW3_V1(0, 0, 0,
 							QM_QC_CQE_SIZE));
-		cqc->w8 = cpu_to_le16(qp->cq_depth - 1);
+		cqc.w8 = cpu_to_le16(qp->cq_depth - 1);
 	} else {
-		cqc->dw3 = cpu_to_le32(QM_MK_CQC_DW3_V2(QM_QC_CQE_SIZE, qp->cq_depth));
-		cqc->w8 = 0; /* rand_qc */
+		cqc.dw3 = cpu_to_le32(QM_MK_CQC_DW3_V2(QM_QC_CQE_SIZE, qp->cq_depth));
+		cqc.w8 = 0; /* rand_qc */
 	}
-	cqc->dw6 = cpu_to_le32(1 << QM_CQ_PHASE_SHIFT | 1 << QM_CQ_FLAG_SHIFT);
+	cqc.dw6 = cpu_to_le32(1 << QM_CQ_PHASE_SHIFT | 1 << QM_CQ_FLAG_SHIFT);
+	cqc.base_l = cpu_to_le32(lower_32_bits(qp->cqe_dma));
+	cqc.base_h = cpu_to_le32(upper_32_bits(qp->cqe_dma));
+	cqc.pasid = cpu_to_le16(pasid);
 
 	if (ver >= QM_HW_V3 && qm->use_sva && !qp->is_in_kernel)
-		cqc->w11 = cpu_to_le16(QM_QC_PASID_ENABLE);
-
-	cqc_dma = dma_map_single(dev, cqc, sizeof(struct qm_cqc),
-				 DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, cqc_dma)) {
-		kfree(cqc);
-		return -ENOMEM;
-	}
+		cqc.w11 = cpu_to_le16(QM_QC_PASID_ENABLE);
 
-	ret = hisi_qm_mb(qm, QM_MB_CMD_CQC, cqc_dma, qp_id, 0);
-	dma_unmap_single(dev, cqc_dma, sizeof(struct qm_cqc), DMA_TO_DEVICE);
-	kfree(cqc);
-
-	return ret;
+	return qm_set_and_get_xqc(qm, QM_MB_CMD_CQC, &cqc, qp_id, 0);
 }
 
 static int qm_qp_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
@@ -2165,14 +2137,11 @@ static void qp_stop_fail_cb(struct hisi_qp *qp)
  */
 static int qm_drain_qp(struct hisi_qp *qp)
 {
-	size_t size = sizeof(struct qm_sqc) + sizeof(struct qm_cqc);
 	struct hisi_qm *qm = qp->qm;
 	struct device *dev = &qm->pdev->dev;
-	struct qm_sqc *sqc;
-	struct qm_cqc *cqc;
-	dma_addr_t dma_addr;
+	struct qm_sqc sqc;
+	struct qm_cqc cqc;
 	int ret = 0, i = 0;
-	void *addr;
 
 	/* No need to judge if master OOO is blocked. */
 	if (qm_check_dev_error(qm))
@@ -2186,44 +2155,32 @@ static int qm_drain_qp(struct hisi_qp *qp)
 		return ret;
 	}
 
-	addr = hisi_qm_ctx_alloc(qm, size, &dma_addr);
-	if (IS_ERR(addr)) {
-		dev_err(dev, "Failed to alloc ctx for sqc and cqc!\n");
-		return -ENOMEM;
-	}
-
 	while (++i) {
-		ret = qm_dump_sqc_raw(qm, dma_addr, qp->qp_id);
+		ret = qm_set_and_get_xqc(qm, QM_MB_CMD_SQC, &sqc, qp->qp_id, 1);
 		if (ret) {
 			dev_err_ratelimited(dev, "Failed to dump sqc!\n");
-			break;
+			return ret;
 		}
-		sqc = addr;
 
-		ret = qm_dump_cqc_raw(qm, (dma_addr + sizeof(struct qm_sqc)),
-				      qp->qp_id);
+		ret = qm_set_and_get_xqc(qm, QM_MB_CMD_CQC, &cqc, qp->qp_id, 1);
 		if (ret) {
 			dev_err_ratelimited(dev, "Failed to dump cqc!\n");
-			break;
+			return ret;
 		}
-		cqc = addr + sizeof(struct qm_sqc);
 
-		if ((sqc->tail == cqc->tail) &&
+		if ((sqc.tail == cqc.tail) &&
 		    (QM_SQ_TAIL_IDX(sqc) == QM_CQ_TAIL_IDX(cqc)))
 			break;
 
 		if (i == MAX_WAIT_COUNTS) {
 			dev_err(dev, "Fail to empty queue %u!\n", qp->qp_id);
-			ret = -EBUSY;
-			break;
+			return -EBUSY;
 		}
 
 		usleep_range(WAIT_PERIOD_US_MIN, WAIT_PERIOD_US_MAX);
 	}
 
-	hisi_qm_ctx_free(qm, size, addr, &dma_addr);
-
-	return ret;
+	return 0;
 }
 
 static int qm_stop_qp_nolock(struct hisi_qp *qp)
@@ -2936,11 +2893,20 @@ static void hisi_qm_unint_work(struct hisi_qm *qm)
 	destroy_workqueue(qm->wq);
 }
 
+static void hisi_qm_free_rsv_buf(struct hisi_qm *qm)
+{
+	struct qm_dma *xqc_dma = &qm->xqc_buf.qcdma;
+	struct device *dev = &qm->pdev->dev;
+
+	dma_free_coherent(dev, xqc_dma->size, xqc_dma->va, xqc_dma->dma);
+}
+
 static void hisi_qm_memory_uninit(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
 
 	hisi_qp_memory_uninit(qm, qm->qp_num);
+	hisi_qm_free_rsv_buf(qm);
 	if (qm->qdma.va) {
 		hisi_qm_cache_wb(qm);
 		dma_free_coherent(dev, qm->qdma.size,
@@ -3062,62 +3028,26 @@ static void qm_disable_eq_aeq_interrupts(struct hisi_qm *qm)
 
 static int qm_eq_ctx_cfg(struct hisi_qm *qm)
 {
-	struct device *dev = &qm->pdev->dev;
-	struct qm_eqc *eqc;
-	dma_addr_t eqc_dma;
-	int ret;
+	struct qm_eqc eqc = {0};
 
-	eqc = kzalloc(sizeof(struct qm_eqc), GFP_KERNEL);
-	if (!eqc)
-		return -ENOMEM;
-
-	eqc->base_l = cpu_to_le32(lower_32_bits(qm->eqe_dma));
-	eqc->base_h = cpu_to_le32(upper_32_bits(qm->eqe_dma));
+	eqc.base_l = cpu_to_le32(lower_32_bits(qm->eqe_dma));
+	eqc.base_h = cpu_to_le32(upper_32_bits(qm->eqe_dma));
 	if (qm->ver == QM_HW_V1)
-		eqc->dw3 = cpu_to_le32(QM_EQE_AEQE_SIZE);
-	eqc->dw6 = cpu_to_le32(((u32)qm->eq_depth - 1) | (1 << QM_EQC_PHASE_SHIFT));
-
-	eqc_dma = dma_map_single(dev, eqc, sizeof(struct qm_eqc),
-				 DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, eqc_dma)) {
-		kfree(eqc);
-		return -ENOMEM;
-	}
+		eqc.dw3 = cpu_to_le32(QM_EQE_AEQE_SIZE);
+	eqc.dw6 = cpu_to_le32(((u32)qm->eq_depth - 1) | (1 << QM_EQC_PHASE_SHIFT));
 
-	ret = hisi_qm_mb(qm, QM_MB_CMD_EQC, eqc_dma, 0, 0);
-	dma_unmap_single(dev, eqc_dma, sizeof(struct qm_eqc), DMA_TO_DEVICE);
-	kfree(eqc);
-
-	return ret;
+	return qm_set_and_get_xqc(qm, QM_MB_CMD_EQC, &eqc, 0, 0);
 }
 
 static int qm_aeq_ctx_cfg(struct hisi_qm *qm)
 {
-	struct device *dev = &qm->pdev->dev;
-	struct qm_aeqc *aeqc;
-	dma_addr_t aeqc_dma;
-	int ret;
-
-	aeqc = kzalloc(sizeof(struct qm_aeqc), GFP_KERNEL);
-	if (!aeqc)
-		return -ENOMEM;
+	struct qm_aeqc aeqc = {0};
 
-	aeqc->base_l = cpu_to_le32(lower_32_bits(qm->aeqe_dma));
-	aeqc->base_h = cpu_to_le32(upper_32_bits(qm->aeqe_dma));
-	aeqc->dw6 = cpu_to_le32(((u32)qm->aeq_depth - 1) | (1 << QM_EQC_PHASE_SHIFT));
+	aeqc.base_l = cpu_to_le32(lower_32_bits(qm->aeqe_dma));
+	aeqc.base_h = cpu_to_le32(upper_32_bits(qm->aeqe_dma));
+	aeqc.dw6 = cpu_to_le32(((u32)qm->aeq_depth - 1) | (1 << QM_EQC_PHASE_SHIFT));
 
-	aeqc_dma = dma_map_single(dev, aeqc, sizeof(struct qm_aeqc),
-				  DMA_TO_DEVICE);
-	if (dma_mapping_error(dev, aeqc_dma)) {
-		kfree(aeqc);
-		return -ENOMEM;
-	}
-
-	ret = hisi_qm_mb(qm, QM_MB_CMD_AEQC, aeqc_dma, 0, 0);
-	dma_unmap_single(dev, aeqc_dma, sizeof(struct qm_aeqc), DMA_TO_DEVICE);
-	kfree(aeqc);
-
-	return ret;
+	return qm_set_and_get_xqc(qm, QM_MB_CMD_AEQC, &aeqc, 0, 0);
 }
 
 static int qm_eq_aeq_ctx_cfg(struct hisi_qm *qm)
@@ -5349,6 +5279,37 @@ static int hisi_qp_alloc_memory(struct hisi_qm *qm)
 	return ret;
 }
 
+static int hisi_qm_alloc_rsv_buf(struct hisi_qm *qm)
+{
+	struct qm_rsv_buf *xqc_buf = &qm->xqc_buf;
+	struct qm_dma *xqc_dma = &xqc_buf->qcdma;
+	struct device *dev = &qm->pdev->dev;
+	size_t off = 0;
+
+#define QM_XQC_BUF_INIT(xqc_buf, type) do { \
+	(xqc_buf)->type = ((xqc_buf)->qcdma.va + (off)); \
+	(xqc_buf)->type##_dma = (xqc_buf)->qcdma.dma + (off); \
+	off += QMC_ALIGN(sizeof(struct qm_##type)); \
+} while (0)
+
+	xqc_dma->size = QMC_ALIGN(sizeof(struct qm_eqc)) +
+			QMC_ALIGN(sizeof(struct qm_aeqc)) +
+			QMC_ALIGN(sizeof(struct qm_sqc)) +
+			QMC_ALIGN(sizeof(struct qm_cqc));
+
+	xqc_dma->va = dma_alloc_coherent(dev, xqc_dma->size, &xqc_dma->dma,
+					 GFP_ATOMIC);
+	if (!xqc_dma->va)
+		return -ENOMEM;
+
+	QM_XQC_BUF_INIT(xqc_buf, eqc);
+	QM_XQC_BUF_INIT(xqc_buf, aeqc);
+	QM_XQC_BUF_INIT(xqc_buf, sqc);
+	QM_XQC_BUF_INIT(xqc_buf, cqc);
+
+	return 0;
+}
+
 static int hisi_qm_memory_init(struct hisi_qm *qm)
 {
 	struct device *dev = &qm->pdev->dev;
@@ -5390,13 +5351,19 @@ static int hisi_qm_memory_init(struct hisi_qm *qm)
 	QM_INIT_BUF(qm, sqc, qm->qp_num);
 	QM_INIT_BUF(qm, cqc, qm->qp_num);
 
+	ret = hisi_qm_alloc_rsv_buf(qm);
+	if (ret)
+		goto err_free_qdma;
+
 	ret = hisi_qp_alloc_memory(qm);
 	if (ret)
-		goto err_alloc_qp_array;
+		goto err_free_reserve_buf;
 
 	return 0;
 
-err_alloc_qp_array:
+err_free_reserve_buf:
+	hisi_qm_free_rsv_buf(qm);
+err_free_qdma:
 	dma_free_coherent(dev, qm->qdma.size, qm->qdma.va, qm->qdma.dma);
 err_destroy_idr:
 	idr_destroy(&qm->qp_idr);
diff --git a/drivers/crypto/hisilicon/qm_common.h b/drivers/crypto/hisilicon/qm_common.h
index 1406a422d455..db96c8bf9692 100644
--- a/drivers/crypto/hisilicon/qm_common.h
+++ b/drivers/crypto/hisilicon/qm_common.h
@@ -77,10 +77,7 @@ static const char * const qm_s[] = {
 	"init", "start", "close", "stop",
 };
 
-void *hisi_qm_ctx_alloc(struct hisi_qm *qm, size_t ctx_size,
-			dma_addr_t *dma_addr);
-void hisi_qm_ctx_free(struct hisi_qm *qm, size_t ctx_size,
-		      const void *ctx_addr, dma_addr_t *dma_addr);
+int qm_set_and_get_xqc(struct hisi_qm *qm, u8 cmd, void *xqc, u32 qp_id, bool op);
 void hisi_qm_show_last_dfx_regs(struct hisi_qm *qm);
 void hisi_qm_set_algqos_init(struct hisi_qm *qm);
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 0f83c19a8f36..3f33d6d99999 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -284,6 +284,18 @@ struct qm_err_isolate {
 	struct list_head qm_hw_errs;
 };
 
+struct qm_rsv_buf {
+	struct qm_sqc *sqc;
+	struct qm_cqc *cqc;
+	struct qm_eqc *eqc;
+	struct qm_aeqc *aeqc;
+	dma_addr_t sqc_dma;
+	dma_addr_t cqc_dma;
+	dma_addr_t eqc_dma;
+	dma_addr_t aeqc_dma;
+	struct qm_dma qcdma;
+};
+
 struct hisi_qm {
 	enum qm_hw_ver ver;
 	enum qm_fun_type fun_type;
@@ -316,6 +328,7 @@ struct hisi_qm {
 	dma_addr_t cqc_dma;
 	dma_addr_t eqe_dma;
 	dma_addr_t aeqe_dma;
+	struct qm_rsv_buf xqc_buf;
 
 	struct hisi_qm_status status;
 	const struct hisi_qm_err_ini *err_ini;
-- 
2.33.0

