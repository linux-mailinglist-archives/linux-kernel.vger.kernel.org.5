Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB2C772902
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjHGPWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjHGPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:22:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AF10FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:22:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F3C61DAD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E00C433C7;
        Mon,  7 Aug 2023 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691421733;
        bh=7/lhRGbx1Z8mj8yTwu0TZl8hjKPrT6ZhZ2ZIvkkXYRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnsG8fxeV0cI4oAqvU8ZvZblZfbUcz7TQ3Koum112qMFhlUz/hdtLsseTUxdR+Eqa
         PyesnJKI2QwT4AWfLuJ6NKuoFBcN4Y1EJJRJDQLTKa67wxMzLn92dYiuTpvkqsxTjB
         nZDEnLrUnsfxPwgTE2LjQ4TrEF9/r3ORjO11lVLxRCjZfOWDXbj3foW0EM3vxIbHHz
         8WDOrdLJsGvX+yireB1q10El3EGNbx2YVxJCONN9e+1ogtZbzJdpeZCeEbu0fOEKOE
         Hit2fSOEdJFTvg0s74NMn+XpCebYIh/kDRFYnWE9TAVWpUp4N4mbydeh7gTlAJF+zq
         7migfJwZ19xcQ==
Date:   Mon, 7 Aug 2023 17:22:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC PATCH 0/6] softirq: Start pushing down the big softirq lock
Message-ID: <ZNEMImA1dWs07U3z@lothringen>
References: <20230801132441.559222-1-frederic@kernel.org>
 <20230807125020.0tMGart2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807125020.0tMGart2@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:50:20PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-08-01 15:24:35 [+0200], Frederic Weisbecker wrote:
> > Networking softirqs can take time, holding the execution of block,
> > tasklets, timers and RCU callbacks.
> > 
> > People fight hard through this big softirq lock, proposing more and
> > more hacks over the years to deal with the resulting fundamental
> > unfairness that is not only a problem for RT users.
> > 
> > Here is a proposal for an entrypoint to dealing with that issue in the
> > long term. The purpose is to adopt a similar journey to the one we took
> > with the BKL push-down but with timers. Most timers are unrelated to
> > other softirq vectors, those can simply be tagged with the new
> > TIMER_SOFTINTERRUPTIBLE flag that makes a callback soft-interruptible.
> > The others can carry the TIMER_SOFTINTERRUPTIBLE after they get converted
> > to use appropriate synchronization against other vectors callbacks
> > (using spin_lock_bh() for example).
> 
> This doesn't work as proposed because of lock ordering:
> |======================================================
> |WARNING: possible circular locking dependency detected
> |6.5.0-rc4-rt1+ #220 Not tainted
> |------------------------------------------------------
> |ktimers/0/15 is trying to acquire lock:
> |ffff88817b41b6d8 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip+0xb7/0x1a0
> |
> |but task is already holding lock:
> |ffff88817b41c820 (&base->expiry_lock){+.+.}-{2:2}, at: run_timer_softirq+0x61/0x3f0
> |
> |which lock already depends on the new lock.
> |
> |
> |the existing dependency chain (in reverse order) is:
> |
> |-> #1 (&base->expiry_lock){+.+.}-{2:2}:
> |       lock_acquire+0xd4/0x2f0
> |       rt_spin_lock+0x21/0xf0
> |       run_timer_softirq+0x61/0x3f0
> |       __do_softirq+0x19b/0x4cb
> |       run_timersd+0x92/0xf0
> |       smpboot_thread_fn+0x211/0x330
> |       kthread+0x110/0x130
> |       ret_from_fork+0x2b/0x40
> |       ret_from_fork_asm+0x1b/0x30
> |
> |-> #0 ((softirq_ctrl.lock)){+.+.}-{2:2}:
> |       check_prev_add+0xe2/0xd60
> |       __lock_acquire+0x132d/0x1700
> |       lock_acquire+0xd4/0x2f0
> |       rt_spin_lock+0x21/0xf0
> |       __local_bh_disable_ip+0xb7/0x1a0
> |       call_timer_fn+0x172/0x310
> |       run_timer_softirq+0x331/0x3f0
> |       __do_softirq+0x19b/0x4cb
> |       run_timersd+0x92/0xf0
> |       smpboot_thread_fn+0x211/0x330
> |       kthread+0x110/0x130
> |       ret_from_fork+0x2b/0x40
> |       ret_from_fork_asm+0x1b/0x30
> |
> |other info that might help us debug this:
> |
> | Possible unsafe locking scenario:
> |
> |       CPU0                    CPU1
> |       ----                    ----
> |  lock(&base->expiry_lock);
> |                               lock((softirq_ctrl.lock));
> |                               lock(&base->expiry_lock);
> |  lock((softirq_ctrl.lock));
> |
> | *** DEADLOCK ***
> |
> |2 locks held by ktimers/0/15:
> | #0: ffffffff826e9ce0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5d/0xf0
> | #1: ffff88817b41c820 (&base->expiry_lock){+.+.}-{2:2}, at:
> |run_timer_softirq+0x61/0x3f0

Right, need to pull that to the caller before it releases the lock.

> 
> I posted a different series last week where I drop the lock for other
> reasons at a different spot where it is safe to do so. It needs adopting
> other level softirq handler (besides TIMER_SOFTIRQ) but there is no
> need to deal with the individual callback.

I've seen that yes, I have yet to review deeper but it looks like a good idea
in any case to have a preemption point between timer callbacks.

RCU already does a similar thing from its rcu boost processing with
cond_resched_tasks_rcu_qs().

> 
> However, how do you continue here? Assuming all timers are marked
> TIMER_SOFTINTERRUPTIBLE then you could avoid the BH-lock at the
> timer-softirq.
> But when is a timer considered safe? Would the lack of the _bh suffix be
> that and you would simply add it during your push down?

Yeah that requires manual inspection. A timer that obviously doesn't mess
up with other softirqs, as is the case most of the time, can simply get the flag.

Other timers can be dealt with individually with local_bh_disable() or
spin_lock_bh() or critical section.

> Then you continue the same thing for the remaining softirqs. And once
> you are done you would remove that RT lock within local_bh_disable()?
> This isn't something a !RT user would benefit, right?

Why not? A long lasting ksoftirqd handling lots of NET_RX could be
interrupted by a timer/rcu softirq in !RT for example. Further, there
could even be more than one ksoftirqd if necessary, though I doubt it.

> The other idea I have (besides the preemption point in each softirq
> handler (mentioned earlier)) is to simple drop the BH-lock on RT. Unlike
> mainline, RT wouldn't deadlock then. The only that would be missing is
> synchronisation against local_bh_disable() only locking for variables.
> From what I remember from the various BH-models we have in RT in the
> past, that was the only thing that exploded.

I thought the issue was about timers fiddling with per-cpu state assuming
they wouldn't be disturbed by other vectors and thus they lack
local_bh_disable() on appropriate places. Or perhaps I misunderstood?

Otherwise all timers can carry TIMER_SOFTINTERRUPTIBLE right away, right?

Thanks.
