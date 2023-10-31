Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4127DD7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 22:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345270AbjJaVt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 17:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbjJaVt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 17:49:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8585E8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 14:49:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C2BC433C7;
        Tue, 31 Oct 2023 21:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698788965;
        bh=yxMINICws7dWVxrYdsw/+WlPWt8z1EveHqPigwS/SNo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=K8jv8LKqcqq7wsUiM6ocSmU8kqETEp+cKGCusB2Nn0ye5qShzzp8A46ToB6tHXF1b
         rkPqYZTvOa0rjr/C6wmI/a5rkWXD7v7kPYKixpnfX+U+krXkjFLcp4ImG71GnddBoY
         lmKYd8pnRoTCg/cvfvWrIDoXjRmoG6gx/OxXtEezVqv8e203KH9gM0dHnZwp5SlvGA
         QNbPt320Z6upH9tbRsL7ulLXNA51QyRT9A7Qb5J67xiuiKjQnjHWeoEIZnY98OSwoP
         lAq7lmj++Lvj6TsbPk6MV237tVkroqo3J6E51UlJdPXxafs+j7QALKSEC6IoQH40/B
         jXTa6zftgTykw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1D6ECCE0DE2; Tue, 31 Oct 2023 14:49:25 -0700 (PDT)
Date:   Tue, 31 Oct 2023 14:49:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Subject: Re: [PATCH] rcu: Break rcu_node_0 --> &rq->__lock order
Message-ID: <3f6ee179-0ef8-4ac0-97ca-f5a9e7eeb900@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231031001418.274187-1-longman@redhat.com>
 <20231031085308.GB35651@noisy.programming.kicks-ass.net>
 <a46f5614-53ec-49fb-86d0-fa5aea4d0a42@paulmck-laptop>
 <20231031200228.GG15024@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031200228.GG15024@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 09:02:28PM +0100, Peter Zijlstra wrote:
> On Tue, Oct 31, 2023 at 07:29:04AM -0700, Paul E. McKenney wrote:
> > Other than the de-alphabetization of the local variables, it looks
> > plausible to me.  Frederic's suggestion also sounds plausible to me.
> 
> Having spend the better part of the past two decades using upside down
> xmas trees for local variables, this alphabet thing is obnoxious :-)
> 
> But your code, your rules.
> 
> To reduce the number of alphabet songs required, I've taken the liberty
> to move a few variables into a narrower scope, hope that doesn't offend.

I have no problem with pushing local variables to local scopes!  ;-)

> ---
> Subject: rcu: Break rcu_node_0 --> &rq->__lock order
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue, 31 Oct 2023 09:53:08 +0100
> 
> Commit 851a723e45d1 ("sched: Always clear user_cpus_ptr in
> do_set_cpus_allowed()") added a kfree() call to free any user
> provided affinity mask, if present. It was changed later to use
> kfree_rcu() in commit 9a5418bc48ba ("sched/core: Use kfree_rcu()
> in do_set_cpus_allowed()") to avoid a circular locking dependency
> problem.
> 
> It turns out that even kfree_rcu() isn't safe for avoiding
> circular locking problem. As reported by kernel test robot,
> the following circular locking dependency now exists:
> 
>   &rdp->nocb_lock --> rcu_node_0 --> &rq->__lock
> 
> Solve this by breaking the rcu_node_0 --> &rq->__lock chain by moving
> the resched_cpu() out from under rcu_node lock.
> 
> [peterz: heavily borrowed from Waiman's Changelog]
> Fixes: 851a723e45d1 ("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lore.kernel.org/oe-lkp/202310302207.a25f1a30-oliver.sang@intel.com

This passes light testing, so I have queued it for further review and
testing.

							Thanx, Paul

> ---
>  kernel/rcu/tree.c |   34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -754,14 +754,19 @@ static int dyntick_save_progress_counter
>  }
>  
>  /*
> - * Return true if the specified CPU has passed through a quiescent
> - * state by virtue of being in or having passed through an dynticks
> - * idle state since the last call to dyntick_save_progress_counter()
> - * for this same CPU, or by virtue of having been offline.
> + * Returns positive if the specified CPU has passed through a quiescent state
> + * by virtue of being in or having passed through an dynticks idle state since
> + * the last call to dyntick_save_progress_counter() for this same CPU, or by
> + * virtue of having been offline.
> + *
> + * Returns negative if the specified CPU needs a force resched.
> + *
> + * Returns zero otherwise.
>   */
>  static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>  {
>  	unsigned long jtsq;
> +	int ret = 0;
>  	struct rcu_node *rnp = rdp->mynode;
>  
>  	/*
> @@ -847,8 +852,8 @@ static int rcu_implicit_dynticks_qs(stru
>  	    (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
>  	     rcu_state.cbovld)) {
>  		WRITE_ONCE(rdp->rcu_urgent_qs, true);
> -		resched_cpu(rdp->cpu);
>  		WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> +		ret = -1;
>  	}
>  
>  	/*
> @@ -891,7 +896,7 @@ static int rcu_implicit_dynticks_qs(stru
>  		}
>  	}
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
> @@ -2257,15 +2262,15 @@ static void force_qs_rnp(int (*f)(struct
>  {
>  	int cpu;
>  	unsigned long flags;
> -	unsigned long mask;
> -	struct rcu_data *rdp;
>  	struct rcu_node *rnp;
>  
>  	rcu_state.cbovld = rcu_state.cbovldnext;
>  	rcu_state.cbovldnext = false;
>  	rcu_for_each_leaf_node(rnp) {
> +		unsigned long mask = 0;
> +		unsigned long rsmask = 0;
> +
>  		cond_resched_tasks_rcu_qs();
> -		mask = 0;
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		rcu_state.cbovldnext |= !!rnp->cbovldmask;
>  		if (rnp->qsmask == 0) {
> @@ -2283,11 +2288,17 @@ static void force_qs_rnp(int (*f)(struct
>  			continue;
>  		}
>  		for_each_leaf_node_cpu_mask(rnp, cpu, rnp->qsmask) {
> +			struct rcu_data *rdp;
> +			int ret;
> +
>  			rdp = per_cpu_ptr(&rcu_data, cpu);
> -			if (f(rdp)) {
> +			ret = f(rdp);
> +			if (ret > 0) {
>  				mask |= rdp->grpmask;
>  				rcu_disable_urgency_upon_qs(rdp);
>  			}
> +			if (ret < 0)
> +				rsmask |= rdp->grpmask;
>  		}
>  		if (mask != 0) {
>  			/* Idle/offline CPUs, report (releases rnp->lock). */
> @@ -2296,6 +2307,9 @@ static void force_qs_rnp(int (*f)(struct
>  			/* Nothing to do here, so just drop the lock. */
>  			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		}
> +
> +		for_each_leaf_node_cpu_mask(rnp, cpu, rsmask)
> +			resched_cpu(cpu);
>  	}
>  }
>  
