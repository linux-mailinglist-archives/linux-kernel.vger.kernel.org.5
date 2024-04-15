Return-Path: <linux-kernel+bounces-144809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53678A4B04
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D252844EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73B3BBD7;
	Mon, 15 Apr 2024 08:59:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835BFDF4D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171562; cv=none; b=oRMYukScO3kYqlvmhJ2B+tw8X8RMhUepLVFJunkIlAsyMz0zwEpHs2eSV6TpfuA+h1mr++RCshtQGN6ZOe9ap07pPMJmT+PTZP9rbIgUV7sJS4VBR/OP52JoJxCdavsdi02yvd9Ho93HR8hrdVUf8RDBghtaR5RZvA9INJK76SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171562; c=relaxed/simple;
	bh=8w2BtVONyFickq1XCiWz69BDy4G9BOCDPEbPXC6WFcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHNkDyV+QyDgTLJv9qz3dEoStLt7Q28OedWLjfqBJC4EZIdTd23LZGAVkMoAYNcbi6GhoWpyyy5t/w9dWl36RInAHs1+sSL8oa3SK1JZeJQkythhoyViiDfKKO5vY1QDelrOLXNROpOfH7kGFswAs5N4plUaT4zPnhi3TtFx4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A122F;
	Mon, 15 Apr 2024 01:59:48 -0700 (PDT)
Received: from [10.57.75.121] (unknown [10.57.75.121])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64003F64C;
	Mon, 15 Apr 2024 01:59:17 -0700 (PDT)
Message-ID: <209b9341-8bd0-47fe-b8fd-9a0f02beeab0@arm.com>
Date: Mon, 15 Apr 2024 09:59:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mm/arm64: override clear_young_dirty_ptes() batch
 helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: zokeefe@google.com, 21cnbao@gmail.com, shy828301@gmail.com,
 david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240413002219.71246-1-ioworker0@gmail.com>
 <20240413002219.71246-3-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240413002219.71246-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/04/2024 01:22, Lance Yang wrote:
> The per-pte get_and_clear/modify/set approach would result in
> unfolding/refolding for contpte mappings on arm64. So we need
> to override clear_young_dirty_ptes() for arm64 to avoid it.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

No, afraid I haven't signed off yet!

> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  arch/arm64/include/asm/pgtable.h | 37 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 28 ++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9fd8613b2db2..f951774dd2d6 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1223,6 +1223,28 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
>  		__ptep_set_wrprotect(mm, address, ptep);
>  }
>  
> +static inline void __clear_young_dirty_ptes(struct mm_struct *mm,
> +					    unsigned long addr, pte_t *ptep,
> +					    unsigned int nr, cydp_t flags)
> +{
> +	pte_t pte;
> +
> +	for (;;) {
> +		pte = __ptep_get(ptep);
> +
> +		if (flags | CYDP_CLEAR_YOUNG)

bug: should be bitwise AND (&).

> +			pte = pte_mkold(pte);
> +		if (flags | CYDP_CLEAR_DIRTY)
> +			pte = pte_mkclean(pte);
> +
> +		__set_pte(ptep, pte);

The __ptep_get() and __set_pte() are not atomic. This is only safe when you are
clearing BOTH access and dirty (as I explained in the previous version). If you
are only clearing one of the flags, you will need a similar cmpxchg loop as for
__ptep_test_and_clear_young(). Otherwise you can race with the HW and lose
information.

> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> @@ -1379,6 +1401,9 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
> +extern void contpte_clear_young_dirty_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, cydp_t flags);
>  
>  static __always_inline void contpte_try_fold(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep, pte_t pte)
> @@ -1603,6 +1628,17 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>  }
>  
> +#define clear_young_dirty_ptes clear_young_dirty_ptes
> +static inline void clear_young_dirty_ptes(struct mm_struct *mm,
> +					  unsigned long addr, pte_t *ptep,
> +					  unsigned int nr, cydp_t flags)
> +{
> +	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
> +		__clear_young_dirty_ptes(mm, addr, ptep, nr, flags);
> +	else
> +		contpte_clear_young_dirty_ptes(mm, addr, ptep, nr, flags);
> +}
> +
>  #else /* CONFIG_ARM64_CONTPTE */
>  
>  #define ptep_get				__ptep_get
> @@ -1622,6 +1658,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  #define wrprotect_ptes				__wrprotect_ptes
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  #define ptep_set_access_flags			__ptep_set_access_flags
> +#define clear_young_dirty_ptes			__clear_young_dirty_ptes
>  
>  #endif /* CONFIG_ARM64_CONTPTE */
>  
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 1b64b4c3f8bf..bf3b089d9641 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -361,6 +361,34 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
>  
> +void contpte_clear_young_dirty_ptes(struct mm_struct *mm, unsigned long addr,
> +				    pte_t *ptep, unsigned int nr, cydp_t flags)
> +{
> +	/*
> +	 * We can safely clear access/dirty without needing to unfold from
> +	 * the architectures perspective, even when contpte is set. If the
> +	 * range starts or ends midway through a contpte block, we can just
> +	 * expand to include the full contpte block. While this is not
> +	 * exactly what the core-mm asked for, it tracks access/dirty per
> +	 * folio, not per page. And since we only create a contpte block
> +	 * when it is covered by a single folio, we can get away with
> +	 * clearing access/dirty for the whole block.
> +	 */
> +	unsigned int start = addr;
> +	unsigned int end = start + nr;

There are addresses; they should be unsigned long. May have been my error
originally when I sent you the example snippet.

Thanks,
Ryan

> +
> +	if (pte_cont(__ptep_get(ptep + nr - 1)))
> +		end = ALIGN(end, CONT_PTE_SIZE);
> +
> +	if (pte_cont(__ptep_get(ptep))) {
> +		start = ALIGN_DOWN(start, CONT_PTE_SIZE);
> +		ptep = contpte_align_down(ptep);
> +	}
> +
> +	__clear_young_dirty_ptes(mm, start, ptep, end - start, flags);
> +}
> +EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
> +
>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep,
>  					pte_t entry, int dirty)


