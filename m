Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739F579EC6A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241640AbjIMPRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbjIMPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:38 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [95.215.58.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7363DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:16:34 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694618193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=54/TH6NwZmycBuSVYU7gHf61WfubLeQthagty1Zb+Ho=;
        b=NTumMwyNHBdjcIricrwm9zKU91F6+4vINw2RVn5cVHIyaTqrJSZE1Mg/sY1E8kCeupdeyr
        Mk+w9MGQRmxoZpZWD0F5Hqi3P6GnuNxVBtZuHXwpRoOTwqymnTnr6HMNHSW+Jrm7T5Bts+
        GVowM6zQPg+BYhyrI4+b2Z2GeH1x8Pw=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     kbusch@kernel.org, mst@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/5] blk-mq: remove RQF_MQ_INFLIGHT
Date:   Wed, 13 Sep 2023 15:16:13 +0000
Message-Id: <20230913151616.3164338-3-chengming.zhou@linux.dev>
In-Reply-To: <20230913151616.3164338-1-chengming.zhou@linux.dev>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Since the previous patch change to only account active requests when
we really allocate the driver tag, the RQF_MQ_INFLIGHT can be removed
and no double account problem.

1. none elevator: flush request will use the first pending request's
   driver tag, won't double account.

2. other elevator: flush request will be accounted when allocate driver
   tag when issue, and will be unaccounted when it put the driver tag.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c      | 11 ++---------
 block/blk-mq-debugfs.c |  1 -
 block/blk-mq.c         |  4 ----
 include/linux/blk-mq.h |  2 --
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e73dc22d05c1..3f4d41952ef2 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -323,16 +323,9 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 	flush_rq->mq_ctx = first_rq->mq_ctx;
 	flush_rq->mq_hctx = first_rq->mq_hctx;
 
-	if (!q->elevator) {
+	if (!q->elevator)
 		flush_rq->tag = first_rq->tag;
-
-		/*
-		 * We borrow data request's driver tag, so have to mark
-		 * this flush request as INFLIGHT for avoiding double
-		 * account of this driver tag
-		 */
-		flush_rq->rq_flags |= RQF_MQ_INFLIGHT;
-	} else
+	else
 		flush_rq->internal_tag = first_rq->internal_tag;
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index c3b5930106b2..5cbeb9344f2f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -246,7 +246,6 @@ static const char *const rqf_name[] = {
 	RQF_NAME(STARTED),
 	RQF_NAME(FLUSH_SEQ),
 	RQF_NAME(MIXED_MERGE),
-	RQF_NAME(MQ_INFLIGHT),
 	RQF_NAME(DONTPREP),
 	RQF_NAME(SCHED_TAGS),
 	RQF_NAME(USE_SCHED),
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e776388decc3..c209a7dddee3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1066,10 +1066,6 @@ static inline void blk_mq_flush_tag_batch(struct blk_mq_hw_ctx *hctx,
 {
 	struct request_queue *q = hctx->queue;
 
-	/*
-	 * All requests should have been marked as RQF_MQ_INFLIGHT, so
-	 * update hctx->nr_active in batch
-	 */
 	blk_mq_sub_active_requests(hctx, nr_tags);
 
 	blk_mq_put_tags(hctx->tags, tag_array, nr_tags);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 958ed7e89b30..1ab3081c82ed 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -32,8 +32,6 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
 /* merge of different types, fail separately */
 #define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
-/* track inflight for MQ */
-#define RQF_MQ_INFLIGHT		((__force req_flags_t)(1 << 6))
 /* don't call prep for this one */
 #define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
 /* use hctx->sched_tags */
-- 
2.40.1

