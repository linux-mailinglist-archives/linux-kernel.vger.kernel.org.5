Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C0B7E52F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbjKHJ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHJ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:56:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4A1715
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 01:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DLHXrfK1M5Av5ypOae5a/HcqwbkktTqup8PAqdNWA8Y=; b=Hs1LTOT+QZvI7oggVAolqKrPoz
        du5uNvcv/ArqQU1DocN9TxHeR7xMpbzRmzbJPB8wZdXYMQzk8s1DXa8f41rFHVgAiHYi049flDnuE
        9Nq4QB8ZRmckuOOYRtHlGIL5ONPhR4woL7oahb024uGPJj2RuqlvOcIUN5mlPMjg8L5TEuKZ8h38R
        TxvJ+ytTYRXXIkYFZTlBShTaiL24d0eGEC0SEdoW85KuowCWJdL6wNx0a/52TsIoq177F5LVA47p8
        rmhlEhm8GVwDcKFVwyWWr67udZne99V7sSIp/cCPDiX2Lvn724PLXi97n81jf89WrdN231VaYPByt
        N1jm2KvQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0fI0-000JA3-Ew; Wed, 08 Nov 2023 09:56:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C946C30049D; Wed,  8 Nov 2023 10:56:00 +0100 (CET)
Date:   Wed, 8 Nov 2023 10:56:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 42/86] sched: force preemption on tick expiration
Message-ID: <20231108095600.GM8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-43-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-43-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:28PM -0800, Ankur Arora wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4d86c618ffa2..fe7e5e9b2207 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1016,8 +1016,11 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
>   * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
>   * this is probably good enough.
>   */
> -static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
> +static void update_deadline(struct cfs_rq *cfs_rq,
> +			    struct sched_entity *se, bool tick)
>  {
> +	struct rq *rq = rq_of(cfs_rq);
> +
>  	if ((s64)(se->vruntime - se->deadline) < 0)
>  		return;
>  
> @@ -1033,13 +1036,19 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	 */
>  	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
>  
> +	if (cfs_rq->nr_running < 2)
> +		return;
> +
>  	/*
> -	 * The task has consumed its request, reschedule.
> +	 * The task has consumed its request, reschedule; eagerly
> +	 * if it ignored our last lazy reschedule.
>  	 */
> -	if (cfs_rq->nr_running > 1) {
> -		resched_curr(rq_of(cfs_rq));
> -		clear_buddies(cfs_rq, se);
> -	}
> +	if (tick && test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED_LAZY))
> +		__resched_curr(rq, RESCHED_eager);
> +	else
> +		resched_curr(rq);
> +
> +	clear_buddies(cfs_rq, se);
>  }
>  
>  #include "pelt.h"
> @@ -1147,7 +1156,7 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  /*
>   * Update the current task's runtime statistics.
>   */
> -static void update_curr(struct cfs_rq *cfs_rq)
> +static void __update_curr(struct cfs_rq *cfs_rq, bool tick)
>  {
>  	struct sched_entity *curr = cfs_rq->curr;
>  	u64 now = rq_clock_task(rq_of(cfs_rq));
> @@ -1174,7 +1183,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  	schedstat_add(cfs_rq->exec_clock, delta_exec);
>  
>  	curr->vruntime += calc_delta_fair(delta_exec, curr);
> -	update_deadline(cfs_rq, curr);
> +	update_deadline(cfs_rq, curr, tick);
>  	update_min_vruntime(cfs_rq);
>  
>  	if (entity_is_task(curr)) {
> @@ -1188,6 +1197,11 @@ static void update_curr(struct cfs_rq *cfs_rq)
>  	account_cfs_rq_runtime(cfs_rq, delta_exec);
>  }
>  
> +static void update_curr(struct cfs_rq *cfs_rq)
> +{
> +	__update_curr(cfs_rq, false);
> +}
> +
>  static void update_curr_fair(struct rq *rq)
>  {
>  	update_curr(cfs_rq_of(&rq->curr->se));
> @@ -5309,7 +5323,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>  	/*
>  	 * Update run-time statistics of the 'current'.
>  	 */
> -	update_curr(cfs_rq);
> +	__update_curr(cfs_rq, true);
>  
>  	/*
>  	 * Ensure that runnable average is periodically updated.

I'm thinking this will be less of a mess if you flip it around some.

(ignore the hrtick mess, I'll try and get that cleaned up)

This way you have two distinct sites to handle the preemption. the
update_curr() would be 'FULL ? force : lazy' while the tick one gets the
special magic bits.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df348aa55d3c..5399696de9e0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1016,10 +1016,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+		return false;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -1037,9 +1037,11 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * The task has consumed its request, reschedule.
 	 */
 	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
+		return true;
 	}
+
+	return false;
 }
 
 #include "pelt.h"
@@ -1147,18 +1149,19 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 /*
  * Update the current task's runtime statistics.
  */
-static void update_curr(struct cfs_rq *cfs_rq)
+static bool __update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
+	bool ret;
 
 	if (unlikely(!curr))
-		return;
+		return false;
 
 	delta_exec = now - curr->exec_start;
 	if (unlikely((s64)delta_exec <= 0))
-		return;
+		return false;
 
 	curr->exec_start = now;
 
@@ -1174,7 +1177,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	ret = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -1186,6 +1189,14 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	return ret;
+}
+
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	if (__update_curr(cfs_rq))
+		resched_curr(rq_of(cfs_rq));
 }
 
 static void update_curr_fair(struct rq *rq)
@@ -5309,7 +5320,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	update_curr(cfs_rq);
+	bool resched = __update_curr(cfs_rq);
 
 	/*
 	 * Ensure that runnable average is periodically updated.
@@ -5317,22 +5328,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
 
-#ifdef CONFIG_SCHED_HRTICK
-	/*
-	 * queued ticks are scheduled to match the slice, so don't bother
-	 * validating it and just reschedule.
-	 */
-	if (queued) {
-		resched_curr(rq_of(cfs_rq));
-		return;
-	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
-#endif
+	return resched;
 }
 
 
@@ -12387,12 +12383,16 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	bool resched = false;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		entity_tick(cfs_rq, se, queued);
+		resched |= entity_tick(cfs_rq, se, queued);
 	}
 
+	if (resched)
+		resched_curr(rq);
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
