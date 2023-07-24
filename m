Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1141875ED58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjGXIX1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 04:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGXIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:23:25 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B911B0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:23:24 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98273ae42d0so118894566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690187002; x=1690791802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iupMJVX8oPsfGnFbr5mFTtpNmz/P1KV5rvU9ROhakAk=;
        b=CMVw3EzpVQrW9s6RKO3gyE1Ivp+XxFNJpKOBXsZ1jWxSNaD/dEIQuQunjVfwdOSUUE
         e3I+0Q0Z3L2X0wtB5sf9e0j2/c/FnycNp7pFaUTiJ23lEb4RzP4uKF2kcXFTbnryvAhV
         i4QxGDDHKc/grj6xqSUiJ2D/HG/TIL1feQdmm0e55dghpQ5P239WlK74c9IiKHhWeyyL
         lLG1OQQpPdR3klWwgAS+lnIIWduN5SlTKKu5zVuXrw+DDqQLmH5oI2Ysls9wLWLnNL+a
         oJ6iLRXORAefaIwx4AJJY6Flx3QSXKnLDRf50KOP7KCeDiHLxLekbppQ4OhNvRZoO9Jz
         Wjnw==
X-Gm-Message-State: ABy/qLYF3AC97smmNyfqXADRm4Mzf9ZBoQzA7r3oU3YiibCtu9C7dkmL
        s2YMGUPa7V/X+90nuZtSeT4pctB3rpJ/Zt0sGTg=
X-Google-Smtp-Source: APBJJlHR2yowWPDWqJTjBA4uoOXlEgqmML5r5OGzqAT2UCpkV9AsNlU/cHPLdaplwa5SguMS1boLBd3N5fs3KyE4l0Y=
X-Received: by 2002:a17:906:518e:b0:993:d54b:3e4b with SMTP id
 y14-20020a170906518e00b00993d54b3e4bmr8105124ejk.0.1690187002256; Mon, 24 Jul
 2023 01:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
In-Reply-To: <ZL2Z8InSLmI5GU9L@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 24 Jul 2023 10:23:08 +0200
Message-ID: <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
Subject: Re: Stopping the tick on a fully loaded system
To:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 11:21 PM Frederic Weisbecker
<frederic@kernel.org> wrote:
>
> (Adding Rafael in Cc)
>
> Le Thu, Jul 20, 2023 at 03:00:37PM +0200, Anna-Maria Behnsen a écrit :
> > I had also a look at teo. It makes things better but does not solve the
> > underlying problem that I see here - please correct me if I missed
> > something or if I'm simply wrong:
> >
> > Yes, the governors have to decide in the end, whether it makes sense to
> > stop the tick or not. For this decision, the governors require information
> > about the current state of the core and how long nothing has to be done
> > propably. At the moment the governors therefore call
> > tick_nohz_get_sleep_length(). This checks first whether the tick can be
> > stopped. Then it takes into account whether rcu, irq_work, arch_work needs
> > the CPU or a timer softirq is pending. If non of this is true, then the
> > timers are checked. So tick_nohz_get_sleep_length() isn't only based on
> > timers already.
>
> Right but those things (rcu/irq work, etc...) act kind of like timers here
> and they should be considered as exceptions.
>
> The timer infrastructure shouldn't take into account the idle activity,
> this is really a job for the cpuidle governors.
>
> > The information about the sleep length of the scheduler perspective is
> > completely missing in the current existing check for the probable sleep
> > length.

Well, not exactly.

From the governor's perspective, tick_nohz_get_sleep_length() is
supposed to return a deterministic upper bound on the upcoming idle
duration (or at least it is used in the governors this way).  IOW, it
is expected that the CPU will not be idle longer that the
tick_nohz_get_sleep_length() return value.

There are other factors that may cause the governor to predict a
shorter idle duration and the information coming from the scheduler
may be regarded as one of them, but they are not deterministic.

> > Sure, teo takes scheduler utilization into account directly in the
> > governor. But for me it is not comprehensible, why the CPU utilization
> > check is done after asking for the possible sleep length where timers are
> > taken into account. If the CPU is busy anyway, the information generated by
> > tick_nohz_next_event() is irrelevant.

Why isn't it?

The CPU is idle at that point and it has gone idle for a reason.
Surely, there was nothing to run on it at.

The scheduler only knows that the CPU has been busy recently, which
may not imply anything on whether or not and when it is going to be
busy again.

> > And when the CPU is not busy, then it
> > makes sense to ask for the sleep length also from a timer perspective.
> >
> > When this CPU utilization check is implemented directly inside the
> > governor, every governor has to implement it on it's own. So wouldn't it
> > make sense to implement a "how utilized is the CPU out of a scheduler

Yes, it would make sense to do that, but I thought that PELT was that
thing.  Wasn't it?

> > perspective" in one place and use this as the first check in
> > tick_nohz_get_sleep_length()/tick_nohz_next_event()?

No, IMO it should be a separate check, because
tick_nohz_get_sleep_length() is expected to return a deterministic
upper bound on the idle duration whereas the scheduler information is
not deterministic.  It is the governor's role to decide how to take it
into account.

> Well, beyond that, there might be other situations where the governor may
> decide not to stop the tick even if tick_nohz_next_event() says it's possible
> to do so. That's the purpose of having that next event as an input among many
> others for the cpuidle governors.

Exactly.

> As such, calling tmigr_cpu_deactivate() on next tick _evaluation_ time instead of
> tick _stop_ time is always going to be problematic.
>
> Can we fix that and call tmigr_cpu_deactivate() from tick_nohz_stop_tick()
> instead? This will change a bit the locking scenario because
> tick_nohz_stop_tick() doesn't hold the base lock. Is it a problem though?
> In the worst case a remote tick happens and handles the earliest timer
> for the current CPU while it's between tick_nohz_next_event() and
> tick_nohz_stop_tick(), but then the current CPU would just propagate
> an earlier deadline than needed. No big deal.

FWIW, this sounds reasonable to me.
