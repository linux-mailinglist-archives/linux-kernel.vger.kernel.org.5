Return-Path: <linux-kernel+bounces-101027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4224587A0DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A49B1C20E88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0410AD56;
	Wed, 13 Mar 2024 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5g5vtPu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471539444
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293715; cv=none; b=rUh09+3ssSQX/Kl2atG1C8SLNkBq/gffBOLzBbgyuxm/2B3MSXG+oqZtstb7RHkgHT5lrmGBogdRqy5OnzKomvcCoKPpn5z9DLUzaIzZ4ICwl4gGNfJyRHm+VabPM0hTBHtYp6fI38SNdBUE1wRTupzcOmrOeW1rnWVNUqaAJuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293715; c=relaxed/simple;
	bh=v+k2mCTe5gPlJORYHy+/XyuqHoVq9kDiNOGaR1ptXFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=reT0P5xtnbQvceO2PbTyVlUjvlQfOjO5G0lpKEyUCkmLPEuhjnYN76t0ufcXgSbjtGIK6EGDbsHBoDqlr/5kbJNiZaPq8yH6aldxRqOgW2yJAhgUSpROocVquqJgPKKTZQzVT5U9DzCa/zPStQD5rswMJjNgvnX1PoxK/ZVAvY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5g5vtPu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710293713; x=1741829713;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=v+k2mCTe5gPlJORYHy+/XyuqHoVq9kDiNOGaR1ptXFE=;
  b=n5g5vtPuhvljqaDgUFRiUpKmg8STf8fdbwBBI0gH1nxXywgdkqx4V6N4
   TnZDM4GqrQSAmduQqcaIBJYm2hikKy64FHaCS80qI8roEpD6Y1wfz5vRB
   RoZJXz8YtUVewLqoL/647nS3qNDGB4TuGJPyPr8kZOCwAEX3ErkL6Rw0O
   01llEyyl+kUxFIGjAZeaBP4UgiQZyqigXSR5YIspiS1tSQbJjvk2akt4y
   AIqXY7xsYNEG23xALTixyzGG0WkBAY/IlTtwblLjjOqhF4Omf/lrmkBqW
   dq+r5CyXtzPAeoo+bH24fz0daubVFyAdZ5jEFfAGNTUeHjccU8vCydG45
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4886677"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4886677"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16460473"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 18:35:09 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] mm: swap: Allow storage of all mTHP orders
In-Reply-To: <f3d063d0-42a1-40cd-9b70-732bd600d6a8@arm.com> (Ryan Roberts's
	message of "Tue, 12 Mar 2024 09:40:55 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-5-ryan.roberts@arm.com>
	<87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<f3d063d0-42a1-40cd-9b70-732bd600d6a8@arm.com>
Date: Wed, 13 Mar 2024 09:33:14 +0800
Message-ID: <87v85q3oh1.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 12/03/2024 07:51, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> Multi-size THP enables performance improvements by allocating large,
>>> pte-mapped folios for anonymous memory. However I've observed that on an
>>> arm64 system running a parallel workload (e.g. kernel compilation)
>>> across many cores, under high memory pressure, the speed regresses. This
>>> is due to bottlenecking on the increased number of TLBIs added due to
>>> all the extra folio splitting when the large folios are swapped out.
>>>
>>> Therefore, solve this regression by adding support for swapping out mTHP
>>> without needing to split the folio, just like is already done for
>>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>>> and when the swap backing store is a non-rotating block device. These
>>> are the same constraints as for the existing PMD-sized THP swap-out
>>> support.
>>>
>>> Note that no attempt is made to swap-in (m)THP here - this is still done
>>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>>> prerequisite for swapping-in mTHP.
>>>
>>> The main change here is to improve the swap entry allocator so that it
>>> can allocate any power-of-2 number of contiguous entries between [1, (1
>>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>>> order and allocating sequentially from it until the cluster is full.
>>> This ensures that we don't need to search the map and we get no
>>> fragmentation due to alignment padding for different orders in the
>>> cluster. If there is no current cluster for a given order, we attempt to
>>> allocate a free cluster from the list. If there are no free clusters, we
>>> fail the allocation and the caller can fall back to splitting the folio
>>> and allocates individual entries (as per existing PMD-sized THP
>>> fallback).
>>>
>>> The per-order current clusters are maintained per-cpu using the existing
>>> infrastructure. This is done to avoid interleving pages from different
>>> tasks, which would prevent IO being batched. This is already done for
>>> the order-0 allocations so we follow the same pattern.
>>>
>>> As is done for order-0 per-cpu clusters, the scanner now can steal
>>> order-0 entries from any per-cpu-per-order reserved cluster. This
>>> ensures that when the swap file is getting full, space doesn't get tied
>>> up in the per-cpu reserves.
>>>
>>> This change only modifies swap to be able to accept any order mTHP. It
>>> doesn't change the callers to elide doing the actual split. That will be
>>> done in separate changes.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/swap.h |   8 ++-
>>>  mm/swapfile.c        | 167 +++++++++++++++++++++++++------------------
>>>  2 files changed, 103 insertions(+), 72 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 0cb082bee717..39b5c18ccc6a 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>>>   */
>>>  #define SWAP_NEXT_INVALID	0
>>>  
>>> +#ifdef CONFIG_THP_SWAP
>>> +#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
>>> +#else
>>> +#define SWAP_NR_ORDERS		1
>>> +#endif
>>> +
>>>  /*
>>>   * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>>>   * its own cluster and swapout sequentially. The purpose is to optimize swapout
>>>   * throughput.
>>>   */
>>>  struct percpu_cluster {
>>> -	unsigned int next; /* Likely next allocation offset */
>>> +	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>>>  };
>>>  
>>>  struct swap_cluster_list {
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 3828d81aa6b8..61118a090796 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>  
>>>  /*
>>>   * The cluster corresponding to page_nr will be used. The cluster will be
>>> - * removed from free cluster list and its usage counter will be increased.
>>> + * removed from free cluster list and its usage counter will be increased by
>>> + * count.
>>>   */
>>> -static void inc_cluster_info_page(struct swap_info_struct *p,
>>> -	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>> +static void add_cluster_info_page(struct swap_info_struct *p,
>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr,
>>> +	unsigned long count)
>>>  {
>>>  	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
>>>  
>>> @@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>>>  	if (cluster_is_free(&cluster_info[idx]))
>>>  		alloc_cluster(p, idx);
>>>  
>>> -	VM_BUG_ON(cluster_count(&cluster_info[idx]) >= SWAPFILE_CLUSTER);
>>> +	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
>>>  	cluster_set_count(&cluster_info[idx],
>>> -		cluster_count(&cluster_info[idx]) + 1);
>>> +		cluster_count(&cluster_info[idx]) + count);
>>> +}
>>> +
>>> +/*
>>> + * The cluster corresponding to page_nr will be used. The cluster will be
>>> + * removed from free cluster list and its usage counter will be increased by 1.
>>> + */
>>> +static void inc_cluster_info_page(struct swap_info_struct *p,
>>> +	struct swap_cluster_info *cluster_info, unsigned long page_nr)
>>> +{
>>> +	add_cluster_info_page(p, cluster_info, page_nr, 1);
>>>  }
>>>  
>>>  /*
>>> @@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>>>   */
>>>  static bool
>>>  scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>> -	unsigned long offset)
>>> +	unsigned long offset, int order)
>>>  {
>>>  	struct percpu_cluster *percpu_cluster;
>>>  	bool conflict;
>>> @@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>>  		return false;
>>>  
>>>  	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
>>> -	percpu_cluster->next = SWAP_NEXT_INVALID;
>>> +	percpu_cluster->next[order] = SWAP_NEXT_INVALID;
>>> +	return true;
>>> +}
>>> +
>>> +static inline bool swap_range_empty(char *swap_map, unsigned int start,
>>> +				    unsigned int nr_pages)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	for (i = 0; i < nr_pages; i++) {
>>> +		if (swap_map[start + i])
>>> +			return false;
>>> +	}
>>> +
>>>  	return true;
>>>  }
>>>  
>>>  /*
>>> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>>> - * might involve allocating a new cluster for current CPU too.
>>> + * Try to get a swap entry (or size indicated by order) from current cpu's swap
>> 
>> IMO, it's not necessary to make mTHP a special case other than base
>> page.  So, this can be changed to
>> 
>>  * Try to get swap entries with specified order from current cpu's swap
>
> Sure, will fix in next version.
>
>> 
>>> + * entry pool (a cluster). This might involve allocating a new cluster for
>>> + * current CPU too.
>>>   */
>>>  static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>> -	unsigned long *offset, unsigned long *scan_base)
>>> +	unsigned long *offset, unsigned long *scan_base, int order)
>>>  {
>>> +	unsigned int nr_pages = 1 << order;
>>>  	struct percpu_cluster *cluster;
>>>  	struct swap_cluster_info *ci;
>>>  	unsigned int tmp, max;
>>>  
>>>  new_cluster:
>>>  	cluster = this_cpu_ptr(si->percpu_cluster);
>>> -	tmp = cluster->next;
>>> +	tmp = cluster->next[order];
>>>  	if (tmp == SWAP_NEXT_INVALID) {
>>>  		if (!cluster_list_empty(&si->free_clusters)) {
>>>  			tmp = cluster_next(&si->free_clusters.head) *
>>> @@ -647,26 +674,27 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>  
>>>  	/*
>>>  	 * Other CPUs can use our cluster if they can't find a free cluster,
>>> -	 * check if there is still free entry in the cluster
>>> +	 * check if there is still free entry in the cluster, maintaining
>>> +	 * natural alignment.
>>>  	 */
>>>  	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
>>>  	if (tmp < max) {
>>>  		ci = lock_cluster(si, tmp);
>>>  		while (tmp < max) {
>>> -			if (!si->swap_map[tmp])
>>> +			if (swap_range_empty(si->swap_map, tmp, nr_pages))
>>>  				break;
>>> -			tmp++;
>>> +			tmp += nr_pages;
>>>  		}
>>>  		unlock_cluster(ci);
>>>  	}
>>>  	if (tmp >= max) {
>>> -		cluster->next = SWAP_NEXT_INVALID;
>>> +		cluster->next[order] = SWAP_NEXT_INVALID;
>>>  		goto new_cluster;
>>>  	}
>>>  	*offset = tmp;
>>>  	*scan_base = tmp;
>>> -	tmp += 1;
>>> -	cluster->next = tmp < max ? tmp : SWAP_NEXT_INVALID;
>>> +	tmp += nr_pages;
>>> +	cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
>>>  	return true;
>>>  }
>>>  
>>> @@ -796,13 +824,14 @@ static bool swap_offset_available_and_locked(struct swap_info_struct *si,
>>>  
>>>  static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  			       unsigned char usage, int nr,
>>> -			       swp_entry_t slots[])
>>> +			       swp_entry_t slots[], unsigned int nr_pages)
>> 
>> IMHO, it's better to use order as parameter directly.  We can change the
>> parameter of get_swap_pages() too.
>
> I agree that this will make the interface clearer/self documenting. I'll do it
> in the next version.
>
>> 
>>>  {
>>>  	struct swap_cluster_info *ci;
>>>  	unsigned long offset;
>>>  	unsigned long scan_base;
>>>  	unsigned long last_in_cluster = 0;
>>>  	int latency_ration = LATENCY_LIMIT;
>>> +	int order = ilog2(nr_pages);
>>>  	int n_ret = 0;
>>>  	bool scanned_many = false;
>>>  
>>> @@ -817,6 +846,26 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	 * And we let swap pages go all over an SSD partition.  Hugh
>>>  	 */
>>>  
>>> +	if (nr_pages > 1) {
>>> +		/*
>>> +		 * Should not even be attempting large allocations when huge
>>> +		 * page swap is disabled.  Warn and fail the allocation.
>>> +		 */
>>> +		if (!IS_ENABLED(CONFIG_THP_SWAP) ||
>>> +		    nr_pages > SWAPFILE_CLUSTER ||
>>> +		    !is_power_of_2(nr_pages)) {
>>> +			VM_WARN_ON_ONCE(1);
>>> +			return 0;
>>> +		}
>>> +
>>> +		/*
>>> +		 * Swapfile is not block device or not using clusters so unable
>>> +		 * to allocate large entries.
>>> +		 */
>>> +		if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
>>> +			return 0;
>>> +	}
>>> +
>>>  	si->flags += SWP_SCANNING;
>>>  	/*
>>>  	 * Use percpu scan base for SSD to reduce lock contention on
>>> @@ -831,8 +880,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  
>>>  	/* SSD algorithm */
>>>  	if (si->cluster_info) {
>>> -		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
>>> +		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order)) {
>>> +			if (order > 0)
>>> +				goto no_page;
>>>  			goto scan;
>>> +		}
>>>  	} else if (unlikely(!si->cluster_nr--)) {
>>>  		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
>>>  			si->cluster_nr = SWAPFILE_CLUSTER - 1;
>>> @@ -874,26 +926,30 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  
>>>  checks:
>>>  	if (si->cluster_info) {
>>> -		while (scan_swap_map_ssd_cluster_conflict(si, offset)) {
>>> +		while (scan_swap_map_ssd_cluster_conflict(si, offset, order)) {
>>>  		/* take a break if we already got some slots */
>>>  			if (n_ret)
>>>  				goto done;
>>>  			if (!scan_swap_map_try_ssd_cluster(si, &offset,
>>> -							&scan_base))
>>> +							&scan_base, order)) {
>>> +				if (order > 0)
>>> +					goto no_page;
>>>  				goto scan;
>>> +			}
>>>  		}
>>>  	}
>>>  	if (!(si->flags & SWP_WRITEOK))
>>>  		goto no_page;
>>>  	if (!si->highest_bit)
>>>  		goto no_page;
>>> -	if (offset > si->highest_bit)
>>> +	if (order == 0 && offset > si->highest_bit)
>> 
>> I don't think that we need to check "order == 0" here.  The original
>> condition will always be false for "order != 0".
>
> I spent ages looking at this and couldn't quite convince myself that this is
> definitely safe. Certainly it would be catastrophic if we modified the returned
> offset for a non-order-0 case (the code below assumes order-0 when checking). So
> I decided in the end to be safe and add this condition. Looking again, I agree
> with you. Will fix in next version.
>
>> 
>>>  		scan_base = offset = si->lowest_bit;
>>>  
>>>  	ci = lock_cluster(si, offset);
>>>  	/* reuse swap entry of cache-only swap if not busy. */
>>>  	if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
>>>  		int swap_was_freed;
>>> +		VM_WARN_ON(order > 0);
>> 
>> Instead of add WARN here, I think that it's better to add WARN at the
>> beginning of "scan" label.  We should never scan if "order > 0", it can
>> capture even more abnormal status.
>
> OK, will do.
>
>> 
>>>  		unlock_cluster(ci);
>>>  		spin_unlock(&si->lock);
>>>  		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
>>> @@ -905,17 +961,18 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	}
>>>  
>>>  	if (si->swap_map[offset]) {
>>> +		VM_WARN_ON(order > 0);
>
> And remove this one too? (relying on the one in scan instead)

Yes.  I think so.

>>>  		unlock_cluster(ci);
>>>  		if (!n_ret)
>>>  			goto scan;
>>>  		else
>>>  			goto done;
>>>  	}
>>> -	WRITE_ONCE(si->swap_map[offset], usage);
>>> -	inc_cluster_info_page(si, si->cluster_info, offset);
>>> +	memset(si->swap_map + offset, usage, nr_pages);
>> 
>> Add barrier() here corresponds to original WRITE_ONCE()?
>> unlock_cluster(ci) may be NOP for some swap devices.
>
> Yep, good spot!
>
>> 
>>> +	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>>  	unlock_cluster(ci);
>>>  
>>> -	swap_range_alloc(si, offset, 1);
>>> +	swap_range_alloc(si, offset, nr_pages);
>>>  	slots[n_ret++] = swp_entry(si->type, offset);
>>>  
>>>  	/* got enough slots or reach max slots? */
>> 
>> If "order > 0", "nr" must be 1.  So, we will "goto done" in the
>> following code.
>
> I've deliberately implemented scan_swap_map_slots() so that it allows nr > 1 for
> order > 0. And leave it to the higher layers to decide on policy.
>
>> 
>>         /* got enough slots or reach max slots? */
>>         if ((n_ret == nr) || (offset >= si->highest_bit))
>>            goto done;
>> 
>> We can add VM_WARN_ON() here to capture some abnormal status.
>
> That was actually how I implemented initially. But decided that it doesn't cost
> anything to allow nr > 1 for order > 0, and IMHO makes the function easier to
> understand because we remove this uneccessary constraint.

