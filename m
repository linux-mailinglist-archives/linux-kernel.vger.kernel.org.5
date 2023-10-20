Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAED7D06E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346886AbjJTDdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbjJTDdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:33:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE40D49
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697772779; x=1729308779;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ivYGA1CuBsuE1aoMC1/Z4fsSzlHs99Tm+5xLSzUaM0w=;
  b=G/dDSyhIWO27Az/WY2jdWOxpZFCTKdD2lzA0LWFF0pMqhBvj1SMmmxsz
   wxVSwXnIMTds5QN5ntn/2CugMbyzxBejOE8kKkp5b6ZBYfZTT4VSN0H8L
   eThlXGyK3Oh772SI1I+AsMFidia+7BD+JfMrQSpI1bl7NNl5IYwUvNntw
   wg8c3gDWWitS9nOAlVyEGypUTwn1YyDxgQgEgKiYWZox7nS9Ma7qI/hL6
   OR3yh0ChZpYiLVJ6AGAjK5lejmw3peY0ewppIY9T3bmLLoHJzpF2eX0FJ
   xEaiTcEAekzpXUWqREE3TU3+xUouq3jDzwfxzCIDWtUa/0B9v2+Xe+uDV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371493231"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371493231"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:32:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="757307892"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="757307892"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 20:32:55 -0700
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
Subject: Re: [PATCH -V3 8/9] mm, pcp: decrease PCP high if free pages < high
 watermark
In-Reply-To: <20231019123310.pirier6sk6iaqr3n@techsingularity.net> (Mel
        Gorman's message of "Thu, 19 Oct 2023 13:33:10 +0100")
References: <20231016053002.756205-1-ying.huang@intel.com>
        <20231016053002.756205-9-ying.huang@intel.com>
        <20231019123310.pirier6sk6iaqr3n@techsingularity.net>
Date:   Fri, 20 Oct 2023 11:30:53 +0800
Message-ID: <87o7guezrm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Mon, Oct 16, 2023 at 01:30:01PM +0800, Huang Ying wrote:
>> One target of PCP is to minimize pages in PCP if the system free pages
>> is too few.  To reach that target, when page reclaiming is active for
>> the zone (ZONE_RECLAIM_ACTIVE), we will stop increasing PCP high in
>> allocating path, decrease PCP high and free some pages in freeing
>> path.  But this may be too late because the background page reclaiming
>> may introduce latency for some workloads.  So, in this patch, during
>> page allocation we will detect whether the number of free pages of the
>> zone is below high watermark.  If so, we will stop increasing PCP high
>> in allocating path, decrease PCP high and free some pages in freeing
>> path.  With this, we can reduce the possibility of the premature
>> background page reclaiming caused by too large PCP.
>> 
>> The high watermark checking is done in allocating path to reduce the
>> overhead in hotter freeing path.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <jweiner@redhat.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Christoph Lameter <cl@linux.com>
>> ---
>>  include/linux/mmzone.h |  1 +
>>  mm/page_alloc.c        | 33 +++++++++++++++++++++++++++++++--
>>  2 files changed, 32 insertions(+), 2 deletions(-)
>> 
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index ec3f7daedcc7..c88770381aaf 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1018,6 +1018,7 @@ enum zone_flags {
>>  					 * Cleared when kswapd is woken.
>>  					 */
>>  	ZONE_RECLAIM_ACTIVE,		/* kswapd may be scanning the zone. */
>> +	ZONE_BELOW_HIGH,		/* zone is below high watermark. */
>>  };
>>  
>>  static inline unsigned long zone_managed_pages(struct zone *zone)
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 8382ad2cdfd4..253fc7d0498e 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2407,7 +2407,13 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
>>  		return min(batch << 2, pcp->high);
>>  	}
>>  
>> -	if (pcp->count >= high && high_min != high_max) {
>> +	if (high_min == high_max)
>> +		return high;
>> +
>> +	if (test_bit(ZONE_BELOW_HIGH, &zone->flags)) {
>> +		pcp->high = max(high - (batch << pcp->free_factor), high_min);
>> +		high = max(pcp->count, high_min);
>> +	} else if (pcp->count >= high) {
>>  		int need_high = (batch << pcp->free_factor) + batch;
>>  
>>  		/* pcp->high should be large enough to hold batch freed pages */
>> @@ -2457,6 +2463,10 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
>>  	if (pcp->count >= high) {
>>  		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
>>  				   pcp, pindex);
>> +		if (test_bit(ZONE_BELOW_HIGH, &zone->flags) &&
>> +		    zone_watermark_ok(zone, 0, high_wmark_pages(zone),
>> +				      ZONE_MOVABLE, 0))
>> +			clear_bit(ZONE_BELOW_HIGH, &zone->flags);
>>  	}
>>  }
>>  
>
> This is a relatively fast path and freeing pages should not need to check
> watermarks.

Another stuff that mitigate the overhead is that the watermarks checking
only occurs when we free pages from PCP to buddy.  That is, in most
cases, every 63 page freeing.

> While the overhead is mitigated because it applies only when
> the watermark is below high, that is also potentially an unbounded condition
> if a workload is sized precisely enough. Why not clear this bit when kswapd
> is going to sleep after reclaiming enough pages in a zone?

IIUC, if the number of free pages is kept larger than the low watermark,
then kswapd will have no opportunity to be waken up even if the number
of free pages was ever smaller than the high watermark.

> If you agree then a follow-up patch classed as a micro-optimisation is
> sufficient to avoid redoing all the results again. For most of your
> tests, it should be performance-neutral or borderline noise.

--
Best Regards,
Huang, Ying
