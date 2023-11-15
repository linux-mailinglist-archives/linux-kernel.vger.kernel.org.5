Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4E57EC0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjKOKbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjKOKbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:31:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64A109
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 02:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jTrB25zqHJmxKcPSZ4NVPi2QdcQQymDkA2ryGwWdzXk=; b=XG5/pDn6qbSbCKS9i8clrqH1LL
        scQH0R82gbwHNmmRMqdu1ySh0zjVC/fFaF5Rr+L9AiInehj2xHUSWXpLebQOVyV0ONPesgyZTpid5
        N3qJMi5Kd9DUzBM6RtZB8upyRXddqqgVoF1UEHooWZtUthDN20B+JlWlnWjL5SGh9QsFq3zL3unqT
        Q/7yp43NLHVuL3AnXXQNXB8OJ5i4nKnI4scA80BkvkLxJzCHKzODLmCOGfOrtnqm5xSh449Q0bfV9
        wkoYbi4KjWAiq9SXl+KTesQKZ8Fq8lw+vLP4piyitYSlbja66Ummmt7QcPWzM7nBZkpT5rEkYEIPV
        FaeL9P1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3DBB-00DeWB-Hu; Wed, 15 Nov 2023 10:31:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 38D62300427; Wed, 15 Nov 2023 11:31:29 +0100 (CET)
Date:   Wed, 15 Nov 2023 11:31:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com
Subject: Re: [PATCH 11/13] perf: Simplify perf_adjust_freq_unthr_context()
Message-ID: <20231115103129.GC3818@noisy.programming.kicks-ass.net>
References: <20231102150919.719936610@infradead.org>
 <20231102152018.986157891@infradead.org>
 <CAM9d7cjy-T6VsPE1VSgYFWHOhKOA5dmDXwWExvXSeJXeE1Jt1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjy-T6VsPE1VSgYFWHOhKOA5dmDXwWExvXSeJXeE1Jt1Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 06:14:32PM -0700, Namhyung Kim wrote:
> On Thu, Nov 2, 2023 at 8:32 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |   51 +++++++++++++++++++++++----------------------------
> >  1 file changed, 23 insertions(+), 28 deletions(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -4090,7 +4090,7 @@ perf_adjust_freq_unthr_context(struct pe
> >         if (!(ctx->nr_freq || unthrottle))
> >                 return;
> >
> > -       raw_spin_lock(&ctx->lock);
> > +       guard(raw_spinlock)(&ctx->lock);
> >
> >         list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
> >                 if (event->state != PERF_EVENT_STATE_ACTIVE)
> > @@ -4100,7 +4100,7 @@ perf_adjust_freq_unthr_context(struct pe
> >                 if (!event_filter_match(event))
> >                         continue;
> >
> > -               perf_pmu_disable(event->pmu);
> > +               guard(perf_pmu_disable)(event->pmu);
> >
> >                 hwc = &event->hw;
> >
> > @@ -4110,34 +4110,29 @@ perf_adjust_freq_unthr_context(struct pe
> >                         event->pmu->start(event, 0);
> >                 }
> >
> > -               if (!event->attr.freq || !event->attr.sample_freq)
> > -                       goto next;
> > +               if (event->attr.freq && event->attr.sample_freq) {
> 
> Any reason for this change?  I think we can just change the
> 'goto next' to 'continue', no?

Linus initially got confused about the life-time of for-loop scopes, but
yeah, this could be continue just fine.

> Also I think this code needs changes to optimize the access.
> A similar reason for the cgroup switch, it accesses all the
> pmu/events in the context even before checking the sampling
> frequency.  This is bad for uncore PMUs (and KVM too).
> 
> But this is a different issue..

Right, lets do that in another patch. Also, there seems to be a problem
with the cgroup thing :/
