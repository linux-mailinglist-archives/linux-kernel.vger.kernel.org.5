Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509EC77C771
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbjHOGHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235101AbjHOGGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:06:53 -0400
Received: from out-81.mta1.migadu.com (out-81.mta1.migadu.com [95.215.58.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB410F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 23:05:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692079529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wWsB6kltJ58XUaHsFfqL6Q4RJBmpJEQuaQ5cbRsruY0=;
        b=NUHbtoXEkOC8aBNe94FABWlMwijvoLrxPXdAz3cp2t7x8mszPyYnRShHVoRdYT3qPD5tLB
        +t02N9eyMZwIdEVE0NAV0OYK/eOF+laBK0+x0X9i+s1cJD4ynQ8cAhQyrn2ia3XJBfoZ/v
        /D2RPLbW1RgSe4Az0tdTxRbZd0eUSZw=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, kch@nvidia.com, dhowells@redhat.com
Cc:     damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
        nj.shetty@samsung.com, kbusch@kernel.org,
        zhouchengming@bytedance.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] null_blk: fix poll request timeout handling
Date:   Tue, 15 Aug 2023 14:04:42 +0800
Message-ID: <20230815060443.660263-1-chengming.zhou@linux.dev>
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

When doing io_uring benchmark on /dev/nullb0, it's easy to crash the
kernel if poll requests timeout triggered, as reported by David. [1]

BUG: kernel NULL pointer dereference, address: 0000000000000008
Workqueue: kblockd blk_mq_timeout_work
RIP: 0010:null_timeout_rq+0x4e/0x91
Call Trace:
 ? __die_body+0x1a/0x5c
 ? page_fault_oops+0x6f/0x9c
 ? kernelmode_fixup_or_oops+0xc6/0xd6
 ? __bad_area_nosemaphore+0x44/0x1eb
 ? exc_page_fault+0xe2/0xf4
 ? asm_exc_page_fault+0x22/0x30
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
 ? rescuer_thread+0x287/0x287
 kthread+0xfa/0x102
 ? kthread_complete_and_exit+0x1b/0x1b
 ret_from_fork+0x22/0x30

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

What's worse is that we don't call blk_mq_complete_request_remote()
before blk_mq_add_to_batch(), so these completed requests have wrong
rq->state == MQ_RQ_IN_FLIGHT. We can easily check this using bpftrace:

```
bpftrace -e 'kretfunc:null_blk:null_poll {
  $iob=(struct io_comp_batch *)args->iob;
  @[$iob->req_list->state]=count();
}'

@[1]: 51708
```

Fix these problems by setting requests state to MQ_RQ_COMPLETE under
nq->poll_lock protection, in which null_timeout_rq() can safely detect
this race and early return.

[1] https://lore.kernel.org/all/3893581.1691785261@warthog.procyon.org.uk/

Fixes: 0a593fbbc245 ("null_blk: poll queue support")
Reported-by: David Howells <dhowells@redhat.com>
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

