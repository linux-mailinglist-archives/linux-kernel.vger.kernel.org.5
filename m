Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC7E7619A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjGYNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjGYNTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:12 -0400
Received: from out-51.mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE0173B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:19:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690291143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMRjU4cz+GWWgAQcR8jyEbZWLfFxQN9dbiOOgRzcy7Q=;
        b=o0QLFYhhnAKVPgEuwksv90YzlrU3SZDj1gKO8UX5Zp2fr5dHEDB+NhvBCQhO80EseFtGx1
        ojhQ2JJTZEnpq2r6H5gTEZqAL5C4GGXMbHGD5Txk/k00Xy7sjh/tYn7YdFvkD9w1vamZY8
        2cCxukur8gFBFNgRa4BZ/ZoB7DB29Eo=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 2/4] blk-flush: split queues for preflush and postflush requests
Date:   Tue, 25 Jul 2023 21:01:00 +0800
Message-ID: <20230725130102.3030032-3-chengming.zhou@linux.dev>
In-Reply-To: <20230725130102.3030032-1-chengming.zhou@linux.dev>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

We don't need to replace rq->end_io to make it return to the flush state
machine if it doesn't need post-flush.

The previous approach [1] we take is to move blk_rq_init_flush() to
REQ_FSEQ_DATA stage and only replace rq->end_io if it needs post-flush.
Otherwise, it can end like normal request and doesn't need to return
back to the flush state machine.

But this way add more magic to the already way too magic flush sequence.
Christoph suggested that we can kill the flush sequence entirely, and
just split the flush_queue into a preflush and a postflush queue.

The reason we need separate queues for preflush and postflush requests
is that in flush_end_io(), we need to handle differently: end request
for postflush requests, but requeue dispatch for preflush requests.

This patch is just in preparation for the following patches, no
functional changes intended.

[1] https://lore.kernel.org/lkml/20230710133308.GB23157@lst.de/

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c | 50 +++++++++++++++++++++++++++++++++++------------
 block/blk.h       |  3 ++-
 2 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index fc25228f7bb1..4993c3c3b502 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -165,7 +165,7 @@ static void blk_flush_complete_seq(struct request *rq,
 				   unsigned int seq, blk_status_t error)
 {
 	struct request_queue *q = rq->q;
-	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
+	struct list_head *pending;
 
 	BUG_ON(rq->flush.seq & seq);
 	rq->flush.seq |= seq;
@@ -177,9 +177,9 @@ static void blk_flush_complete_seq(struct request *rq,
 
 	switch (seq) {
 	case REQ_FSEQ_PREFLUSH:
-	case REQ_FSEQ_POSTFLUSH:
+		pending = &fq->preflush_queue[fq->flush_pending_idx];
 		/* queue for flush */
-		if (list_empty(pending))
+		if (!fq->flush_pending_since)
 			fq->flush_pending_since = jiffies;
 		list_move_tail(&rq->queuelist, pending);
 		break;
@@ -192,6 +192,14 @@ static void blk_flush_complete_seq(struct request *rq,
 		blk_mq_kick_requeue_list(q);
 		break;
 
+	case REQ_FSEQ_POSTFLUSH:
+		pending = &fq->postflush_queue[fq->flush_pending_idx];
+		/* queue for flush */
+		if (!fq->flush_pending_since)
+			fq->flush_pending_since = jiffies;
+		list_move_tail(&rq->queuelist, pending);
+		break;
+
 	case REQ_FSEQ_DONE:
 		/*
 		 * @rq was previously adjusted by blk_insert_flush() for
@@ -215,7 +223,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 				       blk_status_t error)
 {
 	struct request_queue *q = flush_rq->q;
-	struct list_head *running;
+	struct list_head *preflush_running, *postflush_running;
 	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
@@ -248,14 +256,22 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 		flush_rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 
-	running = &fq->flush_queue[fq->flush_running_idx];
+	preflush_running = &fq->preflush_queue[fq->flush_running_idx];
+	postflush_running = &fq->postflush_queue[fq->flush_running_idx];
 	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
 
 	/* account completion of the flush request */
 	fq->flush_running_idx ^= 1;
 
 	/* and push the waiting requests to the next stage */
-	list_for_each_entry_safe(rq, n, running, queuelist) {
+	list_for_each_entry_safe(rq, n, preflush_running, queuelist) {
+		unsigned int seq = blk_flush_cur_seq(rq);
+
+		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
+		blk_flush_complete_seq(rq, fq, seq, error);
+	}
+
+	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
 		unsigned int seq = blk_flush_cur_seq(rq);
 
 		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
@@ -285,13 +301,20 @@ bool is_flush_rq(struct request *rq)
  */
 static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 {
-	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
-	struct request *first_rq =
-		list_first_entry(pending, struct request, queuelist);
+	struct list_head *preflush_pending = &fq->preflush_queue[fq->flush_pending_idx];
+	struct list_head *postflush_pending = &fq->postflush_queue[fq->flush_pending_idx];
+	struct request *first_rq = NULL;
 	struct request *flush_rq = fq->flush_rq;
 
 	/* C1 described at the top of this file */
-	if (fq->flush_pending_idx != fq->flush_running_idx || list_empty(pending))
+	if (fq->flush_pending_idx != fq->flush_running_idx)
+		return;
+
+	if (!list_empty(preflush_pending))
+		first_rq = list_first_entry(preflush_pending, struct request, queuelist);
+	else if (!list_empty(postflush_pending))
+		first_rq = list_first_entry(postflush_pending, struct request, queuelist);
+	else
 		return;
 
 	/* C2 and C3 */
@@ -305,6 +328,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 	 * different from running_idx, which means flush is in flight.
 	 */
 	fq->flush_pending_idx ^= 1;
+	fq->flush_pending_since = 0;
 
 	blk_rq_init(q, flush_rq);
 
@@ -496,8 +520,10 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 	if (!fq->flush_rq)
 		goto fail_rq;
 
-	INIT_LIST_HEAD(&fq->flush_queue[0]);
-	INIT_LIST_HEAD(&fq->flush_queue[1]);
+	INIT_LIST_HEAD(&fq->preflush_queue[0]);
+	INIT_LIST_HEAD(&fq->preflush_queue[1]);
+	INIT_LIST_HEAD(&fq->postflush_queue[0]);
+	INIT_LIST_HEAD(&fq->postflush_queue[1]);
 
 	return fq;
 
diff --git a/block/blk.h b/block/blk.h
index 686712e13835..1a11675152ac 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -20,7 +20,8 @@ struct blk_flush_queue {
 	unsigned int		flush_running_idx:1;
 	blk_status_t 		rq_status;
 	unsigned long		flush_pending_since;
-	struct list_head	flush_queue[2];
+	struct list_head	preflush_queue[2];
+	struct list_head	postflush_queue[2];
 	unsigned long		flush_data_in_flight;
 	struct request		*flush_rq;
 };
-- 
2.41.0

