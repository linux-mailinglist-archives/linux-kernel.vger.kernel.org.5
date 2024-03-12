Return-Path: <linux-kernel+bounces-100447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14848797AE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B53B22302
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E117C6DD;
	Tue, 12 Mar 2024 15:35:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016517C0B2
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257756; cv=none; b=WaGiFpzEuVZxtR02qOVk1thYo+8ciEkeNbPxEK2WhnVxkgEKhEfipoYetkqQpTpmfrr8B899Vhu460efkfKLLyscE3775zTLxdgKPdvlm2jimtBNbI3M7UI3ORX7Bpl13xtmQk+qZvUH0JNlnGZGUM6CU/OI4dxI5pBrgFFzxU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257756; c=relaxed/simple;
	bh=HUPKSgP/hd4apWfeqPxlRJYWZZQDhGAiuRIh7W5Tpxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JMCTS8eQnVtnYYlg81fwcX0wtV9GXsjBqgkIRylUC8CWe9HRxLJ7MXURdacKJ2MzjjgYmq8r1TsAcgUY1ADEKNTVsrpr8fj4KeC2ByocVoReQaLOKWOAsQn/hW+uRPjEfBZXt/c+5q6q1Cv9wtU1Eb85X8tFGvFvlKHjLisGrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C6991007;
	Tue, 12 Mar 2024 08:36:30 -0700 (PDT)
Received: from [10.1.27.122] (XHFQ2J9959.cambridge.arm.com [10.1.27.122])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FB033F762;
	Tue, 12 Mar 2024 08:35:48 -0700 (PDT)
Message-ID: <cf172f8b-8dc4-4017-81eb-84a2438d3cc6@arm.com>
Date: Tue, 12 Mar 2024 15:35:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 4/5] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
 yosryahmed@google.com, yuzhao@google.com, Barry Song
 <v-songbaohua@oppo.com>, Hugh Dickins <hughd@google.com>,
 Minchan Kim <minchan@kernel.org>, SeongJae Park <sj@kernel.org>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-5-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240304081348.197341-5-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/03/2024 08:13, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Commit 13ddaf26be32 ("mm/swap: fix race when skipping swapcache") supports
> one entry only, to support large folio swap-in, we need to handle multiple
> swap entries.
> 
> Cc: Kairui Song <kasong@tencent.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: SeongJae Park <sj@kernel.org>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/swap.h |   1 +
>  mm/swap.h            |   1 +
>  mm/swapfile.c        | 118 ++++++++++++++++++++++++++-----------------
>  3 files changed, 74 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d6ab27929458..22105f0fe2d4 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -480,6 +480,7 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>  extern void swap_shmem_alloc(swp_entry_t);
>  extern int swap_duplicate(swp_entry_t);
>  extern int swapcache_prepare(swp_entry_t);
> +extern int swapcache_prepare_nr(swp_entry_t entry, int nr);
>  extern void swap_free(swp_entry_t);
>  extern void swap_nr_free(swp_entry_t entry, int nr_pages);
>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
> diff --git a/mm/swap.h b/mm/swap.h
> index fc2f6ade7f80..1cec991efcda 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -42,6 +42,7 @@ void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>  				  unsigned long end);
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
> +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>  		struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 244106998a69..bae1b8165b11 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3309,7 +3309,7 @@ void si_swapinfo(struct sysinfo *val)
>  }
>  
>  /*
> - * Verify that a swap entry is valid and increment its swap map count.
> + * Verify that nr swap entries are valid and increment their swap map count.
>   *
>   * Returns error code in following case.
>   * - success -> 0
> @@ -3319,66 +3319,76 @@ void si_swapinfo(struct sysinfo *val)
>   * - swap-cache reference is requested but the entry is not used. -> ENOENT
>   * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
>   */
> -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> +static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned char usage)

perhaps its better to pass order instead of nr to all these functions to make it
clearer that entry should be naturally aligned and be a power-of-2 number of
pages, no bigger than SWAPFILE_CLUSTER?

