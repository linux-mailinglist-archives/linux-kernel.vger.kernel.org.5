Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF17724B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjHGMu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjHGMu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:50:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA210F7
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:50:25 -0700 (PDT)
Date:   Mon, 7 Aug 2023 14:50:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691412622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BEFaFKYfKNxwq9Ysp/Y3/mZoStEydaObwKA32CKX54=;
        b=FJ4661PcuZ3XaM6JGqcQOtlcLo3KzaYoDR0WS0U/QgMD+y0UVh+yafp0SltqEPv5wdYUYW
        lioOii7echIlzSyxCXSXkcUqbHS2g3+CnDUBHdYtgQbJsS08+H2w+ocvIAzmuhCrW55LYn
        VK03JTVnS5oeomQc+/guSakU0BsLJ6ZI7SRER8t28NAfZx1xBFujwmOgHCf1A+qTyPP2sF
        kFEjLeNcYOsW16XsApZ4jTmGL3WMfDvQbj9IklBWxxL4SU/zBbTgbM4wn+SmmhTxGPaoeD
        hD7KaR5qTCBxvEwjNA1VWEScf13o6WeqDnNwstqHnBdpXj70xpSWVYUBm+cDGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691412622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8BEFaFKYfKNxwq9Ysp/Y3/mZoStEydaObwKA32CKX54=;
        b=w6+J+gpdnh0IX9/xOzpRqD4YUw3HetztN4nrD3QxXiQzIqnXN7hZnN6qV3h+7vVmaHyp66
        2iJMqGNrnchaUQCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC PATCH 0/6] softirq: Start pushing down the big softirq lock
Message-ID: <20230807125020.0tMGart2@linutronix.de>
References: <20230801132441.559222-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230801132441.559222-1-frederic@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-01 15:24:35 [+0200], Frederic Weisbecker wrote:
> Networking softirqs can take time, holding the execution of block,
> tasklets, timers and RCU callbacks.
> 
> People fight hard through this big softirq lock, proposing more and
> more hacks over the years to deal with the resulting fundamental
> unfairness that is not only a problem for RT users.
> 
> Here is a proposal for an entrypoint to dealing with that issue in the
> long term. The purpose is to adopt a similar journey to the one we took
> with the BKL push-down but with timers. Most timers are unrelated to
> other softirq vectors, those can simply be tagged with the new
> TIMER_SOFTINTERRUPTIBLE flag that makes a callback soft-interruptible.
> The others can carry the TIMER_SOFTINTERRUPTIBLE after they get converted
> to use appropriate synchronization against other vectors callbacks
> (using spin_lock_bh() for example).

This doesn't work as proposed because of lock ordering:
|======================================================
|WARNING: possible circular locking dependency detected
|6.5.0-rc4-rt1+ #220 Not tainted
|------------------------------------------------------
|ktimers/0/15 is trying to acquire lock:
|ffff88817b41b6d8 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip+0xb7/0x1a0
|
|but task is already holding lock:
|ffff88817b41c820 (&base->expiry_lock){+.+.}-{2:2}, at: run_timer_softirq+0x61/0x3f0
|
|which lock already depends on the new lock.
|
|
|the existing dependency chain (in reverse order) is:
|
|-> #1 (&base->expiry_lock){+.+.}-{2:2}:
|       lock_acquire+0xd4/0x2f0
|       rt_spin_lock+0x21/0xf0
|       run_timer_softirq+0x61/0x3f0
|       __do_softirq+0x19b/0x4cb
|       run_timersd+0x92/0xf0
|       smpboot_thread_fn+0x211/0x330
|       kthread+0x110/0x130
|       ret_from_fork+0x2b/0x40
|       ret_from_fork_asm+0x1b/0x30
|
|-> #0 ((softirq_ctrl.lock)){+.+.}-{2:2}:
|       check_prev_add+0xe2/0xd60
|       __lock_acquire+0x132d/0x1700
|       lock_acquire+0xd4/0x2f0
|       rt_spin_lock+0x21/0xf0
|       __local_bh_disable_ip+0xb7/0x1a0
|       call_timer_fn+0x172/0x310
|       run_timer_softirq+0x331/0x3f0
|       __do_softirq+0x19b/0x4cb
|       run_timersd+0x92/0xf0
|       smpboot_thread_fn+0x211/0x330
|       kthread+0x110/0x130
|       ret_from_fork+0x2b/0x40
|       ret_from_fork_asm+0x1b/0x30
|
|other info that might help us debug this:
|
| Possible unsafe locking scenario:
|
|       CPU0                    CPU1
|       ----                    ----
|  lock(&base->expiry_lock);
|                               lock((softirq_ctrl.lock));
|                               lock(&base->expiry_lock);
|  lock((softirq_ctrl.lock));
|
| *** DEADLOCK ***
|
|2 locks held by ktimers/0/15:
| #0: ffffffff826e9ce0 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5d/0xf0
| #1: ffff88817b41c820 (&base->expiry_lock){+.+.}-{2:2}, at: run_timer_softirq+0x61/0x3f0

I posted a different series last week where I drop the lock for other
reasons at a different spot where it is safe to do so. It needs adopting
other level softirq handler (besides TIMER_SOFTIRQ) but there is no
need to deal with the individual callback.

However, how do you continue here? Assuming all timers are marked
TIMER_SOFTINTERRUPTIBLE then you could avoid the BH-lock at the
timer-softirq.
But when is a timer considered safe? Would the lack of the _bh suffix be
that and you would simply add it during your push down? 
Then you continue the same thing for the remaining softirqs. And once
you are done you would remove that RT lock within local_bh_disable()?
This isn't something a !RT user would benefit, right?

The other idea I have (besides the preemption point in each softirq
handler (mentioned earlier)) is to simple drop the BH-lock on RT. Unlike
mainline, RT wouldn't deadlock then. The only that would be missing is
synchronisation against local_bh_disable() only locking for variables.
From what I remember from the various BH-models we have in RT in the
past, that was the only thing that exploded.

Sebastian
