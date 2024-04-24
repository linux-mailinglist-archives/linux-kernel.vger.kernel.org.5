Return-Path: <linux-kernel+bounces-157164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE598B0D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9272D1C22C91
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8F15FA6A;
	Wed, 24 Apr 2024 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ap8MdnCt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784315FA77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971268; cv=none; b=c7vpigRR/BGn6Im6IctIqaiDyG5LkfNKZbQmfWDQE9Ot1Su6vIFkR9XzRwIMgXoTQMNTjWmVKtyem/WVWf3P78G4HUGADThKN3zG7p46mXXVJu2X6Ax4us5p3M1NhgKRVlxendNLVU0eBiYNWiYToYnNlzkXb9l8pCA7c0kOIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971268; c=relaxed/simple;
	bh=3Imx9i9SQYREHOv6wfyVBohsRJUes5JPkC51O0CAoME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTEdCCQrstgFU2Yg9SlbeNLfCEv2t+rvSGKb6Ce55nh8HzRtN2Yac+mJc+AdX1dEJC/sAFHXRkDSa1mQ+p+LjAHKoIaTLA5iX3v9hVb8q70glb/z4HEJa2TSg9COTp9uriG+xTArPaoe3+P5mX5JjRx/ONbs9gUgZoc5HIbjYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ap8MdnCt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TT+zUneipxKi67aapWzNwPcxgDV/c2B4PFE58NNzbcE=; b=Ap8MdnCt107rb2VEukFy8M7ULb
	9jl7sFVeF+7YFwehLDVDSCLNE4AMdq+xxcLXLWYAuq+zlQcDOa2xZH7b2YbpNVlWcOs5e1OgZW95I
	HL9pP0BAUH/dDu2KJDNUUhnBAGqC4GMaZNmMDkWGUCWdkRh7QyPpmbSY2HUHivXk+63/0W7WkrYvA
	XN4grI3wYpx/zomRSvCu9cT3Rc3elYsnmEPgc1367Gt0Rk5MWM2mYF/EvOR5idiTtoi5P60CjgFuo
	AdSU29i3dMPATOZicElwpgK8J36idB3KTsiW4B9V8x8hKgP8vtbUrDW/DRHMfJQPAGmHg5LwdRZVf
	OCPXOQeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzeDS-000000017vn-0Ucf;
	Wed, 24 Apr 2024 15:07:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C287630043E; Wed, 24 Apr 2024 17:07:21 +0200 (CEST)
Date: Wed, 24 Apr 2024 17:07:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Tobias Huschle <huschle@linux.ibm.com>,
	Luis Machado <luis.machado@arm.com>, Chen Yu <yu.c.chen@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>,
	Youssef Esmat <youssefesmat@chromium.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [RFC PATCH 1/1] sched/eevdf: Skip eligibility check for current
 entity during wakeup preemption
Message-ID: <20240424150721.GQ30852@noisy.programming.kicks-ass.net>
References: <20240325060226.1540-1-kprateek.nayak@amd.com>
 <20240325060226.1540-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325060226.1540-2-kprateek.nayak@amd.com>

On Mon, Mar 25, 2024 at 11:32:26AM +0530, K Prateek Nayak wrote:
> With the curr entity's eligibility check, a wakeup preemption is very
> likely when an entity with positive lag joins the runqueue pushing the
> avg_vruntime of the runqueue backwards, making the vruntime of the
> current entity ineligible. This leads to aggressive wakeup preemption
> which was previously guarded by wakeup_granularity_ns in legacy CFS.
> Below figure depicts one such aggressive preemption scenario with EEVDF
> in DeathStarBench [1]:
> 
> 				deadline for Nginx
> 		   |
> 	+-------+  |			|
>     /-- | Nginx | -|------------------> |
>     |	+-------+  |			|
>     |		   |
>     |	-----------|-------------------------------> vruntime timeline
>     |		   \--> rq->avg_vruntime
>     |
>     | 	wakes service on the same runqueue since system is busy
>     |
>     |	+---------+|
>     \-->| Service || (service has +ve lag pushes avg_vruntime backwards)
> 	+---------+|
> 	  |	   |
>    wakeup |	+--|-----+			 |
>  preempts \---->| N|ginx | --------------------> | {deadline for Nginx}
> 		+--|-----+  			 |
> 	   (Nginx ineligible)
> 	-----------|-------------------------------> vruntime timeline
> 		   \--> rq->avg_vruntime

This graph is really hard to interpret. If you want to illustrate
avg_vruntime moves back, you should not align it. That's really
disorienting.

In both (upper and lower) nginx has the same vruntime thus *that* should
be aligned. The lower will have service placed left and with that
avg_vruntime also moves left, rendering nginx in-eligible.


> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/fair.c     | 24 ++++++++++++++++++++----
>  kernel/sched/features.h |  1 +
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a16129f9a5c..a9b145a4eab0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -875,7 +875,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
>   *
>   * Which allows tree pruning through eligibility.
>   */
> -static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
> +static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, bool wakeup_preempt)
>  {
>  	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
>  	struct sched_entity *se = __pick_first_entity(cfs_rq);
> @@ -889,7 +889,23 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>  	if (cfs_rq->nr_running == 1)
>  		return curr && curr->on_rq ? curr : se;
>  
> -	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> +	if (curr && !curr->on_rq)
> +		curr = NULL;
> +
> +	/*
> +	 * When an entity with positive lag wakes up, it pushes the
> +	 * avg_vruntime of the runqueue backwards. This may causes the
> +	 * current entity to be ineligible soon into its run leading to
> +	 * wakeup preemption.
> +	 *
> +	 * To prevent such aggressive preemption of the current running
> +	 * entity during task wakeups, skip the eligibility check if the
> +	 * slice promised to the entity since its selection has not yet
> +	 * elapsed.
> +	 */
> +	if (curr &&
> +	    !(sched_feat(RUN_TO_PARITY_WAKEUP) && wakeup_preempt && curr->vlag == curr->deadline) &&
> +	    !entity_eligible(cfs_rq, curr))
>  		curr = NULL;
>  
>  	/*

So I see what you want to do, but this is highly unreadable.

I'll try something like the below on top of queue/sched/eevdf, but I
should probably first look at fixing those reported crashes on that tree
:/

---
 kernel/sched/fair.c     | 60 ++++++++++++++++++++++++++++++++++---------------
 kernel/sched/features.h | 11 +++++----
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a9206d8532f..23977ed1cb2c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -855,6 +855,39 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 	return __node_2_se(left);
 }
 
+static inline bool pick_curr(struct cfs_rq *cfs_rq,
+			     struct sched_entity *curr, struct sched_entity *wakee)
+{
+	/*
+	 * Nothing to preserve...
+	 */
+	if (!curr || !sched_feat(RESPECT_SLICE))
+		return false;
+
+	/*
+	 * Allow preemption at the 0-lag point -- even if not all of the slice
+	 * is consumed. Note: placement of positive lag can push V left and render
+	 * @curr instantly ineligible irrespective the time on-cpu.
+	 */
+	if (sched_feat(RUN_TO_PARITY) && !entity_eligible(cfs_rq, curr))
+		return false;
+
+	/*
+	 * Don't preserve @curr when the @wakee has a shorter slice and earlier
+	 * deadline. IOW, explicitly allow preemption.
+	 */
+	if (sched_feat(PREEMPT_SHORT) && wakee &&
+	    wakee->slice < curr->slice &&
+	    (s64)(wakee->deadline - curr->deadline) < 0)
+		return false;
+
+	/*
+	 * Preserve @curr to allow it to finish its first slice.
+	 * See the HACK in set_next_entity().
+	 */
+	return curr->vlag == curr->deadline;
+}
+
 /*
  * Earliest Eligible Virtual Deadline First
  *
@@ -874,28 +907,27 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  *
  * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *wakee)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
 
+	if (curr && !curr->on_rq)
+		curr = NULL;
+
 	/*
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
 	if (cfs_rq->nr_running == 1)
-		return curr && curr->on_rq ? curr : se;
-
-	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
-		curr = NULL;
+		return curr ?: se;
 
 	/*
-	 * Once selected, run a task until it either becomes non-eligible or
-	 * until it gets a new slice. See the HACK in set_next_entity().
+	 * Preserve @curr to let it finish its slice.
 	 */
-	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	if (pick_curr(cfs_rq, curr, wakee))
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -5507,7 +5539,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 		return cfs_rq->next;
 	}
 
-	struct sched_entity *se = pick_eevdf(cfs_rq);
+	struct sched_entity *se = pick_eevdf(cfs_rq, NULL);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		SCHED_WARN_ON(se->sched_delayed);
@@ -8548,15 +8580,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
-	if (sched_feat(PREEMPT_SHORT) && pse->slice < se->slice &&
-	    entity_eligible(cfs_rq, pse) &&
-	    (s64)(pse->deadline - se->deadline) < 0 &&
-	    se->vlag == se->deadline) {
-		/* negate RUN_TO_PARITY */
-		se->vlag = se->deadline - 1;
-	}
-
-	if (pick_eevdf(cfs_rq) == pse)
+	if (pick_eevdf(cfs_rq, pse) == pse)
 		goto preempt;
 
 	return;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 64ce99cf04ec..2285dc30294c 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -10,12 +10,15 @@ SCHED_FEAT(PLACE_LAG, true)
  */
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 /*
- * Inhibit (wakeup) preemption until the current task has either matched the
- * 0-lag point or until is has exhausted it's slice.
+ * Inhibit (wakeup) preemption until the current task has exhausted its slice.
  */
-SCHED_FEAT(RUN_TO_PARITY, true)
+SCHED_FEAT(RESPECT_SLICE, true)
 /*
- * Allow tasks with a shorter slice to disregard RUN_TO_PARITY
+ * Relax RESPECT_SLICE to allow preemption once current has reached 0-lag.
+ */
+SCHED_FEAT(RUN_TO_PARITY, false)
+/*
+ * Allow tasks with a shorter slice to disregard RESPECT_SLICE
  */
 SCHED_FEAT(PREEMPT_SHORT, true)
 

