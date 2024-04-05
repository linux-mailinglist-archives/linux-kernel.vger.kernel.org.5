Return-Path: <linux-kernel+bounces-132880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0892899B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8184A1F239B1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818D316C69B;
	Fri,  5 Apr 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kehDtcgj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8F16C43F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315046; cv=none; b=en/cLMxmQQ0MlTrGB4g/pP3Q6m1i5RiC1Lp/XMumDx07V/twItXk5FHkTW+D+ihFHL1PCyg522IBAG8n04qaDkUEGiKfxYnfGw9tbNulQ4FqH0UKNm6FLQGGPsMYkBOwX9rEw8nXpkUSfryLukVdpZKOgDuYoP8795qo2UALtOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315046; c=relaxed/simple;
	bh=4BPECJyciRglVdr1tX4CnLHIhkD6a5Me0khsSA3HjAg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UDgK2OnzaA1BglxsczkZbV2bo5HyTOv1nqumyhes1lXIbmAhtvP/Pu//begQzPh9xzZjLK+w8G2GmHGqkp0SKYEGkZ7p/oWHrOIakh1/pd5FPZA2dJIf+NQ/RB6LSHh6B+syTAjF6MQdak1Hj2fNaIo+VjnkyyOaSO5xFscgUIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kehDtcgj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Blh4MIhdA49klZL0IUwnknujmpl0XUTAlVdVVrYEY5Q=; b=kehDtcgjKS3PhEyFjuE84isgWi
	3qhJCbAY2zypbrRpo6mFYj860IHiSdB89fqPMTUU6GBDrl20gZ5IuFr4+kWJdMHmXhRXUfV834K7b
	BUAtX/oGH9SPceTJKwak3+FEKv/00/7/fxiEJi6tJdYBasJyc9RXhOTfuIx9IvoWnN0INgcEVRSg9
	szRtQ+atDPy6vgqqo1o3hJF/+/fo75MM+6pyuwnyG5S26fBEIM5sKsTvN8MadwdFDYrU3dy1p6KsJ
	4eEsyVYuKQbS6G2aTGF4jybID5qR+/+vhvMdkRZUN/T+S1dyuwEeq8JhlOBLtgvQUaCSQja4Plvtx
	rW8u7FcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMH-0000000AKMP-22iq;
	Fri, 05 Apr 2024 11:03:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8E3DB302A1A; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.239280675@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:27:59 +0200
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
Subject: [RFC][PATCH 05/10] sched/fair: Unify pick_{,next_}_task_fair()
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Implement pick_next_task_fair() in terms of pick_task_fair() to
de-duplicate the pick loop.

More importantly, this makes all the pick loops use the
state-invariant form, which is useful to introduce further re-try
conditions in later patches.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   60 ++++++----------------------------------------------
 1 file changed, 8 insertions(+), 52 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8415,7 +8415,6 @@ static void check_preempt_wakeup_fair(st
 	resched_curr(rq);
 }
 
-#ifdef CONFIG_SMP
 static struct task_struct *pick_task_fair(struct rq *rq)
 {
 	struct sched_entity *se;
@@ -8427,7 +8426,7 @@ static struct task_struct *pick_task_fai
 		return NULL;
 
 	do {
-		/* When we pick for a remote RQ, we'll not have done put_prev_entity() */
+		/* Might not have done put_prev_entity() */
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
 			update_curr(cfs_rq);
 
@@ -8440,19 +8439,20 @@ static struct task_struct *pick_task_fai
 
 	return task_of(se);
 }
-#endif
 
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
 	struct task_struct *p;
+	struct cfs_rq *cfs_rq;
 	int new_tasks;
 
 again:
-	if (!sched_fair_runnable(rq))
+	p = pick_task_fair(rq);
+	if (!p)
 		goto idle;
+	se = &p->se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (!prev || prev->sched_class != &fair_sched_class)
@@ -8464,46 +8464,7 @@ pick_next_task_fair(struct rq *rq, struc
 	 *
 	 * Therefore attempt to avoid putting and setting the entire cgroup
 	 * hierarchy, only change the part that actually changes.
-	 */
-
-	do {
-		struct sched_entity *curr = cfs_rq->curr;
-
-		/*
-		 * Since we got here without doing put_prev_entity() we also
-		 * have to consider cfs_rq->curr. If it is still a runnable
-		 * entity, update_curr() will update its vruntime, otherwise
-		 * forget we've ever seen it.
-		 */
-		if (curr) {
-			if (curr->on_rq)
-				update_curr(cfs_rq);
-			else
-				curr = NULL;
-
-			/*
-			 * This call to check_cfs_rq_runtime() will do the
-			 * throttle and dequeue its entity in the parent(s).
-			 * Therefore the nr_running test will indeed
-			 * be correct.
-			 */
-			if (unlikely(check_cfs_rq_runtime(cfs_rq))) {
-				cfs_rq = &rq->cfs;
-
-				if (!cfs_rq->nr_running)
-					goto idle;
-
-				goto simple;
-			}
-		}
-
-		se = pick_next_entity(cfs_rq);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
-
-	/*
+	 *
 	 * Since we haven't yet done put_prev_entity and if the selected task
 	 * is a different task than we started out with, try and touch the
 	 * least amount of cfs_rqs.
@@ -8535,13 +8496,8 @@ pick_next_task_fair(struct rq *rq, struc
 	if (prev)
 		put_prev_task(rq, prev);
 
-	do {
-		se = pick_next_entity(cfs_rq);
-		set_next_entity(cfs_rq, se);
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
-
-	p = task_of(se);
+	for_each_sched_entity(se)
+		set_next_entity(cfs_rq_of(se), se);
 
 done: __maybe_unused;
 #ifdef CONFIG_SMP



