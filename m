Return-Path: <linux-kernel+bounces-428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1C6814101
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FAF28384D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035B463B8;
	Fri, 15 Dec 2023 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z3NJrGTA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73967569C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50f082a8-b805-5d66-45f4-2af58e99a67f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702615023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMTQvMW92QfKnIxa39K+CCGnV2PPSQbzW7nt0Rm9e8w=;
	b=Z3NJrGTAWaoJyemZ+IxBaSKq/eFQeLUp5taJjgqJZ7yc9EXzkOVRSsrZHVvBiZ3a/pcWMf
	ANhH1k7qH2Im1NL5eovjsuWB2VlfMfNHyW5/g4baAVv8nylRMSl8JC45v+XB2RRle2nD0u
	5QELYTH+1R+nT2c4QbN0QrgPCA8xxkA=
Date: Fri, 15 Dec 2023 12:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable safely
To: Nanyong Sun <sunnanyong@huawei.com>, catalin.marinas@arm.com,
 will@kernel.org, mike.kravetz@oracle.com, akpm@linux-foundation.org,
 anshuman.khandual@arm.com
Cc: willy@infradead.org, wangkefeng.wang@huawei.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20231214073912.1938330-1-sunnanyong@huawei.com>
 <20231214073912.1938330-3-sunnanyong@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231214073912.1938330-3-sunnanyong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2023/12/14 15:39, Nanyong Sun wrote:
> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
> BBM(break-before-make) logic when change the page table of vmemmap
> address, they will under the init_mm.page_table_lock.
> If a translation fault of vmemmap address concurrently happened after
> pte/pmd cleared, vmemmap page fault handler will acquire the
> init_mm.page_table_lock to wait for vmemmap update to complete,
> by then the virtual address is valid again, so PF can return and
> access can continue.
> In other case, do the traditional kernel fault.

Yes. BTW, we already use the same scheme to support arm64
in our internal production. So the whole approach LGTM.

