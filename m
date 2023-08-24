Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B0578721D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbjHXOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241749AbjHXOpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:45:34 -0400
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [95.215.58.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A299A1BC6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:45:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692888330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KuUH+9zTpQHPAacq3J8wMyhnGazr4U6zklKopxDD0no=;
        b=nQd1/FwzjzBFi7rMxNcNiH+nJ08oYnR89VYgKO2z6iN1+2H5zVbUphrNLZ+n1fVUXYQHqz
        fHhAdGpe+xkMok57NI7IWItVvXkPAhc32VIii9eqjap3szb7J/lQk5rqsAywa6VAmMKVqK
        o/vCJY4RvmF4WMsMfmYiXwLFstL5JlM=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        bvanassche@acm.org, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: [PATCH 6/6] block/null_blk: add queue_rqs() support
Date:   Thu, 24 Aug 2023 22:44:03 +0800
Message-ID: <20230824144403.2135739-7-chengming.zhou@linux.dev>
In-Reply-To: <20230824144403.2135739-1-chengming.zhou@linux.dev>
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 864013019d6b..1b1b58d36707 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1742,6 +1742,25 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
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
+		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
+			rq_list_add_tail(&requeue_lastp, rq);
+	} while (!rq_list_empty(*rqlist));
+
+	*rqlist = requeue_list;
+}
+
 static void cleanup_queue(struct nullb_queue *nq)
 {
 	bitmap_free(nq->tag_map);
@@ -1794,6 +1813,7 @@ static int null_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 
 static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
+	.queue_rqs	= null_queue_rqs,
 	.complete	= null_complete_rq,
 	.timeout	= null_timeout_rq,
 	.poll		= null_poll,
-- 
2.41.0

