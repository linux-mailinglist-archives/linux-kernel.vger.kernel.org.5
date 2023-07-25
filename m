Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5376194E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjGYNHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjGYNHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:07:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60C319AF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:07:07 -0700 (PDT)
Date:   Tue, 25 Jul 2023 15:07:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690290426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slZ+HWqP5Nh2Vfnh5tKdfOTtxtBTJigSsF0f1sQ2R7k=;
        b=aNUAvLLjE840g7XLjSuGLFItAxJXS4Ala6goJzmEfDTwrFYCbWIZVhAICCjzIVbCndFQXO
        s+SEP374tt+Ks52VT2A1OFu9jQM6Ahry0ltdHLTmA+N1mfJDtyDziIb6suBuhlE5HAb09X
        FpHF/X9dWsMxvfK4Nr4F7Jlz7bSYIfA8GoZsZQ6d6tGyWqyrsKAjzG3timtfTaSIXzp0JP
        4pNfe24B78xP5Sz8wzBYZbErRjPhlw/M4tBWfWXrs1zXTjz7N0Clr2Gs/lc0wfEIUI856G
        9OzQN/PGOJ6TFiFafl+yfz6CFtGecSHAVQnJ5tU9HyurfpEVQc5tLsdGXE+pSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690290426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slZ+HWqP5Nh2Vfnh5tKdfOTtxtBTJigSsF0f1sQ2R7k=;
        b=I1G2QydmlIynsJRDxJCycE73K62asE1hABSu2ckeB0XHx2p7g75ScshSab40vHdx9KBfDM
        rZ9WsqzkDnZrxqBg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: Stopping the tick on a fully loaded system
In-Reply-To: <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
Message-ID: <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de> <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com> <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1942303961-1690290426=:3394"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1942303961-1690290426=:3394
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 24 Jul 2023, Rafael J. Wysocki wrote:

> On Sun, Jul 23, 2023 at 11:21 PM Frederic Weisbecker
> <frederic@kernel.org> wrote:
> >
> From the governor's perspective, tick_nohz_get_sleep_length() is
> supposed to return a deterministic upper bound on the upcoming idle
> duration (or at least it is used in the governors this way).  IOW, it
> is expected that the CPU will not be idle longer that the
> tick_nohz_get_sleep_length() return value.
> 
> There are other factors that may cause the governor to predict a
> shorter idle duration and the information coming from the scheduler
> may be regarded as one of them, but they are not deterministic.

Ok. Thanks for this explanation why two separate checks are required.

> > > Sure, teo takes scheduler utilization into account directly in the
> > > governor. But for me it is not comprehensible, why the CPU utilization
> > > check is done after asking for the possible sleep length where timers are
> > > taken into account. If the CPU is busy anyway, the information generated by
> > > tick_nohz_next_event() is irrelevant.
> 
> Why isn't it?
> 
> The CPU is idle at that point and it has gone idle for a reason.
> Surely, there was nothing to run on it at.
> 
> The scheduler only knows that the CPU has been busy recently, which
> may not imply anything on whether or not and when it is going to be
> busy again.
>

I went back one step and simply had a look at current upstream to
understand the behavior when going idle under load more detailed. I wanted
to see the distribution of idle time duration when the tick is stopped. I
used dbench tests with a script provided by Gautham to generate three
different loads: 100% load, 50% load and 25% load. The kernel is configured
with HZ=250. The system has 2 sockets, 64 cores per socket, 2 threads each
-> 256 CPUs. Three minutes trace data - idle periods larger than three
minutes are not tracked. The governor is teo.

I added tracepoints to the point where the tick is stopped and where the
tick is started again. I calculated the delta between the timestamps of
those two trace points and had a look at the distribution:


			100% load		50% load		25% load
			(top: ~2% idle)		(top: ~49% idle)	(top: ~74% idle;
									33 CPUs are completely idle)
			---------------		----------------	----------------------------
