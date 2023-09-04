Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346787919E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbjIDOoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjIDOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 10:43:57 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE41CFB;
        Mon,  4 Sep 2023 07:43:53 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384AhChY001821;
        Mon, 4 Sep 2023 07:43:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=af+8YGkglH8w4EbypmhBL4+TD5KHgfrltyX7odw8BMU=;
 b=Wcl5NkCvTjOwYc3i3mDg5xncEnXYrMzQJXWUG9XUEJGnjhIaq/t2l3Nf8vg+O+I5Mo6K
 z3qsaK6yTLjE94yoVJy3R0CnjH76fgmwvXaLb0kdqxfvhR9P7j0ayJ38AB9bVXljBGhZ
 okN2EGy2S1U6RZ/VByGIu8oAzrykWK8Uk5Ni+I98/9iNvhQ1sUVi19ppMV1hOBndcb8q
 4MFPVznzAWhxH8RzL1a1gchxl8vqkLDLJPg/WdGHYYFRKcKQYpRTLRUNmvL1CiGrxsaC
 fTW4Lv+7jrJJs2x19S8ulAuNWNjKdRq7q0ulMtEAb2TS5R0QVVW082bYGPlCPfvL2yyz Pw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3swdqygpk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 07:43:12 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 4 Sep
 2023 07:43:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 4 Sep 2023 07:43:10 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id 47ECE3F7062;
        Mon,  4 Sep 2023 07:43:06 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <rkannoth@marvell.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>, <bigeasy@linutronix.de>
Subject: [PATCH net] octeontx2-pf: Fix page pool cache index corruption.
Date:   Mon, 4 Sep 2023 20:13:04 +0530
Message-ID: <20230904144304.3280804-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Dnju9oP474xHhMz6Q0WrL0eIO5YANR_b
X-Proofpoint-ORIG-GUID: Dnju9oP474xHhMz6Q0WrL0eIO5YANR_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To fix this issue, worqueue is removed. If refilling fails in NAPI
context, same NAPI is rescheduled with a delay to redo the filling
of rx buffers.

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  5 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |  2 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 59 -------------------
 .../marvell/octeontx2/nic/otx2_common.h       |  3 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  5 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 23 ++++++--
 .../marvell/octeontx2/nic/otx2_txrx.h         |  5 +-
 7 files changed, 27 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k.c
index 826f691de259..026698a78f77 100644
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
@@ -131,6 +132,8 @@ void cn10k_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 			num_ptrs = 1;
 		}
 	}
+
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
index 8511906cb4e2..d44f88ece544 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -575,17 +575,6 @@ int otx2_alloc_buffer(struct otx2_nic *pfvf, struct otx2_cq_queue *cq,
 		      dma_addr_t *dma)
 {
 	if (unlikely(__otx2_alloc_rbuf(pfvf, cq->rbpool, dma))) {
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
 		return -ENOMEM;
 	}
 	return 0;
@@ -1037,7 +1026,6 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 	pool_id = ((cq->cq_type == CQ_RX) &&
 		   (pfvf->hw.rqpool_cnt != pfvf->hw.rx_queues)) ? 0 : qidx;
 	cq->rbpool = &qset->pool[pool_id];
-	cq->refill_task_sched = false;
 
 	/* Get memory to put this msg */
 	aq = otx2_mbox_alloc_msg_nix_aq_enq(&pfvf->mbox);
@@ -1079,43 +1067,6 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 	return otx2_sync_mbox_msg(&pfvf->mbox);
 }
 
