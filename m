Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CA7619A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjGYNTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGYNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:13 -0400
Received: from out-13.mta0.migadu.com (out-13.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1281BF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:19:08 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690291146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XANlsJMqfDtLDth7AmpKRAOz7/FxobYtfojym2xLXV0=;
        b=b0plt3BtcFnwzAyKOqNYzpGkxcY9ezH+pdE4wwMVaZlJVquMLw8y9nCJvDM0EfG+FlXAEM
        AqmMF4GWh4ESt29PaRcDXbcDwePYOkfQ3cVxKJcqlqBf4T/cCGXktU/ETZw9Kqja5f7Cqj
        rhcEj39Ek3nr8MOtTdFcpFsOtbU4Pok=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 3/4] blk-flush: kill the flush state machine
Date:   Tue, 25 Jul 2023 21:01:01 +0800
Message-ID: <20230725130102.3030032-4-chengming.zhou@linux.dev>
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

Since now we put preflush and postflush requests in separate queues,
we don't need the flush sequence to record anymore.

REQ_FSEQ_PREFLUSH: blk_enqueue_preflush()
REQ_FSEQ_POSTFLUSH: blk_enqueue_postflush()
REQ_FSEQ_DONE: blk_end_flush()

In blk_flush_complete(), we have two list to handle: preflush_running
and postflush_running. We just blk_end_flush() directly for postflush
requests, but need to move preflush requests to requeue_list to
dispatch.

This patch just kill the flush state machine and directly call these
functions, in preparation for the next patch.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c      | 158 ++++++++++++++++++-----------------------
 include/linux/blk-mq.h |   1 -
 2 files changed, 70 insertions(+), 89 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 4993c3c3b502..ed195c760617 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -117,11 +117,6 @@ static unsigned int blk_flush_policy(unsigned long fflags, struct request *rq)
 	return policy;
 }
 
-static unsigned int blk_flush_cur_seq(struct request *rq)
-{
-	return 1 << ffz(rq->flush.seq);
-}
-
 static void blk_flush_restore_request(struct request *rq)
 {
 	/*
@@ -147,75 +142,81 @@ static void blk_account_io_flush(struct request *rq)
 	part_stat_unlock();
 }
 
-/**
- * blk_flush_complete_seq - complete flush sequence
- * @rq: PREFLUSH/FUA request being sequenced
- * @fq: flush queue
- * @seq: sequences to complete (mask of %REQ_FSEQ_*, can be zero)
- * @error: whether an error occurred
- *
- * @rq just completed @seq part of its flush sequence, record the
- * completion and trigger the next step.
- *
- * CONTEXT:
- * spin_lock_irq(fq->mq_flush_lock)
- */
-static void blk_flush_complete_seq(struct request *rq,
-				   struct blk_flush_queue *fq,
-				   unsigned int seq, blk_status_t error)
+static void blk_enqueue_preflush(struct request *rq, struct blk_flush_queue *fq)
 {
 	struct request_queue *q = rq->q;
-	struct list_head *pending;
+	struct list_head *pending = &fq->preflush_queue[fq->flush_pending_idx];
 
-	BUG_ON(rq->flush.seq & seq);
-	rq->flush.seq |= seq;
+	if (!fq->flush_pending_since)
+		fq->flush_pending_since = jiffies;
+	list_move_tail(&rq->queuelist, pending);
 
-	if (likely(!error))
-		seq = blk_flush_cur_seq(rq);
-	else
-		seq = REQ_FSEQ_DONE;
+	blk_kick_flush(q, fq);
+}
 
-	switch (seq) {
-	case REQ_FSEQ_PREFLUSH:
-		pending = &fq->preflush_queue[fq->flush_pending_idx];
-		/* queue for flush */
-		if (!fq->flush_pending_since)
-			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->queuelist, pending);
-		break;
+static void blk_enqueue_postflush(struct request *rq, struct blk_flush_queue *fq)
+{
+	struct request_queue *q = rq->q;
+	struct list_head *pending = &fq->postflush_queue[fq->flush_pending_idx];
 
-	case REQ_FSEQ_DATA:
-		fq->flush_data_in_flight++;
-		spin_lock(&q->requeue_lock);
-		list_move(&rq->queuelist, &q->requeue_list);
-		spin_unlock(&q->requeue_lock);
-		blk_mq_kick_requeue_list(q);
-		break;
+	if (!fq->flush_pending_since)
+		fq->flush_pending_since = jiffies;
+	list_move_tail(&rq->queuelist, pending);
 
-	case REQ_FSEQ_POSTFLUSH:
-		pending = &fq->postflush_queue[fq->flush_pending_idx];
-		/* queue for flush */
-		if (!fq->flush_pending_since)
-			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->queuelist, pending);
-		break;
+	blk_kick_flush(q, fq);
+}
 
