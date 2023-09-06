Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6D6793429
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 05:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbjIFDj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 23:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIFDj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 23:39:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E89128;
        Tue,  5 Sep 2023 20:39:54 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385NhV02012985;
        Tue, 5 Sep 2023 20:39:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=rgGv5kuy2iFnE1JoNQJAtscTIUIlgSOWXayJEb6MuL8=;
 b=cARKjHVJwYdi3U6UU7w1pTnLYl55lMwDyIFleckLRu9NOzlurhzl6U7MvJOcgKmMCQ9O
 EfBkoeEz2LmvynmjCNwQpg1dLQhU2seqvkr9xTE9EJfAzNXuUDWXqSbH3fAdLoKb10N5
 MJ+yIsN54c7u+KYRMotoORMZsKaZgoC1YVvIpPwWzCqScPebWofoiXz+3aDPmSqmB40H
 jC3dahJI+wTvNf9rSzUWp8kAw9pTzvX47lSab2xw1Ghj8ODll751es+QoOQq3qQvrrfz
 yBSv5Xtf5Osb2EH8nHAcT7bcQlZabTDc0yXlfNUprJHLquMIxDO1h6QzwgW/G8oNqLXe 8Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sv4jkcmn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 20:39:35 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 5 Sep
 2023 20:39:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 5 Sep 2023 20:39:33 -0700
Received: from marvell-OptiPlex-7090.marvell.com (unknown [10.28.36.165])
        by maili.marvell.com (Postfix) with ESMTP id E6A893F704B;
        Tue,  5 Sep 2023 20:39:28 -0700 (PDT)
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <rkannoth@marvell.com>, <hawk@kernel.org>,
        <alexander.duyck@gmail.com>, <ilias.apalodimas@linaro.org>,
        <linyunsheng@huawei.com>, <bigeasy@linutronix.de>
Subject: [PATCH net v1] octeontx2-pf: Fix page pool cache index corruption.
Date:   Wed, 6 Sep 2023 09:09:26 +0530
Message-ID: <20230906033926.3663659-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cZ7YFGogBDntG-GSqjiG37vBKBeEpCSh
X-Proofpoint-ORIG-GUID: cZ7YFGogBDntG-GSqjiG37vBKBeEpCSh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
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

To fix this issue, NAP is rescheduled from workqueue context to refill
rx buffers.

Fixes: b2e3406a38f0 ("octeontx2-pf: Add support for page pool")
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
ChangeLogs
v0 -> v1: udelay will waste CPU cycles. So call napi_schedule from
	  delayed work queue context.
---
---
 .../ethernet/marvell/octeontx2/nic/cn10k.c    |  4 +-
 .../ethernet/marvell/octeontx2/nic/cn10k.h    |  2 +-
 .../marvell/octeontx2/nic/otx2_common.c       | 40 ++-----------------
 .../marvell/octeontx2/nic/otx2_common.h       |  3 +-
 .../marvell/octeontx2/nic/otx2_txrx.c         | 30 +++++++++++---
 .../marvell/octeontx2/nic/otx2_txrx.h         |  4 +-
 6 files changed, 36 insertions(+), 47 deletions(-)

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
index 8511906cb4e2..5bba1f34e4f6 100644
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
 
@@ -1082,38 +1070,16 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
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
+	napi_schedule(wrk->napi);
 	cq->refill_task_sched = false;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 4c6032ee7800..f6a6437fe169 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -301,6 +301,7 @@ struct flr_work {
 
 struct refill_work {
 	struct delayed_work pool_refill_work;
+	struct napi_struct *napi;
 	struct otx2_nic *pf;
 };
 
@@ -370,7 +371,7 @@ struct dev_hw_ops {
 	int	(*sq_aq_init)(void *dev, u16 qidx, u16 sqb_aura);
 	void	(*sqe_flush)(void *dev, struct otx2_snd_queue *sq,
 			     int size, int qidx);
-	void	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
+	int	(*refill_pool_ptrs)(void *dev, struct otx2_cq_queue *cq);
 	void	(*aura_freeptr)(void *dev, int aura, u64 buf);
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index e369baf11530..e77d43848955 100644
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
 
@@ -561,9 +565,25 @@ int otx2_napi_handler(struct napi_struct *napi, int budget)
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
+			otx2_write64(pfvf,
+				     NIX_LF_CINTX_ENA_W1S(cq_poll->cint_idx),
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

