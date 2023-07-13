Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599D7751C62
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjGMI6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjGMI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:58:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E561B6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689238715; x=1720774715;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=e1gg+ki8Lj41hSt6qxash9SMcqxtMlarpdfmZTvcSI0=;
  b=bL7X6QriytkubQ7qWOuCYgFRSuGRNbjG9SC6VJvl1UeN0n3q7KdS7zp+
   /an+/ypnjieDe0ixWu0u6fvKqBS1Ea4mQDzg5kkk/CPc7Umm4h/7H/ova
   vNomtpMjy54Gl+neTyU5R9MGWVU1CFYPO1eKVM4ptpTtXZ9tX+5nQnw4/
   0HF1zhAlpEXusluuqa37QTvojjTZGRJH+KBfbKtbq+AhCGnBo/mq0XNrj
   2TTnG3utfc0ZKjWqwXKkdoZrv2jDdvp9xTpQMkxZ6ypjJYY7lEM5ZYCNA
   4AXOeg4V17KraoCgLFA/nq41Tj3MFssRclWZuNGf1z5K57QGNOJzGFhZk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="349983483"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="349983483"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 01:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895931771"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="895931771"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 01:58:31 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 2/2] mm: alloc/free depth based PCP high auto-tuning
References: <20230710065325.290366-1-ying.huang@intel.com>
        <20230710065325.290366-3-ying.huang@intel.com>
        <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
        <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
Date:   Thu, 13 Jul 2023 16:56:54 +0800
In-Reply-To: <20230712090526.thk2l7sbdcdsllfi@techsingularity.net> (Mel
        Gorman's message of "Wed, 12 Jul 2023 10:05:26 +0100")
Message-ID: <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Tue, Jul 11, 2023 at 01:19:46PM +0200, Michal Hocko wrote:
>> On Mon 10-07-23 14:53:25, Huang Ying wrote:
>> > To auto-tune PCP high for each CPU automatically, an
>> > allocation/freeing depth based PCP high auto-tuning algorithm is
>> > implemented in this patch.
>> > 
>> > The basic idea behind the algorithm is to detect the repetitive
>> > allocation and freeing pattern with short enough period (about 1
>> > second).  The period needs to be short to respond to allocation and
>> > freeing pattern changes quickly and control the memory wasted by
>> > unnecessary caching.
>> 
>> 1s is an ethernity from the allocation POV. Is a time based sampling
>> really a good choice? I would have expected a natural allocation/freeing
>> feedback mechanism. I.e. double the batch size when the batch is
>> consumed and it requires to be refilled and shrink it under memory
>> pressure (GFP_NOWAIT allocation fails) or when the surplus grows too
>> high over batch (e.g. twice as much).  Have you considered something as
>> simple as that?
>> Quite honestly I am not sure time based approach is a good choice
>> because memory consumptions tends to be quite bulky (e.g. application
>> starts or workload transitions based on requests).
>>  
>
> I tend to agree. Tuning based on the recent allocation pattern without
> frees would make more sense and also be symmetric with how free_factor
> works.

This sounds good to me.  I will give it a try to tune PCP batch.  Have
some questions about how to tune PCP high based on that.  Details are in
the following.

> I suspect that time-based may be heavily orientated around the
> will-it-scale benchmark.

I totally agree that will-it-scale isn't a real workload.  So, I tried
to find some more practical ones.  I found that a repetitive
allocation/freeing several hundreds MB pages pattern exists in kernel
building and netperf/SCTP_STREAM_MANY workloads.  More details can be
found in my reply to Michal as follows,

https://lore.kernel.org/linux-mm/877cr4dydo.fsf@yhuang6-desk2.ccr.corp.intel.com/

> While I only glanced at this, a few things jumped out
>
> 1. Time-based heuristics are not ideal. congestion_wait() and
>    friends was an obvious case where time-based heuristics fell apart even
>    before the event it waited on was removed. For congestion, it happened to
>    work for slow storage for a while but that was about it.  For allocation
>    stream detection, it has a similar problem. If a process is allocating
>    heavily, then fine, if it's in bursts of less than a second more than one
>    second apart then it will not adapt. While I do not think it is explicitly
>    mentioned anywhere, my understanding was that heuristics like this within
>    mm/ should be driven by explicit events as much as possible and not time.

The proposed heuristics can be changed to be not time-based.  When it is
found that the allocation/freeing depth is larger than previous value,
the PCP high can be increased immediately.  We use time-based
implementation to try to reduce the overhead.  And, we mainly targeted
long-time allocation pattern before.

> 2. If time was to be used, it would be cheaper to have the simpliest possible
>    state tracking in the fast paths and decay any resizing of the PCP
>    within the vmstat updates (reuse pcp->expire except it applies to local
>    pcps). Even this is less than ideal as the PCP may be too large for short
>    periods of time but it may also act as a backstop for worst-case behaviour

This sounds reasonable.  Thanks!  We will try this if we choose to use
time-based implementation.

> 3. free_factor is an existing mechanism for detecting recent patterns
>    and adapting the PCP sizes. The allocation side should be symmetric
>    and the events that should drive it are "refills" on the alloc side and
>    "drains" on the free side. Initially it might be easier to have a single
>    parameter that scales batch and high up to a limit

For example, when a workload is started, several GB pages will be
allocated.  We will observe many "refills", and almost no "drains".  So,
we will scales batch and high up to a limit.  When the workload exits,
large number of pages of the workload will be put in PCP because the PCP
high is increased.  When should we decrease the PCP batch and high?

> 4. The amount of state tracked seems excessive and increases the size of
>    the per-cpu structure by more than 1 cache line. That in itself may not
>    be a problem but the state is tracked on every page alloc/free that goes
>    through the fast path and it's relatively complex to track.  That is
>    a constant penalty in fast paths that may not may not be relevant to the
>    workload and only sustained bursty allocation streams may offset the
>    cost.

Yes.  Thanks for pointing this out.  We will optimize this if the other
aspects of the basic idea could be accepted.

> 5. Memory pressure and reclaim activity does not appear to be accounted
>    for and it's not clear if pcp->high is bounded or if it's possible for
>    a single PCP to hide a large number of pages from other CPUs sharing the
>    same node. The max size of the PCP should probably be explicitly clamped.

As in my reply to Michal's email, previously I thought
ZONE_RECLAIM_ACTIVE will be set for kswap reclaiming, and PCP high will
be decreased to (batch * 4) effectively.  Or I miss something?

There's a upper limit for PCP high, which comes from
MIN_PERCPU_PAGELIST_HIGH_FRACTION.  That is, we calculate the PCP high
as if percpu_pagelist_high_fraction is set to
MIN_PERCPU_PAGELIST_HIGH_FRACTION (8).  Then, we use that value as the
upper limit for PCP high.

Best Regards,
Huang, Ying
