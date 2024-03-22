Return-Path: <linux-kernel+bounces-110875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14885886518
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 03:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A061C225E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20B51A38FE;
	Fri, 22 Mar 2024 02:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IsKXOYEO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EB453A6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711073585; cv=none; b=sYUr7B1R6jYttDeOFU92grm9QXxGb1/N8/VSa/ODLFdrgrWSjEC8EJfQVANzlYQsX5hYPiBobvAr9bAIjiZr+Elh5ciVWnsGJXrLqSb5pc5XFsEILbcmHdzcPJWp7uIU89gXbRqzrkOfYqvhyRdr/jPNLVJ6pPPVy/s3PfgjXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711073585; c=relaxed/simple;
	bh=rmNODrghnbesIeDPV/RTWbbPsoPevkCrra+Ef1UEf/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIbevdSjKcbbdHcH5Ok3mjBAZ7EGzRCj+pvD3v7/+i3A0GzbBYV1jNy0OBUrToro1mQu0LbnthM0RY6IW3LlmOuuEwU0X+iC+QDCysYYwbiucOeSTVN+KlQ37/zXPhoxpRF7ac1rbJ92zwoPXJ33WPSURiblhGcRMrmph07T68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IsKXOYEO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711073581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u24w++o8Fciu+sjJN4D74nc+aztaWjGLyppfVLTmswY=;
	b=IsKXOYEOFOPr4apFBwWJhsor6jQfYX9hw24W2UATKKIMVfSt3IYk2fKww74AedGVHHDtUL
	rVrsA2PzzO3ZWf/S18ck1u+kyjYTL1luw2oBQ4/oV6jUOciB4C12o2dwhZV3PKdXHppkO4
	TiO6WgpysotqL8uK73sxY+jsjI1aFhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-bbBtsjmNMqywz7c-g3W3Pw-1; Thu, 21 Mar 2024 22:12:59 -0400
X-MC-Unique: bbBtsjmNMqywz7c-g3W3Pw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 100698007A2;
	Fri, 22 Mar 2024 02:12:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B72C4107AA;
	Fri, 22 Mar 2024 02:12:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Andrew Theurer <atheurer@redhat.com>,
	Joe Mario <jmario@redhat.com>,
	Sebastian Jug <sejug@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH V5] blk-mq: don't schedule block kworker on isolated CPUs
Date: Fri, 22 Mar 2024 10:12:44 +0800
Message-ID: <20240322021244.1056223-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Kernel parameter of `isolcpus=` or 'nohz_full=' are used to isolate CPUs
for specific task, and it isn't expected to let block IO disturb these CPUs.
blk-mq kworker shouldn't be scheduled on isolated CPUs. Also if isolated
CPUs is run for blk-mq kworker, long block IO latency can be caused.

Kernel workqueue only respects CPU isolation for WQ_UNBOUND, for bound
WQ, the responsibility is on user because CPU is specified as WQ API
parameter, such as mod_delayed_work_on(cpu), queue_delayed_work_on(cpu)
and queue_work_on(cpu).

So not run blk-mq kworker on isolated CPUs by removing isolated CPUs
from hctx->cpumask. Meantime use queue map to check if all CPUs in this
hw queue are offline instead of hctx->cpumask, this way can avoid any
cost in fast IO code path, and is safe since hctx->cpumask are only
used in the two cases.

Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrew Theurer <atheurer@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Sebastian Jug <sejug@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Tejun Heo <tj@kernel.org>
Tesed-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V5:
	- fix comment
	- add one helper for document benefit
	- all are suggested by Jens
V4:
	- improve comment & commit log as suggested by Tim
V3:
	- avoid to check invalid cpu as reported by Bart
	- take current cpu(to be offline, not done yet) into account
	- simplify blk_mq_hctx_has_online_cpu()

V2:
	- remove module parameter, meantime use queue map to check if
	all cpus in one hctx are offline


 block/blk-mq.c | 57 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 555ada922cf0..06cd9c8068fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -28,6 +28,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/sched/isolation.h>
 
 #include <trace/events/block.h>
 
@@ -2168,6 +2169,15 @@ static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
 	return cpu;
 }
 
+/*
+ * ->next_cpu is always calculated from hctx->cpumask, so simply use
+ * it for speeding up the check
+ */
+static bool blk_mq_hctx_empty_cpumask(struct blk_mq_hw_ctx *hctx)
+{
+        return hctx->next_cpu >= nr_cpu_ids;
+}
+
 /*
  * It'd be great if the workqueue API had a way to pass
  * in a mask and had some smarts for more clever placement.
@@ -2179,7 +2189,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
-	if (hctx->queue->nr_hw_queues == 1)
+	/* Switch to unbound if no allowable CPUs in this hctx */
+	if (hctx->queue->nr_hw_queues == 1 || blk_mq_hctx_empty_cpumask(hctx))
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
@@ -3488,14 +3499,30 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
 	return data.has_rq;
 }
 
-static inline bool blk_mq_last_cpu_in_hctx(unsigned int cpu,
-		struct blk_mq_hw_ctx *hctx)
+static bool blk_mq_hctx_has_online_cpu(struct blk_mq_hw_ctx *hctx,
+		unsigned int this_cpu)
 {
-	if (cpumask_first_and(hctx->cpumask, cpu_online_mask) != cpu)
-		return false;
-	if (cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask) < nr_cpu_ids)
-		return false;
-	return true;
+	enum hctx_type type = hctx->type;
+	int cpu;
+
+	/*
+	 * hctx->cpumask has to rule out isolated CPUs, but userspace still
+	 * might submit IOs on these isolated CPUs, so use the queue map to
+	 * check if all CPUs mapped to this hctx are offline
+	 */
+	for_each_online_cpu(cpu) {
+		struct blk_mq_hw_ctx *h = blk_mq_map_queue_type(hctx->queue,
+				type, cpu);
+
+		if (h != hctx)
+			continue;
+
+		/* this hctx has at least one online CPU */
+		if (this_cpu != cpu)
+			return true;
+	}
+
+	return false;
 }
 
 static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
@@ -3503,8 +3530,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
-	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
-	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
+	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
 		return 0;
 
 	/*
@@ -3912,6 +3938,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
+		int cpu;
+
 		/*
 		 * If no software queues are mapped to this hardware queue,
 		 * disable it and free the request entries.
@@ -3938,6 +3966,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		 */
 		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
 
+		/*
+		 * Rule out isolated CPUs from hctx->cpumask to avoid
+		 * running block kworker on isolated CPUs
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


