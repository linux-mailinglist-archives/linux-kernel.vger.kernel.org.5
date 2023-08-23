Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2A67853CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjHWJZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjHWJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:18 -0400
Received: from out-50.mta0.migadu.com (out-50.mta0.migadu.com [IPv6:2001:41d0:1004:224b::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67AE10D5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:05:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sg+w5ZFglUPxoQtMPjQrwnVvMwMZe6S7J8bbOdaP8as=;
        b=PgnBv+p7W94tYtx2uWOfy0CxVMSh+TrONCSgfCLs/0d5fnALNllvpKEy656K39rpUCzBBG
        rn0E2QTrq047VKHFvZ3h+8w7xWIdzGa/jIRzYh18tdzUdo7RTBGVnFAUZ3c3PtoS3nPe1F
        1IKKdyHyZrhglk1kcCubZKDV6oGuOxE=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 6/6] blk-mq-tag: fix blk_mq_queue_tag_busy_iter() documentation
Date:   Wed, 23 Aug 2023 17:04:41 +0800
Message-ID: <20230823090441.3986631-7-chengming.zhou@linux.dev>
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

The blk_mq_queue_tag_busy_iter() is only used to iterate over reqeusts
of the specified queue, fix the documentation. And add documentation
for the new added parameter @q.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 087ea6b232f6..69b156750559 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -312,6 +312,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
  *		tags, false to stop.
  * @data:	Will be passed as second argument to @fn.
  * @flags:	BT_TAG_ITER_*
+ * @q:		Only iterate over requests of this queue.
  */
 static void bt_tags_for_each(struct blk_mq_tags *tags, struct sbitmap_queue *bt,
 			     busy_tag_iter_fn *fn, void *data, unsigned int flags,
@@ -432,8 +433,7 @@ EXPORT_SYMBOL(blk_mq_tagset_wait_completed_request);
  * @priv:	Will be passed as second argument to @fn.
  *
  * Note: if @q->tag_set is shared with other request queues then @fn will be
- * called for all requests on all queues that share that tag set and not only
- * for requests associated with @q.
+ * called only for requests associated with @q.
  */
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_tag_iter_fn *fn,
 		void *priv)
-- 
2.41.0

