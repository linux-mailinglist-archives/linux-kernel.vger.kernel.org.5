Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AC5755E3E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGQIQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:16:51 -0400
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [IPv6:2001:41d0:203:375::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B1130
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:16:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689581806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2P6zwutYVrvzrXaidcKY76GWAAPOp1DUnrFH1XwSgjE=;
        b=KZLo+pSf+X241vvb9enfuzVUY7lws6eSO1SS3RkVASw5Bqxot6UMuoSNmneWJjOAzYzDo1
        oCWhUpZT7cd0ih4qswpCa0Ls5DqHlE62vJo4P4ocLJHOQ2J95YbAOMk7oUnheTO/bUkXYk
        4wLS+6vzuu9opzamSHR2UrhPoxBsd3Y=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH] blk-mq: plug based timestamp caching
Date:   Mon, 17 Jul 2023 16:16:02 +0800
Message-ID: <20230717081602.255767-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

This idea is from Tejun [1] that don't like manually optimized timestamp
reads, so come up the plug based timestamp caching infrastructure, which
is more generic and has better performance. It works since we don't care
about nanosec accuracy.

Have the plug init start with the timestamp invalid, and use blk_get_time()
helper that return the time for no plug, and set it in the plug if not set.
Flushing the plug would mark it invalid again at the end.

We replaces all "alloc_time_ns", "start_time_ns" and "io_start_time_ns"
settings to use the blk_get_time() helper.

The only direct caller of ktime_get_ns() left in blk-mq is in request end,
which don't use cached timestamp for better accuracy of completion time.

[1] https://lore.kernel.org/lkml/ZLA7QAfSojxu_FMW@slm.duckdns.org/

Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-core.c       |  3 +++
 block/blk-mq.c         | 22 +++++++++++++++++-----
 include/linux/blkdev.h |  2 ++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 90de50082146..a63d33af7287 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1054,6 +1054,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, unsigned short nr_ios)
 		return;
 
 	plug->mq_list = NULL;
+	plug->cached_time_ns = 0;
 	plug->cached_rq = NULL;
 	plug->nr_ios = min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
 	plug->rq_count = 0;
@@ -1153,6 +1154,8 @@ void __blk_flush_plug(struct blk_plug *plug, bool from_schedule)
 	 */
 	if (unlikely(!rq_list_empty(plug->cached_rq)))
 		blk_mq_free_plug_rqs(plug);
+
+	plug->cached_time_ns = 0;
 }
 
 /**
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b04ff6f56926..54648bfaab9c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -311,6 +311,18 @@ void blk_mq_wake_waiters(struct request_queue *q)
 			blk_mq_tag_wakeup_all(hctx->tags, true);
 }
 
+static inline u64 blk_get_time(void)
+{
+	struct blk_plug *plug = current->plug;
+
+	if (!plug)
+		return ktime_get_ns();
+
+	if (!plug->cached_time_ns)
+		plug->cached_time_ns = ktime_get_ns();
+	return plug->cached_time_ns;
+}
+
 void blk_rq_init(struct request_queue *q, struct request *rq)
 {
 	memset(rq, 0, sizeof(*rq));
@@ -322,7 +334,7 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->tag = BLK_MQ_NO_TAG;
 	rq->internal_tag = BLK_MQ_NO_TAG;
-	rq->start_time_ns = ktime_get_ns();
+	rq->start_time_ns = blk_get_time();
 	rq->part = NULL;
 	blk_crypto_rq_set_defaults(rq);
 }
@@ -332,7 +344,7 @@ EXPORT_SYMBOL(blk_rq_init);
 static inline void blk_mq_rq_time_init(struct request *rq, u64 alloc_time_ns)
 {
 	if (blk_mq_need_time_stamp(rq))
-		rq->start_time_ns = ktime_get_ns();
+		rq->start_time_ns = blk_get_time();
 	else
 		rq->start_time_ns = 0;
 
@@ -441,7 +453,7 @@ static struct request *__blk_mq_alloc_requests(struct blk_mq_alloc_data *data)
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_get_time();
 
 	if (data->cmd_flags & REQ_NOWAIT)
 		data->flags |= BLK_MQ_REQ_NOWAIT;
@@ -624,7 +636,7 @@ struct request *blk_mq_alloc_request_hctx(struct request_queue *q,
 
 	/* alloc_time includes depth and tag waits */
 	if (blk_queue_rq_alloc_time(q))
-		alloc_time_ns = ktime_get_ns();
+		alloc_time_ns = blk_get_time();
 
 	/*
 	 * If the tag allocator sleeps we could get an allocation for a
@@ -1235,7 +1247,7 @@ void blk_mq_start_request(struct request *rq)
 	trace_block_rq_issue(rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-		rq->io_start_time_ns = ktime_get_ns();
+		rq->io_start_time_ns = blk_get_time();
 		rq->stats_sectors = blk_rq_sectors(rq);
 		rq->rq_flags |= RQF_STATS;
 		rq_qos_issue(q, rq);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index ed44a997f629..21a3d4d7ab2b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -961,6 +961,8 @@ void blk_mark_disk_dead(struct gendisk *disk);
 struct blk_plug {
 	struct request *mq_list; /* blk-mq requests */
 
+	u64 cached_time_ns;
+
 	/* if ios_left is > 1, we can batch tag/rq allocations */
 	struct request *cached_rq;
 	unsigned short nr_ios;
-- 
2.41.0

