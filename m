Return-Path: <linux-kernel+bounces-163025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B04A8B63D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72181F22693
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6FA17994D;
	Mon, 29 Apr 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsTxMjRQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563DE179641;
	Mon, 29 Apr 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423545; cv=none; b=qP4+uC88cEw6u2kt3Zp953B6SZxYUHu5ulqgdZVmjUNH7zdWVt4tXx1V5mBUgoCWmQaO1TrxxAE2rP0afTl+xAt93sjQxKi9Dgc6i9LsJKBwP6bBqoK3wdPR0GYlovzIyXxDmWIQqqpfxW0ru1kRtKO1iVpIIvpWu8xOV08L0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423545; c=relaxed/simple;
	bh=K3a2iZ9Cz/1M52sNjT+DInoYMFpT7/x83Kmbuiq20Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCaHGjm0eTsQ6V/eUzZgiDn2/6utnaMSW70QyJPnJDtUsMJnR5ZuMLnr2/3VJFZGLMfrK6AKm3k4x/CX/P1F7RRzppP0f/UeV+6yf5RctgvEx910vZG54GNQgZ+xzwNAMrjbmoj7i+kxLzkANvA60dWx84ffdTVqOlFoqvQ1JOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsTxMjRQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28C0C113CD;
	Mon, 29 Apr 2024 20:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714423544;
	bh=K3a2iZ9Cz/1M52sNjT+DInoYMFpT7/x83Kmbuiq20Fk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AsTxMjRQJTS2LxmMjhScPaQzbxTu0Z8/typvFFYYOK5xUCiCKU945h3bHI8rHYG2s
	 1GMyzEL7fY9wxdg5JWCVvJkXiZOvQdkwYq9NMvOqeYRscyRaVf2lkNmPx8D5CPkR2I
	 iTG5DTVvGTFtvOmez1V2LV4EM1CzUygTVLFY3HPh8jcH6GIwcoM1l6l3Ypa7bvfdRt
	 pYx0SI4XBH4+Fgo+QdbDC8RxDBUga7Vyv1jtEjkwBbi/h7Iqb5A3mrrRPmHDyNxGxT
	 QMtfgvSzigCNUb4MwVE2OddSCoHl7A34g3/NosOhrdWWE1JcYVJg1Y7wICfHhT6+J2
	 aEkhEAgEZTe0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 588E4CE0B6B; Mon, 29 Apr 2024 13:45:44 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:45:44 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: tglx@linutronix.de, frederic@kernel.org, neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix suspicious RCU usage in __do_softirq()
Message-ID: <9f227fd2-13b2-4c78-b3b3-05ef6d583078@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240427102808.29356-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427102808.29356-1-qiang.zhang1211@gmail.com>

On Sat, Apr 27, 2024 at 06:28:08PM +0800, Zqiang wrote:
> Currently, the condition "__this_cpu_read(ksoftirqd) == current" is
> checked to ensure the rcu_softirq_qs() is invoked in ksoftirqd tasks
> context for non-RT kernels. however, in some scenarios, this condition
> will be broken.
> 
>      ksoftirqd/0
> ->finish_task_switch
>   ->put_task_struct_rcu_user
>     ->call_rcu(&task->rcu, delayed_put_task_struct)
>       ->__kasan_record_aux_stack
>         ->pfn_valid
>           ->rcu_read_lock_sched()
>             <interrupt>
>              __irq_exit_rcu
>              ->__do_softirq
>                -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
>                    __this_cpu_read(ksoftirqd) == current)
>                    ->rcu_softirq_qs
>                      ->RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))
> 
> The rcu quiescent states is reported occurs in the rcu-read critical
> section, so the lockdep warning is triggered. this commit therefore
> remove "__this_cpu_read(ksoftirqd) == current" condition check, generate
> new "handle_softirqs(bool kirqd)" function to replace __do_softirq() in
> run_ksoftirqdt(), and set parameter kirqd to true, make rcu_softirq_qs()
> be invoked only in ksofirqd tasks context for non-RT kernels.
> 
> Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop/T/#mea8aba4abfcb97bbf499d169ce7f30c4cff1b0e3
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/softirq.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index b315b21fb28c..e991d735be0d 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
>  static inline void lockdep_softirq_end(bool in_hardirq) { }
>  #endif
>  
> -asmlinkage __visible void __softirq_entry __do_softirq(void)
> +static void handle_softirqs(bool kirqd)
>  {
>  	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
>  	unsigned long old_flags = current->flags;
> @@ -563,8 +563,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  		pending >>= softirq_bit;
>  	}
>  
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> -	    __this_cpu_read(ksoftirqd) == current)
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kirqd)
>  		rcu_softirq_qs();
>  
>  	local_irq_disable();
> @@ -584,6 +583,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>  	current_restore_flags(old_flags, PF_MEMALLOC);
>  }
>  
> +asmlinkage __visible void __softirq_entry __do_softirq(void)
> +{
> +	handle_softirqs(false);
> +}
> +
>  /**
>   * irq_enter_rcu - Enter an interrupt context with RCU watching
>   */
> @@ -921,7 +925,7 @@ static void run_ksoftirqd(unsigned int cpu)
>  		 * We can safely run softirq on inline stack, as we are not deep
>  		 * in the task stack here.
>  		 */
> -		__do_softirq();
> +		handle_softirqs(true);
>  		ksoftirqd_run_end();
>  		cond_resched();
>  		return;
> -- 
> 2.17.1
> 

