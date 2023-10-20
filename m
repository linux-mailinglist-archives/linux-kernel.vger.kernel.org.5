Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76E7D05F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346808AbjJTAtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346767AbjJTAtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:49:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6EEFA;
        Thu, 19 Oct 2023 17:49:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CEF9C433C9;
        Fri, 20 Oct 2023 00:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697762943;
        bh=9IPz2MmxCzAMUtqeAKQ6/4/VO68F8fYr09w07o8HlVk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BuQZ4T8WbnmiItxronuQk02qekF/N0iZ20hsL6StDD8S5qJITFUOPXkr2JVuJcsyU
         pSeB/+Yr4PPRLN/B2TptPn/KkPpvPBuby3Jn03xgvXEDLm2D4+yUM4fqvj3ekO2s/J
         /Y7F8xuI+qxA1UR7YXUl2jMLEgMzaXxPjBxCz3IGKf7PHuRfzwjmwfXSqrFHkCLagF
         HNDAinJkl4KYZPmQhaAwinHLX2JBfbl+fUWn+3f6+/AU+AH58ZVrJAFdtWy2pp7/WS
         mya3qaMHUiyq/o8UpWLf1Dax50kMAGJ8VG7cqldUPXYWwZxg0KNqPWIDX+zn7a3EMn
         fwTNQ3gxE8ANA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1EA6BCE0DEA; Thu, 19 Oct 2023 17:49:03 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:49:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/4] rcu: Make tiny RCU use ksoftirqd to trigger a QS
 from idle
Message-ID: <d81f562a-f3d1-44f8-9bbd-a026aaa529ee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231019233543.1243121-1-frederic@kernel.org>
 <20231019233543.1243121-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019233543.1243121-4-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 01:35:42AM +0200, Frederic Weisbecker wrote:
> The commit:
> 
> 	cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
> 
> fixed an issue where rcutiny would request a quiescent state with
> setting TIF_NEED_RESCHED in early boot when init/0 has the PF_IDLE flag
> set but interrupts aren't enabled yet. A subsequent call to
> cond_resched() would then enable IRQs too early.
> 
> When callbacks are enqueued in idle, RCU currently performs the
> following:
> 
> 1) Call resched_cpu() to trigger exit from idle and go through the
>    scheduler to call rcu_note_context_switch() -> rcu_qs()
> 
> 2) rcu_qs() notes the quiescent state and raises RCU_SOFTIRQ if there
>    is a callback, waking up ksoftirqd since it isn't called from an
>    interrupt.
> 
> However the call to resched_cpu() can opportunistically be replaced and
> optimized with raising RCU_SOFTIRQ and forcing ksoftirqd wakeup instead.
> 
> It's worth noting that RCU grace period polling while idle is then
> suboptimized but such a usecase can be considered very rare or even
> non-existent.
> 
> The advantage of this optimization is that it also works if PF_IDLE is
> set early because ksoftirqd is created way after IRQs are enabled on
> boot and it can't be awaken before its creation. If
> raise_ksoftirqd_irqoff() is called after the first scheduling point
> but before kostfirqd is created, nearby voluntary schedule calls are
> expected to provide the desired quiescent state and in the worst case
> the first launch of ksoftirqd is close enough on the first initcalls.
> 
> Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

I did a touch-test of the series, and have started overnight testing.

							Thanx, Paul

> ---
>  kernel/rcu/tiny.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index fec804b79080..9460e4e9d84c 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -190,12 +190,15 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	local_irq_save(flags);
>  	*rcu_ctrlblk.curtail = head;
>  	rcu_ctrlblk.curtail = &head->next;
> -	local_irq_restore(flags);
>  
>  	if (unlikely(is_idle_task(current))) {
> -		/* force scheduling for rcu_qs() */
> -		resched_cpu(0);
> +		/*
> +		 * Force resched to trigger a QS and handle callbacks right after.
> +		 * This also takes care of avoiding too early rescheduling on boot.
> +		 */
> +		raise_ksoftirqd_irqoff(RCU_SOFTIRQ);
>  	}
> +	local_irq_restore(flags);
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> @@ -228,8 +231,16 @@ unsigned long start_poll_synchronize_rcu(void)
>  	unsigned long gp_seq = get_state_synchronize_rcu();
>  
>  	if (unlikely(is_idle_task(current))) {
> -		/* force scheduling for rcu_qs() */
> -		resched_cpu(0);
> +		unsigned long flags;
> +
> +		/*
> +		 * Force resched to trigger a QS. This also takes care of avoiding
> +		 * too early rescheduling on boot. It's suboptimized but GP
> +		 * polling on idle isn't expected much as a usecase.
> +		 */
> +		local_irq_save(flags);
> +		raise_ksoftirqd_irqoff(RCU_SOFTIRQ);
> +		local_irq_restore(flags);
>  	}
>  	return gp_seq;
>  }
> -- 
> 2.34.1
> 