Idle Total		1658703	100%		3150522	100%		2377035 100%
x >= 4ms		2504	0.15%		2	0.00%		53	0.00%
4ms> x >= 2ms		390	0.02%		0	0.00%		4563	0.19%
2ms > x >= 1ms		62	0.00%		1	0.00%		54	0.00%
1ms > x >= 500us	67	0.00%		6	0.00%		2	0.00%
500us > x >= 250us	93	0.01%		39	0.00%		11	0.00%
250us > x >=100us	280	0.02%		1145	0.04%		633	0.03%
100us > x >= 50us	942	0.06%		30722	0.98%		13347	0.56%
50us > x >= 25us	26728	1.61%		310932	9.87%		106083	4.46%
25us > x >= 10us	825920	49.79%		2320683	73.66%		1722505	72.46%
10us > x > 5us		795197	47.94%		442991	14.06%		506008	21.29%
5us > x			6520	0.39%		43994	1.40%		23645	0.99%


99% of the tick stops only have an idle period shorter than 50us (50us is
1,25% of a tick length).

This is also the reason for my opinion, that the return of
tick_nohz_next_event() is completely irrelevant in a (fully) loaded case:
The return is in the range of ticks, and a tick is ~100 times longer than
the the duration of the majority of idle periods.


> > > And when the CPU is not busy, then it
> > > makes sense to ask for the sleep length also from a timer perspective.
> > >
> > > When this CPU utilization check is implemented directly inside the
> > > governor, every governor has to implement it on it's own. So wouldn't it
> > > make sense to implement a "how utilized is the CPU out of a scheduler
> 
> Yes, it would make sense to do that, but I thought that PELT was that
> thing.  Wasn't it?
> 
> > > perspective" in one place and use this as the first check in
> > > tick_nohz_get_sleep_length()/tick_nohz_next_event()?

[...]

> > As such, calling tmigr_cpu_deactivate() on next tick _evaluation_ time instead of
> > tick _stop_ time is always going to be problematic.
> >
> > Can we fix that and call tmigr_cpu_deactivate() from tick_nohz_stop_tick()
> > instead? This will change a bit the locking scenario because
> > tick_nohz_stop_tick() doesn't hold the base lock. Is it a problem though?
> > In the worst case a remote tick happens and handles the earliest timer
> > for the current CPU while it's between tick_nohz_next_event() and
> > tick_nohz_stop_tick(), but then the current CPU would just propagate
> > an earlier deadline than needed. No big deal.
> 
> FWIW, this sounds reasonable to me.
> 

The worst case scenario will not happen, because remote timer expiry only
happens when CPU is not active in the hierarchy. And with your proposal
this is valid after tick_nohz_stop_tick().

Nevertheless, I see some problems with this. But this also depends if there
is the need to change current idle behavior or not. Right now, this are my
concerns:

- The determinism of tick_nohz_next_event() will break: The return of
  tick_nohz_next_event() will not take into account, if it is the last CPU
  going idle and then has to take care of remote timers. So the first timer
  of the CPU (regardless of global or local) has to be handed back even if
  it could be handled by the hierarchy.

- When moving the tmigr_cpu_deactivate() to tick_nohz_stop_tick() and the
  return value of tmigr_cpu_deactivate() is before the ts->next_tick, the
  expiry has to be modified in tick_nohz_stop_tick().

- The load is simply moved to a later place - tick_nohz_stop_tick() is
  never called without a preceding tick_nohz_next_event() call. Yes,
  tick_nohz_next_event() is called under load ~8% more than
  tick_nohz_stop_tick(), but the 'quality' of the return value of
  tick_nohz_next_event() is getting worse.

- timer migration hierarchy is not a standalone timer infrastructure. It
  only makes sense to handle it in combination with the existing timer
  wheel. When the timer base is idle, the timer migration hierarchy with
  the migrators will do the job for global timers. So, I'm not sure about
  the impact of the changed locking - but I'm pretty sure changing that
  increases the probability for ugly races hidden somewhere between the
  lines.

Thanks,

	Anna-Maria
--8323329-1942303961-1690290426=:3394--
