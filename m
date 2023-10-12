Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC077C6726
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378083AbjJLHuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347078AbjJLHuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:50:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92512B7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697097016; x=1728633016;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=riwDyZ8poGIaGdAq64J2s2w8eTJ6yuogky3gS+kYshg=;
  b=TrEvG7UsrXJBgIBXJAWsastwfv6sOcHCfQNlZaLk2zMWzYOmuo4rAC0g
   vC8fBUhh7fiz9J2axj6nZWO1zsss9KAM43s/CEKbKeOP4huvkklkIhPDt
   bTt1P34tJasYYkeU9PYJ+r16F2LlJnX2K9YZ8dWbNhq7YtPUN6UNkpije
   /xesJt3HcEWl0KUUydV3VVQTWbOshMQeurVbOoh50ALoZBfgYlmebE/fq
   YfYmPgaQjHaIUrIUaoyFwmYs7ANqTu4ZFbx/N3805X7F6AfTOXRhTAwq5
   Gllhdzt3X+3W8ZJH+JEGyd0S9oa//u5gUw5IORLReg1NAjT3BHj8j5W6F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365132397"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="365132397"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 00:50:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747786032"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="747786032"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 00:50:12 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Christoph Lameter" <cl@linux.com>
Subject: Re: [PATCH 09/10] mm, pcp: avoid to reduce PCP high unnecessarily
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920061856.257597-10-ying.huang@intel.com>
        <20231011140949.rwsqfb57vyuub6va@techsingularity.net>
Date:   Thu, 12 Oct 2023 15:48:04 +0800
In-Reply-To: <20231011140949.rwsqfb57vyuub6va@techsingularity.net> (Mel
        Gorman's message of "Wed, 11 Oct 2023 15:09:49 +0100")
Message-ID: <87lec8ffij.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@techsingularity.net> writes:

> On Wed, Sep 20, 2023 at 02:18:55PM +0800, Huang Ying wrote:
>> In PCP high auto-tuning algorithm, to minimize idle pages in PCP, in
>> periodic vmstat updating kworker (via refresh_cpu_vm_stats()), we will
>> decrease PCP high to try to free possible idle PCP pages.  One issue
>> is that even if the page allocating/freeing depth is larger than
>> maximal PCP high, we may reduce PCP high unnecessarily.
>> 
>> To avoid the above issue, in this patch, we will track the minimal PCP
>> page count.  And, the periodic PCP high decrement will not more than
>> the recent minimal PCP page count.  So, only detected idle pages will
>> be freed.
>> 
>> On a 2-socket Intel server with 224 logical CPU, we tested kbuild on
>> one socket with `make -j 112`.  With the patch, The number of pages
>> allocated from zone (instead of from PCP) decreases 25.8%.
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
>>  mm/page_alloc.c        | 15 ++++++++++-----
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 8a19e2af89df..35b78c7522a7 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -682,6 +682,7 @@ enum zone_watermarks {
>>  struct per_cpu_pages {
>>  	spinlock_t lock;	/* Protects lists field */
>>  	int count;		/* number of pages in the list */
>> +	int count_min;		/* minimal number of pages in the list recently */
>>  	int high;		/* high watermark, emptying needed */
>>  	int high_min;		/* min high watermark */
>>  	int high_max;		/* max high watermark */
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 3f8c7dfeed23..77e9b7b51688 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2166,19 +2166,20 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>>   */
>>  int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
>>  {
>> -	int high_min, to_drain, batch;
>> +	int high_min, decrease, to_drain, batch;
>>  	int todo = 0;
>>  
>>  	high_min = READ_ONCE(pcp->high_min);
>>  	batch = READ_ONCE(pcp->batch);
>>  	/*
>> -	 * Decrease pcp->high periodically to try to free possible
>> -	 * idle PCP pages.  And, avoid to free too many pages to
>> -	 * control latency.
>> +	 * Decrease pcp->high periodically to free idle PCP pages counted
>> +	 * via pcp->count_min.  And, avoid to free too many pages to
>> +	 * control latency.  This caps pcp->high decrement too.
>>  	 */
>>  	if (pcp->high > high_min) {
>> +		decrease = min(pcp->count_min, pcp->high / 5);
>
> Not directly related to this patch but why 20%, it seems a bit
> arbitrary. While this is not an fast path, using a divide rather than a
> shift seems unnecessarily expensive.

Yes.  The number chosen is kind of arbitrary.  Will use ">> 3" (/ 8).

>>  		pcp->high = max3(pcp->count - (batch << PCP_BATCH_SCALE_MAX),
>> -				 pcp->high * 4 / 5, high_min);
>> +				 pcp->high - decrease, high_min);
>>  		if (pcp->high > high_min)
>>  			todo++;
>>  	}
>> @@ -2191,6 +2192,8 @@ int decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
>>  		todo++;
>>  	}
>>  
>> +	pcp->count_min = pcp->count;
>> +
>>  	return todo;
>>  }
>>  
>> @@ -2828,6 +2831,8 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>>  		page = list_first_entry(list, struct page, pcp_list);
>>  		list_del(&page->pcp_list);
>>  		pcp->count -= 1 << order;
>> +		if (pcp->count < pcp->count_min)
>> +			pcp->count_min = pcp->count;
>
> While the accounting for this is in a relatively fast path.
>
> At the moment I don't have a better suggestion but I'm not as keen on
> this patch. It seems like it would have been more appropriate to decay if
> there was no recent allocation activity tracked via pcp->flags.  The major
> caveat there is tracking a bit and clearing it may very well be in a fast
> path unless it was tried to refills but that is subject to timing issues
> and the allocation request stream :(
>
> While you noted the difference in buddy allocations which may tie into
> lock contention issues, how much difference to it make to the actual
> performance of the workload?

Thanks Andrew for his reminding on test results.  I found that I used a
uncommon configuration to test kbuild in V1 of the patchset.  So, I sent
out V2 of the patchset as follows with only test results and document
changed.

https://lore.kernel.org/linux-mm/20230926060911.266511-1-ying.huang@intel.com/

So, for performance data, please refer to V2 of the patchset.  For this
patch, the performance data are,

"
On a 2-socket Intel server with 224 logical CPU, we run 8 kbuild
instances in parallel (each with `make -j 28`) in 8 cgroup.  This
simulates the kbuild server that is used by 0-Day kbuild service.
With the patch, The number of pages allocated from zone (instead of
from PCP) decreases 21.4%.
"

I also showed the performance number for each step of optimization as
follows (copied from the above patchset V2 link).

"
	build time   lock contend%	free_high	alloc_zone
	----------	----------	---------	----------
base	     100.0	      13.5          100.0            100.0
patch1	      99.2	      10.6	     19.2	      95.6
patch3	      99.2	      11.7	      7.1	      95.6
patch5	      98.4	      10.0	      8.2	      97.1
patch7	      94.9	       0.7	      3.0	      19.0
patch9	      94.9	       0.6	      2.7	      15.0  <--	this patch
patch10	      94.9	       0.9	      8.8	      18.6
"

Although I think the patch is helpful via avoiding the unnecessary
pcp->high decaying, thus reducing the zone lock contention.  There's no
visible benchmark score change for the patch.

--
Best Regards,
Huang, Ying
