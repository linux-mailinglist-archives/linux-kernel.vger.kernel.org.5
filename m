Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6659E755A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjGQEBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGQEBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:01:44 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD311BC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:01:43 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689566501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pFXxdBNitgVGeb7jBJprwYc2SHfcR9ZpmuG2rofSs+Y=;
        b=aS4UxvHW74aNMeRLZvydKEju8QtYZX1rq7sUBQyrdw3ssRMah0U3Ms/FhSKdxr95m8UelC
        vvhsbRDT0jZse4zpCCnho2PyeLd7OduBgtBI3TyYuXW/WKAQWkpD/lHoT66Hx8WAHO8ulG
        zwfulZcJCFUrhltkkZkq/xBWyVjG3LQ=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v4 1/4] blk-mq: use percpu csd to remote complete instead of per-rq csd
Date:   Mon, 17 Jul 2023 12:00:55 +0800
Message-ID: <20230717040058.3993930-2-chengming.zhou@linux.dev>
In-Reply-To: <20230717040058.3993930-1-chengming.zhou@linux.dev>
References: <20230717040058.3993930-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If request need to be completed remotely, we insert it into percpu llist,
and smp_call_function_single_async() if llist is empty previously.

We don't need to use per-rq csd, percpu csd is enough. And the size of
struct request is decreased by 24 bytes.

This way is cleaner, and looks correct, given block softirq is guaranteed
to be scheduled to consume the list if one new request is added to this
percpu list, either smp_call_function_single_async() returns -EBUSY or 0.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 12 ++++++------
 include/linux/blk-mq.h |  5 +----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d50b1d62a3d9..d98654869615 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 #include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
+static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -1157,15 +1158,11 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 
 static void blk_mq_complete_send_ipi(struct request *rq)
 {
-	struct llist_head *list;
 	unsigned int cpu;
 
 	cpu = rq->mq_ctx->cpu;
-	list = &per_cpu(blk_cpu_done, cpu);
-	if (llist_add(&rq->ipi_list, list)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
-	}
+	if (llist_add(&rq->ipi_list, &per_cpu(blk_cpu_done, cpu)))
+		smp_call_function_single_async(cpu, &per_cpu(blk_cpu_csd, cpu));
 }
 
 static void blk_mq_raise_softirq(struct request *rq)
@@ -4829,6 +4826,9 @@ static int __init blk_mq_init(void)
 
 	for_each_possible_cpu(i)
 		init_llist_head(&per_cpu(blk_cpu_done, i));
+	for_each_possible_cpu(i)
+		INIT_CSD(&per_cpu(blk_cpu_csd, i),
+			 __blk_mq_complete_request_remote, NULL);
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b96e00499f9e..67f810857634 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -182,10 +182,7 @@ struct request {
 		rq_end_io_fn		*saved_end_io;
 	} flush;
 
-	union {
-		struct __call_single_data csd;
-		u64 fifo_time;
-	};
+	u64 fifo_time;
 
 	/*
 	 * completion callback.
-- 
2.41.0

