Return-Path: <linux-kernel+bounces-33735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C854836DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7A41C26AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E095C5FF;
	Mon, 22 Jan 2024 16:58:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5952B5C5E4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942718; cv=none; b=IaLSx0BMAfID8k7wrshpEeKRM56nZ8/TQ/R6Ez1hoDbvmmHNdaHs/pAhr+SafLWjrhk/wrSccgwP2gS5CNxcZoQiHWPaoYqJp+9kH+Ve2SY/AiYyTG72cPYaws7cyXvqkQxPU+Ystq/HLSZob28UWiAjbHFlK3x9MPHpPC/Y2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942718; c=relaxed/simple;
	bh=6mwcS5Rm2RqZx75W3pIXUPeWx8sVN7qarcHqFVNLhRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3ONHub17Edbyl/55tG7UkehtIaYf4zOUGkQX970diN1EOAJ6ESDn2pphYOv/0HIWawLCw8gtIR0xxExblzkruFUYzyu5r5UEsZTo4K1exsjY6dEJy3jyc54bpZJpMeAgjJLSTikecFhBfG71MqC5cFXWieGyoYzeuDpg0PpIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E07A1FB;
	Mon, 22 Jan 2024 08:59:21 -0800 (PST)
Received: from [10.1.33.151] (XHFQ2J9959.cambridge.arm.com [10.1.33.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 362A93F5A1;
	Mon, 22 Jan 2024 08:58:34 -0800 (PST)
Message-ID: <2445cedb-61fb-422c-8bfb-caf0a2beed62@arm.com>
Date: Mon, 22 Jan 2024 16:58:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/40] mm/memory: page_remove_rmap() ->
 folio_remove_rmap_pte()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231220224504.646757-1-david@redhat.com>
 <20231220224504.646757-29-david@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20231220224504.646757-29-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 22:44, David Hildenbrand wrote:
> Let's convert zap_pte_range() and closely-related
> tlb_flush_rmap_batch(). While at it, perform some more folio conversion
> in zap_pte_range().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c     | 23 +++++++++++++----------
>  mm/mmu_gather.c |  2 +-
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6552ea27b0bfa..eda2181275d9b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1434,6 +1434,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	arch_enter_lazy_mmu_mode();
>  	do {
>  		pte_t ptent = ptep_get(pte);
> +		struct folio *folio;
>  		struct page *page;
>  
>  		if (pte_none(ptent))
> @@ -1459,21 +1460,22 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				continue;
>  			}
>  
> +			folio = page_folio(page);
>  			delay_rmap = 0;
> -			if (!PageAnon(page)) {
> +			if (!folio_test_anon(folio)) {
>  				if (pte_dirty(ptent)) {
> -					set_page_dirty(page);
> +					folio_set_dirty(folio);

Is this foliation change definitely correct? I note that set_page_dirty() is
defined as this:

bool set_page_dirty(struct page *page)
{
	return folio_mark_dirty(page_folio(page));
}

And folio_mark_dirty() is doing more than just setting teh PG_dirty bit. In my
equivalent change, as part of the contpte series, I've swapped set_page_dirty()
for folio_mark_dirty().


>  					if (tlb_delay_rmap(tlb)) {
>  						delay_rmap = 1;
>  						force_flush = 1;
>  					}
>  				}
>  				if (pte_young(ptent) && likely(vma_has_recency(vma)))
> -					mark_page_accessed(page);
> +					folio_mark_accessed(folio);
>  			}
>  			rss[mm_counter(page)]--;
>  			if (!delay_rmap) {
> -				page_remove_rmap(page, vma, false);
> +				folio_remove_rmap_pte(folio, page, vma);
>  				if (unlikely(page_mapcount(page) < 0))
>  					print_bad_pte(vma, addr, ptent, page);
>  			}
> @@ -1489,6 +1491,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  		if (is_device_private_entry(entry) ||
>  		    is_device_exclusive_entry(entry)) {
>  			page = pfn_swap_entry_to_page(entry);
> +			folio = page_folio(page);
>  			if (unlikely(!should_zap_page(details, page)))
>  				continue;
>  			/*
> @@ -1500,8 +1503,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			WARN_ON_ONCE(!vma_is_anonymous(vma));
>  			rss[mm_counter(page)]--;
>  			if (is_device_private_entry(entry))
> -				page_remove_rmap(page, vma, false);
> -			put_page(page);
> +				folio_remove_rmap_pte(folio, page, vma);
> +			folio_put(folio);
>  		} else if (!non_swap_entry(entry)) {
>  			/* Genuine swap entry, hence a private anon page */
>  			if (!should_zap_cows(details))
> @@ -3220,10 +3223,10 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  			 * threads.
>  			 *
>  			 * The critical issue is to order this
> -			 * page_remove_rmap with the ptp_clear_flush above.
> -			 * Those stores are ordered by (if nothing else,)
> +			 * folio_remove_rmap_pte() with the ptp_clear_flush
> +			 * above. Those stores are ordered by (if nothing else,)
>  			 * the barrier present in the atomic_add_negative
> -			 * in page_remove_rmap.
> +			 * in folio_remove_rmap_pte();
>  			 *
>  			 * Then the TLB flush in ptep_clear_flush ensures that
>  			 * no process can access the old page before the
> @@ -3232,7 +3235,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  			 * mapcount is visible. So transitively, TLBs to
>  			 * old page will be flushed before it can be reused.
>  			 */
> -			page_remove_rmap(vmf->page, vma, false);
> +			folio_remove_rmap_pte(old_folio, vmf->page, vma);
>  		}
>  
>  		/* Free the old page.. */
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 4f559f4ddd217..604ddf08affed 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -55,7 +55,7 @@ static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_
>  
>  		if (encoded_page_flags(enc)) {
>  			struct page *page = encoded_page_ptr(enc);
> -			page_remove_rmap(page, vma, false);
> +			folio_remove_rmap_pte(page_folio(page), page, vma);
>  		}
>  	}
>  }


