Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBC7853E5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjHWJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjHWJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:09 -0400
Received: from out-4.mta0.migadu.com (out-4.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E8E6F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:05:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPbYMUYhT0SA6se1DsK6M/9sLkfwrKmqxHAZsBcnWYU=;
        b=RzgRxajWXDIHLPp2lIDT7ODLxttOjvUHhm9wmy14Q3sKcg3zzyW3DRrVosbl56cEcLfjpv
        Sfku0hhsWJ8OtmjmKHUShmGzIJ3XNYTK+J10l/NodaI+hnS0gkUQ2jokRyspylrOxohIIn
        u7gm2SARWP+gHyi/a5lBowYVnxTLT7U=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 1/6] blk-mq-tag: support queue filter in bt_tags_iter()
Date:   Wed, 23 Aug 2023 17:04:36 +0800
Message-ID: <20230823090441.3986631-2-chengming.zhou@linux.dev>
In-Reply-To: <20230823090441.3986631-1-chengming.zhou@linux.dev>
References: <20230823090441.3986631-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The only user of bt_for_each() is blk_mq_queue_tag_busy_iter(), which
need to filter queue when iterate the tags. In preparation of removing
bt_for_each(), support queue filter in bt_tags_iter().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq-tag.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index cc57e2dd9a0b..3cf3cf72cd54 100644
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
-- 
2.41.0

