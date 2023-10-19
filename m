Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DCD7CEF56
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjJSFvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjJSFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:51:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7232BFE
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697694668; x=1729230668;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xq9jerLUiSqwfAJjYH39aV0c9fonR4RPiGN08HEiBxQ=;
  b=kKp1gd/atYp+0gMqq+ryqKJ4uW3RDcOAzMbS2ycGGD3uXfHuJ76ezHMR
   JvABrP8MlxtI3W9QpLAFnyqahfmaJvihEpcn1t+uMIc5ucoMzIqPpZsRe
   wFSjHzWS2n+J6VD8oCmr3g/bSvLcp4bDo5x5UIjHOfEWhqiOtpZR8VCvp
   UvzTDxw9gtlxZVeMqBoUeYFwOcrA5Cdd7DnGuM3LE5CP1RYxnpJbFb/aJ
   b81yEqvAr2KceJXYY5WU7r8X/CeGHu909hjtQg3MwvvY5lBTcXLzylq+E
   STVgB3HrWQUvE2c73w/+SdjqX5p4w3KBHZLapAZKIk6ZUyJr2OCRPYbeK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417290945"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417290945"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 22:51:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="900623810"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="900623810"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 22:48:59 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] mm: swap: Swap-out small-sized THP without
 splitting
In-Reply-To: <c1c5881c-f00d-4302-a305-fbd6a9998b22@arm.com> (Ryan Roberts's
        message of "Wed, 18 Oct 2023 15:07:55 +0100")
References: <20231017161302.2518826-1-ryan.roberts@arm.com>
        <20231017161302.2518826-3-ryan.roberts@arm.com>
        <87r0ls773p.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <c1c5881c-f00d-4302-a305-fbd6a9998b22@arm.com>
Date:   Thu, 19 Oct 2023 13:49:04 +0800
Message-ID: <87mswfuppr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 18/10/2023 07:55, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>

[snip]

