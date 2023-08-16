Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B554C77EB59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbjHPVFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346372AbjHPVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:04:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 719FB272B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:04:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37365D75;
        Wed, 16 Aug 2023 14:05:09 -0700 (PDT)
Received: from [10.57.90.114] (unknown [10.57.90.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC23D3F762;
        Wed, 16 Aug 2023 14:04:24 -0700 (PDT)
Message-ID: <4c1bd243-6a94-08b4-6790-bb9e6ac6b0af@arm.com>
Date:   Wed, 16 Aug 2023 22:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 08/11] RISC-V: drivers/iommu/riscv: Add page table support
Content-Language: en-GB
To:     Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
References: <cover.1689792825.git.tjeznach@rivosinc.com>
 <2d5242e79a98dc75cd8fa0fefdb4e3ad37a920ba.1689792825.git.tjeznach@rivosinc.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2d5242e79a98dc75cd8fa0fefdb4e3ad37a920ba.1689792825.git.tjeznach@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-19 20:33, Tomasz Jeznach wrote:
> Introduces I/O page level translation services, with 4K, 2M, 1G page
> size support and enables page level iommu_map/unmap domain interfaces.
> 
> Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> ---
>   drivers/iommu/io-pgtable.c       |   3 +
>   drivers/iommu/riscv/Makefile     |   2 +-
>   drivers/iommu/riscv/io_pgtable.c | 266 +++++++++++++++++++++++++++++++
>   drivers/iommu/riscv/iommu.c      |  40 +++--
>   drivers/iommu/riscv/iommu.h      |   1 +
>   include/linux/io-pgtable.h       |   2 +
>   6 files changed, 297 insertions(+), 17 deletions(-)
>   create mode 100644 drivers/iommu/riscv/io_pgtable.c
> 
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index b843fcd365d2..c4807175934f 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -32,6 +32,9 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
>   	[AMD_IOMMU_V1] = &io_pgtable_amd_iommu_v1_init_fns,
>   	[AMD_IOMMU_V2] = &io_pgtable_amd_iommu_v2_init_fns,
>   #endif
> +#ifdef CONFIG_RISCV_IOMMU
> +	[RISCV_IOMMU] = &io_pgtable_riscv_init_fns,
> +#endif
>   };
>   
>   struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
> index 9523eb053cfc..13af452c3052 100644
> --- a/drivers/iommu/riscv/Makefile
> +++ b/drivers/iommu/riscv/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-pci.o iommu-platform.o iommu-sysfs.o
> \ No newline at end of file
> +obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-pci.o iommu-platform.o iommu-sysfs.o io_pgtable.o
> diff --git a/drivers/iommu/riscv/io_pgtable.c b/drivers/iommu/riscv/io_pgtable.c
> new file mode 100644
> index 000000000000..b6e603e6726e
> --- /dev/null
> +++ b/drivers/iommu/riscv/io_pgtable.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright © 2022-2023 Rivos Inc.
> + *
> + * RISC-V IOMMU page table allocator.
> + *
> + * Authors:
> + *	Tomasz Jeznach <tjeznach@rivosinc.com>
> + *	Sebastien Boeuf <seb@rivosinc.com>
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/bitops.h>
> +#include <linux/io-pgtable.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include <linux/dma-mapping.h>

There's no DMA API usage here. Should there be?

