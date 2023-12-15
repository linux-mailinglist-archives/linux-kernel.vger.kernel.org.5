Return-Path: <linux-kernel+bounces-1616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0EB8150EC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BE351F25B57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F332C45BE0;
	Fri, 15 Dec 2023 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdoWDeKM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DB45974;
	Fri, 15 Dec 2023 20:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35A5C433C8;
	Fri, 15 Dec 2023 20:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702671121;
	bh=nEmfY9z5TnN6GFTUA4cTpNxq38s/GuMs6bGNqKCjz30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdoWDeKMr0H6n+y8tOvg6JiAoTJG7z+mUD9sXdZfQl9GGI+zE5HEM2xsB3xVO4lGI
	 aPOF6HUMniCTrx3b5axE09rKwq9b/3c6rPThDx/A5+J7FOib2eWSrPfsrue/T+tamB
	 P3L9gxtFiODftrnALO9ixC6xf0qHFiCWFs4dIzpFUUTcLHVC3TsUBiojq5YB0JJFjT
	 +zI233TJzNMcMDoJKi0OMrTysBGP7WrP+tPHr34f4wcJpNryWqW0npuLsHt/1Trp11
	 O3q0x1B6OpXHWyzMifMJ1Jb+fkpDNZQHe8NPXqERpNaynv3wt4IhL91LDKM8VaBvEn
	 xh9IRsBU/HAWg==
From: SeongJae Park <sj@kernel.org>
To: Aravinda Prasad <aravinda.prasad@intel.com>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	sj@kernel.org,
	linux-kernel@vger.kernel.org,
	s2322819@ed.ac.uk,
	sandeep4.kumar@intel.com,
	ying.huang@intel.com,
	dave.hansen@intel.com,
	dan.j.williams@intel.com,
	sreenivas.subramoney@intel.com,
	antti.kervinen@intel.com,
	alexander.kanevskiy@intel.com,
	Alan Nair <alan.nair@intel.com>
Subject: Re: mm/DAMON: Profiling enhancements for DAMON
Date: Fri, 15 Dec 2023 20:11:59 +0000
Message-Id: <20231215201159.73845-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231215074619.173787-1-aravinda.prasad@intel.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Aravinda,

> Subject: Re: mm/DAMON: Profiling enhancements for DAMON

Nit.  I'd suggest to use 'mm/damon: ' prefix for consistency.  Also adding
[PATCH] prefix before that would help people easily classifying this nice mail.

And if you are posting this patch aiming not to be merged as is but to share
the early implementation and get some comments, you could further make your
intention clear using [RFC PATCH] prefix instead.

On 2023-12-15T13:16:19+05:30 Aravinda Prasad <aravinda.prasad@intel.com> wrote:

> DAMON randomly samples one or more pages in every region and tracks
> accesses to them using the ACCESSED bit in PTE (or PMD for 2MB pages).
> When the region size is large (e.g., several GBs), which is common
> for large footprint applications, detecting whether the region is
> accessed or not completely depends on whether the pages that are
> actively accessed in the region are picked during random sampling.
> If such pages are not picked for sampling, DAMON fails to identify
> the region as accessed. However, increasing the sampling rate or
> increasing the number of regions increases CPU overheads of kdamond.
> 
> This patch proposes profiling different levels of the application\u2019s
> page table tree to detect whether a region is accessed or not. This
> patch is based on the observation that, when the accessed bit for a
> page is set, the accessed bits at the higher levels of the page table
> tree (PMD/PUD/PGD) corresponding to the path of the page table walk
> are also set. Hence, it is efficient to  check the accessed bits at
> the higher levels of the page table tree to detect whether a region
> is accessed or not. For example, if the access bit for a PUD entry
> is set, then one or more pages in the 1GB PUD subtree is accessed as
> each PUD entry covers 1GB mapping. Hence, instead of sampling
> thousands of 4K/2M pages to detect accesses in a large region, 
> sampling at the higher level of page table tree is faster and efficient.

The high level problem and solution ideas make sense to me, thank you for
sharing these nice finding and patch!

> 
> This patch is based on 6.6.3 kernel.

6.6.3 would be a nice baseline for RFC level patches, since it would let more
people do test.  But for non-RFC, I'd suggest to base patches for DAMON on
latest mm-unstable[1] if possible.

