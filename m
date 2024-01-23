Return-Path: <linux-kernel+bounces-35448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352FF839156
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B112E1F24263
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D765FB86;
	Tue, 23 Jan 2024 14:28:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294D25FB80;
	Tue, 23 Jan 2024 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706020083; cv=none; b=lV1lcfYP/W4Udz/G8FXih6G4faawEESov2w1FJOyUsB504HbjQG6C/unQWEHUj204rT6dnMW42mVaE2m+UzZnULDrwHKy1PAmZ4uLkGAMoZ/X/XUnMkx/IdZj7jqTFJ1ynNZ8BI0PeyIQ3rcmaESTPEYhsC2hTO4E+BjJVHX+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706020083; c=relaxed/simple;
	bh=n5Sxb3m5EKoKEa7DWkAuvTEXkevzHLo3B9dfQYIGHNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUhj+LKDhhLRDM7wH7L9NLgSZU6R9sutaSEy3KsUhGEv6X4UAj+ipc5aCnJkA7+HX3qH97OOgmZfux5MpfcJaMwMpyL78MaoTo0ppg3Dnb/Ykl6Wg76D3Kmd9L99ZWWd1g0LafDjUpDCq2Ga7TNVYOSXhgGTuZaYL6bKpKkmuvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B78CB1FB;
	Tue, 23 Jan 2024 06:28:45 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 707653F762;
	Tue, 23 Jan 2024 06:27:56 -0800 (PST)
Message-ID: <7db13538-20b9-4c12-b333-d197c4b2846d@arm.com>
Date: Tue, 23 Jan 2024 14:27:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/11] mm/memory: ignore dirty/accessed/soft-dirty bits
 in folio_pte_batch()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240122194200.381241-1-david@redhat.com>
 <20240122194200.381241-11-david@redhat.com>
 <59592b50-fe89-4b32-8490-2e6c296f972f@arm.com>
 <76740e33-9b52-4e23-b407-8ae38bac15ec@redhat.com>
 <94d33a07-c59a-4315-9c64-8b4d959ca1f4@arm.com>
 <c92c2460-c66a-46c7-b84f-0732965dcf73@redhat.com>
 <8eb5db8e-33cc-4cbf-a1bf-0da7af230fab@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8eb5db8e-33cc-4cbf-a1bf-0da7af230fab@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 14:13, David Hildenbrand wrote:
>>> Although now I'm wondering if there is a race here... What happens if a page in
>>> the parent becomes dirty after you have checked it but before you write protect
>>> it? Isn't that already a problem with the current non-batched version? Why do we
>>> even to preserve dirty in the child for private mappings?
>>
>> I suspect, because the parent could zap the anon folio. If the folio is
>> clean, but the PTE dirty, I suspect that we could lose data of the child
>> if we were to evict that clean folio (swapout).
>>
>> So I assume we simply copy the dirty PTE bit, so the system knows that
>> that folio is actually dirty, because one PTE is dirty.
> 
> Oh, and regarding your race concern: it's undefined which page state
> would see if some write is racing with fork, so it also doesn't matter
> if we would copy the PTE dirty bit or not, if it gets set in a racy fashion.

Ahh that makes sense. Thanks.

> 
> I'll not experiment with:

Looks good as long as its still performant.

> 
> From 14e83ff2a422a96ce5701f9c8454a49f9ed947e3 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Sat, 30 Dec 2023 12:54:35 +0100
> Subject: [PATCH] mm/memory: ignore dirty/accessed/soft-dirty bits in
>  folio_pte_batch()
> 
> Let's always ignore the accessed/young bit: we'll always mark the PTE
> as old in our child process during fork, and upcoming users will
> similarly not care.
> 
> Ignore the dirty bit only if we don't want to duplicate the dirty bit
> into the child process during fork. Maybe, we could just set all PTEs
> in the child dirty if any PTE is dirty. For now, let's keep the behavior
> unchanged.
> 
> Ignore the soft-dirty bit only if the bit doesn't have any meaning in
> the src vma.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 7690994929d26..9aba1b0e871ca 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -953,24 +953,44 @@ static __always_inline void __copy_present_ptes(struct
> vm_area_struct *dst_vma,
>      set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>  }
>  
> +/* Flags for folio_pte_batch(). */
> +typedef int __bitwise fpb_t;
> +
> +/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
> +#define FPB_IGNORE_DIRTY        ((__force fpb_t)BIT(0))
> +
> +/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
> +#define FPB_IGNORE_SOFT_DIRTY        ((__force fpb_t)BIT(1))
> +
> +static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
> +{
> +    if (flags & FPB_IGNORE_DIRTY)
> +        pte = pte_mkclean(pte);
> +    if (likely(flags & FPB_IGNORE_SOFT_DIRTY))
> +        pte = pte_clear_soft_dirty(pte);
> +    return pte_mkold(pte);
> +}
> +
>  /*
>   * Detect a PTE batch: consecutive (present) PTEs that map consecutive
>   * pages of the same folio.
>   *
>   * All PTEs inside a PTE batch have the same PTE bits set, excluding the PFN.
> + * the accessed bit, dirty bit (with FPB_IGNORE_DIRTY) and soft-dirty bit
> + * (with FPB_IGNORE_SOFT_DIRTY).
>   */
>  static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
> -        pte_t *start_ptep, pte_t pte, int max_nr)
> +        pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags)
>  {
>      unsigned long folio_end_pfn = folio_pfn(folio) + folio_nr_pages(folio);
>      const pte_t *end_ptep = start_ptep + max_nr;
> -    pte_t expected_pte = pte_next_pfn(pte);
> +    pte_t expected_pte = __pte_batch_clear_ignored(pte_next_pfn(pte), flags);
>      pte_t *ptep = start_ptep + 1;
>  
>      VM_WARN_ON_FOLIO(!pte_present(pte), folio);
>  
>      while (ptep != end_ptep) {
> -        pte = ptep_get(ptep);
> +        pte = __pte_batch_clear_ignored(ptep_get(ptep), flags);
>  
>          if (!pte_same(pte, expected_pte))
>              break;
> @@ -1004,6 +1024,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct
> vm_area_struct *src_vma
>  {
>      struct page *page;
>      struct folio *folio;
> +    fpb_t flags = 0;
>      int err, nr;
>  
>      page = vm_normal_page(src_vma, addr, pte);
> @@ -1018,7 +1039,12 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct
> vm_area_struct *src_vma
>       * by keeping the batching logic separate.
>       */
>      if (unlikely(!*prealloc && folio_test_large(folio) && max_nr != 1)) {
> -        nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr);
> +        if (src_vma->vm_flags & VM_SHARED)
> +            flags |= FPB_IGNORE_DIRTY;
> +        if (!vma_soft_dirty_enabled(src_vma))
> +            flags |= FPB_IGNORE_SOFT_DIRTY;
> +
> +        nr = folio_pte_batch(folio, addr, src_pte, pte, max_nr, flags);
>          folio_ref_add(folio, nr);
>          if (folio_test_anon(folio)) {
>              if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,


