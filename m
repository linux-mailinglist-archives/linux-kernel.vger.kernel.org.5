Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D9C75711F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGRA5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGRA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:57:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF0C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689641822; x=1721177822;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=t4bV+J3+25UzS/iEzI9vgtREPrGKJEqdWMMc+J/VAOE=;
  b=UV77BvsmrJhPgBkXx01a9/vf997xp5Vx8td3HpHoF4IR43bsi8JKxhNr
   pZtbPug34oQpP8NgvSjKZb8/aXW1z8wpeIsl7N8ugYWxkmlJuvsO3rIpT
   +cdZ0NYgQ/hH75V7ZPIfgZXu533qPhM6kxQ7Dcp4mFSWclsoXgHvBJKys
   177ykrJVqDqsgRA5vxlkeDQdv6HVv7KENJP/iqln1ukguvXrJXocuW3p0
   iolwcyHLYyJmbjXWnoaT4M0P4qXe9ucfj3WUlEqO+TobWxXKLrviTlT27
   aBTcQmpitbj/CfDkX/l28cdpaCG31yzzp4IpUBYXHqlZ8HQoTUvyjVaUu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="356014317"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="356014317"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 17:57:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="723398639"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="723398639"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 17:56:58 -0700
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
Date:   Tue, 18 Jul 2023 08:55:16 +0800
In-Reply-To: <20230717135017.7ro76lsaninbazvf@techsingularity.net> (Mel
        Gorman's message of "Mon, 17 Jul 2023 14:50:17 +0100")
Message-ID: <87lefeca2z.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Mon, Jul 17, 2023 at 05:16:11PM +0800, Huang, Ying wrote:
>> Mel Gorman <mgorman@techsingularity.net> writes:
>> 
>> > Batch should have a much lower maximum than high because it's a deferred cost
>> > that gets assigned to an arbitrary task. The worst case is where a process
>> > that is a light user of the allocator incurs the full cost of a refill/drain.
>> >
>> > Again, intuitively this may be PID Control problem for the "Mix" case
>> > to estimate the size of high required to minimise drains/allocs as each
>> > drain/alloc is potentially a lock contention. The catchall for corner
>> > cases would be to decay high from vmstat context based on pcp->expires. The
>> > decay would prevent the "high" being pinned at an artifically high value
>> > without any zone lock contention for prolonged periods of time and also
>> > mitigate worst-case due to state being per-cpu. The downside is that "high"
>> > would also oscillate for a continuous steady allocation pattern as the PID
>> > control might pick an ideal value suitable for a long period of time with
>> > the "decay" disrupting that ideal value.
>> 
>> Maybe we can track the minimal value of pcp->count.  If it's small
>> enough recently, we can avoid to decay pcp->high.  Because the pages in
>> PCP are used for allocations instead of idle.
>
> Implement as a separate patch. I suspect this type of heuristic will be
> very benchmark specific and the complexity may not be worth it in the
> general case.

OK.

>> Another question is as follows.
>> 
>> For example, on CPU A, a large number of pages are freed, and we
>> maximize batch and high.  So, a large number of pages are put in PCP.
>> Then, the possible situations may be,
>> 
>> a) a large number of pages are allocated on CPU A after some time
>> b) a large number of pages are allocated on another CPU B
>> 
>> For a), we want the pages are kept in PCP of CPU A as long as possible.
>> For b), we want the pages are kept in PCP of CPU A as short as possible.
>> I think that we need to balance between them.  What is the reasonable
>> time to keep pages in PCP without many allocations?
>> 
>
> This would be a case where you're relying on vmstat to drain the PCP after
> a period of time as it is a corner case.

Yes.  The remaining question is how long should "a period of time" be?
If it's long, the pages in PCP can be used for allocation after some
time.  If it's short the pages can be put in buddy, so can be used by
other workloads if needed.

Anyway, I will do some experiment for that.

> You cannot reasonably detect the pattern on two separate per-cpu lists
> without either inspecting remote CPU state or maintaining global
> state. Either would incur cache miss penalties that probably cost more
> than the heuristic saves.

Yes.  Totally agree.

Best Regards,
Huang, Ying
