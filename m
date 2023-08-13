Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A10477A68C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 15:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjHMNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHMNhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 09:37:15 -0400
Received: from out-98.mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7731713
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 06:37:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691933834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CG3IKy5ptWoRbG5i3l8taVt5iUnIz4LWywOlBGuYiKk=;
        b=UKGTjKuiCbOe/huG0X45azx1anraaVfPFyG77JpZlgcn9W3QDRylZmnHDMwQr+8GXf0mc3
        nOqKu2lhOc0pS1lBpUNsTVF8mW6xigBICTIl2PPvEWT2kNS95ZAix+5hwemas+sKpUwQMQ
        F6nQecGsWIkmgSaBGu17zSdDNZheNH4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, chuck.lever@oracle.com
Cc:     bvanassche@acm.org, cel@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH] blk-mq: release scheduler resource when request complete
Date:   Sun, 13 Aug 2023 21:36:43 +0800
Message-ID: <20230813133643.3006943-1-chengming.zhou@linux.dev>
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
 block/blk-mq.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f14b8669ac69..5b14f18f9670 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -682,6 +682,15 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_alloc_request_hctx);
 
+static void blk_mq_finish_request(struct request *rq)
+{
+	struct request_queue *q = rq->q;
+
+	if ((rq->rq_flags & RQF_USE_SCHED) &&
+	    q->elevator->type->ops.finish_request)
+		q->elevator->type->ops.finish_request(rq);
+}
+
 static void __blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
@@ -708,10 +717,6 @@ void blk_mq_free_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	if ((rq->rq_flags & RQF_USE_SCHED) &&
-	    q->elevator->type->ops.finish_request)
-		q->elevator->type->ops.finish_request(rq);
-
 	if (unlikely(laptop_mode && !blk_rq_is_passthrough(rq)))
 		laptop_io_completion(q->disk->bdi);
 
@@ -1021,6 +1026,8 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 	if (blk_mq_need_time_stamp(rq))
 		__blk_mq_end_request_acct(rq, ktime_get_ns());
 
+	blk_mq_finish_request(rq);
+
 	if (rq->end_io) {
 		rq_qos_done(rq->q, rq);
 		if (rq->end_io(rq, error) == RQ_END_IO_FREE)
@@ -1075,6 +1082,8 @@ void blk_mq_end_request_batch(struct io_comp_batch *iob)
 		if (iob->need_ts)
 			__blk_mq_end_request_acct(rq, now);
 
+		blk_mq_finish_request(rq);
+
 		rq_qos_done(rq->q, rq);
 
 		/*
-- 
2.41.0

