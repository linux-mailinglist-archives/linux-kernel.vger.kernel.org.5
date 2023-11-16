Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCC7EDE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjKPK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjKPK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:26:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDC68B8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:26:42 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6E571595;
        Thu, 16 Nov 2023 02:27:28 -0800 (PST)
Received: from [10.1.35.163] (XHFQ2J9959.cambridge.arm.com [10.1.35.163])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0F43F6C4;
        Thu, 16 Nov 2023 02:26:39 -0800 (PST)
Message-ID: <e53b7fe9-d2f7-4e4b-9313-3ea015128d74@arm.com>
Date:   Thu, 16 Nov 2023 10:26:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-2-ryan.roberts@arm.com>
 <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <271f1e98-6217-4b40-bae0-0ac9fe5851cb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 10:03, David Hildenbrand wrote:
> On 15.11.23 17:30, Ryan Roberts wrote:
>> Convert copy_pte_range() to copy a set of ptes in a batch. A given batch
>> maps a physically contiguous block of memory, all belonging to the same
>> folio, with the same permissions, and for shared mappings, the same
>> dirty state. This will likely improve performance by a tiny amount due
>> to batching the folio reference count management and calling set_ptes()
>> rather than making individual calls to set_pte_at().
>>
>> However, the primary motivation for this change is to reduce the number
>> of tlb maintenance operations that the arm64 backend has to perform
>> during fork, as it is about to add transparent support for the
>> "contiguous bit" in its ptes. By write-protecting the parent using the
>> new ptep_set_wrprotects() (note the 's' at the end) function, the
>> backend can avoid having to unfold contig ranges of PTEs, which is
>> expensive, when all ptes in the range are being write-protected.
>> Similarly, by using set_ptes() rather than set_pte_at() to set up ptes
>> in the child, the backend does not need to fold a contiguous range once
>> they are all populated - they can be initially populated as a contiguous
>> range in the first place.
>>
>> This change addresses the core-mm refactoring only, and introduces
>> ptep_set_wrprotects() with a default implementation that calls
>> ptep_set_wrprotect() for each pte in the range. A separate change will
>> implement ptep_set_wrprotects() in the arm64 backend to realize the
>> performance improvement as part of the work to enable contpte mappings.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   include/linux/pgtable.h |  13 +++
>>   mm/memory.c             | 175 +++++++++++++++++++++++++++++++---------
>>   2 files changed, 150 insertions(+), 38 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index af7639c3b0a3..1c50f8a0fdde 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -622,6 +622,19 @@ static inline void ptep_set_wrprotect(struct mm_struct
>> *mm, unsigned long addres
>>   }
>>   #endif
>>   +#ifndef ptep_set_wrprotects
>> +struct mm_struct;
>> +static inline void ptep_set_wrprotects(struct mm_struct *mm,
>> +                unsigned long address, pte_t *ptep,
>> +                unsigned int nr)
>> +{
>> +    unsigned int i;
>> +
>> +    for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>> +        ptep_set_wrprotect(mm, address, ptep);
>> +}
>> +#endif
>> +
>>   /*
>>    * On some architectures hardware does not set page access bit when accessing
>>    * memory page, it is responsibility of software setting this bit. It brings
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1f18ed4a5497..b7c8228883cf 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -921,46 +921,129 @@ copy_present_page(struct vm_area_struct *dst_vma,
>> struct vm_area_struct *src_vma
>>           /* Uffd-wp needs to be delivered to dest pte as well */
>>           pte = pte_mkuffd_wp(pte);
>>       set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>> -    return 0;
>> +    return 1;
>> +}
>> +
>> +static inline unsigned long page_cont_mapped_vaddr(struct page *page,
>> +                struct page *anchor, unsigned long anchor_vaddr)
>> +{
>> +    unsigned long offset;
>> +    unsigned long vaddr;
>> +
>> +    offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
>> +    vaddr = anchor_vaddr + offset;
>> +
>> +    if (anchor > page) {
>> +        if (vaddr > anchor_vaddr)
>> +            return 0;
>> +    } else {
>> +        if (vaddr < anchor_vaddr)
>> +            return ULONG_MAX;
>> +    }
>> +
>> +    return vaddr;
>> +}
>> +
>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>> +                      struct page *page, pte_t *pte,
>> +                      unsigned long addr, unsigned long end,
>> +                      pte_t ptent, bool *any_dirty)
>> +{
>> +    int floops;
>> +    int i;
>> +    unsigned long pfn;
>> +    pgprot_t prot;
>> +    struct page *folio_end;
>> +
>> +    if (!folio_test_large(folio))
>> +        return 1;
>> +
>> +    folio_end = &folio->page + folio_nr_pages(folio);
>> +    end = min(page_cont_mapped_vaddr(folio_end, page, addr), end);
>> +    floops = (end - addr) >> PAGE_SHIFT;
>> +    pfn = page_to_pfn(page);
>> +    prot = pte_pgprot(pte_mkold(pte_mkclean(ptent)));
>> +
>> +    *any_dirty = pte_dirty(ptent);
>> +
>> +    pfn++;
>> +    pte++;
>> +
>> +    for (i = 1; i < floops; i++) {
>> +        ptent = ptep_get(pte);
>> +        ptent = pte_mkold(pte_mkclean(ptent));
>> +
>> +        if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
>> +            pgprot_val(pte_pgprot(ptent)) != pgprot_val(prot))
>> +            break;
>> +
>> +        if (pte_dirty(ptent))
>> +            *any_dirty = true;
>> +
>> +        pfn++;
>> +        pte++;
>> +    }
>> +
>> +    return i;
>>   }
>>     /*
>> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
>> - * is required to copy this pte.
>> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
>> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
>> + * first pte.
>>    */
>>   static inline int
>> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>> -         pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>> -         struct folio **prealloc)
>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct
>> *src_vma,
>> +          pte_t *dst_pte, pte_t *src_pte,
>> +          unsigned long addr, unsigned long end,
>> +          int *rss, struct folio **prealloc)
>>   {
>>       struct mm_struct *src_mm = src_vma->vm_mm;
>>       unsigned long vm_flags = src_vma->vm_flags;
>>       pte_t pte = ptep_get(src_pte);
>>       struct page *page;
>>       struct folio *folio;
>> +    int nr = 1;
>> +    bool anon;
>> +    bool any_dirty = pte_dirty(pte);
>> +    int i;
>>         page = vm_normal_page(src_vma, addr, pte);
>> -    if (page)
>> +    if (page) {
>>           folio = page_folio(page);
>> -    if (page && folio_test_anon(folio)) {
>> -        /*
>> -         * If this page may have been pinned by the parent process,
>> -         * copy the page immediately for the child so that we'll always
>> -         * guarantee the pinned page won't be randomly replaced in the
>> -         * future.
>> -         */
>> -        folio_get(folio);
>> -        if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
>> -            /* Page may be pinned, we have to copy. */
>> -            folio_put(folio);
>> -            return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>> -                         addr, rss, prealloc, page);
>> +        anon = folio_test_anon(folio);
>> +        nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
>> +                        end, pte, &any_dirty);
>> +
>> +        for (i = 0; i < nr; i++, page++) {
>> +            if (anon) {
>> +                /*
>> +                 * If this page may have been pinned by the
>> +                 * parent process, copy the page immediately for
>> +                 * the child so that we'll always guarantee the
>> +                 * pinned page won't be randomly replaced in the
>> +                 * future.
>> +                 */
>> +                if (unlikely(page_try_dup_anon_rmap(
>> +                        page, false, src_vma))) {
>> +                    if (i != 0)
>> +                        break;
>> +                    /* Page may be pinned, we have to copy. */
>> +                    return copy_present_page(
>> +                        dst_vma, src_vma, dst_pte,
>> +                        src_pte, addr, rss, prealloc,
>> +                        page);
>> +                }
>> +                rss[MM_ANONPAGES]++;
>> +                VM_BUG_ON(PageAnonExclusive(page));
>> +            } else {
>> +                page_dup_file_rmap(page, false);
>> +                rss[mm_counter_file(page)]++;
>> +            }
>>           }
>> -        rss[MM_ANONPAGES]++;
>> -    } else if (page) {
>> -        folio_get(folio);
>> -        page_dup_file_rmap(page, false);
>> -        rss[mm_counter_file(page)]++;
>> +
>> +        nr = i;
>> +        folio_ref_add(folio, nr);
> 
> You're changing the order of mapcount vs. refcount increment. Don't. Make sure
> your refcount >= mapcount.

Ouch - good spot.

> 
> You can do that easily by doing the folio_ref_add(folio, nr) first and then
> decrementing in case of error accordingly. Errors due to pinned pages are the
> corner case.

Yep, propose this for v3:

diff --git a/mm/memory.c b/mm/memory.c
index b7c8228883cf..98373349806e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1014,6 +1014,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct
vm_area_struct *src_vma
                anon = folio_test_anon(folio);
                nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
                                                end, pte, &any_dirty);
+               folio_ref_add(folio, nr);

                for (i = 0; i < nr; i++, page++) {
                        if (anon) {
@@ -1029,6 +1030,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct
vm_area_struct *src_vma
                                        if (i != 0)
                                                break;
                                        /* Page may be pinned, we have to copy. */
+                                       folio_ref_sub(folio, nr);
                                        return copy_present_page(
                                                dst_vma, src_vma, dst_pte,
                                                src_pte, addr, rss, prealloc,
@@ -1042,8 +1044,10 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct
vm_area_struct *src_vma
                        }
                }

-               nr = i;
-               folio_ref_add(folio, nr);
+               if (i < nr) {
+                       folio_ref_sub(folio, nr - i);
+                       nr = i;
+               }
        }

> 
> I'll note that it will make a lot of sense to have batch variants of
> page_try_dup_anon_rmap() and page_dup_file_rmap().
> 
> Especially, the batch variant of page_try_dup_anon_rmap() would only check once
> if the folio maybe pinned, and in that case, you can simply drop all references
> again. So you either have all or no ptes to process, which makes that code easier.
> 
> But that can be added on top, and I'll happily do that.

That's very kind - thanks for the offer! I'll leave it to you then.

