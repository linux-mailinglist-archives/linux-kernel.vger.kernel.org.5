Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5126A78E4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343865AbjHaCdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242302AbjHaCdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:33:04 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C06CD6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:32:59 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-64b3504144cso1989436d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693449178; x=1694053978;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqDHAbb0+180sYxrmrpKE74ucjMV+7CXYqGixgPrIJI=;
        b=ktG7zQb4Z8m8l+5TPIsTCAcAaZ2ajLm08rewvmOs/tKti128FUXM9/P8W2dixKKjkQ
         ylrK2gyAXicZwkdVt73tAxnuV5vHaqzGRVUAjhj2m47CechSF8Z3G5oKj3JPad/SOequ
         US1GQEU7F4OJ1gh+qZ+ZdQFd4TaBj1yDyWdpPYOHt7LVUz2qMj+JpSlZw80uvFqB1oW8
         NB+zPbDodcScSwWdQNISjxRptMzcF9DaCI2ARGolA80pdZbcKEOkfKcEkwEGWrIeVqAl
         sFb/qfbKTWAcGK50ryKaG2CWAMdS2X6YLi40Cm1gGDOF8ZUxDxphTiRNIlhgu2CujxU7
         eRVQ==
X-Gm-Message-State: AOJu0YxsUq3DxS6STdjHj3RnPUSpooHWqEbDT8c2E2yxVBlmwUoK8Fd+
        mHxEY/+JcU9XV3+dnw4Rb6A=
X-Google-Smtp-Source: AGHT+IHTuT04Iks084ln8Pk2HM7BlG2n0dWlc/6EOmFtWEnoZUiDpo4wobWEjM45yxLXnAKNrhXxTg==
X-Received: by 2002:a0c:da10:0:b0:64f:92d2:44f8 with SMTP id x16-20020a0cda10000000b0064f92d244f8mr1501628qvj.59.1693449178182;
        Wed, 30 Aug 2023 19:32:58 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:1c30])
        by smtp.gmail.com with ESMTPSA id t10-20020a0cde0a000000b0062de51d8a12sm188387qvk.26.2023.08.30.19.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 19:32:57 -0700 (PDT)
Date:   Wed, 30 Aug 2023 21:32:54 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <20230831023254.GC506447@maniforge>
References: <20230809221218.163894-1-void@manifault.com>
 <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com>
 <20230818050355.GA5718@maniforge>
 <ZN8wfiAVttkNnFDe@BLR-5CG11610CF.amd.com>
 <ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com>
 <20230824225150.GB6119@maniforge>
 <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:26:40PM +0530, K Prateek Nayak wrote:
> Hello David,

Hello Prateek,

