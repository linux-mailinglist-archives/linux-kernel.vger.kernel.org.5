Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70977A75E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjHMPYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjHMPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:23:59 -0400
Received: from out-104.mta1.migadu.com (out-104.mta1.migadu.com [95.215.58.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463171708
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 08:23:58 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691940236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XkcqFUq2iQ+GDNeZzMw6CrBWy06VHbGuLcfVVf92S4A=;
        b=LK5FGwlCHvTui01VHknsB9SONJipEgvP9qTCUPmFzeaxlcoQqge/GnMinykRtbVcypZ27b
        dMxE1qwdLtR5TTMbgLlPgdYdUA0gCmx22s/7TlJPV5QwXLxvnWYpvWKrZbZwuMK7v2cKue
        6l0dxDk6TOW2qWatxbTbHfhGwg/6jkM=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, chuck.lever@oracle.com
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH v2] blk-mq: release scheduler resource when request complete
Date:   Sun, 13 Aug 2023 23:23:25 +0800
Message-ID: <20230813152325.3017343-1-chengming.zhou@linux.dev>
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

Chuck reported [1] a IO hang problem on NFS exports that reside on SATA
devices and bisected to commit 615939a2ae73 ("blk-mq: defer to the normal
submission path for post-flush requests").

We analysed the IO hang problem, found there are two postflush requests
are waiting for each other.

The first postflush request completed the REQ_FSEQ_DATA sequence, so go to
the REQ_FSEQ_POSTFLUSH sequence and added in the flush pending list, but
failed to blk_kick_flush() because of the second postflush request which
is inflight waiting in scheduler queue.

The second postflush waiting in scheduler queue can't be dispatched because
the first postflush hasn't released scheduler resource even though it has
completed by itself.

Fix it by releasing scheduler resource when the first postflush request
completed, so the second postflush can be dispatched and completed, then
make blk_kick_flush() succeed.

[1] https://lore.kernel.org/all/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/

Fixes: 615939a2ae73 ("blk-mq: defer to the normal submission path for post-flush requests")
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Tested-by: Chuck Lever <chuck.lever@oracle.com>
---
v2:
 - All IO schedulers do set ->finish_request(), so remove the
   check and warn on not setting when register.
---
 block/blk-mq.c   | 16 ++++++++++++----
 block/elevator.c |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f14b8669ac69..a8c63bef8ff1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -682,6 +682,14 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+static void blk_mq_finish_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+
+	if (rq->rq_flags & RQF_USE_SCHED)
+		q->elevator->type->ops.finish_request(rq);
+}
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -708,10 +716,6 @@ void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	if ((rq->rq_flags & RQF_USE_SCHED) &&
-	    q->elevator->type->ops.finish_request)
-		q->elevator->type->ops.finish_request(rq);
-
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
@@ -1021,6 +1025,8 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 	if (blk_mq_need_time_stamp(rq))
 		__blk_mq_end_request_acct(rq, ktime_get_ns());
 
+	blk_mq_finish_request(rq);
+
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
 		if (rq->end_io(rq, error) == RQ_END_IO_FREE)
@@ -1075,6 +1081,8 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
 
+		blk_mq_finish_request(rq);
+
 		rq_qos_done(rq->q, rq);
 
 		/*
diff --git a/block/elevator.c b/block/elevator.c
index 8400e303fbcb..ac2cb3814eac 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -499,6 +499,9 @@ void elv_unregister_queue(struct request_queue *q)
 
 int elv_register(struct elevator_type *e)
 {
+	if (WARN_ON_ONCE(!e->ops.finish_request))
+		return -EINVAL;
+
 	/* insert_requests and dispatch_request are mandatory */
 	if (WARN_ON_ONCE(!e->ops.insert_requests || !e->ops.dispatch_request))
 		return -EINVAL;
-- 
2.41.0

