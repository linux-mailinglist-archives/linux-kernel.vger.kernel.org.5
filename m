Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE867853D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjHWJZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbjHWJMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:12:18 -0400
Received: from out-54.mta0.migadu.com (out-54.mta0.migadu.com [91.218.175.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79E10D0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 02:05:14 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692781513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P8W3+vOTfQOXGit1QxzQtrjlMaY4uGL5zXFxfZ2DGWU=;
        b=fWrqr/S0/e4dZQuGdBtg4BfFmNqU/bFbd22dl9t+Ol5yQhPg1xah8tecQmTMQIeGxnlrv0
        cKOvwaJWF4u0MV250xC4QZuQm3Gs3MHY6nCswSWlrqeWqn16rz0wcGlkQ86xFWRz4k1ZDs
        JHzl+eGBLrLt0Z6OuDoxm4PwDBgxoXI=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 4/6] blk-mq: delete superfluous check in iterate callback
Date:   Wed, 23 Aug 2023 17:04:39 +0800
Message-ID: <20230823090441.3986631-5-chengming.zhou@linux.dev>
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

The previous patch in this series changed the behavior of
blk_mq_queue_tag_busy_iter() from iterating over all allocated tags into
iterating over started requests only. Leave out the code from
blk_mq_rq_inflight() that became superfluous because of this change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 953f08354c8c..f1bafbae0a61 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1516,19 +1516,15 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
 static bool blk_mq_rq_inflight(struct request *rq, void *priv)
 {
+	bool *busy = priv;
+
 	/*
 	 * If we find a request that isn't idle we know the queue is busy
 	 * as it's checked in the iter.
 	 * Return false to stop the iteration.
 	 */
-	if (blk_mq_request_started(rq)) {
-		bool *busy = priv;
-
-		*busy = true;
-		return false;
-	}
-
-	return true;
+	*busy = true;
+	return false;
 }
 
 bool blk_mq_queue_inflight(struct request_queue *q)
-- 
2.41.0