> 
> Short update based on some of my experimentation.
> 
> Disclaimer: I've been only looking at tbench 128 client case on a dual
> socket 3rd Generation EPYC system (2x 64C/128T). Wider results may
> vary but I have some information that may help with the debug and to
> proceed further.
> 
> On 8/25/2023 4:21 AM, David Vernet wrote:
> > On Thu, Aug 24, 2023 at 04:44:19PM +0530, Gautham R. Shenoy wrote:
> >> Hello David,
> >>
> >> On Fri, Aug 18, 2023 at 02:19:03PM +0530, Gautham R. Shenoy wrote:
> >>> Hello David,
> >>>
> >>> On Fri, Aug 18, 2023 at 12:03:55AM -0500, David Vernet wrote:
> >>>> On Thu, Aug 17, 2023 at 02:12:03PM +0530, Gautham R. Shenoy wrote:
> >>>>> Hello David,
> >>>>
> >>>> Hello Gautham,
> >>>>
> >>>> Thanks a lot as always for running some benchmarks and analyzing these
> >>>> changes.
> >>>>
> >>>>> On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
> >>>>>> Changes
> >>>>>> -------
> >>>>>>
> >>>>>> This is v3 of the shared runqueue patchset. This patch set is based off
> >>>>>> of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> >>>>>> bandwidth in use") on the sched/core branch of tip.git.
> >>>>>
> >>>>>
> >>>>> I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
> >>>>> notice that apart from hackbench, every other bechmark is showing
> >>>>> regressions with this patch series. Quick summary of my observations:
> >>>>
> >>>> Just to verify per our prior conversation [0], was this latest set of
> >>>> benchmarks run with boost disabled?
> >>>
> >>> Boost is enabled by default. I will queue a run tonight with boost
> >>> disabled.
> >>
> >> Apologies for the delay. I didn't see any changes with boost-disabled
> >> and with reverting the optimization to bail out of the
> >> newidle_balance() for SMT and MC domains when there was no task to be
> >> pulled from the shared-runq. I reran the whole thing once again, just
> >> to rule out any possible variance. The results came out the same.
> > 
> > Thanks a lot for taking the time to run more benchmarks.
> > 
> >> With the boost disabled, and the optimization reverted, the results
> >> don't change much.
> > 
> > Hmmm, I see. So, that was the only real substantive "change" between v2
> > -> v3. The other changes were supporting hotplug / domain recreation,
> > optimizing locking a bit, and fixing small bugs like the return value
> > from shared_runq_pick_next_task(), draining the queue when the feature
> > is disabled, and fixing the lkp errors.
> > 
> > With all that said, it seems very possible that the regression is due to
> > changes in sched/core between commit ebb83d84e49b ("sched/core: Avoid
> > multiple calling update_rq_clock() in __cfsb_csd_unthrottle()") in v2,
> > and commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> > bandwidth in use") in v3. EEVDF was merged in that window, so that could
> > be one explanation for the context switch rate being so much higher.
> > 
> >> It doesn't appear that the optimization is the cause for increase in
> >> the number of load-balancing attempts at the DIE and the NUMA
> >> domains. I have shared the counts of the newidle_balance with and
> >> without SHARED_RUNQ below for tbench and it can be noticed that the
> >> counts are significantly higher for the 64 clients and 128 clients. I
> >> also captured the counts/s of find_busiest_group() using funccount.py
> >> which tells the same story. So the drop in the performance for tbench
> >> with your patches strongly correlates with the increase in
> >> load-balancing attempts.
> >>
> >> newidle balance is undertaken only if the overload flag is set and the
> >> expected idle duration is greater than the avg load balancing cost. It
> >> is hard to imagine why should the shared runq cause the overload flag
> >> to be set!
> > 
> > Yeah, I'm not sure either about how or why woshared_runq uld cause this
> > This is purely hypothetical, but is it possible that shared_runq causes
> > idle cores to on average _stay_ idle longer due to other cores pulling
> > tasks that would have otherwise been load balanced to those cores?
> > 
> > Meaning -- say CPU0 is idle, and there are tasks on other rqs which
> > could be load balanced. Without shared_runq, CPU0 might be woken up to
> > run a task from a periodic load balance. With shared_runq, any active
> > core that would otherwise have gone idle could pull the task, keeping
> > CPU0 idle.
> > 
> > What do you think? I could be totally off here.
> > 
> > From my perspective, I'm not too worried about this given that we're
> > seeing gains in other areas such as kernel compile as I showed in [0],
> > though I definitely would like to better understand it.
> 
> Let me paste a cumulative diff containing everything I've tried since
> it'll be easy to explain.
> 
> o Performance numbers for tbench 128 clients:
> 
> tip			: 1.00 (Var: 0.57%)
> tip + vanilla v3	: 0.39 (var: 1.15%) (%diff: -60.74%)
> tip + v3 + diff		: 0.99 (var: 0.61%) (%diff: -00.24%)
> 
> tip is at commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when
> cfs bandwidth in use"), same as what Gautham used, so no EEVDF yet.
> 
> o Cumulative Diff
> 
> Should apply cleanly on top of tip at above commit + this series as is.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -198,7 +198,7 @@ struct shared_runq_shard {
>  } ____cacheline_aligned;
>  
>  /* This would likely work better as a configurable knob via debugfs */
> -#define SHARED_RUNQ_SHARD_SZ 6
> +#define SHARED_RUNQ_SHARD_SZ 16
>  #define SHARED_RUNQ_MAX_SHARDS \
>  	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
>  
> @@ -322,20 +322,36 @@ void shared_runq_toggle(bool enabling)
>  }
>  
>  static struct task_struct *
> -shared_runq_pop_task(struct shared_runq_shard *shard, int target)
> +shared_runq_pop_task(struct shared_runq_shard *shard, struct rq *rq)
>  {
> +	int target = cpu_of(rq);
>  	struct task_struct *p;
>  
>  	if (list_empty(&shard->list))
>  		return NULL;
>  
>  	raw_spin_lock(&shard->lock);
> +again:
>  	p = list_first_entry_or_null(&shard->list, struct task_struct,
>  				     shared_runq_node);
> -	if (p && is_cpu_allowed(p, target))
> +
> +	/* If we find a task, delete if from list regardless */
> +	if (p) {
>  		list_del_init(&p->shared_runq_node);
> -	else
> -		p = NULL;
> +
> +		if (!task_on_rq_queued(p) ||
> +		    task_on_cpu(task_rq(p), p) ||

Have you observed !task_on_rq_queued() or task_on_cpu() returning true
here? The task should have removed itself from the shard when
__dequeue_entity() is called from set_next_entity() when it's scheduled
in pick_next_task_fair(). The reason we have to check in
shared_runq_pick_next_task() is that between dequeuing the task from the
shared_runq and getting its rq lock, it could have been scheduled on its
current rq. But if the task was scheduled first, it should have removed
itself from the shard.

> +		    !is_cpu_allowed(p, target)) {
> +			if (rq->ttwu_pending) {
> +				p = NULL;
> +				goto out;
> +			}

Have you observed this as well? If the task is enqueued on the ttwu
queue wakelist, it isn't enqueued on the waking CPU, so it shouldn't be
added to the shared_runq right?

> +
> +			goto again;
> +		}
> +	}
> +
> +out:
>  	raw_spin_unlock(&shard->lock);
>  
>  	return p;
> @@ -380,9 +396,12 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  		curr_idx = (starting_idx + i) % num_shards;
>  		shard = &shared_runq->shards[curr_idx];
>  
> -		p = shared_runq_pop_task(shard, cpu_of(rq));
> +		p = shared_runq_pop_task(shard, rq);
>  		if (p)
>  			break;
> +
> +		if (rq->ttwu_pending)
> +			return 0;

Same here r.e. rq->ttwu_pending. This should be handled in the

if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p))

