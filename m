Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB47F2160
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjKTXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjKTXYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:24:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BBBC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:24:03 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b1d1099a84so4739502b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700522643; x=1701127443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6LIFM3DjLDyxu9TJ4ikiMj/7WYNnBo7D6Iup3iI3Lo=;
        b=CWN3Mv00rOzcl4Oy7sjIG0VOuzoNXrM6umjSqhDtLDzmKzQCRnHEzyieTfXCAiwfCO
         RYb6gJtcQGuBbGUo/te+7utGqlF/fm/v9j6hhkoxIKAPB7BxI3Y3g1NxFeAZSods0oIX
         XXDRKsnuKGgonvpcSVqXuG8WeSyEg0e5TcoA4DaNGZmyN+8Htc81uNZ19VXNKtlclS2O
         bEAf7XiiIY1ArXFvqzQb6GNoac6tpdzmfq/N+38ucLEqUVMmlB+82LEI0totmLywSZl3
         vQswGfbf5Q4pUVcA47sG7NuGjl+mo5oA52AcPJPXOSgXl2fPxf4RbheMZM0eqQzS9Zke
         x8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522643; x=1701127443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6LIFM3DjLDyxu9TJ4ikiMj/7WYNnBo7D6Iup3iI3Lo=;
        b=HgClDhJVeTZ4zIT2t7jRHV9il8xp/gJUVSpVKsfztpEaP5pyCDiN8ncoXB/3GojxFF
         l98QKL177x1gP4sswdDBmoD/wjqbUly5l8epTYKCPfO7S++e/RgdLofbNPFCAz3q7Zxp
         duCElUuBNwcodhvlh16OWog7M9q5jYLj/ZkSlM1TWoCHCWOfGLwQO0pFsJ2KyQfeAi39
         pEh4gCpJlwOpox6MMsHWrSeYArnQECg4tbodO+X1d5YY1lw+0EB3F4xA6NMybk/GpbTa
         mgesvbKwtxVC25XewtqZ+zJEG8wjDxfkoihHEl0Ls5RtzvoNFe6GO1VgKEd3ArP07G9r
         pvMA==
X-Gm-Message-State: AOJu0Yzk6zxZuwsDww9IiWgtZs+gKVcjRjnb/G1neB5s8bp4QEGmRKuY
        qxiYHgFCJUZRdSZirNngv/R1Rw==
X-Google-Smtp-Source: AGHT+IEi38LFR7njl3ugxBjCCU6gQl7b53EV7U8LmUW9lq8R3+JHWoZAVZ51KNcLfgq/YRjGmoeExg==
X-Received: by 2002:a05:6a00:1ca9:b0:6cb:a434:b58f with SMTP id y41-20020a056a001ca900b006cba434b58fmr4657793pfw.33.1700522642993;
        Mon, 20 Nov 2023 15:24:02 -0800 (PST)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id fm12-20020a056a002f8c00b006c9c0705b5csm4769179pfb.48.2023.11.20.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:24:02 -0800 (PST)
Date:   Mon, 20 Nov 2023 23:23:59 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
Message-ID: <ZVvqj0pR2ZebBF3L@google.com>
References: <20231120221932.213710-1-namhyung@kernel.org>
 <CAP-5=fWFeqEK4woCj2ngjxMi4B4EZ3y0gLN+qNu4oNfp4wG8xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWFeqEK4woCj2ngjxMi4B4EZ3y0gLN+qNu4oNfp4wG8xA@mail.gmail.com>
X-Spam-Status: No, score=-16.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023, Ian Rogers wrote:
> On Mon, Nov 20, 2023 at 2:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It was unnecessarily disabling and enabling PMUs for each event.  It
> > should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> > at each PMU.  As pmu context has separate active lists for pinned group
> > and flexible group, factor out a new function to do the job.
> >
> > Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> > even if it needs to unthrottle sampling events.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Series:
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 

Can we have "Cc: stable@vger.kernel.org" for the whole series? This
series should have a great performance improvement for all VMs in which
perf sampling events without specifying period.

The key point behind is that disabling/enabling PMU in virtualized
environment is super heavyweight which can reaches up to 50% of the CPU
time, ie., When multiplxing is used in the VM, a vCPU on a pCPU can only
use 50% of the resource, the other half was entirely wasted in host PMU
code doing the enabling/disabling PMU.

Thanks.
-Mingwei

