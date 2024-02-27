Return-Path: <linux-kernel+bounces-82947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316B868C10
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC101C2040B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4E6136646;
	Tue, 27 Feb 2024 09:20:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723CB135A6E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025623; cv=none; b=vDGkrYT4LPmUn0aOCynxCTQhxhGAOEhONXMLMJch43FNyWzkCZSbcIbdbMuhRHWeX5Eg89nYYjJ7Eywis0dv6GLZMxJwXNcGzj6fXMvfUm67aITQZEj0JPtSTh/h4UXqJC7OnCDAuPWgRutwSfpSfG1N9BwJoRSTSOx4Y7bIprY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025623; c=relaxed/simple;
	bh=oB9w23lzQaXPWqAv3hlyO3XSewGD1nXDKFxZM6b+2cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQhDXoBhciLGUt3+unZZFmcz3IopHAYs2tpEykYqUWv2AZzuncV/0FhPevd/I1Y16632/gh4YsupEg6/a8xx66wYv0U9YER18Y5M+6v6C6mkAgzsTJSvZXXoB9cG6MHhE31/HP02VXTKCehDP0bIvdD5fcJpuUR06mlGK7d58Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39A40DA7;
	Tue, 27 Feb 2024 01:20:59 -0800 (PST)
Received: from [10.57.67.4] (unknown [10.57.67.4])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A75833F762;
	Tue, 27 Feb 2024 01:20:18 -0800 (PST)
Message-ID: <74958d41-6d73-4f5a-aae7-33dc374b6ddb@arm.com>
Date: Tue, 27 Feb 2024 09:20:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: export folio_pte_batch as a couple of modules might
 need it
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Barry Song <21cnbao@gmail.com>,
 akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Lance Yang <ioworker0@gmail.com>, Yin Fengwei <fengwei.yin@intel.com>
References: <20240227024050.244567-1-21cnbao@gmail.com>
 <61b9dfc9-5522-44fd-89a4-140833ede8af@arm.com>
 <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <c95215b2-6ec5-4efb-a73b-7be92cda1c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/02/2024 09:14, David Hildenbrand wrote:
> On 27.02.24 10:07, Ryan Roberts wrote:
>> On 27/02/2024 02:40, Barry Song wrote:
>>> From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> madvise and some others might need folio_pte_batch to check if a range
>>> of PTEs are completely mapped to a large folio with contiguous physcial
>>> addresses. Let's export it for others to use.
>>>
>>> Cc: Lance Yang <ioworker0@gmail.com>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>>   -v1:
>>>   at least two jobs madv_free and madv_pageout depend on it. To avoid
>>>   conflicts and dependencies, after discussing with Lance, we prefer
>>>   this one can land earlier.
>>
>> I think this will also ultimately be useful for mprotect too, though I haven't
>> looked at it properly yet.
>>
> 
> Yes, I think we briefly discussed that.
> 
>>>
>>>   mm/internal.h | 13 +++++++++++++
>>>   mm/memory.c   | 11 +----------
>>>   2 files changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index 13b59d384845..8e2bc304f671 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
>>>       return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
>>>   }
>>>   +/* Flags for folio_pte_batch(). */
>>> +typedef int __bitwise fpb_t;
>>> +
>>> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>>> +#define FPB_IGNORE_DIRTY        ((__force fpb_t)BIT(0))
>>> +
>>> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>>> +#define FPB_IGNORE_SOFT_DIRTY        ((__force fpb_t)BIT(1))
>>> +
>>> +extern int folio_pte_batch(struct folio *folio, unsigned long addr,
>>> +        pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
>>> +        bool *any_writable);
>>> +
>>>   void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>>                           int nr_throttled);
>>>   static inline void acct_reclaim_writeback(struct folio *folio)
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 1c45b6a42a1b..319b3be05e75 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct
>>> vm_area_struct *dst_vma,
>>>       set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>>>   }
>>>   -/* Flags for folio_pte_batch(). */
>>> -typedef int __bitwise fpb_t;
>>> -
>>> -/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
>>> -#define FPB_IGNORE_DIRTY        ((__force fpb_t)BIT(0))
>>> -
>>> -/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
>>> -#define FPB_IGNORE_SOFT_DIRTY        ((__force fpb_t)BIT(1))
>>> -
>>>   static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
>>>   {
>>>       if (flags & FPB_IGNORE_DIRTY)
>>> @@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte,
>>> fpb_t flags)
>>>    * If "any_writable" is set, it will indicate if any other PTE besides the
>>>    * first (given) PTE is writable.
>>>    */
>>
>> David was talking in Lance's patch thread, about improving the docs for this
>> function now that its exported. Might be worth syncing on that.
> 
> Here is my take:
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d0b855a1837a8..098356b8805ae 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -971,16 +971,28 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte,
> fpb_t flags)
>      return pte_wrprotect(pte_mkold(pte));
>  }
>  
> -/*
> +/**
> + * folio_pte_batch - detect a PTE batch for a large folio
> + * @folio: The large folio to detect a PTE batch for.
> + * @addr: The user virtual address the first page is mapped at.
> + * @start_ptep: Page table pointer for the first entry.
> + * @pte: Page table entry for the first page.
> + * @max_nr: The maximum number of table entries to consider.
> + * @flags: Flags to modify the PTE batch semantics.
> + * @any_writable: Optional pointer to indicate whether any entry except the
> + *          first one is writable.
> + *
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
> - * pages of the same folio.
> + * pages of the same large folio.
>   *
>   * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN,
>   * the accessed bit, writable bit, dirty bit (with FPB_IGNORE_DIRTY) and
>   * soft-dirty bit (with FPB_IGNORE_SOFT_DIRTY).
>   *
> - * If "any_writable" is set, it will indicate if any other PTE besides the
> - * first (given) PTE is writable.
> + * start_ptep must map any page of the folio. max_nr must be at least one and
> + * must be limited by the caller so scanning cannot exceed a single page table.
> + *
> + * Return: the number of table entries in the batch.
>   */

LGTM!

>  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
>          pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
> @@ -996,6 +1008,8 @@ static inline int folio_pte_batch(struct folio *folio,
> unsigned long addr,
>          *any_writable = false;
>  
>      VM_WARN_ON_FOLIO(!pte_present(pte), folio);
> +    VM_WARN_ON_FOLIO(!folio_test_large(folio) || max_nr < 1, folio);
> +    VM_WARN_ON_FOLIO(page_folio(pfn_to_page(pte_pfn(pte))) != folio, folio);
>  
>      nr = pte_batch_hint(start_ptep, pte);
>      expected_pte = __pte_batch_clear_ignored(pte_advance_pfn(pte, nr), flags);


