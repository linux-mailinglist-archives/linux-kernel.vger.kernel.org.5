Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46443753C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjGNOHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjGNOHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:07:20 -0400
Received: from outbound-smtp23.blacknight.com (outbound-smtp23.blacknight.com [81.17.249.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916AA2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:07:15 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 9245DBF0A4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:07:13 +0100 (IST)
Received: (qmail 16834 invoked from network); 14 Jul 2023 14:07:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.16.24])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jul 2023 14:07:13 -0000
Date:   Fri, 14 Jul 2023 15:07:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
Message-ID: <20230714140710.5xbesq6xguhcbyvi@techsingularity.net>
References: <20230710065325.290366-1-ying.huang@intel.com>
 <20230710065325.290366-3-ying.huang@intel.com>
 <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
 <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
 <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:56:54PM +0800, Huang, Ying wrote:
> Mel Gorman <mgorman@techsingularity.net> writes:
> 
> > On Tue, Jul 11, 2023 at 01:19:46PM +0200, Michal Hocko wrote:
> >> On Mon 10-07-23 14:53:25, Huang Ying wrote:
> >> > To auto-tune PCP high for each CPU automatically, an
> >> > allocation/freeing depth based PCP high auto-tuning algorithm is
> >> > implemented in this patch.
> >> > 
> >> > The basic idea behind the algorithm is to detect the repetitive
> >> > allocation and freeing pattern with short enough period (about 1
> >> > second).  The period needs to be short to respond to allocation and
> >> > freeing pattern changes quickly and control the memory wasted by
> >> > unnecessary caching.
> >> 
> >> 1s is an ethernity from the allocation POV. Is a time based sampling
> >> really a good choice? I would have expected a natural allocation/freeing
> >> feedback mechanism. I.e. double the batch size when the batch is
> >> consumed and it requires to be refilled and shrink it under memory
> >> pressure (GFP_NOWAIT allocation fails) or when the surplus grows too
> >> high over batch (e.g. twice as much).  Have you considered something as
> >> simple as that?
> >> Quite honestly I am not sure time based approach is a good choice
> >> because memory consumptions tends to be quite bulky (e.g. application
> >> starts or workload transitions based on requests).
> >>  
> >
> > I tend to agree. Tuning based on the recent allocation pattern without
> > frees would make more sense and also be symmetric with how free_factor
> > works.
> 
> This sounds good to me.  I will give it a try to tune PCP batch.  Have
> some questions about how to tune PCP high based on that.  Details are in
> the following.
> 
> > I suspect that time-based may be heavily orientated around the
> > will-it-scale benchmark.
> 
> I totally agree that will-it-scale isn't a real workload.  So, I tried
> to find some more practical ones.  I found that a repetitive
> allocation/freeing several hundreds MB pages pattern exists in kernel
> building and netperf/SCTP_STREAM_MANY workloads.  More details can be
> found in my reply to Michal as follows,
> 
> https://lore.kernel.org/linux-mm/877cr4dydo.fsf@yhuang6-desk2.ccr.corp.intel.com/
> 
> > While I only glanced at this, a few things jumped out
> >
> > 1. Time-based heuristics are not ideal. congestion_wait() and
> >    friends was an obvious case where time-based heuristics fell apart even
> >    before the event it waited on was removed. For congestion, it happened to
> >    work for slow storage for a while but that was about it.  For allocation
> >    stream detection, it has a similar problem. If a process is allocating
> >    heavily, then fine, if it's in bursts of less than a second more than one
> >    second apart then it will not adapt. While I do not think it is explicitly
> >    mentioned anywhere, my understanding was that heuristics like this within
> >    mm/ should be driven by explicit events as much as possible and not time.
> 
> The proposed heuristics can be changed to be not time-based.  When it is
> found that the allocation/freeing depth is larger than previous value,
> the PCP high can be increased immediately.  We use time-based
> implementation to try to reduce the overhead.  And, we mainly targeted
> long-time allocation pattern before.
> 

