Return-Path: <linux-kernel+bounces-147241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65F8A716D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B957F1F22ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F3131BDB;
	Tue, 16 Apr 2024 16:29:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9EE13281B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284973; cv=none; b=VMFKsY2PtHLYWMmSlZQb3q3SjI7Zf8zppp+boBwh4zDFxPEPKKDCDqJezU+pqHCI3cg6sHoQK7VPPR4WpIRJ3NtksSv2gLrtzRGjjCgs7pK32skqMuQ01Ofduaxnw5C+yeXDmtxfgDPLbOHGWwH3kLWn0hFhJw6gjx0ifjip1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284973; c=relaxed/simple;
	bh=a+U1aff+byZUWRNdPTYVIQxzfH8dezfV0KWrVGhhhtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gz3DiY6/+TbfL7IpZaQ6sklvxMcVMYq21R0Vyr/e/WxyXfTMKM6FHB8dmgOtsLceTfEGQvDSF1kxzHX8GynjKIN37tftXSLVuSQ+WZxU4SbbVXEgTL+DaR4zwLLZP1BLPSupFW06ce4RvNHcnvGEAmNIPe232i0CfNitJVZ3la4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5629339;
	Tue, 16 Apr 2024 09:29:58 -0700 (PDT)
Received: from [10.1.39.189] (XHFQ2J9959.cambridge.arm.com [10.1.39.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 823B43F792;
	Tue, 16 Apr 2024 09:29:28 -0700 (PDT)
Message-ID: <456de31b-221f-4aeb-a2d3-9bb318526417@arm.com>
Date: Tue, 16 Apr 2024 17:29:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] mm/arm64: override clear_young_dirty_ptes() batch
 helper
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>, akpm@linux-foundation.org
Cc: david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com,
 xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240416033457.32154-1-ioworker0@gmail.com>
 <20240416033457.32154-3-ioworker0@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240416033457.32154-3-ioworker0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 04:34, Lance Yang wrote:
> The per-pte get_and_clear/modify/set approach would result in
> unfolding/refolding for contpte mappings on arm64. So we need
> to override clear_young_dirty_ptes() for arm64 to avoid it.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Barry Song <21cnbao@gmail.com>
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  arch/arm64/include/asm/pgtable.h | 55 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 29 +++++++++++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9fd8613b2db2..1303d30287dc 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1223,6 +1223,46 @@ static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
>  		__ptep_set_wrprotect(mm, address, ptep);
>  }
>  
> +static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
> +					   unsigned long addr, pte_t *ptep,
> +					   pte_t pte, cydp_t flags)
> +{
> +	pte_t old_pte;
> +
> +	do {
> +		old_pte = pte;
> +
> +		if (flags & CYDP_CLEAR_YOUNG)
> +			pte = pte_mkold(pte);
> +		if (flags & CYDP_CLEAR_DIRTY)
> +			pte = pte_mkclean(pte);
> +
> +		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
> +					       pte_val(old_pte), pte_val(pte));
> +	} while (pte_val(pte) != pte_val(old_pte));
> +}
> +
> +static inline void __clear_young_dirty_ptes(struct vm_area_struct *vma,
> +					    unsigned long addr, pte_t *ptep,
> +					    unsigned int nr, cydp_t flags)
> +{
> +	pte_t pte;
> +
> +	for (;;) {
> +		pte = __ptep_get(ptep);
> +
> +		if (flags == (CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY))
> +			__set_pte(ptep, pte_mkclean(pte_mkold(pte)));
> +		else
> +			__clear_young_dirty_pte(vma, addr, ptep, pte, flags);
> +
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
> @@ -1379,6 +1419,9 @@ extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
> +extern void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, cydp_t flags);
>  
>  static __always_inline void contpte_try_fold(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep, pte_t pte)
> @@ -1603,6 +1646,17 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>  }
>  
> +#define clear_young_dirty_ptes clear_young_dirty_ptes
> +static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
> +					  unsigned long addr, pte_t *ptep,
> +					  unsigned int nr, cydp_t flags)
> +{
> +	if (likely(nr == 1 && !pte_cont(__ptep_get(ptep))))
> +		__clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
> +	else
> +		contpte_clear_young_dirty_ptes(vma, addr, ptep, nr, flags);
> +}
> +
>  #else /* CONFIG_ARM64_CONTPTE */
>  
>  #define ptep_get				__ptep_get
> @@ -1622,6 +1676,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  #define wrprotect_ptes				__wrprotect_ptes
>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>  #define ptep_set_access_flags			__ptep_set_access_flags
> +#define clear_young_dirty_ptes			__clear_young_dirty_ptes
>  
>  #endif /* CONFIG_ARM64_CONTPTE */
>  
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 1b64b4c3f8bf..9f9486de0004 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -361,6 +361,35 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
>  
> +void contpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
> +				    unsigned long addr, pte_t *ptep,
> +				    unsigned int nr, cydp_t flags)
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
> +	unsigned long start = addr;
> +	unsigned long end = start + nr;
> +
> +	if (pte_cont(__ptep_get(ptep + nr - 1)))
> +		end = ALIGN(end, CONT_PTE_SIZE);
> +
> +	if (pte_cont(__ptep_get(ptep))) {
> +		start = ALIGN_DOWN(start, CONT_PTE_SIZE);
> +		ptep = contpte_align_down(ptep);
> +	}
> +
> +	__clear_young_dirty_ptes(vma, start, ptep, end - start, flags);
> +}
> +EXPORT_SYMBOL_GPL(contpte_clear_young_dirty_ptes);
> +
>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep,
>  					pte_t entry, int dirty)


