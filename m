Return-Path: <linux-kernel+bounces-134185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3922589AEC2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA33282F36
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 06:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0406FC3;
	Sun,  7 Apr 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="buK6wkFn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8687917FF
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712469855; cv=none; b=Xn7zcGylacHcmmVxQZJrUUNY8aCnETKmJADFMoFGql+csqlE+WxQjx2s1U6cahKUymV8pnmJlFEh6q0JFHN3g2dRQH+5kyW077Bnz0iDcAvrN49MzeuBEohK33AnYU7U9bZjykWdN37DCpWZsNbFWEOi8T5wSVorgMBWH57NEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712469855; c=relaxed/simple;
	bh=9ASREbF5V+W5V2iTmngHkcY+rf4Cr1ccazmdC+nE9Pc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XsbAXrgcyUFLeuoL1G0KcxRJYrtwyCL+D5dcV2ERehE6h5oOUciuDl/Z3SwNvKO9yfPtktsYMJ1VRoL6DMX21nXHT+3CzmHj7SCDIGnPA1Dtd5QNgfg33ExvlWKcDUZph/WkPw6xb/uXtvLeHsHRIC3LG+ylegQ84M8I9VlUbK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=buK6wkFn; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712469853; x=1744005853;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=9ASREbF5V+W5V2iTmngHkcY+rf4Cr1ccazmdC+nE9Pc=;
  b=buK6wkFnrJHJXhhXVMbguHyl9IB7s/bf98Q6h4Yst2kTaz7IkWvTeIFy
   wTsnSuykLoqnuv7g4U286MIZom7KM9XXhg7UHa6sS547Mt4GZoI1BB5Ev
   tXhGybKPO9DXepyw+fQ5NR3QdRup3f8YIrNytR2Hflu+l2oNSJathWylK
   IzgfmZLv0liZ0Je3Brf6XmID6McysjYq2/MZioHWUZ8W09ONFfhq2tElz
   jonIOjFlhoT8kgEeyjKQ9TG3xomNvhO781O88s9cFbAn+nHW9MHWzZbgP
   OtHWQKMLixw55rZhxvBfWGMRcJlpreMMv9rnPu3usU2yLULDAdf7oc3Tf
   Q==;
X-CSE-ConnectionGUID: Ky3gTTOeSLyFX6FYe8UsrA==
X-CSE-MsgGUID: t6w9zYVHTfWSOcMACKrlow==
X-IronPort-AV: E=McAfee;i="6600,9927,11036"; a="7944394"
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="7944394"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:04:12 -0700
X-CSE-ConnectionGUID: enoCzR67Q7GqsPFXl1aIDg==
X-CSE-MsgGUID: /eEN4FILTLOXj5Wgffu5wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,184,1708416000"; 
   d="scan'208";a="19611610"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2024 23:04:09 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Gao
 Xiang <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Lance Yang <ioworker0@gmail.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] mm: swap: Allow storage of all mTHP orders
