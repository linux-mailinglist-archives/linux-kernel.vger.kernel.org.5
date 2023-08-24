Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CE378702D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbjHXNY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 09:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241100AbjHXNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 09:24:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE91519A5;
        Thu, 24 Aug 2023 06:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C2DD66BB3;
        Thu, 24 Aug 2023 13:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01DCC433C9;
        Thu, 24 Aug 2023 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692883450;
        bh=e1UdEt0G1ZuuvUbvI0q3HKGVn0n+qxCJo5AziWRbLV4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=esyYirSv9Hon2TircB+ssyXu/QsUmQVaHA0s7BVggtQOgHvM4d2M4h5fX6Di6Ra3J
         0kGuEsSjLLUFK7TqSz0VCgqYTgIlhugzVLM6QLO4DGpGjS+Cd0C8CQBhBl6if+qrXH
         As4PXO6LwAxvSs+O00R4Yu+WaCHsBMkFtJDYT+VMJY5sBz791aFLReyz69dTGwvv+Z
         XFIa5cQt34BvPAFBJZIBHTZsZXknyLq5/Tm1abT3b0uHmAZpHlBoxw18c5npSjd4I0
         v5w4Jx2WEeLdMz1MdwYs7S4jJN0tPb3Nn5l23OPDq28n+eI/excFOIBqyGXCduSPxl
         zjrLkL8zUGb1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 459BECE035E; Thu, 24 Aug 2023 06:24:10 -0700 (PDT)
Date:   Thu, 24 Aug 2023 06:24:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Message-ID: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAAhV-H6ejw=8afS0jmmQvKUrCw=qZm_P6SA0A+tuvvb8bsq4-Q@mail.gmail.com>
 <5777BD82-2C8D-4BAB-BDD3-C2C003DC57FB@joelfernandes.org>
 <CAAhV-H58OpQJapV7LDNjZ-vM7nNJrwdkBiPjFcCutO1yRsUshQ@mail.gmail.com>
 <87ttspct76.ffs@tglx>
 <03fe7084-0509-45fa-87ee-8f8705a221a6@paulmck-laptop>
 <CAAhV-H5Z3s=2_OyA_AJ1-NqXBtNrcs-EmsqYcrjc+qXmJ=SitQ@mail.gmail.com>
 <16827b4e-9823-456d-a6be-157fbfae64c3@paulmck-laptop>
 <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:40:00PM +0800, Huacai Chen wrote:
