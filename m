Return-Path: <linux-kernel+bounces-135143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F9D89BBA9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A7D2812B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FADB47F48;
	Mon,  8 Apr 2024 09:28:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5128F44C94
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712568523; cv=none; b=GrFpwcbWDdA1MdHFLgKDn9adA4WDNSLvLScV/EJZN1dVdMRyDWcYjfNeaU1V+5gKK/Bq2qEUC8gJ+TjQ+rmyoJLJh6TpdPxvBokI6RBp4mwXHbDGEIj2S9pMgDlCs5MG9pfIC801v/TnuQTAXem8axo1mNHI40d9RH+AVDwbMSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712568523; c=relaxed/simple;
	bh=ZuQofrmaTymzMdDH1cmaefoZi/AkIQ6KtWS6l8YxNqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpYiZifQTH/2yL9JnMcCpCsWku3ZWXXE2CX7IYxMxkTkXGg19ra3LalBUej5s+SC8AkVEgiS1Ljk4DvClHlmqNaGctBpDqnMyBYSZY7pqf06qOd4xJF9qHA1Y1zFjvdK4kIC1uuz+ZkLceR4Hssfwb32hLTPycOp5fAPj75HXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11A9F1007;
	Mon,  8 Apr 2024 02:29:10 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2F53F766;
	Mon,  8 Apr 2024 02:28:37 -0700 (PDT)
Message-ID: <a574c43f-cc1a-4aad-bd09-e75616c2ed66@arm.com>
Date: Mon, 8 Apr 2024 10:28:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-5-ryan.roberts@arm.com>
 <CAGsJ_4zuTMbVNPE4ZHisi35+T1ftV4+YCbt_eJGNXnrBQ-c4OQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zuTMbVNPE4ZHisi35+T1ftV4+YCbt_eJGNXnrBQ-c4OQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/04/2024 08:38, Barry Song wrote:
> On Thu, Apr 4, 2024 at 12:40 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Multi-size THP enables performance improvements by allocating large,
>> pte-mapped folios for anonymous memory. However I've observed that on an
>> arm64 system running a parallel workload (e.g. kernel compilation)
>> across many cores, under high memory pressure, the speed regresses. This
>> is due to bottlenecking on the increased number of TLBIs added due to
>> all the extra folio splitting when the large folios are swapped out.
>>
>> Therefore, solve this regression by adding support for swapping out mTHP
>> without needing to split the folio, just like is already done for
>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>> and when the swap backing store is a non-rotating block device. These
>> are the same constraints as for the existing PMD-sized THP swap-out
>> support.
>>
>> Note that no attempt is made to swap-in (m)THP here - this is still done
>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>> prerequisite for swapping-in mTHP.
>>
>> The main change here is to improve the swap entry allocator so that it
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
>>
>> The per-order current clusters are maintained per-cpu using the existing
>> infrastructure. This is done to avoid interleving pages from different
>> tasks, which would prevent IO being batched. This is already done for
>> the order-0 allocations so we follow the same pattern.
>>
>> As is done for order-0 per-cpu clusters, the scanner now can steal
>> order-0 entries from any per-cpu-per-order reserved cluster. This
>> ensures that when the swap file is getting full, space doesn't get tied
>> up in the per-cpu reserves.
>>
>> This change only modifies swap to be able to accept any order mTHP. It
>> doesn't change the callers to elide doing the actual split. That will be
>> done in separate changes.
> 
> An idea suddenly struck me: we might not need to split the folio into
> order 0. Instead,
> if we attempt to obtain swap entries at a certain order but fail, we
> could try at half the
> order. If successful, we could utilize Zi Yan's approach to split the
> large folios into two
> smaller ones(still large folios) but not nr_pages small folios.

Yes, agree that there is certainly room for optimization here. Although deciding
on what order to target might not always be obvious; I guess we would want to
take into consideration the user-space enabled set of orders?

IIUC, Chris Li is working on an indirection layer that would permit storing
large folios non-contiguously in swap, so that might ultimately provide a better
solution than splitting.

> 
> Please disregard this comment for now since we don't have any data regarding
> THP_SWPOUT_FALLBACK of mTHP.

Yes, let's see what the data tells us.

