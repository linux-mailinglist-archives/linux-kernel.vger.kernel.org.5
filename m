Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2311C761BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGYO2t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjGYO21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:28:27 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C52E2682
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:28:08 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso1377832fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295288; x=1690900088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5O6Sn5F+vixIoT08dpn3tSzkl82lGLk+JO/up7j+YA=;
        b=eG9LMrSgb36Zy9s3kLdqvJpaaYtM8nN8S5JEvVqaC6zdlK2k6P9LTVbIoC9pkV7aq8
         iyAieBFkDQtUNm/zU7JVEtPmK0ORjtv6opsq/qfcpoX52WjqrY/sk2s9y6gBNpcqQN2n
         Qt9VkfiYgUbP8sOtikD+5QaqhpxcJD09toVMfyiIGfoVuN+0lMEyrkSIilMRjKyF+/uI
         MF9iJenhsTXy/UCSOf2d4tsTXbCPPyzRbeV8NhbgvykJitEf9Enr7Ud9sme06DfM1Lm+
         6zCJc3sicoc1Ey9OraMkZQYRnI4Ued42vXOciwbxK5f0Pq52JsypZkwcfbIrvcfMMUQt
         JCLQ==
X-Gm-Message-State: ABy/qLY9jMSJvQCBaaokP/bb67jxhbm3uM4vneSP4UX7GhxmlKXT/8TK
        mhjIeEDBzdJ/3GMgkYIoILt0gaid2vLMRByOK8s=
X-Google-Smtp-Source: APBJJlEzs5QXNnZA09eZYBz4Z4ZrdRLd4dBq4hXspdADZXi+jozy2E7ca+tDURAm8Ic/0XTTCsZXaaSK5sFIjbZb+ng=
X-Received: by 2002:a4a:de44:0:b0:563:3b56:5dc1 with SMTP id
 z4-20020a4ade44000000b005633b565dc1mr8804854oot.0.1690295287803; Tue, 25 Jul
 2023 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com> <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
In-Reply-To: <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 25 Jul 2023 16:27:56 +0200
Message-ID: <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
Subject: Re: Stopping the tick on a fully loaded system
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 3:07 PM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> Hi,
>
> On Mon, 24 Jul 2023, Rafael J. Wysocki wrote:
>
> > On Sun, Jul 23, 2023 at 11:21 PM Frederic Weisbecker
> > <frederic@kernel.org> wrote:
> > >
> > From the governor's perspective, tick_nohz_get_sleep_length() is
> > supposed to return a deterministic upper bound on the upcoming idle
> > duration (or at least it is used in the governors this way).  IOW, it
> > is expected that the CPU will not be idle longer that the
> > tick_nohz_get_sleep_length() return value.
> >
> > There are other factors that may cause the governor to predict a
> > shorter idle duration and the information coming from the scheduler
> > may be regarded as one of them, but they are not deterministic.
>
> Ok. Thanks for this explanation why two separate checks are required.
>
> > > > Sure, teo takes scheduler utilization into account directly in the
> > > > governor. But for me it is not comprehensible, why the CPU utilization
> > > > check is done after asking for the possible sleep length where timers are
> > > > taken into account. If the CPU is busy anyway, the information generated by
> > > > tick_nohz_next_event() is irrelevant.
> >
> > Why isn't it?
> >
> > The CPU is idle at that point and it has gone idle for a reason.
> > Surely, there was nothing to run on it at.
> >
> > The scheduler only knows that the CPU has been busy recently, which
> > may not imply anything on whether or not and when it is going to be
> > busy again.
> >
>
> I went back one step and simply had a look at current upstream to
> understand the behavior when going idle under load more detailed. I wanted
> to see the distribution of idle time duration when the tick is stopped. I
> used dbench tests with a script provided by Gautham to generate three
> different loads: 100% load, 50% load and 25% load. The kernel is configured
> with HZ=250. The system has 2 sockets, 64 cores per socket, 2 threads each
> -> 256 CPUs. Three minutes trace data - idle periods larger than three
> minutes are not tracked. The governor is teo.
>
> I added tracepoints to the point where the tick is stopped and where the
> tick is started again. I calculated the delta between the timestamps of
> those two trace points and had a look at the distribution:
>
>
>                         100% load               50% load                25% load
>                         (top: ~2% idle)         (top: ~49% idle)        (top: ~74% idle;
>                                                                         33 CPUs are completely idle)
>                         ---------------         ----------------        ----------------------------
> Idle Total              1658703 100%            3150522 100%            2377035 100%
> x >= 4ms                2504    0.15%           2       0.00%           53      0.00%
> 4ms> x >= 2ms           390     0.02%           0       0.00%           4563    0.19%
> 2ms > x >= 1ms          62      0.00%           1       0.00%           54      0.00%
> 1ms > x >= 500us        67      0.00%           6       0.00%           2       0.00%
> 500us > x >= 250us      93      0.01%           39      0.00%           11      0.00%
> 250us > x >=100us       280     0.02%           1145    0.04%           633     0.03%
> 100us > x >= 50us       942     0.06%           30722   0.98%           13347   0.56%
> 50us > x >= 25us        26728   1.61%           310932  9.87%           106083  4.46%
> 25us > x >= 10us        825920  49.79%          2320683 73.66%          1722505 72.46%
> 10us > x > 5us          795197  47.94%          442991  14.06%          506008  21.29%
> 5us > x                 6520    0.39%           43994   1.40%           23645   0.99%
>
>
> 99% of the tick stops only have an idle period shorter than 50us (50us is
> 1,25% of a tick length).

