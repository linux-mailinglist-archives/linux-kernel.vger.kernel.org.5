Return-Path: <linux-kernel+bounces-132881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C10899B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6306B20EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D4516C850;
	Fri,  5 Apr 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfMc9Xvy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EE416C441
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315047; cv=none; b=gb3XrG7sui3E1ncRRNguZJQt0crA0cVcV7Lxw16wU1BLf4zswS8zNy9cKttTXmCBge3o7Pcw4HN4Q31Trogdv0yaT7ytGB6GeFr5WkPczlewqMXWf4bMfqRZfmU2CwQS7UnaYzXTfnBUofCgvLQtgTk3IqjtGQrc8oug8UiT6n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315047; c=relaxed/simple;
	bh=PkhWAQpajBwui8Ycrw5lTswtSwkgjOF5Q/Nz56jrQEU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VxqIhDdrbvZILunPpusyJSZrA17hflidb8WiyqJ0jV71WWy4F1jhvGRGsJb+vAByEUorpzqmHNWPxxv3CeGWaJ8dmwMqr2pXYCzEKBF/7pvG0B8nNfN+2ueBOQnaMn2Bo0k2MWhi3kVsfp9uvwVxIktyJu9B+ACsbAtiWjaGmaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfMc9Xvy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Awpxthql4oMHs/pvkyB9gf8DdhE6IGA6MumMVMqXLls=; b=LfMc9XvyFhlBdrxp6oc+dSBHK/
	erUKxJv7afnUFZX+QuQyTDhj8KMIJe3Rrb/TE5eil7N5A3hGaep8T++Bui4nbidNiQwN2MSFGnVwZ
	lvMmRXXz9z4CSRRfbpMhED2krmQ/J3eJ2p46jagoRsWq+5Vu8J6cQb1L3H6CHfKpbdlNVzVo9E/ZJ
	dzhBLfLQYvLQdM5krFdm3g3UNV0IKXRqhiQ54Zf1cNRAtq3yZxdIF274O7OVO+DUKioofra+A3lEn
	ZAYavvvaY5pnQibyVTPqNlzxGw6J3slJhQD1EdngrZzbL7sRoHkxuzhoONVfja2b0pTbSkzvOk4P6
	+GmWwR0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMH-0000000AKMQ-24Ds;
	Fri, 05 Apr 2024 11:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 9721C302DAB; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.522077707@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:28:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 07/10] sched/fair: Re-organize dequeue_task_fair()
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Working towards delaying dequeue, notably also inside the hierachy,
rework dequeue_task_fair() such that it can 'resume' an interrupted
hierarchy walk.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   82 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 27 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6824,33 +6824,45 @@ enqueue_task_fair(struct rq *rq, struct
 static void set_next_buddy(struct sched_entity *se);
 
 /*
- * The dequeue_task method is called before nr_running is
- * decreased. We remove the task from the rbtree and
- * update the fair scheduling stats:
+ * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
+ * failing half-way through and resume the dequeue later.
+ *
+ * Returns:
+ * -1 - dequeue delayed
+ *  0 - dequeue throttled
+ *  1 - dequeue complete
  */
-static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
-	struct cfs_rq *cfs_rq;
-	struct sched_entity *se = &p->se;
-	int task_sleep = flags & DEQUEUE_SLEEP;
-	int idle_h_nr_running = task_has_idle_policy(p);
 	bool was_sched_idle = sched_idle_rq(rq);
+	bool task_sleep = flags & DEQUEUE_SLEEP;
+	struct task_struct *p = NULL;
+	struct cfs_rq *cfs_rq;
+	int idle_h_nr_running;
 
-	util_est_dequeue(&rq->cfs, p);
+	if (entity_is_task(se)) {
+		p = task_of(se);
+		idle_h_nr_running = task_has_idle_policy(p);
+	} else {
+		idle_h_nr_running = cfs_rq_is_idle(group_cfs_rq(se));
+	}
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		dequeue_entity(cfs_rq, se, flags);
 
-		cfs_rq->h_nr_running--;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		/* h_nr_running is the hierachical count of tasks */
+		if (p) {
+			cfs_rq->h_nr_running--;
+			cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			if (cfs_rq_is_idle(cfs_rq))
+				idle_h_nr_running = 1;
+		}
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
+			return 0;
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
@@ -6870,33 +6882,49 @@ static bool dequeue_task_fair(struct rq
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
+		// XXX avoid these load updates for delayed dequeues ?
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		se_update_runnable(se);
 		update_cfs_group(se);
 
-		cfs_rq->h_nr_running--;
-		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
+		if (p) {
+			cfs_rq->h_nr_running--;
+			cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 
-		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = 1;
+			if (cfs_rq_is_idle(cfs_rq))
+				idle_h_nr_running = 1;
+		}
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
-			goto dequeue_throttle;
+			return 0;
+	}
+
+	if (p) {
+		sub_nr_running(rq, 1);
 
+		/* balance early to pull high priority tasks */
+		if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
+			rq->next_balance = jiffies;
 	}
 
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, 1);
+	return 1;
+}
 
-	/* balance early to pull high priority tasks */
-	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
-		rq->next_balance = jiffies;
+/*
+ * The dequeue_task method is called before nr_running is
+ * decreased. We remove the task from the rbtree and
+ * update the fair scheduling stats:
+ */
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
+{
+	util_est_dequeue(&rq->cfs, p);
 
-dequeue_throttle:
-	util_est_update(&rq->cfs, p, task_sleep);
-	hrtick_update(rq);
+	if (dequeue_entities(rq, &p->se, flags) < 0)
+		return false;
 
+	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	hrtick_update(rq);
 	return true;
 }
 



