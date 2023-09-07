Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD94E796EA9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbjIGBsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 21:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGBr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 21:47:59 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0E133;
        Wed,  6 Sep 2023 18:47:54 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386Hr2aU002406;
        Wed, 6 Sep 2023 18:47:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=qN1pEcIQ5sTFzWnsvKIJUxtk03Ha45iAVcUPOgTKH3w=;
 b=QkKH22nXvpHX0HnKArJ9R/ingvX79g+u9tyefvQQyZI0LeXuaF93a6rPwZkHAzJgUjx7
 qIvKuagFSouZLuTlvA6Vj6TRnf53LnSuuoUjaCXEvAozpEiaSH6yy4KBnI25Pm8Ko3kE
 r7LB9tDEgz9JNayetJIptjrmIyjzX+d1oUn8FXm5srTb6twsxIe5dc3WdxIRNP1h2EQA
 a6qRihWL/7Wvmrq44cxG/pf7roMQ/EbvIyDf+zeBffTry8xS1Sf9DXwml1VSa541eGSK
 Eh/Jqu+uLAS3g8wyoXuNYdbrEFYSabL6CGoyU04zBwH5/e5+oW9O71YaXJC6ndGsAfAY 5Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sv4jkh8kt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 18:47:22 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Sep
 2023 18:47:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 6 Sep 2023 18:47:19 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id ECA023F705A;
        Wed,  6 Sep 2023 18:47:13 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <rkannoth@marvell.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>, <bigeasy@linutronix.de>
Subject: [PATCH net v2] octeontx2-pf: Fix page pool cache index corruption.
Date:   Thu, 7 Sep 2023 07:17:11 +0530
Message-ID: <20230907014711.3869840-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: nqRUJk66d6zTLDweMCTVTkzVqqKl3zoz
X-Proofpoint-ORIG-GUID: nqRUJk66d6zTLDweMCTVTkzVqqKl3zoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The access to page pool `cache' array and the `count' variable
is not locked. Page pool cache access is fine as long as there
is only one consumer per pool.

octeontx2 driver fills in rx buffers from page pool in NAPI context.
If system is stressed and could not allocate buffers, refiiling work
will be delegated to a delayed workqueue. This means that there are
two cosumers to the page pool cache.

Either workqueue or IRQ/NAPI can be run on other CPU. This will lead
to lock less access, hence corruption of cache pool indexes.

To fix this issue, NAPI is rescheduled from workqueue context to refill
rx buffers.

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
ChangeLogs
v1 -> v2: Added local_bh_disable() to be precise on napi scheduling.

v0 -> v1: udelay will waste CPU cycles in UP. So call napi_schedule from
	  delayed work queue context.

---
---
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |  2 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 43 +++----------------
 .../marvell/octeontx2/nic/otx2_common.h       |  3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  7 +--
 .../marvell/octeontx2/nic/otx2_txrx.c         | 29 ++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |  4 +-
 7 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 826f691de259..211c7d8a0556 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
@@ -107,12 +107,13 @@ int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura)
 }
 
 #define NPA_MAX_BURST 16
-void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
+int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 {
 	struct otx2_nic *pfvf = dev;
 	u64 ptrs[NPA_MAX_BURST];
 	int num_ptrs = 1;
 	dma_addr_t bufptr;
+	int cnt = cq->pool_ptrs;
 
 	/* Refill pool with new buffers */
 	while (cq->pool_ptrs) {
@@ -131,6 +132,7 @@ void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 			num_ptrs = 1;
 		}
 	}
+	return cnt - cq->pool_ptrs;
 }
 
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq, int size, int qidx)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
index 8ae96815865e..c1861f7de254 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.h
@@ -24,7 +24,7 @@ static inline int mtu_to_dwrr_weight(struct otx2_nic *pfvf, int mtu)
 	return weight;
 }
 
