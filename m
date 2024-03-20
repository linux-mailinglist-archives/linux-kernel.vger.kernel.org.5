Return-Path: <linux-kernel+bounces-108362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559A288099C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7957C1C221F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948D101C6;
	Wed, 20 Mar 2024 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIokp8Jc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21EF9CC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902106; cv=none; b=UZoWUTYXHVhtRA+3Pmo0Lzngfw3vNxEqn8103gqR2AsOMuVWOQGMuihuE35/3I7p7+Wj1epP65YbEO6T3vdXu5SLoaRDAFRW8B56s2RjjQ2r2eSspZ3pzGuNyRZQKV4tJ0WBxrG/FC6ADxtBP+sX9/AhV1RCgcMS1hg51ANnc2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902106; c=relaxed/simple;
	bh=+FtuJcZDjYoxsHOkuHssLwtOO/q/pOEiv8h2bj3wQ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlohffZ6JTWqrgnwIHoPeIUoz9cLYd6MfK8gKYwAeMi9a3ur4s47FuaFP/AQRvE40OYVBzSlv05RhqdKEhbJCGtAOJKy5InCC1yTs6fZ2OBEWbGwUQ4ujJeS9EdEFvRbfJ9+9auIPQrVzjONhe+zvl+nBGKt+0EduAs6RG8ydGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIokp8Jc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710902103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iVOnpgBiHQNqWMYuUycLlmKFbOhzuiuFaGVkmq39BWM=;
	b=jIokp8JcZt2kjmNg+iRRJJUhy17+CU4hIXHmzPWeP7fiyjClPRXRB2rmUQYZ205accsFy8
	4plu8122cb9x06yYxoBfrGAEi/U1mmat6F8+5Iy7E/4GnD16X5cSlcBQvgzKZ0/i0x70pF
	hSz6k1PSouQuBtBa3ixV6eWOWRj661c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-OXVIwTu-PCOkEDm8GDOAyw-1; Tue, 19 Mar 2024 22:35:00 -0400
X-MC-Unique: OXVIwTu-PCOkEDm8GDOAyw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A938007A1;
	Wed, 20 Mar 2024 02:34:59 +0000 (UTC)
Received: from localhost (hp-dl380g10-01.lab.eng.pek2.redhat.com [10.73.196.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8CED5492BD3;
	Wed, 20 Mar 2024 02:34:58 +0000 (UTC)
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
Subject: [PATCH V4] blk-mq: don't schedule block kworker on isolated CPUs
Date: Wed, 20 Mar 2024 10:34:46 +0800
Message-ID: <20240320023446.882006-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

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
Tested-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V4:
	- improve comment & commit log as suggested by Tim
V3:
	- avoid to check invalid cpu as reported by Bart
	- take current cpu(to be offline, not done yet) into account
	- simplify blk_mq_hctx_has_online_cpu()

V2:
	- remove module parameter, meantime use queue map to check if
	all cpus in one hctx are offline

 block/blk-mq.c | 51 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 555ada922cf0..187fbfacb397 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -28,6 +28,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/sched/isolation.h>
 
 #include <trace/events/block.h>
 
@@ -2179,7 +2180,11 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 	bool tried = false;
 	int next_cpu = hctx->next_cpu;
 
-	if (hctx->queue->nr_hw_queues == 1)
+	/*
+	 * Switch to unbound work if all CPUs in this hw queue fall
+	 * into isolated CPUs
+	 */
+	if (hctx->queue->nr_hw_queues == 1 || next_cpu >= nr_cpu_ids)
 		return WORK_CPU_UNBOUND;
 
 	if (--hctx->next_cpu_batch <= 0) {
@@ -3488,14 +3493,30 @@ static bool blk_mq_hctx_has_requests(struct blk_mq_hw_ctx *hctx)
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
+	 * hctx->cpumask has rule out isolated CPUs, but userspace still
+	 * might submit IOs on these isolated CPUs, so use queue map to
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
@@ -3503,8 +3524,7 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
-	if (!cpumask_test_cpu(cpu, hctx->cpumask) ||
-	    !blk_mq_last_cpu_in_hctx(cpu, hctx))
+	if (blk_mq_hctx_has_online_cpu(hctx, cpu))
 		return 0;
 
 	/*
@@ -3912,6 +3932,8 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 	}
 
 	queue_for_each_hw_ctx(q, hctx, i) {
+		int cpu;
+
 		/*
 		 * If no software queues are mapped to this hardware queue,
 		 * disable it and free the request entries.
@@ -3938,6 +3960,15 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		 */
 		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
 
+		/*
+		 * Rule out isolated CPUs from hctx->cpumask to avoid
+		 * running run wq worker on isolated CPU
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


