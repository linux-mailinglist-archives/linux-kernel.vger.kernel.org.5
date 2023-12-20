Return-Path: <linux-kernel+bounces-6425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8126A8198A5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A597B1C256EE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914201CA91;
	Wed, 20 Dec 2023 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cvS4vcLA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8E41C680
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703053998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfpLB0WYs8nz5UdmiOJ/cuEd4btbk/+PVDiE8yot5zc=;
	b=cvS4vcLA7EtoRWMOlI56+GNDO7nmjBr8m8PrvtkvaVv5zW1aepAj+VkgjPGkIbZkrrs+Q8
	Npv2dT33NMHZ7K184jYhQgQpS+B0GICuE7ofcWjngvoGNixvNbn7hLLVhvYeeHMovQsKst
	T6y3x/7NGWHnSvQcZn2yPn0ByQDOcr4=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable
 safely
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231220051855.47547-3-sunnanyong@huawei.com>
Date: Wed, 20 Dec 2023 14:32:33 +0800
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: 7bit
Message-Id: <08DCC8BB-631C-4F7A-BB0A-494AD2AD3465@linux.dev>
References: <20231220051855.47547-1-sunnanyong@huawei.com>
 <20231220051855.47547-3-sunnanyong@huawei.com>
To: Nanyong Sun <sunnanyong@huawei.com>
X-Migadu-Flow: FLOW_OUT



> On Dec 20, 2023, at 13:18, Nanyong Sun <sunnanyong@huawei.com> wrote:
> 
> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
> BBM(break-before-make) logic when change the page table of vmemmap
> address, they will under the init_mm.page_table_lock.
> If a translation fault of vmemmap address concurrently happened after
> pte/pmd cleared, vmemmap page fault handler will acquire the
> init_mm.page_table_lock to wait for vmemmap update to complete,
> by then the virtual address is valid again, so PF can return and
> access can continue.
> In other case, do the traditional kernel fault.
> 
> Implement vmemmap_flush_tlb_all/range on arm64 with nothing
> to do because tlb already flushed in every single BBM.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
> arch/arm64/include/asm/esr.h |  4 ++
> arch/arm64/include/asm/mmu.h | 20 +++++++++
> arch/arm64/mm/fault.c        | 78 ++++++++++++++++++++++++++++++++++--
> arch/arm64/mm/mmu.c          | 28 +++++++++++++
> 4 files changed, 127 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index ae35939f395b..1c63256efd25 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -116,6 +116,10 @@
> #define ESR_ELx_FSC_SERROR (0x11)
> #define ESR_ELx_FSC_ACCESS (0x08)
> #define ESR_ELx_FSC_FAULT (0x04)
> +#define ESR_ELx_FSC_FAULT_L0    (0x04)
> +#define ESR_ELx_FSC_FAULT_L1    (0x05)
> +#define ESR_ELx_FSC_FAULT_L2    (0x06)
> +#define ESR_ELx_FSC_FAULT_L3    (0x07)
> #define ESR_ELx_FSC_PERM (0x0C)
> #define ESR_ELx_FSC_SEA_TTW0 (0x14)
> #define ESR_ELx_FSC_SEA_TTW1 (0x15)
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 2fcf51231d6e..b553bc37c925 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -76,5 +76,25 @@ extern bool kaslr_requires_kpti(void);
> #define INIT_MM_CONTEXT(name) \
> .pgd = init_pg_dir,
> 
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep);
> +#define vmemmap_update_pmd vmemmap_update_pmd
> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
> +#define vmemmap_update_pte vmemmap_update_pte
> +
> +static inline void vmemmap_flush_tlb_all(void)
> +{
> + 	/* do nothing, already flushed tlb in every single BBM */
> +}
> +#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
> +
> +static inline void vmemmap_flush_tlb_range(unsigned long start,
> +   unsigned long end)
> +{
> + 	/* do nothing, already flushed tlb in every single BBM */
> +}
> +#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
> +#endif

I think those declaration related to TLB flushing should be moved
to arch/arm64/include/asm/tlbflush.h since we do not include
<asm/mmu.h> explicitly in hugetlb_vmemmap.c and its functionality
is to flush TLB. Luckily, <asm/tlbflush.h> is included by hugetlb_vmemmap.c.

Additionally, vmemmap_update_pmd/pte helpers should be moved to
arch/arm64/include/asm/pgtable.h since it is really pgtable related
operations.

Thanks.