check below, no? Note that task_on_rq_queued(p) should only return true
if the task has made it to ttwu_do_activate(), and if it hasn't, I don't
think it should be in the shard in the first place.

>  	}
>  	if (!p)
>  		return 0;
> @@ -395,17 +414,16 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
>  		update_rq_clock(src_rq);
>  		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> -		ret = 1;
>  	}
>  
>  	if (src_rq != rq) {
>  		task_rq_unlock(src_rq, p, &src_rf);
>  		raw_spin_rq_lock(rq);
>  	} else {
> +		ret = 1;
>  		rq_unpin_lock(rq, &src_rf);
>  		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>  	}
> -	rq_repin_lock(rq, rf);

Huh, wouldn't this cause a WARN to be issued the next time we invoke
rq_clock() in newidle_balance() if we weren't able to find a task? Or
was it because we moved the SHARED_RUNQ logic to below where we check
rq_clock()? In general though, I don't think this should be removed. At
the very least, it should be tested with lockdep.

>  	return ret;
>  }
> @@ -12344,50 +12362,59 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (!cpu_active(this_cpu))
>  		return 0;
>  
> -	if (sched_feat(SHARED_RUNQ)) {
> -		pulled_task = shared_runq_pick_next_task(this_rq, rf);
> -		if (pulled_task)
> -			return pulled_task;
> -	}
> -
>  	/*
>  	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>  	 * measure the duration of idle_balance() as idle time.
>  	 */
>  	this_rq->idle_stamp = rq_clock(this_rq);
>  
> -	/*
> -	 * This is OK, because current is on_cpu, which avoids it being picked
> -	 * for load-balance and preemption/IRQs are still disabled avoiding
> -	 * further scheduler activity on it and we're being very careful to
> -	 * re-start the picking loop.
> -	 */
> -	rq_unpin_lock(this_rq, rf);
> -
>  	rcu_read_lock();
> -	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> -
> -	/*
> -	 * Skip <= LLC domains as they likely won't have any tasks if the
> -	 * shared runq is empty.
> -	 */
> -	if (sched_feat(SHARED_RUNQ)) {
> +	if (sched_feat(SHARED_RUNQ))
>  		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> -		if (likely(sd))
> -			sd = sd->parent;
> -	}
> +	else
> +		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  
>  	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>  
> -		if (sd)
> +		while (sd) {
>  			update_next_balance(sd, &next_balance);
> +			sd = sd->child;
> +		}
> +
>  		rcu_read_unlock();
>  
>  		goto out;
>  	}
>  	rcu_read_unlock();
>  
> +	t0 = sched_clock_cpu(this_cpu);
> +	if (sched_feat(SHARED_RUNQ)) {
> +		pulled_task = shared_runq_pick_next_task(this_rq, rf);
> +		if (pulled_task) {
> +			curr_cost = sched_clock_cpu(this_cpu) - t0;
> +			update_newidle_cost(sd, curr_cost);
> +			goto out_swq;
> +		}
> +	}

