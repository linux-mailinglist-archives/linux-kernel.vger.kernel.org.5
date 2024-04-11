Return-Path: <linux-kernel+bounces-140490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2938A1561
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67702825F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F97928FD;
	Thu, 11 Apr 2024 13:17:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE21EB26
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841474; cv=none; b=ihc8BJMSimwpluOCvToYu3s+deFlxNIdgzvDZlOyBAAhGvKSV+1OArTRprS5lGSdfSPi99HDWnDqHP9E//vJdcnv6MvQOVuP3c5XyxMJdhFjGNMxtfyTVZBRk5Jwed+70cLoe+iZZ91HGDMqz3O38AgVnwnvkxgpDGFTC2fGUBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841474; c=relaxed/simple;
	bh=4d0sgpuZnJjBfbJ/z/bu2/P8v4xruSiwB3QqaLvAsis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuKG4nQmfbHgJsZELvzpxX6lLZlBzVNTi18SkT/tcSOv7wj119eG3JfMBa0RMX4c0ZsyTQGBFcJJ7Bf7WvA4c2OgGUKObutCFRL7bDTOO+w0OQVFV46avrwygfIUJAzTNNwkP3YF7bl891ubeduFgc1o/9jiMDXHoIWVla26hE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 842E9113E;
	Thu, 11 Apr 2024 06:18:21 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 349F13F64C;
	Thu, 11 Apr 2024 06:17:50 -0700 (PDT)
Message-ID: <3cd1036d-3814-4a10-b6d2-099937ceabc8@arm.com>
Date: Thu, 11 Apr 2024 14:17:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] mm/arm64: override mkold_clean_ptes() batch helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240408042437.10951-1-ioworker0@gmail.com>
 <20240408042437.10951-3-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240408042437.10951-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 05:24, Lance Yang wrote:
> The per-pte get_and_clear/modify/set approach would result in
> unfolding/refolding for contpte mappings on arm64. So we need
> to override mkold_clean_ptes() for arm64 to avoid it.

IIRC, in the last version, I suggested copying the wrprotect_ptes() pattern to
correctly iterate over contpte blocks. I meant for you to take it as inspiration
but looks like you have done a carbon copy, including lots of things that are
unneeded here. That's my fault for not being clear - sorry!


> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 55 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 15 +++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9fd8613b2db2..395754638a9a 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1223,6 +1223,34 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
>  		__ptep_set_wrprotect(mm, address, ptep);
>  }
>  
> +static inline void ___ptep_mkold_clean(struct mm_struct *mm, unsigned long addr,
> +				       pte_t *ptep, pte_t pte)
> +{
> +	pte_t old_pte;
> +
> +	do {
> +		old_pte = pte;
> +		pte = pte_mkclean(pte_mkold(pte));
> +		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
> +					       pte_val(old_pte), pte_val(pte));
> +	} while (pte_val(pte) != pte_val(old_pte));
> +}

Given you are clearing old and dirty, you have nothing to race against, so you
shouldn't need the cmpxchg loop here; just a get/modify/set should do? Of course
if you are setting one or the other, then you need the loop.

> +
> +static inline void __ptep_mkold_clean(struct mm_struct *mm, unsigned long addr,
> +				      pte_t *ptep)
> +{
> +	___ptep_mkold_clean(mm, addr, ptep, __ptep_get(ptep));
> +}

I don't see a need for this intermediate function.

> +
> +static inline void __mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
> +				      pte_t *ptep, unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < nr; i++, addr += PAGE_SIZE, ptep++)

It would probably be good to use the for() loop pattern used by the generic
impls here too.

> +		__ptep_mkold_clean(mm, addr, ptep);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> @@ -1379,6 +1407,8 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
> +extern void contpte_mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr);
>  
>  static __always_inline void contpte_try_fold(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep, pte_t pte)
> @@ -1603,6 +1633,30 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>  }
>  
> +#define mkold_clean_ptes mkold_clean_ptes
> +static inline void mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
> +				    pte_t *ptep, unsigned int nr)
> +{
> +	if (likely(nr == 1)) {
> +		/*
> +		 * Optimization: mkold_clean_ptes() can only be called for present
> +		 * ptes so we only need to check contig bit as condition for unfold,
> +		 * and we can remove the contig bit from the pte we read to avoid
> +		 * re-reading. This speeds up madvise(MADV_FREE) which is sensitive
> +		 * for order-0 folios. Equivalent to contpte_try_unfold().
> +		 */

Is this true? Do you have data that shows the cost? If not, I'd prefer to avoid
the optimization and do it the more standard way:

contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));