In-Reply-To: <c7748c77-b2a3-4b06-aaeb-02793a160aaf@redhat.com> (David
	Hildenbrand's message of "Fri, 5 Apr 2024 12:38:10 +0200")
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
	<20240403114032.1162100-5-ryan.roberts@arm.com>
	<c7748c77-b2a3-4b06-aaeb-02793a160aaf@redhat.com>
Date: Sun, 07 Apr 2024 14:02:16 +0800
Message-ID: <87edbhaexj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 03.04.24 13:40, Ryan Roberts wrote:
>> Multi-size THP enables performance improvements by allocating large,
>> pte-mapped folios for anonymous memory. However I've observed that on an
>> arm64 system running a parallel workload (e.g. kernel compilation)
>> across many cores, under high memory pressure, the speed regresses. This
>> is due to bottlenecking on the increased number of TLBIs added due to
>> all the extra folio splitting when the large folios are swapped out.
>> Therefore, solve this regression by adding support for swapping out
>> mTHP
>> without needing to split the folio, just like is already done for
>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>> and when the swap backing store is a non-rotating block device. These
>> are the same constraints as for the existing PMD-sized THP swap-out
>> support.
>> Note that no attempt is made to swap-in (m)THP here - this is still
>> done
>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>> prerequisite for swapping-in mTHP.
>> The main change here is to improve the swap entry allocator so that
>> it
>> can allocate any power-of-2 number of contiguous entries between [1, (1
>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>> order and allocating sequentially from it until the cluster is full.
>> This ensures that we don't need to search the map and we get no
>> fragmentation due to alignment padding for different orders in the
>> cluster. If there is no current cluster for a given order, we attempt to
>> allocate a free cluster from the list. If there are no free clusters, we
>> fail the allocation and the caller can fall back to splitting the folio
>> and allocates individual entries (as per existing PMD-sized THP
>> fallback).
>> The per-order current clusters are maintained per-cpu using the
>> existing
>> infrastructure. This is done to avoid interleving pages from different
>> tasks, which would prevent IO being batched. This is already done for
>> the order-0 allocations so we follow the same pattern.
>> As is done for order-0 per-cpu clusters, the scanner now can steal
>> order-0 entries from any per-cpu-per-order reserved cluster. This
>> ensures that when the swap file is getting full, space doesn't get tied
>> up in the per-cpu reserves.
>> This change only modifies swap to be able to accept any order
>> mTHP. It
>> doesn't change the callers to elide doing the actual split. That will be
>> done in separate changes.
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   include/linux/swap.h |  10 ++-
>>   mm/swap_slots.c      |   6 +-
>>   mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>>   3 files changed, 109 insertions(+), 82 deletions(-)
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 5e1e4f5bf0cb..11c53692f65f 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>>    */
>>   #define SWAP_NEXT_INVALID	0
>>   +#ifdef CONFIG_THP_SWAP
>> +#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
>> +#else
>> +#define SWAP_NR_ORDERS		1
>> +#endif
>> +
>>   /*
>>    * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>>    * its own cluster and swapout sequentially. The purpose is to optimize swapout
>>    * throughput.
>>    */
>>   struct percpu_cluster {
>> -	unsigned int next; /* Likely next allocation offset */
>> +	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>>   };
>>     struct swap_cluster_list {
>> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>>   bool folio_free_swap(struct folio *folio);
>>   void put_swap_folio(struct folio *folio, swp_entry_t entry);
>>   extern swp_entry_t get_swap_page_of_type(int);
>> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
>> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>>   extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>   extern void swap_shmem_alloc(swp_entry_t);
>>   extern int swap_duplicate(swp_entry_t);
>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
>> index 53abeaf1371d..13ab3b771409 100644
>> --- a/mm/swap_slots.c
>> +++ b/mm/swap_slots.c
>> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>>   	cache->cur = 0;
>>   	if (swap_slot_cache_active)
>>   		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
>> -					   cache->slots, 1);
>> +					   cache->slots, 0);
>>     	return cache->nr;
>>   }
>> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>     	if (folio_test_large(folio)) {
>>   		if (IS_ENABLED(CONFIG_THP_SWAP))
>> -			get_swap_pages(1, &entry, folio_nr_pages(folio));
>> +			get_swap_pages(1, &entry, folio_order(folio));
>
> The only comment I have is that this nr_pages -> order conversion adds
> a bit of noise to this patch.
>
> AFAIKS, it's primarily only required for "cluster->next[order]",
> everything else doesn't really require the order.
>
> I'd just have split that out into a separate patch, or simply
> converted nr_pages -> order where required.
>
> Nothing jumped at me, but I'm not an expert on that code, so I'm
> mostly trusting the others ;)

The nr_pages -> order conversion replaces ilog2(nr_pages) with
(1<<order).  IIUC, "<<" is a little faster than "ilog2()".  And, we
don't need to worry about whether nr_pages is a power of 2.  Do you
think that this makes sense?

--
Best Regards,
Huang, Ying