Hmmm, why did you move this further down in newidle_balance()? We don't
want to skip trying to get a task from the shared_runq if rq->avg_idle <
sd->max_newidle_lb_cost.

> +
> +	/* Check again for pending wakeups */
> +	if (this_rq->ttwu_pending)
> +		return 0;
> +
> +	t1 = sched_clock_cpu(this_cpu);
> +	curr_cost += t1 - t0;
> +
> +	if (sd)
> +		update_newidle_cost(sd, curr_cost);
> +
> +	/*
> +	 * This is OK, because current is on_cpu, which avoids it being picked
> +	 * for load-balance and preemption/IRQs are still disabled avoiding
> +	 * further scheduler activity on it and we're being very careful to
> +	 * re-start the picking loop.
> +	 */
> +	rq_unpin_lock(this_rq, rf);
>  	raw_spin_rq_unlock(this_rq);
>  
>  	t0 = sched_clock_cpu(this_cpu);
> @@ -12400,6 +12427,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  		update_next_balance(sd, &next_balance);
>  
> +		/*
> +		 * Skip <= LLC domains as they likely won't have any tasks if the
> +		 * shared runq is empty.
> +		 */
> +		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
> +			continue;

This makes sense to me, good call.

> +
>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>  			break;
>  
> @@ -12429,6 +12463,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	raw_spin_rq_lock(this_rq);
>  
> +out_swq:
>  	if (curr_cost > this_rq->max_idle_balance_cost)
>  		this_rq->max_idle_balance_cost = curr_cost;
>  
> --
> 
> o Breakdown
> 
> I'll proceed to annotate a copy of diff with reasoning behind the changes:

Ah, ok, you provided explanations :-) I'll leave my questions above
regardless for posterity.

> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -198,7 +198,7 @@ struct shared_runq_shard {
>  } ____cacheline_aligned;
>  
>  /* This would likely work better as a configurable knob via debugfs */
> -#define SHARED_RUNQ_SHARD_SZ 6
> +#define SHARED_RUNQ_SHARD_SZ 16
>  #define SHARED_RUNQ_MAX_SHARDS \
>  	((NR_CPUS / SHARED_RUNQ_SHARD_SZ) + (NR_CPUS % SHARED_RUNQ_SHARD_SZ != 0))
> 
> --
> 
> 	Here I'm setting the SHARED_RUNQ_SHARD_SZ to sd_llc_size for
> 	my machine. I played around with this and did not see any
> 	contention for shared_rq lock while running tbench.

I don't really mind making the shard bigger because it will never be one
size fits all, but for what it's worth, I saw less contention in netperf
with a size of 6, but everything else performed fine with a larger
shard. This is one of those "there's no right answer" things, I'm
afraid. I think it will be inevitable to make this configurable at some
point, if we find that it's really causing inefficiencies.

