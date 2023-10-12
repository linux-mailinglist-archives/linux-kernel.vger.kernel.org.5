Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32FC7C6F67
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378867AbjJLNhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbjJLNhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:37:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E36394
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697117855; x=1728653855;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=2es9QpCjQe0fxU3AdQYO6Eo7Ee3E5kJdWJAssUgAlGU=;
  b=fayMnZ5DUtTyYQ30RNmffvMc1OiTV1dOHBeR/emx2L7dRq37DD3j3ntF
   TqGT0CrsJg+mP6QOj+9s3svOZABGMk1a4vQPzBmBYm6wNVSKaHSvWpc3N
   /s89afhYpUdkzUBdv7KG8yRVUDIVQQX8nXq1DY1aR84k4/gTNCjcX1um0
   efKvgcMg+SshFTRClc3aViLO1l+G2yb1TTcCdmGK9AvPrBsmEWOP5gEFB
   3vux79s7s/VUAoGcyGk0zR2/kWAhK+UeY2nNtj1VLTA2deBJpC2jBR//M
   M0KFFdDGhEwwTgEayJd5FJNJQ1nEuvtTpN3F/atxqaS4gv+GhdDc+x4g+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="415971372"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="415971372"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:37:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845003581"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="845003581"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 06:37:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Christoph Lameter" <cl@linux.com>
Subject: Re: [PATCH 01/10] mm, pcp: avoid to drain PCP when process exit
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-2-ying.huang@intel.com>
        <20231011124610.4punxroovolyvmgr@techsingularity.net>
        <20231011101617.2f814633defaa13e77308d9b@linux-foundation.org>
        <20231012130921.mkcftgq4njnpl3qy@techsingularity.net>
Date:   Thu, 12 Oct 2023 21:35:26 +0800
In-Reply-To: <20231012130921.mkcftgq4njnpl3qy@techsingularity.net> (Mel
        Gorman's message of "Thu, 12 Oct 2023 14:09:21 +0100")
Message-ID: <87mswodkv5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Wed, Oct 11, 2023 at 10:16:17AM -0700, Andrew Morton wrote:
>> On Wed, 11 Oct 2023 13:46:10 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
>> 
>> > > --- a/include/linux/mmzone.h
>> > > +++ b/include/linux/mmzone.h
>> > > @@ -676,12 +676,15 @@ enum zone_watermarks {
>> > >  #define high_wmark_pages(z) (z->_watermark[WMARK_HIGH] + z->watermark_boost)
>> > >  #define wmark_pages(z, i) (z->_watermark[i] + z->watermark_boost)
>> > >  
>> > > +#define	PCPF_PREV_FREE_HIGH_ORDER	0x01
>> > > +
>> > 
>> > The meaning of the flag and its intent should have been documented.
>> 
>> I need to rebase mm-stable for other reasons.  So let's please
>> decide (soon) whether Mel's review comments can be addressed
>> via add-on patches or whether I should drop this version of this
>> series altogether, during that rebase.
>
> The cache slice calculation is the only change I think may deserve a
> respin as it may have a material impact on the performance figures if the
> "size_data" value changes by too much. Huang, what do you think and how
> long do you think it would take to update the performance figures?  As it
> may require multiple tests for each patch in the series, I would also be ok
> with a follow-on patch like "mm: page_alloc: Simply cache size estimation
> for PCP tuning" that documents the limitation of summing the unified caches
> and the impact, if any, on performance. It makes for a messy history *but*
> it would also record the reasons why summing hierarchies is not necessarily
> the best approach which also has value.

I am OK to respin the series.  It will take 3-4 days to update the
performance figures.

> I think patch 9 should be dropped as it has no impact on headline performance
> while adding a relatively tricky heuristic that updates within a fast
> path. Again, I'd like to give Huang a chance to respond and to evaluate
> if it materially impacts patch 10 -- I don't think it does but I didn't
> think very hard about it. Even if patch 9+10 had to be dropped, it would
> not take much from the overall value of the series.

I am OK to drop patch 9 at least for now.  In the future we may revisit
it when we found workloads that benefit more from it.  It's not too hard
to rebase patch 10.

> Comments and documentation alone are not grounds for pulling the series but
> I hope they do get addressed in follow-on patches. I think requiring them
> for accepting the series is unfair even if the only reason is I took too
> long to review.

Never mind, your review are very value!

--
Best Regards,
Huang, Ying
