Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17364763BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjGZPyC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjGZPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:54:00 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FA3100
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:53:59 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-565ac1880a2so799410eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690386838; x=1690991638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERNP5mjf9nSpKTlRjc4GV2PylaFgsrLTZKl0/iko4So=;
        b=iTrv8eZ+4b/aHravtvdeVEviV0qZ2s4b/2CviMf0VpCZHl8shlSHZkQj4L56M/VJpa
         Co5WmkVsmBjTgWG5e4Xg1Kkp1TX2B8JncvXLoKAnEmxjShaWUDzHDG9F/u973ODQAV6q
         I6c1ZCvBHqqgujTLkdBQ5fLeV88qF1NEQwaFopYdM5Cxxcjq5ZUrxMBfZi9q1rqfvHq+
         kxTg/mVNol6Kzpzq2u2WuCsWDo1mQa8nGm2wFC95Sstkzc64DEnWc+1UvVRG1/3SwaUX
         u+q86iJdbkobK8IvZXTX+F3RULk3r8SonRfSu1Y+S+5Q0WkLQ17dw5EgdC7V4sJhr6Cj
         Dsaw==
X-Gm-Message-State: ABy/qLbpgMkdYPvA08ESEp4OiswVzxLYTlrcGjrrfYaRagbNeTFsdUKI
        2Kdx5QJh5OARjPXv5yGmEI7G86/0ai9OHcc6jtw=
X-Google-Smtp-Source: APBJJlEHH8ZOccF5pjsnFtYCuJe7vxgLTgSFRHZrKnbtAtrA1sxo211MG48U6hDs88mTSszkEmcO7uHRT4CzLWjRZek=
X-Received: by 2002:a4a:bb86:0:b0:565:bcd8:19db with SMTP id
 h6-20020a4abb86000000b00565bcd819dbmr1618809oop.1.1690386838411; Wed, 26 Jul
 2023 08:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de>
 <CAKfTPtCSsLz+qD-xUnm4N1HyZqtQD+rYVagnSur+hfUHEk0sYg@mail.gmail.com>
 <ad370ab-5694-d6e4-c888-72bdc635824@linutronix.de> <ZL2Z8InSLmI5GU9L@localhost.localdomain>
 <CAJZ5v0ib=j+DHVE1mKCZaoyZ_CHVkA9f90v8b8wSA+3TEG1kHg@mail.gmail.com>
 <8857d035-1c1a-27dd-35cf-7ff68bbf3119@linutronix.de> <CAJZ5v0gJj_xGHcABCDoX2t8aR+9kXr7fvRFF+5KBO5MJz9kFWQ@mail.gmail.com>
 <20230725222851.GC3784071@hirez.programming.kicks-ass.net> <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gyQvPqCN8jPrJqJVNeYXkhmCOnkuNvLgdqQtcS-fgF-g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 17:53:46 +0200
Message-ID: <CAJZ5v0iW=kg4i1Fi_Fny=CaH_YKiGps+6KsBPcgWzS5YOk00VA@mail.gmail.com>
Subject: Re: Stopping the tick on a fully loaded system
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
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

On Wed, Jul 26, 2023 at 5:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 26, 2023 at 12:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 25, 2023 at 04:27:56PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Jul 25, 2023 at 3:07 PM Anna-Maria Behnsen
> >
> > > >                         100% load               50% load                25% load
> > > >                         (top: ~2% idle)         (top: ~49% idle)        (top: ~74% idle;
> > > >                                                                         33 CPUs are completely idle)
> > > >                         ---------------         ----------------        ----------------------------
> > > > Idle Total              1658703 100%            3150522 100%            2377035 100%
> > > > x >= 4ms                2504    0.15%           2       0.00%           53      0.00%
> > > > 4ms> x >= 2ms           390     0.02%           0       0.00%           4563    0.19%
> > > > 2ms > x >= 1ms          62      0.00%           1       0.00%           54      0.00%
> > > > 1ms > x >= 500us        67      0.00%           6       0.00%           2       0.00%
> > > > 500us > x >= 250us      93      0.01%           39      0.00%           11      0.00%
> > > > 250us > x >=100us       280     0.02%           1145    0.04%           633     0.03%
> > > > 100us > x >= 50us       942     0.06%           30722   0.98%           13347   0.56%
> > > > 50us > x >= 25us        26728   1.61%           310932  9.87%           106083  4.46%
> > > > 25us > x >= 10us        825920  49.79%          2320683 73.66%          1722505 72.46%
> > > > 10us > x > 5us          795197  47.94%          442991  14.06%          506008  21.29%
> > > > 5us > x                 6520    0.39%           43994   1.40%           23645   0.99%
> > > >
> > > >
> > > > 99% of the tick stops only have an idle period shorter than 50us (50us is
> > > > 1,25% of a tick length).
> > >
> > > Well, this just means that the governor predicts overly long idle
> > > durations quite often under this workload.
> > >
> > > The governor's decision on whether or not to stop the tick is based on
> > > its idle duration prediction.  If it overshoots, that's how it goes.
> >
> > This is abysmal; IIRC TEO tracks a density function in C state buckets
> > and if it finds it's more likely to be shorter than 'predicted' by the
> > timer it should pick something shallower.
> >
> > Given we have this density function, picking something that's <1% likely
> > is insane. In fact, it seems to suggest the whole pick-alternative thing
> > is utterly broken.
> >
> > > > This is also the reason for my opinion, that the return of
> > > > tick_nohz_next_event() is completely irrelevant in a (fully) loaded case:
> > >
> > > It is an upper bound and in a fully loaded case it may be way off.
> >
> > But given we have our density function, we should be able to do much
> > better.
> >
> >
> > Oooh,... I think I see the problem. Our bins are strictly the available
> > C-state, but if you run this on a Zen3 that has ACPI-idle, then you end
> > up with something that only has 3 C states, like:
> >
> > $ for i in state*/residency ; do echo -n "${i}: "; cat $i; done
> > state0/residency: 0
> > state1/residency: 2
> > state2/residency: 36
> >
> > Which means we only have buckets: (0,0] (0,2000], (2000,36000] or somesuch. All
> > of them very much smaller than TICK_NSEC.
> >
> > That means we don't track nearly enough data to reliably tell anything
> > about disabling the tick or not. We should have at least one bucket
> > beyond TICK_NSEC for this.
>
> Quite likely.

So the reasoning here was that those additional bins would not be
necessary for idle state selection, but the problem of whether or not
to stop the tick is kind of separate from the idle state selection
problem if the target residency values for all of the idle states are
relatively short.  And so it should be addressed separately which
currently it is not.  Admittedly, this is a mistake.
