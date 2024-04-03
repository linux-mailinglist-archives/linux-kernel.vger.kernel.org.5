Return-Path: <linux-kernel+bounces-130205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF089755E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F5728C122
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F82150980;
	Wed,  3 Apr 2024 16:38:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777150A60
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162294; cv=none; b=m2KvqmvmGubq5hmYhfXDm9AovcBVG/PHIUikPuvVTpJOOCNv0gBj4sHAPAmeLXfn1as2Sv752XdIqYX55Kqv81GCT8SLvBaJQa5/zgcTkUYhgDgYctGlPpu0pLIozBy60ipuUmaA6lM87EqBYSIEfjcAfohd/XjfBM69ReJ4YAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162294; c=relaxed/simple;
	bh=0uBvKsUXSPr3DSXxjUljvz/Au+xN1WNZFImPxCAyrsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzAk8ygXNJ/CmYonLCeWW8v1a/RaYS9VY1kHNPV80gk6UkWh3OWlADlPLLSycgYsf7nL8wVG8TR+h8tWkjL9krDe56X2UKw7QRc54b0RobTf6+e23DEtxrcuwFVuZ6JP9r0kk52PzqBnbCgaM81M6bBmqq04LBYDSVchIzFVmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B1321007;
	Wed,  3 Apr 2024 09:38:42 -0700 (PDT)
Received: from [10.57.72.245] (unknown [10.57.72.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F80F3F7B4;
	Wed,  3 Apr 2024 09:38:09 -0700 (PDT)
Message-ID: <0793c3d9-589b-4550-a556-9a4fa5a6cec2@arm.com>
Date: Wed, 3 Apr 2024 17:38:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm/madvise: introduce mkold_clean_ptes() batch
 helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: zokeefe@google.com, 21cnbao@gmail.com, shy828301@gmail.com,
 david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240402124029.47846-1-ioworker0@gmail.com>
 <20240402124029.47846-2-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240402124029.47846-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/04/2024 13:40, Lance Yang wrote:
> Change the code that clears young and dirty bits from the PTEs to use
> ptep_get_and_clear_full() and set_pte_at(), via the new mkold_clean_ptes()
> batch helper function.
> 
> Unfortunately, the per-pte get_and_clear/modify/set approach would result
> in unfolding/refolding for contpte mappings on arm64. So we need to
> override mkold_clean_ptes() for arm64 to avoid it.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 10 +++++++++
>  include/linux/pgtable.h          | 30 ++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)

When I suggested splitting out this patch, this wasn't quite what I meant.
Instead I intended for the first patch to make the MADV_FREE change and as part
of that introduce mkold_clean_ptes() with a generic implementation. Then a
second patch would do the arm64-specific specialization of mkold_clean_ptes()
for an arm64-specific performance boost. In general it is often useful to
separate core changes from arch changes where practical since they have
different target audiences.


> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9fd8613b2db2..b032c107090c 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1086,6 +1086,27 @@ static inline bool pud_user_accessible_page(pud_t pud)
>  }
>  #endif
>  
> +static inline void __mkold_clean_pte(struct vm_area_struct *vma,
> +				    unsigned long addr, pte_t *ptep)
> +{
> +	pte_t old_pte, pte;
> +
> +	pte = __ptep_get(ptep);
> +	do {
> +		old_pte = pte;
> +		pte = pte_mkclean(pte_mkold(pte));
> +		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
> +					       pte_val(old_pte), pte_val(pte));
> +	} while (pte_val(pte) != pte_val(old_pte));
> +}

I'm not sure how value it is to split this out, given we are only exposing a
batched version to the core. Perhaps just include the body in mkold_clean_ptes()?

> +
> +static inline void mkold_clean_ptes(struct vm_area_struct *vma,
> +				    unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	for (; nr-- > 0; ptep++, addr += PAGE_SIZE)
> +		__mkold_clean_pte(vma, addr, ptep);
> +}
> +
>  /*
>   * Atomic pte/pmd modifications.
>   */
> @@ -1379,6 +1400,8 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
> +extern void contpte_ptep_mkold_clean(struct vm_area_struct *vma,
> +				unsigned long addr, pte_t *ptep);

Let's have this follow the same naming pattern; contpte_mkold_clean_ptes()

>  
>  static __always_inline void contpte_try_fold(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep, pte_t pte)
> @@ -1603,6 +1626,18 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>  }
>  
> +#define mkold_clean_ptes mkold_clean_ptes
> +static inline void mkold_clean_ptes(struct vm_area_struct *vma,
> +				    unsigned long addr, pte_t *ptep, unsigned int nr, int full)
> +{
> +	pte_t orig_pte = __ptep_get(ptep);
> +
> +	if (likely(!pte_valid_cont(orig_pte)))
> +		return __mkold_clean_ptes(vma, addr, ptep, nr, full);
> +
> +	return contpte_ptep_mkold_clean(vma, addr, ptep);> +}

This function is totally broken as far as I can tell. You are assuming if the
first pte is not cont, then the whole range is not cont; you can't assume that.
Then if you decide it is cont, you ignore nr and only fixup a single contpte block.

Take a look at wrprotect_ptes() or another one of the batched helpers and follow
that pattern.

> +
>  #else /* CONFIG_ARM64_CONTPTE */
>  
>  #define ptep_get				__ptep_get
> @@ -1622,6 +1657,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  #define wrprotect_ptes				__wrprotect_ptes
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  #define ptep_set_access_flags			__ptep_set_access_flags
> +#define mkold_clean_ptes			__mkold_clean_ptes
>  
>  #endif /* CONFIG_ARM64_CONTPTE */
>  
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 1b64b4c3f8bf..560622cfb2a9 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -322,6 +322,16 @@ int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL_GPL(contpte_ptep_test_and_clear_young);
>  
> +void contpte_ptep_mkold_clean(struct vm_area_struct *vma, unsigned long addr,
> +			      pte_t *ptep)
> +{
> +	ptep = contpte_align_down(ptep);
> +	addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +
> +	__mkold_clean_ptes(vma, addr, ptep, CONT_PTES, 0);

As above, this is broken as is.

> +}
> +EXPORT_SYMBOL_GPL(contpte_ptep_mkold_clean);
> +
>  int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index fa8f92f6e2d7..fd30779fe487 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -391,6 +391,36 @@ static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
>  }
>  #endif
>  
> +#ifndef mkold_clean_ptes
> +/**
> + * mkold_clean_ptes - Mark PTEs that map consecutive pages of the same folio
> + *		as old and clean.
> + * @vma: VMA the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to mark old and clean.
> + *
> + * May be overridden by the architecture; otherwise, implemented as a simple
> + * loop over ptep_get_and_clear_full().

How about "otherwise, implemented by get_and_clear/modify/set for each pte in
the range."?

> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void mkold_clean_ptes(struct vm_area_struct *vma,
> +				    unsigned long addr, pte_t *ptep, unsigned int nr, int full)

You've included the "full" param in the function but not in the docs. I don't
think the full param is valuable though; it doesn't make sense to call this
function when tearing down a process. So drop the parameter and just call
ptep_get_and_clear().

> +{
> +	pte_t pte;
> +
> +	for (; nr-- > 0; ptep++, addr += PAGE_SIZE) {

nit: This is using a different pattern to all the other batch helpers
(set_ptes(), wrprotect_ptes() clear_full_ptes()).

> +		pte = ptep_get_and_clear_full(vma->vm_mm, addr, ptep, full);
> +		set_pte_at(vma->vm_mm, addr, ptep, pte_mkclean(pte_mkold(pte)));
> +	}
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,


