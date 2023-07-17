Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44586755A72
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGQECJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjGQEB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:01:56 -0400
Received: from out-11.mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21104E6B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:01:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689566506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vDpuVCWvXzou2B7OXWC1deh3uuUZ5lSIACnNEl46ljk=;
        b=gpKgExO2AR+T/Bj9kjyrPBzUoeybLo9OrrTg5UdcGIDGxeXfbzRBk9yEwPT5OaFDuNmzs/
        G0ZGilzX2aVZLRlwQRBq6A8xKzQ3fhBTHG/jP+A3OzV4gShsa4bY4zJvPlVNVYWVECW1WF
        LZVjRGhopjLHLNIyAeglKcuZDCurIeY=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v4 3/4] blk-flush: count inflight flush_data requests
Date:   Mon, 17 Jul 2023 12:00:57 +0800
Message-ID: <20230717040058.3993930-4-chengming.zhou@linux.dev>
In-Reply-To: <20230717040058.3993930-1-chengming.zhou@linux.dev>
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The flush state machine use a double list to link all inflight
flush_data requests, to avoid issuing separate post-flushes for
these flush_data requests which shared PREFLUSH.

So we can't reuse rq->queuelist, this is why we need rq->flush.list

In preparation of the next patch that reuse rq->queuelist for flush
state machine, we change the double linked list to unsigned long
counter, which count all inflight flush_data requests.

This is ok since we only need to know if there is any inflight
flush_data request, so unsigned long counter is good.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-flush.c | 9 +++++----
 block/blk.h       | 5 ++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index fdc489e0ea16..fedb39031647 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -187,7 +187,8 @@ static void blk_flush_complete_seq(struct request *rq,
 		break;
 
 	case REQ_FSEQ_DATA:
-		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
+		list_del_init(&rq->flush.list);
+		fq->flush_data_in_flight++;
 		spin_lock(&q->requeue_lock);
 		list_add(&rq->queuelist, &q->requeue_list);
 		spin_unlock(&q->requeue_lock);
@@ -299,7 +300,7 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 		return;
 
 	/* C2 and C3 */
-	if (!list_empty(&fq->flush_data_in_flight) &&
+	if (fq->flush_data_in_flight &&
 	    time_before(jiffies,
 			fq->flush_pending_since + FLUSH_PENDING_TIMEOUT))
 		return;
@@ -374,6 +375,7 @@ static enum rq_end_io_ret mq_flush_data_end_io(struct request *rq,
 	 * the comment in flush_end_io().
 	 */
 	spin_lock_irqsave(&fq->mq_flush_lock, flags);
+	fq->flush_data_in_flight--;
 	blk_flush_complete_seq(rq, fq, REQ_FSEQ_DATA, error);
 	spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
 
@@ -445,7 +447,7 @@ bool blk_insert_flush(struct request *rq)
 		blk_rq_init_flush(rq);
 		rq->flush.seq |= REQ_FSEQ_PREFLUSH;
 		spin_lock_irq(&fq->mq_flush_lock);
-		list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
+		fq->flush_data_in_flight++;
 		spin_unlock_irq(&fq->mq_flush_lock);
 		return false;
 	default:
@@ -496,7 +498,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 
 	INIT_LIST_HEAD(&fq->flush_queue[0]);
 	INIT_LIST_HEAD(&fq->flush_queue[1]);
-	INIT_LIST_HEAD(&fq->flush_data_in_flight);
 
 	return fq;
 
diff --git a/block/blk.h b/block/blk.h
index 608c5dcc516b..686712e13835 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -15,15 +15,14 @@ struct elevator_type;
 extern struct dentry *blk_debugfs_root;
 
 struct blk_flush_queue {
+	spinlock_t		mq_flush_lock;
 	unsigned int		flush_pending_idx:1;
 	unsigned int		flush_running_idx:1;
 	blk_status_t 		rq_status;
 	unsigned long		flush_pending_since;
 	struct list_head	flush_queue[2];
-	struct list_head	flush_data_in_flight;
+	unsigned long		flush_data_in_flight;
 	struct request		*flush_rq;
-
-	spinlock_t		mq_flush_lock;
 };
 
 bool is_flush_rq(struct request *req);
-- 
2.41.0

