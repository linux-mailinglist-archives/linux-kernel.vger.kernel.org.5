Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7075BFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGUHak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGUHai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:30:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273610F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 00:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689924637; x=1721460637;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=i/ZKMMFr+QksEJlbZ/iNDpPO/13trm3BPAAGJEwTLq8=;
  b=dF37p8rCVcis3OvINcKOoNu2eNM2lzWYfOIXkom32Sz0bKq8Gep9Of+i
   QJ51aWjjD/3jy0N+t5k1iT0Sks/xDn9GG+c/AZgtm4Sqjw1HkjqiKgSZo
   mvN5VJtK0GY8f0X7D59YtlzVP24QgGiMXglMIOI5M4Du9J3Dm4LF/G3Ce
   o2Z7PAJnMWQHNPEkItTPIwM2Mjev6foCkI4ZPYbvg/JeoUJ3QmFYkSDh9
   13dPx7u9JMxYSUQvdCKk5IpF+yvDsGcQrNmYwMIWvniZ69Ql4dP00FuAU
   Ap4pTMSeb2Umk4bV+rxuz0TZt/E7kMCtnThAbyFFGMX1/OhFJ6PdBlMsq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="366996806"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="366996806"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724765726"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="724765726"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:30:32 -0700
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
References: <20230710065325.290366-3-ying.huang@intel.com>
        <ZK060sMG0GfC5gUS@dhcp22.suse.cz>
        <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
        <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230714140710.5xbesq6xguhcbyvi@techsingularity.net>
        <87pm4qdhk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230717135017.7ro76lsaninbazvf@techsingularity.net>
        <87lefeca2z.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230718123428.jcy4avtjg3rhuh7i@techsingularity.net>
        <87mszsbfx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230719090518.67g7hascnfcly6hk@techsingularity.net>
Date:   Fri, 21 Jul 2023 15:28:43 +0800
In-Reply-To: <20230719090518.67g7hascnfcly6hk@techsingularity.net> (Mel
        Gorman's message of "Wed, 19 Jul 2023 10:05:18 +0100")
Message-ID: <87fs5h7mfo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Wed, Jul 19, 2023 at 01:59:00PM +0800, Huang, Ying wrote:
>> > The big remaaining corner case to watch out for is where the sum
>> > of the boosted pcp->high exceeds the low watermark.  If that should ever
>> > happen then potentially a premature OOM happens because the watermarks
>> > are fine so no reclaim is active but no pages are available. It may even
>> > be the case that the sum of pcp->high should not exceed *min* as that
>> > corner case means that processes may prematurely enter direct reclaim
>> > (not as bad as OOM but still bad).
>> 
>> Sorry, I don't understand this.  When pages are moved from buddy to PCP,
>> zone NR_FREE_PAGES will be decreased in rmqueue_bulk().  That is, pages
>> in PCP will be counted as used instead of free.  And, in
>> zone_watermark_ok*() and zone_watermark_fast(), zone NR_FREE_PAGES is
>> used to check watermark.  So, if my understanding were correct, if the
>> number of pages in PCP is larger than low/min watermark, we can still
>> trigger reclaim.  Whether is my understanding correct?
>> 
>
> You're right, I didn't check the timing of the accounting and all that
> occurred to me was "the timing of when watermarks trigger kswapd or
> direct reclaim may change as a result of PCP adaptive resizing". Even
> though I got the timing wrong, the shape of the problem just changes.
> I suspect that excessively large PCP high relative to the watermarks may
> mean that reclaim happens prematurely if too many pages are pinned by PCP
> pages as the zone free pages approaches the watermark.

Yes.  I think so too.  In addition to reclaim, falling back to remote
NUMA node may happen prematurely too.

> While disabling the adaptive resizing during reclaim will limit the
> worst of the problem, it may still be the case that kswapd is woken
> early simply because there are enough CPUs pinning pages in PCP
> lists. Similarly, depending on the size of pcp->high and the gap
> between the watermarks, it's possible for direct reclaim to happen
> prematurely. I could still be wrong because I'm not thinking the
> problem through fully, examining the code or thinking about the
> implementation. It's simply worth keeping in mind the impact elevated
> PCP high values has on the timing of watermarks failing. If it's
> complex enough, it may be necessary to have a separate patch dealing
> with the impact of elevated pcp->high on watermarks.

Sure.  I will keep this in mind.  We may need to check zone watermark
when tuning pcp->high and free some pages from PCP before falling back
to other node or reclaiming.

--
Best Regards,
Huang, Ying
