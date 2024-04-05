Return-Path: <linux-kernel+bounces-132800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0A0899A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185431F2387F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0C16190D;
	Fri,  5 Apr 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFIkhBKM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47376161339
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311993; cv=none; b=hx8mxLXSNaYKPR+ox+K93MzyZURJjy0XqiYICxFC6Ew0zVPBa1s81SXiIxHJwyBkWR72/wXQ5vjXgKQO640WCN03QDi8a98NejxwRA6Vdy0OQRgRrMvxkbnGKWMatssSj3KefENPlJ9awa6GWIKXjrIaVSoo+dGZXhRbeJWgqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311993; c=relaxed/simple;
	bh=TKlwpOozPlfOGXkQIdKteiizSmSlJgPs64COgbLz3Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aaDuokfqTP2Rbic/z5Hhxlz85pe7zEMJBrV87sXvE8lQ9VCfjP68oUakV2EjOD1S/erTQ7RyVwd8/1IG5MoXQCpnuW9EcZlSPPzUdfTFUpiP3zhKBDWe1S2heDwXqjw5NULWN/k1i45NCbS/w7zH32bMFbCA1cGSnRf8MDA5BSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YFIkhBKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712311990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LuX9GQDXSZa7+su2x33O89pYvAmnIYP6bhbkQ4nuBwk=;
	b=YFIkhBKMflK5bnCwjeNzL8yoxMXiBjVW0/GL66KeE709XC7a0i4FrXa/+gmXqRG0x5YqmL
	5onptOsIAky7s0oF5DHUi1nJazb1jz74AD/ur00x/oAHhLJv8zM9hgN/3uC+pCUzhGl6Mi
	aS+z1sJxDOF59Cw3DWMuvsLV3OPUO1k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-HkaUqIKpNxifU1uifdM4nA-1; Fri, 05 Apr 2024 06:13:08 -0400
X-MC-Unique: HkaUqIKpNxifU1uifdM4nA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-41463be093aso9711555e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712311988; x=1712916788;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LuX9GQDXSZa7+su2x33O89pYvAmnIYP6bhbkQ4nuBwk=;
        b=fBmONYX545JyMXgDQ6cga9KiP67fJf8CZRrFBdfHUxhV9GZGH3tW15ohsZH830WrQA
         p8kQc2ml6kBu2LqpRd1vYsGQurqsgemJV4MtRDEsApT1ZOPYYFyaiLUQwsBSFeNaH+Y/
         8DozG2eKIeWcy3lEkQiLqUi/+jMiMrzTt19+GiQgFMmb2PC0tFiqSgfJrAVGtBEURr0u
         gPgCjP6ZHEuq47uI7g1eTs3zs1OYRgmlESSk+aWv29tUDFdos3xRDzDbgZNk7vUhzNX4
         0jSOZC82VZzaq+sLwlFokgcMK5MJvCr2j7O9W0KHCK6hQnkYpVn6F5e6tbKmnbQP1ImG
         +6ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpNptCcj2wKKoVJrCV1b4sEzjWmKXK0eW0DD5r7VBENdL6vV+MEbNQdoUPpgKAbE+N8mQg6tULURM5Y0Nmkngd00+ykcuc2REw7JWF
X-Gm-Message-State: AOJu0Yyd0XgfYDe3qXt+A/MLaFuUZBPonmzEtjd0XHt8+UpL6d/0VW/f
	GCKJXVpheSlNOISfgaBInCEjlydKWLmfzy4ZaZGeAngw03dJRCNgaEKcMjRXTVAn2FZ6ZTH4f8X
	K/1NHgTCbVRGWqhA22EehoZWiY2aCodZAiUpAhIQaaa486XTW82vM1jGJLx04nQ==
X-Received: by 2002:a05:600c:4714:b0:415:52e2:64b2 with SMTP id v20-20020a05600c471400b0041552e264b2mr849235wmo.6.1712311987618;
        Fri, 05 Apr 2024 03:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvoE+KA0ZVUHCZ1ys5NzQIxuDoTAZNXlQ5SffMRkJjf1+nhvf7GApar/cLoYrlrhUmfcn3kg==
X-Received: by 2002:a05:600c:4714:b0:415:52e2:64b2 with SMTP id v20-20020a05600c471400b0041552e264b2mr849206wmo.6.1712311987133;
        Fri, 05 Apr 2024 03:13:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id m32-20020a05600c3b2000b004154e48bcdesm5923609wms.14.2024.04.05.03.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 03:13:06 -0700 (PDT)