Well, this just means that the governor predicts overly long idle
durations quite often under this workload.

The governor's decision on whether or not to stop the tick is based on
its idle duration prediction.  If it overshoots, that's how it goes.

> This is also the reason for my opinion, that the return of
> tick_nohz_next_event() is completely irrelevant in a (fully) loaded case:

It is an upper bound and in a fully loaded case it may be way off.

> The return is in the range of ticks, and a tick is ~100 times longer than
> the the duration of the majority of idle periods.

Overall, this means that there is room for improvements in the idle governor.

> > > > And when the CPU is not busy, then it
> > > > makes sense to ask for the sleep length also from a timer perspective.
> > > >
> > > > When this CPU utilization check is implemented directly inside the
> > > > governor, every governor has to implement it on it's own. So wouldn't it
> > > > make sense to implement a "how utilized is the CPU out of a scheduler
> >
> > Yes, it would make sense to do that, but I thought that PELT was that
> > thing.  Wasn't it?
> >
> > > > perspective" in one place and use this as the first check in
> > > > tick_nohz_get_sleep_length()/tick_nohz_next_event()?
>
> [...]
>
> > > As such, calling tmigr_cpu_deactivate() on next tick _evaluation_ time instead of
> > > tick _stop_ time is always going to be problematic.
> > >
> > > Can we fix that and call tmigr_cpu_deactivate() from tick_nohz_stop_tick()
> > > instead? This will change a bit the locking scenario because
> > > tick_nohz_stop_tick() doesn't hold the base lock. Is it a problem though?
> > > In the worst case a remote tick happens and handles the earliest timer
> > > for the current CPU while it's between tick_nohz_next_event() and
> > > tick_nohz_stop_tick(), but then the current CPU would just propagate
> > > an earlier deadline than needed. No big deal.
> >
> > FWIW, this sounds reasonable to me.
> >
>
> The worst case scenario will not happen, because remote timer expiry only
> happens when CPU is not active in the hierarchy. And with your proposal
> this is valid after tick_nohz_stop_tick().
>
> Nevertheless, I see some problems with this. But this also depends if there
> is the need to change current idle behavior or not. Right now, this are my
> concerns:
>
> - The determinism of tick_nohz_next_event() will break:

That would be bad.

>   The return of
>   tick_nohz_next_event() will not take into account, if it is the last CPU
>   going idle and then has to take care of remote timers. So the first timer
>   of the CPU (regardless of global or local) has to be handed back even if
>   it could be handled by the hierarchy.
>
> - When moving the tmigr_cpu_deactivate() to tick_nohz_stop_tick() and the
>   return value of tmigr_cpu_deactivate() is before the ts->next_tick, the
>   expiry has to be modified in tick_nohz_stop_tick().
>
> - The load is simply moved to a later place - tick_nohz_stop_tick() is
>   never called without a preceding tick_nohz_next_event() call. Yes,
>   tick_nohz_next_event() is called under load ~8% more than
>   tick_nohz_stop_tick(), but the 'quality' of the return value of
>   tick_nohz_next_event() is getting worse.
>
> - timer migration hierarchy is not a standalone timer infrastructure. It
>   only makes sense to handle it in combination with the existing timer
>   wheel. When the timer base is idle, the timer migration hierarchy with
>   the migrators will do the job for global timers. So, I'm not sure about
>   the impact of the changed locking - but I'm pretty sure changing that
>   increases the probability for ugly races hidden somewhere between the
>   lines.

I'll let Frederic respond to the above, but from my perspective it all
just means that the idle governors in use today are not perfect.

However, they will never be perfect, because they only have a little
time to make a decision, so it's a matter of balancing that with
precision.
