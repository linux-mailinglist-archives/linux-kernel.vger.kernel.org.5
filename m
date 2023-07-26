Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0157E763CA2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjGZQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGZQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:40:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F3394
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:40:26 -0700 (PDT)
Date:   Wed, 26 Jul 2023 18:40:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690389624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpfYoJkxfKlvizSJq1CZUYHU8NXnynMRb1kpFQmnsnU=;
        b=2R6tNcFPc0T0GSEZJf9FRVzhbJfpLKkwo2xjM3KGkDQosRvx7joBZQ/LTrsEAIwZDkfMOk
        TCWvQtO4TSgrq450F+y2bTctZcorwQoFcwhCUgzurnl6ywZBqxYC6UYeW2CjMqRuQOuxcS
        8gTgsp4YBcQ6eWjgcPGv5+TdzyHxtrsbbirwGvD+ePscL7cGRkTKpdKe1S/l7YaLT9yeJn
        mMMe7Cpo8x3BiiKCBbWka14oM7GNG03fenDmHr4uhUEWyKEUR5M7r7LOHUEiKEpIqBpJKQ
        PfenkxHf7nCjORlOyCHfbMTrb8oCb/l6+zb7MTek87PdvL+gv8zqvZXF0v6NKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690389624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tpfYoJkxfKlvizSJq1CZUYHU8NXnynMRb1kpFQmnsnU=;
        b=CRHVO02IV9ojoajhg6x+8nyTOfmnzDSbJPzytScWjYfDIyBGb4ikyGVziAUv/1iARSsKsY
        hrCltX71ntnpfeAg==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
In-Reply-To: <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
Message-ID: <f84ecbee-cb2a-d574-422-b357f0d4ca2@linutronix.de>
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de> <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com> <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com> <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de> <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com> <20230725222851.GC3784071@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-845300581-1690389624=:1720"
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

--8323329-845300581-1690389624=:1720
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 26 Jul 2023, Peter Zijlstra wrote:

> On Tue, Jul 25, 2023 at 04:27:56PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Jul 25, 2023 at 3:07 PM Anna-Maria Behnsen
> 
> > >                         100% load               50% load                25% load
> > >                         (top: ~2% idle)         (top: ~49% idle)        (top: ~74% idle;
> > >                                                                         33 CPUs are completely idle)
> > >                         ---------------         ----------------        ----------------------------
> > > Idle Total              1658703 100%            3150522 100%            2377035 100%
> > > x >= 4ms                2504    0.15%           2       0.00%           53      0.00%
> > > 4ms> x >= 2ms           390     0.02%           0       0.00%           4563    0.19%
> > > 2ms > x >= 1ms          62      0.00%           1       0.00%           54      0.00%
> > > 1ms > x >= 500us        67      0.00%           6       0.00%           2       0.00%
> > > 500us > x >= 250us      93      0.01%           39      0.00%           11      0.00%
> > > 250us > x >=100us       280     0.02%           1145    0.04%           633     0.03%
> > > 100us > x >= 50us       942     0.06%           30722   0.98%           13347   0.56%
> > > 50us > x >= 25us        26728   1.61%           310932  9.87%           106083  4.46%
> > > 25us > x >= 10us        825920  49.79%          2320683 73.66%          1722505 72.46%
> > > 10us > x > 5us          795197  47.94%          442991  14.06%          506008  21.29%
> > > 5us > x                 6520    0.39%           43994   1.40%           23645   0.99%
> > >
> > >
> > > 99% of the tick stops only have an idle period shorter than 50us (50us is
> > > 1,25% of a tick length).
> > 
> > Well, this just means that the governor predicts overly long idle
> > durations quite often under this workload.
> > 
> > The governor's decision on whether or not to stop the tick is based on
> > its idle duration prediction.  If it overshoots, that's how it goes.
> 
> This is abysmal; IIRC TEO tracks a density function in C state buckets
> and if it finds it's more likely to be shorter than 'predicted' by the
> timer it should pick something shallower.
> 
> Given we have this density function, picking something that's <1% likely
> is insane. In fact, it seems to suggest the whole pick-alternative thing
> is utterly broken.
> 

When I tried to understand the cstates, I noticed cstates have been
disabled on the zen3 machine I used for testing - I'm sorry, pilot error.

So the numbers above are caused by calling tick_nohz_idle_stop_tick()
unconditionally in cpuidle_idle_call() when cpuidle_not_available() is
true.