[1] https://git.kernel.org/akpm/mm/h/mm-unstable

> 
> TODO: Support 5-level page table tree

Looking forward to that! :)

> 
> Evaluation:
> 
> - MASIM benchmark with 1GB, 10GB, 100GB footprint with 10% hot data
>   and 5TB with 10GB hot data.
> - DAMON: 5ms sampling, 200ms aggregation interval. Rest all
>   parameters set to default value.

The default setup is 5ms sampling and 100ms aggregation intervals.  Was there a
reason to use 200ms aggregation interval instead of the default one?

> - DAMON+PTP: Page table profiling applied to DAMON with the above
>   parameters.
> 
> Profiling efficiency in detecting hot data [1]:
> 
> Footprint	1GB	10GB	100GB	5TB
> ---------------------------------------------
> DAMON		>90%	<50%	 ~0%	  0%
> DAMON+PTP	>90%	>90%	>90%	>90%

DAMON provides both frequency and a sort of recency information via
'nr_accesses' and 'age', respectively.  Using those together, we could minimize
DAMON's accuracy risk.  For example, if we define hot pages with only the
frequency information, say, pages that DAMON reported as having >=40
'nr_accesses' (100% access rate), I have no doubt at above result.  But if we
define hot page with both information, say, pages that DAMON didn't reported as
having 0 'nr_accesses' for more than 10 'age' (not accessed for more than 2
seconds), I think the number might be higher.  So I'm wondering how you defined
the hot page for this evaluation, and if you also measured with the age
information usage.

Note that this doesn't mean DAMON+PTP is not needed.  I think DAMON+PTP would
be anyway better even when we use the 'age' together.  I'm just curious if you
have considered such approaches and already have such test results.  I'm also
not asking to do the tests and add those here.  But mentioning your thought
about such approach could also be helpful for readers of this patch, imho.

> 
> CPU overheads (in billion cycles) for kdamond:
> 
> Footprint	1GB	10GB	100GB	5TB
> ---------------------------------------------
> DAMON		1.15	19.53	3.52	9.55
> DAMON+PTP	0.83	 3.20	1.27	2.55
> 
> A detailed explanation and evaluation can be found in the arXiv paper:
> [1] https://arxiv.org/pdf/2311.10275.pdf
> 
> Regards,
> Aravinda
> 
> Signed-off-by: Alan Nair <alan.nair@intel.com>
> Signed-off-by: Sandeep Kumar <sandeep4.kumar@intel.com>
> Signed-off-by: Aravinda Prasad <aravinda.prasad@intel.com>
> ---

Though it's not clearly mentioned, I left only high level comments below
assuming this is an RFC patch.

>  arch/x86/include/asm/pgtable.h |   17 +++++
>  include/linux/damon.h          |   13 ++++
>  include/linux/pgtable.h        |   31 ++++++++
>  mm/damon/core.c                |   28 ++++++++
>  mm/damon/vaddr.c               |  146 +++++++++++++++++++++++++++++++++++++---

Seems this improvement is only for vaddr.  Would this great improvement be able
to be applied to paddr.c in future?

