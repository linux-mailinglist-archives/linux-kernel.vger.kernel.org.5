Return-Path: <linux-kernel+bounces-132838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A19D8899AFE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D3F1F22603
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A0F15FA6F;
	Fri,  5 Apr 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5eaBUOx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049D7535B6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313499; cv=none; b=S9+Xn3pzADyJMiB8CHmONDfNozuzsXgjmr1KnU201Whx+Ex6c+rH1Pb5bYr292Son9p4xi9DRHb/2C2m1ko/grs3FWQgL7FOq4pPtBszuYJ0P4tUZw5S5nNv0X2tcswis0q8b1WdXl3S2EZKnAnZ8eUQG5ngUMRLJ6I8WWV+xOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313499; c=relaxed/simple;
	bh=KnUhpanRpuHNBZjQHOfLdi4FYBpgeV0mKalqdYGC26I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4g0/eMipdLByGPV86U49x6dRm1vPOTpixmmRIQEyF1WkW0a5YZ4cNgOo3BrJMI9I+qU1LEMxdSfvNoy3na1y34lB+MT7rHjLwgxtiKwN0/sShmqAi9BpshVLARgW5XUlEXzqSKt4EGkjO/7OX0mrRzCyWE0mOKvJVObXQdJaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5eaBUOx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712313495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=I0L4+tioaEa5Oez9lF/k2qN4oyGOYvytJdtMM+KNXgo=;
	b=Q5eaBUOxMIxm17dDUwMLpZ47/bfp58pV47+JCbiI+kVFPUnqeU7SB0z59zXoK2Aln82NZS
	nKlWJg4zc9zECe8b34wkQ+GJsSo7Efal41oJ1f6Mrfqc6EKRjLOJd0sOVcTj3/JrRcuOMS
	+/XklZTaUtCFAqtQIrGzbpFCLjh+uvs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-Vo3LerlkMOC_SyyWZ4cExA-1; Fri, 05 Apr 2024 06:38:14 -0400
X-MC-Unique: Vo3LerlkMOC_SyyWZ4cExA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-343bc1e4ef3so1105015f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313493; x=1712918293;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I0L4+tioaEa5Oez9lF/k2qN4oyGOYvytJdtMM+KNXgo=;
        b=p/En93BZkZc5d4K6MzXk/TYp77B4NY3nER4ebx0cmMlY+KLmQdMof2+wfRbF8pSfnv
         A9kWxD6LFLCfwnJ1cOMJUgjDNJxhj2REiCpBdSCjJSWnLcq///Az5jgwLfayM/6n4tvi
         yLQkJaGrsXJwnUB45KDS2NBRYqJEgLDBT/AsSivAVL+9NwsC0YyNjnEM1qMgxwpaD5ny
         FZWMVjP+F1w5n2G7ZZ5wPy80L48CEgFhW/7xWLcsUzanSJck9KEVhCTOti77d7nemHWZ
         Eu3oa6ZomU4rZt0LU4eXVGh6nLJNdGNvy9fSRv9XvUwWQlWqmegkvpUU/QXAJlddUj1Q
         j1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWvM9Hh5yZPubarbd/FUQJriQEDFgo3fcExVS3mx7URmc3XI/IH9XbYQDddBENalCgcb4XHOKlCoq6qTEDwLEZxwzJNyoPxPj9j8Tzv
X-Gm-Message-State: AOJu0YwrGnEvbjx9NYIEpuAHqrZAfwf+2SxXG+SA99Zmw9OwsDJk4ioT
	63qYN8u+GeWPStAaiyhOsWRsECQ6qqHJDS0dDp8h/ImoHG6vU19v8hiH9nsQMENjDjHwlH2LBfL
	wx7IQQFPasfrPUbOD7sPEaLQ2JXX/+9iYqcoeg3t6qkXFvqKs9Uk04Hajstagug==
X-Received: by 2002:a05:6000:dcd:b0:33e:777c:3899 with SMTP id dw13-20020a0560000dcd00b0033e777c3899mr883775wrb.38.1712313493167;
        Fri, 05 Apr 2024 03:38:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyfFTD3zwItr6aj2WiOUXsHcvRA8x7JictPcRE/VUTmPyzHDisD8P+Z29Zc6RCleXwMuNGaA==
X-Received: by 2002:a05:6000:dcd:b0:33e:777c:3899 with SMTP id dw13-20020a0560000dcd00b0033e777c3899mr883757wrb.38.1712313492634;
        Fri, 05 Apr 2024 03:38:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id f13-20020a5d64cd000000b00343e97150d6sm1149011wri.32.2024.04.05.03.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 03:38:11 -0700 (PDT)
