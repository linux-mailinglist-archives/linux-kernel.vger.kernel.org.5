Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91F758D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjGSGA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjGSGA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:00:57 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232AB1BF5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 23:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689746452; x=1721282452;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Lrm8C4LkSKxSTMxpNCc3TGkjG2hlTDS4b5Oxvf/6LnY=;
  b=VSK0L98oH8LzJDV84j7a+0WtCBU3L6TBK8iJNLVfTd+9Dlkvmp7UjYl+
   unizjyx++ePuxa82zQV1XtKC89/W+Mon11FwXjQkFjesi4TF4oEZ/Qk1Q
   bRsUYCHnYWCm4u9NXVCNf1MiExZSM+pNSguyLfZsN9YZ+CKyVNAJtdsg1
   S5wTBEA9DScXy4+IVUEo9xxYHmmMfOjP3EdPITcjj2BMM8KX6biM+/hZE
   0lxd/X8XGNwaDbntgZAE+Ws+nti5bBL+ZVqd6iuGW0bmoZcr+sel67tzT
   NdX11owCcW8vwL+2NScDIEKZxm+77T9llRhHA95P5ECVC4thGQ7TOc/aT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346682836"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346682836"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 23:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="847940388"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="847940388"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 23:00:43 -0700
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
        <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230714140710.5xbesq6xguhcbyvi@techsingularity.net>
        <87pm4qdhk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230717135017.7ro76lsaninbazvf@techsingularity.net>
        <87lefeca2z.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230718123428.jcy4avtjg3rhuh7i@techsingularity.net>
Date:   Wed, 19 Jul 2023 13:59:00 +0800
In-Reply-To: <20230718123428.jcy4avtjg3rhuh7i@techsingularity.net> (Mel
        Gorman's message of "Tue, 18 Jul 2023 13:34:28 +0100")
Message-ID: <87mszsbfx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Tue, Jul 18, 2023 at 08:55:16AM +0800, Huang, Ying wrote:
>> Mel Gorman <mgorman@techsingularity.net> writes:
>> 
>> > On Mon, Jul 17, 2023 at 05:16:11PM +0800, Huang, Ying wrote:
>> >> Mel Gorman <mgorman@techsingularity.net> writes:
>> >> 
>> >> > Batch should have a much lower maximum than high because it's a deferred cost
>> >> > that gets assigned to an arbitrary task. The worst case is where a process
>> >> > that is a light user of the allocator incurs the full cost of a refill/drain.
>> >> >
>> >> > Again, intuitively this may be PID Control problem for the "Mix" case
>> >> > to estimate the size of high required to minimise drains/allocs as each
>> >> > drain/alloc is potentially a lock contention. The catchall for corner
>> >> > cases would be to decay high from vmstat context based on pcp->expires. The
>> >> > decay would prevent the "high" being pinned at an artifically high value
>> >> > without any zone lock contention for prolonged periods of time and also
>> >> > mitigate worst-case due to state being per-cpu. The downside is that "high"
>> >> > would also oscillate for a continuous steady allocation pattern as the PID
>> >> > control might pick an ideal value suitable for a long period of time with
>> >> > the "decay" disrupting that ideal value.
>> >> 
>> >> Maybe we can track the minimal value of pcp->count.  If it's small
>> >> enough recently, we can avoid to decay pcp->high.  Because the pages in
>> >> PCP are used for allocations instead of idle.
>> >
>> > Implement as a separate patch. I suspect this type of heuristic will be
>> > very benchmark specific and the complexity may not be worth it in the
>> > general case.
>> 
>> OK.
>> 
>> >> Another question is as follows.
>> >> 
>> >> For example, on CPU A, a large number of pages are freed, and we
>> >> maximize batch and high.  So, a large number of pages are put in PCP.
>> >> Then, the possible situations may be,
>> >> 
>> >> a) a large number of pages are allocated on CPU A after some time
>> >> b) a large number of pages are allocated on another CPU B
>> >> 
>> >> For a), we want the pages are kept in PCP of CPU A as long as possible.
>> >> For b), we want the pages are kept in PCP of CPU A as short as possible.
>> >> I think that we need to balance between them.  What is the reasonable
>> >> time to keep pages in PCP without many allocations?
>> >> 
>> >
>> > This would be a case where you're relying on vmstat to drain the PCP after
>> > a period of time as it is a corner case.
>> 
>> Yes.  The remaining question is how long should "a period of time" be?
>
> Match the time used for draining "remote" pages from the PCP lists. The
> choice is arbitrary and no matter what value is chosen, it'll be possible
> to build an adverse workload.

OK.

>> If it's long, the pages in PCP can be used for allocation after some
>> time.  If it's short the pages can be put in buddy, so can be used by
>> other workloads if needed.
>> 
>
> Assume that the main reason to expire pages and put them back on the buddy
> list is to avoid premature allocation failures due to pages pinned on the
> PCP. Once pages are going back onto the buddy list and the expiry is hit,
> it might as well be assumed that the pages are cache-cold. Some bad corner
> cases should be mitigated by disabling the adapative sizing when reclaim is
> active.

Yes.  This can be mitigated, but the page allocation performance may be
hurt.

> The big remaaining corner case to watch out for is where the sum
> of the boosted pcp->high exceeds the low watermark.  If that should ever
> happen then potentially a premature OOM happens because the watermarks
> are fine so no reclaim is active but no pages are available. It may even
> be the case that the sum of pcp->high should not exceed *min* as that
> corner case means that processes may prematurely enter direct reclaim
> (not as bad as OOM but still bad).

Sorry, I don't understand this.  When pages are moved from buddy to PCP,
zone NR_FREE_PAGES will be decreased in rmqueue_bulk().  That is, pages
in PCP will be counted as used instead of free.  And, in
zone_watermark_ok*() and zone_watermark_fast(), zone NR_FREE_PAGES is
used to check watermark.  So, if my understanding were correct, if the
number of pages in PCP is larger than low/min watermark, we can still
trigger reclaim.  Whether is my understanding correct?

>> Anyway, I will do some experiment for that.
>> 
>> > You cannot reasonably detect the pattern on two separate per-cpu lists
>> > without either inspecting remote CPU state or maintaining global
>> > state. Either would incur cache miss penalties that probably cost more
>> > than the heuristic saves.
>> 
>> Yes.  Totally agree.

Best Regards,
Huang, Ying
