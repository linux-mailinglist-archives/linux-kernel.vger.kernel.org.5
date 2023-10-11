Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCB17C4896
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345031AbjJKDpW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Oct 2023 23:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjJKDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:45:19 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D1392;
        Tue, 10 Oct 2023 20:45:15 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3af603da0f0so4410378b6e.3;
        Tue, 10 Oct 2023 20:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696995914; x=1697600714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JAdZNNBnfGnal/iVTBToNqlZEdsGpjsc5d2wsH2u74=;
        b=aPlvSRSBFBXlQIHX27Ch+CN7VMN64eZIbJYfXv3tcAJ7wBWsj2/8Xu3oohWLR6OI3a
         DGmwfsxe2Ck8Q33iUEbCfqIw7K7n+bssUtk9q/jnen30cCvH2q/RqGIKkM+vzd924gA2
         qoMJkAKRF+xilUc5J/RMzznU5pYv7p+J9Zk6yLHMMPXFocosgz55ZFflQoXiabjcgn1h
         9SOuF9GQ2gwEqUsLup7rSYy5VFyNKkynHuyKNXa2iwp+OvOomvYntzfIHqRN7vV/feQW
         XSbGe0VHJAFYsjLGWWLvwvU36Kus7pKrdKr1UZv/+Gy+4mD/IK7+hVDjuiGJURYwdU9R
         Fkng==
X-Gm-Message-State: AOJu0YyOQ3wqOFWAOgH9yIKmrS8tLfF3im1PS8z9K9Cpa+qNBxmLlD6y
        ey3T56JuoBbzKYgJwSQpcjop5cGnKj2TjvW7AQ4=
X-Google-Smtp-Source: AGHT+IFI+U0gLKzah81qdQUkfv9avSrKlmZ/ZvBcWyvNHnzvtxtbd9CIco5hCn8LNdJNlTbqahzEYeOFBCPogezWcEA=
X-Received: by 2002:a05:6358:918c:b0:14e:28f9:53fd with SMTP id
 j12-20020a056358918c00b0014e28f953fdmr18993640rwa.15.1696995914451; Tue, 10
 Oct 2023 20:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231004040844.797044-1-namhyung@kernel.org> <20231004160224.GB6307@noisy.programming.kicks-ass.net>
 <CAM9d7cizC0J85ByuF5fBmc_Bqi=wpNJpiVsw+3F1Avusn2aQog@mail.gmail.com>
 <20231009210425.GC6307@noisy.programming.kicks-ass.net> <CAM9d7cigs9mWuYiE=MYNg-xVhXzDu5FF6GdMGJi=D_zP1zJoCQ@mail.gmail.com>
In-Reply-To: <CAM9d7cigs9mWuYiE=MYNg-xVhXzDu5FF6GdMGJi=D_zP1zJoCQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Oct 2023 20:45:03 -0700
Message-ID: <CAM9d7cjxSd9QJzTs1_s6Nh7c38FZ7_2FGPoCunvnmjX_y-+Dyg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 9:57 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Peter,
>
> On Mon, Oct 9, 2023 at 2:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Oct 04, 2023 at 09:32:24AM -0700, Namhyung Kim wrote:
> >
> > > Yeah, I know.. but I couldn't come up with a better solution.
> >
> > Not been near a compiler, and haven't fully thought it through, but
> > could something like the work work?
>
> Thanks for the patch, I think it'd work.  Let me test it
> and get back to you.

I worked well but contained a typo.  See below.

Which way do you want to process this change?  Do I send it again
with your S-o-b or will you apply it by yourself?  Either is fine, just
let me know.  In case of latter, you can add

Tested-by: Namhyung Kim <namhyung@kernel.org>

> >
> >
> > ---
> >  include/linux/perf_event.h |   1 +
> >  kernel/events/core.c       | 115 +++++++++++++++++++++++----------------------
> >  2 files changed, 61 insertions(+), 55 deletions(-)
> >
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index f31f962a6445..0367d748fae0 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -878,6 +878,7 @@ struct perf_event_pmu_context {
> >         unsigned int                    embedded : 1;
> >
> >         unsigned int                    nr_events;
> > +       unsigned int                    nr_cgroups;
> >
> >         atomic_t                        refcount; /* event <-> epc */
> >         struct rcu_head                 rcu_head;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 708d474c2ede..f3d5d47ecdfc 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -375,6 +375,7 @@ enum event_type_t {
> >         EVENT_TIME = 0x4,
> >         /* see ctx_resched() for details */
> >         EVENT_CPU = 0x8,
> > +       EVENT_CGROUP = 0x10,
> >         EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
> >  };
> >
> > @@ -684,20 +685,26 @@ do {                                                                      \
> >         ___p;                                                           \
> >  })
> >
> > -static void perf_ctx_disable(struct perf_event_context *ctx)
> > +static void perf_ctx_disable(struct perf_event_context *ctx, bool cgroup)
> >  {
> >         struct perf_event_pmu_context *pmu_ctx;
> >
> > -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
> > +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > +               if (cgroup && !pmu_ctx->nr_cgroups)
> > +                       continue;
> >                 perf_pmu_disable(pmu_ctx->pmu);
> > +       }
> >  }
> >
> > -static void perf_ctx_enable(struct perf_event_context *ctx)
> > +static void perf_ctx_enable(struct perf_event_context *ctx. bool cgroup)

s/./,/

Thanks,
Namhyung


> >  {
> >         struct perf_event_pmu_context *pmu_ctx;
> >
> > -       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry)
> > +       list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > +               if (cgroup && !pmu_ctx->nr_cgroups)
> > +                       continue;
> >                 perf_pmu_enable(pmu_ctx->pmu);
> > +       }
> >  }
