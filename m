Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2179DEC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbjIMDv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjIMDvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:21 -0400
Received: from out-229.mta0.migadu.com (out-229.mta0.migadu.com [91.218.175.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DED1989
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:51:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tr2y1RXEAqFREuCr8X/bFxj1HZWX82tlPsNorh3+Y6g=;
        b=Xe3QWvFEiv03j7kyGYShuLqk4W1WQG3vHr92YijOPzUaq7YxU1tUwyw9DmPQezs3eof0bh
        E34dtvSBWS32CG0ZaJksOasz19sNwffkVYrI93uAIBd84MAf1IngkYa6V+k2ozcV2Tv3sS
        iTQz9OSB6VFt6yjtLXLfcgKbRgH0+9A=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 5/6] blk-mq-tag: fix functions documentation
Date:   Wed, 13 Sep 2023 03:50:32 +0000
Message-Id: <20230913035033.1549277-6-chengming.zhou@linux.dev>
In-Reply-To: <20230913035033.1549277-1-chengming.zhou@linux.dev>
References: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

There are some stale functions documentation in blk-mq-tag, since
the prototype of busy_tag_iter_fn() has changed. Fix it as we're here.

Fixes: 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 3ddc0c7b7f7e..0d42f3c4d76e 100644
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
  * @q:		Only iterate over requests of this queue.
@@ -346,10 +346,9 @@ static void __blk_mq_all_tag_iter(struct blk_mq_tags *tags,
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
@@ -380,10 +379,9 @@ static void __blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
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
@@ -430,11 +428,9 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
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
2.40.1

