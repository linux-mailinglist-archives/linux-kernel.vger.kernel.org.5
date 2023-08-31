Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4296F78F2D9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbjHaSqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjHaSqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:46:04 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A41E5D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:45:58 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-76d80d35762so76709685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507557; x=1694112357;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWkUTZZrrnDmBJh9modDqEN0oy+lyGKososWDfsFafI=;
        b=fM6ouRjifK1Rl/0unY6ntwyz+m7dvcaHeb8kgBAxqcOe8VXQkIEYks1DQX6QmGIVQZ
         QkOpvwSHRb6PSgCZkI2AxO8/HxWm2zPeRa/fqSdP4hwTL0F5lvTQVRBYvGnC0yawDQko
         s3O7bWgd/bk8VXxnpDWF0zZLuyfepN309yrW068pLXfP/f2ii2dA2HIuXzeQ1Ri5W2ob
         275cFKv20dRHl0d6i/+IzKS60xF0bCQxF8vUeFeCvNr+6AoSAI+EWJsX6O4TqXi/jS5+
         FrkYruYWCu8jNG1O6cDOdLohLwAzKT3hve7fdoe+ezBV9Ao0o+/AyXPbCajsFZ/RT8IK
         +iqA==
X-Gm-Message-State: AOJu0YwLIdkuEiSbCWTIUNoD4aTtMEjXg/cdYUq/ybNCCs024GveHkqp
        IMJB+0qaN/g9wA3pCURlUzw=
X-Google-Smtp-Source: AGHT+IGfTbCk+imO/Rw7FHsv9K5jY9PU8gutFWTSdb59Xj2JKLgSYEGnv6VaoQbItTDW6RSjsn92xw==
X-Received: by 2002:a05:620a:25d1:b0:768:1572:e9af with SMTP id y17-20020a05620a25d100b007681572e9afmr310920qko.8.1693507557269;
        Thu, 31 Aug 2023 11:45:57 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:2cd8])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a148e00b0076745f352adsm799638qkj.59.2023.08.31.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:45:56 -0700 (PDT)
Date:   Thu, 31 Aug 2023 13:45:54 -0500
From:   David Vernet <void@manifault.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [RFC PATCH 2/3] sched/fair: Improve integration of SHARED_RUNQ
 feature within newidle_balance
Message-ID: <20230831184554.GB531917@maniforge>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-3-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831104508.7619-3-kprateek.nayak@amd.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 04:15:07PM +0530, K Prateek Nayak wrote:
> This patch takes the relevant optimizations from [1] in
> newidle_balance(). Following is the breakdown:

Thanks for working on this. I think the fix you added for skipping <=
LLC domains makes sense. The others possibly as well -- left some
comments below!

> 
> - Check "rq->rd->overload" before jumping into newidle_balance, even
>   with SHARED_RQ feat enabled.

Out of curiosity -- did you observe this making a material difference in
your tests? After thinking about it some more, though I see the argument
for why it would be logical to check if we're overloaded, I'm still
thinking that it's more ideal to just always check the SHARED_RUNQ.
rd->overload is only set in find_busiest_group() when we load balance,
so I worry that having SHARED_RUNQ follow rd->overload may just end up
making it redundant with normal load balancing in many cases.

So yeah, while I certainly understand the idea (and would like to better
understand what kind of difference it made in your tests), I still feel
pretty strongly that SHARED_RUNQ makes the most sense as a feature when
it ignores all of these heuristics and just tries to maximize work
conservation.

What do you think?

> - Call update_next_balance() for all the domains till MC Domain in
>   when SHARED_RQ path is taken.

I _think_ this makes sense. Though even in this case, I feel that it may
be slightly confusing and/or incorrect to push back the balance time
just because we didn't find a task in our current CCX's shared_runq.
Maybe we should avoid mucking with load balancing? Not sure, but I am
leaning towards what you're proposing here as a better approach.

> - Account cost from shared_runq_pick_next_task() and update
>   curr_cost and sd->max_newidle_lb_cost accordingly.

Yep, I think this is the correct thing to do.