> Hi, Paul,
> On Thu, Aug 24, 2023 at 7:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Thu, Aug 24, 2023 at 10:50:41AM +0800, Huacai Chen wrote:
> > > Hi, Paul,
> > > On Thu, Aug 24, 2023 at 6:41 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Thu, Aug 24, 2023 at 12:03:25AM +0200, Thomas Gleixner wrote:
> > > > > On Thu, Aug 17 2023 at 16:06, Huacai Chen wrote:
> > > > > > On Thu, Aug 17, 2023 at 3:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >> > If  do_update_jiffies_64() cannot be used in NMI context,
> > > > > >>
> > > > > >> Can you not make the jiffies update conditional on whether it is
> > > > > >> called within NMI context?
> > > > >
> > > > > Which solves what? If KGDB has a breakpoint in the jiffies lock held
> > > > > region then you still dead lock.
> > > > >
> > > > > >> I dislike that..
> > > > > > Is this acceptable?
> > > > > >
> > > > > > void rcu_cpu_stall_reset(void)
> > > > > > {
> > > > > >         unsigned long delta;
> > > > > >
> > > > > >         delta = nsecs_to_jiffies(ktime_get_ns() - ktime_get_coarse_ns());
> > > > > >
> > > > > >         WRITE_ONCE(rcu_state.jiffies_stall,
> > > > > >                    jiffies + delta + rcu_jiffies_till_stall_check());
> > > > > > }
> > > > > >
> > > > > > This can update jiffies_stall without updating jiffies (but has the
> > > > > > same effect).
> > > > >
> > > > > Now you traded the potential dead lock on jiffies lock for a potential
> > > > > live lock vs. tk_core.seq. Not really an improvement, right?
> > > > >
> > > > > The only way you can do the above is something like the incomplete and
> > > > > uncompiled below. NMI safe and therefore livelock proof time interfaces
> > > > > exist for a reason.
> > > >
> > > > Just for completeness, another approach, with its own advantages
> > > > and disadvantage, is to add something like ULONG_MAX/4 to
> > > > rcu_state.jiffies_stall, but also set a counter indicating that this
> > > > has been done.  Then RCU's force-quiescent processing could decrement
> > > > that counter (if non-zero) and reset rcu_state.jiffies_stall when it
> > > > does reach zero.
> > > >
> > > > Setting the counter to three should cover most cases, but "live by the
> > > > heuristic, die by the heuristic".  ;-)
> > > >
> > > > It would be good to have some indication when gdb exited, but things
> > > > like the gdb "next" command can make that "interesting" when applied to
> > > > a long-running function.
> > >
> > > The original code is adding ULONG_MAX/2, so adding ULONG_MAX/4 may
> > > make no much difference? The simplest way is adding 300*HZ, but Joel
> > > dislikes that.
> >
> > I am not seeing the ULONG_MAX/2, so could you please point me to that
> > original code?
> 
> Maybe I misunderstand something, I say the original code means code
> before commit a80be428fbc1f1f3bc9ed924 ("rcu: Do not disable GP stall
> detection in rcu_cpu_stall_reset()").

Yes, my suggestion would essentially revert that patch.  It would
compensate by resetting rcu_state.jiffies_stall after a few calls
to rcu_gp_fqs().

Alternatively, we could simply provide a way for gdb users to manually
disable RCU CPU stall warnings at the beginning of their debug sessions
and to manually re-enable them when they are done.

							Thanx, Paul

> Huacai
> >
> > The advantage of ULONG_MAX/4 over ULONG_MAX/2 is that the time_after()
> > and time_before() macros have ULONG_MAX/4 slop in either direction
> > before giving you the wrong answer.  You can get nearly the same result
> > using ULONG_MAX/2, but it requires a bit more care.  And even on 32-bit
> > HZ=1000 systems, ULONG_MAX/4 gets you more than 12 days of gdb session
> > or jiffies-update delay before you start getting false positives.
> >
> > Then things can be reset after (say) 3 calls to rcu_gp_fqs() and
> > also the current reset at the beginning of a grace period, which
> > is in record_gp_stall_check_time().
> >
> > It would be better if RCU could get notified at both ends of the debug
> > session, but given gdb commands such as "next", along with Thomas's
> > point about gdb breakpoints being pretty much anywhere, this might or
> > might not be so helpful in real life.  But worth looking into.
> >
> >                                                         Thanx, Paul
> >
> > > Huacai
> > >
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > > Thanks,
> > > > >
> > > > >         tglx
> > > > > ---
> > > > > --- a/kernel/time/tick-sched.c
> > > > > +++ b/kernel/time/tick-sched.c
> > > > > @@ -51,6 +51,13 @@ struct tick_sched *tick_get_tick_sched(i
> > > > >   */
> > > > >  static ktime_t last_jiffies_update;
> > > > >
> > > > > +unsigned long tick_estimate_stale_jiffies(void)
> > > > > +{
> > > > > +     ktime_t delta = ktime_get_mono_fast_ns() - READ_ONCE(last_jiffies_update);
> > > > > +
> > > > > +     return delta < 0 ? 0 : div_s64(delta, TICK_NSEC);
> > > > > +}
> > > > > +
> > > > >  /*
> > > > >   * Must be called with interrupts disabled !
> > > > >   */
> > > > >
> > > > >