> 
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/linux/swap.h |  10 ++-
>>  mm/swap_slots.c      |   6 +-
>>  mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>>  3 files changed, 109 insertions(+), 82 deletions(-)
>>
>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>> index 5e1e4f5bf0cb..11c53692f65f 100644
>> --- a/include/linux/swap.h
>> +++ b/include/linux/swap.h
>> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>>   */
>>  #define SWAP_NEXT_INVALID      0
>>
>> +#ifdef CONFIG_THP_SWAP
>> +#define SWAP_NR_ORDERS         (PMD_ORDER + 1)
>> +#else
>> +#define SWAP_NR_ORDERS         1
>> +#endif
>> +
>>  /*
>>   * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>>   * its own cluster and swapout sequentially. The purpose is to optimize swapout
>>   * throughput.
>>   */
>>  struct percpu_cluster {
>> -       unsigned int next; /* Likely next allocation offset */
>> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>>  };
>>
>>  struct swap_cluster_list {
>> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>>  bool folio_free_swap(struct folio *folio);
>>  void put_swap_folio(struct folio *folio, swp_entry_t entry);
>>  extern swp_entry_t get_swap_page_of_type(int);
>> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
>> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>>  extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>  extern void swap_shmem_alloc(swp_entry_t);
>>  extern int swap_duplicate(swp_entry_t);
>> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
>> index 53abeaf1371d..13ab3b771409 100644
>> --- a/mm/swap_slots.c
>> +++ b/mm/swap_slots.c
>> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>>         cache->cur = 0;
>>         if (swap_slot_cache_active)
>>                 cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
>> -                                          cache->slots, 1);
>> +                                          cache->slots, 0);
>>
>>         return cache->nr;
>>  }
>> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>
>>         if (folio_test_large(folio)) {
>>                 if (IS_ENABLED(CONFIG_THP_SWAP))
>> -                       get_swap_pages(1, &entry, folio_nr_pages(folio));
>> +                       get_swap_pages(1, &entry, folio_order(folio));
>>                 goto out;
>>         }
>>
>> @@ -343,7 +343,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>>                         goto out;
>>         }
>>
>> -       get_swap_pages(1, &entry, 1);
>> +       get_swap_pages(1, &entry, 0);
>>  out:
>>         if (mem_cgroup_try_charge_swap(folio, entry)) {
>>                 put_swap_folio(folio, entry);
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index c95986b9cb9c..3ee8957a46e6 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -278,15 +278,15 @@ static void discard_swap_cluster(struct swap_info_struct *si,
>>  #ifdef CONFIG_THP_SWAP
>>  #define SWAPFILE_CLUSTER       HPAGE_PMD_NR
>>
>> -#define swap_entry_size(size)  (size)
>> +#define swap_entry_order(order)        (order)
>>  #else
>>  #define SWAPFILE_CLUSTER       256
>>
>>  /*
>> - * Define swap_entry_size() as constant to let compiler to optimize
>> + * Define swap_entry_order() as constant to let compiler to optimize
>>   * out some code if !CONFIG_THP_SWAP
>>   */
>> -#define swap_entry_size(size)  1
>> +#define swap_entry_order(order)        0
>>  #endif
>>  #define LATENCY_LIMIT          256
>>
>> @@ -551,10 +551,12 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
>>
>>  /*
>>   * The cluster corresponding to page_nr will be used. The cluster will be
>> - * removed from free cluster list and its usage counter will be increased.
>> + * removed from free cluster list and its usage counter will be increased by
>> + * count.
>>   */
>> -static void inc_cluster_info_page(struct swap_info_struct *p,
>> -       struct swap_cluster_info *cluster_info, unsigned long page_nr)
>> +static void add_cluster_info_page(struct swap_info_struct *p,
>> +       struct swap_cluster_info *cluster_info, unsigned long page_nr,
>> +       unsigned long count)
>>  {
>>         unsigned long idx = page_nr / SWAPFILE_CLUSTER;
>>
>> @@ -563,9 +565,19 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
>>         if (cluster_is_free(&cluster_info[idx]))
>>                 alloc_cluster(p, idx);
>>
>> -       VM_BUG_ON(cluster_count(&cluster_info[idx]) >= SWAPFILE_CLUSTER);
>> +       VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
>>         cluster_set_count(&cluster_info[idx],
>> -               cluster_count(&cluster_info[idx]) + 1);
>> +               cluster_count(&cluster_info[idx]) + count);
>> +}
>> +
>> +/*
>> + * The cluster corresponding to page_nr will be used. The cluster will be
>> + * removed from free cluster list and its usage counter will be increased by 1.
>> + */
>> +static void inc_cluster_info_page(struct swap_info_struct *p,
>> +       struct swap_cluster_info *cluster_info, unsigned long page_nr)
>> +{
>> +       add_cluster_info_page(p, cluster_info, page_nr, 1);
>>  }
>>
>>  /*
>> @@ -595,7 +607,7 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
>>   */
>>  static bool
>>  scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>> -       unsigned long offset)
>> +       unsigned long offset, int order)
>>  {
>>         struct percpu_cluster *percpu_cluster;
>>         bool conflict;
>> @@ -609,24 +621,39 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>                 return false;
>>
>>         percpu_cluster = this_cpu_ptr(si->percpu_cluster);
>> -       percpu_cluster->next = SWAP_NEXT_INVALID;
>> +       percpu_cluster->next[order] = SWAP_NEXT_INVALID;
>> +       return true;
>> +}
>> +
>> +static inline bool swap_range_empty(char *swap_map, unsigned int start,
>> +                                   unsigned int nr_pages)
>> +{
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < nr_pages; i++) {
>> +               if (swap_map[start + i])
>> +                       return false;
>> +       }
>> +
>>         return true;
>>  }
>>
>>  /*
>> - * Try to get a swap entry from current cpu's swap entry pool (a cluster). This
>> - * might involve allocating a new cluster for current CPU too.
>> + * Try to get swap entries with specified order from current cpu's swap entry
>> + * pool (a cluster). This might involve allocating a new cluster for current CPU
>> + * too.
>>   */
>>  static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>> -       unsigned long *offset, unsigned long *scan_base)
>> +       unsigned long *offset, unsigned long *scan_base, int order)
>>  {
>> +       unsigned int nr_pages = 1 << order;
>>         struct percpu_cluster *cluster;
>>         struct swap_cluster_info *ci;
>>         unsigned int tmp, max;
>>
>>  new_cluster:
>>         cluster = this_cpu_ptr(si->percpu_cluster);
>> -       tmp = cluster->next;
>> +       tmp = cluster->next[order];
>>         if (tmp == SWAP_NEXT_INVALID) {
>>                 if (!cluster_list_empty(&si->free_clusters)) {
>>                         tmp = cluster_next(&si->free_clusters.head) *
>> @@ -647,26 +674,27 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>
>>         /*
>>          * Other CPUs can use our cluster if they can't find a free cluster,
>> -        * check if there is still free entry in the cluster
>> +        * check if there is still free entry in the cluster, maintaining
>> +        * natural alignment.
>>          */
>>         max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
>>         if (tmp < max) {
>>                 ci = lock_cluster(si, tmp);
>>                 while (tmp < max) {
>> -                       if (!si->swap_map[tmp])
>> +                       if (swap_range_empty(si->swap_map, tmp, nr_pages))
>>                                 break;
>> -                       tmp++;
>> +                       tmp += nr_pages;
>>                 }
>>                 unlock_cluster(ci);
>>         }
>>         if (tmp >= max) {
>> -               cluster->next = SWAP_NEXT_INVALID;
>> +               cluster->next[order] = SWAP_NEXT_INVALID;
>>                 goto new_cluster;
>>         }
>>         *offset = tmp;
>>         *scan_base = tmp;
>> -       tmp += 1;
>> -       cluster->next = tmp < max ? tmp : SWAP_NEXT_INVALID;
>> +       tmp += nr_pages;
>> +       cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
>>         return true;
>>  }
>>
>> @@ -796,13 +824,14 @@ static bool swap_offset_available_and_locked(struct swap_info_struct *si,
>>
>>  static int scan_swap_map_slots(struct swap_info_struct *si,
>>                                unsigned char usage, int nr,
>> -                              swp_entry_t slots[])
>> +                              swp_entry_t slots[], int order)
>>  {
>>         struct swap_cluster_info *ci;
>>         unsigned long offset;
>>         unsigned long scan_base;
>>         unsigned long last_in_cluster = 0;
>>         int latency_ration = LATENCY_LIMIT;
>> +       unsigned int nr_pages = 1 << order;
>>         int n_ret = 0;
>>         bool scanned_many = false;
>>
>> @@ -817,6 +846,25 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>          * And we let swap pages go all over an SSD partition.  Hugh
>>          */
>>
>> +       if (order > 0) {
>> +               /*
>> +                * Should not even be attempting large allocations when huge
>> +                * page swap is disabled.  Warn and fail the allocation.
>> +                */
>> +               if (!IS_ENABLED(CONFIG_THP_SWAP) ||
>> +                   nr_pages > SWAPFILE_CLUSTER) {
>> +                       VM_WARN_ON_ONCE(1);
>> +                       return 0;
>> +               }
>> +
>> +               /*
>> +                * Swapfile is not block device or not using clusters so unable
>> +                * to allocate large entries.
>> +                */
>> +               if (!(si->flags & SWP_BLKDEV) || !si->cluster_info)
>> +                       return 0;
>> +       }
>> +
>>         si->flags += SWP_SCANNING;
>>         /*
>>          * Use percpu scan base for SSD to reduce lock contention on
>> @@ -831,8 +879,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>
>>         /* SSD algorithm */
>>         if (si->cluster_info) {
>> -               if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
>> +               if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order)) {
>> +                       if (order > 0)
>> +                               goto no_page;
>>                         goto scan;
>> +               }
>>         } else if (unlikely(!si->cluster_nr--)) {
>>                 if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
>>                         si->cluster_nr = SWAPFILE_CLUSTER - 1;
>> @@ -874,13 +925,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>
>>  checks:
>>         if (si->cluster_info) {
>> -               while (scan_swap_map_ssd_cluster_conflict(si, offset)) {
>> +               while (scan_swap_map_ssd_cluster_conflict(si, offset, order)) {
>>                 /* take a break if we already got some slots */
>>                         if (n_ret)
>>                                 goto done;
>>                         if (!scan_swap_map_try_ssd_cluster(si, &offset,
>> -                                                       &scan_base))
>> +                                                       &scan_base, order)) {
>> +                               if (order > 0)
>> +                                       goto no_page;
>>                                 goto scan;
>> +                       }
>>                 }
>>         }
>>         if (!(si->flags & SWP_WRITEOK))
>> @@ -911,11 +965,11 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>                 else
>>                         goto done;
>>         }
>> -       WRITE_ONCE(si->swap_map[offset], usage);
>> -       inc_cluster_info_page(si, si->cluster_info, offset);
>> +       memset(si->swap_map + offset, usage, nr_pages);
>> +       add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
>>         unlock_cluster(ci);
>>
>> -       swap_range_alloc(si, offset, 1);
>> +       swap_range_alloc(si, offset, nr_pages);
>>         slots[n_ret++] = swp_entry(si->type, offset);
>>
>>         /* got enough slots or reach max slots? */
>> @@ -936,8 +990,10 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>
>>         /* try to get more slots in cluster */
>>         if (si->cluster_info) {
>> -               if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base))
>> +               if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order))
>>                         goto checks;
>> +               if (order > 0)
>> +                       goto done;
>>         } else if (si->cluster_nr && !si->swap_map[++offset]) {
>>                 /* non-ssd case, still more slots in cluster? */
>>                 --si->cluster_nr;
>> @@ -964,11 +1020,13 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>         }
>>
>>  done:
>> -       set_cluster_next(si, offset + 1);
>> +       if (order == 0)
>> +               set_cluster_next(si, offset + 1);
>>         si->flags -= SWP_SCANNING;
>>         return n_ret;
>>
>>  scan:
>> +       VM_WARN_ON(order > 0);
>>         spin_unlock(&si->lock);
>>         while (++offset <= READ_ONCE(si->highest_bit)) {
>>                 if (unlikely(--latency_ration < 0)) {
>> @@ -997,38 +1055,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>>         return n_ret;
>>  }
>>
>> -static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>> -{
>> -       unsigned long idx;
>> -       struct swap_cluster_info *ci;
>> -       unsigned long offset;
>> -
>> -       /*
>> -        * Should not even be attempting cluster allocations when huge
>> -        * page swap is disabled.  Warn and fail the allocation.
>> -        */
>> -       if (!IS_ENABLED(CONFIG_THP_SWAP)) {
>> -               VM_WARN_ON_ONCE(1);
>> -               return 0;
>> -       }
>> -
>> -       if (cluster_list_empty(&si->free_clusters))
>> -               return 0;
>> -
>> -       idx = cluster_list_first(&si->free_clusters);
>> -       offset = idx * SWAPFILE_CLUSTER;
>> -       ci = lock_cluster(si, offset);
>> -       alloc_cluster(si, idx);
>> -       cluster_set_count(ci, SWAPFILE_CLUSTER);
>> -
>> -       memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>> -       unlock_cluster(ci);
>> -       swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
>> -       *slot = swp_entry(si->type, offset);
>> -
>> -       return 1;
>> -}
>> -
>>  static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>  {
>>         unsigned long offset = idx * SWAPFILE_CLUSTER;
>> @@ -1042,17 +1068,15 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>         swap_range_free(si, offset, SWAPFILE_CLUSTER);
>>  }
>>
>> -int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>> +int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_order)
>>  {
>> -       unsigned long size = swap_entry_size(entry_size);
>> +       int order = swap_entry_order(entry_order);
>> +       unsigned long size = 1 << order;
>>         struct swap_info_struct *si, *next;
>>         long avail_pgs;
>>         int n_ret = 0;
>>         int node;
>>
>> -       /* Only single cluster request supported */
>> -       WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
>> -
>>         spin_lock(&swap_avail_lock);
>>
>>         avail_pgs = atomic_long_read(&nr_swap_pages) / size;
>> @@ -1088,14 +1112,10 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>>                         spin_unlock(&si->lock);
>>                         goto nextsi;
>>                 }
>> -               if (size == SWAPFILE_CLUSTER) {
>> -                       if (si->flags & SWP_BLKDEV)
>> -                               n_ret = swap_alloc_cluster(si, swp_entries);
>> -               } else
>> -                       n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
>> -                                                   n_goal, swp_entries);
>> +               n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
>> +                                           n_goal, swp_entries, order);
>>                 spin_unlock(&si->lock);
>> -               if (n_ret || size == SWAPFILE_CLUSTER)
>> +               if (n_ret || size > 1)
>>                         goto check_out;
>>                 cond_resched();
>>
>> @@ -1349,7 +1369,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry)
>>         unsigned char *map;
>>         unsigned int i, free_entries = 0;
>>         unsigned char val;
>> -       int size = swap_entry_size(folio_nr_pages(folio));
>> +       int size = 1 << swap_entry_order(folio_order(folio));
>>
>>         si = _swap_info_get(entry);
>>         if (!si)
>> @@ -1659,7 +1679,7 @@ swp_entry_t get_swap_page_of_type(int type)
>>
>>         /* This is called for allocating swap entry, not cache */
>>         spin_lock(&si->lock);
>> -       if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
>> +       if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry, 0))
>>                 atomic_long_dec(&nr_swap_pages);
>>         spin_unlock(&si->lock);
>>  fail:
>> @@ -3113,7 +3133,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>                 p->flags |= SWP_SYNCHRONOUS_IO;
>>
>>         if (p->bdev && bdev_nonrot(p->bdev)) {
>> -               int cpu;
>> +               int cpu, i;
>>                 unsigned long ci, nr_cluster;
>>
>>                 p->flags |= SWP_SOLIDSTATE;
>> @@ -3151,7 +3171,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>>                         struct percpu_cluster *cluster;
>>
>>                         cluster = per_cpu_ptr(p->percpu_cluster, cpu);
>> -                       cluster->next = SWAP_NEXT_INVALID;
>> +                       for (i = 0; i < SWAP_NR_ORDERS; i++)
>> +                               cluster->next[i] = SWAP_NEXT_INVALID;
>>                 }
>>         } else {
>>                 atomic_inc(&nr_rotate_swap);
>> --
>> 2.25.1
>>
> 
> Thanks
> Barry


