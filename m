Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226D37C71DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379197AbjJLPw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 11:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjJLPwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 11:52:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AF2C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 08:52:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12284C433C8;
        Thu, 12 Oct 2023 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697125973;
        bh=59K4iGekkWwDLDUC5rLrFmi/slgimt2MTbMdwt9WSi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lBp+BUbYpd/YaPoVSB/uUEflFKoMssInos8CrNILJVURJ4ZgGDnVwsgmnmCnBJE8a
         UpY3ZJbn/9WIh/Qdd6MBb7YN8fiGXVgFeJmzF6tt+4JBHkGWWgAnHROxzoR7Ni0mI4
         G4wCKiPE7JkPR0LLeSvqqd9/eISSTA7eVlmhzI3oYVhButFBTpm2PlOXFYx5SBGmtt
         1lJ1N3Yx7dF3LYpnckBUsvSCT7mcRBCku3x5k6uYFU+fuws/XxqOYb9s+RJa0cBePV
         1T50h4+WabYVBRO7wJ+3Yd9Vrbk8cQ1pOiTaVCG1DELdG7Ir1hE2PwRiNOmOiVP4a6
         OB2y4wbrnW97Q==
Date:   Thu, 12 Oct 2023 17:52:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v8 10/25] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Message-ID: <ZSgWUTsV37rEeh3t@localhost.localdomain>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <20231004123454.15691-11-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004123454.15691-11-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Oct 04, 2023 at 02:34:39PM +0200, Anna-Maria Behnsen a écrit :
>  static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  {
>  	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
> +	unsigned long basejiff = ts->last_jiffies;
>  	u64 basemono = ts->timer_expires_base;
> -	u64 expires = ts->timer_expires;
> +	bool timer_idle = ts->tick_stopped;
> +	u64 expires;
>  
>  	/* Make sure we won't be trying to stop it twice in a row. */
>  	ts->timer_expires_base = 0;
>  
> +	/*
> +	 * Now the tick should be stopped definitely - so timer base needs to be
> +	 * marked idle as well to not miss a newly queued timer.
> +	 */
> +	expires = timer_set_idle(basejiff, basemono, &timer_idle);
> +	if (!timer_idle) {
> +		/*
> +		 * Do not clear tick_stopped here when it was already set - it will
> +		 * be retained on next idle iteration when tick expired earlier
> +		 * than expected.
> +		 */
> +		expires = basemono + TICK_NSEC;
> +
> +		/* Undo the effect of timer_set_idle() */
> +		timer_clear_idle();

Looks like you don't even need to clear ->is_idle on failure. timer_set_idle()
does it for you.

> +	} else if (expires < ts->timer_expires) {
> +		ts->timer_expires = expires;
> +	} else {
> +		expires = ts->timer_expires;

Is it because timer_set_idle() doesn't recalculate the next hrtimer (as opposed
to get_next_timer_interrupt())? And since tick_nohz_next_event() did, the fact
that ts->timer_expires has a lower value may mean there is an hrtimer to take
into account and so you rather use the old calculation?

If so please add a comment explaining that because it's not that obvious. It's
worth noting also the side effect that the nearest timer may have been cancelled
in-between and we might reprogram too-early but the event should be rare enough
that we don't care.

Another reason also is that cpuidle may have programmed a shallow C-state
because it saw an early next expiration estimation. And if the related timer is
cancelled in-between and we didn't keep the old expiration estimation, we would
otherwise stop the tick for a long time with a shallow C-state.

> @@ -926,7 +944,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	 * first call we save the current tick time, so we can restart
>  	 * the scheduler tick in nohz_restart_sched_tick.
>  	 */
> -	if (!ts->tick_stopped) {
> +	if (!ts->tick_stopped && timer_idle) {

In fact, if (!ts->tick_stopped && !timer_idle) then you
should return now and avoid the reprogramming.

> @@ -1950,6 +1950,40 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
>  	if (cpu_is_offline(smp_processor_id()))
>  		return expires;
>  
> +	raw_spin_lock(&base->lock);
> +	nextevt = __get_next_timer_interrupt(basej, base);
> +	raw_spin_unlock(&base->lock);

It's unfortunate we have to lock here, which means we lock twice
on the idle path. But I can't think of a better way and I guess
the follow-up patches rely on that.

Thanks.