> --
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -322,20 +322,36 @@ void shared_runq_toggle(bool enabling)
>  }
>  
>  static struct task_struct *
> -shared_runq_pop_task(struct shared_runq_shard *shard, int target)
> +shared_runq_pop_task(struct shared_runq_shard *shard, struct rq *rq)
>  {
> +	int target = cpu_of(rq);
>  	struct task_struct *p;
>  
>  	if (list_empty(&shard->list))
>  		return NULL;
>  
>  	raw_spin_lock(&shard->lock);
> +again:
>  	p = list_first_entry_or_null(&shard->list, struct task_struct,
>  				     shared_runq_node);
> -	if (p && is_cpu_allowed(p, target))
> +
> +	/* If we find a task, delete if from list regardless */

As I mentioned in my other reply [0], I don't think we should always
have to delete here. Let me know if I'm missing something.

[0]: https://lore.kernel.org/all/20230831013435.GB506447@maniforge/

> +	if (p) {
>  		list_del_init(&p->shared_runq_node);
> -	else
> -		p = NULL;
> +
> +		if (!task_on_rq_queued(p) ||
> +		    task_on_cpu(task_rq(p), p) ||
> +		    !is_cpu_allowed(p, target)) {
> +			if (rq->ttwu_pending) {
> +				p = NULL;
> +				goto out;
> +			}
> +
> +			goto again;
> +		}
> +	}
> +
> +out:
>  	raw_spin_unlock(&shard->lock);
>  
>  	return p;
> --
> 
> 	Context: When running perf with IBS, I saw following lock
> 	contention:
> 
> -   12.17%  swapper          [kernel.vmlinux]          [k] native_queued_spin_lock_slowpath
>    - 10.48% native_queued_spin_lock_slowpath
>       - 10.30% _raw_spin_lock
>          - 9.11% __schedule
>               schedule_idle
>               do_idle
>             + cpu_startup_entry
>          - 0.86% task_rq_lock
>               newidle_balance
>               pick_next_task_fair
>               __schedule
>               schedule_idle
>               do_idle
>             + cpu_startup_entry
> 
> 	So I imagined the newidle_balance is contending with another
> 	run_queue going idle when pulling task. Hence, I moved some
> 	checks in shared_runq_pick_next_task() to here.

Hmm, so the idea was to avoid contending on the rq lock? As I mentioned
above, I'm not sure these checks actually buy us anything.

> 	I was not sure if the task's rq lock needs to be held to do this
> 	to get an accurate result so I've left the original checks in
> 	shared_runq_pick_next_task() as it is.

Yep, we need to have the rq lock held for these functions to return
consistent data.

> 	Since retry may be costly, I'm using "rq->ttwu_pending" as a
> 	bail out threshold. Maybe there are better alternates with
> 	the lb_cost and rq->avg_idle but this was simpler for now.

Hmm, not sure I'm quite understanding this one. As I mentioned above, I
don't _think_ this should ever be set for a task enqueued in a shard.
Were you observing that?

> 	(Realizing as I write this that this will cause more contention
> 	with enqueue/dequeue in a busy system. I'll check if that is the
> 	case)
> 
> 	P.S. This did not affect the ~60% regression I was seeing one
> 	bit so the problem was deeper.
> 
> --
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -380,9 +396,12 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  		curr_idx = (starting_idx + i) % num_shards;
>  		shard = &shared_runq->shards[curr_idx];
>  
> -		p = shared_runq_pop_task(shard, cpu_of(rq));
> +		p = shared_runq_pop_task(shard, rq);
>  		if (p)
>  			break;
> +
> +		if (rq->ttwu_pending)
> +			return 0;
>  	}
>  	if (!p)
>  		return 0;
> --
> 
> 	More bailout logic.
> 
> --
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -395,17 +414,16 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  	if (task_on_rq_queued(p) && !task_on_cpu(src_rq, p)) {
>  		update_rq_clock(src_rq);
>  		src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
> -		ret = 1;
>  	}
>  
>  	if (src_rq != rq) {
>  		task_rq_unlock(src_rq, p, &src_rf);
>  		raw_spin_rq_lock(rq);
>  	} else {
> +		ret = 1;
>  		rq_unpin_lock(rq, &src_rf);
>  		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>  	}
> -	rq_repin_lock(rq, rf);
>  
>  	return ret;
>  }
> --
> 
> 	Only return 1 is task is actually pulled else return -1
> 	signifying the path has released and re-aquired the lock.