> Implement flush_tlb_vmemmap_all and flush_tlb_vmemmap_range on arm64
> with nothing to do because tlb already flushed in every single BBM.
>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>   arch/arm64/include/asm/esr.h |  4 ++
>   arch/arm64/include/asm/mmu.h | 20 ++++++++
>   arch/arm64/mm/fault.c        | 94 ++++++++++++++++++++++++++++++++++++
>   arch/arm64/mm/mmu.c          | 28 +++++++++++
>   4 files changed, 146 insertions(+)
>
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index ae35939f395b..1c63256efd25 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -116,6 +116,10 @@
>   #define ESR_ELx_FSC_SERROR	(0x11)
>   #define ESR_ELx_FSC_ACCESS	(0x08)
>   #define ESR_ELx_FSC_FAULT	(0x04)
> +#define ESR_ELx_FSC_FAULT_L0    (0x04)
> +#define ESR_ELx_FSC_FAULT_L1    (0x05)
> +#define ESR_ELx_FSC_FAULT_L2    (0x06)
> +#define ESR_ELx_FSC_FAULT_L3    (0x07)
>   #define ESR_ELx_FSC_PERM	(0x0C)
>   #define ESR_ELx_FSC_SEA_TTW0	(0x14)
>   #define ESR_ELx_FSC_SEA_TTW1	(0x15)
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 2fcf51231d6e..fcec5827f54f 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -76,5 +76,25 @@ extern bool kaslr_requires_kpti(void);
>   #define INIT_MM_CONTEXT(name)	\
>   	.pgd = init_pg_dir,
>   
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +void vmemmap_update_pmd(unsigned long start, pmd_t *pmd, pte_t *pgtable);
> +#define vmemmap_update_pmd vmemmap_update_pmd
> +void vmemmap_update_pte(unsigned long addr, pte_t *pte, pte_t entry);
> +#define vmemmap_update_pte vmemmap_update_pte
> +
> +static inline void flush_tlb_vmemmap_all(void)
> +{
> +	/* do nothing, already flushed tlb in every single BBM */
> +}
> +#define flush_tlb_vmemmap_all flush_tlb_vmemmap_all
> +
> +static inline void flush_tlb_vmemmap_range(unsigned long start,
> +					   unsigned long end)
> +{
> +	/* do nothing, already flushed tlb in every single BBM */
> +}
> +#define flush_tlb_vmemmap_range flush_tlb_vmemmap_range
> +#endif
> +
>   #endif	/* !__ASSEMBLY__ */
>   #endif
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 460d799e1296..7066a273c1e0 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -368,6 +368,97 @@ static bool is_el1_mte_sync_tag_check_fault(unsigned long esr)
>   	return false;
>   }
>   
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +static inline bool is_vmemmap_address(unsigned long addr)
> +{
> +	return (addr >= VMEMMAP_START) && (addr < VMEMMAP_END);
> +}
> +
> +static inline bool vmemmap_fault_may_fixup(unsigned long addr,
> +					   unsigned long esr)
> +{
> +	if (!is_vmemmap_address(addr))
> +		return false;
> +
> +	/*
> +	 * Only try to handle translation fault level 2 or level 3,
> +	 * because hugetlb vmemmap optimize only clear pmd or pte.
> +	 */
> +	switch (esr & ESR_ELx_FSC) {
> +	case ESR_ELx_FSC_FAULT_L2:
> +	case ESR_ELx_FSC_FAULT_L3:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/*
> + * PMD mapped vmemmap should has been split as PTE mapped
> + * by HVO now, here we only check this case, other cases
> + * should fail.
> + * Also should check the addr is healthy enough that will not cause
> + * a level2 or level3 translation fault again after page fault
> + * handled with success, so we need check both bits[1:0] of PMD and
> + * PTE as ARM Spec mentioned below:
> + * A Translation fault is generated if bits[1:0] of a translation
> + * table descriptor identify the descriptor as either a Fault
> + * encoding or a reserved encoding.
> + */
> +static inline bool vmemmap_addr_healthy(unsigned long addr)
> +{
> +	pgd_t *pgdp;
> +	p4d_t *p4dp;
> +	pud_t *pudp, pud;
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
> +
> +	pgdp = pgd_offset_k(addr);
> +	if (pgd_none(READ_ONCE(*pgdp)))
> +		return false;
> +
> +	p4dp = p4d_offset(pgdp, addr);
> +	if (p4d_none(READ_ONCE(*p4dp)))
> +		return false;
> +
> +	pudp = pud_offset(p4dp, addr);
> +	pud = READ_ONCE(*pudp);
> +	if (pud_none(pud))
> +		return false;
> +
> +	pmdp = pmd_offset(pudp, addr);

We already make sure it is a translation fault of level 2 or 3
here, so we could use pmd_offset_k() macro to simplify the code
a little. Right?

> +	pmd = READ_ONCE(*pmdp);
> +	if (!pmd_table(pmd))
> +		return false;
> +
> +	ptep = pte_offset_kernel(pmdp, addr);
> +	pte = READ_ONCE(*ptep);

Please use ptep_get (which is supposed to do this) to access the
raw pte, see commit c33c794828f21217.

> +	return (pte_val(pte) & PTE_TYPE_MASK) == PTE_TYPE_PAGE;
> +}
> +
> +static bool vmemmap_handle_page_fault(unsigned long addr,
> +				      unsigned long esr)
> +{
> +	bool ret = false;
> +
> +	if (likely(!vmemmap_fault_may_fixup(addr, esr)))
> +		return false;
> +
> +	spin_lock(&init_mm.page_table_lock);
> +	if (vmemmap_addr_healthy(addr))
> +		ret = true;

It is to assign the return value to ret directly. Like:

         ret = vmemmap_addr_healthy(addr);

The the initializetion to ret also can be dropped.

> +	spin_unlock(&init_mm.page_table_lock);
> +
> +	return ret;
> +}
> +#else
> +static inline bool vmemmap_handle_page_fault(unsigned long addr,
> +					     unsigned long esr)
> +{
> +	return false;
> +}
> +#endif /*CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
           ^
Miss a blank between "*" and "C" here.

Thanks.

> +
>   static bool is_translation_fault(unsigned long esr)
>   {
>   	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
> @@ -409,6 +500,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned long esr,
>   		    kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
>   			return;
>   
> +		if (vmemmap_handle_page_fault(addr, esr))
> +			return;
> +
>   		msg = "paging request";
>   	}
>   
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 15f6347d23b6..81a600ccac7c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1146,6 +1146,34 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>   	return 1;
>   }
>   
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +/*
> + * In the window between the page table entry is cleared and filled
> + * with a new value, other threads have the opportunity to concurrently
> + * access the vmemmap area then page translation fault occur.
> + * Therefore, we need to ensure that the init_mm.page_table_lock is held
> + * to synchronize the vmemmap page fault handling which will wait for
> + * this lock to be released to ensure that the page table entry has been
> + * refreshed with a new valid value.
> + */
> +void vmemmap_update_pmd(unsigned long start, pmd_t *pmd, pte_t *pgtable)
> +{
> +	lockdep_assert_held(&init_mm.page_table_lock);
> +	pmd_clear(pmd);
> +	flush_tlb_kernel_range(start, start + PMD_SIZE);
> +	pmd_populate_kernel(&init_mm, pmd, pgtable);
> +}
> +
> +void vmemmap_update_pte(unsigned long addr, pte_t *pte, pte_t entry)
> +{
> +	spin_lock(&init_mm.page_table_lock);
> +	pte_clear(&init_mm, addr, pte);
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +	set_pte_at(&init_mm, addr, pte, entry);
> +	spin_unlock(&init_mm.page_table_lock);
> +}
> +#endif
> +
>   int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>   		struct vmem_altmap *altmap)
>   {