This sounds reasonable to me.

>> 
>>> @@ -936,8 +993,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  
>>>  	/* try to get more slots in cluster */
>>>  	if (si->cluster_info) {
>>> -		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
>>> +		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order))
>>>  			goto checks;
>>> +		if (order > 0)
>>> +			goto done;
>> 
>> Don't need to add this, if "order > 0", we will never go here.
>
> As per above.
>
>> 
>>>  	} else if (si->cluster_nr && !si->swap_map[++offset]) {
>>>  		/* non-ssd case, still more slots in cluster? */
>>>  		--si->cluster_nr;
>>> @@ -964,7 +1023,8 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	}
>>>  
>>>  done:
>>> -	set_cluster_next(si, offset + 1);
>>> +	if (order == 0)
>>> +		set_cluster_next(si, offset + 1);
>>>  	si->flags -= SWP_SCANNING;
>>>  	return n_ret;
>>>  
>>> @@ -997,38 +1057,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>>  	return n_ret;
>>>  }
>>>  
>>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>>> -{
>>> -	unsigned long idx;
>>> -	struct swap_cluster_info *ci;
>>> -	unsigned long offset;
>>> -
>>> -	/*
>>> -	 * Should not even be attempting cluster allocations when huge
>>> -	 * page swap is disabled.  Warn and fail the allocation.
>>> -	 */
>>> -	if (!IS_ENABLED(CONFIG_THP_SWAP)) {
>>> -		VM_WARN_ON_ONCE(1);
>>> -		return 0;
>>> -	}
>>> -
>>> -	if (cluster_list_empty(&si->free_clusters))
>>> -		return 0;
>>> -
>>> -	idx = cluster_list_first(&si->free_clusters);
>>> -	offset = idx * SWAPFILE_CLUSTER;
>>> -	ci = lock_cluster(si, offset);
>>> -	alloc_cluster(si, idx);
>>> -	cluster_set_count(ci, SWAPFILE_CLUSTER);
>>> -
>>> -	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>>> -	unlock_cluster(ci);
>>> -	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
>>> -	*slot = swp_entry(si->type, offset);
>>> -
>>> -	return 1;
>>> -}
>>> -
>>>  static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>  {
>>>  	unsigned long offset = idx * SWAPFILE_CLUSTER;
>>> @@ -1050,8 +1078,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>>>  	int n_ret = 0;
>>>  	int node;
>>>  
>>> -	/* Only single cluster request supported */
>>> -	WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
>>> +	/* Only single THP request supported */
>>> +	WARN_ON_ONCE(n_goal > 1 && size > 1);
>>>  
>>>  	spin_lock(&swap_avail_lock);
>>>  
>>> @@ -1088,14 +1116,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>>>  			spin_unlock(&si->lock);
>>>  			goto nextsi;
>>>  		}
>>> -		if (size == SWAPFILE_CLUSTER) {
>>> -			if (si->flags & SWP_BLKDEV)
>>> -				n_ret = swap_alloc_cluster(si, swp_entries);
>>> -		} else
>>> -			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
>>> -						    n_goal, swp_entries);
>>> +		n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
>>> +					    n_goal, swp_entries, size);
>>>  		spin_unlock(&si->lock);
>>> -		if (n_ret || size == SWAPFILE_CLUSTER)
>>> +		if (n_ret || size > 1)
>>>  			goto check_out;
>>>  		cond_resched();
>>>  
>>> @@ -1647,7 +1671,7 @@ swp_entry_t get_swap_page_of_type(int type)
>>>  
>>>  	/* This is called for allocating swap entry, not cache */
>>>  	spin_lock(&si->lock);
>>> -	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
>>> +	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 1))
>>>  		atomic_long_dec(&nr_swap_pages);
>>>  	spin_unlock(&si->lock);
>>>  fail:
>>> @@ -3101,7 +3125,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>>  		p->flags |= SWP_SYNCHRONOUS_IO;
>>>  
>>>  	if (p->bdev && bdev_nonrot(p->bdev)) {
>>> -		int cpu;
>>> +		int cpu, i;
>>>  		unsigned long ci, nr_cluster;
>>>  
>>>  		p->flags |= SWP_SOLIDSTATE;
>>> @@ -3139,7 +3163,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>>  			struct percpu_cluster *cluster;
>>>  
>>>  			cluster = per_cpu_ptr(p->percpu_cluster, cpu);
>>> -			cluster->next = SWAP_NEXT_INVALID;
>>> +			for (i = 0; i < SWAP_NR_ORDERS; i++)
>>> +				cluster->next[i] = SWAP_NEXT_INVALID;
>>>  		}
>>>  	} else {
>>>  		atomic_inc(&nr_rotate_swap);
>> 
>> You also need to check whether we should add swap_entry_size() for some
>> functions to optimize for small system.  We may need to add swap_order()
>> too.
>
> I was planning to convert swap_entry_size() to swap_entry_order() as part of
> switching to pass order instead of nr_pages. There is one other site that uses
> swap_entry_size() and needs a size, so was going to just change it to 1 <<
> swap_entry_order(). Does that work for you?

Yes.

> I'll do an audit for places to use swap_entry_order() but quick scan just now
> suggests that the constant should propagate to all the static functions from
> get_swap_pages().
>

--
Best Regards,
Huang, Ying

