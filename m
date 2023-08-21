Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4979D7824B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjHUHlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjHUHls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:41:48 -0400
Received: from out-42.mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04ECBC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:41:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692603704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d3472x6xe2SoalFzQo695vCbic+ZWYHmbTAUaGOXC/s=;
        b=sn4Tho2y07LzItKAhC2uDwM1pNXYBMWvwCwZJqvgYV7/Bch3/QpZj/oR5aMjzAoYM69fEN
        AzKI6ah9YhbmW+X7QPYuUA815oFsyf9YwWpsoRMyS1HQa2BnLvFLLnqkS97tv28IHbSzX+
        x4JM5/299Nx9SsG3y5ZE7RTyVI3RIuU=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 2/4] blk-mq-tag: remove bt_for_each()
Date:   Mon, 21 Aug 2023 15:35:26 +0800
Message-ID: <20230821073528.3469210-3-chengming.zhou@linux.dev>
In-Reply-To: <20230821073528.3469210-1-chengming.zhou@linux.dev>
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Change the only user of bt_for_each() to use the new function
__blk_mq_tagset_busy_iter() -> bt_tags_for_each() and remove
bt_for_each().

There are some advantages:
1. less code to maintain, now only bt_tags_for_each() left.
2. __blk_mq_tagset_busy_iter() has BT_TAG_ITER_STARTED flag set, so only
   started requests will be iterated, which should be more efficient.

Only one potential disadvantage I can see is that we lost the
blk_mq_hw_queue_mapped() filter, which maybe not happen for now?
Unmapped hctx was used to dynamically map or unmap when CPU hotplug,
but we don't do this anymore, we always map all possible CPUs now.
So it seems unmapped hctx may only happen if something wrong with
driver's tagset settings.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 99 +---------------------------------------------
 1 file changed, 1 insertion(+), 98 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 75b33ae6acef..c497d634cfdb 100644
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
@@ -519,35 +450,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
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
2.41.0