> +		pte_t orig_pte = __ptep_get(ptep);
> +
> +		if (unlikely(pte_cont(orig_pte))) {
> +			__contpte_try_unfold(mm, addr, ptep, orig_pte);
> +			orig_pte = pte_mknoncont(orig_pte);
> +		}
> +		___ptep_mkold_clean(mm, addr, ptep, orig_pte);
> +	} else {
> +		contpte_mkold_clean_ptes(mm, addr, ptep, nr);
> +	}

..but I don't think you should ever need to unfold in the first place. Even if
it's folded and you are trying to clear access/dirty for a single pte, you can
just clear the whole block. See existing comment in
contpte_ptep_test_and_clear_young().

So this ends up as something like:

static inline void clear_young_dirty_ptes(struct mm_struct *mm,
			unsigned long addr, pte_t *ptep, unsigned int nr,
			bool clear_young, bool clear_dirty)
{
	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
		clear_young_dirty_ptes(mm, addr, ptep, nr,
					clear_young, clear_dirty);
	else
		contpte_clear_young_dirty_ptes(mm, addr, ptep, nr,
					clear_young, clear_dirty);
}


> +}
> +
>  #else /* CONFIG_ARM64_CONTPTE */
>  
>  #define ptep_get				__ptep_get
> @@ -1622,6 +1676,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  #define wrprotect_ptes				__wrprotect_ptes
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  #define ptep_set_access_flags			__ptep_set_access_flags
> +#define mkold_clean_ptes			__mkold_clean_ptes
>  
>  #endif /* CONFIG_ARM64_CONTPTE */
>  
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 1b64b4c3f8bf..dbff9c5e9eff 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -361,6 +361,21 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
>  
> +void contpte_mkold_clean_ptes(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, unsigned int nr)
> +{
> +	/*
> +	 * If clearing the young and dirty bits for an entire contig range, we can
> +	 * avoid unfolding. Just set old/clean and wait for the later mmu_gather
> +	 * flush to invalidate the tlb. If it's a partial range though, we need to
> +	 * unfold.
> +	 */

nit: Please reflow comments like this to 80 cols.

We can avoid unfolding in all cases. See existing comment in
contpte_ptep_test_and_clear_young(). Suggest something like this (untested):

void clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
			    pte_t *ptep, unsigned int nr,
			    bool clear_young, bool clear_dirty)
{
	/*
	 * We can safely clear access/dirty without needing to unfold from the
	 * architectures perspective, even when contpte is set. If the range
	 * starts or ends midway through a contpte block, we can just expand to
	 * include the full contpte block. While this is not exactly what the
	 * core-mm asked for, it tracks access/dirty per folio, not per page.
	 * And since we only create a contpte block when it is covered by a
	 * single folio, we can get away with clearing access/dirty for the
	 * whole block.
	 */

	unsigned int start = addr;
	unsigned int end = start + nr;

	if (pte_cont(__ptep_get(ptep + nr - 1)))
		end = ALIGN(end, CONT_PTE_SIZE);

	if (pte_cont(__ptep_get(ptep))) {
		start = ALIGN_DOWN(start, CONT_PTE_SIZE);
		ptep = contpte_align_down(ptep);
	}

	__clear_young_dirty_ptes(mm, start, ptep, end - start,
				 clear_young, clear_dirty);
}

Thanks,
Ryan

> +
> +	contpte_try_unfold_partial(mm, addr, ptep, nr);
> +	__mkold_clean_ptes(mm, addr, ptep, nr);
> +}
> +EXPORT_SYMBOL_GPL(contpte_mkold_clean_ptes);
> +
>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep,
>  					pte_t entry, int dirty)