The regression Gautham observed was then caused by tons of
tick_nohz_next_event() calls, which are more expensive with the current
implementation of the timer migration hierarchy (if he tested with cstates
enabled...).

Nevertheless, I rerun the tests on current upstream with cstates enabled on
zen3 machine and on a SKL-X with governor teo, menu and ladder and
generated the following numbers (100% load):

Zen3:
			teo			menu			ladder
			------------------	------------------	------------------
Idle Total		2533	100.00%		5123	100.00%		1333746	100.00%
x >= 4ms		1458	57.56%		2764	53.95%		2304	0.17%
4ms> x >= 2ms		91	3.59%		95	1.85%		98	0.01%
2ms > x >= 1ms		56	2.21%		66	1.29%		57	0.00%
1ms > x >= 500us	64	2.53%		74	1.44%		61	0.00%
500us > x >= 250us	73	2.88%		39	0.76%		69	0.01%
250us > x >=100us	76	3.00%		88	1.72%		502	0.04%
100us > x >= 50us	33	1.30%		104	2.03%		3976	0.30%
50us > x >= 25us	39	1.54%		289	5.64%		64463	4.83%
25us > x >= 10us	199	7.86%		830	16.20%		1245946	93.42%
10us > x > 5us		156	6.16%		231	4.51%		9452	0.71%
5us > x			288	11.37%		543	10.60%		6818	0.51%

tick_nohz_next_event()
total count		8839790			2113357			1363896



SKL-X:
			teo			menu			ladder
			------------------	------------------	------------------
Idle Total		2388	100.00%		2047	100.00%		693514	100.00%
x >= 4ms		2047	85.72%		1347	65.80%		1141	0.16%
4ms> x >= 2ms		29	1.21%		47	2.30%		18	0.00%
2ms > x >= 1ms		20	0.84%		9	0.44%		10	0.00%
1ms > x >= 500us	21	0.88%		17	0.83%		10	0.00%
500us > x >= 250us	15	0.63%		26	1.27%		9	0.00%
250us > x >=100us	67	2.81%		39	1.91%		24	0.00%
100us > x >= 50us	18	0.75%		26	1.27%		17	0.00%
50us > x >= 25us	15	0.63%		28	1.37%		2141	0.31%
25us > x >= 10us	31	1.30%		61	2.98%		108208	15.60%
10us > x > 5us		37	1.55%		195	9.53%		242809	35.01%
5us > x			88	3.69%		252	12.31%		339127	48.90%

tick_nohz_next_event()
total count		2317973			2481724			701069



With this (and hopefully without another pilot error), I see the following
'open points' where improvement or more thoughts might be good:

- Without cstates enabled, it is possible to change the cpuidle governors
  even if they do not have an impact on idle behavior but at the first
  glance it looks like cpuidle governors are used. Is this behavior
  intended?

- When there is no cpuidle driver, tick_nohz_idle_stop_tick() is called
  unconditionally - is there the possibility to make an easy check whether
  the CPU is loaded?

- The governors teo and menu do the tick_nohz_next_event() check even if
  the CPU is fully loaded and but the check is not for free.

- timer bases are marked idle in tick_nohz_next_event() when the next
  expiry is more than a tick away. But when the tick can not be stopped,
  because CPU is loaded and timer base is alreay marked idle, a remote
  timer enqueue before clearing timer base idle information will lead to a
  IPI which is also expensive.

  It might be worth a try to do only a (maybe leaner) check for the next
  timer in tick_nohz_next_event() and do the actual idle dance in
  tick_nohz_stop_tick(). When a timer is enqueued remote between
  tick_nohz_next_event() and tick_nohz_stop_tick() call, there is no need
  for an IPI - CPU might be prevented from stopping the tick. This is also
  the case at the moment and only solved by an IPI after tick is already
  stopped.

  With regard to the timer migration hierarchy, there might be the
  possibility to do also a quick check in tick_nohz_next_event() and do the
  final tmigr_cpu_deactivate() thing when stopping the tick and marking the
  timer bases idle. So no lock ordering change would be required here...

- Side note: When testing 'ladder' on SKL-X machine there was a strange
  pattern: All CPUs on the second socket, stopped the tick quite often
  (~12000) and all of the idle durations were below 50us. All CPUs on the
  first socket stopped the tick max ~100 times and most of the idle
  durations were longer than 4ms (HZ=250).


Thanks,

	Anna-Maria

--8323329-845300581-1690389624=:1720--