Not sure I'm following. If we migrate the task to the current rq, we
want to return 1 to signify that there are new fair tasks present in the
rq don't we? It doesn't need to have started there originally for it to
be present after we move it.

> 
> 	Also leave the rq_repin_lock() part to caller, i.e.,
> 	newidle_balance() since it makes up for a nice flow (see
> 	below).
> 
> --
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12344,50 +12362,59 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	if (!cpu_active(this_cpu))
>  		return 0;
>  
> -	if (sched_feat(SHARED_RUNQ)) {
> -		pulled_task = shared_runq_pick_next_task(this_rq, rf);
> -		if (pulled_task)
> -			return pulled_task;
> -	}
> -
>  	/*
>  	 * We must set idle_stamp _before_ calling idle_balance(), such that we
>  	 * measure the duration of idle_balance() as idle time.
>  	 */
>  	this_rq->idle_stamp = rq_clock(this_rq);
>  
> -	/*
> -	 * This is OK, because current is on_cpu, which avoids it being picked
> -	 * for load-balance and preemption/IRQs are still disabled avoiding
> -	 * further scheduler activity on it and we're being very careful to
> -	 * re-start the picking loop.
> -	 */
> -	rq_unpin_lock(this_rq, rf);
> -
>  	rcu_read_lock();
> -	sd = rcu_dereference_check_sched_domain(this_rq->sd);
> -
> -	/*
> -	 * Skip <= LLC domains as they likely won't have any tasks if the
> -	 * shared runq is empty.
> -	 */
> -	if (sched_feat(SHARED_RUNQ)) {
> +	if (sched_feat(SHARED_RUNQ))
>  		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> -		if (likely(sd))
> -			sd = sd->parent;
> -	}
> +	else
> +		sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  
>  	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
>  
> -		if (sd)
> +		while (sd) {
>  			update_next_balance(sd, &next_balance);
> +			sd = sd->child;
> +		}
> +
>  		rcu_read_unlock();
>  
>  		goto out;
>  	}
>  	rcu_read_unlock();
>  
> +	t0 = sched_clock_cpu(this_cpu);
> +	if (sched_feat(SHARED_RUNQ)) {
> +		pulled_task = shared_runq_pick_next_task(this_rq, rf);
> +		if (pulled_task) {
> +			curr_cost = sched_clock_cpu(this_cpu) - t0;
> +			update_newidle_cost(sd, curr_cost);
> +			goto out_swq;
> +		}
> +	}
> +
> +	/* Check again for pending wakeups */
> +	if (this_rq->ttwu_pending)
> +		return 0;
> +
> +	t1 = sched_clock_cpu(this_cpu);
> +	curr_cost += t1 - t0;
> +
> +	if (sd)
> +		update_newidle_cost(sd, curr_cost);
> +
> +	/*
> +	 * This is OK, because current is on_cpu, which avoids it being picked
> +	 * for load-balance and preemption/IRQs are still disabled avoiding
> +	 * further scheduler activity on it and we're being very careful to
> +	 * re-start the picking loop.
> +	 */
> +	rq_unpin_lock(this_rq, rf);
>  	raw_spin_rq_unlock(this_rq);
>  
>  	t0 = sched_clock_cpu(this_cpu);
> --
> 
> 	This hunk does a few things:
> 
> 	1. If a task is successfully pulled from shared rq, or if the rq
> 	   lock had been released and re-acquired with, jump to the
> 	   very end where we check a bunch of conditions and return
> 	   accordingly.
> 
> 	2. Move the shared rq picking after the "rd->overload" and
> 	   checks against "rq->avg_idle".
> 
> 	   P.S. This recovered half the performance that was lost.

Sorry, which performance are you referring to? I'm not thrilled about
this part because it's another heuristic for users to have to reason
about. _Maybe_ it makes sense to keep the rd->overload check? I don't
think we should keep the rq->avg_idle check though unless it's
absolutely necessary, and I'd have to think more about the rq->overload
check.

> 	3. Update the newidle_balance_cost via update_newidle_cost()
> 	   since that is also used to determine the previous bailout
> 	   threshold.