>  5 files changed, 223 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index e02b179ec..accdabb95 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -169,6 +169,11 @@ static inline int pud_young(pud_t pud)
>  	return pud_flags(pud) & _PAGE_ACCESSED;
>  }
>  
> +static inline int pgd_young(pgd_t pgd)
> +{
> +	return pgd_flags(pgd) & _PAGE_ACCESSED;
> +}
> +
>  static inline int pte_write(pte_t pte)
>  {
>  	/*
> @@ -681,6 +686,18 @@ static inline pud_t pud_mkwrite(pud_t pud)
>  	return pud_clear_saveddirty(pud);
>  }
>  
> +static inline pgd_t pgd_clear_flags(pgd_t pgd, pgdval_t clear)
> +{
> +	pgdval_t v = native_pgd_val(pgd);
> +
> +	return native_make_pgd(v & ~clear);
> +}
> +
> +static inline pgd_t pgd_mkold(pgd_t pgd)
> +{
> +	return pgd_clear_flags(pgd, _PAGE_ACCESSED);
> +}
> +
>  #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
>  static inline int pte_soft_dirty(pte_t pte)
>  {
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index c70cca8a8..8521a62ec 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -19,6 +19,14 @@
>  /* Max priority score for DAMON-based operation schemes */
>  #define DAMOS_MAX_SCORE		(99)
>  
> +/* DAMON profiling levels */
> +enum damon_profile_level {
> +	PTE_LEVEL,
> +	PMD_LEVEL,
> +	PUD_LEVEL,
> +	PGD_LEVEL,
> +};

I'd prefer more detailed kerneldoc comments.  Also, I think this new enum is
not really needed.  Please read my comment for damon_va_mkold() below for my
detailed opinion.

> +
>  /* Get a random number in [l, r) */
>  static inline unsigned long damon_rand(unsigned long l, unsigned long r)
>  {
> @@ -57,6 +65,8 @@ struct damon_region {
>  	unsigned int age;
>  /* private: Internal value for age calculation. */
>  	unsigned int last_nr_accesses;
> +	/* Page table profiling level */
> +	enum damon_profile_level profile_level;

Seems this field is set for every damon_va_mkold(), and used on only the
function call, and following damon_va_young() call.  That allows the following
damon_va_young() skips the unnecessary recalculation of this field.  Unless the
profile_level calculation is a big deal, I think letting damon_va_young() do
the calculation once more and keeping this struct simple may be better.

>  };
>  
>  /**
> @@ -656,6 +666,9 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>  int damon_set_region_biggest_system_ram_default(struct damon_target *t,
>  				unsigned long *start, unsigned long *end);
>  
> +enum damon_profile_level pick_profile_level(unsigned long start,
> +		unsigned long end, unsigned long addr);
> +

Seems damon_va_mkold() is the only caller of this function.  I think defining
this as static on the same source file will make change simpler.

>  #endif	/* CONFIG_DAMON */
>  
>  #endif	/* _DAMON_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index af7639c3b..82d5f67ea 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -935,6 +935,37 @@ static inline void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>  #define flush_tlb_fix_spurious_fault(vma, address, ptep) flush_tlb_page(vma, address)
>  #endif
>  
> +/*
> + * When walking page tables, get the address of the current/passed boundary,
> + * or the start address of the range if that comes earlier.
> + */
> +
> +#define pgd_addr_start(addr, start)			\
> +({	unsigned long __boundary = (addr) & PGDIR_MASK;	\
> +	(__boundary > start) ? __boundary : (start);	\
> +})
> +
> +#ifndef p4d_addr_start
> +#define p4d_addr_start(addr, start)			\
> +({	unsigned long __boundary = (addr) & P4D_MASK;	\
> +	(__boundary > start) ? __boundary : (start);	\
> +})
> +#endif
> +
> +#ifndef pud_addr_start
> +#define pud_addr_start(addr, start)			\
> +({	unsigned long __boundary = (addr) & PUD_MASK;	\
> +	(__boundary > start) ? __boundary : (start);	\
> +})
> +#endif
> +
> +#ifndef pmd_addr_start
> +#define pmd_addr_start(addr, start)			\
> +({	unsigned long __boundary = (addr) & PMD_MASK;	\
> +	(__boundary > start) ? __boundary : (start);	\
> +})
> +#endif

Seems these are only used from mm/damon/vaddr.c.  If so, I think moving these
definitions into the file may better to read.

> +
>  /*
>   * When walking page tables, get the address of the next boundary,
>   * or the end address of the range if that comes earlier.  Although no
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index fd5be73f6..2a7d5c041 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -31,6 +31,33 @@ static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
>  
>  static struct kmem_cache *damon_region_cache __ro_after_init;
>  
> +/* Pick the highest possible page table profiling level for the
> + * region corresponding to addr
> + */

Again, I'd prefer having a nice kerneldoc comment.

> +enum damon_profile_level pick_profile_level(unsigned long start,
> +	unsigned long end, unsigned long addr)

As noted above, seems this function is used from vaddr.c only.  Moving this
definition into the file may make this change simpler in my opinion.

> +{
> +	enum damon_profile_level level = PTE_LEVEL;
> +
> +	if (pmd_addr_start(addr, (start) - 1) < start
> +		|| pmd_addr_end(addr, (end) + 1) > end)
> +		goto out;

How about simply 'return PTE_LEVEL' here, and similarly for below parts?

> +	level = PMD_LEVEL;
> +
> +	if (pud_addr_start(addr, (start) - 1) < start
> +		|| pud_addr_end(addr, (end) + 1) > end)
> +		goto out;
> +	level = PUD_LEVEL;
> +
> +	if (pgd_addr_start(addr, (start) - 1) < start
> +		|| pgd_addr_end(addr, (end) + 1) > end)
> +		goto out;
> +	level = PGD_LEVEL;
> +
> +out:
> +	return level;
> +}
> +
>  /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
>  static bool __damon_is_registered_ops(enum damon_ops_id id)
>  {
> @@ -132,6 +159,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>  
>  	region->age = 0;
>  	region->last_nr_accesses = 0;
> +	region->profile_level = PTE_LEVEL;
>  
>  	return region;
>  }
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index cf8a9fc5c..b71221b3e 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -387,16 +387,76 @@ static int damon_mkold_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  #define damon_mkold_hugetlb_entry NULL
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
> -static const struct mm_walk_ops damon_mkold_ops = {
> -	.pmd_entry = damon_mkold_pmd_entry,
> +static int damon_mkold_pmd(pmd_t *pmd, unsigned long addr,
> +	unsigned long next, struct mm_walk *walk)
> +{
> +	spinlock_t *ptl;
> +
> +	if (!pmd_present(*pmd) || pmd_none(*pmd))
> +		goto out;
> +
> +	ptl = pmd_lock(walk->mm, pmd);
> +	if (pmd_young(*pmd))
> +		*pmd = pmd_mkold(*pmd);

Maybe we need to do the test and write at once?  Same for similar parts below.

> +
> +	spin_unlock(ptl);
> +
> +out:
> +	return 0;
> +}
> +
> +static int damon_mkold_pud(pud_t *pud, unsigned long addr,
> +	unsigned long next, struct mm_walk *walk)
> +{
> +	spinlock_t *ptl;
> +
> +	if (!pud_present(*pud) || pud_none(*pud))
> +		goto out;
> +
> +	ptl = pud_lock(walk->mm, pud);
> +	if (pud_young(*pud))
> +		*pud = pud_mkold(*pud);
> +
> +	spin_unlock(ptl);
> +
> +out:
> +	return 0;
> +}
> +
> +static int damon_mkold_pgd(pgd_t *pgd, unsigned long addr,
> +	unsigned long next, struct mm_walk *walk)
> +{
> +
> +	if (!pgd_present(*pgd) || pgd_none(*pgd))
> +		goto out;
> +
> +	spin_lock(&pgd_lock);
> +	if (pgd_young(*pgd))
> +		*pgd = pgd_mkold(*pgd);
> +
> +	spin_unlock(&pgd_lock);
> +
> +out:
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops damon_mkold_ops[] = {
> +	{.pmd_entry = damon_mkold_pmd_entry,
>  	.hugetlb_entry = damon_mkold_hugetlb_entry,
> -	.walk_lock = PGWALK_RDLOCK,
> +	.walk_lock = PGWALK_RDLOCK},
> +	{.pmd_entry = damon_mkold_pmd},
> +	{.pud_entry = damon_mkold_pud},
> +	{.pgd_entry = damon_mkold_pgd},
>  };
>  
> -static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> +static void damon_va_mkold(struct mm_struct *mm, struct damon_region *r)
>  {
> +	unsigned long addr = r->sampling_addr;
> +
> +	r->profile_level = pick_profile_level(r->ar.start, r->ar.end, addr);
> +
>  	mmap_read_lock(mm);
> -	walk_page_range(mm, addr, addr + 1, &damon_mkold_ops, NULL);
> +	walk_page_range(mm, addr, addr + 1, damon_mkold_ops + r->profile_level, NULL);

Maybe &damon_mkold_ops[r->profile_level] would easier to read?

>  	mmap_read_unlock(mm);
>  }
>  
> @@ -409,7 +469,7 @@ static void __damon_va_prepare_access_check(struct mm_struct *mm,
>  {
>  	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
>  
> -	damon_va_mkold(mm, r->sampling_addr);
> +	damon_va_mkold(mm, r);
>  }
>  
>  static void damon_va_prepare_access_checks(struct damon_ctx *ctx)
> @@ -531,22 +591,84 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  #define damon_young_hugetlb_entry NULL
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
> -static const struct mm_walk_ops damon_young_ops = {
> -	.pmd_entry = damon_young_pmd_entry,
> +static int damon_young_pmd(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	spinlock_t *ptl;
> +	struct damon_young_walk_private *priv = walk->private;
> +
> +	if (!pmd_present(*pmd) || pmd_none(*pmd))
> +		goto out;
> +
> +	ptl = pmd_lock(walk->mm, pmd);
> +	if (pmd_young(*pmd) || mmu_notifier_test_young(walk->mm, addr))
> +		priv->young = true;
> +
> +	*priv->folio_sz = (1UL << PMD_SHIFT);
> +	spin_unlock(ptl);
> +out:
> +	return 0;
> +}
> +
> +static int damon_young_pud(pud_t *pud, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	spinlock_t *ptl;
> +	struct damon_young_walk_private *priv = walk->private;
> +
> +	if (!pud_present(*pud) || pud_none(*pud))
> +		goto out;
> +
> +	ptl = pud_lock(walk->mm, pud);
> +	if (pud_young(*pud) || mmu_notifier_test_young(walk->mm, addr))
> +		priv->young = true;
> +
> +	*priv->folio_sz = (1UL << PUD_SHIFT);
> +
> +	spin_unlock(ptl);
> +out:
> +	return 0;
> +}
> +
> +static int damon_young_pgd(pgd_t *pgd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	struct damon_young_walk_private *priv = walk->private;
> +
> +	if (!pgd_present(*pgd) || pgd_none(*pgd))
> +		goto out;
> +
> +	spin_lock(&pgd_lock);
> +	if (pgd_young(*pgd) || mmu_notifier_test_young(walk->mm, addr))
> +		priv->young = true;
> +
> +	*priv->folio_sz = (1UL << PGDIR_SHIFT);
> +
> +	spin_unlock(&pgd_lock);
> +out:
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops damon_young_ops[] = {
> +	{.pmd_entry = damon_young_pmd_entry,
>  	.hugetlb_entry = damon_young_hugetlb_entry,
> -	.walk_lock = PGWALK_RDLOCK,
> +	.walk_lock = PGWALK_RDLOCK},
> +	{.pmd_entry = damon_young_pmd},
> +	{.pud_entry = damon_young_pud},
> +	{.pgd_entry = damon_young_pgd},
>  };
>  
> -static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> +static bool damon_va_young(struct mm_struct *mm, struct damon_region *r,
>  		unsigned long *folio_sz)
>  {
> +	unsigned long addr = r->sampling_addr;
>  	struct damon_young_walk_private arg = {
>  		.folio_sz = folio_sz,
>  		.young = false,
>  	};
>  
>  	mmap_read_lock(mm);
> -	walk_page_range(mm, addr, addr + 1, &damon_young_ops, &arg);
> +	walk_page_range(mm, addr, addr + 1, damon_young_ops + r->profile_level, &arg);

Again, '&damon_young_ops[r->profile_level]' may be easier for me to read.

Also, I still prefer 80 columns limit.  Could we wrap this line?

Seems pick_profile_level() is only for calculating ->profile_level which will
be stored into the region for each damon_va_mkold().  And ->profile_level is
used to find proper mm_walk_ops from damon_mkold_ops[] and damon_young_ops[].
I understand the index is saved in ->profile_level to be reused in the followup
damon_va_young() call, to avoid the unnecessary recalculation overhead.

If the recalculation overhead is not a big deal, I think having functions for
getting the proper pointers to mm_walk_ops could make the change simpler?

>  	mmap_read_unlock(mm);
>  	return arg.young;
>  }
> @@ -572,7 +694,7 @@ static void __damon_va_check_access(struct mm_struct *mm,
>  		return;
>  	}
>  
> -	last_accessed = damon_va_young(mm, r->sampling_addr, &last_folio_sz);
> +	last_accessed = damon_va_young(mm, r, &last_folio_sz);
>  	if (last_accessed)
>  		r->nr_accesses++;


Thanks,
SJ

