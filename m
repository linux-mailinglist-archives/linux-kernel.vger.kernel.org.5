Return-Path: <linux-kernel+bounces-99488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165887891F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BB51F218C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80E856B66;
	Mon, 11 Mar 2024 19:53:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CE52F82
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186794; cv=none; b=AQugrxhkYfIRCs06T3Bps9kSpw7u4/+bvZNHEcCMCidBfANFUqVin9LZ/zNqfPSnBXV/1WIjz9YKg2l638H2bgIrwpJCIUxmKDsLNn+8GMFULK32/QYzqbQGBQa7LekdhwPWaEeRCJpxIBqaTw30bjHcSxUORhJCKtI1xG8xK5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186794; c=relaxed/simple;
	bh=nxnMG6Bk1TNigOaRxdRVcWL8s3/11yNy3WpcTr1SEZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oICzD/4l0PFFFmHvpfDMtXGiqY7gbkNZMV/gCHPARs45e32l2TlZ/SwRbKB5CR9hM3auztU+OFMKtaKFIBW3PdEUnljlP4urbMCDdUWZmWP4XVViGcc6bmjdogon1Cw4M7a+eY4vIKeiPD64J2AToYoqsPK/795fZmr4zVHej3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7414DFEC;
	Mon, 11 Mar 2024 12:53:47 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 016063F73F;
	Mon, 11 Mar 2024 12:53:08 -0700 (PDT)
Message-ID: <93f05080-1a31-4f59-828e-f5294561a99f@arm.com>
Date: Mon, 11 Mar 2024 19:53:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: put dest folio on deferred split list if
 source was there.
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org
References: <20240311193641.133981-1-zi.yan@sent.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240311193641.133981-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 19:36, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
> did not check if a THP is on deferred split list before migration, thus,
> the destination THP is never put on deferred split list even if the source
> THP might be. The opportunity of reclaiming free pages in a partially
> mapped THP during deferred list scanning is lost, but no other harmful
> consequence is present[1]. Checking source folio deferred split list
> status before page unmapped and add destination folio to the list if
> source was after migration.
> 
> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 22 ----------------------
>  mm/internal.h    | 23 +++++++++++++++++++++++
>  mm/migrate.c     | 26 +++++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..c6d4d0cdf4b3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>  	return pmd;
>  }
>  
> -#ifdef CONFIG_MEMCG
> -static inline
> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> -{
> -	struct mem_cgroup *memcg = folio_memcg(folio);
> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> -
> -	if (memcg)
> -		return &memcg->deferred_split_queue;
> -	else
> -		return &pgdat->deferred_split_queue;
> -}
> -#else
> -static inline
> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
> -{
> -	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> -
> -	return &pgdat->deferred_split_queue;
> -}
> -#endif
> -
>  void folio_prep_large_rmappable(struct folio *folio)
>  {
>  	if (!folio || !folio_test_large(folio))
> diff --git a/mm/internal.h b/mm/internal.h
> index d1c69119b24f..8fa36e84463a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>  				   unsigned long addr, pmd_t *pmd,
>  				   unsigned int flags);
>  
> +#ifdef CONFIG_MEMCG
> +static inline
> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
> +{
> +	struct mem_cgroup *memcg = folio_memcg(folio);
> +	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> +
> +	if (memcg)
> +		return &memcg->deferred_split_queue;
> +	else
> +		return &pgdat->deferred_split_queue;
> +}
> +#else
> +static inline
> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
> +{
> +	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
> +
> +	return &pgdat->deferred_split_queue;
> +}
> +#endif
> +
> +
>  /*
>   * mm/mmap.c
>   */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 73a052a382f1..84ba1c65d20d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -20,6 +20,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/buffer_head.h>
>  #include <linux/mm_inline.h>
> +#include <linux/mmzone.h>
>  #include <linux/nsproxy.h>
>  #include <linux/ksm.h>
>  #include <linux/rmap.h>
> @@ -1037,7 +1038,10 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>  enum {
>  	PAGE_WAS_MAPPED = BIT(0),
>  	PAGE_WAS_MLOCKED = BIT(1),
> -	PAGE_OLD_STATES = PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
> +	PAGE_WAS_ON_DEFERRED_LIST = BIT(2),
> +	PAGE_OLD_STATES = PAGE_WAS_MAPPED |
> +			  PAGE_WAS_MLOCKED |
> +			  PAGE_WAS_ON_DEFERRED_LIST,
>  };
>  
>  static void __migrate_folio_record(struct folio *dst,
> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>  		folio_lock(src);
>  	}
>  	locked = true;
> +	if (folio_test_large_rmappable(src) &&
> +		!list_empty(&src->_deferred_list)) {
> +		struct deferred_split *ds_queue = get_deferred_split_queue(src);
> +
> +		spin_lock(&ds_queue->split_queue_lock);
> +		ds_queue->split_queue_len--;
> +		list_del_init(&src->_deferred_list);
> +		spin_unlock(&ds_queue->split_queue_lock);
> +		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
> +	}
> +
>  	if (folio_test_mlocked(src))
>  		old_page_state |= PAGE_WAS_MLOCKED;
>  
> @@ -1307,6 +1322,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>  	if (old_page_state & PAGE_WAS_MAPPED)
>  		remove_migration_ptes(src, dst, false);
>  
> +	if (old_page_state & PAGE_WAS_ON_DEFERRED_LIST) {
> +		struct deferred_split *ds_queue = get_deferred_split_queue(src);

do you mean dst here?

> +
> +		spin_lock(&ds_queue->split_queue_lock);
> +		ds_queue->split_queue_len++;
> +		list_add(&dst->_deferred_list, &ds_queue->split_queue);
> +		spin_unlock(&ds_queue->split_queue_lock);
> +	}
> +
>  out_unlock_both:
>  	folio_unlock(dst);
>  	set_page_owner_migrate_reason(&dst->page, reason);


