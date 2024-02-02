Return-Path: <linux-kernel+bounces-49443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759DE846A61
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4421C212BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0935718AEE;
	Fri,  2 Feb 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPlur54y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536BF1AADD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861456; cv=none; b=rEqZ4EZKraYr+wtHlPrm1b/XTdZ2ICgUrQ2iRkWLmLFRPyAEll/WOm8I4yKhca9fbeh2HLuRNdnVwxPD1QfGanFvRQ/o/VKuznsz8qxqTrFFnfk1DNlHl4Qw/tQTVsvCAHmdACyI2Z+CefS0sQtBdGmePSwzekcejEtj0MtL25E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861456; c=relaxed/simple;
	bh=XSUm7ZVkUeJgzY+9JV/lu1DGc96b7lL1jb2zM9BjCJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYM2x8UDmGABzZaMedauhb3ttg72aB1JOPC0PIDNqjNE2ZS5CAde05rHAsECldeDT5BlobcKmg7d5pU8O++xrl9T8K1wJCodxjhZadJV180U9zHDo2GZD2w4Z+FcByS+fRLAsTtCmG7RMJETPaeEnCa6FZc2MENzkeygfVMk81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPlur54y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706861453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=59FY7Fjt6DUz/1aW5sr5w/uHLVwuGkenIcuvCVNSVT4=;
	b=UPlur54yBIBI1UWQTbEn1GaxfNJniS+Ptuvdfc/bT5D403PrC1lJqyuUYA09QKCJTWOEcY
	wfTbCpu66ChWChvUox8o0aYdNHgD0Yg4YRK74ihZ33nypfKia/fTWZ3vDigNOBOEZ3/PI3
	Zw1pLYz12P3HHUYf4wxeM84hzjxrjPo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-vO7VM0CHMYa-y6FzF5P9nA-1; Fri, 02 Feb 2024 03:10:48 -0500
X-MC-Unique: vO7VM0CHMYa-y6FzF5P9nA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 635D983B82B;
	Fri,  2 Feb 2024 08:10:48 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.193.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F9A0C2590D;
	Fri,  2 Feb 2024 08:10:46 +0000 (UTC)
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
Subject: [RFC PATCH v2 4/5] sched/fair: Track count of tasks running in userspace
Date: Fri,  2 Feb 2024 09:09:19 +0100
Message-ID: <20240202080920.3337862-5-vschneid@redhat.com>
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

While having a second tree to pick from solves the throttling aspect of things,
it also requires modification of the task count at the cfs_rq level.

h_nr_running is used throughout load_balance(), and it needs to accurately
reflect the amount of pickable tasks: a cfs_rq with .throttle_pending=1 may have
many tasks in userspace (thus effectively throttled), and this "excess" of tasks
shouldn't cause find_busiest_group() / find_busiest_queue() to pick that
cfs_rq's CPU to pull load from when there are other CPUs with more pickable
tasks to pull.

The approach taken here is to track both the count of tasks in kernelspace and
the count of tasks in userspace (technically tasks-just-about-to-enter-userspace).

When a cfs_rq runs out of runtime, it gets marked as .throttle_pending=1. From
this point on, only tasks executing in kernelspace are pickable, and this is
reflected up the hierarchy by removing that cfs_rq.h_user_running from its
parents' .h_nr_running.

To aid in validating the proper behaviour of the implementation, we assert the
following invariants:
  o For any cfs_rq with .throttle_pending == 0:
    .h_kernel_running + .h_user_running == .h_nr_running
  o For any cfs_rq with .throttle_pending == 1:
    .h_kernel_running == .h_nr_running

This means the .h_user_running also needs to be updated as cfs_rq's become
throttle_pending=1. When a cfs_rq becomes .throttle_pending=1, its
h_user_running remains untouched, but it is subtracted from its parents'
h_user_running.

Another way to look at it is that the .h_user_running is "stored" at the level
of the .throttle_pending cfs_rq, and restored to the upper part of the hierarchy
at unthrottle.

An overview of the count logic is:

 Consider:
   cfs_rq.kernel := count of kernel *tasks* enqueued on this cfs_rq
   cfs_rq.user   := count of user   *tasks* enqueued on this cfs_rq

 Then, the following logic is implemented:
   cfs_rq.h_kernel_running = Sum(child.kernel) for all child cfs_rq
   cfs_rq.h_user_running   = Sum(child.user)   for all child cfs_rq with !child.throttle_pending
   cfs_rq.h_nr_running     = Sum(child.kernel) for all child cfs_rq
			   + Sum(child.user)   for all child cfs_rq with !child.throttle_pending