Message-ID: <c7748c77-b2a3-4b06-aaeb-02793a160aaf@redhat.com>
Date: Fri, 5 Apr 2024 12:38:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] mm: swap: Allow storage of all mTHP orders
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-5-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403114032.1162100-5-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 13:40, Ryan Roberts wrote:
> Multi-size THP enables performance improvements by allocating large,
> pte-mapped folios for anonymous memory. However I've observed that on an
> arm64 system running a parallel workload (e.g. kernel compilation)
> across many cores, under high memory pressure, the speed regresses. This
> is due to bottlenecking on the increased number of TLBIs added due to
> all the extra folio splitting when the large folios are swapped out.
> 
> Therefore, solve this regression by adding support for swapping out mTHP
> without needing to split the folio, just like is already done for
> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
> and when the swap backing store is a non-rotating block device. These
> are the same constraints as for the existing PMD-sized THP swap-out
> support.
> 
> Note that no attempt is made to swap-in (m)THP here - this is still done
> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
> prerequisite for swapping-in mTHP.
> 
> The main change here is to improve the swap entry allocator so that it
> can allocate any power-of-2 number of contiguous entries between [1, (1
> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
> order and allocating sequentially from it until the cluster is full.
> This ensures that we don't need to search the map and we get no
> fragmentation due to alignment padding for different orders in the
> cluster. If there is no current cluster for a given order, we attempt to
> allocate a free cluster from the list. If there are no free clusters, we
> fail the allocation and the caller can fall back to splitting the folio
> and allocates individual entries (as per existing PMD-sized THP
> fallback).
> 
> The per-order current clusters are maintained per-cpu using the existing
> infrastructure. This is done to avoid interleving pages from different
> tasks, which would prevent IO being batched. This is already done for
> the order-0 allocations so we follow the same pattern.
> 
> As is done for order-0 per-cpu clusters, the scanner now can steal
> order-0 entries from any per-cpu-per-order reserved cluster. This
> ensures that when the swap file is getting full, space doesn't get tied
> up in the per-cpu reserves.
> 
> This change only modifies swap to be able to accept any order mTHP. It
> doesn't change the callers to elide doing the actual split. That will be
> done in separate changes.
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   include/linux/swap.h |  10 ++-
>   mm/swap_slots.c      |   6 +-
>   mm/swapfile.c        | 175 ++++++++++++++++++++++++-------------------
>   3 files changed, 109 insertions(+), 82 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 5e1e4f5bf0cb..11c53692f65f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -268,13 +268,19 @@ struct swap_cluster_info {
>    */
>   #define SWAP_NEXT_INVALID	0
>   
> +#ifdef CONFIG_THP_SWAP
> +#define SWAP_NR_ORDERS		(PMD_ORDER + 1)
> +#else
> +#define SWAP_NR_ORDERS		1
> +#endif
> +
>   /*
>    * We assign a cluster to each CPU, so each CPU can allocate swap entry from
>    * its own cluster and swapout sequentially. The purpose is to optimize swapout
>    * throughput.
>    */
>   struct percpu_cluster {
> -	unsigned int next; /* Likely next allocation offset */
> +	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>   };
>   
>   struct swap_cluster_list {
> @@ -471,7 +477,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio);
>   bool folio_free_swap(struct folio *folio);
>   void put_swap_folio(struct folio *folio, swp_entry_t entry);
>   extern swp_entry_t get_swap_page_of_type(int);
> -extern int get_swap_pages(int n, swp_entry_t swp_entries[], int entry_size);
> +extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>   extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>   extern void swap_shmem_alloc(swp_entry_t);
>   extern int swap_duplicate(swp_entry_t);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 53abeaf1371d..13ab3b771409 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -264,7 +264,7 @@ static int refill_swap_slots_cache(struct swap_slots_cache *cache)
>   	cache->cur = 0;
>   	if (swap_slot_cache_active)
>   		cache->nr = get_swap_pages(SWAP_SLOTS_CACHE_SIZE,
> -					   cache->slots, 1);
> +					   cache->slots, 0);
>   
>   	return cache->nr;
>   }
> @@ -311,7 +311,7 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
>   
>   	if (folio_test_large(folio)) {
>   		if (IS_ENABLED(CONFIG_THP_SWAP))
> -			get_swap_pages(1, &entry, folio_nr_pages(folio));
> +			get_swap_pages(1, &entry, folio_order(folio));

The only comment I have is that this nr_pages -> order conversion adds a 
bit of noise to this patch.

AFAIKS, it's primarily only required for "cluster->next[order]", 
everything else doesn't really require the order.

I'd just have split that out into a separate patch, or simply converted 
nr_pages -> order where required.

Nothing jumped at me, but I'm not an expert on that code, so I'm mostly 
trusting the others ;)

-- 
Cheers,

David / dhildenb


