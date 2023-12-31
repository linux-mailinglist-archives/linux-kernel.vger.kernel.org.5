Return-Path: <linux-kernel+bounces-13751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC09820C05
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9E2E281D18
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903B179D4;
	Sun, 31 Dec 2023 16:39:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07F8F51
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C1A5FF805;
	Sun, 31 Dec 2023 16:39:45 +0000 (UTC)
Message-ID: <70de2d00-703f-4f9d-9800-fd50ac7b4e21@ghiti.fr>
Date: Sun, 31 Dec 2023 17:39:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 01/11] mm: Fix misused APIs on huge pte
Content-Language: en-US
To: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 anup@brainfault.org, atishp@atishpatra.org
Cc: dengliang.1214@bytedance.com, xieyongji@bytedance.com,
 lihangjing@bytedance.com, songmuchun@bytedance.com,
 punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
 <20231123065708.91345-2-luxu.kernel@bytedance.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231123065708.91345-2-luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Xu,

On 23/11/2023 07:56, Xu Lu wrote:
> There exist some paths that try to get value of huge pte via normal
> pte API ptep_get instead of huge pte API huge_ptep_get. This commit
> corrects these misused APIs.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>   arch/riscv/mm/hugetlbpage.c   |  2 +-
>   fs/proc/task_mmu.c            |  2 +-
>   include/asm-generic/hugetlb.h |  7 +++++++
>   mm/hugetlb.c                  |  2 +-
>   mm/migrate.c                  |  5 ++++-
>   mm/mprotect.c                 |  2 +-
>   mm/rmap.c                     | 10 ++++++++--
>   mm/vmalloc.c                  |  3 ++-
>   8 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index b52f0210481f..d7cf8e2d3c5b 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -74,7 +74,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>   
>   out:
>   	if (pte) {
> -		pte_t pteval = ptep_get_lockless(pte);
> +		pte_t pteval = huge_ptep_get_lockless(pte);
>   
>   		WARN_ON_ONCE(pte_present(pteval) && !pte_huge(pteval));
>   	}


Only looking at riscv for this patch, this change does not look 
necessary as the pte value is only used to check if the pte is huge or 
not, it does not use the A/D bits.

Thanks,

Alex


> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index ef2eb12906da..0fe9d23aa062 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -726,7 +726,7 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
>   	struct mem_size_stats *mss = walk->private;
>   	struct vm_area_struct *vma = walk->vma;
>   	struct page *page = NULL;
> -	pte_t ptent = ptep_get(pte);
> +	pte_t ptent = huge_ptep_get(pte);
>   
>   	if (pte_present(ptent)) {
>   		page = vm_normal_page(vma, addr, ptent);
> diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
> index 6dcf4d576970..52c299db971a 100644
> --- a/include/asm-generic/hugetlb.h
> +++ b/include/asm-generic/hugetlb.h
> @@ -150,6 +150,13 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
>   }
>   #endif
>   
> +#ifndef __HAVE_ARCH_HUGE_PTEP_GET_LOCKLESS
> +static inline pte_t huge_ptep_get_lockless(pte_t *ptep)
> +{
> +	return huge_ptep_get(ptep);
> +}
> +#endif
> +
>   #ifndef __HAVE_ARCH_GIGANTIC_PAGE_RUNTIME_SUPPORTED
>   static inline bool gigantic_page_runtime_supported(void)
>   {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1169ef2f2176..9f773eb95b3b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7406,7 +7406,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
>   	}
>   
>   	if (pte) {
> -		pte_t pteval = ptep_get_lockless(pte);
> +		pte_t pteval = huge_ptep_get_lockless(pte);
>   
>   		BUG_ON(pte_present(pteval) && !pte_huge(pteval));
>   	}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 35a88334bb3c..d0daf58e486e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -210,7 +210,10 @@ static bool remove_migration_pte(struct folio *folio,
>   
>   		folio_get(folio);
>   		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
> -		old_pte = ptep_get(pvmw.pte);
> +		if (folio_test_hugetlb(folio))
> +			old_pte = huge_ptep_get(pvmw.pte);
> +		else
> +			old_pte = ptep_get(pvmw.pte);
>   		if (pte_swp_soft_dirty(old_pte))
>   			pte = pte_mksoft_dirty(pte);
>   
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 81991102f785..b9129c03f451 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -555,7 +555,7 @@ static int prot_none_hugetlb_entry(pte_t *pte, unsigned long hmask,
>   				   unsigned long addr, unsigned long next,
>   				   struct mm_walk *walk)
>   {
> -	return pfn_modify_allowed(pte_pfn(ptep_get(pte)),
> +	return pfn_modify_allowed(pte_pfn(huge_ptep_get(pte)),
>   				  *(pgprot_t *)(walk->private)) ?
>   		0 : -EACCES;
>   }
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 7a27a2b41802..d93c6dabbdf4 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1577,7 +1577,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>   			break;
>   		}
>   
> -		pfn = pte_pfn(ptep_get(pvmw.pte));
> +		if (folio_test_hugetlb(folio))
> +			pfn = pte_pfn(huge_ptep_get(pvmw.pte));
> +		else
> +			pfn = pte_pfn(ptep_get(pvmw.pte));
>   		subpage = folio_page(folio, pfn - folio_pfn(folio));
>   		address = pvmw.address;
>   		anon_exclusive = folio_test_anon(folio) &&
> @@ -1931,7 +1934,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>   		/* Unexpected PMD-mapped THP? */
>   		VM_BUG_ON_FOLIO(!pvmw.pte, folio);
>   
> -		pfn = pte_pfn(ptep_get(pvmw.pte));
> +		if (folio_test_hugetlb(folio))
> +			pfn = pte_pfn(huge_ptep_get(pvmw.pte));
> +		else
> +			pfn = pte_pfn(ptep_get(pvmw.pte));
>   
>   		if (folio_is_zone_device(folio)) {
>   			/*
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d12a17fc0c17..1a451b82a7ac 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -103,7 +103,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   	if (!pte)
>   		return -ENOMEM;
>   	do {
> -		BUG_ON(!pte_none(ptep_get(pte)));
>   
>   #ifdef CONFIG_HUGETLB_PAGE
>   		size = arch_vmap_pte_range_map_size(addr, end, pfn, max_page_shift);
> @@ -111,11 +110,13 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>   			pte_t entry = pfn_pte(pfn, prot);
>   
>   			entry = arch_make_huge_pte(entry, ilog2(size), 0);
> +			BUG_ON(!pte_none(huge_ptep_get(pte)));
>   			set_huge_pte_at(&init_mm, addr, pte, entry, size);
>   			pfn += PFN_DOWN(size);
>   			continue;
>   		}
>   #endif
> +		BUG_ON(!pte_none(ptep_get(pte)));
>   		set_pte_at(&init_mm, addr, pte, pfn_pte(pfn, prot));
>   		pfn++;
>   	} while (pte += PFN_DOWN(size), addr += size, addr != end);

