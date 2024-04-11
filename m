Return-Path: <linux-kernel+bounces-140523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9748A15C2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D00284BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09D14D6E5;
	Thu, 11 Apr 2024 13:37:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A21145FFA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842674; cv=none; b=UbBnjNLF/wM7A61v4OPwJBjScuKTwl6d9YADzFzOs5DleIrlpVuzwzVob2Cbd8MT5BMAHPFfhDy+lFOOnV7E0R0sJLUaMkk6jAIs6BsrZzom6WVQFQAT7ZWxETCh5NdV4vehZhvF5yzQbBJsYw7emg6B34nNqKPQLsFwTyhWxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842674; c=relaxed/simple;
	bh=qvVwcCr3JGczMFMAMRe79sgCK9u4BuKs5e8KxRYIp08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9jil4TzHrVhOejlO0C/bsbkAfoykPS4lzp2g9L7iOJlaFUzuD9KHPuvSmQdMbA/OmP08OU7ddB/65ROZyex9Jbw9GVg2TtLTYYxzo5qivvyHXQ3B0++u9CZ/TMepm7h8RbbdvhGLV2wiKp2B3C+z5/2w8PjUkOTQHM+oyQewQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E966113E;
	Thu, 11 Apr 2024 06:38:21 -0700 (PDT)
Received: from [10.1.38.151] (XHFQ2J9959.cambridge.arm.com [10.1.38.151])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C7063F64C;
	Thu, 11 Apr 2024 06:37:50 -0700 (PDT)
Message-ID: <37d4c278-3780-49ce-bd7e-e8f2ff4501fd@arm.com>
Date: Thu, 11 Apr 2024 14:37:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: mm: Don't remap pgtables for allocate vs
 populate
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/04/2024 14:02, Mark Rutland wrote:
> On Thu, Apr 04, 2024 at 03:33:07PM +0100, Ryan Roberts wrote:
>> During linear map pgtable creation, each pgtable is fixmapped /
>> fixunmapped twice; once during allocation to zero the memory, and a
>> again during population to write the entries. This means each table has
>> 2 TLB invalidations issued against it. Let's fix this so that each table
>> is only fixmapped/fixunmapped once, halving the number of TLBIs, and
>> improving performance.
>>
>> Achieve this by abstracting pgtable allocate, map and unmap operations
>> out of the main pgtable population loop code and into a `struct
>> pgtable_ops` function pointer structure. This allows us to formalize the
>> semantics of "alloc" to mean "alloc and map", requiring an "unmap" when
>> finished. So "map" is only performed (and also matched by "unmap") if
>> the pgtable has already been allocated.
>>
>> As a side effect of this refactoring, we no longer need to use the
>> fixmap at all once pages have been mapped in the linear map because
>> their "map" operation can simply do a __va() translation. So with this
>> change, we are down to 1 TLBI per table when doing early pgtable
>> manipulations, and 0 TLBIs when doing late pgtable manipulations.
>>
>> Execution time of map_mem(), which creates the kernel linear map page
>> tables, was measured on different machines with different RAM configs:
>>
>>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
>> ---------------|-------------|-------------|-------------|-------------
>>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
>> ---------------|-------------|-------------|-------------|-------------
>> before         |   13   (0%) |  162   (0%) |  655   (0%) |  1656   (0%)
>> after          |   11 (-15%) |  109 (-33%) |  449 (-31%) |  1257 (-24%)
> 
> Do we know how much of that gain is due to the early pgtable creation doing
> fewer fixmap/fixunmap ops vs the later operations using the linear map?
> 
> I suspect that the bulk of that is down to the early pgtable creation, and if
> so I think that we can get most of the benefit with a simpler change (see
> below).

All of this improvement is due to early pgtable creation doing fewer
fixmap/fixunmaps; I'm only measuring the execution time of map_mem(), which only
uses the early ops.

I haven't even looked to see if there are any hot paths where the late ops
benefit. I just saw it as a happy side-effect.