-static void otx2_pool_refill_task(struct work_struct *work)
-{
-	struct otx2_cq_queue *cq;
-	struct otx2_pool *rbpool;
-	struct refill_work *wrk;
-	int qidx, free_ptrs = 0;
-	struct otx2_nic *pfvf;
-	dma_addr_t bufptr;
-
-	wrk = container_of(work, struct refill_work, pool_refill_work.work);
-	pfvf = wrk->pf;
-	qidx = wrk - pfvf->refill_wrk;
-	cq = &pfvf->qset.cq[qidx];
-	rbpool = cq->rbpool;
-	free_ptrs = cq->pool_ptrs;
-
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
-	cq->refill_task_sched = false;
-}
 
 int otx2_config_nix_queues(struct otx2_nic *pfvf)
 {
@@ -1149,17 +1100,7 @@ int otx2_config_nix_queues(struct otx2_nic *pfvf)
 	pfvf->cq_op_addr = (__force u64 *)otx2_get_regaddr(pfvf,
 							   NIX_LF_CQ_OP_STATUS);
 
-	/* Initialize work queue for receive buffer refill */
-	pfvf->refill_wrk = devm_kcalloc(pfvf->dev, pfvf->qset.cq_cnt,
-					sizeof(struct refill_work), GFP_KERNEL);
-	if (!pfvf->refill_wrk)
-		return -ENOMEM;
 
-	for (qidx = 0; qidx < pfvf->qset.cq_cnt; qidx++) {
-		pfvf->refill_wrk[qidx].pf = pfvf;
-		INIT_DELAYED_WORK(&pfvf->refill_wrk[qidx].pool_refill_work,
-				  otx2_pool_refill_task);
-	}
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 4c6032ee7800..01e2d35ce1e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -370,7 +370,7 @@ struct dev_hw_ops {
 	int	(*sq_aq_init)(void *dev, u16 qidx, u16 sqb_aura);
 	void	(*sqe_flush)(void *dev, struct otx2_snd_queue *sq,
 			     int size, int qidx);
-	void	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
+	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 };
 
@@ -493,7 +493,6 @@ struct otx2_nic {
 	struct work_struct	reset_task;
 	struct workqueue_struct	*flr_wq;
 	struct flr_work		*flr_wrk;
-	struct refill_work	*refill_wrk;
 	struct workqueue_struct	*otx2_wq;
 	struct work_struct	rx_mode_work;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 70b9065f7d10..c5a6d0e4e157 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1902,7 +1902,7 @@ int otx2_stop(struct net_device *netdev)
 	struct otx2_cq_poll *cq_poll = NULL;
 	struct otx2_qset *qset = &pf->qset;
 	struct otx2_rss_info *rss;
-	int qidx, vec, wrk;
+	int qidx, vec;
 
 	/* If the DOWN flag is set resources are already freed */
 	if (pf->flags & OTX2_FLAG_INTF_DOWN)
@@ -1950,9 +1950,6 @@ int otx2_stop(struct net_device *netdev)
 	for (qidx = 0; qidx < netdev->num_tx_queues; qidx++)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, qidx));
 
-	for (wrk = 0; wrk < pf->qset.cq_cnt; wrk++)
-		cancel_delayed_work_sync(&pf->refill_wrk[wrk].pool_refill_work);
-	devm_kfree(pf->dev, pf->refill_wrk);
 
 	kfree(qset->sq);
 	kfree(qset->cq);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index e369baf11530..cf2e631af58b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -424,10 +424,11 @@ static int otx2_rx_napi_handler(struct otx2_nic *pfvf,
 	return processed_cqe;
 }
 
-void otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
+int otx2_refill_pool_ptrs(void *dev, struct otx2_cq_queue *cq)
 {
 	struct otx2_nic *pfvf = dev;
 	dma_addr_t bufptr;
+	int cnt = cq->pool_ptrs;
 
 	while (cq->pool_ptrs) {
 		if (otx2_alloc_buffer(pfvf, cq, &bufptr))
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
@@ -541,7 +545,8 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 	}
 
 	if (rx_cq && rx_cq->pool_ptrs)
-		pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
+		filled_cnt = pfvf->hw_ops->refill_pool_ptrs(pfvf, rx_cq);
+
 	/* Clear the IRQ */
 	otx2_write64(pfvf, NIX_LF_CINTX_INT(cq_poll->cint_idx), BIT_ULL(0));
 
@@ -561,10 +566,18 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
 				otx2_config_irq_coalescing(pfvf, i);
 		}
 
-		/* Re-enable interrupts */
-		otx2_write64(pfvf, NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
-			     BIT_ULL(0));
+		/* Schedule NAPI again to refill rx buffers */
+		if (unlikely(!filled_cnt)) {
+			udelay(1000);
+			napi_schedule(napi);
+		} else {
+			/* Re-enable interrupts */
+			otx2_write64(pfvf,
+				     NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
+				     BIT_ULL(0));
+		}
 	}
+
 	return workdone;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 9e3bfbe5c480..bb718c7ad8f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -128,7 +128,6 @@ struct otx2_cq_queue {
 	u8			cq_idx;
 	u8			cq_type;
 	u8			cint_idx; /* CQ interrupt id */
-	u8			refill_task_sched;
 	u16			cqe_size;
 	u16			pool_ptrs;
 	u32			cqe_cnt;
@@ -170,6 +169,6 @@ void cn10k_sqe_flush(void *dev, struct otx2_snd_queue *sq,
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

