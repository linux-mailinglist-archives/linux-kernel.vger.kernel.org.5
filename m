Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C927824B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233783AbjHUHlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjHUHlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:41:44 -0400
Received: from out-47.mta0.migadu.com (out-47.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E235B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:41:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692603700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ldWiERt8BmZf5+TVcJmmrAkpSuSMUdZmUwLdnC5s4gI=;
        b=MReozL+ZLoC8g6dRx3jzHNVngcl85B2IlBQrM9NodmeDwJtd/FHJnlmV71V/4l95U+ciLM
        ec1UIhoruqSnNasidS1zTqv2h6VypZ2X8O1j2Psb2Pj+Byiq1152K5n6XXJxufZ/TqkmtE
        r39FL3YaPXKk4qZLGpdvFIuNE7rrj60=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 1/4] blk-mq-tag: support queue filter in bt_tags_iter()
Date:   Mon, 21 Aug 2023 15:35:25 +0800
Message-ID: <20230821073528.3469210-2-chengming.zhou@linux.dev>
In-Reply-To: <20230821073528.3469210-1-chengming.zhou@linux.dev>
References: <20230821073528.3469210-1-chengming.zhou@linux.dev>
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

The only user of bt_for_each() is blk_mq_queue_tag_busy_iter(), which
need to filter queue when iterate the tags. In preparation of removing
bt_for_each(), support queue filter in bt_tags_iter().

The new created __blk_mq_tagset_busy_iter() will be used by the next
patch to iterate requests of only one specified queue.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..75b33ae6acef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -329,6 +329,7 @@ struct bt_tags_iter_data {
 	busy_tag_iter_fn *fn;
 	void *data;
 	unsigned int flags;
+	struct request_queue *q;
 };
 
 #define BT_TAG_ITER_RESERVED		(1 << 0)
@@ -357,9 +358,13 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 	if (!rq)
 		return true;
 
+	if (iter_data->q && iter_data->q != rq->q)
+		goto out;
+
 	if (!(iter_data->flags & BT_TAG_ITER_STARTED) ||
 	    blk_mq_request_started(rq))
 		ret = iter_data->fn(rq, iter_data->data);
+out:
 	if (!iter_static_rqs)
 		blk_mq_put_rq_ref(rq);
 	return ret;
@@ -378,13 +383,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @flags:	BT_TAG_ITER_*
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
-			     busy_tag_iter_fn *fn, void *data, unsigned int flags)
+			     busy_tag_iter_fn *fn, void *data, unsigned int flags,
+			     struct request_queue *q)
 {
 	struct bt_tags_iter_data iter_data = {
 		.tags = tags,
 		.fn = fn,
 		.data = data,
 		.flags = flags,
+		.q = q,
 	};
 
 	if (tags->rqs)
@@ -392,14 +399,15 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 }
 
 static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
-		busy_tag_iter_fn *fn, void *priv, unsigned int flags)
+		busy_tag_iter_fn *fn, void *priv, unsigned int flags,
+		struct request_queue *q)
 {
 	WARN_ON_ONCE(flags & BT_TAG_ITER_RESERVED);
 
 	if (tags->nr_reserved_tags)
 		bt_tags_for_each(tags, &tags->breserved_tags, fn, priv,
-				 flags | BT_TAG_ITER_RESERVED);
-	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags);
+				 flags | BT_TAG_ITER_RESERVED, q);
+	bt_tags_for_each(tags, &tags->bitmap_tags, fn, priv, flags, q);
 }
 
 /**
@@ -417,7 +425,23 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
 void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 		void *priv)
 {
-	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS);
+	__blk_mq_all_tag_iter(tags, fn, priv, BT_TAG_ITER_STATIC_RQS, NULL);
+}
+
+static void __blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
+				      busy_tag_iter_fn *fn, void *priv,
+				      struct request_queue *q)
+{
+	unsigned int flags = tagset->flags;
+	int i, nr_tags;
+
+	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
+
+	for (i = 0; i < nr_tags; i++) {
+		if (tagset->tags && tagset->tags[i])
+			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
+					      BT_TAG_ITER_STARTED, q);
+	}
 }
 
 /**
@@ -436,16 +460,7 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
 void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 		busy_tag_iter_fn *fn, void *priv)
 {
-	unsigned int flags = tagset->flags;
-	int i, nr_tags;
-
-	nr_tags = blk_mq_is_shared_tags(flags) ? 1 : tagset->nr_hw_queues;
-
-	for (i = 0; i < nr_tags; i++) {
-		if (tagset->tags && tagset->tags[i])
-			__blk_mq_all_tag_iter(tagset->tags[i], fn, priv,
-					      BT_TAG_ITER_STARTED);
-	}
+	__blk_mq_tagset_busy_iter(tagset, fn, priv, NULL);
 }
 EXPORT_SYMBOL(blk_mq_tagset_busy_iter);
 
-- 
2.41.0