> 
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
>> Tested-by: Eric Chanudet <echanude@redhat.com>
>> ---
>>  arch/arm64/include/asm/mmu.h     |   8 +
>>  arch/arm64/include/asm/pgtable.h |   2 +
>>  arch/arm64/kernel/cpufeature.c   |  10 +-
>>  arch/arm64/mm/mmu.c              | 308 ++++++++++++++++++++++---------
>>  4 files changed, 237 insertions(+), 91 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 65977c7783c5..ae44353010e8 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -109,6 +109,14 @@ static inline bool kaslr_requires_kpti(void)
>>  	return true;
>>  }
>>  
>> +#ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>> +extern
>> +void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>> +			     phys_addr_t size, pgprot_t prot,
>> +			     void *(*pgtable_alloc)(int, phys_addr_t *),
>> +			     int flags);
>> +#endif
>> +
>>  #define INIT_MM_CONTEXT(name)	\
>>  	.pgd = swapper_pg_dir,
>>  
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 105a95a8845c..92c9aed5e7af 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -1010,6 +1010,8 @@ static inline p4d_t *p4d_offset_kimg(pgd_t *pgdp, u64 addr)
>>  
>>  static inline bool pgtable_l5_enabled(void) { return false; }
>>  
>> +#define p4d_index(addr)		(((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1))
>> +
>>  /* Match p4d_offset folding in <asm/generic/pgtable-nop4d.h> */
>>  #define p4d_set_fixmap(addr)		NULL
>>  #define p4d_set_fixmap_offset(p4dp, addr)	((p4d_t *)p4dp)
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 56583677c1f2..9a70b1954706 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -1866,17 +1866,13 @@ static bool has_lpa2(const struct arm64_cpu_capabilities *entry, int scope)
>>  #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
>>  #define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
>>  
>> -extern
>> -void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>> -			     phys_addr_t size, pgprot_t prot,
>> -			     phys_addr_t (*pgtable_alloc)(int), int flags);
>> -
>>  static phys_addr_t __initdata kpti_ng_temp_alloc;
>>  
>> -static phys_addr_t __init kpti_ng_pgd_alloc(int shift)
>> +static void *__init kpti_ng_pgd_alloc(int type, phys_addr_t *pa)
>>  {
>>  	kpti_ng_temp_alloc -= PAGE_SIZE;
>> -	return kpti_ng_temp_alloc;
>> +	*pa = kpti_ng_temp_alloc;
>> +	return __va(kpti_ng_temp_alloc);
>>  }
>>  
>>  static int __init __kpti_install_ng_mappings(void *__unused)
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index dc86dceb0efe..90bf822859b8 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -41,9 +41,42 @@
>>  #include <asm/pgalloc.h>
>>  #include <asm/kfence.h>
>>  
>> +enum pgtable_type {
>> +	TYPE_P4D = 0,
>> +	TYPE_PUD = 1,
>> +	TYPE_PMD = 2,
>> +	TYPE_PTE = 3,
>> +};
>> +
>> +/**
>> + * struct pgtable_ops - Ops to allocate and access pgtable memory. Calls must be
>> + * serialized by the caller.
>> + * @alloc:      Allocates 1 page of memory for use as pgtable `type` and maps it
>> + *              into va space. Returned memory is zeroed. Puts physical address
>> + *              of page in *pa, and returns virtual address of the mapping. User
>> + *              must explicitly unmap() before doing another alloc() or map() of
>> + *              the same `type`.
>> + * @map:        Determines the physical address of the pgtable of `type` by
>> + *              interpretting `parent` as the pgtable entry for the next level
>> + *              up. Maps the page and returns virtual address of the pgtable
>> + *              entry within the table that corresponds to `addr`. User must
>> + *              explicitly unmap() before doing another alloc() or map() of the
>> + *              same `type`.
>> + * @unmap:      Unmap the currently mapped page of `type`, which will have been
>> + *              mapped either as a result of a previous call to alloc() or
>> + *              map(). The page's virtual address must be considered invalid
>> + *              after this call returns.
>> + */
>> +struct pgtable_ops {
>> +	void *(*alloc)(int type, phys_addr_t *pa);
>> +	void *(*map)(int type, void *parent, unsigned long addr);
>> +	void (*unmap)(int type);
>> +};
> 
> There's a lot of boilerplate that results from having the TYPE_Pxx enumeration
> and needing to handle that in the callbacks, and it's somewhat unfortunate that
> the callbacks can't use the enum type directly (becuase the KPTI allocator is
> in another file).
> 
> I'm not too keen on all of that.

Yes, I agree its quite a big change. And all the switches are naff. But I
couldn't see a way to avoid it and still get all the "benefits".

> 
> As above, I suspect that most of the benefit comes from minimizing the
> map/unmap calls in the early table creation, and I think that we can do that
> without needing all this infrastructure if we keep the fixmapping explciit
> in the alloc_init_pXX() functions, but factor that out of
> early_pgtable_alloc().
> 
> Does something like the below look ok to you? 

Yes this is actually quite similar to my first attempt, but then I realised I
could get rid of the redudancies too.

> The trade-off performance-wise is
> that late uses will still use the fixmap, and will redundantly zero the tables,

I think we can mitigate the redudant zeroing for most kernel configs; tell the
allocator we don't need it to be zeroed. There are some obscure configs where
pages are zeroed on free instead of on alloc IIRC, so those would still have a
redundant clear but they are not widely used AIUI. (see bleow).

> but the logic remains fairly simple, and I suspect the overhead for late
> allocations might not matter since the bulk of late changes are non-allocating.

Its just the fixmap overhead that remains...

I'll benchmark with your below change, and also have a deeper look to check if
there are real places where fixmap might cause slowness for late ops.