-void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
+int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
 void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq, int size, int qidx);
 int cn10k_sq_aq_init(void *dev, u16 qidx, u16 sqb_aura);
 int cn10k_lmtst_init(struct otx2_nic *pfvf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 8511906cb4e2..997fedac3a98 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -574,20 +574,8 @@ int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
 int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma)
 {
-	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma))) {
-		struct refill_work *work;
-		struct delayed_work *dwork;
-
-		work = &pfvf->refill_wrk[cq->cq_idx];
-		dwork = &work->pool_refill_work;
-		/* Schedule a task if no other task is running */
-		if (!cq->refill_task_sched) {
-			cq->refill_task_sched = true;
-			schedule_delayed_work(dwork,
-					      msecs_to_jiffies(100));
-		}
+	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma)))
 		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -1082,39 +1070,20 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 static void otx2_pool_refill_task(struct work_struct *work)
 {
 	struct otx2_cq_queue *cq;
-	struct otx2_pool *rbpool;
 	struct refill_work *wrk;
-	int qidx, free_ptrs = 0;
 	struct otx2_nic *pfvf;
-	dma_addr_t bufptr;
+	int qidx;
 
 	wrk = container_of(work, struct refill_work, pool_refill_work.work);
 	pfvf = wrk->pf;
 	qidx = wrk - pfvf->refill_wrk;
 	cq = &pfvf->qset.cq[qidx];
-	rbpool = cq->rbpool;
-	free_ptrs = cq->pool_ptrs;
 
-	while (cq->pool_ptrs) {
-		if (otx2_alloc_rbuf(pfvf, rbpool, &bufptr)) {
-			/* Schedule a WQ if we fails to free atleast half of the
-			 * pointers else enable napi for this RQ.
-			 */
-			if (!((free_ptrs - cq->pool_ptrs) > free_ptrs / 2)) {
-				struct delayed_work *dwork;
-
-				dwork = &wrk->pool_refill_work;
-				schedule_delayed_work(dwork,
-						      msecs_to_jiffies(100));
-			} else {
-				cq->refill_task_sched = false;
-			}
-			return;
-		}
-		pfvf->hw_ops->aura_freeptr(pfvf, qidx, bufptr + OTX2_HEAD_ROOM);
-		cq->pool_ptrs--;
-	}
 	cq->refill_task_sched = false;
+
+	local_bh_disable();
+	napi_schedule(wrk->napi);
+	local_bh_enable();
 }
 
 int otx2_config_nix_queues(struct otx2_nic *pfvf)
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 4c6032ee7800..c04a8ee53a82 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -302,6 +302,7 @@ struct flr_work {
 struct refill_work {
 	struct delayed_work pool_refill_work;
 	struct otx2_nic *pf;
+	struct napi_struct *napi;
 };
 
 /* PTPv2 originTimestamp structure */
@@ -370,7 +371,7 @@ struct dev_hw_ops {
 	int	(*sq_aq_init)(void *dev, u16 qidx, u16 sqb_aura);
 	void	(*sqe_flush)(void *dev, struct otx2_snd_queue *sq,
 			     int size, int qidx);
-	void	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
+	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 70b9065f7d10..6daf4d58c25d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1943,6 +1943,10 @@ int otx2_stop(struct net_device *netdev)
 
 	netif_tx_disable(netdev);
 
+	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
+		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
+	devm_kfree(pf->dev, pf->refill_wrk);
+
 	otx2_free_hw_resources(pf);
 	otx2_free_cints(pf, pf->hw.cint_cnt);
 	otx2_disable_napi(pf);
@@ -1950,9 +1954,6 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
-	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
-		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
-	devm_kfree(pf->dev, pf->refill_wrk);
 
 	kfree(qset->sq);
 	kfree(qset->cq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index e369baf11530..b778ed366f81 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -424,9 +424,10 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 	return processed_cqe;
 }
 
-void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
+int otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 {
 	struct otx2_nic *pfvf = dev;
+	int cnt = cq->pool_ptrs;
 	dma_addr_t bufptr;
 
 	while (cq->pool_ptrs) {
@@ -435,6 +436,8 @@ void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 		otx2_aura_freeptr(pfvf, cq->cq_idx, bufptr + OTX2_HEAD_ROOM);
 		cq->pool_ptrs--;
 	}
+
+	return cnt - cq->pool_ptrs;
 }
 
 static int otx2_tx_napi_handler(struct otx2_nic *pfvf,
@@ -521,6 +524,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	struct otx2_cq_queue *cq;
 	struct otx2_qset *qset;
 	struct otx2_nic *pfvf;
+	int filled_cnt = -1;
 
 	cq_poll = container_of(napi, struct otx2_cq_poll, napi);
 	pfvf = (struct otx2_nic *)cq_poll->dev;
@@ -541,7 +545,7 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	}
 
 	if (rx_cq && rx_cq->pool_ptrs)
-		pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
+		filled_cnt = pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
 	/* Clear the IRQ */
 	otx2_write64(pfvf, NIX_LF_CINTX_INT(cq_poll->cint_idx), BIT_ULL(0));
 
@@ -561,9 +565,24 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 				otx2_config_irq_coalescing(pfvf, i);
 		}
 
-		/* Re-enable interrupts */
-		otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
-			     BIT_ULL(0));
+		if (unlikely(!filled_cnt)) {
+			struct refill_work *work;
+			struct delayed_work *dwork;
+
+			work = &pfvf->refill_wrk[cq->cq_idx];
+			dwork = &work->pool_refill_work;
+			/* Schedule a task if no other task is running */
+			if (!cq->refill_task_sched) {
+				work->napi = napi;
+				cq->refill_task_sched = true;
+				schedule_delayed_work(dwork,
+						      msecs_to_jiffies(100));
+			}
+		} else {
+			/* Re-enable interrupts */
+			otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
+				     BIT_ULL(0));
+		}
 	}
 	return workdone;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 9e3bfbe5c480..a82ffca8ce1b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -170,6 +170,6 @@ void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		     int size, int qidx);
 void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 		    int size, int qidx);
-void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
-void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
+int otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
+int cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq);
 #endif /* OTX2_TXRX_H */
-- 
2.25.1

