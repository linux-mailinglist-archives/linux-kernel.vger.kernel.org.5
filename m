Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFC7853DA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjHWJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbjHWJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:09 -0400
Received: from out-56.mta0.migadu.com (out-56.mta0.migadu.com [IPv6:2001:41d0:1004:224b::38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46267E73
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:05:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Ck0rs81AEiodN0S3rZySD0WGGzyJ4hTtyZoFTOerZQ=;
        b=g6TeL8imDuOfAy/AqraJoNw2qHhnH3g0sx8U26G2sFHnyHg2QiDlFKimvbArOq3hlcafJ9
        7Nh029sgg5Cf1jkNDsXoGf6RGIZQp6FnbtPZnGDQMK+aRqhYX+yAkxl428nNG/vHsgWkX4
        BPnP0zOudV9Mzm/QTjyWkggrclRHVWI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 2/6] blk-mq-tag: introduce __blk_mq_tagset_busy_iter()
Date:   Wed, 23 Aug 2023 17:04:37 +0800
Message-ID: <20230823090441.3986631-3-chengming.zhou@linux.dev>
In-Reply-To: <20230823090441.3986631-1-chengming.zhou@linux.dev>
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

For support of specified queue filter when iterating over a tagset,
we introduce __blk_mq_tagset_busy_iter() here and all current users
just set queue as NULL which means have no queue filter.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3cf3cf72cd54..75b33ae6acef 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -383,13 +383,15 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
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
@@ -397,14 +399,15 @@ static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
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
@@ -422,7 +425,23 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
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
@@ -441,16 +460,7 @@ void blk_mq_all_tag_iter(struct blk_mq_tags *tags, busy_tag_iter_fn *fn,
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

