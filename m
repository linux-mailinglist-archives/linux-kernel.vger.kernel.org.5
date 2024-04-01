Return-Path: <linux-kernel+bounces-126443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFDA893823
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68E6B20FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403488F58;
	Mon,  1 Apr 2024 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CyEzq8Ok"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15966944D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 05:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711950846; cv=none; b=WCnKJFG0++2RoT4M+S92MIsPFbbhOB8Yr5a2IWNxkHq3qQY21o3+NJD9efXWozcYJNkRqqbZVpIGEKZeLa9+TmZxXLdXjbnXqFMQcsOXX1CHwxmKfMFprqD764OpVscsrlIKklkN0OCfgK6JXvWKrtISlJWJqSjN3xrzqxhvtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711950846; c=relaxed/simple;
	bh=lE92Mn4WgyHHHmCFG0YK/cnjWkrzaDnOIbLPbCdVEPY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbpXIJ+9l77nggRbViL/avip8NUFazrGLY4tB1k6r+YE8W1M9a+mBM9+I1421SCh9rDMxmNl9WuLY5AiiLLpqehOBFv7TzuPKvxZqiFJRq9fJeY8uwSH/LZHOJXEzDw5iFFV/9mCV3gizRFT+76Ydzi9M4JD1BiY1E0HotbQZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CyEzq8Ok; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711950844; x=1743486844;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=lE92Mn4WgyHHHmCFG0YK/cnjWkrzaDnOIbLPbCdVEPY=;
  b=CyEzq8OkhnSFsYjECSc8+z0cpqiaUCsGO1n/RJJg66ii+qbocuSeBBvz
   7DLK/eHRTNeUZ0p5sv9cmjLMKOAp9JOMrSsUGNhSD69lgIC3hPVGuRF2L
   ixwnmebDCtMcIpuwt4GQs+Vq5W5m35pAV5/RV7CtNl6dM8fCrfvMEhVRW
   DjN/CWCGs7A0IJfGCImxwWm/rGAjExNw0h7OJ1oIEOVWLzQrMmhIioCxG
   h/zmgTbjOo1OdwWgQCXVVSociyEd2njl8Dd/1me4rBfZQcfGWlbOsfBIZ
   pDoeA5T0XaNjvcWF/ssJxICKUm/vsM8nvfp78kmEEqIq5Ju7tXDmTnClp
   w==;
X-CSE-ConnectionGUID: pNIW5Gn9TM6PQxVusyma7w==
X-CSE-MsgGUID: UKX633niR7qirIKgZBIWCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6922652"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6922652"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 22:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="17474745"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2024 22:54:00 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Lance Yang <ioworker0@gmail.com>,
  <linux-mm@kvack.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
In-Reply-To: <20240327144537.4165578-3-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Wed, 27 Mar 2024 14:45:33 +0000")
References: <20240327144537.4165578-1-ryan.roberts@arm.com>
	<20240327144537.4165578-3-ryan.roberts@arm.com>
