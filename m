Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA38801474
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjLAUaA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 15:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:29:59 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B3E10C2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:30:06 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so8842645ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:30:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701462605; x=1702067405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CeYIdWlsv5Nxg9Uu3to5cfBHN6j2D+aqFRVe9wb2aw=;
        b=miuKivTZrniRyiQKNvQmlkwwjd02zW8XU/9cGAHZIiMldh4EEtBRh9eMYD6dyvKi5e
         yK5CSyZSel9rwCd7vItwnzooDWxvZmB0NRJDaA+1kSDNiG4peqd65aKEmzZeBtSs9Sbo
         hdB6MboAOtBOwi0FQYluGrUJ2gR0Iqn1dm6SCRvkt+XSjO3LmhxdIaGhBz4eGyuvArwg
         wJXC7FDovHkBXHnLvzEL1JLXGrVzXyqEoR1YuzHKjciHuWnx+71erkle3jr39uc3mxuB
         72waFje7jNC0BBXM/YV7YdaSRzD+Cd9Qc7WZImmNFVaDRhiZ/Rhdgs9Jb3/sP6CJuWBr
         j5ow==
X-Gm-Message-State: AOJu0YzdRplLZZWAP1mrn/HAlBvKLamuKOr7f9A/2fKYjj4qP+IzjjUj
        ZwsMSZ736DUi3wnAIpk0I/B/tynWBLDNVNzBCeE=
X-Google-Smtp-Source: AGHT+IHtxJSR2jijt8xXZ2w8xbxHOdeqTRsgGnaNKtiYk9KooZvv6OfDnqQ0rAYWd8gmH7T3BUvf8X01j0/6Njbi62Q=
X-Received: by 2002:a17:902:f54d:b0:1d0:6ffd:6e56 with SMTP id
 h13-20020a170902f54d00b001d06ffd6e56mr68122plf.78.1701462605318; Fri, 01 Dec
 2023 12:30:05 -0800 (PST)
MIME-Version: 1.0
References: <20231120221932.213710-1-namhyung@kernel.org> <20231120221932.213710-3-namhyung@kernel.org>
 <66f74af2-21b6-477b-ada1-a8816ee115dc@linux.intel.com> <CAM9d7chDB0nPcu7_Ks4kp2R=+iVNU8SyEFKHVEsd3d0S=mYRnw@mail.gmail.com>
 <25e006f6-43a2-4046-a14e-a856285f5eed@linux.intel.com>
In-Reply-To: <25e006f6-43a2-4046-a14e-a856285f5eed@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 1 Dec 2023 12:29:53 -0800
Message-ID: <CAM9d7cj+6CEH89NSs4Jo+BusU3WG-Cw1w9qK7JFbCHHem+381A@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86: Add CAP_NO_INTERRUPT for uncore PMUs
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 11:26 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2023-11-21 1:30 p.m., Namhyung Kim wrote:
> > Hi Kan,
> >
> > On Tue, Nov 21, 2023 at 7:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 2023-11-20 5:19 p.m., Namhyung Kim wrote:
> >>> It doesn't support sampling in uncore PMU events.  While it's
> >>> technically possible to generate interrupts, let's treat it as if it
> >>> has no interrupt in order to skip the freq adjust/unthrottling logic
> >>> in the timer handler which is only meaningful to sampling events.
> >>>
> >>> Also remove the sampling event check because it'd be done in the general
> >>> code in the perf_event_open syscall.
> >>>
> >>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >>> ---
> >>>  arch/x86/events/intel/uncore.c | 11 ++++++-----
> >>>  1 file changed, 6 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> >>> index 69043e02e8a7..f7e6228bd1b1 100644
> >>> --- a/arch/x86/events/intel/uncore.c
> >>> +++ b/arch/x86/events/intel/uncore.c
> >>> @@ -744,10 +744,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
> >>>       if (pmu->func_id < 0)
> >>>               return -ENOENT;
> >>>
> >>> -     /* Sampling not supported yet */
> >>> -     if (hwc->sample_period)
> >>> -             return -EINVAL;
> >>> -
> >>>       /*
> >>>        * Place all uncore events for a particular physical package
> >>>        * onto a single cpu
> >>> @@ -919,7 +915,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
> >>>                       .stop           = uncore_pmu_event_stop,
> >>>                       .read           = uncore_pmu_event_read,
> >>>                       .module         = THIS_MODULE,
> >>> -                     .capabilities   = PERF_PMU_CAP_NO_EXCLUDE,
> >>> +                     /*
> >>> +                      * It doesn't allow sampling for uncore events, let's
> >>> +                      * treat the PMU has no interrupts to skip them in the
> >>> +                      * perf_adjust_freq_unthr_context().
> >>> +                      */
> >>> +                     .capabilities   = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> >>>                       .attr_update    = pmu->type->attr_update,
> >>>               };
> >>
> >>
> >> There is a special customized uncore PMU which needs the flag as well.
> >
> > Ok, I will add that too.
> >
> > Btw, during the work I noticed many PMU drivers didn't set the
> > CAP_NO_INTERRUPT flag even if they didn't support sampling and
> > rejected the sampling events manually in the ->event_init() callback.
> >
> > I guess it's because the name of the flag is somewhat misleading.
> > As the PMU drivers handle IRQ (for overflows), they thought they had
> > interrupts and didn't set the flag.  I think it'd be better to rename it to
> > CAP_NO_SAMPLING to reveal the intention.  And then we could just set
> > the flag in the pmu.capabilities and remove the manual checks.
> >
> > The benefit is it can skip the PMUs in the timer tick handler even if
> > it needs to unthrottle some events.  What do you think?
> >
>
> I agree. The current name is kind of misleading.
>
> The patch, which introduced the flag (commit id 53b25335dd60 ("perf:
> Disable sampled events if no PMU interrupt")), also tried to disable the
> sampled events on a no-sampling supported platform.
>
> The renaming sounds good to me.

Thank Kan for the review.

Peter and Ingo, would you please pick up the first two patches
if you don't have any concerns?  Then I can work on the
renaming on top.

Thanks,
Namhyung
