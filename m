Return-Path: <linux-kernel+bounces-99910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86FE878F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 543C3B21357
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279106995A;
	Tue, 12 Mar 2024 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TEIceE4V"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690069958
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710228445; cv=none; b=M4rOcP0MMvhdWo3Fs418YU67QiC4RfrEwN3veAKeMs3Zz54IIpTSFT0SZmt0EFFvgPA6K1W2aDCxmvL9fMhtnquiU6BS9FCZ6bbNzJJDxB6AcHkoyVygjzNqWQmFHZ0o23wp2SabU5CtbBS9wu0kVLbbBdHaeBrB7V5pGi6o9BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710228445; c=relaxed/simple;
	bh=rau2ZXhw2u4iwC+3dkjnjkUaq/e+8lozHDLSMOcuGUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdLqMQ6PfmqCL3ivZvejudv84XMkQW8XS9mFfpiBOwUi1k93g1XGNFb6b2WGMLnUyqc3uP6x/K+vyKOGZ1RPg4X5PFf5PZ7OnieksnTpOPl6sTwdEJv8oEmhjrlca3Q4nS5TZvEFVudwIEbl37PfCbFe6YHuq/T8f6x3OYwmgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TEIceE4V; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710228434; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kSSt8SHpYapetnfBjwiq6UQNHHnNk1Xqt0pSKtWzsiU=;
	b=TEIceE4VZQ95NcQh+ctSRTGybQZ9NWOK/7Kupl7/+DC+pwCEgu/Nsokqu+uN2sIzqJhGhuMXQ2PU9Ca5vpSuwtfkgf7mzFYAjXViEu49F+t6DQv0lK23MDz/rmX2IFtqq7oNpADK4zkx0ZicFluYdEaHrM+OzT00TgZy10yvhcA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KyR9a_1710228432;
Received: from 30.97.56.54(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W2KyR9a_1710228432)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 15:27:14 +0800
Message-ID: <081dc7bb-ae60-4a38-b9c8-560280cf5cf8@linux.alibaba.com>
Date: Tue, 12 Mar 2024 15:27:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/migrate: put dest folio on deferred split list if
 source was there.
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
References: <20240311195848.135067-1-zi.yan@sent.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240311195848.135067-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/12 03:58, Zi Yan wrote:
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
>  From v1:
> 1. Used dst to get correct deferred split list after migration
>     (per Ryan Roberts).
> 
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   mm/huge_memory.c | 22 ----------------------
>   mm/internal.h    | 23 +++++++++++++++++++++++
>   mm/migrate.c     | 26 +++++++++++++++++++++++++-
>   3 files changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9859aa4f7553..c6d4d0cdf4b3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
>   	return pmd;
>   }
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
>   void folio_prep_large_rmappable(struct folio *folio)
>   {
>   	if (!folio || !folio_test_large(folio))
> diff --git a/mm/internal.h b/mm/internal.h
> index d1c69119b24f..8fa36e84463a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
>   				   unsigned long addr, pmd_t *pmd,
>   				   unsigned int flags);
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
>   /*
>    * mm/mmap.c
>    */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 73a052a382f1..591e65658535 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -20,6 +20,7 @@
>   #include <linux/pagemap.h>
>   #include <linux/buffer_head.h>
>   #include <linux/mm_inline.h>
> +#include <linux/mmzone.h>
>   #include <linux/nsproxy.h>
>   #include <linux/ksm.h>
>   #include <linux/rmap.h>
> @@ -1037,7 +1038,10 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
>   enum {
>   	PAGE_WAS_MAPPED = BIT(0),
>   	PAGE_WAS_MLOCKED = BIT(1),
> -	PAGE_OLD_STATES = PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
> +	PAGE_WAS_ON_DEFERRED_LIST = BIT(2),
> +	PAGE_OLD_STATES = PAGE_WAS_MAPPED |
> +			  PAGE_WAS_MLOCKED |
> +			  PAGE_WAS_ON_DEFERRED_LIST,
>   };
>   
>   static void __migrate_folio_record(struct folio *dst,
> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   		folio_lock(src);
>   	}
>   	locked = true;
> +	if (folio_test_large_rmappable(src) &&

IMO, you should check folio_test_large() before calling 
folio_test_large_rmappable(), since the PG_large_rmappable flag is 
stored in the first tail page.

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
>   	if (folio_test_mlocked(src))
>   		old_page_state |= PAGE_WAS_MLOCKED;
>   
> @@ -1307,6 +1322,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
>   	if (old_page_state & PAGE_WAS_MAPPED)
>   		remove_migration_ptes(src, dst, false);
>   
> +	if (old_page_state & PAGE_WAS_ON_DEFERRED_LIST) {
> +		struct deferred_split *ds_queue = get_deferred_split_queue(dst);
> +
> +		spin_lock(&ds_queue->split_queue_lock);
> +		ds_queue->split_queue_len++;
> +		list_add(&dst->_deferred_list, &ds_queue->split_queue);
> +		spin_unlock(&ds_queue->split_queue_lock);
> +	}
> +
>   out_unlock_both:
>   	folio_unlock(dst);
>   	set_page_owner_migrate_reason(&dst->page, reason);

