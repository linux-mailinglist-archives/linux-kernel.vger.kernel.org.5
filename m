Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063BE7F2085
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjKTWlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjKTWln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:41:43 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25EA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:41:39 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507c9305727so331e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700520098; x=1701124898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZbWt5rtNARkknOUMdjBsyhFBJQ0BMvO34++Ya5sVhY=;
        b=S+NpUkky4DS1cth2R+2A72+tnVkBTlePCsheGxHm88iiaceJ1wW9ivarxWkaRCk+D3
         SdlegY4/TTeSY1QSONpPi9ZR55nRxXfXJSbzPCvX3gJvWe0tD+R183eXAt/E7kAzyDc7
         vtuKpUj/b9a2XMo6UBKCkxgKEAfTD2v/TcTJQwM1sSsGH4XycZgl25DLF2PefJ6+ETFR
         9cvV63nj89H2tKldbTMxqmMZl5BIkHydowIFPcyjEF94nxk5vv0lYrEBJfyvHkQsDX/A
         ZMYoF8rs1/re+eT8d+GdDQwsMJmEv86wi8U7qPXi0PfPSfyQKbE4GwmQF4oE6CwKpXXZ
         soZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700520098; x=1701124898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZbWt5rtNARkknOUMdjBsyhFBJQ0BMvO34++Ya5sVhY=;
        b=kNaMLxnFjBI3QfhjRU0xOddyk1bTzNsNtq8hPuLobMqWoU/ObqyPM68O7S7KIamZAE
         MX/RkH0cQ2jkSesKm7YV/IEo2qYao/7wnkokzmASb2kxbfEVnXxxyJu63UWFJ5hZx0Kn
         qaFgKRzRK3/4BpX//mcQgOZvrKi6/fQEyl0K2dwV6vX2kwDuS4ppJoADo9Cs9yNONDXQ
         f0RJqjY1iFbtQkI1OL0bxq67NGSMYfL0xgnELx1n0dUITd7rWN7WX5HU59/iytFGEJZv
         qwQ2kIOiFqLn5tvQehx04BgRPG8/7gSnPtsgADqVrFKduOBJwt3fypiZpcnP5twV3qAH
         8JuA==
X-Gm-Message-State: AOJu0Yw1mb6J+f81c7EaiqJ7EWsF8qKI7G5waoB21Us99lunwVe28ote
        90qF+jiGWUr0Nwtnv3ecN+ESV46NFHn3yrF34IKVXg==
X-Google-Smtp-Source: AGHT+IGztMfoZwIqqkl+g77z2BQDHZc5bkiMsGMPzRf2XHbDBCTACBWLDZMMAYN9OC4Jw9wbV3QC0WUvX05iZ6SyaVE=
X-Received: by 2002:a05:6512:21b:b0:509:48d1:698b with SMTP id
 a27-20020a056512021b00b0050948d1698bmr214104lfo.4.1700520097753; Mon, 20 Nov
 2023 14:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20231120221932.213710-1-namhyung@kernel.org>
