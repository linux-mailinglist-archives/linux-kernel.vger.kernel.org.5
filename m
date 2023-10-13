Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02B7C8617
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjJMMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjJMMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED108BE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697201291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h78T/7NPGQz52SHwxHI3clyF7jiR025tvOcU1xIze+A=;
        b=FRPdpewyp5EOGrYQwJt5n8PRMABbAo3+E2zVJgqT236jBdRCSwtqaZOqtK2RMzKI0Aqab6
        Sce2WJbzorrFBAb3sHB12dEQxEtNAw05cN8oxQMtlTzOflfWy2l9lwdfAIOLAaXAUMg5x8
        DQwwEHUN8g8mCdmdcH0ZBMAynkMuLyk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-0i1UD0zaOym2JiTld1dkKQ-1; Fri, 13 Oct 2023 08:48:08 -0400
X-MC-Unique: 0i1UD0zaOym2JiTld1dkKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 921211C00D21;
        Fri, 13 Oct 2023 12:48:07 +0000 (UTC)
Received: from localhost (unknown [10.72.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FA2D492BFA;
        Fri, 13 Oct 2023 12:48:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH V2] blk-mq: don't schedule block kworker on isolated CPUs
Date:   Fri, 13 Oct 2023 20:47:58 +0800
Message-ID: <20231013124758.1492796-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel parameter of `isolcpus=` or 'nohz_full=' are used for isolating CPUs
for specific task, and user often won't want block IO to disturb these CPUs,
also long IO latency may be caused if blk-mq kworker is scheduled on these
isolated CPUs.

Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
the responsibility should be on wq user.

So don't not run block kworker on isolated CPUs by ruling out isolated CPUs
from hctx->cpumask. Meantime in cpuhp handler, use queue map to check if
all CPUs in this hw queue are offline, this way can avoid any cost in fast
IO code path.

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrew Theurer <atheurer@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Sebastian Jug <sejug@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove module parameter, meantime use queue map to check if
	all cpus in one hctx are offline

 block/blk-mq.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec922c6bccbe..91055bdc4426 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/sched/isolation.h>
 
 #include <trace/events/block.h>
 
@@ -3476,14 +3477,27 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
-static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
-		struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx)
 {
-	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
-		return false;
-	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
-		return false;
-	return true;
+	struct blk_mq_tag_set *tag_set = hctx->queue->tag_set;
+	int cpu;
+
+	/*
+	 * hctx->cpumask has rule out isolated CPUs, but userspace still
+	 * might submit IOs on these isolated CPUs, so use queue map to
+	 * check if all CPUs mapped to this hctx are offline
+	 */
+	for_each_possible_cpu(cpu) {
+		unsigned idx = tag_set->map[hctx->type].mq_map[cpu];
+
+		if (idx != hctx->queue_num)
+			continue;
+
+		if (cpu_online(cpu))
+			return true;
+	}
+
+	return false;
 }
 
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
@@ -3491,8 +3505,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
-	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
-	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
+	if (blk_mq_hctx_has_online_cpu(hctx))
 		return 0;
 
 	/*
@@ -3900,6 +3913,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
+		int cpu;
+
 		/*
 		 * If no software queues are mapped to this hardware queue,
 		 * disable it and free the request entries.
@@ -3926,6 +3941,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		 */
 		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
 
+		/*
+		 * rule out isolated CPUs from hctx->cpumask for avoiding to
+		 * run wq worker on isolated CPU
+		 */
+		for_each_cpu(cpu, hctx->cpumask) {
+			if (cpu_is_isolated(cpu))
+				cpumask_clear_cpu(cpu, hctx->cpumask);
+		}
+
 		/*
 		 * Initialize batch roundrobin counts
 		 */
-- 
2.41.0

