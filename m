Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234977C7C58
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjJMDwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMDwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:52:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E825B7;
        Thu, 12 Oct 2023 20:52:50 -0700 (PDT)
Received: from kwepemm000005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S6CCF1dmTzvPxs;
        Fri, 13 Oct 2023 11:48:09 +0800 (CST)
Received: from huawei.com (10.50.163.32) by kwepemm000005.china.huawei.com
 (7.193.23.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 13 Oct
 2023 11:52:47 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/qm - fix EQ/AEQ interrupt issue
Date:   Fri, 13 Oct 2023 11:49:57 +0800
Message-ID: <20231013034957.28311-1-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000005.china.huawei.com (7.193.23.27)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hisilicon accelerator live migration operation. In order to
prevent the problem of EQ/AEQ interrupt loss. Migration driver will
trigger an EQ/AEQ doorbell at the end of the migration.

This operation may cause double interruption of EQ/AEQ events.
To ensure that the EQ/AEQ interrupt processing function is normal.
The interrupt handling functionality of EQ/AEQ needs to be updated.
Used to handle repeated interrupts event.

Fixes: b0eed085903e ("hisi_acc_vfio_pci: Add support for VFIO live migration")
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/qm.c | 105 +++++++++++++---------------------
 include/linux/hisi_acc_qm.h   |   1 +
 2 files changed, 41 insertions(+), 65 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index f3b55c044dd3..c12dedcd6bba 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -854,47 +854,15 @@ static void qm_poll_req_cb(struct hisi_qp *qp)
 	qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ, qp->qp_status.cq_head, 1);
 }
 
-static int qm_get_complete_eqe_num(struct hisi_qm_poll_data *poll_data)
-{
-	struct hisi_qm *qm = poll_data->qm;
-	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	u16 eq_depth = qm->eq_depth;
-	int eqe_num = 0;
-	u16 cqn;
-
-	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
-		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-		poll_data->qp_finish_id[eqe_num] = cqn;
-		eqe_num++;
-
-		if (qm->status.eq_head == eq_depth - 1) {
-			qm->status.eqc_phase = !qm->status.eqc_phase;
-			eqe = qm->eqe;
-			qm->status.eq_head = 0;
-		} else {
-			eqe++;
-			qm->status.eq_head++;
-		}
-
-		if (eqe_num == (eq_depth >> 1) - 1)
-			break;
-	}
-
-	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
-
-	return eqe_num;
-}
-
 static void qm_work_process(struct work_struct *work)
 {
 	struct hisi_qm_poll_data *poll_data =
 		container_of(work, struct hisi_qm_poll_data, work);
 	struct hisi_qm *qm = poll_data->qm;
+	u16 eqe_num = poll_data->eqe_num;
 	struct hisi_qp *qp;
-	int eqe_num, i;
+	int i;
 
-	/* Get qp id of completed tasks and re-enable the interrupt. */
-	eqe_num = qm_get_complete_eqe_num(poll_data);
 	for (i = eqe_num - 1; i >= 0; i--) {
 		qp = &qm->qp_array[poll_data->qp_finish_id[i]];
 		if (unlikely(atomic_read(&qp->qp_status.flags) == QP_STOP))
@@ -910,39 +878,55 @@ static void qm_work_process(struct work_struct *work)
 	}
 }
 
