Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73A755A73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGQECN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjGQECB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:02:01 -0400
Received: from out-31.mta0.migadu.com (out-31.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F92F10C1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:01:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689566509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L62IGS5yyrINSCSaBLEOOOMpycO+zZjyfsnojgz6mDg=;
        b=qxiNEW0Gf1Z9a7yqlE6MdCGCZ93ZTCLqy2TQPpQqsynOcXPGx0yCxEYYdteDz8U64+tFqt
        j32AmN9HvZC8brL+sUv/zp5ZGOv+3y7BTWhIZS2npJ1rnQcTdhTDJ1HJl3tLW9Mb5th/J5
        p/DtxG4I7FIIn2nslGxhivLDtgi8DGI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v4 4/4] blk-flush: reuse rq queuelist in flush state machine
Date:   Mon, 17 Jul 2023 12:00:58 +0800
Message-ID: <20230717040058.3993930-5-chengming.zhou@linux.dev>
In-Reply-To: <20230717040058.3993930-1-chengming.zhou@linux.dev>
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Since we don't need to maintain inflight flush_data requests list
anymore, we can reuse rq->queuelist for flush pending list.

Note in mq_flush_data_end_io(), we need to re-initialize rq->queuelist
before reusing it in the state machine when end, since the rq->rq_next
also reuse it, may have corrupted rq->queuelist by the driver.

This patch decrease the size of struct request by 16 bytes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c      | 17 ++++++++++-------
 include/linux/blk-mq.h |  1 -
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index fedb39031647..e73dc22d05c1 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -183,14 +183,13 @@ static void blk_flush_complete_seq(struct request *rq,
 		/* queue for flush */
 		if (list_empty(pending))
 			fq->flush_pending_since = jiffies;
-		list_move_tail(&rq->flush.list, pending);
+		list_move_tail(&rq->queuelist, pending);
 		break;
 
 	case REQ_FSEQ_DATA:
-		list_del_init(&rq->flush.list);
 		fq->flush_data_in_flight++;
 		spin_lock(&q->requeue_lock);
-		list_add(&rq->queuelist, &q->requeue_list);
+		list_move(&rq->queuelist, &q->requeue_list);
 		spin_unlock(&q->requeue_lock);
 		blk_mq_kick_requeue_list(q);
 		break;
@@ -202,7 +201,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		 * flush data request completion path.  Restore @rq for
 		 * normal completion and end it.
 		 */
-		list_del_init(&rq->flush.list);
+		list_del_init(&rq->queuelist);
 		blk_flush_restore_request(rq);
 		blk_mq_end_request(rq, error);
 		break;
@@ -258,7 +257,7 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
 	fq->flush_running_idx ^= 1;
 
 	/* and push the waiting requests to the next stage */
-	list_for_each_entry_safe(rq, n, running, flush.list) {
+	list_for_each_entry_safe(rq, n, running, queuelist) {
 		unsigned int seq = blk_flush_cur_seq(rq);
 
 		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
@@ -292,7 +291,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 {
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	struct request *first_rq =
-		list_first_entry(pending, struct request, flush.list);
+		list_first_entry(pending, struct request, queuelist);
 	struct request *flush_rq = fq->flush_rq;
 
 	/* C1 described at the top of this file */
@@ -376,6 +375,11 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	 */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
 	fq->flush_data_in_flight--;
+	/*
+	 * May have been corrupted by rq->rq_next reuse, we need to
+	 * re-initialize rq->queuelist before reusing it here.
+	 */
+	INIT_LIST_HEAD(&rq->queuelist);
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
@@ -386,7 +390,6 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 static void blk_rq_init_flush(struct request *rq)
 {
 	rq->flush.seq = 0;
-	INIT_LIST_HEAD(&rq->flush.list);
 	rq->rq_flags |= RQF_FLUSH_SEQ;
 	rq->flush.saved_end_io = rq->end_io; /* Usually NULL */
 	rq->end_io = mq_flush_data_end_io;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 67f810857634..01e8c31db665 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -178,7 +178,6 @@ struct request {
 
 	struct {
 		unsigned int		seq;
-		struct list_head	list;
 		rq_end_io_fn		*saved_end_io;
 	} flush;
 
-- 
2.41.0

