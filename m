Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3093E7B0509
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjI0NPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjI0NPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:15:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5473FF5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:15:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EE57A21880;
        Wed, 27 Sep 2023 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695820507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R1lJlxF9feC5+oLdQvnirtsv5D6sDWokNHxdvRBj354=;
        b=PxBGJ/p/qeBZ1VWYBbtFczveMJzqPzSLtWr915pYoVX7/fCaF4ZkX/1kzTB+kPWMlqomGe
        WTxsjqTxZuDuFL9S2L0tlJ23N1PcSwXwxQePVdU1PsbKzZmx3/o7e2189ImWdSndRSKCG7
        V/N4noB5Ec0xlCTAKnFUboY7ehz9rrI=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8082D2C142;
        Wed, 27 Sep 2023 13:15:06 +0000 (UTC)
Date:   Wed, 27 Sep 2023 15:15:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH printk v2 09/11] panic: Add atomic write enforcement to
 oops
Message-ID: <ZRQq2ZqMN34qLs44@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-10-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:54, John Ogness wrote:
> Invoke the atomic write enforcement functions for oops to
> ensure that the information gets out to the consoles.
> 
> Since there is no single general function that calls both
> oops_enter() and oops_exit(), the nesting feature of atomic
> write sections is taken advantage of in order to guarantee
> full coverage between the first oops_enter() and the last
> oops_exit().
> 
> It is important to note that if there are any legacy consoles
> registered, they will be attempting to directly print from the
> printk-caller context, which may jeopardize the reliability of
> the atomic consoles. Optimally there should be no legacy
> consoles registered.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -630,6 +634,36 @@ bool oops_may_print(void)
>   */
>  void oops_enter(void)
>  {
> +	enum nbcon_prio prev_prio;
> +	int cpu = -1;
> +
> +	/*
> +	 * If this turns out to be the first CPU in oops, this is the
> +	 * beginning of the outermost atomic section. Otherwise it is
> +	 * the beginning of an inner atomic section.
> +	 */

This sounds strange. What is the advantage of having the inner
atomic context, please? It covers only messages printed inside
oops_enter() and not the whole oops_enter()/exit(). Also see below.

> +	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
> +
> +	if (atomic_try_cmpxchg_relaxed(&oops_cpu, &cpu, smp_processor_id())) {
> +		/*
> +		 * This is the first CPU in oops. Save the outermost
> +		 * @prev_prio in order to restore it on the outermost
> +		 * matching oops_exit(), when @oops_nesting == 0.
> +		 */
> +		oops_prev_prio = prev_prio;
> +
> +		/*
> +		 * Enter an inner atomic section that ends at the end of this
> +		 * function. In this case, the nbcon_atomic_enter() above
> +		 * began the outermost atomic section.
> +		 */
> +		prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
> +	}
> +
> +	/* Track nesting when this CPU is the owner. */
> +	if (cpu == -1 || cpu == smp_processor_id())
> +		oops_nesting++;
> +
>  	tracing_off();
>  	/* can't trust the integrity of the kernel anymore: */
>  	debug_locks_off();
> @@ -637,6 +671,9 @@ void oops_enter(void)
>  
>  	if (sysctl_oops_all_cpu_backtrace)
>  		trigger_all_cpu_backtrace();
> +
> +	/* Exit inner atomic section. */
> +	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);

This will not flush the messages when:

   + This CPU owns oops_cpu. The flush will have to wait for exiting
     the outer loop.

     In this case, the inner atomic context is not needed.


   + oops_cpu is owner by another CPU, the other CPU is
     just flushing the messages and block the per-console
     lock.

     The good thing is that the messages printed by this oops_enter()
     would likely get flushed by the other CPU.

     The bad thing is that oops_exit() on this CPU won't call
     nbcon_atomic_exit() so that the following OOPS messages
     from this CPU might need to wait for the printk kthread.
     IMHO, this is not what we want.


One solution would be to store prev_prio in per-CPU array
so that each CPU could call its own nbcon_atomic_exit().

But I start liking more and more the idea with storing
and counting nested emergency contexts in struct task_struct.
It is the alternative implementation in reply to the 7th patch,
https://lore.kernel.org/r/ZRLBxsXPCym2NC5Q@alley

Then it will be enough to simply call:

   + nbcon_emergency_enter() in oops_enter()
   + nbcon_emergency_exit() in oops_enter()

Best Regards,
Petr

PS: I just hope that you didn't add all this complexity just because
    we preferred this behavior at LPC 2022. Especially I hope
    that it was not me who proposed and preferred this.
