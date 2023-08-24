Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59687787579
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241522AbjHXQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbjHXQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:34:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E4E1FC4;
        Thu, 24 Aug 2023 09:34:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E51966346;
        Thu, 24 Aug 2023 16:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B783C433C7;
        Thu, 24 Aug 2023 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692894843;
        bh=PJ6Gx1h2AHQyzLM7RTHQj8zRPqXX05bgRWMeI7Je9Fk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CtU6yZ0sUohVDy9Z8AddYTDA3TRnli3TrC/xAdZ0rQhOjL4tCt9un1MAHbNIJZnDy
         o0FQdqGT09SW/h8c5jyMRI5X5SKOH/8HAja1+mAtN0nTBWtzSvoFHhmkDQfQ7mraaW
         m59z5wk0J8GYqt2NJcIJk/1cltJVB1B9uvvrkz8pyzma67SQ/IylDEzy6wHcj4pHWK
         lulpEqUpp8p0bGhbCwb4DFwaAi+Jz73n104ZahqJgark3oPH+LikA9Le5w5mJEAbK0
         0tDpUKLlQQS3udKvvMxJ0DIBAcAguCY/9Dzza+bMuzBGhSr7YsUkBV/6ysocUrw9lk
         iaWejQ+ZPWhFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 04FA8CE00C8; Thu, 24 Aug 2023 09:34:03 -0700 (PDT)
Date:   Thu, 24 Aug 2023 09:34:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <a0b30aa4-7007-436e-9f89-e60fd54f0964@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
 <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop>
 <20230824130942.GA3810470@google.com>
 <69b47bd2-307d-41ae-ae5f-e18c7a6f0379@paulmck-laptop>
 <CAAhV-H7PSR-3Xi84uz0cs4yojVxODPJnFo_G3BTQK+cHDxx-ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7PSR-3Xi84uz0cs4yojVxODPJnFo_G3BTQK+cHDxx-ww@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:03:31AM +0800, Huacai Chen wrote:
> Hi, Paul,
> 
> On Thu, Aug 24, 2023 at 9:28 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Thu, Aug 24, 2023 at 01:09:42PM +0000, Joel Fernandes wrote:
> > > On Thu, Aug 24, 2023 at 04:40:42AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > > > > Hi, Paul,
> > > > >
> > > > > On Thu, Aug 24, 2023 at 6:41 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > > > > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > > > > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > > > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > > > > > > >>
> > > > > > > >> Can you not make the jiffies update conditional on whether it is
> > > > > > > >> called within NMI context?
> > > > > > >
> > > > > > > Which solves what? If KGDB has a breakpoint in the jiffies lock held
> > > > > > > region then you still dead lock.
> > > > > > >
> > > > > > > >> I dislike that..
> > > > > > > > Is this acceptable?
> > > > > > > >
> > > > > > > > void rcu_cpu_stall_reset(void)
> > > > > > > > {
> > > > > > > >         unsigned long delta;
> > > > > > > >
> > > > > > > >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> > > > > > > >
> > > > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > > > >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > > > > > > > }
> > > > > > > >
> > > > > > > > This can update jiffies_stall without updating jiffies (but has the
> > > > > > > > same effect).
> > > > > > >
> > > > > > > Now you traded the potential dead lock on jiffies lock for a potential
> > > > > > > live lock vs. tk_core.seq. Not really an improvement, right?
> > > > > > >
> > > > > > > The only way you can do the above is something like the incomplete and
> > > > > > > uncompiled below. NMI safe and therefore livelock proof time interfaces
> > > > > > > exist for a reason.
> > > > > >
> > > > > > Just for completeness, another approach, with its own advantages
> > > > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > > > rcu_state.jiffies_stall, but also set a counter indicating that this
> > > > > > has been done.  Then RCU's force-quiescent processing could decrement
> > > > > > that counter (if non-zero) and reset rcu_state.jiffies_stall when it
> > > > > > does reach zero.
> > > > > >
> > > > > > Setting the counter to three should cover most cases, but "live by the
> > > > > > heuristic, die by the heuristic".  ;-)
> > > > > >
> > > > > > It would be good to have some indication when gdb exited, but things
> > > > > > like the gdb "next" command can make that "interesting" when applied to
> > > > > > a long-running function.
> > > > >
> > > > > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 may
> > > > > make no much difference? The simplest way is adding 300*HZ, but Joel
> > > > > dislikes that.
> > > >
> > > > I am not seeing the ULONG_MAX/2, so could you please point me to that
> > > > original code?
> > > >
> > > > The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_after()
> > > > and time_before() macros have ULONG_MAX/4 slop in either direction
> > > > before giving you the wrong answer.  You can get nearly the same result
> > > > using ULONG_MAX/2, but it requires a bit more care.  And even on 32-bit
> > > > HZ=1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb session
> > > > or jiffies-update delay before you start getting false positives.
> > > >
> > > > Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> > > > also the current reset at the beginning of a grace period, which
> > > > is in record_gp_stall_check_time().
> > >
> > > I like Paul's suggestion a lot except that if someone sets a breakpoint right
> > > when the jiffies is being reset, so then we have to come back to doing
> > > Thomas's suggestion.
> >
> > Please note that ULONG_MAX / 4 allows for jiffies not having been reset
> > for more than 10 days on 32-bit systems and for many millions of years
> > on 64-bit systems.  ;-)
> >
> > > So maybe a combination of Paul's and Thomas's suggestions (of using
> > > last_jiffies_update with the NMI-safe timestamp read) may work.
> >
> > I am absolutely not a fan of reworking all of the RCU CPU stall-warning
> > code to use some other timebase, at least not without a very important
> > reason to do so.  Nothing mentioned in this thread even comes close to
> > that level of importance.
> >
> > > > It would be better if RCU could get notified at both ends of the debug
> > > > session, but given gdb commands such as "next", along with Thomas's
> > > > point about gdb breakpoints being pretty much anywhere, this might or
> > > > might not be so helpful in real life.  But worth looking into.
> > >
> > > True, I was curious if rcu_cpu_stall_reset() can be called on a tickless
> > > kernel as well before jiffies gets a chance to update, in which case I think
> > > your suggestion of biasing the stall time and later resetting it would help a
> > > lot for such situations.
> >
> > What code path can possibly invoke rcu_cpu_stall_reset() after an
> > extended full-system nohz_full time period without first doing at least
> > one context switch on the CPU that invokes rcu_cpu_stall_reset()?
> 
> In my commit message, the "KGDB initial breakpoint" means the
> automatic call to kgdb_initial_breakpoint() at system boot. In my
> test:
> 1, the "stall timeout" is 21s;
> 2, when I use "continue" to exit kgdb, the "total jiffies delayed
> time" is ~40s (of course it will cause stall warning);
> 3, the "irq disabled time" (nearly the same as execution time of
> kgdb_cpu_enter()) is ~12s;
> 4, this means the "jiffies delayed time" due to the tickless mechanism is ~28s.
> 
> So, at least in this case, the tickless mechanism contributes much for
> the jiffies delay.

