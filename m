Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B353579DEC6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbjIMDv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbjIMDvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:51:19 -0400
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [91.218.175.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED0A173C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 20:51:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694577069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CwOToPUftF0QYoHtVkc85ZdKan8gl08CbzCEbRbTyKA=;
        b=aKCAzuHc3FjbIB54vrQc5onYeA8q2UVdaWLmog2d/11qaoDItd1QfZ+kudbyz/gvqOsXMt
        ILAShXyZaHeE6/+qrx6SJtAqP187/lvCLrAlXVZzO0VISLUxn9TDX0IIS0m4OIaXwOC/4g
        RBOYyy+zxiz+Qth/sfIkfX5f0oxAVlw=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, bvanassche@acm.org,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 4/6] blk-mq: delete superfluous check in iterate callback
Date:   Wed, 13 Sep 2023 03:50:31 +0000
Message-Id: <20230913035033.1549277-5-chengming.zhou@linux.dev>
In-Reply-To: <20230913035033.1549277-1-chengming.zhou@linux.dev>
References: <20230913035033.1549277-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

The previous patch in this series changed the behavior of
blk_mq_queue_tag_busy_iter() from iterating over all allocated tags into
iterating over started requests only. Leave out the code from
blk_mq_rq_inflight() that became superfluous because of this change.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..1473b49350c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1513,19 +1513,15 @@ EXPORT_SYMBOL(blk_mq_delay_kick_requeue_list);
 
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
2.40.1