Message-ID: <051052af-3b56-4290-98d3-fd5a1eb11ce1@redhat.com>
Date: Fri, 5 Apr 2024 12:13:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-3-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240403114032.1162100-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.24 13:40, Ryan Roberts wrote:
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
>   include/linux/pgtable.h | 28 ++++++++++++++
>   include/linux/swap.h    | 12 ++++--
>   mm/internal.h           | 48 +++++++++++++++++++++++
>   mm/madvise.c            | 12 ++++--
>   mm/memory.c             | 13 ++++---
>   mm/swapfile.c           | 86 ++++++++++++++++++++++++++++++++---------
>   6 files changed, 167 insertions(+), 32 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index a3fc8150b047..0278259f7078 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -708,6 +708,34 @@ static inline void pte_clear_not_present_full(struct mm_struct *mm,
>   }
>   #endif
>   
> +#ifndef clear_not_present_full_ptes
> +/**
> + * clear_not_present_full_ptes - Clear consecutive not present PTEs.


Consecutive only in the page table or also in some other sense?

I suspect: just unrelated non-present entries of any kind (swp, nonswp) 
and any offset/pfn.

Consider document that.

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
>   #ifndef __HAVE_ARCH_PTEP_CLEAR_FLUSH
>   extern pte_t ptep_clear_flush(struct vm_area_struct *vma,
>   			      unsigned long address,
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6f78198f000..5737236dc3ce 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -471,7 +471,7 @@ extern int swap_duplicate(swp_entry_t);
>   extern int swapcache_prepare(swp_entry_t);
>   extern void swap_free(swp_entry_t);
>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
> -extern int free_swap_and_cache(swp_entry_t);
> +extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>   int swap_type_of(dev_t device, sector_t offset);
>   int find_first_swap(dev_t *device);
>   extern unsigned int count_swap_pages(int, int);
> @@ -520,8 +520,9 @@ static inline void put_swap_device(struct swap_info_struct *si)
>   #define free_pages_and_swap_cache(pages, nr) \
>   	release_pages((pages), (nr));
>   


[...]

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

Likely you should document that any swp pte bits are ignored? ()

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

Looks very clean :)

I was wondering whether we could similarly construct the expected swp 
PTE and only check pte_same.

expected_pte = __swp_entry_to_pte(__swp_entry(expected_type, 
expected_offset));

.. or have a variant to increase only the swp offset for an existing 
pte. But non-trivial due to the arch-dependent format.

But then, we'd fail on mismatch of other swp pte bits.


On swapin, when reusing this function (likely!), we'll might to make 
sure that the PTE bits match as well.

See below regarding uffd-wp.


>   #endif /* CONFIG_MMU */
>   
>   void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 1f77a51baaac..070bedb4996e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>   	struct folio *folio;
>   	int nr_swap = 0;
>   	unsigned long next;
> +	int nr, max_nr;
>   
>   	next = pmd_addr_end(addr, end);
>   	if (pmd_trans_huge(*pmd))
> @@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>   		return 0;
>   	flush_tlb_batched_pending(mm);
>   	arch_enter_lazy_mmu_mode();
> -	for (; addr != end; pte++, addr += PAGE_SIZE) {
> +	for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
> +		nr = 1;
>   		ptent = ptep_get(pte);
>   
>   		if (pte_none(ptent))
> @@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>   
>   			entry = pte_to_swp_entry(ptent);
>   			if (!non_swap_entry(entry)) {
> -				nr_swap--;
> -				free_swap_and_cache(entry);
> -				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> +				max_nr = (end - addr) / PAGE_SIZE;
> +				nr = swap_pte_batch(pte, max_nr, entry);
> +				nr_swap -= nr;
> +				free_swap_and_cache_nr(entry, nr);
> +				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>   			} else if (is_hwpoison_entry(entry) ||
>   				   is_poisoned_swp_entry(entry)) {
>   				pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> diff --git a/mm/memory.c b/mm/memory.c
> index 7dc6c3d9fa83..ef2968894718 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1637,12 +1637,13 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   				folio_remove_rmap_pte(folio, page, vma);
>   			folio_put(folio);
>   		} else if (!non_swap_entry(entry)) {
> -			/* Genuine swap entry, hence a private anon page */
> +			max_nr = (end - addr) / PAGE_SIZE;
> +			nr = swap_pte_batch(pte, max_nr, entry);
> +			/* Genuine swap entries, hence a private anon pages */
>   			if (!should_zap_cows(details))
>   				continue;
> -			rss[MM_SWAPENTS]--;
> -			if (unlikely(!free_swap_and_cache(entry)))
> -				print_bad_pte(vma, addr, ptent, NULL);
> +			rss[MM_SWAPENTS] -= nr;
> +			free_swap_and_cache_nr(entry, nr);
>   		} else if (is_migration_entry(entry)) {
>   			folio = pfn_swap_entry_folio(entry);
>   			if (!should_zap_folio(details, folio))
> @@ -1665,8 +1666,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>   			pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>   			WARN_ON_ONCE(1);
>   		}
> -		pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
> -		zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
> +		clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);

