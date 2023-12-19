Return-Path: <linux-kernel+bounces-5487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D73818B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC8B21869
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73011CA8A;
	Tue, 19 Dec 2023 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gp5ey1fg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D93A1CA82;
	Tue, 19 Dec 2023 15:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63DFC433D9;
	Tue, 19 Dec 2023 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702999763;
	bh=q7a9zPyS7FnollgtLmCVbmrzHtXm3HyWLIGbUs5rFFI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Gp5ey1fgf6OunXBrFexRX0WH52xrn/Dzy2cYwwqlY2pTtrYCEYUoGC1pOYG1Ak8Oq
	 Nb+zAU/uYHAAaJunG8lZXQhI814Y9L/ai5Q8kFqH2X7oT6E05i6RqvmccGuSoGE26D
	 a2m9EdU2G30vwsI60B8+bzmnhWRU8JOgGEj70C2NJn8wcXfPvhCgejdMjVtlDBFaJ1
	 YToBZVtyZjCKkS9gLWFSEjbJatQ5yMIvVYzIEsfdfWDKL8cHhyXCuXDZygTj5FBr/7
	 IgAAb82cNHQIuSO87/qQhJKV3CA7+1mcLorr5isLEs1v7S3ELrRBxD+Ko0JSmEmCkj
	 ogmBXOQ0luAFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3C796CE0B37; Tue, 19 Dec 2023 07:29:23 -0800 (PST)
Date: Tue, 19 Dec 2023 07:29:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <b6da15c7-4729-4c7c-a88a-cc6773f9a371@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218231916.11719-3-frederic@kernel.org>

On Tue, Dec 19, 2023 at 12:19:15AM +0100, Frederic Weisbecker wrote:
> When the CPU goes idle for the last time during the CPU down hotplug
> process, RCU reports a final quiescent state for the current CPU. If
> this quiescent state propagates up to the top, some tasks may then be
> woken up to complete the grace period: the main grace period kthread
> and/or the expedited main workqueue (or kworker).
> 
> If those kthreads have a SCHED_FIFO policy, the wake up can indirectly
> arm the RT bandwith timer to the local offline CPU. Since this happens
> after hrtimers have been migrated at CPUHP_AP_HRTIMERS_DYING stage, the
> timer gets ignored. Therefore if the RCU kthreads are waiting for RT
> bandwidth to be available, they may never be actually scheduled.
> 
> This triggers TREE03 rcutorture hangs:
> 
> 	 rcu: INFO: rcu_preempt self-detected stall on CPU
> 	 rcu:     4-...!: (1 GPs behind) idle=9874/1/0x4000000000000000 softirq=0/0 fqs=20 rcuc=21071 jiffies(starved)
> 	 rcu:     (t=21035 jiffies g=938281 q=40787 ncpus=6)
> 	 rcu: rcu_preempt kthread starved for 20964 jiffies! g938281 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> 	 rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> 	 rcu: RCU grace-period kthread stack dump:
> 	 task:rcu_preempt     state:R  running task     stack:14896 pid:14    tgid:14    ppid:2      flags:0x00004000
> 	 Call Trace:
> 	  <TASK>
> 	  __schedule+0x2eb/0xa80
> 	  schedule+0x1f/0x90
> 	  schedule_timeout+0x163/0x270
> 	  ? __pfx_process_timeout+0x10/0x10
> 	  rcu_gp_fqs_loop+0x37c/0x5b0
> 	  ? __pfx_rcu_gp_kthread+0x10/0x10
> 	  rcu_gp_kthread+0x17c/0x200
> 	  kthread+0xde/0x110
> 	  ? __pfx_kthread+0x10/0x10
> 	  ret_from_fork+0x2b/0x40
> 	  ? __pfx_kthread+0x10/0x10
> 	  ret_from_fork_asm+0x1b/0x30
> 	  </TASK>
> 
> The situation can't be solved with just unpinning the timer. The hrtimer
> infrastructure and the nohz heuristics involved in finding the best
> remote target for an unpinned timer would then also need to handle
> enqueues from an offline CPU in the most horrendous way.
> 
> So fix this on the RCU side instead and defer the wake up to an online
> CPU if it's too late for the local one.

One question below...

> Reported-by: Paul E. McKenney <paulmck@kernel.org>
> Fixes: 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/rcu/tree.c     | 34 +++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree_exp.h |  3 +--
>  2 files changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ac3c846105f..157f3ca2a9b5 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1013,6 +1013,38 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
>  	return needmore;
>  }
>  
> +static void swake_up_one_online_ipi(void *arg)
> +{
> +	struct swait_queue_head *wqh = arg;
> +
> +	swake_up_one(wqh);
> +}
> +
> +static void swake_up_one_online(struct swait_queue_head *wqh)
> +{
> +	int cpu = get_cpu();

This works because get_cpu() is currently preempt_disable().  If there are plans to
make get_cpu() be some sort of read lock, we might deadlock when synchronize_rcu()
is invoked from a CPU-hotplug notifier, correct?

Might this be worth a comment somewhere at some point?

								Thanx, Paul

> +
> +	/*
> +	 * If called from rcutree_report_cpu_starting(), wake up
> +	 * is dangerous that late in the CPU-down hotplug process. The
> +	 * scheduler might queue an ignored hrtimer. Defer the wake up
> +	 * to an online CPU instead.
> +	 */
> +	if (unlikely(cpu_is_offline(cpu))) {
> +		int target;
> +
> +		target = cpumask_any_and(housekeeping_cpumask(HK_TYPE_RCU),
> +					 cpu_online_mask);
> +
> +		smp_call_function_single(target, swake_up_one_online_ipi,
> +					 wqh, 0);
> +		put_cpu();
> +	} else {
> +		put_cpu();
> +		swake_up_one(wqh);
> +	}
> +}
> +
>  /*
>   * Awaken the grace-period kthread.  Don't do a self-awaken (unless in an
>   * interrupt or softirq handler, in which case we just might immediately
> @@ -1037,7 +1069,7 @@ static void rcu_gp_kthread_wake(void)
>  		return;
>  	WRITE_ONCE(rcu_state.gp_wake_time, jiffies);
>  	WRITE_ONCE(rcu_state.gp_wake_seq, READ_ONCE(rcu_state.gp_seq));
> -	swake_up_one(&rcu_state.gp_wq);
> +	swake_up_one_online(&rcu_state.gp_wq);
>  }
>  
>  /*
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 6d7cea5d591f..2ac440bc7e10 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -173,7 +173,6 @@ static bool sync_rcu_exp_done_unlocked(struct rcu_node *rnp)
>  	return ret;
>  }
>  
> -
>  /*
>   * Report the exit from RCU read-side critical section for the last task
>   * that queued itself during or before the current expedited preemptible-RCU
> @@ -201,7 +200,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
>  			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  			if (wake) {
>  				smp_mb(); /* EGP done before wake_up(). */
> -				swake_up_one(&rcu_state.expedited_wq);
> +				swake_up_one_online(&rcu_state.expedited_wq);
>  			}
>  			break;
>  		}
> -- 
> 2.42.1
> 

