Return-Path: <linux-kernel+bounces-23393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A085482AC37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD3F1F23BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9182E14A8A;
	Thu, 11 Jan 2024 10:41:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6425A14A9C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D56F2F4;
	Thu, 11 Jan 2024 02:42:21 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDD6F3F73F;
	Thu, 11 Jan 2024 02:41:33 -0800 (PST)
Date: Thu, 11 Jan 2024 10:41:27 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH RESEND 1/2] perf/core: Update
 perf_adjust_freq_unthr_context()
Message-ID: <ZZ_F1zohd7W0oVat@FVFF77S0Q05N>
References: <20240109213623.449371-1-namhyung@kernel.org>
 <ZZ6ug3IOeQlmQnsM@FVFF77S0Q05N>
 <CAM9d7cimwXVYpN7Tk3T6OMRAVo843AHHewndXkefn3r5g8549g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cimwXVYpN7Tk3T6OMRAVo843AHHewndXkefn3r5g8549g@mail.gmail.com>

On Wed, Jan 10, 2024 at 10:27:27AM -0800, Namhyung Kim wrote:
> On Wed, Jan 10, 2024 at 6:49 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Jan 09, 2024 at 01:36:22PM -0800, Namhyung Kim wrote:
> > > It was unnecessarily disabling and enabling PMUs for each event.  It
> > > should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
> > > at each PMU.  As pmu context has separate active lists for pinned group
> > > and flexible group, factor out a new function to do the job.
> > >
> > > Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
> > > even if it needs to unthrottle sampling events.
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > > Tested-by: Mingwei Zhang <mizhang@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Hi,
> >
> > I've taken a quick look and I don't think this is quite right for
> > hybrid/big.LITTLE, but I think that should be relatively simple to fix (more on
> > that below).
> 
> Thanks for your review!

No problem!

> > This seems to be a bunch of optimizations; was that based on inspection alone,
> > or have you found a workload where this has a measureable impact?
> 
> It's from a code inspection but I think Mingwei reported some excessive
> MSR accesses for KVM use cases.  Anyway it'd increase the interrupt \
> latency if you have slow (uncore) PMUs and lots of events on those PMUs.

Makes sense; it would be good if we could put smoething in the commit message
mentioning that.

[...]

> > > +static void
> > > +perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
> > > +{
> > > +     struct perf_event_pmu_context *pmu_ctx;
> > > +
> > > +     /*
> > > +      * only need to iterate over all events iff:
> > > +      * - context have events in frequency mode (needs freq adjust)
> > > +      * - there are events to unthrottle on this cpu
> > > +      */
> > > +     if (!(ctx->nr_freq || unthrottle))
> > > +             return;
> > > +
> > > +     raw_spin_lock(&ctx->lock);
> > > +
> > > +     list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
> > > +             if (!(pmu_ctx->nr_freq || unthrottle))
> > > +                     continue;
> > > +             if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
> > > +                     continue;
> > > +
> > > +             perf_pmu_disable(pmu_ctx->pmu);
> > > +             perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> > > +             perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> > > +             perf_pmu_enable(pmu_ctx->pmu);
> > >       }
> >
> > I don't think this is correct for big.LITTLE/hybrid systems.
> >
> > Imagine a system where CPUs 0-1 have pmu_a, CPUs 2-3 have pmu_b, and a task has
> > events for both pmu_a and pmu_b. The perf_event_context for that task will have
> > a perf_event_pmu_context for each PMU in its pmu_ctx_list.
> >
> > Say that task is run on CPU0, and perf_event_task_tick() is called. That will
> > call perf_adjust_freq_unthr_context(), and it will iterate over the
> > pmu_ctx_list. Note that regardless of pmu_ctx->nr_freq, if 'unthottle' is true,
> > we'll go ahead and call the following for all of the pmu contexts in the
> > pmu_ctx_list:
> >
> >         perf_pmu_disable(pmu_ctx->pmu);
> >         perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
> >         perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
> >         perf_pmu_enable(pmu_ctx->pmu);
> >
> > ... and that means we might call that for pmu_b, even though it's not
> > associated with CPU0. That could be fatal depending on what those callbacks do.
> 
> Thanks for pointing that out.  I missed the hybrid cases.
> 
> > The old logic avoided that possibility implicitly, since the events for pmu_b
> > couldn't be active, and so the check at the start of the look would skip all of
> > pmu_b's events:
> >
> >         if (event->state != PERF_EVENT_STATE_ACTIVE)
> >                 continue;
> >
> > We could do similar by keeping track of how many active events each
> > perf_event_pmu_context has, which'd allow us to do something like:
> >
> >         if (pmu_ctx->nr_active == 0)
> >                 continue;
> >
> > How does that sound to you?
> 
> Sounds good.  Maybe we can just test if both active lists are empty.

Good idea, I think that'd be simpler and less fragile.

Thanks,
Mark.

