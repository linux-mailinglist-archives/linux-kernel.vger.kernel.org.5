Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46B76199F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGYNTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjGYNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:19:05 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5825F19BA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:18:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690291137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/QeLRD3PFm/UhjbcDO63KGqnRYCXFOsqKzmt3mk4Vfs=;
        b=dYoyHX5VNzJ1aicvzztBVYudt9ptphJkTO29hYSGPPfG0Z0U7+n46WMtbxZ4J7Q35KtYcO
        VI3RNCkVOFCy/kp957wNpvXCnsfHnxP/W8pdkhTwK+I9mj16ZUuVEqp1sFFDxTF5iSA752
        y0QkHtWqGy1/KK6cPZOi18C8u5+TCYc=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 1/4] blk-flush: flush_rq should inherit first_rq's cmd_flags
Date:   Tue, 25 Jul 2023 21:00:59 +0800
Message-ID: <20230725130102.3030032-2-chengming.zhou@linux.dev>
In-Reply-To: <20230725130102.3030032-1-chengming.zhou@linux.dev>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The cmd_flags in blk_kick_flush() should inherit the original request's
cmd_flags, but the current code looks buggy to me:

flush_end_io()
  blk_flush_complete_seq() // requests on flush running list
    blk_kick_flush()

So the request passed to blk_flush_complete_seq() may will be ended
before blk_kick_flush().
On the other hand, flush_rq will inherit first_rq's tag, it should
use first_rq's cmd_flags too.

This patch is just preparation for the following patches, no bugfix
intended.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-flush.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index e73dc22d05c1..fc25228f7bb1 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -92,7 +92,7 @@ enum {
 };
 
 static void blk_kick_flush(struct request_queue *q,
-			   struct blk_flush_queue *fq, blk_opf_t flags);
+			   struct blk_flush_queue *fq);
 
 static inline struct blk_flush_queue *
 blk_get_flush_queue(struct request_queue *q, struct blk_mq_ctx *ctx)
@@ -166,11 +166,9 @@ static void blk_flush_complete_seq(struct request *rq,
 {
 	struct request_queue *q = rq->q;
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
-	blk_opf_t cmd_flags;
 
 	BUG_ON(rq->flush.seq & seq);
 	rq->flush.seq |= seq;
-	cmd_flags = rq->cmd_flags;
 
 	if (likely(!error))
 		seq = blk_flush_cur_seq(rq);
@@ -210,7 +208,7 @@ static void blk_flush_complete_seq(struct request *rq,
 		BUG();
 	}
 
-	blk_kick_flush(q, fq, cmd_flags);
+	blk_kick_flush(q, fq);
 }
 
 static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
@@ -277,7 +275,6 @@ bool is_flush_rq(struct request *rq)
  * blk_kick_flush - consider issuing flush request
  * @q: request_queue being kicked
  * @fq: flush queue
- * @flags: cmd_flags of the original request
  *
  * Flush related states of @q have changed, consider issuing flush request.
  * Please read the comment at the top of this file for more info.
@@ -286,8 +283,7 @@ bool is_flush_rq(struct request *rq)
  * spin_lock_irq(fq->mq_flush_lock)
  *
  */
-static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
-			   blk_opf_t flags)
+static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq)
 {
 	struct list_head *pending = &fq->flush_queue[fq->flush_pending_idx];
 	struct request *first_rq =
@@ -336,7 +332,8 @@ static void blk_kick_flush(struct request_queue *q, struct blk_flush_queue *fq,
 		flush_rq->internal_tag = first_rq->internal_tag;
 
 	flush_rq->cmd_flags = REQ_OP_FLUSH | REQ_PREFLUSH;
-	flush_rq->cmd_flags |= (flags & REQ_DRV) | (flags & REQ_FAILFAST_MASK);
+	flush_rq->cmd_flags |= (first_rq->cmd_flags & REQ_DRV) |
+			       (first_rq->cmd_flags & REQ_FAILFAST_MASK);
 	flush_rq->rq_flags |= RQF_FLUSH_SEQ;
 	flush_rq->end_io = flush_end_io;
 	/*
-- 
2.41.0

