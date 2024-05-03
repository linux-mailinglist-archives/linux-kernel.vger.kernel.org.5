Return-Path: <linux-kernel+bounces-167465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD448BA9E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF2C1F222D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B61914F13C;
	Fri,  3 May 2024 09:31:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B47B14D71C
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728678; cv=none; b=d7Go8MTf8dLNwtYMGkXAdAWAEYmrAZ0E85swaEWWAHvZYCcRMjJ9j2KOCuIQnRQwYJtIHSE49bgv0CKWmGJumdp9BWG3suKYtmS6Nuqj4eCXAkgQwQc5iZAbHhKKwHaynuVO/dsdJQuthtaLSgCHoe2UWqvL0lAX5CcgX6DFimY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728678; c=relaxed/simple;
	bh=HlXz9yZSrbmE57QUFCXF8XoZl9rej5ILMUohig4pI2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2s3mAITmJnD8m+0SERnVZ+oYgf2e9Bba0mL3IvVWW4/5RUTCPPh0sz4/HOpRUOTR3HCM4TZjpBFbC/8ms15eIRv3VLDFygh21n7hBIzaSDPKZ07734i1ptJ0K5edGg/5AdftSYkfqernK0oHtugKloIUy5QQYg4IFYAdetqA74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A40D339;
	Fri,  3 May 2024 02:31:41 -0700 (PDT)
Received: from [10.57.67.51] (unknown [10.57.67.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8693F73F;
	Fri,  3 May 2024 02:31:12 -0700 (PDT)
Message-ID: <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
Date: Fri, 3 May 2024 10:31:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use
 swap_free_nr()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-3-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240503005023.174597-3-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/05/2024 01:50, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> To streamline maintenance efforts, we propose discontinuing the use of
> swap_free(). Instead, we can simply invoke swap_free_nr() with nr set
> to 1. This adjustment offers the advantage of enabling batch processing
> within kernel/power/swap.c. Furthermore, swap_free_nr() is designed with
> a bitmap consisting of only one long, resulting in overhead that can be
> ignored for cases where nr equals 1.
> 
> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> ---
>  include/linux/swap.h |  5 -----
>  kernel/power/swap.c  |  7 +++----
>  mm/memory.c          |  2 +-
>  mm/rmap.c            |  4 ++--
>  mm/shmem.c           |  4 ++--
>  mm/swapfile.c        | 19 +++++--------------
>  6 files changed, 13 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d1d35e92d7e9..f03cb446124e 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
> -extern void swap_free(swp_entry_t);

I wonder if it would be cleaner to:

#define swap_free(entry) swap_free_nr((entry), 1)

To save all the churn for the callsites that just want to pass a single entry?

>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
> @@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
>  	return 0;
>  }
>  
> -static inline void swap_free(swp_entry_t swp)
> -{
> -}
> -
>  static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
>  {
>  }
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index 5bc04bfe2db1..6befaa88a342 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -181,7 +181,7 @@ sector_t alloc_swapdev_block(int swap)
>  	offset = swp_offset(get_swap_page_of_type(swap));
>  	if (offset) {
>  		if (swsusp_extents_insert(offset))
> -			swap_free(swp_entry(swap, offset));
> +			swap_free_nr(swp_entry(swap, offset), 1);
>  		else
>  			return swapdev_block(swap, offset);
>  	}
> @@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
>  
>  	while ((node = swsusp_extents.rb_node)) {
>  		struct swsusp_extent *ext;
> -		unsigned long offset;
>  
>  		ext = rb_entry(node, struct swsusp_extent, node);
>  		rb_erase(node, &swsusp_extents);
> -		for (offset = ext->start; offset <= ext->end; offset++)
> -			swap_free(swp_entry(swap, offset));
> +		swap_free_nr(swp_entry(swap, ext->start),
> +			     ext->end - ext->start + 1);
>  
>  		kfree(ext);
>  	}
> diff --git a/mm/memory.c b/mm/memory.c
> index eea6e4984eae..f033eb3528ba 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4225,7 +4225,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 * We're already holding a reference on the page but haven't mapped it
>  	 * yet.
>  	 */
> -	swap_free(entry);
> +	swap_free_nr(entry, 1);
>  	if (should_try_to_free_swap(folio, vma, vmf->flags))
>  		folio_free_swap(folio);
>  
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 087a79f1f611..39ec7742acec 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1865,7 +1865,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  				goto walk_done_err;
>  			}
>  			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
> -				swap_free(entry);
> +				swap_free_nr(entry, 1);
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  				goto walk_done_err;
>  			}
> @@ -1873,7 +1873,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			/* See folio_try_share_anon_rmap(): clear PTE first. */
>  			if (anon_exclusive &&
>  			    folio_try_share_anon_rmap_pte(folio, subpage)) {
> -				swap_free(entry);
> +				swap_free_nr(entry, 1);
>  				set_pte_at(mm, address, pvmw.pte, pteval);
>  				goto walk_done_err;
>  			}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fa2a0ed97507..bfc8a2beb24f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1836,7 +1836,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>  	 * in shmem_evict_inode().
>  	 */
>  	shmem_recalc_inode(inode, -1, -1);
> -	swap_free(swap);
> +	swap_free_nr(swap, 1);
>  }
>  
>  /*
> @@ -1927,7 +1927,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>  
>  	delete_from_swap_cache(folio);
>  	folio_mark_dirty(folio);
> -	swap_free(swap);
> +	swap_free_nr(swap, 1);
>  	put_swap_device(si);
>  
>  	*foliop = folio;
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ec12f2b9d229..ddcd0f24b9a1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>  	swap_range_free(p, offset, 1);
>  }
>  
> -/*
> - * Caller has made sure that the swap device corresponding to entry
> - * is still around or has not been recycled.
> - */
> -void swap_free(swp_entry_t entry)
> -{
> -	struct swap_info_struct *p;
> -
> -	p = _swap_info_get(entry);
> -	if (p)
> -		__swap_entry_free(p, entry);
> -}
> -
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
>  		unsigned long offset, int nr_pages)
>  {
> @@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
>  	unlock_cluster_or_swap_info(sis, ci);
>  }
>  
> +/*
> + * Caller has made sure that the swap device corresponding to entry
> + * is still around or has not been recycled.
> + */
>  void swap_free_nr(swp_entry_t entry, int nr_pages)
>  {
>  	int nr;
> @@ -1930,7 +1921,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		new_pte = pte_mkuffd_wp(new_pte);
>  setpte:
>  	set_pte_at(vma->vm_mm, addr, pte, new_pte);
> -	swap_free(entry);
> +	swap_free_nr(entry, 1);
>  out:
>  	if (pte)
>  		pte_unmap_unlock(pte, ptl);