> +
> +#include "iommu.h"
> +
> +#define io_pgtable_to_domain(x) \
> +	container_of((x), struct riscv_iommu_domain, pgtbl)
> +
> +#define io_pgtable_ops_to_domain(x) \
> +	io_pgtable_to_domain(container_of((x), struct io_pgtable, ops))
> +
> +static inline size_t get_page_size(size_t size)
> +{
> +	if (size >= IOMMU_PAGE_SIZE_512G)
> +		return IOMMU_PAGE_SIZE_512G;
> +
> +	if (size >= IOMMU_PAGE_SIZE_1G)
> +		return IOMMU_PAGE_SIZE_1G;
> +
> +	if (size >= IOMMU_PAGE_SIZE_2M)
> +		return IOMMU_PAGE_SIZE_2M;
> +
> +	return IOMMU_PAGE_SIZE_4K;
> +}
> +
> +static void riscv_iommu_pt_walk_free(pmd_t * ptp, unsigned shift, bool root)
> +{
> +	pmd_t *pte, *pt_base;
> +	int i;
> +
> +	if (shift == PAGE_SHIFT)
> +		return;
> +
> +	if (root)
> +		pt_base = ptp;
> +	else
> +		pt_base =
> +		    (pmd_t *) pfn_to_virt(__page_val_to_pfn(pmd_val(*ptp)));
> +
> +	/* Recursively free all sub page table pages */
> +	for (i = 0; i < PTRS_PER_PMD; i++) {
> +		pte = pt_base + i;
> +		if (pmd_present(*pte) && !pmd_leaf(*pte))
> +			riscv_iommu_pt_walk_free(pte, shift - 9, false);
> +	}
> +
> +	/* Now free the current page table page */

Without any TLB maintenance, even if it was live? Maybe walk caches and 
speculative prefetching are a long way from anyone's mind if this is 
still only running under Qemu, but it still makes me unconfortable to 
see a complete lack of appropriate looking maintenance in the places I 
would usually expect to. Especially if there's the prospect of the IOMMU 
doing hardware pagetable updates itself (which I see is a thing, even if 
it's not enabled here yet).

> +	if (!root && pmd_present(*pt_base))
> +		free_page((unsigned long)pt_base);
> +}
> +
> +static void riscv_iommu_free_pgtable(struct io_pgtable *iop)
> +{
> +	struct riscv_iommu_domain *domain = io_pgtable_to_domain(iop);
> +	riscv_iommu_pt_walk_free((pmd_t *) domain->pgd_root, PGDIR_SHIFT, true);
> +}
> +
> +static pte_t *riscv_iommu_pt_walk_alloc(pmd_t * ptp, unsigned long iova,
> +					unsigned shift, bool root,
> +					size_t pgsize,
> +					unsigned long (*pd_alloc)(gfp_t),
> +					gfp_t gfp)
> +{
> +	pmd_t *pte;
> +	unsigned long pfn;
> +
> +	if (root)
> +		pte = ptp + ((iova >> shift) & (PTRS_PER_PMD - 1));
> +	else
> +		pte = (pmd_t *) pfn_to_virt(__page_val_to_pfn(pmd_val(*ptp))) +
> +		    ((iova >> shift) & (PTRS_PER_PMD - 1));
> +
> +	if ((1ULL << shift) <= pgsize) {
> +		if (pmd_present(*pte) && !pmd_leaf(*pte))
> +			riscv_iommu_pt_walk_free(pte, shift - 9, false);
> +		return (pte_t *) pte;
> +	}
> +
> +	if (pmd_none(*pte)) {
> +		pfn = pd_alloc ? virt_to_pfn(pd_alloc(gfp)) : 0;
> +		if (!pfn)
> +			return NULL;
> +		set_pmd(pte, __pmd((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> +	}
> +
> +	return riscv_iommu_pt_walk_alloc(pte, iova, shift - 9, false,
> +					 pgsize, pd_alloc, gfp);
> +}
> +
> +static pte_t *riscv_iommu_pt_walk_fetch(pmd_t * ptp,
> +					unsigned long iova, unsigned shift,
> +					bool root)
> +{
> +	pmd_t *pte;
> +
> +	if (root)
> +		pte = ptp + ((iova >> shift) & (PTRS_PER_PMD - 1));
> +	else
> +		pte = (pmd_t *) pfn_to_virt(__page_val_to_pfn(pmd_val(*ptp))) +
> +		    ((iova >> shift) & (PTRS_PER_PMD - 1));
> +
> +	if (pmd_leaf(*pte))
> +		return (pte_t *) pte;
> +	else if (pmd_none(*pte))
> +		return NULL;
> +	else if (shift == PAGE_SHIFT)
> +		return NULL;
> +
> +	return riscv_iommu_pt_walk_fetch(pte, iova, shift - 9, false);
> +}
> +
> +static int riscv_iommu_map_pages(struct io_pgtable_ops *ops,
> +				 unsigned long iova, phys_addr_t phys,
> +				 size_t pgsize, size_t pgcount, int prot,
> +				 gfp_t gfp, size_t *mapped)
> +{
> +	struct riscv_iommu_domain *domain = io_pgtable_ops_to_domain(ops);
> +	size_t size = 0;
> +	size_t page_size = get_page_size(pgsize);
> +	pte_t *pte;
> +	pte_t pte_val;
> +	pgprot_t pte_prot;
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_BLOCKED)
> +		return -ENODEV;
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
> +		*mapped = pgsize * pgcount;
> +		return 0;
> +	}

As before, these are utter nonsense, but cannot happen anyway.

> +
> +	pte_prot = (prot & IOMMU_WRITE) ?
> +	    __pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | _PAGE_DIRTY) :
> +	    __pgprot(_PAGE_BASE | _PAGE_READ);
> +
> +	while (pgcount--) {
> +		pte =
> +		    riscv_iommu_pt_walk_alloc((pmd_t *) domain->pgd_root, iova,
> +					      PGDIR_SHIFT, true, page_size,
> +					      get_zeroed_page, gfp);
> +		if (!pte) {
> +			*mapped = size;
> +			return -ENOMEM;
> +		}
> +
> +		pte_val = pfn_pte(phys_to_pfn(phys), pte_prot);
> +
> +		set_pte(pte, pte_val);
> +
> +		size += page_size;
> +		iova += page_size;
> +		phys += page_size;
> +	}
> +
> +	*mapped = size;
> +	return 0;
> +}
> +
> +static size_t riscv_iommu_unmap_pages(struct io_pgtable_ops *ops,
> +				      unsigned long iova, size_t pgsize,
> +				      size_t pgcount,
> +				      struct iommu_iotlb_gather *gather)
> +{
> +	struct riscv_iommu_domain *domain = io_pgtable_ops_to_domain(ops);
> +	size_t size = 0;
> +	size_t page_size = get_page_size(pgsize);
> +	pte_t *pte;
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> +		return pgsize * pgcount;

"Yes, non-existent caller, those pages are definitely unmapped and 
inaccessible now. Totally secure. Device couldn't possibly touch them if 
it tried. Would I lie to you?"

> +
> +	while (pgcount--) {
> +		pte = riscv_iommu_pt_walk_fetch((pmd_t *) domain->pgd_root,
> +						iova, PGDIR_SHIFT, true);
> +		if (!pte)
> +			return size;
> +
> +		set_pte(pte, __pte(0));
> +
> +		iommu_iotlb_gather_add_page(&domain->domain, gather, iova,
> +					    pgsize);
> +
> +		size += page_size;
> +		iova += page_size;
> +	}
> +
> +	return size;
> +}
> +
> +static phys_addr_t riscv_iommu_iova_to_phys(struct io_pgtable_ops *ops,
> +					    unsigned long iova)
> +{
> +	struct riscv_iommu_domain *domain = io_pgtable_ops_to_domain(ops);
> +	pte_t *pte;
> +
> +	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> +		return (phys_addr_t) iova;

I mean, even if it was still 2 years ago before the core code handled 
this anyway (and it's only for a couple of broken network drivers doing 
dumb things they shouldn't), why would a sane IOMMU driver even bother 
going to the lengths of allocating io-pgtable ops for an identity domain 
that by definition doesn't use a pagetable!?

> +
> +	pte = riscv_iommu_pt_walk_fetch((pmd_t *) domain->pgd_root,
> +					iova, PGDIR_SHIFT, true);
> +	if (!pte || !pte_present(*pte))
> +		return 0;
> +
> +	return (pfn_to_phys(pte_pfn(*pte)) | (iova & PAGE_MASK));
> +}
> +
> +static void riscv_iommu_tlb_inv_all(void *cookie)
> +{
> +}
> +
> +static void riscv_iommu_tlb_inv_walk(unsigned long iova, size_t size,
> +				     size_t granule, void *cookie)
> +{
> +}
> +
> +static void riscv_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
> +				     unsigned long iova, size_t granule,
> +				     void *cookie)
> +{
> +}
> +
> +static const struct iommu_flush_ops riscv_iommu_flush_ops = {
> +	.tlb_flush_all = riscv_iommu_tlb_inv_all,
> +	.tlb_flush_walk = riscv_iommu_tlb_inv_walk,
> +	.tlb_add_page = riscv_iommu_tlb_add_page,
> +};

...Why? Either implement them properly, or don't implement them at all. 
And if they are implemented it needs to be by the driver, so either way 
they shouldn't be *here*.

> +
> +/* NOTE: cfg should point to riscv_iommu_domain structure member pgtbl.cfg */
> +static struct io_pgtable *riscv_iommu_alloc_pgtable(struct io_pgtable_cfg *cfg,
> +						    void *cookie)
> +{
> +	struct io_pgtable *iop = container_of(cfg, struct io_pgtable, cfg);
> +
> +	cfg->pgsize_bitmap = SZ_4K | SZ_2M | SZ_1G;
> +	cfg->ias = 57;		// va mode, SvXX -> ias
> +	cfg->oas = 57;		// pa mode, or SvXX+4 -> oas

At least IAS should be passed by the driver based on what the IOMMU 
actually supports (and isn't OAS 56?)

> +	cfg->tlb = &riscv_iommu_flush_ops;
> +
> +	iop->ops.map_pages = riscv_iommu_map_pages;
> +	iop->ops.unmap_pages = riscv_iommu_unmap_pages;
> +	iop->ops.iova_to_phys = riscv_iommu_iova_to_phys;
> +
> +	return iop;
> +}
> +
> +struct io_pgtable_init_fns io_pgtable_riscv_init_fns = {
> +	.alloc = riscv_iommu_alloc_pgtable,
> +	.free = riscv_iommu_free_pgtable,
> +};
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 9ee7d2b222b5..2ef6952a2109 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -807,7 +807,7 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
>   	/* Initial DC pointer can be NULL if IOMMU is configured in OFF or BARE mode */
>   	ep->dc = riscv_iommu_get_dc(iommu, ep->devid);
>   
> -	dev_info(iommu->dev, "adding device to iommu with devid %i in domain %i\n",
> +	dev_dbg(iommu->dev, "adding device to iommu with devid %i in domain %i\n",
>   		ep->devid, ep->domid);
>   
>   	dev_iommu_priv_set(dev, ep);
> @@ -874,7 +874,10 @@ static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
>   {
>   	struct riscv_iommu_domain *domain;
>   
> -	if (type != IOMMU_DOMAIN_IDENTITY &&
> +	if (type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_DMA_FQ &&

IOMMU_DOMAIN_DMA_FQ isn't exposed to drivers any more.

> +	    type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_IDENTITY &&
>   	    type != IOMMU_DOMAIN_BLOCKED)

I might start believing you could support blocking domains if I saw some 
kind of handling of them since patch #7, but no, still nothing.

AFAICS from the spec there's no super-convenient way if you did want to 
do it, since you apparently can't suppress the faults from simply making 
the DC invalid. I guess it might be a case of keeping a special 
always-empty context so you can point any device's FSC at that while 
setting DTF. But it's hardly critical, so for now I'd just remove the 
broken non-support and leave the idea as something to revisit later.

>   		return NULL;
>   
> @@ -890,7 +893,7 @@ static struct iommu_domain *riscv_iommu_domain_alloc(unsigned type)
>   	domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
>   					RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
>   
> -	printk("domain type %x alloc %u\n", type, domain->pscid);
> +	printk("domain alloc %u\n", domain->pscid);
>   
>   	return &domain->domain;
>   }
> @@ -903,6 +906,9 @@ static void riscv_iommu_domain_free(struct iommu_domain *iommu_domain)
>   		pr_warn("IOMMU domain is not empty!\n");
>   	}
>   
> +	if (domain->pgtbl.cookie)
> +		free_io_pgtable_ops(&domain->pgtbl.ops);
> +
>   	if (domain->pgd_root)
>   		free_pages((unsigned long)domain->pgd_root, 0);

Is there a reason for this weird pgd_root setup where the io-pgtable 
implementation doesn't simply allocate and own the full pagetable itself?

>   
> @@ -959,6 +965,9 @@ static int riscv_iommu_domain_finalize(struct riscv_iommu_domain *domain,
>   	if (!domain->pgd_root)
>   		return -ENOMEM;
>   
> +	if (!alloc_io_pgtable_ops(RISCV_IOMMU, &domain->pgtbl.cfg, domain))
> +		return -ENOMEM;
> +
>   	return 0;
>   }
>   
> @@ -1006,9 +1015,8 @@ static int riscv_iommu_attach_dev(struct iommu_domain *iommu_domain, struct devi
>   		return 0;
>   	}
>   
> -	if (!dc) {
> +	if (!dc)
>   		return -ENODEV;
> -	}

This is a great example of more of the kind of stuff I was getting at on 
patch #1 - obviously unnecessary churn *within* a series is the ideal 
way to overload and annoy reviewers... and then I look at the rest of my 
screen below and see loads of code from an earlier patch being deleted 
already, so apparently it was a waste of time reviewing it at all :(

Thanks,
Robin.

>   	/*
>   	 * S-Stage translation table. G-Stage remains unmodified (BARE).
> @@ -1104,12 +1112,11 @@ static int riscv_iommu_map_pages(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
>   
> -	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY) {
> -		*mapped = pgsize * pgcount;
> -		return 0;
> -	}
> +	if (!domain->pgtbl.ops.map_pages)
> +		return -ENODEV;
>   
> -	return -ENODEV;
> +	return domain->pgtbl.ops.map_pages(&domain->pgtbl.ops, iova, phys,
> +					   pgsize, pgcount, prot, gfp, mapped);
>   }
>   
>   static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
> @@ -1118,10 +1125,11 @@ static size_t riscv_iommu_unmap_pages(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
>   
> -	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> -		return pgsize * pgcount;
> +	if (!domain->pgtbl.ops.unmap_pages)
> +		return 0;
>   
> -	return 0;
> +	return domain->pgtbl.ops.unmap_pages(&domain->pgtbl.ops, iova, pgsize,
> +					     pgcount, gather);
>   }
>   
>   static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
> @@ -1129,10 +1137,10 @@ static phys_addr_t riscv_iommu_iova_to_phys(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
>   
> -	if (domain->domain.type == IOMMU_DOMAIN_IDENTITY)
> -		return (phys_addr_t) iova;
> +	if (!domain->pgtbl.ops.iova_to_phys)
> +		return 0;
>   
> -	return 0;
> +	return domain->pgtbl.ops.iova_to_phys(&domain->pgtbl.ops, iova);
>   }
>   
>   /*
> diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> index 9140df71e17b..fe32a4eff14e 100644
> --- a/drivers/iommu/riscv/iommu.h
> +++ b/drivers/iommu/riscv/iommu.h
> @@ -88,6 +88,7 @@ struct riscv_iommu_device {
>   
>   struct riscv_iommu_domain {
>   	struct iommu_domain domain;
> +	struct io_pgtable pgtbl;
>   
>   	struct list_head endpoints;
>   	struct mutex lock;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 1b7a44b35616..8dd9d3a28e3a 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -19,6 +19,7 @@ enum io_pgtable_fmt {
>   	AMD_IOMMU_V2,
>   	APPLE_DART,
>   	APPLE_DART2,
> +	RISCV_IOMMU,
>   	IO_PGTABLE_NUM_FMTS,
>   };
>   
> @@ -258,5 +259,6 @@ extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
>   extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_riscv_init_fns;
>   
>   #endif /* __IO_PGTABLE_H */
