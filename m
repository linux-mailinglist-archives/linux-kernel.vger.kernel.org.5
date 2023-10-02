Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57857B573B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238214AbjJBPpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbjJBPpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:45:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02581A4;
        Mon,  2 Oct 2023 08:45:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96035C433C7;
        Mon,  2 Oct 2023 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261535;
        bh=gnflgoj/4t5aXhvqE1jJ7nBMN1dHV/5laG0EVdN1cG4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UzcgrRZTcB0U5fChegyD+GRbZ3TS0yzcuIozm39qGUTZMC9bwD0p0pKp7XGK3ELSa
         Ibvgn175ol1Q+eEpdDw9zaJT+bduDTXYzOGelaXswzoHkiheBT87cZ4qp0LrupVLGE
         EzbS6UgbyXKX1HpAzhxIsrm57E8/FhqEEQiNyp6b+c7JXb/YwbRRsquBRYkTXW/9cR
         ntrTdY7z/FeoD+vTjifzO+iER9sHjddRtgfrNuOWVCDUU1rA3b/fX5TTYirM+Dn4yv
         kZeMAWXN8E7yb+TXKfd0+5j9ll5PKYpkXcx9LpsO59GKDYWTIa+qtacr75D/UxnUDq
         3KkqkBDS0+BUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3A527CE0CCF; Mon,  2 Oct 2023 08:45:35 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:45:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 06/10] rcu: Assume rcu_report_dead() is always called
 locally
Message-ID: <685c5e4e-491c-4fef-b7d7-499a32158e39@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-7-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-7-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:35:59PM +0200, Frederic Weisbecker wrote:
> rcu_report_dead() has to be called locally by the CPU that is going to
> exit the RCU state machine. Passing a cpu argument here is error-prone
> and leaves the possibility for a racy remote call.
> 
> Use local access instead.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

I was going to ask for an assertion for "cpu" in cpu_die_early(), but
given that its value comes from smp_processor_id() just a few lines
earlier, there isn't a whole lot of point to that.  So:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  arch/arm64/kernel/smp.c  | 2 +-
>  include/linux/rcupdate.h | 2 +-
>  kernel/cpu.c             | 2 +-
>  kernel/rcu/tree.c        | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index edd63894d61e..ce672cb69f1c 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -401,7 +401,7 @@ void __noreturn cpu_die_early(void)
>  
>  	/* Mark this CPU absent */
>  	set_cpu_present(cpu, 0);
> -	rcu_report_dead(cpu);
> +	rcu_report_dead();
>  
>  	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
>  		update_cpu_boot_status(CPU_KILL_ME);
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e5f920ade90..aa351ddcbe8d 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -122,7 +122,7 @@ static inline void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
>  void rcu_init(void);
>  extern int rcu_scheduler_active;
>  void rcu_sched_clock_irq(int user);
> -void rcu_report_dead(unsigned int cpu);
> +void rcu_report_dead(void);
>  void rcutree_migrate_callbacks(int cpu);
>  
>  #ifdef CONFIG_TASKS_RCU_GENERIC
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 88a7ede322bd..86f08eafbd9f 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1368,7 +1368,7 @@ void cpuhp_report_idle_dead(void)
>  	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
>  
>  	BUG_ON(st->state != CPUHP_AP_OFFLINE);
> -	rcu_report_dead(smp_processor_id());
> +	rcu_report_dead();
>  	st->state = CPUHP_AP_IDLE_DEAD;
>  	/*
>  	 * We cannot call complete after rcu_report_dead() so we delegate it
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8b5ebef32e17..289c51417cbc 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4551,11 +4551,11 @@ void rcu_cpu_starting(unsigned int cpu)
>   * from the outgoing CPU rather than from the cpuhp_step mechanism.
>   * This is because this function must be invoked at a precise location.
>   */
> -void rcu_report_dead(unsigned int cpu)
> +void rcu_report_dead(void)
>  {
>  	unsigned long flags;
>  	unsigned long mask;
> -	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
>  
>  	/*
> -- 
> 2.41.0
> 