> 
> - Move the initial rq_unpin_lock() logic around. Also, the caller of
>   shared_runq_pick_next_task() is responsible for calling
>   rq_repin_lock() if the return value is non zero. (Needs to be verified
>   everything is right with LOCKDEP)

Still need to think more about this, but it's purely just tactical and
can easily be fixed it we need.

> 
> - Includes a fix to skip directly above the LLC domain when calling the
>   load_balance() in newidle_balance()

Big fix, thanks again for noticing it.

> All other surgery from [1] has been removed.
> 
> Link: https://lore.kernel.org/all/31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com/ [1]
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/fair.c | 94 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 67 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bf844ffa79c2..446ffdad49e1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -337,7 +337,6 @@ static int shared_runq_pick_next_task(struct rq *rq, struct rq_flags *rf)
>  		rq_unpin_lock(rq, &src_rf);
>  		raw_spin_unlock_irqrestore(&p->pi_lock, src_rf.flags);
>  	}
> -	rq_repin_lock(rq, rf);
>  
>  	return ret;
>  }
> @@ -12276,50 +12275,83 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
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
> -	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> +	    /* Look at rq->avg_idle iff SHARED_RUNQ is disabled */
> +	    (!sched_feat(SHARED_RUNQ) && sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
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
> +
> +	if (sched_feat(SHARED_RUNQ)) {
> +		struct sched_domain *tmp = sd;
> +
> +		t0 = sched_clock_cpu(this_cpu);
> +
> +		/* Do update_next_balance() for all domains within LLC */
> +		while (tmp) {
> +			update_next_balance(tmp, &next_balance);
> +			tmp = tmp->child;
> +		}
> +
> +		pulled_task = shared_runq_pick_next_task(this_rq, rf);
> +		if (pulled_task) {
> +			if (sd) {
> +				curr_cost = sched_clock_cpu(this_cpu) - t0;
> +				/*
> +				 * Will help bail out of scans of higer domains
> +				 * slightly earlier.
> +				 */
> +				update_newidle_cost(sd, curr_cost);
> +			}
> +
> +			rcu_read_unlock();
> +			goto out_swq;
> +		}
> +
> +		if (sd) {
> +			t1 = sched_clock_cpu(this_cpu);
> +			curr_cost += t1 - t0;
> +			update_newidle_cost(sd, curr_cost);
> +		}
> +
> +		/*
> +		 * Since shared_runq_pick_next_task() can take a while
> +		 * check if the CPU was targetted for a wakeup in the
> +		 * meantime.
> +		 */
> +		if (this_rq->ttwu_pending) {
> +			rcu_read_unlock();
> +			return 0;
> +		}

At first I was wondering whether we should do this above
update_newidle_cost(), but I think it makes sense to always call
update_newidle_cost() after we've failed to get a task from
shared_runq_pick_next_task().

> +	}
>  	rcu_read_unlock();
>  
> +	/*
> +	 * This is OK, because current is on_cpu, which avoids it being picked
> +	 * for load-balance and preemption/IRQs are still disabled avoiding
> +	 * further scheduler activity on it and we're being very careful to
> +	 * re-start the picking loop.
> +	 */
> +	rq_unpin_lock(this_rq, rf);

Don't you need to do this before you exit on the rq->ttwu_pending path?

>  	raw_spin_rq_unlock(this_rq);
>  
>  	t0 = sched_clock_cpu(this_cpu);
> @@ -12335,6 +12367,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
>  			break;
>  
> +		/*
> +		 * Skip <= LLC domains as they likely won't have any tasks if the
> +		 * shared runq is empty.
> +		 */
> +		if (sched_feat(SHARED_RUNQ) && (sd->flags & SD_SHARE_PKG_RESOURCES))
> +			continue;
> +
>  		if (sd->flags & SD_BALANCE_NEWIDLE) {
>  
>  			pulled_task = load_balance(this_cpu, this_rq,
> @@ -12361,6 +12400,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  	raw_spin_rq_lock(this_rq);
>  
> +out_swq:
>  	if (curr_cost > this_rq->max_idle_balance_cost)
>  		this_rq->max_idle_balance_cost = curr_cost;
>  


Thanks,
David