An application of that logic to an A/B/C cgroup hierarchy:

  Initial condition, no throttling

    +------+ .h_kernel_running = C.kernel + B.kernel + A.kernel
  A |cfs_rq| .h_user_running   = C.user   + B.user   + A.user
    +------+ .h_nr_running     = C.{kernel+user} + B.{kernel+user} + A.{kernel+user}
       ^     .throttle_pending = 0
       |
       | parent
       |
    +------+ .h_kernel_running = C.kernel + B.kernel
  B |cfs_rq| .h_user_running   = C.user   + B.user
    +------+ .h_nr_running     = C.{kernel+user} + B.{kernel+user}
       ^     .throttle_pending = 0
       |
       | parent
       |
    +------+ .h_kernel_running = C.kernel
  C |cfs_rq| .h_user_running   = C.user
    +------+ .h_nr_running     = C.{kernel+user}
	     .throttle_pending = 0

  C becomes .throttle_pending

    +------+ .h_kernel_running = C.kernel + B.kernel + A.kernel               <- Untouched
  A |cfs_rq| .h_user_running   = B.user   + A.user                            <- Decremented by C.user
    +------+ .h_nr_running     = C.kernel + B.{kernel+user} + A.{kernel+user} <- Decremented by C.user
       ^     .throttle_pending = 0
       |
       | parent
       |
    +------+ .h_kernel_running = C.kernel + B.kernel                          <- Untouched
  B |cfs_rq| .h_user_running   = B.user                                       <- Decremented by C.user
    +------+ .h_nr_running     = C.kernel + B.{kernel+user} + A.{kernel+user} <- Decremented by C.user
       ^     .throttle_pending = 0
       |
       | parent
       |
    +------+ .h_kernel_running = C.kernel
  C |cfs_rq| .h_user_running   = C.user   <- Untouched, the count is "stored" at this level
    +------+ .h_nr_running     = C.kernel <- Decremented by C.user
	     .throttle_pending = 1

  C becomes throttled

    +------+ .h_kernel_running = B.kernel + A.kernel               <- Decremented by C.kernel
  A |cfs_rq| .h_user_running   = B.user   + A.user
    +------+ .h_nr_running     = B.{kernel+user} + A.{kernel+user} <- Decremented by C.kernel
       ^     .throttle_pending = 0
       |
       | parent
       |
    +------+ .h_kernel_running = B.kernel                          <- Decremented by C.kernel
  B |cfs_rq| .h_user_running   = B.user
    +------+ .h_nr_running     = B.{kernel+user} + A.{kernel+user} <- Decremented by C.kernel
       ^     .throttle_pending = 0
       |
       | parent
       |
    +------+ .h_kernel_running = C.kernel
  C |cfs_rq| .h_user_running   = C.user
    +------+ .h_nr_running     = C.{kernel+user} <- Incremented by C.user
	     .throttle_pending = 0

Could we get away with just one count, e.g. the user count and not the kernel
count? Technically yes, we could follow this scheme:
  if (throttle_pending) => kernel count := h_nr_running - h_user_running
  else                  => kernel count := h_nr_running
this however prevents any sort of assertion or sanity checking on the counts,
which I am not the biggest fan on - CFS group scheduling is enough of a headache
as it is.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c  | 174 ++++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h |   2 +
 2 files changed, 151 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 60778afbff207..2b54d3813d18d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5785,17 +5785,48 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, kernel_delta, dequeue = 1;
+	long task_delta, idle_task_delta, kernel_delta, user_delta, dequeue = 1;
+	bool was_pending;
 
 	/*
-	 * We don't actually throttle, though account() will have made sure to
-	 * resched us so that we pick into a kernel task.
+	 * We don't actually throttle just yet, though account_cfs_rq_runtime()
+	 * will have made sure to resched us so that we pick into a kernel task.
 	 */
 	if (cfs_rq->h_kernel_running) {
+		if (cfs_rq->throttle_pending)
+			return false;
+
+		/*
+		 * From now on we're only going to pick tasks that are in the
+		 * second tree. Reflect this by discounting tasks that aren't going
+		 * to be pickable from the ->h_nr_running counts.
+		 */
 		cfs_rq->throttle_pending = true;
+
+		se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
+		user_delta = cfs_rq->h_user_running;
+		cfs_rq->h_nr_running -= user_delta;
+
+		for_each_sched_entity(se) {
+			struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+
+			if (!se->on_rq)
+				goto done;
+
+			qcfs_rq->h_nr_running -= user_delta;
+			qcfs_rq->h_user_running -= user_delta;
+
+			assert_cfs_rq_counts(qcfs_rq);
+		}
 		return false;
 	}
 