> 
> Mark
> 
> ---->8-----
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 105a95a8845c5..1eecf87021bd0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1010,6 +1010,8 @@ static inline p4d_t *p4d_offset_kimg(pgd_t *pgdp, u64 addr)
>  
>  static inline bool pgtable_l5_enabled(void) { return false; }
>  
> +#define p4d_index(addr)              (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1)
> +
>  /* Match p4d_offset folding in <asm/generic/pgtable-nop4d.h> */
>  #define p4d_set_fixmap(addr)		NULL
>  #define p4d_set_fixmap_offset(p4dp, addr)	((p4d_t *)p4dp)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index dc86dceb0efe6..4b944ef8f618c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -109,28 +109,12 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>  static phys_addr_t __init early_pgtable_alloc(int shift)
>  {
>  	phys_addr_t phys;
> -	void *ptr;
>  
>  	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
>  					 MEMBLOCK_ALLOC_NOLEAKTRACE);
>  	if (!phys)
>  		panic("Failed to allocate page table page\n");
>  
> -	/*
> -	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
> -	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
> -	 * any level of table.
> -	 */
> -	ptr = pte_set_fixmap(phys);
> -
> -	memset(ptr, 0, PAGE_SIZE);
> -
> -	/*
> -	 * Implicit barriers also ensure the zeroed page is visible to the page
> -	 * table walker
> -	 */
> -	pte_clear_fixmap();
> -
>  	return phys;
>  }
>  
> @@ -172,6 +156,14 @@ bool pgattr_change_is_safe(u64 old, u64 new)
>  	return ((old ^ new) & ~mask) == 0;
>  }
>  
> +static void init_clear_pgtable(void *table)
> +{
> +	clear_page(table);
> +
> +	/* Ensure the zeroing is observed by page table walks. */
> +	dsb(ishst);
> +}
> +
>  static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		       phys_addr_t phys, pgprot_t prot)
>  {
> @@ -216,12 +208,18 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  			pmdval |= PMD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pte_phys = pgtable_alloc(PAGE_SHIFT);
> +
> +		ptep = pte_set_fixmap(pte_phys);
> +		init_clear_pgtable(ptep);
> +
>  		__pmd_populate(pmdp, pte_phys, pmdval);
>  		pmd = READ_ONCE(*pmdp);
> +	} else {
> +		ptep = pte_set_fixmap(pmd_page_paddr(pmd));
>  	}
>  	BUG_ON(pmd_bad(pmd));
>  
> -	ptep = pte_set_fixmap_offset(pmdp, addr);
> +	ptep += pte_index(addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -303,12 +301,18 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  			pudval |= PUD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pmd_phys = pgtable_alloc(PMD_SHIFT);
> +
> +		pmdp = pmd_set_fixmap(pmd_phys);
> +		init_clear_pgtable(pmdp);
> +
>  		__pud_populate(pudp, pmd_phys, pudval);
>  		pud = READ_ONCE(*pudp);
> +	} else {
> +		pmdp = pmd_set_fixmap(pud_page_paddr(pud));
>  	}
>  	BUG_ON(pud_bad(pud));
>  
> -	pmdp = pmd_set_fixmap_offset(pudp, addr);
> +	pmdp += pmd_index(addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -345,12 +349,18 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  			p4dval |= P4D_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pud_phys = pgtable_alloc(PUD_SHIFT);
> +
> +		pudp = pud_set_fixmap(pud_phys);
> +		init_clear_pgtable(pudp);
> +
>  		__p4d_populate(p4dp, pud_phys, p4dval);
>  		p4d = READ_ONCE(*p4dp);
> +	} else {
> +		pudp = pud_set_fixmap(p4d_page_paddr(p4d));
>  	}
>  	BUG_ON(p4d_bad(p4d));
>  
> -	pudp = pud_set_fixmap_offset(p4dp, addr);
> +	pudp += pud_index(addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
>  
> @@ -400,12 +410,18 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  			pgdval |= PGD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		p4d_phys = pgtable_alloc(P4D_SHIFT);
> +
> +		p4dp = p4d_set_fixmap(p4d_phys);
> +		init_clear_pgtable(p4dp);
> +
>  		__pgd_populate(pgdp, p4d_phys, pgdval);
>  		pgd = READ_ONCE(*pgdp);
> +	} else {
> +		p4dp = p4d_set_fixmap(pgd_page_paddr(pgd));
>  	}
>  	BUG_ON(pgd_bad(pgd));
>  
> -	p4dp = p4d_set_fixmap_offset(pgdp, addr);
> +	p4dp += p4d_index(addr);
>  	do {
>  		p4d_t old_p4d = READ_ONCE(*p4dp);
>  
> @@ -475,8 +491,6 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
>  	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);

How about:

	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL & ~__GFP_ZERO);


>  	BUG_ON(!ptr);
>  
> -	/* Ensure the zeroed page is visible to the page table walker */
> -	dsb(ishst);
>  	return __pa(ptr);
>  }
>  


