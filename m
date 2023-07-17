Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59552755E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 10:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGQIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 04:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjGQIU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 04:20:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADC2130
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 01:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689582058; x=1721118058;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=EXOX2k9VFsuPowKXuZz03YoTvqXpHZ/inazra+32p+s=;
  b=OGkMIitMlRKlLyb8/V7J2m3jEj5SBzk58JZBbyFI6hGvDEBtZtbsdSzO
   D0gwgAh28rLDlEkbQ13wBh9G/Y81bDouZaYAHbWbMMu908fiqDvfPiouo
   VFf5H2x+L7+JAQnXO0dcWe8hUu/lcgNpTU9x/YuIG5/pgWnt0ycuscwK4
   HKfq49U0ahYayN14QhiqjUL59oogwYqTt574hgR6f1HqEdmhTfTga7jDT
   9OJFHy8eRAbsZqsYHEjRaVQAOgZVzpEQoL+PuvXQn7fZLl6UN8s0Qkif0
   FyCUrmur5E59ThdX2IR3noelp2/Tn4nSRtBzwYrsuDrYrSOdtW5UPTKc3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="364748643"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="364748643"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 01:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="758322066"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="758322066"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 01:20:54 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 1/2] mm: add framework for PCP high auto-tuning
References: <20230710065325.290366-1-ying.huang@intel.com>
        <20230710065325.290366-2-ying.huang@intel.com>
        <ZK035Tl7lrCPk09r@dhcp22.suse.cz>
        <87edldefnt.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZLEOZ7ScEwnNpS0e@dhcp22.suse.cz>
Date:   Mon, 17 Jul 2023 16:19:12 +0800
In-Reply-To: <ZLEOZ7ScEwnNpS0e@dhcp22.suse.cz> (Michal Hocko's message of
        "Fri, 14 Jul 2023 10:59:19 +0200")
Message-ID: <87wmyzc5mn.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Wed 12-07-23 15:45:58, Huang, Ying wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Mon 10-07-23 14:53:24, Huang Ying wrote:
>> >> The page allocation performance requirements of different workloads
>> >> are usually different.  So, we often need to tune PCP (per-CPU
>> >> pageset) high to optimize the workload page allocation performance.
>> >> Now, we have a system wide sysctl knob (percpu_pagelist_high_fraction)
>> >> to tune PCP high by hand.  But, it's hard to find out the best value
>> >> by hand.  And one global configuration may not work best for the
>> >> different workloads that run on the same system.  One solution to
>> >> these issues is to tune PCP high of each CPU automatically.
>> >> 
>> >> This patch adds the framework for PCP high auto-tuning.  With it,
>> >> pcp->high will be changed automatically by tuning algorithm at
>> >> runtime.  Its default value (pcp->high_def) is the original PCP high
>> >> value calculated based on low watermark pages or
>> >> percpu_pagelist_high_fraction sysctl knob.  To avoid putting too many
>> >> pages in PCP, the original limit of percpu_pagelist_high_fraction
>> >> sysctl knob, MIN_PERCPU_PAGELIST_HIGH_FRACTION, is used to calculate
>> >> the max PCP high value (pcp->high_max).
>> >
>> > It would have been very helpful to describe the basic entry points to
>> > the auto-tuning. AFAICS the central place of the tuning is tune_pcp_high
>> > which is called from the freeing path. Why?  Is this really a good place
>> > considering this is a hot path? What about the allocation path? Isn't
>> > that a good spot to watch for the allocation demand? 
>> 
>> Yes.  The main entry point to the auto-tuning is tune_pcp_high().  Which
>> is called from the freeing path because pcp->high is only used by page
>> freeing.  It's possible to call it in allocation path instead.  The
>> drawback is that the pcp->high may be updated a little later in some
>> situations.  For example, if there are many page freeing but no page
>> allocation for quite long time.  But I don't think this is a serious
>> problem.
>
> I consider it a serious flaw in the framework as it cannot cope with the
> transition of the allocation pattern (e.g. increasing the allocation
> pressure).

Sorry, my previous words are misleading.  What I really wanted to say is
that the problem may be just theoretical.  Anyway, I will try to avoid
this problem in the future version.

>> > Also this framework seems to be enabled by default. Is this really
>> > desirable? What about workloads tuning the pcp batch size manually?
>> > Shouldn't they override any auto-tuning?
>> 
>> In the current implementation, the pcp->high will be tuned between
>> original pcp high (default or tuned manually) and the max pcp high (via
>> MIN_PERCPU_PAGELIST_HIGH_FRACTION).  So the high value tuned manually is
>> respected at some degree.
>> 
>> So you think that it's better to disable auto-tuning if PCP high is
>> tuned manually?
>
> Yes, I think this is a much safer option. For two reasons 1) it is less
> surprising to setups which know what they are doing by configuring the
> batching and 2) the auto-tuning needs a way to get disabled in case
> there are pathological patterns in behavior.

OK.

Best Regards,
Huang, Ying
