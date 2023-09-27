Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58C07B077A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjI0PAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjI0PA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:00:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB095F4;
        Wed, 27 Sep 2023 08:00:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3FC1D21871;
        Wed, 27 Sep 2023 15:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695826826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ntrsNhAyOOgMXZMp6zh4HTN0Tx78MaxJouIAxQNAnI8=;
        b=Ti6s3RfzLpsWtNcGRLkWU78lEcclV7iQ8fZ8Sk/gHgmoL6gZikY8cEs53gy2XRqaXyBkeR
        yg+hVf19WoF2a/z52qzb9MDxryiWrtARId2lzxKiHdIQHNziR3jx9Nvnj9SsefNuSGmuHd
        N6G/151E9e0jDELXUPhczncG47APK6M=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DC3842C145;
        Wed, 27 Sep 2023 15:00:24 +0000 (UTC)
Date:   Wed, 27 Sep 2023 17:00:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v2 10/11] rcu: Add atomic write enforcement for
 rcu stalls
Message-ID: <ZRRDiAUJMHAgiDnD@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-11-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-11-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:55, John Ogness wrote:
> Invoke the atomic write enforcement functions for rcu stalls to
> ensure that the information gets out to the consoles.
> 
> It is important to note that if there are any legacy consoles
> registered, they will be attempting to directly print from the
> printk-caller context, which may jeopardize the reliability of
> the atomic consoles. Optimally there should be no legacy
> consoles registered.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/rcu/tree_stall.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 6f06dc12904a..0a58f8b233d8 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/kvm_para.h>
> +#include <linux/console.h>
>  
>  //////////////////////////////////////////////////////////////////////////////
>  //
> @@ -582,6 +583,7 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
>  
>  static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  {
> +	enum nbcon_prio prev_prio;
>  	int cpu;
>  	unsigned long flags;
>  	unsigned long gpa;
> @@ -597,6 +599,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	if (rcu_stall_is_suppressed())
>  		return;
>  
> +	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
> +
>  	/*
>  	 * OK, time to rat on our buddy...
>  	 * See Documentation/RCU/stallwarn.rst for info on how to debug
> @@ -651,6 +655,8 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
>  	panic_on_rcu_stall();
>  
>  	rcu_force_quiescent_state();  /* Kick them all. */
> +
> +	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);

The locations looks reasonable to me. I just hope that we would
use another API: nbcon_emergency_enter()/exit() in the end.

Note that the new API it would allow to flush the messages in
the emergency context immediately from printk().

In that case, we would to handle nmi_trigger_cpumask_backtrace()
some special way.

This function would be called from the emergency context but
the nmi_cpu_backtrace() callbacks would be called on other
CPUs in normal context.

For this case I would add something like:

void nbcon_flush_all_emergency(void)
{
	emum nbcon_prio = nbcon_get_default_prio();

	if (nbcon_prio >= NBCON_PRIO_EMERGENCY)
		nbcon_flush_all();
}

, where the POC of nbcon_get_default_prio() and nbcon_flush_all()
was in the replay to the 7th patch, see
https://lore.kernel.org/all/ZRLBxsXPCym2NC5Q@alley/


Best Regards,
Petr
