Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26667B573C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbjJBPlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbjJBPli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:41:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B93B8;
        Mon,  2 Oct 2023 08:41:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521EAC433C8;
        Mon,  2 Oct 2023 15:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261295;
        bh=OIxjPCr9wkZbCOoxXWBU/u5qVifWIFEkIOgrP/+zrzg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bs7VDzIxp3PxLyxrVFfEnB2W6cL3823xMsPOR9+MVtzOSpvvQmKWsz32La4mqW3Ip
         FSXsrDi6V8bNib4o/jQ1sxuht04cRXiRD+sxRpStg08EIz8RzQ2/dVmKqQ5TFyh/Mf
         s+hPEn8B6fX+63vfYq4hw22sb1Z5x8RY00DpaKtD6MXAGNe9TX99t9xPoSwwq8j7lN
         VG0DKF28gE2HUG4uR/jUBjf1IsyQ86R0Yz/ltfJw1JPrsqi7Ouh1ReJtgzuvRG5N3/
         vO/bpeJfN3Ve6OluWOHBUmRFiceaTkHbC5kSzKrNgSv6Y0XXanzVET85Qja4EtA/8f
         qx4X8EB8XJZcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C70CFCE0CCF; Mon,  2 Oct 2023 08:41:34 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:41:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 05/10] rcu: Assume IRQS disabled from rcu_report_dead()
Message-ID: <d8c5364e-45ed-47bf-afe3-25cd17ec2f08@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-6-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 10:35:58PM +0200, Frederic Weisbecker wrote:
> rcu_report_dead() is the last RCU word from the CPU down through the
> hotplug path. It is called in the idle loop right before the CPU shuts
> down for good. Because it removes the CPU from the grace period state
> machine and reports an ultimate quiescent state if necessary, no further
> use of RCU is allowed. Therefore it is expected that IRQs are disabled
> upon calling this function and are not to be re-enabled again until the
> CPU shuts down.
> 
> Remove the IRQs disablement from that function and verify instead that
> it is actually called with IRQs disabled as it is expected at that
> special point in the idle path.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index a83ecab77917..8b5ebef32e17 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4553,11 +4553,16 @@ void rcu_cpu_starting(unsigned int cpu)
>   */
>  void rcu_report_dead(unsigned int cpu)
>  {
> -	unsigned long flags, seq_flags;
> +	unsigned long flags;
>  	unsigned long mask;
>  	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
>  	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
>  
> +	/*
> +	 * IRQS must be disabled from now on and until the CPU dies, or an interrupt
> +	 * may introduce a new READ-side while it is actually off the QS masks.
> +	 */
> +	lockdep_assert_irqs_disabled();
>  	// Do any dangling deferred wakeups.
>  	do_nocb_deferred_wakeup(rdp);
>  
> @@ -4565,7 +4570,6 @@ void rcu_report_dead(unsigned int cpu)
>  
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
> -	local_irq_save(seq_flags);
>  	arch_spin_lock(&rcu_state.ofl_lock);
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
> @@ -4579,8 +4583,6 @@ void rcu_report_dead(unsigned int cpu)
>  	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	arch_spin_unlock(&rcu_state.ofl_lock);
> -	local_irq_restore(seq_flags);
> -
>  	rdp->cpu_started = false;
>  }
>  
> -- 
> 2.41.0
> 
