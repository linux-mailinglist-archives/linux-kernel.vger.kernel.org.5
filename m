Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3FE79EC69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbjIMPRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbjIMPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:41 -0400
Received: from out-227.mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16861B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:16:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694618195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0/BBRvz91/qS3KlzgnvKJU+Ez3qMEnH1nXMNaUxqVE0=;
        b=F4q3Ygj6OhewGfFQk8HXu//5xlTYgIC1sqR6KVRQA0SVq6L0RiUD/ZRfRu1NkH95snA+s5
        woXrvUBK7WVCG2aACvaVJKPnZ7UHGDwOPfJcKH9deghCemJVWWxDZ1PVKJ/Jg5WEa9Ni0W
        MpDPeTrjt51ApEQrfPSEPDq7qam3WVY=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     kbusch@kernel.org, mst@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 3/5] blk-mq: support batched queue_rqs() on shared tags queue
Date:   Wed, 13 Sep 2023 15:16:14 +0000
Message-Id: <20230913151616.3164338-4-chengming.zhou@linux.dev>
In-Reply-To: <20230913151616.3164338-1-chengming.zhou@linux.dev>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Since active requests have been accounted when allocate driver tags,
we can remove this limit now.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c209a7dddee3..68ce9357463b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2781,13 +2781,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 		 * If we do, we can dispatch the whole plug list in one go. We
 		 * already know at this point that all requests belong to the
 		 * same queue, caller must ensure that's the case.
-		 *
-		 * Since we pass off the full list to the driver at this point,
-		 * we do not increment the active request count for the queue.
-		 * Bypass shared tags for now because of that.
 		 */
-		if (q->mq_ops->queue_rqs &&
-		    !(rq->mq_hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED)) {
+		if (q->mq_ops->queue_rqs) {
 			blk_mq_run_dispatch_ops(q,
 				__blk_mq_flush_plug_list(q, plug));
 			if (rq_list_empty(plug->mq_list))
-- 
2.40.1