-static bool do_qm_eq_irq(struct hisi_qm *qm)
+static void qm_get_complete_eqe_num(struct hisi_qm *qm)
 {
 	struct qm_eqe *eqe = qm->eqe + qm->status.eq_head;
-	struct hisi_qm_poll_data *poll_data;
-	u16 cqn;
+	struct hisi_qm_poll_data *poll_data = NULL;
+	u16 eq_depth = qm->eq_depth;
+	u16 cqn, eqe_num = 0;
 
-	if (!readl(qm->io_base + QM_VF_EQ_INT_SOURCE))
-		return false;
+	if (QM_EQE_PHASE(eqe) != qm->status.eqc_phase) {
+		atomic64_inc(&qm->debug.dfx.err_irq_cnt);
+		qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+		return;
+	}
 
-	if (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
+	cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
+	if (unlikely(cqn >= qm->qp_num))
+		return;
+	poll_data = &qm->poll_data[cqn];
+
+	while (QM_EQE_PHASE(eqe) == qm->status.eqc_phase) {
 		cqn = le32_to_cpu(eqe->dw0) & QM_EQE_CQN_MASK;
-		poll_data = &qm->poll_data[cqn];
-		queue_work(qm->wq, &poll_data->work);
+		poll_data->qp_finish_id[eqe_num] = cqn;
+		eqe_num++;
+
+		if (qm->status.eq_head == eq_depth - 1) {
+			qm->status.eqc_phase = !qm->status.eqc_phase;
+			eqe = qm->eqe;
+			qm->status.eq_head = 0;
+		} else {
+			eqe++;
+			qm->status.eq_head++;
+		}
 
-		return true;
+		if (eqe_num == (eq_depth >> 1) - 1)
+			break;
 	}
 
-	return false;
+	poll_data->eqe_num = eqe_num;
+	queue_work(qm->wq, &poll_data->work);
+	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
 }
 
 static irqreturn_t qm_eq_irq(int irq, void *data)
 {
 	struct hisi_qm *qm = data;
-	bool ret;
-
-	ret = do_qm_eq_irq(qm);
-	if (ret)
-		return IRQ_HANDLED;
 
-	atomic64_inc(&qm->debug.dfx.err_irq_cnt);
-	qm_db(qm, 0, QM_DOORBELL_CMD_EQ, qm->status.eq_head, 0);
+	/* Get qp id of completed tasks and re-enable the interrupt */
+	qm_get_complete_eqe_num(qm);
 
-	return IRQ_NONE;
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t qm_mb_cmd_irq(int irq, void *data)
@@ -1024,6 +1008,8 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	u16 aeq_depth = qm->aeq_depth;
 	u32 type, qp_id;
 
+	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
+
 	while (QM_AEQE_PHASE(aeqe) == qm->status.aeqc_phase) {
 		type = (le32_to_cpu(aeqe->dw0) >> QM_AEQE_TYPE_SHIFT) &
 			QM_AEQE_TYPE_MASK;
@@ -1062,17 +1048,6 @@ static irqreturn_t qm_aeq_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t qm_aeq_irq(int irq, void *data)
-{
-	struct hisi_qm *qm = data;
-
-	atomic64_inc(&qm->debug.dfx.aeq_irq_cnt);
-	if (!readl(qm->io_base + QM_VF_AEQ_INT_SOURCE))
-		return IRQ_NONE;
-
-	return IRQ_WAKE_THREAD;
-}
-
 static void qm_init_qp_status(struct hisi_qp *qp)
 {
 	struct hisi_qp_status *qp_status = &qp->qp_status;
@@ -4997,8 +4972,8 @@ static int qm_register_aeq_irq(struct hisi_qm *qm)
 		return 0;
 
 	irq_vector = val & QM_IRQ_VECTOR_MASK;
-	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), qm_aeq_irq,
-						   qm_aeq_thread, 0, qm->dev_name, qm);
+	ret = request_threaded_irq(pci_irq_vector(pdev, irq_vector), NULL,
+						   qm_aeq_thread, IRQF_ONESHOT, qm->dev_name, qm);
 	if (ret)
 		dev_err(&pdev->dev, "failed to request eq irq, ret = %d", ret);
 
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 34c64a02712c..369206363569 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -276,6 +276,7 @@ struct hisi_qm_poll_data {
 	struct hisi_qm *qm;
 	struct work_struct work;
 	u16 *qp_finish_id;
+	u16 eqe_num;
 };
 
 /**
-- 
2.24.0

