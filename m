Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8427F35F9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234647AbjKUSbd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 13:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjKUSbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:31:16 -0500
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D523410C9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:31:11 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5a9bc2ec556so3584828a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:31:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591471; x=1701196271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKcp8GN0HAb+u3SYTXG/ePsA9Uq1e5LSJUzKPNEW5Ew=;
        b=PA9RsV0QfBDPYnF3sNudZRjMcy3WWk43qwcJyzRWeiL/uNthpmP4lbqWzVnrpFoB6A
         q+4C2ykHwRH+6YtmsHV0cQF2FOoXQi6BLL95SDG7jLqJzFSAV/X8m1Osv5/XwMBugfWn
         C3wz6EXMHbXiPj0NaFdRgpgINAPjW8+JnfR+Ja6xiAfnOVBPO5J2tkbHhTHcCwcwGRnI
         hvp+xJKsetOKbercSeL3DO/Py5SOCWI6BcHpSTdlkxq/+9mfLP5wzjukykcD9dHt/7P+
         76cnlDSQ3TZt82pTNr8lnV0e7PWcOXzxoUpmo95jRmpC1wmeEK3qhRvdcuzcxFbaiPu2
         T0Ug==
X-Gm-Message-State: AOJu0Yxn84YYZXpg0jb3SdmtVH0jnItt0+LUEiTWKQm5uCUVD1Fx7xsU
        zU/c1enZv76QYbfQgqePCK9Nb1O318xBIdmytXyahvd/
X-Google-Smtp-Source: AGHT+IHRh1QGQiUes6PZ/e9wgPD7jsoiN0h934RaY7gWobHGVdxIX1icXPwqfiJs8tjIuTKAXfe824YBfJTaaUGDj/c=
X-Received: by 2002:a17:90b:1b4f:b0:280:2652:d45 with SMTP id
 nv15-20020a17090b1b4f00b0028026520d45mr33265pjb.20.1700591471039; Tue, 21 Nov
 2023 10:31:11 -0800 (PST)
MIME-Version: 1.0
References: <20231120221932.213710-1-namhyung@kernel.org> <20231120221932.213710-3-namhyung@kernel.org>
 <66f74af2-21b6-477b-ada1-a8816ee115dc@linux.intel.com>
In-Reply-To: <66f74af2-21b6-477b-ada1-a8816ee115dc@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 21 Nov 2023 10:30:59 -0800
Message-ID: <CAM9d7chDB0nPcu7_Ks4kp2R=+iVNU8SyEFKHVEsd3d0S=mYRnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf/x86: Add CAP_NO_INTERRUPT for uncore PMUs
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Tue, Nov 21, 2023 at 7:59 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 2023-11-20 5:19 p.m., Namhyung Kim wrote:
> > It doesn't support sampling in uncore PMU events.  While it's
> > technically possible to generate interrupts, let's treat it as if it
> > has no interrupt in order to skip the freq adjust/unthrottling logic
> > in the timer handler which is only meaningful to sampling events.
> >
> > Also remove the sampling event check because it'd be done in the general
> > code in the perf_event_open syscall.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  arch/x86/events/intel/uncore.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> > index 69043e02e8a7..f7e6228bd1b1 100644
> > --- a/arch/x86/events/intel/uncore.c
> > +++ b/arch/x86/events/intel/uncore.c
> > @@ -744,10 +744,6 @@ static int uncore_pmu_event_init(struct perf_event *event)
> >       if (pmu->func_id < 0)
> >               return -ENOENT;
> >
> > -     /* Sampling not supported yet */
> > -     if (hwc->sample_period)
> > -             return -EINVAL;
> > -
> >       /*
> >        * Place all uncore events for a particular physical package
> >        * onto a single cpu
> > @@ -919,7 +915,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
> >                       .stop           = uncore_pmu_event_stop,
> >                       .read           = uncore_pmu_event_read,
> >                       .module         = THIS_MODULE,
> > -                     .capabilities   = PERF_PMU_CAP_NO_EXCLUDE,
> > +                     /*
> > +                      * It doesn't allow sampling for uncore events, let's
> > +                      * treat the PMU has no interrupts to skip them in the
> > +                      * perf_adjust_freq_unthr_context().
> > +                      */
> > +                     .capabilities   = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
> >                       .attr_update    = pmu->type->attr_update,
> >               };
>
>
> There is a special customized uncore PMU which needs the flag as well.

Ok, I will add that too.

Btw, during the work I noticed many PMU drivers didn't set the
CAP_NO_INTERRUPT flag even if they didn't support sampling and
rejected the sampling events manually in the ->event_init() callback.

I guess it's because the name of the flag is somewhat misleading.
As the PMU drivers handle IRQ (for overflows), they thought they had
interrupts and didn't set the flag.  I think it'd be better to rename it to
CAP_NO_SAMPLING to reveal the intention.  And then we could just set
the flag in the pmu.capabilities and remove the manual checks.

The benefit is it can skip the PMUs in the timer tick handler even if
it needs to unthrottle some events.  What do you think?

Thanks,
Namhyung

>
> diff --git a/arch/x86/events/intel/uncore_snb.c
> b/arch/x86/events/intel/uncore_snb.c
> index 7fd4334e12a1..46a63e291975 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -1013,7 +1013,7 @@ static struct pmu snb_uncore_imc_pmu = {
>         .start          = uncore_pmu_event_start,
>         .stop           = uncore_pmu_event_stop,
>         .read           = uncore_pmu_event_read,
> -       .capabilities   = PERF_PMU_CAP_NO_EXCLUDE,
> +       .capabilities   = PERF_PMU_CAP_NO_EXCLUDE |
> PERF_PMU_CAP_NO_INTERRUPT,
>  };
>
>  static struct intel_uncore_ops snb_uncore_imc_ops = {
>
>
> Thanks,
> Kan
> >       } else {