> > ---
> >  include/linux/perf_event.h |  1 +
> >  kernel/events/core.c       | 68 +++++++++++++++++++++++---------------
> >  2 files changed, 43 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 0367d748fae0..3eb17dc89f5e 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -879,6 +879,7 @@ struct perf_event_pmu_context {
> >
> >         unsigned int                    nr_events;
> >         unsigned int                    nr_cgroups;
> > +       unsigned int                    nr_freq;
> >
> >         atomic_t                        refcount; /* event <-> epc */
> >         struct rcu_head                 rcu_head;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 3eb26c2c6e65..53e2ad73102d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -2275,8 +2275,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
> >
> >         if (!is_software_event(event))
> >                 cpc->active_oncpu--;
> > -       if (event->attr.freq && event->attr.sample_freq)
> > +       if (event->attr.freq && event->attr.sample_freq) {
> >                 ctx->nr_freq--;
> > +               epc->nr_freq--;
> > +       }
> >         if (event->attr.exclusive || !cpc->active_oncpu)
> >                 cpc->exclusive = 0;
> >
> > @@ -2531,9 +2533,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
> >
> >         if (!is_software_event(event))
> >                 cpc->active_oncpu++;
> > -       if (event->attr.freq && event->attr.sample_freq)
> > +       if (event->attr.freq && event->attr.sample_freq) {
> >                 ctx->nr_freq++;
> > -
> > +               epc->nr_freq++;
> > +       }
> >         if (event->attr.exclusive)
> >                 cpc->exclusive = 1;
> >
> > @@ -4096,30 +4099,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
> >         }
> >  }
> >
> > -/*
> > - * combine freq adjustment with unthrottling to avoid two passes over the
> > - * events. At the same time, make sure, having freq events does not change
> > - * the rate of unthrottling as that would introduce bias.
> > - */
> > -static void
> > -perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> > +static void perf_adjust_freq_unthr_events(struct list_head *event_list)
> >  {
> >         struct perf_event *event;
> >         struct hw_perf_event *hwc;
> >         u64 now, period = TICK_NSEC;
> >         s64 delta;
> >
> > -       /*
> > -        * only need to iterate over all events iff:
> > -        * - context have events in frequency mode (needs freq adjust)
> > -        * - there are events to unthrottle on this cpu
> > -        */
> > -       if (!(ctx->nr_freq || unthrottle))
> > -               return;
> > -
> > -       raw_spin_lock(&ctx->lock);
> > -
> > -       list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> > +       list_for_each_entry(event, event_list, active_list) {
> >                 if (event->state != PERF_EVENT_STATE_ACTIVE)
> >                         continue;
> >
> > @@ -4127,8 +4114,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> >                 if (!event_filter_match(event))
> >                         continue;
> >
> > -               perf_pmu_disable(event->pmu);
> > -
> >                 hwc = &event->hw;
> >
> >                 if (hwc->interrupts == MAX_INTERRUPTS) {
> > @@ -4138,7 +4123,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> >                 }
> >
> >                 if (!event->attr.freq || !event->attr.sample_freq)
> > -                       goto next;
> > +                       continue;
> >
> >                 /*
> >                  * stop the event and update event->count
> > @@ -4160,8 +4145,39 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> >                         perf_adjust_period(event, period, delta, false);
> >
> >                 event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> > -       next:
> > -               perf_pmu_enable(event->pmu);
> > +       }
> > +}
> > +
> > +/*
> > + * combine freq adjustment with unthrottling to avoid two passes over the
> > + * events. At the same time, make sure, having freq events does not change
> > + * the rate of unthrottling as that would introduce bias.
> > + */
> > +static void
> > +perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> > +{
> > +       struct perf_event_pmu_context *pmu_ctx;
> > +
> > +       /*
> > +        * only need to iterate over all events iff:
> > +        * - context have events in frequency mode (needs freq adjust)
> > +        * - there are events to unthrottle on this cpu
> > +        */
> > +       if (!(ctx->nr_freq || unthrottle))
> > +               return;
> > +
> > +       raw_spin_lock(&ctx->lock);
> > +
> > +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > +               if (!(pmu_ctx->nr_freq || unthrottle))
> > +                       continue;
> > +               if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
> > +                       continue;
> > +
> > +               perf_pmu_disable(pmu_ctx->pmu);
> > +               perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> > +               perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> > +               perf_pmu_enable(pmu_ctx->pmu);
> >         }
> >
> >         raw_spin_unlock(&ctx->lock);
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
