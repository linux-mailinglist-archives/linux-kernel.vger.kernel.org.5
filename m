Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696F676D607
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjHBRuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjHBRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:49:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA544B7;
        Wed,  2 Aug 2023 10:49:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBB4B61A73;
        Wed,  2 Aug 2023 17:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236FFC433C8;
        Wed,  2 Aug 2023 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690998534;
        bh=ec++qd+96KFIy686wWR0g6gZlFG7AhB4I5X3AHouovE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gQgov8TXV7aMMrG4qm3LbiCBnMZBGnIhXpvZ3e/awF1e7R8hw19JT/Urv7O3laRfT
         fshhhiU4UR5UXbvsf8Y81pRqirlso7KI13sNI2AXwcFemvPj9iYIX5zErlveCaFYoS
         0EOExx6E60EDCMnxxO66zLQn3T5EBeoZ9rVW1dSHsThPovkvNqHPMaUS1WZwgv1IZ4
         os+UAD2cg5KaUBykb4cfjfeQ9qwZFeVAUjB4Ija7ecOw61LYXJLul1oEt7sQ5ucFqI
         DW06aWKd2Jk3M4ba3qq0Ula1BIkilSRa+BJaBqAMchOEWVJ7EkrhOiDR76FEHS5wut
         m3YSwr8S2IKZw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A8786CE0927; Wed,  2 Aug 2023 10:48:53 -0700 (PDT)
Date:   Wed, 2 Aug 2023 10:48:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Roy Hopkins <rhopkins@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Message-ID: <8ab3ca72-e20c-4b18-803f-bf6937c2cd70@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
 <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
 <CAHk-=wj5iESP-=gJSHe0Mfi=Xh2HdSsy+nm8NSr7DbXB9aBDGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj5iESP-=gJSHe0Mfi=Xh2HdSsy+nm8NSr7DbXB9aBDGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:14:51AM -0700, Linus Torvalds wrote:
> Two quick comments, both of them "this code is a bit odd" rather than
> anything else.

Good to get eyes on this code, so thank you very much!!!

> On Tue, 1 Aug 2023 at 12:11, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> 
> Why is this file called "tasks.h"?
> 
> It's not a header file. It makes no sense. It's full of C code. It's
> included in only one place. It's just _weird_.

You are right, it is weird.

This is a holdover from when I was much more concerned about being
criticized for having #ifdef in a .c file, and pretty much every
line in this file is under some combination or another of #ifdefs.
This concern led to kernel/rcu/tree_plugin.h being set up in this way
back when preemptible RCU was introduced, and for good or for bad I just
kept following that pattern.

We could convert this to a .c file, keep the #ifdefs, drop some instances
of "static", add a bunch of declarations, and maybe (or maybe not) push a
function or two into some .h file for performance/inlining reasons.  Me, I
would prefer to leave it alone, but we can certainly change it.

> However, more relevantly:
> 
> > +               mutex_unlock(&rtp->tasks_gp_mutex);
> >                 set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
> 
> Isn't the tasks_gp_mutex the thing that protects the gp state here?
> Shouldn't it be after setting?

Much of the gp state is protected by being accessed only by the gp
kthread.  But there is a window in time where the gp might be driven
directly out of the synchronize_rcu_tasks() call.  That window in time
does not have a definite end, so this ->tasks_gp_mutex does the needed
mutual exclusion during the transition of gp processing to the newly
created gp kthread.

> >                 rcuwait_wait_event(&rtp->cbs_wait,
> >                                    (needgpcb = rcu_tasks_need_gpcb(rtp)),
> >                                    TASK_IDLE);
> 
> Also, looking at rcu_tasks_need_gpcb() that is now called outside the
> lock, it does something quite odd.

The state of each callback list is protected by the ->lock field of
the rcu_tasks_percpu structure.  Yes, rcu_segcblist_n_cbs() is invoked
int rcu_tasks_need_gpcb() outside of the lock, but it is designed for
lockless use.  If it is modified just after the check, then there will
be a later wakeup on the one hand or we will just uselessly acquire that
->lock this one time on the other.

Also, ncbs records the number of callbacks seen in that first loop,
then used later, where its value might be stale.  This might result in
a collapse back to single-callback-queue operation and a later expansion
back up.  Except that at this point we are still in single-CPU mode, so
there should not be any lock contention, which means that there should
still be but a single callback queue.  The transition itself is protected
by ->cbs_gbl_lock.

> At the very top of the function does
> 
>         for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
> 
> and 'smp_load_acquire()' is all about saying "everything *after* this
> load is ordered,
> 
> But the way it is done in that loop, it is indeed done at the
> beginning of the loop, but then it's done *after* the loop too, so the
> last smp_load_acquire seems a bit nonsensical.
> 
> If you want to load a value and say "this value is now sensible for
> everything that follows", I think you should load it *first*. No?
> 
> IOW, wouldn't the whole sequence make more sense as
> 
>         dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
>         for (cpu = 0; cpu < dequeue_limit; cpu++) {
> 
> and say that everything in rcu_tasks_need_gpcb() is ordered wrt the
> initial limit on entry?
> 
> I dunno. That use of "smp_load_acquire()" just seems odd. Memory
> ordering is hard to understand to begin with, but then when you have
> things like loops that do the same ordered load multiple times, it
> goes from "hard to understand" to positively confusing.

Excellent point.  I am queueing that change with your Suggested-by.
If testing goes well, it will be as shown below.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 83049a893de5..94bb5abdbb37 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -432,6 +432,7 @@ static void rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
 static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 {
 	int cpu;
+	int dequeue_limit;
 	unsigned long flags;
 	bool gpdone = poll_state_synchronize_rcu(rtp->percpu_dequeue_gpseq);
 	long n;
@@ -439,7 +440,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 	long ncbsnz = 0;
 	int needgpcb = 0;
 
-	for (cpu = 0; cpu < smp_load_acquire(&rtp->percpu_dequeue_lim); cpu++) {
+	dequeue_limit = smp_load_acquire(&rtp->percpu_dequeue_lim);
+	for (cpu = 0; cpu < dequeue_limit; cpu++) {
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
 
 		/* Advance and accelerate any new callbacks. */