+	/*
+	 * Unlikely as it may be, we may only have user tasks as we hit the
+	 * throttle, in which case we won't have discount them from the
+	 * h_nr_running, and we need to be aware of that.
+	 */
+	was_pending = cfs_rq->throttle_pending;
 	cfs_rq->throttle_pending = false;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5826,9 +5857,27 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
+	/*
+	 * At this point, h_nr_running == h_kernel_running. We add back the
+	 * h_user_running to the throttled cfs_rq, and only remove the difference
+	 * to the upper cfs_rq's.
+	 */
+	if (was_pending) {
+		WARN_ON_ONCE(cfs_rq->h_nr_running != cfs_rq->h_kernel_running);
+		cfs_rq->h_nr_running += cfs_rq->h_user_running;
+	} else {
+		WARN_ON_ONCE(cfs_rq->h_nr_running != cfs_rq->h_user_running);
+	}
+
+	/*
+	 * We always discount user tasks from h_nr_running when throttle_pending
+	 * so only h_kernel_running remains to be removed
+	 */
+	task_delta = was_pending ? cfs_rq->h_kernel_running : cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	kernel_delta = cfs_rq->h_kernel_running;
+	user_delta   = was_pending ? 0 : cfs_rq->h_user_running;
+
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
@@ -5843,6 +5892,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		dequeue_kernel(qcfs_rq, se, kernel_delta);
+		qcfs_rq->h_user_running -= user_delta;
+
 
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
@@ -5866,6 +5917,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		dequeue_kernel(qcfs_rq, se, kernel_delta);
+		qcfs_rq->h_user_running -= user_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
@@ -5888,7 +5940,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, kernel_delta;
+	long task_delta, idle_task_delta, kernel_delta, user_delta;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -5924,6 +5976,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	task_delta = cfs_rq->h_nr_running;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	kernel_delta = cfs_rq->h_kernel_running;
+	user_delta = cfs_rq->h_user_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
@@ -5937,6 +5990,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		enqueue_kernel(qcfs_rq, se, kernel_delta);
+		qcfs_rq->h_user_running += user_delta;
+
+		assert_cfs_rq_counts(qcfs_rq);
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -5955,6 +6011,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		qcfs_rq->h_nr_running += task_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		enqueue_kernel(qcfs_rq, se, kernel_delta);
+		qcfs_rq->h_user_running += user_delta;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(qcfs_rq))
@@ -6855,6 +6912,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	bool kernel_task = is_kernel_task(p);
+	bool throttle_pending = false;
 
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
@@ -6878,13 +6936,20 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 
-		cfs_rq->h_nr_running++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+		if (kernel_task || (!throttle_pending && !cfs_rq->throttle_pending))
+			cfs_rq->h_nr_running++;
 		if (kernel_task)
 			enqueue_kernel(cfs_rq, se, 1);
+		else if (!throttle_pending)
+			cfs_rq->h_user_running++;
+
+		throttle_pending |= cfs_rq->throttle_pending;
+
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6900,13 +6965,20 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se_update_runnable(se);
 		update_cfs_group(se);
 
-		cfs_rq->h_nr_running++;
-		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+		if (kernel_task || (!throttle_pending && !cfs_rq->throttle_pending))
+			cfs_rq->h_nr_running++;
 		if (kernel_task)
 			enqueue_kernel(cfs_rq, se, 1);
+		else if (!throttle_pending)
+			cfs_rq->h_user_running++;
+
+		throttle_pending |= cfs_rq->throttle_pending;
+
+		cfs_rq->idle_h_nr_running += idle_h_nr_running;
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6957,6 +7029,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
 	bool kernel_task = !list_empty(&p->se.kernel_node);
+	bool throttle_pending = false;
 
 	util_est_dequeue(&rq->cfs, p);
 
