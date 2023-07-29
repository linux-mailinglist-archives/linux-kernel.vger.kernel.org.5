Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328EB767F41
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 14:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjG2Mvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjG2Mvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 08:51:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 970BBE6A;
        Sat, 29 Jul 2023 05:51:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 575E22F4;
        Sat, 29 Jul 2023 05:52:18 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.77.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C9263F67D;
        Sat, 29 Jul 2023 05:51:33 -0700 (PDT)
Date:   Sat, 29 Jul 2023 13:51:25 +0100
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] cpuidle: teo: Update idle duration estimate when
 choosing shallower state
Message-ID: <ZMULTVTo5RjclWFt@e126311.manchester.arm.com>
References: <4506480.LvFx2qVVIh@kreacher>
 <CAJZ5v0hnRm7Nnup3HPWedEchzLD_9w8OPkhQ0vjpR3uAL3HUoQ@mail.gmail.com>
 <20230729090255.GD3945851@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230729090255.GD3945851@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 11:02:55AM +0200, Peter Zijlstra wrote:
> On Thu, Jul 27, 2023 at 10:12:56PM +0200, Rafael J. Wysocki wrote:
> > On Thu, Jul 27, 2023 at 10:05 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The TEO governor takes CPU utilization into account by refining idle state
> > > selection when the utilization is above a certain threshold.  The idle state
> > > selection is then refined by choosing an idle state shallower than the
> > > previously selected one.
> > >
> > > However, when this is done, the idle duration estimate needs to be updated
> > > so as to prevent the scheduler tick from being stopped while the candidate
> > > idle state is shallow, which may lead to excessive energy usage if the CPU
> > > is not interrupted quickly enough going forward.  Moreover, in case the
> > > scheduler tick has been stopped already and the new idle duration estimate
> > > is too small, the replacement candidate state cannot be used.
> > >
> > > Modify the relevant code to take the above observations into account.
> > >
> > > Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >
> > > @Peter: This doesn't attempt to fix the tick stopping problem, it just makes
> > > the current behavior consistent.
> > >
> > > @Anna-Maria: This is likely to basically prevent the tick from being stopped
> > > at all if the CPU utilization is above a certain threshold.  I'm wondering if
> > > your results will be affected by it and in what way.
> > >
> > > ---
> > >  drivers/cpuidle/governors/teo.c |   33 ++++++++++++++++++++++++++-------
> > >  1 file changed, 26 insertions(+), 7 deletions(-)
> > >
> > > Index: linux-pm/drivers/cpuidle/governors/teo.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/cpuidle/governors/teo.c
> > > +++ linux-pm/drivers/cpuidle/governors/teo.c
> > > @@ -397,13 +397,22 @@ static int teo_select(struct cpuidle_dri
> > >          * the shallowest non-polling state and exit.
> > >          */
> > >         if (drv->state_count < 3 && cpu_data->utilized) {
> > > -               for (i = 0; i < drv->state_count; ++i) {
> > > -                       if (!dev->states_usage[i].disable &&
> > > -                           !(drv->states[i].flags & CPUIDLE_FLAG_POLLING)) {
> > > -                               idx = i;
> > > +               /*
> > > +                * If state 0 is enabled and it is not a polling one, select it
> > > +                * right away and update the idle duration estimate accordingly,
> > > +                * unless the scheduler tick has been stopped.
> > > +                */
> > > +               if (!idx && !(drv->states[0].flags & CPUIDLE_FLAG_POLLING)) {
> > > +                       s64 span_ns = teo_middle_of_bin(0, drv);
> > > +
> > > +                       if (teo_time_ok(span_ns)) {
> > > +                               duration_ns = span_ns;
> > >                                 goto end;
> > >                         }
> > >                 }
> > > +               /* Assume that state 1 is not a polling one and select it. */
> > 
> > Well, I should also check if it is not disabled.  Will send a v2 tomorrow.
> > 
> > > +               idx = 1;
> > > +               goto end;
> > >         }
> > >
> > >         /*
> > > @@ -539,10 +548,20 @@ static int teo_select(struct cpuidle_dri
> > >
> > >         /*
> > >          * If the CPU is being utilized over the threshold, choose a shallower
> > > -        * non-polling state to improve latency
> > > +        * non-polling state to improve latency, unless the scheduler tick has
> > > +        * been stopped already and the shallower state's target residency is
> > > +        * not sufficiently large.
> > >          */
> > > -       if (cpu_data->utilized)
> > > -               idx = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> > > +       if (cpu_data->utilized) {
> > > +               s64 span_ns;
> > > +
> > > +               i = teo_find_shallower_state(drv, dev, idx, duration_ns, true);
> > > +               span_ns = teo_middle_of_bin(i, drv);
> > > +               if (teo_time_ok(span_ns)) {
> > > +                       idx = i;
> > > +                       duration_ns = span_ns;
> > > +               }
> > > +       }
> 
> So I'm not a huge fan of that utilized thing to begin with.. that feels
> like a hack. I think my patch 3 would achieve much the same, because if
> busy, you'll have short idles, which will drive the hit+intercept to
> favour low states, and voila.

Not exactly, simply relying on the hit/intercept metrics while
functional still just amounts to pretty much guessing as it does not
take any information about what the cpu might be doing into account
(beyond the timer events but that's the case for both approaches).

Apart from the approach of "extrapolating future results from past
mistakes" being slightly questionable to begin with it's in my view made
even worse by the fact that the metrics are per cpu - meaning they get
essentially invalidated when tasks get migrated between cores.

Using just the hit/intercept metrics approach you end up bumping into
the two scenarios below:

1) workload with short idle times -> governor selects too deep states
then adjusts to shallower idle -> -> workload changes to longer idle times
-> governor selects too shallow then adjusts to deeper -> workload changes to
shorter idle -> governor keeps selecting too deep states before adjusting

From looking at many traces I had this happens pretty often and we end
up with the governor selecting deep idle while the avg util on the cpu
is still massive and by looking at the util we could clearly tell that
deep idle here would be a mistake. The metrics cannot avoid making that
mistake, they need to make several of them in order to adjust. You can
just get stuck ping-ponging between being wrong both ways.

2) A reasonably large task gets migrated onto a different CPU. The
metrics on the target CPU still favour deeper idle as it wasn't doing
anything up until the migration, the metrics on the previous CPU favour
shallower states because of the workload having just run there. Now you
have the target CPU selecing too deep states before it can adjust and
the previous one selecting too shallow.

With the util approach on the other hand, the change in util will be
reflected right away so we can avoid making said mistakes on both the
cores.

> I didn't take it out -- yet -- because I haven't had much time to
> evaluate it.
> 
> Simply lowering one state at a random busy threshold is duct-tape if
> ever I saw some.

There might be a platform difference here, I do think it probably makes
more sense on Arm and similar platforms where we only have 2 states to
choose from so you use the threshold to distinguish between 'deep idle
desirable' and 'deep idle not desirable'. It does feel slighly more
hacky on Intel and other platforms with however many states those have
as instead of "change scenario A to B" it ends up more like "lower
scenario A". Doesn't make it a bad idea though, it can still be
beneficial and bring improvements just like on Arm I think. My initial
suggestion was to make this a separate governor for platforms and use
cases where this makes sense.

Besides, the threshold isn't random - just empirically the level that
worked best for the approach. As I wrote in the other thread, it might
benefit from being tweaked depending on the platform. That's not unique
to this patchset in any case, the kernel is full of these arbitrary
numbers that come from "worked on the developer's machine" and not much
else after all.

I put the numbers from testing this in the original thread for the
patchset, the util approach was consistently getting much less too deep
sleeps than the metrics approach in all the workloads I tested to the
point of being noticeable on both the performance and power usage plots
for our use cases (Android mobile phone). I never advocated for this to
be made the default but it is useful for our side of the industry so at
the very least we should have this as an option. In my view given that
x86 and arm do cpuidle very differently we probably should have separate
governors instead of trying to make a one size fits all approach but
that's a different story.