>  {
>  	struct swap_info_struct *p;
>  	struct swap_cluster_info *ci;
>  	unsigned long offset;
> -	unsigned char count;
> -	unsigned char has_cache;
> -	int err;
> +	unsigned char count[SWAPFILE_CLUSTER];
> +	unsigned char has_cache[SWAPFILE_CLUSTER];

I'm not sure this 1K stack buffer is a good idea?

Could you split it slightly differently so that loop 1 just does error checking
and bails out if an error is found, and loop 2 does the new value calculation
and writeback? Then you don't need these arrays.

> +	int err, i;
>  
>  	p = swp_swap_info(entry);
>  
>  	offset = swp_offset(entry);
>  	ci = lock_cluster_or_swap_info(p, offset);
>  
> -	count = p->swap_map[offset];
> -
> -	/*
> -	 * swapin_readahead() doesn't check if a swap entry is valid, so the
> -	 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> -	 */
> -	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
> -		err = -ENOENT;
> -		goto unlock_out;
> -	}
> -
> -	has_cache = count & SWAP_HAS_CACHE;
> -	count &= ~SWAP_HAS_CACHE;
> -	err = 0;
> -
> -	if (usage == SWAP_HAS_CACHE) {
> +	for (i = 0; i < nr; i++) {
> +		count[i] = p->swap_map[offset + i];
>  
> -		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
> -		if (!has_cache && count)
> -			has_cache = SWAP_HAS_CACHE;
> -		else if (has_cache)		/* someone else added cache */
> -			err = -EEXIST;
> -		else				/* no users remaining */
> +		/*
> +		 * swapin_readahead() doesn't check if a swap entry is valid, so the
> +		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> +		 */
> +		if (unlikely(swap_count(count[i]) == SWAP_MAP_BAD)) {
>  			err = -ENOENT;
> +			goto unlock_out;
> +		}
>  
> -	} else if (count || has_cache) {
> -
> -		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> -			count += usage;
> -		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> -			err = -EINVAL;
> -		else if (swap_count_continued(p, offset, count))
> -			count = COUNT_CONTINUED;
> -		else
> -			err = -ENOMEM;
> -	} else
> -		err = -ENOENT;			/* unused swap entry */
> +		has_cache[i] = count[i] & SWAP_HAS_CACHE;
> +		count[i] &= ~SWAP_HAS_CACHE;
> +		err = 0;
> +
> +		if (usage == SWAP_HAS_CACHE) {
> +
> +			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
> +			if (!has_cache[i] && count[i])
> +				has_cache[i] = SWAP_HAS_CACHE;
> +			else if (has_cache[i])		/* someone else added cache */
> +				err = -EEXIST;
> +			else				/* no users remaining */
> +				err = -ENOENT;
> +		} else if (count[i] || has_cache[i]) {
> +
> +			if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> +				count[i] += usage;
> +			else if ((count[i] & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> +				err = -EINVAL;
> +			else if (swap_count_continued(p, offset + i, count[i]))
> +				count[i] = COUNT_CONTINUED;
> +			else
> +				err = -ENOMEM;
> +		} else
> +			err = -ENOENT;			/* unused swap entry */
>  
> -	if (!err)
> -		WRITE_ONCE(p->swap_map[offset], count | has_cache);
> +		if (err)
> +			break;
> +	}
>  
> +	if (!err) {
> +		for (i = 0; i < nr; i++)
> +			WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]);
> +	}
>  unlock_out:
>  	unlock_cluster_or_swap_info(p, ci);
>  	return err;
>  }
>  
> +static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
> +{
> +	return __swap_duplicate_nr(entry, 1, usage);
> +}
> +
>  /*
>   * Help swapoff by noting that swap entry belongs to shmem/tmpfs
>   * (in which case its reference count is never incremented).
> @@ -3417,17 +3427,33 @@ int swapcache_prepare(swp_entry_t entry)
>  	return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>  
> -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +int swapcache_prepare_nr(swp_entry_t entry, int nr)
> +{
> +	return __swap_duplicate_nr(entry, nr, SWAP_HAS_CACHE);
> +}
> +
> +void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, int nr)
>  {
>  	struct swap_cluster_info *ci;
>  	unsigned long offset = swp_offset(entry);
> -	unsigned char usage;
> +	unsigned char usage[SWAPFILE_CLUSTER];
> +	int i;
>  
>  	ci = lock_cluster_or_swap_info(si, offset);
> -	usage = __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> +	for (i = 0; i < nr; i++)
> +		usage[i] = __swap_entry_free_locked(si, offset + i, SWAP_HAS_CACHE);
>  	unlock_cluster_or_swap_info(si, ci);
> -	if (!usage)
> -		free_swap_slot(entry);
> +	for (i = 0; i < nr; i++) {
> +		if (!usage[i]) {
> +			free_swap_slot(entry);
> +			entry.val++;
> +		}
> +	}
> +}

This is pretty similar to swap_nr_free() which you added in patch 2. Except
swap_nr_free() passes 1 as last param to __swap_entry_free_locked() and this
passes SWAP_HAS_CACHE. Perhaps their should be a common helper? I think
swap_nr_free()'s usage bitmap is preferable to this version's char array too.

Thanks,
Ryan

> +
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +	swapcache_clear_nr(si, entry, 1);
>  }
>  
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)