@@ -6964,13 +7037,20 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-		cfs_rq->h_nr_running--;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+		if (kernel_task || (!throttle_pending && !cfs_rq->throttle_pending))
+			cfs_rq->h_nr_running--;
 		if (kernel_task)
 			dequeue_kernel(cfs_rq, se, 1);
+		else if (!throttle_pending)
+			cfs_rq->h_user_running--;
+
+		throttle_pending |= cfs_rq->throttle_pending;
+
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -6998,13 +7078,20 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se_update_runnable(se);
 		update_cfs_group(se);
 
-		cfs_rq->h_nr_running--;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+		if (kernel_task || (!throttle_pending && !cfs_rq->throttle_pending))
+			cfs_rq->h_nr_running--;
 		if (kernel_task)
 			dequeue_kernel(cfs_rq, se, 1);
+		else if (!throttle_pending)
+			cfs_rq->h_user_running--;
+
+		throttle_pending |= cfs_rq->throttle_pending;
+
+		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		if (cfs_rq_is_idle(cfs_rq))
+			idle_h_nr_running = 1;
+
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -8503,28 +8590,65 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	resched_curr(rq);
 }
 
+/*
+ * Consider:
+ *   cfs_rq.kernel := count of kernel *tasks* enqueued on this cfs_rq
+ *   cfs_rq.user   := count of user   *tasks* enqueued on this cfs_rq
+ *
+ * Then, the following logic is implemented:
+ *   cfs_rq.h_kernel_running = Sum(child.kernel) for all child cfs_rq
+ *   cfs_rq.h_user_running   = Sum(child.user)   for all child cfs_rq with !child.throttle_pending
+ *   cfs_rq.h_nr_running     = Sum(child.kernel) for all child cfs_rq
+ *			     + Sum(child.user)   for all child cfs_rq with !child.throttle_pending
+ *
+ * IOW, count of kernel tasks is always propagated up the hierarchy, and count
+ * of user tasks is only propagated up if the cfs_rq isn't .throttle_pending.
+ */
 static void handle_kernel_task_prev(struct task_struct *prev)
 {
 #ifdef CONFIG_CFS_BANDWIDTH
 	struct sched_entity *se = &prev->se;
 	bool p_in_kernel = is_kernel_task(prev);
 	bool p_in_kernel_tree = !list_empty(&se->kernel_node);
+	bool throttle_pending = false;
 	/*
 	 * These extra loops are bad and against the whole point of the merged
 	 * PNT, but it's a pain to merge, particularly since we want it to occur
 	 * before check_cfs_runtime().
 	 */
 	if (p_in_kernel_tree && !p_in_kernel) {
+		/* Switch from KERNEL -> USER */
 		WARN_ON_ONCE(!se->on_rq); /* dequeue should have removed us */
+
 		for_each_sched_entity(se) {
-			dequeue_kernel(cfs_rq_of(se), se, 1);
-			if (cfs_rq_throttled(cfs_rq_of(se)))
+			struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+			if (throttle_pending || cfs_rq->throttle_pending)
+				cfs_rq->h_nr_running--;
+			dequeue_kernel(cfs_rq, se, 1);
+			if (!throttle_pending)
+				cfs_rq->h_user_running++;
+
+			throttle_pending |= cfs_rq->throttle_pending;
+
+			if (cfs_rq_throttled(cfs_rq))
 				break;
 		}
 	} else if (!p_in_kernel_tree && p_in_kernel && se->on_rq) {
+		/* Switch from USER -> KERNEL */
+
 		for_each_sched_entity(se) {
-			enqueue_kernel(cfs_rq_of(se), se, 1);
-			if (cfs_rq_throttled(cfs_rq_of(se)))
+			struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+			if (throttle_pending || cfs_rq->throttle_pending)
+				cfs_rq->h_nr_running++;
+			enqueue_kernel(cfs_rq, se, 1);
+			if (!throttle_pending)
+				cfs_rq->h_user_running--;
+
+			throttle_pending |= cfs_rq->throttle_pending;
+
+			if (cfs_rq_throttled(cfs_rq))
 				break;
 		}
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0b33ce2e60555..e8860e0d6fbc7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -660,6 +660,8 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	int			h_kernel_running;
+	int			h_user_running;
+	int                     throttle_pending;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
 	struct list_head	kernel_children;
-- 
2.43.0


