Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205F379DEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbjIMDvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbjIMDvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:13 -0400
Received: from out-211.mta0.migadu.com (out-211.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AACD1730
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:51:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0J2KdIXBZzKToHETr5IICIXYsUscX31c5YuO5la0Sc=;
        b=Jz1oZ3eZlVbLc58wbXXq9fi5nLOEoUZhKoqk69495Hat27LKyoCJYGpjZa8KX5i/QlsXYr
        Od8/g2H4XQmwaWIpXpxNO0J3mIvqssu3eQ3J+XMrjmk24Zx/hbyMrPz9xG87bKcCOOC+dX
        Bwcv16xIbIl6R1ChETHGn553mci3+8g=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 3/6] blk-mq-tag: remove bt_for_each()
Date:   Wed, 13 Sep 2023 03:50:30 +0000
Message-Id: <20230913035033.1549277-4-chengming.zhou@linux.dev>
In-Reply-To: <20230913035033.1549277-1-chengming.zhou@linux.dev>
References: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Change the only user of bt_for_each() to use the introduced function
__blk_mq_tagset_busy_iter() to specify queue filter when iterating.

Since blk_mq_queue_tag_busy_iter() is only used to iterate over started
requests, __blk_mq_tagset_busy_iter() already have BT_TAG_ITER_STARTED
filter to iterate over started requests only, there should be no
problem.

Only one potential disadvantage I can see is that we lost the
blk_mq_hw_queue_mapped() filter, which maybe not happen for now.
Unmapped hctx was used to dynamically map or unmap when CPU hotplug,
but we don't do this anymore, we always map all possible CPUs now.
So it seems unmapped hctx may only happen if something wrong with
driver's tagset map settings.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 99 +---------------------------------------------
 1 file changed, 1 insertion(+), 98 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dc4edde3c80a..3ddc0c7b7f7e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -241,14 +241,6 @@ void blk_mq_put_tags(struct blk_mq_tags *tags, int *tag_array, int nr_tags)
 					tag_array, nr_tags);
 }
 
-struct bt_iter_data {
-	struct blk_mq_hw_ctx *hctx;
-	struct request_queue *q;
-	busy_tag_iter_fn *fn;
-	void *data;
-	bool reserved;
-};
-
 static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 		unsigned int bitnr)
 {
@@ -263,67 +255,6 @@ static struct request *blk_mq_find_and_get_req(struct blk_mq_tags *tags,
 	return rq;
 }
 
-static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
-{
-	struct bt_iter_data *iter_data = data;
-	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
-	struct request_queue *q = iter_data->q;
-	struct blk_mq_tag_set *set = q->tag_set;
-	struct blk_mq_tags *tags;
-	struct request *rq;
-	bool ret = true;
-
-	if (blk_mq_is_shared_tags(set->flags))
-		tags = set->shared_tags;
-	else
-		tags = hctx->tags;
-
-	if (!iter_data->reserved)
-		bitnr += tags->nr_reserved_tags;
-	/*
-	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assigning ->rqs[].
-	 */
-	rq = blk_mq_find_and_get_req(tags, bitnr);
-	if (!rq)
-		return true;
-
-	if (rq->q == q && (!hctx || rq->mq_hctx == hctx))
-		ret = iter_data->fn(rq, iter_data->data);
-	blk_mq_put_rq_ref(rq);
-	return ret;
-}
-
-/**
- * bt_for_each - iterate over the requests associated with a hardware queue
- * @hctx:	Hardware queue to examine.
- * @q:		Request queue to examine.
- * @bt:		sbitmap to examine. This is either the breserved_tags member
- *		or the bitmap_tags member of struct blk_mq_tags.
- * @fn:		Pointer to the function that will be called for each request
- *		associated with @hctx that has been assigned a driver tag.
- *		@fn will be called as follows: @fn(@hctx, rq, @data, @reserved)
- *		where rq is a pointer to a request. Return true to continue
- *		iterating tags, false to stop.
- * @data:	Will be passed as third argument to @fn.
- * @reserved:	Indicates whether @bt is the breserved_tags member or the
- *		bitmap_tags member of struct blk_mq_tags.
- */
-static void bt_for_each(struct blk_mq_hw_ctx *hctx, struct request_queue *q,
-			struct sbitmap_queue *bt, busy_tag_iter_fn *fn,
-			void *data, bool reserved)
-{
-	struct bt_iter_data iter_data = {
-		.hctx = hctx,
-		.fn = fn,
-		.data = data,
-		.reserved = reserved,
-		.q = q,
-	};
-
-	sbitmap_for_each_set(&bt->sb, bt_iter, &iter_data);
-}
-
 struct bt_tags_iter_data {
 	struct blk_mq_tags *tags;
 	busy_tag_iter_fn *fn;
@@ -520,35 +451,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return;
 
-	if (blk_mq_is_shared_tags(q->tag_set->flags)) {
-		struct blk_mq_tags *tags = q->tag_set->shared_tags;
-		struct sbitmap_queue *bresv = &tags->breserved_tags;
-		struct sbitmap_queue *btags = &tags->bitmap_tags;
-
-		if (tags->nr_reserved_tags)
-			bt_for_each(NULL, q, bresv, fn, priv, true);
-		bt_for_each(NULL, q, btags, fn, priv, false);
-	} else {
-		struct blk_mq_hw_ctx *hctx;
-		unsigned long i;
-
-		queue_for_each_hw_ctx(q, hctx, i) {
-			struct blk_mq_tags *tags = hctx->tags;
-			struct sbitmap_queue *bresv = &tags->breserved_tags;
-			struct sbitmap_queue *btags = &tags->bitmap_tags;
-
-			/*
-			 * If no software queues are currently mapped to this
-			 * hardware queue, there's nothing to check
-			 */
-			if (!blk_mq_hw_queue_mapped(hctx))
-				continue;
-
-			if (tags->nr_reserved_tags)
-				bt_for_each(hctx, q, bresv, fn, priv, true);
-			bt_for_each(hctx, q, btags, fn, priv, false);
-		}
-	}
+	__blk_mq_tagset_busy_iter(q->tag_set, fn, priv, q);
 	blk_queue_exit(q);
 }
 
-- 
2.40.1

