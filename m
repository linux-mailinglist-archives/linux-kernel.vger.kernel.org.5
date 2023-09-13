Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE05A79DEBD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbjIMDvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjIMDvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:10 -0400
Received: from out-220.mta0.migadu.com (out-220.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E8172B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:51:06 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wk0aXTAElE79+EX7YkShEQJOBh1Ww7m9AhWaKXcP+HU=;
        b=xAb+4CRXl0hHZ6+fRJK4pT0roSElfuf4R2pSRDncD3ZGoXAM/BCgeVEQJfzSO4+mjVolxj
        HBS0nBYli2a5V2fjVt0n3kZnfC9beSXrsOpRbZratcNVg4jSHuAw1d+UDv6syvmKfA35Z6
        sxHV1/I88dkcpLLzcZVbdmLPJLHNeGs=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 1/6] blk-mq-tag: support queue filter in bt_tags_iter()
Date:   Wed, 13 Sep 2023 03:50:28 +0000
Message-Id: <20230913035033.1549277-2-chengming.zhou@linux.dev>
In-Reply-To: <20230913035033.1549277-1-chengming.zhou@linux.dev>
References: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The only user of bt_for_each() is blk_mq_queue_tag_busy_iter(), which
need to filter queue when iterate the tags. In preparation of removing
bt_for_each(), support queue filter in bt_tags_iter().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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
2.40.1

