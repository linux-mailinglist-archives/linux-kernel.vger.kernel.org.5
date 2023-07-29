Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694F0767F49
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjG2Mzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjG2Mzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:55:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673C30CD;
        Sat, 29 Jul 2023 05:55:26 -0700 (PDT)
Received: from kwepemm600009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RCkwf3HnlzrRtF;
        Sat, 29 Jul 2023 20:54:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 20:55:23 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 1/7] crypto: hisilicon/qm - obtain the mailbox configuration at one time
Date:   Sat, 29 Jul 2023 20:52:33 +0800
Message-ID: <20230729125239.25337-2-qianweili@huawei.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mailbox configuration(128 bits) needs to be obtained from the
hardware at one time. If the mailbox configuration is obtained for
multiple times, the read value may be incorrect. Use the instruction
to read mailbox data instead of readl().

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 152 ++++++++++++++++++++++------------
 include/linux/hisi_acc_qm.h   |   1 -
 2 files changed, 99 insertions(+), 54 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index a99fd589445c..ef807a90946b 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -33,6 +33,8 @@
 #define QM_MB_CMD_DATA_SHIFT		32
 #define QM_MB_CMD_DATA_MASK		GENMASK(31, 0)
 #define QM_MB_STATUS_MASK		GENMASK(12, 9)
+#define QM_MB_MAX_WAIT_CNT		6000
+#define QM_MB_WAIT_READY_CNT		10
 
 /* sqc shift */
 #define QM_SQ_HOP_NUM_SHIFT		0
@@ -597,17 +599,6 @@ static void qm_mb_pre_init(struct qm_mailbox *mailbox, u8 cmd,
 	mailbox->rsvd = 0;
 }
 
-/* return 0 mailbox ready, -ETIMEDOUT hardware timeout */
-int hisi_qm_wait_mb_ready(struct hisi_qm *qm)
-{
-	u32 val;
-
-	return readl_relaxed_poll_timeout(qm->io_base + QM_MB_CMD_SEND_BASE,
-					  val, !((val >> QM_MB_BUSY_SHIFT) &
-					  0x1), POLL_PERIOD, POLL_TIMEOUT);
-}
-EXPORT_SYMBOL_GPL(hisi_qm_wait_mb_ready);
-
 /* 128 bit should be written to hardware at one time to trigger a mailbox */
 static void qm_mb_write(struct hisi_qm *qm, const void *src)
 {
@@ -635,35 +626,93 @@ static void qm_mb_write(struct hisi_qm *qm, const void *src)
 #endif
 }
 