In-Reply-To: <20231120221932.213710-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Nov 2023 14:41:26 -0800
Message-ID: <CAP-5=fWFeqEK4woCj2ngjxMi4B4EZ3y0gLN+qNu4oNfp4wG8xA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 2:19=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It was unnecessarily disabling and enabling PMUs for each event.  It
> should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> at each PMU.  As pmu context has separate active lists for pinned group
> and flexible group, factor out a new function to do the job.
>
> Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> even if it needs to unthrottle sampling events.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Series:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 68 +++++++++++++++++++++++---------------
>  2 files changed, 43 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0367d748fae0..3eb17dc89f5e 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -879,6 +879,7 @@ struct perf_event_pmu_context {
>
>         unsigned int                    nr_events;
>         unsigned int                    nr_cgroups;
> +       unsigned int                    nr_freq;
>
>         atomic_t                        refcount; /* event <-> epc */
>         struct rcu_head                 rcu_head;
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 3eb26c2c6e65..53e2ad73102d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2275,8 +2275,10 @@ event_sched_out(struct perf_event *event, struct p=
erf_event_context *ctx)
>
>         if (!is_software_event(event))
>                 cpc->active_oncpu--;
> -       if (event->attr.freq && event->attr.sample_freq)
> +       if (event->attr.freq && event->attr.sample_freq) {
>                 ctx->nr_freq--;
> +               epc->nr_freq--;
> +       }
>         if (event->attr.exclusive || !cpc->active_oncpu)
>                 cpc->exclusive =3D 0;
>
> @@ -2531,9 +2533,10 @@ event_sched_in(struct perf_event *event, struct pe=
rf_event_context *ctx)
>
>         if (!is_software_event(event))
>                 cpc->active_oncpu++;
> -       if (event->attr.freq && event->attr.sample_freq)
> +       if (event->attr.freq && event->attr.sample_freq) {
>                 ctx->nr_freq++;
> -
> +               epc->nr_freq++;
> +       }
>         if (event->attr.exclusive)
>                 cpc->exclusive =3D 1;
>
> @@ -4096,30 +4099,14 @@ static void perf_adjust_period(struct perf_event =
*event, u64 nsec, u64 count, bo
>         }
>  }
>
> -/*
> - * combine freq adjustment with unthrottling to avoid two passes over th=
e
> - * events. At the same time, make sure, having freq events does not chan=
ge
> - * the rate of unthrottling as that would introduce bias.
> - */
> -static void
> -perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unth=
rottle)
> +static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  {
>         struct perf_event *event;
>         struct hw_perf_event *hwc;
>         u64 now, period =3D TICK_NSEC;
>         s64 delta;
>
> -       /*
> -        * only need to iterate over all events iff:
> -        * - context have events in frequency mode (needs freq adjust)
> -        * - there are events to unthrottle on this cpu
> -        */
> -       if (!(ctx->nr_freq || unthrottle))
> -               return;
> -
> -       raw_spin_lock(&ctx->lock);
> -
> -       list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> +       list_for_each_entry(event, event_list, active_list) {
>                 if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
>                         continue;
>
> @@ -4127,8 +4114,6 @@ perf_adjust_freq_unthr_context(struct perf_event_co=
ntext *ctx, bool unthrottle)
>                 if (!event_filter_match(event))
>                         continue;
>
> -               perf_pmu_disable(event->pmu);
> -
>                 hwc =3D &event->hw;
>
>                 if (hwc->interrupts =3D=3D MAX_INTERRUPTS) {
> @@ -4138,7 +4123,7 @@ perf_adjust_freq_unthr_context(struct perf_event_co=
ntext *ctx, bool unthrottle)
>                 }
>
>                 if (!event->attr.freq || !event->attr.sample_freq)
> -                       goto next;
> +                       continue;
>
>                 /*
>                  * stop the event and update event->count
> @@ -4160,8 +4145,39 @@ perf_adjust_freq_unthr_context(struct perf_event_c=
ontext *ctx, bool unthrottle)
>                         perf_adjust_period(event, period, delta, false);
>
>                 event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
> -       next:
> -               perf_pmu_enable(event->pmu);
> +       }
> +}
> +
> +/*
> + * combine freq adjustment with unthrottling to avoid two passes over th=
e
> + * events. At the same time, make sure, having freq events does not chan=
ge
> + * the rate of unthrottling as that would introduce bias.
> + */
> +static void
> +perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unth=
rottle)
> +{
> +       struct perf_event_pmu_context *pmu_ctx;
> +
> +       /*
> +        * only need to iterate over all events iff:
> +        * - context have events in frequency mode (needs freq adjust)
> +        * - there are events to unthrottle on this cpu
> +        */
> +       if (!(ctx->nr_freq || unthrottle))
> +               return;
> +
> +       raw_spin_lock(&ctx->lock);
> +
> +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> +               if (!(pmu_ctx->nr_freq || unthrottle))
> +                       continue;
> +               if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUP=
T)
> +                       continue;
> +
> +               perf_pmu_disable(pmu_ctx->pmu);
> +               perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> +               perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> +               perf_pmu_enable(pmu_ctx->pmu);
>         }
>
>         raw_spin_unlock(&ctx->lock);
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