I think this makes sense as well, but need to think about it more.

> 	4. A bunch of update_next_balance().

I guess this should be OK, though I would expect us to have to load
balance less with SHARED_RUNQ.

> 	5. Move rq_unpin_lock() below. I do not know the implication of
> 	   this the kernel is not complaining so far (mind you I'm on
> 	   x86 and I do not have lockdep enabled)

If you move rq_unpin_lock(), you should probably run with lockdep to see
what happens :-) There are also implications for tracking whether it's
safe to look at the rq clock.

> 
> 	A combination of 3 and 4 seemed to give back the other half of
> 	tbench performance.
> 
> --
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12400,6 +12427,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  		update_next_balance(sd, &next_balance);
>  
> +		/*
> +		 * Skip <= LLC domains as they likely won't have any tasks if the
> +		 * shared runq is empty.
> +		 */
> +		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
> +			continue;
> +

Agreed on this.

>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>  			break;
>  
> --
> 
> 	This was based on my suggestion in the parallel thread.
> 
> 	P.S. This alone, without the changes in previous hunk showed no
> 	difference in performance with results same as vanilla v3.
> 
> --
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d67d86d3bfdf..f1e64412fd48 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12429,6 +12463,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	raw_spin_rq_lock(this_rq);
>  
> +out_swq:
>  	if (curr_cost > this_rq->max_idle_balance_cost)
>  		this_rq->max_idle_balance_cost = curr_cost;
>  
> --
> 
> 	The last part of newidle_balance() does a bunch of accounting
> 	which is relevant after the above changes. Also the
> 	rq_repin_lock() I had removed now happens here.
> 
> --
> 
> Again most of this is lightly tested with just one workload but I would
> like to hear your thoughts, especially with the significance of
> "rd->overload", "max_newidle_lb_cost", and "update_next_balance()".
> however, I'm afraid these may be the bits that led to the drop in
> utilization you mentioned in the first place.

Exactly :-( I think your proposal to fix how we skip load balancing on
the LLC if SHARED_RUNQ is enabled makes sense, but I'd really prefer to
avoid adding these heuristics to avoid contention for specific
workloads. The goal of SHARED_RUNQ is really to drive up CPU util. I
don't think we're really doing the user many favors if we try to guess
for them when they actually want that to happen.

If there's a time where we _really_ don't want or need to do it then
absolutely, let's skip it. But I would really like to see this go in
without checks on max_newidle_lb_cost, etc. The whole point of
SHARED_RUNQ is that it should be less costly than iterating over O(n)
cores to find tasks, so we _want_ to be more aggressive in doing so.

> Most of the experimentation (except for rq lock contention using IBS)
> was done by reading the newidle_balance() code.

And kudos for doing so!

> Finally a look at newidle_balance counts (tip vs tip + v3 + diff) for
> 128-clients of tbench on the test machine:
> 
> 
> < ----------------------------------------  Category:  newidle (SMT)  ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :     921871,   0	(diff: -100.00%)
> --
> < ----------------------------------------  Category:  newidle (MC)   ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :     472412,   0	(diff: -100.00%)
> --
> < ----------------------------------------  Category:  newidle (DIE)  ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :        114, 279	(diff: +144.74%)
> --
> < ----------------------------------------  Category:  newidle (NUMA) ---------------------------------------- >
> load_balance cnt on cpu newly idle                         :          9,   9	(diff: +00.00%)
> --
> 
> Let me know if you have any queries. I'll go back and try to bisect the
> diff to see if only a couple of changes that I thought were important
> are good enought to yield back the lost performance. I'll do wider
> testing post hearing your thoughts.

Hopefully my feedback above should give you enough context to bisect and
find the changes that we really think are most helpful? To reiterate: I
definitely think your change to avoid iterating over the LLC sd is
correct and makes sense. Others possibly do as well such as checking
rd->overload (though not 100% sure), but others such as the
max_newidle_lb_cost checks I would strongly prefer to avoid.

Prateek -- thank you for doing all of this work, it's very much
appreciated.

As I mentioned on the other email, I'll be on vacation for about a week
and a half starting tomorrow afternoon, so I may be slow to respond in
that time.

Thanks,
David