-static int qm_mb_nolock(struct hisi_qm *qm, struct qm_mailbox *mailbox)
+/* 128 bit should be read from hardware at one time */
+static void qm_mb_read(struct hisi_qm *qm, void *dst)
 {
-	int ret;
-	u32 val;
+	const void __iomem *fun_base = qm->io_base + QM_MB_CMD_SEND_BASE;
 
-	if (unlikely(hisi_qm_wait_mb_ready(qm))) {
-		dev_err(&qm->pdev->dev, "QM mailbox is busy to start!\n");
-		ret = -EBUSY;
-		goto mb_busy;
+#if IS_ENABLED(CONFIG_ARM64)
+	unsigned long tmp0 = 0, tmp1 = 0;
+#endif
+	if (!IS_ENABLED(CONFIG_ARM64)) {
+		memcpy_fromio(dst, fun_base, 16);
+		dma_wmb();
+		return;
 	}
 
-	qm_mb_write(qm, mailbox);
+#if IS_ENABLED(CONFIG_ARM64)
+	asm volatile("ldp %0, %1, %3\n"
+		     "stp %0, %1, %2\n"
+		     "dmb oshst\n"
+		     : "=&r" (tmp0),
+		       "=&r" (tmp1),
+		       "+Q" (*((char *)dst))
+		     : "Q" (*((char __iomem *)fun_base))
+		     : "memory");
+#endif
+}
+
+int hisi_qm_wait_mb_ready(struct hisi_qm *qm)
+{
+	struct qm_mailbox mailbox;
+	int i = 0;
+
+	while (i++ < QM_MB_WAIT_READY_CNT) {
+		qm_mb_read(qm, &mailbox);
+		if (!((le16_to_cpu(mailbox.w0) >> QM_MB_BUSY_SHIFT) & 0x1))
+			return 0;
 
-	if (unlikely(hisi_qm_wait_mb_ready(qm))) {
-		dev_err(&qm->pdev->dev, "QM mailbox operation timeout!\n");
-		ret = -ETIMEDOUT;
-		goto mb_busy;
+		usleep_range(WAIT_PERIOD_US_MIN, WAIT_PERIOD_US_MAX);
 	}
 
-	val = readl(qm->io_base + QM_MB_CMD_SEND_BASE);
-	if (val & QM_MB_STATUS_MASK) {
+	dev_err(&qm->pdev->dev, "QM mailbox is busy to start!\n");
+
+	return -EBUSY;
+}
+EXPORT_SYMBOL_GPL(hisi_qm_wait_mb_ready);
+
+static int qm_wait_mb_finish(struct hisi_qm *qm, struct qm_mailbox *mailbox)
+{
+	int i = 0;
+
+	while (++i) {
+		qm_mb_read(qm, mailbox);
+		if (!((le16_to_cpu(mailbox->w0) >> QM_MB_BUSY_SHIFT) & 0x1))
+			break;
+
+		if (i == QM_MB_MAX_WAIT_CNT) {
+			dev_err(&qm->pdev->dev, "QM mailbox operation timeout!\n");
+			return -ETIMEDOUT;
+		}
+
+		usleep_range(WAIT_PERIOD_US_MIN, WAIT_PERIOD_US_MAX);
+	}
+
+	if (le16_to_cpu(mailbox->w0) & QM_MB_STATUS_MASK) {
 		dev_err(&qm->pdev->dev, "QM mailbox operation failed!\n");
-		ret = -EIO;
-		goto mb_busy;
+		return -EIO;
 	}
 
 	return 0;
+}
+
+static int qm_mb_nolock(struct hisi_qm *qm, struct qm_mailbox *mailbox)
+{
+	int ret;
+
+	ret = hisi_qm_wait_mb_ready(qm);
+	if (ret)
+		goto mb_err_cnt_increase;
+
+	qm_mb_write(qm, mailbox);
 
-mb_busy:
+	ret = qm_wait_mb_finish(qm, mailbox);
+	if (ret)
+		goto mb_err_cnt_increase;
+
+	return 0;
+
+mb_err_cnt_increase:
 	atomic64_inc(&qm->debug.dfx.mb_err_cnt);
 	return ret;
 }
@@ -687,6 +736,24 @@ int hisi_qm_mb(struct hisi_qm *qm, u8 cmd, dma_addr_t dma_addr, u16 queue,
 }
 EXPORT_SYMBOL_GPL(hisi_qm_mb);
 
+static int hisi_qm_mb_read(struct hisi_qm *qm, u64 *base, u8 cmd, u16 queue)
+{
+	struct qm_mailbox mailbox;
+	int ret;
+
+	qm_mb_pre_init(&mailbox, cmd, 0, queue, 1);
+	mutex_lock(&qm->mailbox_lock);
+	ret = qm_mb_nolock(qm, &mailbox);
+	mutex_unlock(&qm->mailbox_lock);
+	if (ret)
+		return ret;
+
+	*base = le32_to_cpu(mailbox.base_l) |
+		((u64)le32_to_cpu(mailbox.base_h) << 32);
+
+	return 0;
+}
+
 static void qm_db_v1(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
 {
 	u64 doorbell;
@@ -1308,12 +1375,10 @@ static int qm_get_vft_v2(struct hisi_qm *qm, u32 *base, u32 *number)
 	u64 sqc_vft;
 	int ret;
 
-	ret = hisi_qm_mb(qm, QM_MB_CMD_SQC_VFT_V2, 0, 0, 1);
+	ret = hisi_qm_mb_read(qm, &sqc_vft, QM_MB_CMD_SQC_VFT_V2, 0);
 	if (ret)
 		return ret;
 
-	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
-		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) << 32);
 	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
 	*number = (QM_SQC_VFT_NUM_MASK_V2 &
 		   (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
@@ -1484,25 +1549,6 @@ static enum acc_err_result qm_hw_error_handle_v2(struct hisi_qm *qm)
 	return ACC_ERR_RECOVERED;
 }
 
-static int qm_get_mb_cmd(struct hisi_qm *qm, u64 *msg, u16 fun_num)
-{
-	struct qm_mailbox mailbox;
-	int ret;
-
-	qm_mb_pre_init(&mailbox, QM_MB_CMD_DST, 0, fun_num, 0);
-	mutex_lock(&qm->mailbox_lock);
-	ret = qm_mb_nolock(qm, &mailbox);
-	if (ret)
-		goto err_unlock;
-
-	*msg = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
-		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) << 32);
-
-err_unlock:
-	mutex_unlock(&qm->mailbox_lock);
-	return ret;
-}
-
 static void qm_clear_cmd_interrupt(struct hisi_qm *qm, u64 vf_mask)
 {
 	u32 val;
@@ -1522,7 +1568,7 @@ static void qm_handle_vf_msg(struct hisi_qm *qm, u32 vf_id)
 	u64 msg;
 	int ret;
 
-	ret = qm_get_mb_cmd(qm, &msg, vf_id);
+	ret = hisi_qm_mb_read(qm, &msg, QM_MB_CMD_DST, vf_id);
 	if (ret) {
 		dev_err(dev, "failed to get msg from VF(%u)!\n", vf_id);
 		return;
@@ -4755,7 +4801,7 @@ static int qm_wait_pf_reset_finish(struct hisi_qm *qm)
 	 * Whether message is got successfully,
 	 * VF needs to ack PF by clearing the interrupt.
 	 */
-	ret = qm_get_mb_cmd(qm, &msg, 0);
+	ret = hisi_qm_mb_read(qm, &msg, QM_MB_CMD_DST, 0);
 	qm_clear_cmd_interrupt(qm, 0);
 	if (ret) {
 		dev_err(dev, "failed to get msg from PF in reset done!\n");
@@ -4809,7 +4855,7 @@ static void qm_handle_cmd_msg(struct hisi_qm *qm, u32 fun_num)
 	 * Get the msg from source by sending mailbox. Whether message is got
 	 * successfully, destination needs to ack source by clearing the interrupt.
 	 */
-	ret = qm_get_mb_cmd(qm, &msg, fun_num);
+	ret = hisi_qm_mb_read(qm, &msg, QM_MB_CMD_DST, fun_num);
 	qm_clear_cmd_interrupt(qm, BIT(fun_num));
 	if (ret) {
 		dev_err(dev, "failed to get msg from source!\n");
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 39fbfb4be944..0f83c19a8f36 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -52,7 +52,6 @@
 #define QM_MB_OP_SHIFT			14
 #define QM_MB_CMD_DATA_ADDR_L		0x304
 #define QM_MB_CMD_DATA_ADDR_H		0x308
-#define QM_MB_MAX_WAIT_CNT		6000
 
 /* doorbell */
 #define QM_DOORBELL_CMD_SQ              0
-- 
2.33.0

