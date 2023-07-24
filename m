Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B575E5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGXBLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXBLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:11:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C986C6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690161076; x=1721697076;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=2bkwBVVjsPHIqYj7TayR1Uu4788OLpgRpr080tPdSn0=;
  b=Y8hJE9LfY7FVVeCtpRp/fkQNrYbLcXe8QChqioQC74nKPGXqQoepWtpN
   6I8cnsY3XbXLYkBXpuLTQ/zz/SS6QOFVX++7jT4tHPdBNRtKu47+ZOxe8
   m9MrNE371FKc/+wzoTQll5i3Tv5+QrDtng7UnvGhTL+YwmJgSbpubsdsW
   TXBwuVUvKA9axRA+ucuFqG8Z+17DRjvxuOxZZuV85Wc98L1pJAHcvQrur
   itPrdkrGUStzZA3EeeP5tmm5ArkHA3BA0rkHfF9kr6hckW0D7ZTBE1fEz
   8IujEJ5omNqBML0tmBqtazCDcw4vfLzGK0+p+F4PSwZDmkwTLUMq5OhYZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="433562620"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="433562620"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 18:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719473880"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719473880"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 18:11:12 -0700
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
References: <20230712090526.thk2l7sbdcdsllfi@techsingularity.net>
        <871qhcdwa1.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230714140710.5xbesq6xguhcbyvi@techsingularity.net>
        <87pm4qdhk4.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230717135017.7ro76lsaninbazvf@techsingularity.net>
        <87lefeca2z.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230718123428.jcy4avtjg3rhuh7i@techsingularity.net>
        <87mszsbfx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230719090518.67g7hascnfcly6hk@techsingularity.net>
        <87fs5h7mfo.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230721092119.5nzpru7ttfudqzbg@techsingularity.net>
Date:   Mon, 24 Jul 2023 09:09:31 +0800
In-Reply-To: <20230721092119.5nzpru7ttfudqzbg@techsingularity.net> (Mel
        Gorman's message of "Fri, 21 Jul 2023 10:21:19 +0100")
Message-ID: <87bkg26rp0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Fri, Jul 21, 2023 at 03:28:43PM +0800, Huang, Ying wrote:
>> Mel Gorman <mgorman@techsingularity.net> writes:
>> 
>> > On Wed, Jul 19, 2023 at 01:59:00PM +0800, Huang, Ying wrote:
>> >> > The big remaaining corner case to watch out for is where the sum
>> >> > of the boosted pcp->high exceeds the low watermark.  If that should ever
>> >> > happen then potentially a premature OOM happens because the watermarks
>> >> > are fine so no reclaim is active but no pages are available. It may even
>> >> > be the case that the sum of pcp->high should not exceed *min* as that
>> >> > corner case means that processes may prematurely enter direct reclaim
>> >> > (not as bad as OOM but still bad).
>> >> 
>> >> Sorry, I don't understand this.  When pages are moved from buddy to PCP,
>> >> zone NR_FREE_PAGES will be decreased in rmqueue_bulk().  That is, pages
>> >> in PCP will be counted as used instead of free.  And, in
>> >> zone_watermark_ok*() and zone_watermark_fast(), zone NR_FREE_PAGES is
>> >> used to check watermark.  So, if my understanding were correct, if the
>> >> number of pages in PCP is larger than low/min watermark, we can still
>> >> trigger reclaim.  Whether is my understanding correct?
>> >> 
>> >
>> > You're right, I didn't check the timing of the accounting and all that
>> > occurred to me was "the timing of when watermarks trigger kswapd or
>> > direct reclaim may change as a result of PCP adaptive resizing". Even
>> > though I got the timing wrong, the shape of the problem just changes.
>> > I suspect that excessively large PCP high relative to the watermarks may
>> > mean that reclaim happens prematurely if too many pages are pinned by PCP
>> > pages as the zone free pages approaches the watermark.
>> 
>> Yes.  I think so too.  In addition to reclaim, falling back to remote
>> NUMA node may happen prematurely too.
>> 
>
> Yes, with the added bonus that this is relatively easy to detect from
> the NUMA miss stats. I say "relative" because in a lot of cases, it'll be
> difficult to distinguish from the noise. Hence, it's better to be explicit in
> the change log that the potential problem is known and has been considered.
> That way, if bisect points the finger at adaptive resizing, there will be
> some notes on how to investigate the bug.

Sure.  Will do that.

>> > While disabling the adaptive resizing during reclaim will limit the
>> > worst of the problem, it may still be the case that kswapd is woken
>> > early simply because there are enough CPUs pinning pages in PCP
>> > lists. Similarly, depending on the size of pcp->high and the gap
>> > between the watermarks, it's possible for direct reclaim to happen
>> > prematurely. I could still be wrong because I'm not thinking the
>> > problem through fully, examining the code or thinking about the
>> > implementation. It's simply worth keeping in mind the impact elevated
>> > PCP high values has on the timing of watermarks failing. If it's
>> > complex enough, it may be necessary to have a separate patch dealing
>> > with the impact of elevated pcp->high on watermarks.
>> 
>> Sure.  I will keep this in mind.  We may need to check zone watermark
>> when tuning pcp->high and free some pages from PCP before falling back
>> to other node or reclaiming.
>> 
>
> That would certainly be one option, a cap on adaptive resizing as memory
> gets lower. It's not perfect but ideally the worst-case behaviour would be
> that PCP adaptive sizing returns to existing behaviour when memory usage
> is persistently high and near watermarks within a zone.

--
Best Regards,
Huang, Ying