Checking kgdb_initial_breakpoint() call points:

o	From start_kernel():  This is before interrupts have been enabled
	on the boot CPU, and so is before the first RCU grace period has
	started.  Also before any CPU is able to enter nohz_full mode.
	So this is presumably not the code path you are hitting.

o	From opt_kgdb_wait():  This is an early_param() function, thus
	also invoked before interrupts have been enabled on the boot CPU.

o	From kgdb_register_io_module(): I don't have a good handle
	on this set of code paths, but I am guessing that this is
	where you are hitting your breakpoint.

And in the post-boot cases, if there is no RCU grace period in flight,
there will be no RCU CPU stall warning.  Otherwise, the RCU grace-period
kthread should have been running every few jiffies for the duration of
the grace period.  If it wasn't, for example, due to being starved by
the nohz_full user processes running at real-time priority, you would
get RCU CPU stall warnings anyway.

If the RCU grace-period kthread is running, then the system is not in pure
system-wide nohz_full mode, and the jiffies updates should be happening.
This means that even if you were running in this mode for many weeks on
a 32-bit system, the jiffies value should be sane.

Which in turn should mean that this should be fixable by adding
ULONG_MAX/4 to rcu_state.jiffies_stall in rcu_cpu_stall_reset(), along
with a reset via rcu_jiffies_till_stall_check() after a few calls to
rcu_gp_fqs().

Or am I missing something subtle here?

							Thanx, Paul

> Huacai
> 
> >
> >                                                         Thanx, Paul
> >
> > > thanks,
> > >
> > >  - Joel
> > >
> > >
> > > >                                                     Thanx, Paul
> > > >
> > > > > Huacai
> > > > >
> > > > > >
> > > > > >                                                         Thanx, Paul
> > > > > >
> > > > > > > Thanks,
> > > > > > >
> > > > > > >         tglx
> > > > > > > ---
> > > > > > > --- a/kernel/time/tick-sched.c
> > > > > > > +++ b/kernel/time/tick-sched.c
> > > > > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > > > > >   */
> > > > > > >  static ktime_t last_jiffies_update;
> > > > > > >
> > > > > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > > > > +{
> > > > > > > +     ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> > > > > > > +
> > > > > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > > > > +}
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * Must be called with interrupts disabled !
> > > > > > >   */
> > > > > > >
> > > > > > >