For zap_install_uffd_wp_if_needed(), the uffd-wp bit has to match.

zap_install_uffd_wp_if_needed() will use the uffd-wp information in 
ptent->pteval to make a decision whether to place PTE_MARKER_UFFD_WP 
markers.

On mixture, you either lose some or place too many markers.

A simple workaround would be to disable any such batching if the VMA 
does have uffd-wp enabled.

> +		zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
>   	} while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
>   
>   	add_mm_rss_vec(mm, rss);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0d44ee2b4f9c..d059de6896c1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -130,7 +130,11 @@ static inline unsigned char swap_count(unsigned char ent)
>   /* Reclaim the swap entry if swap is getting full*/
>   #define TTRS_FULL		0x4
>   
> -/* returns 1 if swap entry is freed */
> +/*
> + * returns number of pages in the folio that backs the swap entry. If positive,
> + * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
> + * folio was associated with the swap entry.
> + */
>   static int __try_to_reclaim_swap(struct swap_info_struct *si,
>   				 unsigned long offset, unsigned long flags)
>   {
> @@ -155,6 +159,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
>   			ret = folio_free_swap(folio);
>   		folio_unlock(folio);
>   	}
> +	ret = ret ? folio_nr_pages(folio) : -folio_nr_pages(folio);
>   	folio_put(folio);
>   	return ret;
>   }
> @@ -895,7 +900,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
>   		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
>   		spin_lock(&si->lock);
>   		/* entry was freed successfully, try to use this again */
> -		if (swap_was_freed)
> +		if (swap_was_freed > 0)
>   			goto checks;
>   		goto scan; /* check next one */
>   	}
> @@ -1572,32 +1577,75 @@ bool folio_free_swap(struct folio *folio)
>   	return true;
>   }
>   
> -/*
> - * Free the swap entry like above, but also try to
> - * free the page cache entry if it is the last user.
> - */
> -int free_swap_and_cache(swp_entry_t entry)

Can we have some documentation what this function expects? How does nr 
relate to entry?

i.e., offset range defined by [entry.offset, entry.offset + nr).

> +void free_swap_and_cache_nr(swp_entry_t entry, int nr)
>   {
> -	struct swap_info_struct *p;

It might be easier to get if you do

const unsigned long start_offset = swp_offset(entry);
const unsigned long end_offset = start_offset + nr;

> +	unsigned long end = swp_offset(entry) + nr;
> +	unsigned int type = swp_type(entry);
> +	struct swap_info_struct *si;
> +	bool any_only_cache = false;
> +	unsigned long offset;
>   	unsigned char count;
>   
>   	if (non_swap_entry(entry))
> -		return 1;
> +		return;
>   
> -	p = get_swap_device(entry);
> -	if (p) {
> -		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
> -			put_swap_device(p);
> -			return 0;
> +	si = get_swap_device(entry);
> +	if (!si)
> +		return;
> +
> +	if (WARN_ON(end > si->max))
> +		goto out;
> +
> +	/*
> +	 * First free all entries in the range.
> +	 */
> +	for (offset = swp_offset(entry); offset < end; offset++) {
> +		if (!WARN_ON(data_race(!si->swap_map[offset]))) {

Ouch "!(!)). Confusing.

I'm sure there is a better way to write that, maybe using more lines

if (data_race(si->swap_map[offset])) {
	...
} else {
	WARN_ON_ONCE(1);
}


> +			count = __swap_entry_free(si, swp_entry(type, offset));
> +			if (count == SWAP_HAS_CACHE)
> +				any_only_cache = true;
>   		}
> +	}
> +
> +	/*
> +	 * Short-circuit the below loop if none of the entries had their
> +	 * reference drop to zero.
> +	 */
> +	if (!any_only_cache)
> +		goto out;
>   
> -		count = __swap_entry_free(p, entry);
> -		if (count == SWAP_HAS_CACHE)
> -			__try_to_reclaim_swap(p, swp_offset(entry),
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

Here we use READ_ONCE() only, above data_race(). Hmmm.

> +			/*
> +			 * Folios are always naturally aligned in swap so
> +			 * advance forward to the next boundary. Zero means no
> +			 * folio was found for the swap entry, so advance by 1
> +			 * in this case. Negative value means folio was found
> +			 * but could not be reclaimed. Here we can still advance
> +			 * to the next boundary.
> +			 */
> +			nr = __try_to_reclaim_swap(si, offset,
>   					      TTRS_UNMAPPED | TTRS_FULL);
> -		put_swap_device(p);
> +			if (nr == 0)
> +				nr = 1;
> +			else if (nr < 0)
> +				nr = -nr;
> +			nr = ALIGN(offset + 1, nr) - offset;
> +		}

Apart from that nothing jumped at me.

-- 
Cheers,

David / dhildenb


