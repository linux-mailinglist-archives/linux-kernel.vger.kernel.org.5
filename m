Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA70578FCE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbjIAMEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349325AbjIAMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:04:19 -0400
Received: from out-240.mta1.migadu.com (out-240.mta1.migadu.com [IPv6:2001:41d0:203:375::f0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B291
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:04:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693569852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLsG099Z2LegFBqk4mtUwChsd4QinWx9wD5fWTNkaI0=;
        b=cEzT2wEtNwyib/T1LXzCcsLjzrQCkNSLIQREK9UH61WZNAU8CFhI8VxOMfeXm0O88MTUzq
        Lb4VU8ROjRPl7NrjaUQut59r5VfLg7Ci5Mls8E0kKgzSDL4h0Cu3f3Wp7e1bE9pgPvQMSo
        icYGd/MZt37OQbcd6ib5/KV+CisQeLQ=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com, dhowells@redhat.com
Subject: [PATCH v2 1/1] null_blk: fix poll request timeout handling
Date:   Fri,  1 Sep 2023 20:03:06 +0800
Message-ID: <20230901120306.170520-2-chengming.zhou@linux.dev>
In-Reply-To: <20230901120306.170520-1-chengming.zhou@linux.dev>
References: <20230901120306.170520-1-chengming.zhou@linux.dev>
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

When doing io_uring benchmark on /dev/nullb0, it's easy to crash the
kernel if poll requests timeout triggered, as reported by David. [1]

BUG: kernel NULL pointer dereference, address: 0000000000000008
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:null_timeout_rq+0x4e/0x91
Call Trace:
 ? null_timeout_rq+0x4e/0x91
 blk_mq_handle_expired+0x31/0x4b
 bt_iter+0x68/0x84
 ? bt_tags_iter+0x81/0x81
 __sbitmap_for_each_set.constprop.0+0xb0/0xf2
 ? __blk_mq_complete_request_remote+0xf/0xf
 bt_for_each+0x46/0x64
 ? __blk_mq_complete_request_remote+0xf/0xf
 ? percpu_ref_get_many+0xc/0x2a
 blk_mq_queue_tag_busy_iter+0x14d/0x18e
 blk_mq_timeout_work+0x95/0x127
 process_one_work+0x185/0x263
 worker_thread+0x1b5/0x227

This is indeed a race problem between null_timeout_rq() and null_poll().

null_poll()				null_timeout_rq()
  spin_lock(&nq->poll_lock)
  list_splice_init(&nq->poll_list, &list)
  spin_unlock(&nq->poll_lock)

  while (!list_empty(&list))
    req = list_first_entry()
    list_del_init()
    ...
    blk_mq_add_to_batch()
    // req->rq_next = NULL
					spin_lock(&nq->poll_lock)

					// rq->queuelist->next == NULL
					list_del_init(&rq->queuelist)

					spin_unlock(&nq->poll_lock)

Fix these problems by setting requests state to MQ_RQ_COMPLETE under
nq->poll_lock protection, in which null_timeout_rq() can safely detect
this race and early return.

Note this patch just fix the kernel panic when request timeout happen.

[1] https://lore.kernel.org/all/3893581.1691785261@warthog.procyon.org.uk/

Fixes: 0a593fbbc245 ("null_blk: poll queue support")
Reported-by: David Howells <dhowells@redhat.com>
Tested-by: David Howells <dhowells@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 drivers/block/null_blk/main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 864013019d6b..968090935eb2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1643,9 +1643,12 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	struct nullb_queue *nq = hctx->driver_data;
 	LIST_HEAD(list);
 	int nr = 0;
+	struct request *rq;
 
 	spin_lock(&nq->poll_lock);
 	list_splice_init(&nq->poll_list, &list);
+	list_for_each_entry(rq, &list, queuelist)
+		blk_mq_set_request_complete(rq);
 	spin_unlock(&nq->poll_lock);
 
 	while (!list_empty(&list)) {
@@ -1671,16 +1674,21 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
 
-	pr_info("rq %p timed out\n", rq);
-
 	if (hctx->type == HCTX_TYPE_POLL) {
 		struct nullb_queue *nq = hctx->driver_data;
 
 		spin_lock(&nq->poll_lock);
+		/* The request may have completed meanwhile. */
+		if (blk_mq_request_completed(rq)) {
+			spin_unlock(&nq->poll_lock);
+			return BLK_EH_DONE;
+		}
 		list_del_init(&rq->queuelist);
 		spin_unlock(&nq->poll_lock);
 	}
 
+	pr_info("rq %p timed out\n", rq);
+
 	/*
 	 * If the device is marked as blocking (i.e. memory backed or zoned
 	 * device), the submission path may be blocked waiting for resources
-- 
2.41.0