-	case REQ_FSEQ_DONE:
-		/*
-		 * @rq was previously adjusted by blk_insert_flush() for
-		 * flush sequencing and may already have gone through the
-		 * flush data request completion path.  Restore @rq for
-		 * normal completion and end it.
-		 */
-		list_del_init(&rq->queuelist);
-		blk_flush_restore_request(rq);
-		blk_mq_end_request(rq, error);
-		break;
+static void blk_end_flush(struct request *rq, struct blk_flush_queue *fq,
+			  blk_status_t error)
+{
+	struct request_queue *q = rq->q;
 
-	default:
-		BUG();
+	/*
+	 * @rq was previously adjusted by blk_insert_flush() for
+	 * flush sequencing and may already have gone through the
+	 * flush data request completion path.  Restore @rq for
+	 * normal completion and end it.
+	 */
+	list_del_init(&rq->queuelist);
+	blk_flush_restore_request(rq);
+	blk_mq_end_request(rq, error);
+
+	blk_kick_flush(q, fq);
+}
+
+static void blk_flush_complete(struct request_queue *q,
+			       struct blk_flush_queue *fq,
+			       blk_status_t error)
+{
+	unsigned int nr_requeue = 0;
+	struct list_head *preflush_running;
+	struct list_head *postflush_running;
+	struct request *rq, *n;
+
+	preflush_running = &fq->preflush_queue[fq->flush_running_idx];
+	postflush_running = &fq->postflush_queue[fq->flush_running_idx];
+
+	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
+		blk_end_flush(rq, fq, error);
 	}
 
+	list_for_each_entry_safe(rq, n, preflush_running, queuelist) {
+		if (unlikely(error || !blk_rq_sectors(rq)))
+			blk_end_flush(rq, fq, error);
+		else
+			nr_requeue++;
+	}
+
+	if (nr_requeue) {
+		fq->flush_data_in_flight += nr_requeue;
+		spin_lock(&q->requeue_lock);
+		list_splice_init(preflush_running, &q->requeue_list);
+		spin_unlock(&q->requeue_lock);
+		blk_mq_kick_requeue_list(q);
+	}
+
+	/* account completion of the flush request */
+	fq->flush_running_idx ^= 1;
 	blk_kick_flush(q, fq);
 }
 
@@ -223,8 +224,6 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 				       blk_status_t error)
 {
 	struct request_queue *q = flush_rq->q;
-	struct list_head *preflush_running, *postflush_running;
-	struct request *rq, *n;
 	unsigned long flags = 0;
 	struct blk_flush_queue *fq = blk_get_flush_queue(q, flush_rq->mq_ctx);
 
@@ -256,27 +255,9 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 		flush_rq->internal_tag = BLK_MQ_NO_TAG;
 	}
 
-	preflush_running = &fq->preflush_queue[fq->flush_running_idx];
-	postflush_running = &fq->postflush_queue[fq->flush_running_idx];
 	BUG_ON(fq->flush_pending_idx == fq->flush_running_idx);
 
-	/* account completion of the flush request */
-	fq->flush_running_idx ^= 1;
-
-	/* and push the waiting requests to the next stage */
-	list_for_each_entry_safe(rq, n, preflush_running, queuelist) {
-		unsigned int seq = blk_flush_cur_seq(rq);
-
-		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
-		blk_flush_complete_seq(rq, fq, seq, error);
-	}
-
-	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
-		unsigned int seq = blk_flush_cur_seq(rq);
-
-		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
-		blk_flush_complete_seq(rq, fq, seq, error);
-	}
+	blk_flush_complete(q, fq, error);
 
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 	return RQ_END_IO_NONE;
@@ -401,7 +382,10 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	 * re-initialize rq->queuelist before reusing it here.
 	 */
 	INIT_LIST_HEAD(&rq->queuelist);
-	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
+	if (likely(!error))
+		blk_enqueue_postflush(rq, fq);
+	else
+		blk_end_flush(rq, fq, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
 	blk_mq_sched_restart(hctx);
@@ -410,7 +394,6 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 
 static void blk_rq_init_flush(struct request *rq)
 {
-	rq->flush.seq = 0;
 	rq->rq_flags |= RQF_FLUSH_SEQ;
 	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
 	rq->end_io = mq_flush_data_end_io;
@@ -469,7 +452,6 @@ bool blk_insert_flush(struct request *rq)
 		 * the post flush, and then just pass the command on.
 		 */
 		blk_rq_init_flush(rq);
-		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
 		spin_lock_irq(&fq->mq_flush_lock);
 		fq->flush_data_in_flight++;
 		spin_unlock_irq(&fq->mq_flush_lock);
@@ -481,7 +463,7 @@ bool blk_insert_flush(struct request *rq)
 		 */
 		blk_rq_init_flush(rq);
 		spin_lock_irq(&fq->mq_flush_lock);
-		blk_flush_complete_seq(rq, fq, REQ_FSEQ_ACTIONS & ~policy, 0);
+		blk_enqueue_preflush(rq, fq);
 		spin_unlock_irq(&fq->mq_flush_lock);
 		return true;
 	}
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 01e8c31db665..d46fefdacea8 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -177,7 +177,6 @@ struct request {
 	} elv;
 
 	struct {
-		unsigned int		seq;
 		rq_end_io_fn		*saved_end_io;
 	} flush;
 
-- 
2.41.0