Time simply has too many corner cases. When it's reset for example, all
state is lost so patterns that are longer than the time window are
unpredictable. It tends to work slightly better than time decays state
rather than resets but it gets very hand-wavey.

> > 2. If time was to be used, it would be cheaper to have the simpliest possible
> >    state tracking in the fast paths and decay any resizing of the PCP
> >    within the vmstat updates (reuse pcp->expire except it applies to local
> >    pcps). Even this is less than ideal as the PCP may be too large for short
> >    periods of time but it may also act as a backstop for worst-case behaviour
> 
> This sounds reasonable.  Thanks!  We will try this if we choose to use
> time-based implementation.
> 
> > 3. free_factor is an existing mechanism for detecting recent patterns
> >    and adapting the PCP sizes. The allocation side should be symmetric
> >    and the events that should drive it are "refills" on the alloc side and
> >    "drains" on the free side. Initially it might be easier to have a single
> >    parameter that scales batch and high up to a limit
> 
> For example, when a workload is started, several GB pages will be
> allocated.  We will observe many "refills", and almost no "drains".  So,
> we will scales batch and high up to a limit.  When the workload exits,
> large number of pages of the workload will be put in PCP because the PCP
> high is increased.  When should we decrease the PCP batch and high?
> 

Honestly, I'm not 100% certain as I haven't spent time with paper to
sketch out the different combinations with "all allocs" at one end, "all
frees" at the other and "ratio of alloc:free" in the middle. Intuitively
I would expect the time to shrink is when there is a mix.

All allocs -- maximise batch and high
All frees  -- maximise batch and high
Mix        -- adjust high to appoximate the minimum value of high such
	      that a drain/refill does not occur or rarely occurs

Batch should have a much lower maximum than high because it's a deferred cost
that gets assigned to an arbitrary task. The worst case is where a process
that is a light user of the allocator incurs the full cost of a refill/drain.

Again, intuitively this may be PID Control problem for the "Mix" case
to estimate the size of high required to minimise drains/allocs as each
drain/alloc is potentially a lock contention. The catchall for corner
cases would be to decay high from vmstat context based on pcp->expires. The
decay would prevent the "high" being pinned at an artifically high value
without any zone lock contention for prolonged periods of time and also
mitigate worst-case due to state being per-cpu. The downside is that "high"
would also oscillate for a continuous steady allocation pattern as the PID
control might pick an ideal value suitable for a long period of time with
the "decay" disrupting that ideal value.

> > 4. The amount of state tracked seems excessive and increases the size of
> >    the per-cpu structure by more than 1 cache line. That in itself may not
> >    be a problem but the state is tracked on every page alloc/free that goes
> >    through the fast path and it's relatively complex to track.  That is
> >    a constant penalty in fast paths that may not may not be relevant to the
> >    workload and only sustained bursty allocation streams may offset the
> >    cost.
> 
> Yes.  Thanks for pointing this out.  We will optimize this if the other
> aspects of the basic idea could be accepted.
> 

I'm not opposed to having an adaptive pcp->high in concept. I think it would
be best to disable adaptive tuning if percpu_pagelist_high_fraction is set
though. I expect that users of that tunable are rare and that if it *is*
used that there is a very good reason for it.

> > 5. Memory pressure and reclaim activity does not appear to be accounted
> >    for and it's not clear if pcp->high is bounded or if it's possible for
> >    a single PCP to hide a large number of pages from other CPUs sharing the
> >    same node. The max size of the PCP should probably be explicitly clamped.
> 
> As in my reply to Michal's email, previously I thought
> ZONE_RECLAIM_ACTIVE will be set for kswap reclaiming, and PCP high will
> be decreased to (batch * 4) effectively.  Or I miss something?
> 

I don't think you did, but it deserves a big comment in the tuning at minimum
and potentially even disabling adaptive tuning entirely if reclaim is active.

-- 
Mel Gorman
SUSE Labs
