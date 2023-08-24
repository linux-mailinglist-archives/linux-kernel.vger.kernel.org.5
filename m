Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39F9787217
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbjHXOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbjHXOpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:45:24 -0400
Received: from out-17.mta1.migadu.com (out-17.mta1.migadu.com [IPv6:2001:41d0:203:375::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4851BC5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:45:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692888321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNMIjrcjjgLtOR47Ivp/pWFjvTNQF2gw34heMee5wC0=;
        b=szAF17CsZXJ3rsgIWhZDvvPDDCZ+0LKs7QcffukGw3yP+NwTajtWYV5l9u1BFdXMTMcrvC
        PTN43prCMhw1klaOb0ULkbBxn9i+FefrzJdRNDCJ/sBDGSe1d+N5IErcpX1IeVTTSDHj0Z
        k4Ak3o63jDl+d48mHBU+euzjOgnFCVs=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 4/6] blk-mq: update driver tags request table when start request
Date:   Thu, 24 Aug 2023 22:44:01 +0800
Message-ID: <20230824144403.2135739-5-chengming.zhou@linux.dev>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Now we update driver tags request table in blk_mq_get_driver_tag(),
so the driver that support queue_rqs() have to update that inflight
table by itself.

Move it to blk_mq_start_request(), which is a better place where
we setup the deadline for request timeout check. And it's just
where the request becomes inflight.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c             | 1 +
 block/blk-mq.h             | 3 ---
 drivers/block/virtio_blk.c | 2 --
 drivers/nvme/host/pci.c    | 1 -
 4 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 44595385b34c..ff1b0f3ab3a8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1259,6 +1259,7 @@ void blk_mq_start_request(struct request *rq)
 
 	blk_add_timer(rq);
 	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
+	rq->mq_hctx->tags->rqs[rq->tag] = rq;
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (blk_integrity_rq(rq) && req_op(rq) == REQ_OP_WRITE)
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 560a76df290a..f75a9ecfebde 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -351,12 +351,9 @@ bool __blk_mq_alloc_driver_tag(struct request *rq);
 
 static inline bool blk_mq_get_driver_tag(struct request *rq)
 {
-	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
-
 	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_alloc_driver_tag(rq))
 		return false;
 
-	hctx->tags->rqs[rq->tag] = rq;
 	return true;
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 1fe011676d07..4689ac2e0c0e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -470,8 +470,6 @@ static bool virtblk_prep_rq_batch(struct request *req)
 	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 
-	req->mq_hctx->tags->rqs[req->tag] = req;
-
 	return virtblk_prep_rq(req->mq_hctx, vblk, req, vbr) == BLK_STS_OK;
 }
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d983..c2e942808eff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -924,7 +924,6 @@ static bool nvme_prep_rq_batch(struct nvme_queue *nvmeq, struct request *req)
 	if (unlikely(!nvme_check_ready(&nvmeq->dev->ctrl, req, true)))
 		return false;
 
-	req->mq_hctx->tags->rqs[req->tag] = req;
 	return nvme_prep_rq(nvmeq->dev, req) == BLK_STS_OK;
 }
 
-- 
2.41.0

