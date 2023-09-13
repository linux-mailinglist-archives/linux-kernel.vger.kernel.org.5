Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEAA79EC67
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241680AbjIMPRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbjIMPQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:16:46 -0400
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [IPv6:2001:41d0:203:375::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3633EDF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:16:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694618200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCOMDgQx+bgpwKLnJ2wBA8f+pdNiIK3o3ggHoT0hM7g=;
        b=tTN41pCZ//w5UNw1GVbdKGdqCSWpAtDlyNGtHOLmA/YyKL9qApU6+LurZMfZ+k7Lyhit9u
        ULGyDYi6YxwhAFwIanaBI2Eeg/Og6Ph7SECgHyu9Uc2MVF9JKexnFtaoBaVl9EOFG9WDv/
        0BvG7Xgr04o7ABH9n1TVozi+Y8JsEYQ=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org
Cc:     kbusch@kernel.org, mst@redhat.com,
        damien.lemoal@opensource.wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 5/5] block/null_blk: add queue_rqs() support
Date:   Wed, 13 Sep 2023 15:16:16 +0000
Message-Id: <20230913151616.3164338-6-chengming.zhou@linux.dev>
In-Reply-To: <20230913151616.3164338-1-chengming.zhou@linux.dev>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Add batched mq_ops.queue_rqs() support in null_blk for testing. The
implementation is much easy since null_blk doesn't have commit_rqs().

We simply handle each request one by one, if errors are encountered,
leave them in the passed in list and return back.

There is about 3.6% improvement in IOPS of fio/t/io_uring on null_blk
with hw_queue_depth=256 on my test VM, from 1.09M to 1.13M.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 drivers/block/null_blk/main.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 968090935eb2..79d6cd3c3d41 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1750,6 +1750,25 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
 }
 
+static void null_queue_rqs(struct request **rqlist)
+{
+	struct request *requeue_list = NULL;
+	struct request **requeue_lastp = &requeue_list;
+	struct blk_mq_queue_data bd = { };
+	blk_status_t ret;
+
+	do {
+		struct request *rq = rq_list_pop(rqlist);
+
+		bd.rq = rq;
+		ret = null_queue_rq(rq->mq_hctx, &bd);
+		if (ret != BLK_STS_OK)
+			rq_list_add_tail(&requeue_lastp, rq);
+	} while (!rq_list_empty(*rqlist));
+
+	*rqlist = requeue_list;
+}
+
 static void cleanup_queue(struct nullb_queue *nq)
 {
 	bitmap_free(nq->tag_map);
@@ -1802,6 +1821,7 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 
 static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
+	.queue_rqs	= null_queue_rqs,
 	.complete	= null_complete_rq,
 	.timeout	= null_timeout_rq,
 	.poll		= null_poll,
-- 
2.40.1

