Return-Path: <linux-kernel+bounces-147230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6577D8A714D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5403B225F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8130131BDB;
	Tue, 16 Apr 2024 16:25:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D801131750
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284744; cv=none; b=C59K1AWE+k6HvghBpHvzDWAhLgBO/MZqYPFf7YWN6L1IVgJIVRlrHNnn4J4a3xlTrw+Q6SGrK95JIQeHEglnmQsoAM75fju7nLi5fB3x/VXWuOJtmpyRi4/uKUF1l/svcAwveGdWDnwLTnAMOv9vbcGGsX+uwprUj+DF6RFdAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284744; c=relaxed/simple;
	bh=yBO4eUI1vmYvSn1FlgZd+SWDy6MXclS1NXS9IT3JYv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FBLmv+88Drr0m7NfxcWJIggzegDnVOUXfbG1sDGxVd7QTBbeCjhP7QC5IAltmL6ZAmDLqBUGInkEovV/JoF/uKPCcChMEFVoInI53FOY8qbwTXkjXg/bWnBPvi98wIt0occ8NT5RQdODCoWSU93YY5K+v5ZZhIOkUq32j1pZQ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B4C339;
	Tue, 16 Apr 2024 09:26:09 -0700 (PDT)
Received: from [10.1.39.189] (XHFQ2J9959.cambridge.arm.com [10.1.39.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85D273F792;
	Tue, 16 Apr 2024 09:25:39 -0700 (PDT)
Message-ID: <3c4b1711-5a84-4e7a-b54a-d4955d62ec59@arm.com>
Date: Tue, 16 Apr 2024 17:25:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] mm/madvise: introduce clear_young_dirty_ptes()
 batch helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240416033457.32154-1-ioworker0@gmail.com>
 <20240416033457.32154-2-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240416033457.32154-2-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 04:34, Lance Yang wrote:
> This commit introduces clear_young_dirty_ptes() to replace mkold_ptes().
> By doing so, we can use the same function for both use cases
> (madvise_pageout and madvise_free), and it also provides the flexibility
> to only clear the dirty flag in the future if needed.
> 
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  include/linux/mm_types.h |  9 +++++
>  include/linux/pgtable.h  | 74 ++++++++++++++++++++++++----------------
>  mm/madvise.c             |  3 +-
>  3 files changed, 55 insertions(+), 31 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c432add95913..28822cd65d2a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1367,6 +1367,15 @@ enum fault_flag {
>  
>  typedef unsigned int __bitwise zap_flags_t;
>  
> +/* Flags for clear_young_dirty_ptes(). */
> +typedef int __bitwise cydp_t;
> +
> +/* Clear the access bit */
> +#define CYDP_CLEAR_YOUNG		((__force cydp_t)BIT(0))
> +
> +/* Clear the dirty bit */
> +#define CYDP_CLEAR_DIRTY		((__force cydp_t)BIT(1))
> +
>  /*
>   * FOLL_PIN and FOLL_LONGTERM may be used in various combinations with each
>   * other. Here is what they mean, and how to use them:
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e2f45e22a6d1..18019f037bae 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -361,36 +361,6 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>  }
>  #endif
>  
> -#ifndef mkold_ptes
> -/**
> - * mkold_ptes - Mark PTEs that map consecutive pages of the same folio as old.
> - * @vma: VMA the pages are mapped into.
> - * @addr: Address the first page is mapped at.
> - * @ptep: Page table pointer for the first entry.
> - * @nr: Number of entries to mark old.
> - *
> - * May be overridden by the architecture; otherwise, implemented as a simple
> - * loop over ptep_test_and_clear_young().
> - *
> - * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> - * some PTEs might be write-protected.
> - *
> - * Context: The caller holds the page table lock.  The PTEs map consecutive
> - * pages that belong to the same folio.  The PTEs are all in the same PMD.
> - */
> -static inline void mkold_ptes(struct vm_area_struct *vma, unsigned long addr,
> -		pte_t *ptep, unsigned int nr)
> -{
> -	for (;;) {
> -		ptep_test_and_clear_young(vma, addr, ptep);
> -		if (--nr == 0)
> -			break;
> -		ptep++;
> -		addr += PAGE_SIZE;
> -	}
> -}
> -#endif
> -
>  #ifndef __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG)
>  static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
> @@ -489,6 +459,50 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  }
>  #endif
>  
> +#ifndef clear_young_dirty_ptes
> +/**
> + * clear_young_dirty_ptes - Mark PTEs that map consecutive pages of the
> + *		same folio as old/clean.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Address the first page is mapped at.
> + * @ptep: Page table pointer for the first entry.
> + * @nr: Number of entries to mark old/clean.
> + * @flags: Flags to modify the PTE batch semantics.
> + *
> + * May be overridden by the architecture; otherwise, implemented by
> + * get_and_clear/modify/set for each pte in the range.
> + *
> + * Note that PTE bits in the PTE range besides the PFN can differ. For example,
> + * some PTEs might be write-protected.
> + *
> + * Context: The caller holds the page table lock.  The PTEs map consecutive
> + * pages that belong to the same folio.  The PTEs are all in the same PMD.
> + */
> +static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep,
> +					  unsigned int nr, cydp_t flags)
> +{
> +	pte_t pte;
> +
> +	for (;;) {
> +		if (flags == CYDP_CLEAR_YOUNG)
> +			ptep_test_and_clear_young(vma, addr, ptep);
> +		else {
> +			pte = ptep_get_and_clear(vma->vm_mm, addr, ptep);
> +			if (flags & CYDP_CLEAR_YOUNG)
> +				pte = pte_mkold(pte);
> +			if (flags & CYDP_CLEAR_DIRTY)
> +				pte = pte_mkclean(pte);
> +			set_pte_at(vma->vm_mm, addr, ptep, pte);
> +		}
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +#endif
> +
>  static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep)
>  {
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f59169888b8e..edb592adb749 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -507,7 +507,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			continue;
>  
>  		if (!pageout && pte_young(ptent)) {
> -			mkold_ptes(vma, addr, pte, nr);
> +			clear_young_dirty_ptes(vma, addr, pte, nr,
> +					       CYDP_CLEAR_YOUNG);
>  			tlb_remove_tlb_entries(tlb, pte, nr, addr);
>  		}
>  


