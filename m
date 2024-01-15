Return-Path: <linux-kernel+bounces-26256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF9882DD95
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBECC28294F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7304C17BBE;
	Mon, 15 Jan 2024 16:27:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA08417BAE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF232F4;
	Mon, 15 Jan 2024 08:28:00 -0800 (PST)
Received: from [10.57.76.47] (unknown [10.57.76.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C6C73F5A1;
	Mon, 15 Jan 2024 08:27:10 -0800 (PST)
Message-ID: <f1e20474-14aa-4721-b649-1fb832bad476@arm.com>
Date: Mon, 15 Jan 2024 16:27:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/16] arm64/mm: Wire up PTE_CONT for user mappings
Content-Language: en-GB
To: Alexandre Ghiti <alex@ghiti.fr>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-15-ryan.roberts@arm.com>
 <4c9f4507-94ce-4b1b-975e-74cc19faece9@ghiti.fr>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4c9f4507-94ce-4b1b-975e-74cc19faece9@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/01/2024 15:14, Alexandre Ghiti wrote:
> Hi Ryan,
> 
> On 18/12/2023 11:50, Ryan Roberts wrote:
>> With the ptep API sufficiently refactored, we can now introduce a new
>> "contpte" API layer, which transparently manages the PTE_CONT bit for
>> user mappings. Whenever it detects a set of PTEs that meet the
>> requirements for a contiguous range, the PTEs are re-painted with the
>> PTE_CONT bit. Use of contpte mappings is intended to be transparent to
>> the core-mm, which continues to interact with individual ptes.
>>
>> Since a contpte block only has a single access and dirty bit, the
>> semantic here changes slightly; when getting a pte (e.g. ptep_get())
>> that is part of a contpte mapping, the access and dirty information are
>> pulled from the block (so all ptes in the block return the same
>> access/dirty info). When changing the access/dirty info on a pte (e.g.
>> ptep_set_access_flags()) that is part of a contpte mapping, this change
>> will affect the whole contpte block. This is works fine in practice
>> since we guarantee that only a single folio is mapped by a contpte
>> block, and the core-mm tracks access/dirty information per folio.
>>
>> This initial change provides a baseline that can be optimized in future
>> commits. That said, fold/unfold operations (which imply tlb
>> invalidation) are avoided where possible with a few tricks for
>> access/dirty bit management. Write-protect modifications for contpte
>> mappings are currently non-optimal, and incure a regression in fork()
>> performance. This will be addressed in follow-up changes.
>>
>> In order for the public functions, which used to be pure inline, to
>> continue to be callable by modules, export all the contpte_* symbols
>> that are now called by those public inline functions.
>>
>> The feature is enabled/disabled with the ARM64_CONTPTE Kconfig parameter
>> at build time. It defaults to enabled as long as its dependency,
>> TRANSPARENT_HUGEPAGE is also enabled. The core-mm depends upon
>> TRANSPARENT_HUGEPAGE to be able to allocate large folios, so if its not
>> enabled, then there is no chance of meeting the physical contiguity
>> requirement for contpte mappings.
>>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   arch/arm64/Kconfig               |  10 +-
>>   arch/arm64/include/asm/pgtable.h | 184 +++++++++++++++
>>   arch/arm64/mm/Makefile           |   1 +
>>   arch/arm64/mm/contpte.c          | 388 +++++++++++++++++++++++++++++++
>>   4 files changed, 582 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/mm/contpte.c
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7b071a00425d..de76e484ff3a 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -2209,6 +2209,15 @@ config UNWIND_PATCH_PAC_INTO_SCS
>>       select UNWIND_TABLES
>>       select DYNAMIC_SCS
>>   +config ARM64_CONTPTE
>> +    bool "Contiguous PTE mappings for user memory" if EXPERT
>> +    depends on TRANSPARENT_HUGEPAGE
>> +    default y
>> +    help
>> +      When enabled, user mappings are configured using the PTE contiguous
>> +      bit, for any mappings that meet the size and alignment requirements.
>> +      This reduces TLB pressure and improves performance.
>> +
>>   endmenu # "Kernel Features"
>>     menu "Boot options"
>> @@ -2318,4 +2327,3 @@ endmenu # "CPU Power Management"
>>   source "drivers/acpi/Kconfig"
>>     source "arch/arm64/kvm/Kconfig"
>> -
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 6930c14f062f..e64120452301 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -133,6 +133,10 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>    */
>>   #define pte_valid_not_user(pte) \
>>       ((pte_val(pte) & (PTE_VALID | PTE_USER | PTE_UXN)) == (PTE_VALID |
>> PTE_UXN))
>> +/*
>> + * Returns true if the pte is valid and has the contiguous bit set.
>> + */
>> +#define pte_valid_cont(pte)    (pte_valid(pte) && pte_cont(pte))
>>   /*
>>    * Could the pte be present in the TLB? We must check mm_tlb_flush_pending
>>    * so that we don't erroneously return false for pages that have been
>> @@ -1116,6 +1120,184 @@ extern void ptep_modify_prot_commit(struct
>> vm_area_struct *vma,
>>                       unsigned long addr, pte_t *ptep,
>>                       pte_t old_pte, pte_t new_pte);
>>   +#ifdef CONFIG_ARM64_CONTPTE
>> +
>> +/*
>> + * The contpte APIs are used to transparently manage the contiguous bit in ptes
>> + * where it is possible and makes sense to do so. The PTE_CONT bit is considered
>> + * a private implementation detail of the public ptep API (see below).
>> + */
>> +extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, pte_t pte);
>> +extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, pte_t pte);
>> +extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>> +extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>> +extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, pte_t pte, unsigned int nr);
>> +extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>> +                unsigned long addr, pte_t *ptep);
>> +extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>> +                unsigned long addr, pte_t *ptep);
>> +extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>> +                unsigned long addr, pte_t *ptep,
>> +                pte_t entry, int dirty);
>> +
>> +static inline void contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>> +                    pte_t *ptep, pte_t pte)
>> +{
>> +    /*
>> +     * Only bother trying if both the virtual and physical addresses are
>> +     * aligned and correspond to the last entry in a contig range. The core
>> +     * code mostly modifies ranges from low to high, so this is the likely
>> +     * the last modification in the contig range, so a good time to fold.
>> +     * We can't fold special mappings, because there is no associated folio.
>> +     */
>> +
>> +    const unsigned long contmask = CONT_PTES - 1;
>> +    bool valign = (((unsigned long)ptep >> 3) & contmask) == contmask;
>> +    bool palign = (pte_pfn(pte) & contmask) == contmask;
>> +
>> +    if (valign && palign &&
>> +        pte_valid(pte) && !pte_cont(pte) && !pte_special(pte))
>> +        __contpte_try_fold(mm, addr, ptep, pte);
>> +}
>> +
>> +static inline void contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>> +                    pte_t *ptep, pte_t pte)
>> +{
>> +    if (pte_valid_cont(pte))
>> +        __contpte_try_unfold(mm, addr, ptep, pte);
>> +}
>> +
>> +/*
>> + * The below functions constitute the public API that arm64 presents to the
>> + * core-mm to manipulate PTE entries within their page tables (or at least this
>> + * is the subset of the API that arm64 needs to implement). These public
>> + * versions will automatically and transparently apply the contiguous bit where
>> + * it makes sense to do so. Therefore any users that are contig-aware (e.g.
>> + * hugetlb, kernel mapper) should NOT use these APIs, but instead use the
>> + * private versions, which are prefixed with double underscore. All of these
>> + * APIs except for ptep_get_lockless() are expected to be called with the PTL
>> + * held.
>> + */
>> +
>> +#define ptep_get ptep_get
>> +static inline pte_t ptep_get(pte_t *ptep)
>> +{
>> +    pte_t pte = __ptep_get(ptep);
>> +
>> +    if (!pte_valid_cont(pte))
>> +        return pte;
>> +
>> +    return contpte_ptep_get(ptep, pte);
>> +}
>> +
>> +#define ptep_get_lockless ptep_get_lockless
>> +static inline pte_t ptep_get_lockless(pte_t *ptep)
>> +{
>> +    pte_t pte = __ptep_get(ptep);
>> +
>> +    if (!pte_valid_cont(pte))
>> +        return pte;
>> +
>> +    return contpte_ptep_get_lockless(ptep);
>> +}
>> +
>> +static inline void set_pte(pte_t *ptep, pte_t pte)
>> +{
>> +    /*
>> +     * We don't have the mm or vaddr so cannot unfold or fold contig entries
>> +     * (since it requires tlb maintenance). set_pte() is not used in core
>> +     * code, so this should never even be called. Regardless do our best to
>> +     * service any call and emit a warning if there is any attempt to set a
>> +     * pte on top of an existing contig range.
>> +     */
>> +    pte_t orig_pte = __ptep_get(ptep);
>> +
>> +    WARN_ON_ONCE(pte_valid_cont(orig_pte));
>> +    __set_pte(ptep, pte_mknoncont(pte));
>> +}
>> +
>> +#define set_ptes set_ptes
>> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, pte_t pte, unsigned int nr)
>> +{
>> +    pte = pte_mknoncont(pte);
>> +
>> +    if (nr == 1) {
>> +        contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +        __set_ptes(mm, addr, ptep, pte, 1);
>> +        contpte_try_fold(mm, addr, ptep, pte);
>> +    } else
>> +        contpte_set_ptes(mm, addr, ptep, pte, nr);
>> +}
>> +
>> +static inline void pte_clear(struct mm_struct *mm,
>> +                unsigned long addr, pte_t *ptep)
>> +{
>> +    contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +    __pte_clear(mm, addr, ptep);
>> +}
>> +
>> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>> +static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>> +                unsigned long addr, pte_t *ptep)
>> +{
>> +    contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +    return __ptep_get_and_clear(mm, addr, ptep);
>> +}
>> +
>> +#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>> +static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>> +                unsigned long addr, pte_t *ptep)
>> +{
>> +    pte_t orig_pte = __ptep_get(ptep);
>> +
>> +    if (!pte_valid_cont(orig_pte))
>> +        return __ptep_test_and_clear_young(vma, addr, ptep);
>> +
>> +    return contpte_ptep_test_and_clear_young(vma, addr, ptep);
>> +}
>> +
>> +#define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>> +static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>> +                unsigned long addr, pte_t *ptep)
>> +{
>> +    pte_t orig_pte = __ptep_get(ptep);
>> +
>> +    if (!pte_valid_cont(orig_pte))
>> +        return __ptep_clear_flush_young(vma, addr, ptep);
>> +
>> +    return contpte_ptep_clear_flush_young(vma, addr, ptep);
>> +}
>> +
>> +#define __HAVE_ARCH_PTEP_SET_WRPROTECT
>> +static inline void ptep_set_wrprotect(struct mm_struct *mm,
>> +                unsigned long addr, pte_t *ptep)
>> +{
>> +    contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +    __ptep_set_wrprotect(mm, addr, ptep);
>> +    contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
>> +}
>> +
>> +#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>> +static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>> +                unsigned long addr, pte_t *ptep,
>> +                pte_t entry, int dirty)
>> +{
>> +    pte_t orig_pte = __ptep_get(ptep);
>> +
>> +    entry = pte_mknoncont(entry);
>> +
>> +    if (!pte_valid_cont(orig_pte))
>> +        return __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>> +
>> +    return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>> +}
>> +
>> +#else /* CONFIG_ARM64_CONTPTE */
>> +
>>   #define ptep_get                __ptep_get
>>   #define set_pte                    __set_pte
>>   #define set_ptes                __set_ptes
>> @@ -1131,6 +1313,8 @@ extern void ptep_modify_prot_commit(struct
>> vm_area_struct *vma,
>>   #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>>   #define ptep_set_access_flags            __ptep_set_access_flags
>>   +#endif /* CONFIG_ARM64_CONTPTE */
>> +
>>   #endif /* !__ASSEMBLY__ */
>>     #endif /* __ASM_PGTABLE_H */
>> diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
>> index dbd1bc95967d..60454256945b 100644
>> --- a/arch/arm64/mm/Makefile
>> +++ b/arch/arm64/mm/Makefile
>> @@ -3,6 +3,7 @@ obj-y                := dma-mapping.o extable.o fault.o init.o \
>>                      cache.o copypage.o flush.o \
>>                      ioremap.o mmap.o pgd.o mmu.o \
>>                      context.o proc.o pageattr.o fixmap.o
>> +obj-$(CONFIG_ARM64_CONTPTE)    += contpte.o
>>   obj-$(CONFIG_HUGETLB_PAGE)    += hugetlbpage.o
>>   obj-$(CONFIG_PTDUMP_CORE)    += ptdump.o
>>   obj-$(CONFIG_PTDUMP_DEBUGFS)    += ptdump_debugfs.o
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> new file mode 100644
>> index 000000000000..69c36749dd98
>> --- /dev/null
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -0,0 +1,388 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2023 ARM Ltd.
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/export.h>
>> +#include <asm/tlbflush.h>
>> +
>> +static inline bool mm_is_user(struct mm_struct *mm)
>> +{
>> +    /*
>> +     * Don't attempt to apply the contig bit to kernel mappings, because
>> +     * dynamically adding/removing the contig bit can cause page faults.
>> +     * These racing faults are ok for user space, since they get serialized
>> +     * on the PTL. But kernel mappings can't tolerate faults.
>> +     */
>> +    return mm != &init_mm;
>> +}
>> +
>> +static inline pte_t *contpte_align_down(pte_t *ptep)
>> +{
>> +    return (pte_t *)(ALIGN_DOWN((unsigned long)ptep >> 3, CONT_PTES) << 3);
>> +}
>> +
>> +static void ptep_clear_flush_range(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, int nr)
>> +{
>> +    struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
>> +    unsigned long start_addr = addr;
>> +    int i;
>> +
>> +    for (i = 0; i < nr; i++, ptep++, addr += PAGE_SIZE)
>> +        __pte_clear(mm, addr, ptep);
>> +
>> +    __flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>> +}
>> +
>> +static bool ptep_any_valid(pte_t *ptep, int nr)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < nr; i++, ptep++) {
>> +        if (pte_valid(__ptep_get(ptep)))
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>> +                pte_t *ptep, pte_t pte)
>> +{
>> +    struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
>> +    unsigned long start_addr;
>> +    pte_t *start_ptep;
>> +    int i;
>> +
>> +    start_ptep = ptep = contpte_align_down(ptep);
>> +    start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>> +    pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
>> +
>> +    for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE) {
>> +        pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
>> +
>> +        if (pte_dirty(ptent))
>> +            pte = pte_mkdirty(pte);
>> +
>> +        if (pte_young(ptent))
>> +            pte = pte_mkyoung(pte);
>> +    }
>> +
>> +    __flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>> +
>> +    __set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>> +}
>> +
>> +void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>> +            pte_t *ptep, pte_t pte)
>> +{
>> +    /*
>> +     * We have already checked that the virtual and pysical addresses are
>> +     * correctly aligned for a contpte mapping in contpte_try_fold() so the
>> +     * remaining checks are to ensure that the contpte range is fully
>> +     * covered by a single folio, and ensure that all the ptes are valid
>> +     * with contiguous PFNs and matching prots. We ignore the state of the
>> +     * access and dirty bits for the purpose of deciding if its a contiguous
>> +     * range; the folding process will generate a single contpte entry which
>> +     * has a single access and dirty bit. Those 2 bits are the logical OR of
>> +     * their respective bits in the constituent pte entries. In order to
>> +     * ensure the contpte range is covered by a single folio, we must
>> +     * recover the folio from the pfn, but special mappings don't have a
>> +     * folio backing them. Fortunately contpte_try_fold() already checked
>> +     * that the pte is not special - we never try to fold special mappings.
>> +     * Note we can't use vm_normal_page() for this since we don't have the
>> +     * vma.
>> +     */
>> +
>> +    unsigned long folio_saddr;
>> +    unsigned long folio_eaddr;
>> +    unsigned long cont_saddr;
>> +    unsigned long cont_eaddr;
>> +    struct folio *folio;
>> +    struct page *page;
>> +    unsigned long pfn;
>> +    pte_t *orig_ptep;
>> +    pgprot_t prot;
>> +    pte_t subpte;
>> +    int i;
>> +
>> +    if (!mm_is_user(mm))
>> +        return;
>> +
>> +    page = pte_page(pte);
>> +    folio = page_folio(page);
>> +    folio_saddr = addr - (page - &folio->page) * PAGE_SIZE;
>> +    folio_eaddr = folio_saddr + folio_nr_pages(folio) * PAGE_SIZE;
>> +    cont_saddr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>> +    cont_eaddr = cont_saddr + CONT_PTE_SIZE;
>> +
>> +    if (folio_saddr > cont_saddr || folio_eaddr < cont_eaddr)
>> +        return;
>> +
>> +    pfn = pte_pfn(pte) - ((addr - cont_saddr) >> PAGE_SHIFT);
>> +    prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
>> +    orig_ptep = ptep;
>> +    ptep = contpte_align_down(ptep);
>> +
>> +    for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
>> +        subpte = __ptep_get(ptep);
>> +        subpte = pte_mkold(pte_mkclean(subpte));
>> +
>> +        if (!pte_valid(subpte) ||
>> +            pte_pfn(subpte) != pfn ||
>> +            pgprot_val(pte_pgprot(subpte)) != pgprot_val(prot))
>> +            return;
>> +    }
>> +
>> +    pte = pte_mkcont(pte);
>> +    contpte_convert(mm, addr, orig_ptep, pte);
>> +}
>> +EXPORT_SYMBOL(__contpte_try_fold);
>> +
>> +void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>> +            pte_t *ptep, pte_t pte)
>> +{
>> +    /*
>> +     * We have already checked that the ptes are contiguous in
>> +     * contpte_try_unfold(), so just check that the mm is user space.
>> +     */
>> +
>> +    if (!mm_is_user(mm))
>> +        return;
>> +
>> +    pte = pte_mknoncont(pte);
>> +    contpte_convert(mm, addr, ptep, pte);
>> +}
>> +EXPORT_SYMBOL(__contpte_try_unfold);
>> +
>> +pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>> +{
>> +    /*
>> +     * Gather access/dirty bits, which may be populated in any of the ptes
>> +     * of the contig range. We are guarranteed to be holding the PTL, so any
>> +     * contiguous range cannot be unfolded or otherwise modified under our
>> +     * feet.
>> +     */
>> +
>> +    pte_t pte;
>> +    int i;
>> +
>> +    ptep = contpte_align_down(ptep);
>> +
>> +    for (i = 0; i < CONT_PTES; i++, ptep++) {
>> +        pte = __ptep_get(ptep);
>> +
>> +        if (pte_dirty(pte))
>> +            orig_pte = pte_mkdirty(orig_pte);
>> +
>> +        if (pte_young(pte))
>> +            orig_pte = pte_mkyoung(orig_pte);
>> +    }
>> +
>> +    return orig_pte;
>> +}
>> +EXPORT_SYMBOL(contpte_ptep_get);
>> +
>> +pte_t contpte_ptep_get_lockless(pte_t *orig_ptep)
>> +{
>> +    /*
>> +     * Gather access/dirty bits, which may be populated in any of the ptes
>> +     * of the contig range. We may not be holding the PTL, so any contiguous
>> +     * range may be unfolded/modified/refolded under our feet. Therefore we
>> +     * ensure we read a _consistent_ contpte range by checking that all ptes
>> +     * in the range are valid and have CONT_PTE set, that all pfns are
>> +     * contiguous and that all pgprots are the same (ignoring access/dirty).
>> +     * If we find a pte that is not consistent, then we must be racing with
>> +     * an update so start again. If the target pte does not have CONT_PTE
>> +     * set then that is considered consistent on its own because it is not
>> +     * part of a contpte range.
>> +     */
>> +
>> +    pgprot_t orig_prot;
>> +    unsigned long pfn;
>> +    pte_t orig_pte;
>> +    pgprot_t prot;
>> +    pte_t *ptep;
>> +    pte_t pte;
>> +    int i;
>> +
>> +retry:
>> +    orig_pte = __ptep_get(orig_ptep);
>> +
>> +    if (!pte_valid_cont(orig_pte))
>> +        return orig_pte;
>> +
>> +    orig_prot = pte_pgprot(pte_mkold(pte_mkclean(orig_pte)));
>> +    ptep = contpte_align_down(orig_ptep);
>> +    pfn = pte_pfn(orig_pte) - (orig_ptep - ptep);
>> +
>> +    for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
>> +        pte = __ptep_get(ptep);
>> +        prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
>> +
>> +        if (!pte_valid_cont(pte) ||
>> +           pte_pfn(pte) != pfn ||
>> +           pgprot_val(prot) != pgprot_val(orig_prot))
>> +            goto retry;
>> +
>> +        if (pte_dirty(pte))
>> +            orig_pte = pte_mkdirty(orig_pte);
>> +
>> +        if (pte_young(pte))
>> +            orig_pte = pte_mkyoung(orig_pte);
>> +    }
>> +
>> +    return orig_pte;
>> +}
>> +EXPORT_SYMBOL(contpte_ptep_get_lockless);
>> +
>> +void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>> +                    pte_t *ptep, pte_t pte, unsigned int nr)
>> +{
>> +    unsigned long next;
>> +    unsigned long end;
>> +    unsigned long pfn;
>> +    pgprot_t prot;
>> +    pte_t orig_pte;
>> +
>> +    if (!mm_is_user(mm))
>> +        return __set_ptes(mm, addr, ptep, pte, nr);
>> +
>> +    end = addr + (nr << PAGE_SHIFT);
>> +    pfn = pte_pfn(pte);
>> +    prot = pte_pgprot(pte);
>> +
>> +    do {
>> +        next = pte_cont_addr_end(addr, end);
>> +        nr = (next - addr) >> PAGE_SHIFT;
>> +        pte = pfn_pte(pfn, prot);
>> +
>> +        if (((addr | next | (pfn << PAGE_SHIFT)) & ~CONT_PTE_MASK) == 0)
>> +            pte = pte_mkcont(pte);
>> +        else
>> +            pte = pte_mknoncont(pte);
>> +
>> +        /*
>> +         * If operating on a partial contiguous range then we must first
>> +         * unfold the contiguous range if it was previously folded.
>> +         * Otherwise we could end up with overlapping tlb entries.
>> +         */
>> +        if (nr != CONT_PTES)
>> +            contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +
>> +        /*
>> +         * If we are replacing ptes that were contiguous or if the new
>> +         * ptes are contiguous and any of the ptes being replaced are
>> +         * valid, we need to clear and flush the range to prevent
>> +         * overlapping tlb entries.
>> +         */
>> +        orig_pte = __ptep_get(ptep);
>> +        if (pte_valid_cont(orig_pte) ||
>> +            (pte_cont(pte) && ptep_any_valid(ptep, nr)))
>> +            ptep_clear_flush_range(mm, addr, ptep, nr);
>> +
>> +        __set_ptes(mm, addr, ptep, pte, nr);
>> +
>> +        addr = next;
>> +        ptep += nr;
>> +        pfn += nr;
>> +
>> +    } while (addr != end);
>> +}
>> +EXPORT_SYMBOL(contpte_set_ptes);
>> +
>> +int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>> +                    unsigned long addr, pte_t *ptep)
>> +{
>> +    /*
>> +     * ptep_clear_flush_young() technically requires us to clear the access
>> +     * flag for a _single_ pte. However, the core-mm code actually tracks
>> +     * access/dirty per folio, not per page. And since we only create a
>> +     * contig range when the range is covered by a single folio, we can get
>> +     * away with clearing young for the whole contig range here, so we avoid
>> +     * having to unfold.
>> +     */
>> +
>> +    int young = 0;
>> +    int i;
>> +
>> +    ptep = contpte_align_down(ptep);
>> +    addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>> +
>> +    for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
>> +        young |= __ptep_test_and_clear_young(vma, addr, ptep);
>> +
>> +    return young;
>> +}
>> +EXPORT_SYMBOL(contpte_ptep_test_and_clear_young);
>> +
>> +int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>> +                    unsigned long addr, pte_t *ptep)
>> +{
>> +    int young;
>> +
>> +    young = contpte_ptep_test_and_clear_young(vma, addr, ptep);
>> +
>> +    if (young) {
>> +        /*
>> +         * See comment in __ptep_clear_flush_young(); same rationale for
>> +         * eliding the trailing DSB applies here.
>> +         */
>> +        addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>> +        __flush_tlb_range_nosync(vma, addr, addr + CONT_PTE_SIZE,
>> +                     PAGE_SIZE, true, 3);
>> +    }
>> +
>> +    return young;
>> +}
>> +EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
>> +
>> +int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>> +                    unsigned long addr, pte_t *ptep,
>> +                    pte_t entry, int dirty)
>> +{
>> +    unsigned long start_addr;
>> +    pte_t orig_pte;
>> +    int i;
>> +
>> +    /*
>> +     * Gather the access/dirty bits for the contiguous range. If nothing has
>> +     * changed, its a noop.
>> +     */
>> +    orig_pte = pte_mknoncont(ptep_get(ptep));
>> +    if (pte_val(orig_pte) == pte_val(entry))
>> +        return 0;
>> +
>> +    /*
>> +     * We can fix up access/dirty bits without having to unfold/fold the
>> +     * contig range. But if the write bit is changing, we need to go through
>> +     * the full unfold/fold cycle.
>> +     */
>> +    if (pte_write(orig_pte) == pte_write(entry)) {
>> +        /*
>> +         * For HW access management, we technically only need to update
>> +         * the flag on a single pte in the range. But for SW access
>> +         * management, we need to update all the ptes to prevent extra
>> +         * faults. Avoid per-page tlb flush in __ptep_set_access_flags()
>> +         * and instead flush the whole range at the end.
>> +         */
>> +        ptep = contpte_align_down(ptep);
>> +        start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>> +
>> +        for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
>> +            __ptep_set_access_flags(vma, addr, ptep, entry, 0);
> 
> 
> entry was pte_mknoncont() in ptep_set_access_flags() so here you lose the
> contpte range, is that intentional? Or am I mistaken?

entry doesn't have PTE_CONT bit set, that's correct. I intentionally strip that
bit at the interface boundary, because it is the implementation's job to decide
whether its a contpte block, not the caller's. But there are situations where
the caller can end up with a pte that has PTE_CONT set (by having done a
previous ptep_get() for example) and then it forwards the pte to a setter. So
stripping it is required; It would probably be cleaner to strip it before
returning it from ptep_get(), but that would be problematic for pte_leaf_size()
which is called from perf_get_pgtable_size().

In this particular case, __ptep_set_access_flags() only modifies the PTE's
access flags, so CONT_PTE will remain as it is in the page table. The fact that
entry has it cleared is not a problem.

Thanks,
Ryan


> 
> 
>> +
>> +        if (dirty)
>> +            __flush_tlb_range(vma, start_addr, addr,
>> +                            PAGE_SIZE, true, 3);
>> +    } else {
>> +        __contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
>> +        __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
>> +        contpte_try_fold(vma->vm_mm, addr, ptep, entry);
>> +    }
>> +
>> +    return 1;
>> +}
>> +EXPORT_SYMBOL(contpte_ptep_set_access_flags);