Date: Mon, 01 Apr 2024 13:52:07 +0800
Message-ID: <87jzlhk4u0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> Now that we no longer have a convenient flag in the cluster to determine
> if a folio is large, free_swap_and_cache() will take a reference and
> lock a large folio much more often, which could lead to contention and
> (e.g.) failure to split large folios, etc.
>
> Let's solve that problem by batch freeing swap and cache with a new
> function, free_swap_and_cache_nr(), to free a contiguous range of swap
> entries together. This allows us to first drop a reference to each swap
> slot before we try to release the cache folio. This means we only try to
> release the folio once, only taking the reference and lock once - much
> better than the previous 512 times for the 2M THP case.
>
> Contiguous swap entries are gathered in zap_pte_range() and
> madvise_free_pte_range() in a similar way to how present ptes are
> already gathered in zap_pte_range().
>
> While we are at it, let's simplify by converting the return type of both
> functions to void. The return value was used only by zap_pte_range() to
> print a bad pte, and was ignored by everyone else, so the extra
> reporting wasn't exactly guaranteed. We will still get the warning with
> most of the information from get_swap_device(). With the batch version,
> we wouldn't know which pte was bad anyway so could print the wrong one.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h | 28 +++++++++++++++
>  include/linux/swap.h    | 12 +++++--
>  mm/internal.h           | 48 +++++++++++++++++++++++++
>  mm/madvise.c            | 12 ++++---
>  mm/memory.c             | 13 +++----
>  mm/swapfile.c           | 78 ++++++++++++++++++++++++++++++-----------
>  6 files changed, 157 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 09c85c7bf9c2..8185939df1e8 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef clear_not_present_full_ptes
> +/**
> + * clear_not_present_full_ptes - Clear consecutive not present PTEs.
> + * @mm: Address space the ptes represent.
> + * @addr: Address of the first pte.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to clear.
> + * @full: Whether we are clearing a full mm.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over pte_clear_not_present_full().
> + *
> + * Context: The caller holds the page table lock.  The PTEs are all not present.
> + * The PTEs are all in the same PMD.
> + */
> +static inline void clear_not_present_full_ptes(struct mm_struct *mm,
> +		unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	for (;;) {
> +		pte_clear_not_present_full(mm, addr, ptep, full);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
>  extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
>  			      unsigned long address,
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6f78198f000..5737236dc3ce 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
>  extern void swap_free(swp_entry_t);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> -extern int free_swap_and_cache(swp_entry_t);
> +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>  int swap_type_of(dev_t device, sector_t offset);
>  int find_first_swap(dev_t *device);
>  extern unsigned int count_swap_pages(int, int);
> @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  #define free_pages_and_swap_cache(pages, nr) \
>  	release_pages((pages), (nr));
>  
> -/* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
> -#define free_swap_and_cache(e) is_pfn_swap_entry(e)
> +static inline void free_swap_and_cache_nr(swp_entry_t entry, int nr)
> +{
> +}
>  
>  static inline void free_swap_cache(struct folio *folio)
>  {
> @@ -589,6 +590,11 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
>  }
>  #endif /* CONFIG_SWAP */
>  
> +static inline void free_swap_and_cache(swp_entry_t entry)
> +{
> +	free_swap_and_cache_nr(entry, 1);
> +}
> +
>  #ifdef CONFIG_MEMCG
>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>  {
> diff --git a/mm/internal.h b/mm/internal.h
> index 8e11f7b2da21..eadb79c3a357 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -11,6 +11,8 @@
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
>  #include <linux/rmap.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  #include <linux/tracepoint-defs.h>
>  
>  struct folio_batch;
> @@ -189,6 +191,52 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>  
>  	return min(ptep - start_ptep, max_nr);
>  }
> +
> +/**
> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
> + * @start_ptep: Page table pointer for the first entry.
> + * @max_nr: The maximum number of table entries to consider.
> + * @entry: Swap entry recovered from the first table entry.
> + *
> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
> + * containing swap entries all with consecutive offsets and targeting the same
> + * swap type.
> + *
> + * max_nr must be at least one and must be limited by the caller so scanning
> + * cannot exceed a single page table.
> + *
> + * Return: the number of table entries in the batch.
> + */
> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr,
> +				 swp_entry_t entry)
> +{
> +	const pte_t *end_ptep = start_ptep + max_nr;
> +	unsigned long expected_offset = swp_offset(entry) + 1;
> +	unsigned int expected_type = swp_type(entry);
> +	pte_t *ptep = start_ptep + 1;
> +
> +	VM_WARN_ON(max_nr < 1);
> +	VM_WARN_ON(non_swap_entry(entry));
> +
> +	while (ptep < end_ptep) {
> +		pte_t pte = ptep_get(ptep);
> +
> +		if (pte_none(pte) || pte_present(pte))
> +			break;
> +
> +		entry = pte_to_swp_entry(pte);
> +
> +		if (non_swap_entry(entry) ||
> +		    swp_type(entry) != expected_type ||
> +		    swp_offset(entry) != expected_offset)
> +			break;
> +
> +		expected_offset++;
> +		ptep++;
> +	}
> +
> +	return ptep - start_ptep;
> +}
>  #endif /* CONFIG_MMU */
>  
>  void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 1f77a51baaac..070bedb4996e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  	struct folio *folio;
>  	int nr_swap = 0;
>  	unsigned long next;
> +	int nr, max_nr;
>  
>  	next = pmd_addr_end(addr, end);
>  	if (pmd_trans_huge(*pmd))
> @@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		return 0;
>  	flush_tlb_batched_pending(mm);
>  	arch_enter_lazy_mmu_mode();
> -	for (; addr != end; pte++, addr += PAGE_SIZE) {
> +	for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
> +		nr = 1;
>  		ptent = ptep_get(pte);
>  
>  		if (pte_none(ptent))
> @@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  
>  			entry = pte_to_swp_entry(ptent);
>  			if (!non_swap_entry(entry)) {
> -				nr_swap--;
> -				free_swap_and_cache(entry);
> -				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +				max_nr = (end - addr) / PAGE_SIZE;
> +				nr = swap_pte_batch(pte, max_nr, entry);
> +				nr_swap -= nr;
> +				free_swap_and_cache_nr(entry, nr);
> +				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>  			} else if (is_hwpoison_entry(entry) ||
>  				   is_poisoned_swp_entry(entry)) {
>  				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> diff --git a/mm/memory.c b/mm/memory.c
> index 36191a9c799c..9d844582ba38 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1631,12 +1631,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				folio_remove_rmap_pte(folio, page, vma);
>  			folio_put(folio);
>  		} else if (!non_swap_entry(entry)) {
> -			/* Genuine swap entry, hence a private anon page */
> +			max_nr = (end - addr) / PAGE_SIZE;
> +			nr = swap_pte_batch(pte, max_nr, entry);
> +			/* Genuine swap entries, hence a private anon pages */
>  			if (!should_zap_cows(details))
>  				continue;
> -			rss[MM_SWAPENTS]--;
> -			if (unlikely(!free_swap_and_cache(entry)))
> -				print_bad_pte(vma, addr, ptent, NULL);
> +			rss[MM_SWAPENTS] -= nr;
> +			free_swap_and_cache_nr(entry, nr);
>  		} else if (is_migration_entry(entry)) {
>  			folio = pfn_swap_entry_folio(entry);
>  			if (!should_zap_folio(details, folio))
> @@ -1659,8 +1660,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>  			WARN_ON_ONCE(1);
>  		}
> -		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> -		zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
> +		clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
> +		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
>  	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>  
>  	add_mm_rss_vec(mm, rss);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0d44ee2b4f9c..cedfc82d37e5 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -130,7 +130,11 @@ static inline unsigned char swap_count(unsigned char ent)
>  /* Reclaim the swap entry if swap is getting full*/
>  #define TTRS_FULL		0x4
>  
> -/* returns 1 if swap entry is freed */
> +/*
> + * returns number of pages in the folio that backs the swap entry. If positive,
> + * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
> + * folio was associated with the swap entry.
> + */
>  static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  				 unsigned long offset, unsigned long flags)
>  {
> @@ -155,6 +159,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>  			ret = folio_free_swap(folio);
>  		folio_unlock(folio);
>  	}
> +	ret = ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
>  	folio_put(folio);
>  	return ret;
>  }
> @@ -895,7 +900,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>  		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
>  		spin_lock(&si->lock);
>  		/* entry was freed successfully, try to use this again */
> -		if (swap_was_freed)
> +		if (swap_was_freed > 0)
>  			goto checks;
>  		goto scan; /* check next one */
>  	}
> @@ -1572,32 +1577,63 @@ bool folio_free_swap(struct folio *folio)
>  	return true;
>  }
>  
> -/*
> - * Free the swap entry like above, but also try to
> - * free the page cache entry if it is the last user.
> - */
> -int free_swap_and_cache(swp_entry_t entry)
> +void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>  {
> -	struct swap_info_struct *p;
> -	unsigned char count;
> +	unsigned long end = swp_offset(entry) + nr;
> +	unsigned int type = swp_type(entry);
> +	struct swap_info_struct *si;
> +	unsigned long offset;
>  
>  	if (non_swap_entry(entry))
> -		return 1;
> +		return;
>  
> -	p = get_swap_device(entry);
> -	if (p) {
> -		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
> -			put_swap_device(p);
> -			return 0;
> -		}
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return;
>  
> -		count = __swap_entry_free(p, entry);
> -		if (count == SWAP_HAS_CACHE)
> -			__try_to_reclaim_swap(p, swp_offset(entry),
> +	if (WARN_ON(end > si->max))
> +		goto out;
> +
> +	/*
> +	 * First free all entries in the range.
> +	 */
> +	for (offset = swp_offset(entry); offset < end; offset++) {
> +		if (!WARN_ON(data_race(!si->swap_map[offset])))
> +			__swap_entry_free(si, swp_entry(type, offset));

I think that it's better to check the return value of
__swap_entry_free() here.  When the return value != SWAP_HAS_CACHE, we
can try to reclaim all swap entries we have checked before, then restart
the check with the new start.

> +	}
> +
> +	/*
> +	 * Now go back over the range trying to reclaim the swap cache. This is
> +	 * more efficient for large folios because we will only try to reclaim
> +	 * the swap once per folio in the common case. If we do
> +	 * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
> +	 * latter will get a reference and lock the folio for every individual
> +	 * page but will only succeed once the swap slot for every subpage is
> +	 * zero.
> +	 */
> +	for (offset = swp_offset(entry); offset < end; offset += nr) {
> +		nr = 1;
> +		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
> +			/*
> +			 * Folios are always naturally aligned in swap so
> +			 * advance forward to the next boundary. Zero means no
> +			 * folio was found for the swap entry, so advance by 1
> +			 * in this case. Negative value means folio was found
> +			 * but could not be reclaimed. Here we can still advance
> +			 * to the next boundary.
> +			 */
> +			nr = __try_to_reclaim_swap(si, offset,
>  					      TTRS_UNMAPPED | TTRS_FULL);
> -		put_swap_device(p);
> +			if (nr == 0)
> +				nr = 1;
> +			else if (nr < 0)
> +				nr = -nr;
> +			nr = ALIGN(offset + 1, nr) - offset;
> +		}
>  	}
> -	return p != NULL;
> +
> +out:
> +	put_swap_device(si);
>  }
>  
>  #ifdef CONFIG_HIBERNATION

--
Best Regards,
Huang, Ying