>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index a073366a227c..35cbbe6509a9 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -268,6 +268,12 @@ struct swap_cluster_info {
>>>  struct percpu_cluster {
>>>  	struct swap_cluster_info index; /* Current cluster index */
>>>  	unsigned int next; /* Likely next allocation offset */
>>> +	unsigned int large_next[];	/*
>>> +					 * next free offset within current
>>> +					 * allocation cluster for large folios,
>>> +					 * or UINT_MAX if no current cluster.
>>> +					 * Index is (order - 1).
>>> +					 */
>>>  };
>>>
>>>  struct swap_cluster_list {
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index b83ad77e04c0..625964e53c22 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -987,35 +987,70 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	return n_ret;
>>>  }
>>>
>>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>> +static int swap_alloc_large(struct swap_info_struct *si, swp_entry_t *slot,
>>> +			    unsigned int nr_pages)
>> 
>> This looks hacky.  IMO, we should put the allocation logic inside
>> percpu_cluster framework.  If percpu_cluster framework doesn't work for
>> you, just refactor it firstly.
>
> I'm not sure I really understand what you are suggesting - could you elaborate?
> What "framework"? I only see a per-cpu data structure and
> scan_swap_map_try_ssd_cluster(), which is very much geared towards order-0
> allocations.

I suggest to share as much code as possible between order-0 and order >
0 swap entry allocation.  I think that we can make
scan_swap_map_try_ssd_cluster() works for order > 0 swap entry allocation.

> Are you suggesting you want to allocate large entries (> order-0) from the same
> cluster that is used for small (order-0) entries? The problem with this approach
> is that there may not be enough space left in the current cluster for the large
> entry that you are trying to allocate. Then you would need to take a new cluster
> from the free list and presumably leave the previous cluster with unused entries
> (which will now only be accessible by scanning). That unused space could be
> considerable.
>
> That's why I am currently reserving a "current cluster" per order; that way, all
> allocations are the same order, they are all naturally aligned and there is no
> waste.

I am fine to use one swap cluster per order per CPU.  I just think that
we should share code.

> Perhaps I could implement "stealing" between cpus so that a cpu trying to
> allocate a specific order, but which doesn't have a current cluster for that
> order and the free list is empty, could allocate from another cpu's current
> cluster? I don't think it's a good idea to mix different orders in the same
> cluster though.

I think we can start from a simple solution, that is, just fall back to
split the large folio.  Then, we can optimize it step by step.

> I guess if really low, I could remove a current cluster from a cpu and allow it
> to be scanned for order-0 allocations at least?

Better to have same behavior between order- and order > 0.  Perhaps
begin with the current solution (allow swap entries in per-CPU cluster
to be stolen).  Then we can optimize based on this.

Not directly related to this patchset.  Maybe we can replace
swap_slots_cache with per-CPU cluster in the future.  This will reduce
the code complexity.

> Any opinions gratefully received!

Thanks!

>> 
>>>  {
>>> +	int order_idx;
>>>  	unsigned long idx;
>>>  	struct swap_cluster_info *ci;
>>> +	struct percpu_cluster *cluster;
>>>  	unsigned long offset;
>>>
>>>  	/*
>>>  	 * Should not even be attempting cluster allocations when huge
>>>  	 * page swap is disabled.  Warn and fail the allocation.
>>>  	 */
>>> -	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
>>> +	if (!IS_ENABLED(CONFIG_THP_SWAP) ||
>>> +	    nr_pages < 4 || nr_pages > SWAPFILE_CLUSTER ||
>>> +	    !is_power_of_2(nr_pages)) {
>>>  		VM_WARN_ON_ONCE(1);
>>>  		return 0;
>>>  	}
>>>
>>> -	if (cluster_list_empty(&si->free_clusters))
>>> +	/*
>>> +	 * Not using clusters so unable to allocate large entries.
>>> +	 */
>>> +	if (!si->cluster_info)
>>>  		return 0;
>>>
>>> -	idx = cluster_list_first(&si->free_clusters);
>>> -	offset = idx * SWAPFILE_CLUSTER;
>>> -	ci = lock_cluster(si, offset);
>>> -	alloc_cluster(si, idx);
>>> -	cluster_set_count(ci, SWAPFILE_CLUSTER);
>>> +	order_idx = ilog2(nr_pages) - 2;
>>> +	cluster = this_cpu_ptr(si->percpu_cluster);
>>> +	offset = cluster->large_next[order_idx];
>>> +
>>> +	if (offset == UINT_MAX) {
>>> +		if (cluster_list_empty(&si->free_clusters))
>>> +			return 0;
>>> +
>>> +		idx = cluster_list_first(&si->free_clusters);
>>> +		offset = idx * SWAPFILE_CLUSTER;
>>>
>>> -	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>>> +		ci = lock_cluster(si, offset);
>>> +		alloc_cluster(si, idx);
>>> +		cluster_set_count(ci, SWAPFILE_CLUSTER);
>>> +
>>> +		/*
>>> +		 * If scan_swap_map_slots() can't find a free cluster, it will
>>> +		 * check si->swap_map directly. To make sure this standby
>>> +		 * cluster isn't taken by scan_swap_map_slots(), mark the swap
>>> +		 * entries bad (occupied). (same approach as discard).
>>> +		 */
>>> +		memset(si->swap_map + offset + nr_pages, SWAP_MAP_BAD,
>>> +			SWAPFILE_CLUSTER - nr_pages);
>> 
>> There's an issue with this solution.  If the free space of swap device
>> runs low, it's possible that
>> 
>> - some cluster are put in the percpu_cluster of some CPUs
>>   the swap entries there are marked as used
>> 
>> - no free swap entries elsewhere
>> 
>> - nr_swap_pages isn't 0
>> 
>> So, we will still scan LRU, but swap allocation fails, although there's
>> still free swap space.
>
> Ahh yes, good spot.
>
>> 
>> I think that we should follow the method we used for the original
>> percpu_cluster.  That is, if all free swap entries are in
>> percpu_cluster, we will start to allocate from percpu_cluster.
>
> As i suggested above, I think I could do this by removing a cpu's current
> cluster for a given order from the percpu_cluster and making it generally
> available for scanning. Does that work for you?

replied above.

>> 
>>> +	} else {
>>> +		idx = offset / SWAPFILE_CLUSTER;
>>> +		ci = lock_cluster(si, offset);
>>> +	}
>>> +
>>> +	memset(si->swap_map + offset, SWAP_HAS_CACHE, nr_pages);
>>>  	unlock_cluster(ci);
>>> -	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
>>> +	swap_range_alloc(si, offset, nr_pages);
>>>  	*slot = swp_entry(si->type, offset);
>>>
>>> +	offset += nr_pages;
>>> +	if (idx != offset / SWAPFILE_CLUSTER)
>>> +		offset = UINT_MAX;
>>> +	cluster->large_next[order_idx] = offset;
>>> +
>>>  	return 1;
>>>  }
>>>
>> 
>> [snip]

--
Best Regards,
Huang, Ying
