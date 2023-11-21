Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ADC7F2231
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 01:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjKUAiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 19:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKUAiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 19:38:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C1CBB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 16:38:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D90E3C433C8;
        Tue, 21 Nov 2023 00:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700527090;
        bh=YaadEINN+MJ2ly7Vsrgyw8WtUuyHp41LyZ7pnHSZI7I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NEAPL1v4B1fGEyzm8CG5AD4iy/ZOD+hVeCbdkf6bmBFbows0o2JfcguPGkxq2XmbM
         xa87Px1CI28arzhCoGmlzLXrYU3yu056Ey6CBNEyNS7u80d29qycuiwrq9WOCBVkD9
         RvhbZhkt4jqpOw5rztsyAmrHhpKYYfvf3xM8LWutEdQDzOQdZQ06QyDM/TddnfHx6F
         +yX9ZnHVLcx8FayNLGuIvJ1hELFL4ilgQdyinsueEhXLpyat4C5P7mC7YTGM7S615x
         tDDfWvMW054oKg63e9QiETGJ7UKrBC3oYW0Y2gUEE1I1on4TOIELxtcE+TFGOPGyDU
         SeTDogLBJfz1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 787C7CE1390; Mon, 20 Nov 2023 16:38:10 -0800 (PST)
Date:   Mon, 20 Nov 2023 16:38:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
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
Subject: Re: [RFC PATCH 48/86] rcu: handle quiescent states for PREEMPT_RCU=n
Message-ID: <2027da00-273d-41cf-b9e7-460776181083@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107215742.363031-49-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107215742.363031-49-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 01:57:34PM -0800, Ankur Arora wrote:
> cond_resched() is used to provide urgent quiescent states for
> read-side critical sections on PREEMPT_RCU=n configurations.
> This was necessary because lacking preempt_count, there was no
> way for the tick handler to know if we were executing in RCU
> read-side critical section or not.
> 
> An always-on CONFIG_PREEMPT_COUNT, however, allows the tick to
> reliably report quiescent states.
> 
> Accordingly, evaluate preempt_count() based quiescence in
> rcu_flavor_sched_clock_irq().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  kernel/rcu/tree_plugin.h |  3 ++-
>  kernel/sched/core.c      | 15 +--------------
>  2 files changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index f87191e008ff..618f055f8028 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -963,7 +963,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
>   */
>  static void rcu_flavor_sched_clock_irq(int user)
>  {
> -	if (user || rcu_is_cpu_rrupt_from_idle()) {
> +	if (user || rcu_is_cpu_rrupt_from_idle() ||
> +	    !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {

This looks good.

>  		/*
>  		 * Get here if this CPU took its interrupt from user
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bf5df2b866df..15db5fb7acc7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8588,20 +8588,7 @@ int __sched _cond_resched(void)
>  		preempt_schedule_common();
>  		return 1;
>  	}
> -	/*
> -	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
> -	 * whether the current CPU is in an RCU read-side critical section,
> -	 * so the tick can report quiescent states even for CPUs looping
> -	 * in kernel context.  In contrast, in non-preemptible kernels,
> -	 * RCU readers leave no in-memory hints, which means that CPU-bound
> -	 * processes executing in kernel context might never report an
> -	 * RCU quiescent state.  Therefore, the following code causes
> -	 * cond_resched() to report a quiescent state, but only when RCU
> -	 * is in urgent need of one.
> -	 */
> -#ifndef CONFIG_PREEMPT_RCU
> -	rcu_all_qs();
> -#endif

But...

Suppose we have a long-running loop in the kernel that regularly
enables preemption, but only momentarily.  Then the added
rcu_flavor_sched_clock_irq() check would almost always fail, making
for extremely long grace periods.  Or did I miss a change that causes
preempt_enable() to help RCU out?

							Thanx, Paul

>  	return 0;
>  }
>  EXPORT_SYMBOL(_cond_resched);
> -- 
> 2.31.1
> 
