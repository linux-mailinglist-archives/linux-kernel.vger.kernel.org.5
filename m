Return-Path: <linux-kernel+bounces-49442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B2846A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA68F1F295D8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D44F1AAD7;
	Fri,  2 Feb 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3ZpuSiS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9086E19477
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861453; cv=none; b=Xbv6Hkh1+4Wa87hU/AfTGrhyqTHBe34FkbhB9QXeDEfiPdaJ+AWajiQnB1juVlFTC88SgLf7aKNeARRAjWEi1dVlVwo3EDzklkXWhpqkNVqpKIwBdvyAtcamC3f3bL57x8pF+325eEj44k03JVOD+VWCnAhEI6IJUe/OXvTCG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861453; c=relaxed/simple;
	bh=dWuR9UQw2rwTVshyZQG5PCMcxyEdawkP54MOYUetJAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB3w/RGRzNdwRlPgTiGybUFW0vFZ+O41iw8Xq1ZsTFiQt/f/SRsPDAVIGmoKbMkcJU/TQ9n9+rl2ijwXf7GNO0dNdkaYQaxJffse7s1LcIksibw2oq4yP32ZT5Z0CVizexecHKd6SDVsTlzcst5tWGC9cqnvIAetMldLypjIbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3ZpuSiS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706861450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxaIkJskuFw38ApXZhFFaPGSaq/2ThOojlsU5lw5wRE=;
	b=N3ZpuSiSogq4Fzc3MLaKHNggOKGsr76/9qDKxi11ss+02s+Wy4SPjACFD4rjrS/gq/3HMy
	Mx2izwBJoIhvuqJPjmer9qYtFByOYBYG1TRGX5jG3upGzeVvRxdONUtihwoeSvkrkUF8VG
	y7QyhvAXiGX7MkJdMmAFQ1Gnz2S6y5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319--CXo1PhyNSiCukS3YGEorQ-1; Fri, 02 Feb 2024 03:10:46 -0500
X-MC-Unique: -CXo1PhyNSiCukS3YGEorQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E676D1013663;
	Fri,  2 Feb 2024 08:10:45 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 59EE0C2590E;
	Fri,  2 Feb 2024 08:10:43 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH v2 3/5] sched/fair: Delete cfs_rq_throttled_loose(), use cfs_rq->throttle_pending instead
Date: Fri,  2 Feb 2024 09:09:18 +0100
Message-ID: <20240202080920.3337862-4-vschneid@redhat.com>
In-Reply-To: <20240202080920.3337862-1-vschneid@redhat.com>
References: <20240202080920.3337862-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

cfs_rq_throttled_loose() does not check if there is runtime remaining in
the cfs_b, and thus relies on check_cfs_rq_runtime() being ran previously
for that to be checked.

Cache the throttle attempt in throttle_cfs_rq and reuse that where
needed.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 44 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96504be6ee14a..60778afbff207 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5462,7 +5462,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * 5) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
+pick_next_entity(struct cfs_rq *cfs_rq)
 {
 #ifdef CONFIG_CFS_BANDWIDTH
 	/*
@@ -5473,7 +5473,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, bool throttled)
 	 * throttle_cfs_rq.
 	 */
 	WARN_ON_ONCE(list_empty(&cfs_rq->kernel_children));
-	if (throttled && !list_empty(&cfs_rq->kernel_children)) {
+	if (cfs_rq->throttle_pending && !list_empty(&cfs_rq->kernel_children)) {
 		/*
 		 * TODO: you'd want to factor out pick_eevdf to just take
 		 * tasks_timeline, and replace this list with a second rbtree
@@ -5791,8 +5791,12 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * We don't actually throttle, though account() will have made sure to
 	 * resched us so that we pick into a kernel task.
 	 */
-	if (cfs_rq->h_kernel_running)
+	if (cfs_rq->h_kernel_running) {
+		cfs_rq->throttle_pending = true;
 		return false;
+	}
+
+	cfs_rq->throttle_pending = false;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -6666,20 +6670,6 @@ static void dequeue_kernel(struct cfs_rq *cfs_rq, struct sched_entity *se, int c
 	cfs_rq->h_kernel_running -= count;
 }
 
-/*
- * Returns if the cfs_rq "should" be throttled but might not be because of
- * kernel threads bypassing throttle.
- */
-static bool cfs_rq_throttled_loose(struct cfs_rq *cfs_rq)
-{
-	if (!cfs_bandwidth_used())
-		return false;
-
-	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
-		return false;
-	return true;
-}
-
 static void unthrottle_on_enqueue(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
@@ -8546,7 +8536,6 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
-	bool throttled = false;
 
 again:
 	cfs_rq = &rq->cfs;
@@ -8567,10 +8556,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 				goto again;
 		}
 
-		if (cfs_rq_throttled_loose(cfs_rq))
-			throttled = true;
-
-		se = pick_next_entity(cfs_rq, throttled);
+		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8585,7 +8571,6 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	struct sched_entity *se;
 	struct task_struct *p;
 	int new_tasks;
-	bool throttled;
 
 	/*
 	 * We want to handle this before check_cfs_runtime(prev). We'll
@@ -8609,8 +8594,6 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	 * Therefore attempt to avoid putting and setting the entire cgroup
 	 * hierarchy, only change the part that actually changes.
 	 */
-
-	throttled = false;
 	do {
 		struct sched_entity *curr = cfs_rq->curr;
 
@@ -8641,11 +8624,7 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 				goto simple;
 			}
 		}
-
-		if (cfs_rq_throttled_loose(cfs_rq))
-			throttled = true;
-
-		se = pick_next_entity(cfs_rq, throttled);
+		se = pick_next_entity(cfs_rq);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
@@ -8683,11 +8662,8 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 	if (prev)
 		put_prev_task(rq, prev);
 
-	throttled = false;
 	do {
-		if (cfs_rq_throttled_loose(cfs_rq))
-			throttled = true;
-		se = pick_next_entity(cfs_rq, throttled);
+		se = pick_next_entity(cfs_rq);
 		set_next_entity(cfs_rq, se);
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
-- 
2.43.0


