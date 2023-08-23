Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373E7853CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjHWJZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235111AbjHWJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:18 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [IPv6:2001:41d0:1004:224b::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C58810CF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:05:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbNyJdrWtMp++/ohd8EBBKwgxGmWLvHJBt/jgS9PW8s=;
        b=vyltGbbJ3r+rvwAzjp0mPNdRf51SYlmVht6l7vRfXjsFDzUJFT/3WzGrm99pc+ZobA/3Uw
        ThsnZ8B0ZR+wGE5c1pnlAlJyIbzi90vlDw43vayowdjdbdErxIct7/ZmYO2rfyMz0bOjxS
        Tj2Vwed/iPgcq0F60QSlq2qCWOOJI5w=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 5/6] blk-mq-tag: fix functions documentation
Date:   Wed, 23 Aug 2023 17:04:40 +0800
Message-ID: <20230823090441.3986631-6-chengming.zhou@linux.dev>
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

There are some stale functions documentation in blk-mq-tag, since
the prototype of busy_tag_iter_fn() has changed. Fix it as we're here.

Fixes: 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c497d634cfdb..087ea6b232f6 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -307,9 +307,9 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  * @bt:		sbitmap to examine. This is either the breserved_tags member
  *		or the bitmap_tags member of struct blk_mq_tags.
  * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @data,
- *		@reserved) where rq is a pointer to a request. Return true
- *		to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @data) where
+ *		rq is a pointer to a request. Return true to continue iterating
+ *		tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @flags:	BT_TAG_ITER_*
  */
@@ -345,10 +345,9 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
  * blk_mq_all_tag_iter - iterate over all requests in a tag map
  * @tags:	Tag map to iterate over.
  * @fn:		Pointer to the function that will be called for each
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @priv)
+ *		where rq is a pointer to a request. Return true to
+ *		continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  *
  * Caller has to pass the tag map from which requests are allocated.
@@ -379,10 +378,9 @@ static void __blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
  * blk_mq_tagset_busy_iter - iterate over all started requests in a tag set
  * @tagset:	Tag set to iterate over.
  * @fn:		Pointer to the function that will be called for each started
- *		request. @fn will be called as follows: @fn(rq, @priv,
- *		reserved) where rq is a pointer to a request. 'reserved'
- *		indicates whether or not @rq is a reserved request. Return
- *		true to continue iterating tags, false to stop.
+ *		request. @fn will be called as follows: @fn(rq, @priv)
+ *		where rq is a pointer to a request. Return true to
+ *		continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  *
  * We grab one request reference before calling @fn and release it after
@@ -429,11 +427,9 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * blk_mq_queue_tag_busy_iter - iterate over all requests with a driver tag
  * @q:		Request queue to examine.
  * @fn:		Pointer to the function that will be called for each request
- *		on @q. @fn will be called as follows: @fn(hctx, rq, @priv,
- *		reserved) where rq is a pointer to a request and hctx points
- *		to the hardware queue associated with the request. 'reserved'
- *		indicates whether or not @rq is a reserved request.
- * @priv:	Will be passed as third argument to @fn.
+ *		on @q. @fn will be called as follows: @fn(rq, @priv) where rq
+ *		is a pointer to a request.
+ * @priv:	Will be passed as second argument to @fn.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
  * called for all requests on all queues that share that tag set and not only
-- 
2.41.0

