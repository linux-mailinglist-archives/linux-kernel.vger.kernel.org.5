Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5C80EAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346329AbjLLLvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:51:52 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE3B4C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:51:57 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8611143D;
        Tue, 12 Dec 2023 03:52:43 -0800 (PST)
Received: from [10.1.39.183] (XHFQ2J9959.cambridge.arm.com [10.1.39.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44CDF3F762;
        Tue, 12 Dec 2023 03:51:54 -0800 (PST)
Message-ID: <f6792c43-1305-4c79-8bfb-c77919f0d0a1@arm.com>
Date:   Tue, 12 Dec 2023 11:51:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-2-ryan.roberts@arm.com>
 <87lea5a5qm.fsf@nvdebian.thelocal>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87lea5a5qm.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 00:32, Alistair Popple wrote:
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
> <snip>
> 
>>  /*
>>   * On some architectures hardware does not set page access bit when accessing
>>   * memory page, it is responsibility of software setting this bit. It brings
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 1f18ed4a5497..8a87a488950c 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -924,68 +924,162 @@ copy_present_page(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
>>  	return 0;
>>  }
>>  
>> +static int folio_nr_pages_cont_mapped(struct folio *folio,
>> +				      struct page *page, pte_t *pte,
>> +				      unsigned long addr, unsigned long end,
>> +				      pte_t ptent, bool enforce_uffd_wp,
>> +				      int *dirty_nr, int *writable_nr)
>> +{
>> +	int floops;
>> +	int i;
>> +	unsigned long pfn;
>> +	bool prot_none;
>> +	bool uffd_wp;
>> +
>> +	if (!folio_test_large(folio))
>> +		return 1;
>> +
>> +	/*
>> +	 * Loop either to `end` or to end of folio if its contiguously mapped,
>> +	 * whichever is smaller.
>> +	 */
>> +	floops = (end - addr) >> PAGE_SHIFT;
>> +	floops = min_t(int, floops,
>> +		       folio_pfn(folio_next(folio)) - page_to_pfn(page));
> 
> Much better, thanks for addressing my comments here.
> 
>> +
>> +	pfn = page_to_pfn(page);
>> +	prot_none = pte_protnone(ptent);
>> +	uffd_wp = pte_uffd_wp(ptent);
>> +
>> +	*dirty_nr = !!pte_dirty(ptent);
>> +	*writable_nr = !!pte_write(ptent);
>> +
>> +	pfn++;
>> +	pte++;
>> +
>> +	for (i = 1; i < floops; i++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (!pte_present(ptent) || pte_pfn(ptent) != pfn ||
>> +		    prot_none != pte_protnone(ptent) ||
>> +		    (enforce_uffd_wp && uffd_wp != pte_uffd_wp(ptent)))
>> +			break;
>> +
>> +		if (pte_dirty(ptent))
>> +			(*dirty_nr)++;
>> +		if (pte_write(ptent))
>> +			(*writable_nr)++;
>> +
>> +		pfn++;
>> +		pte++;
>> +	}
>> +
>> +	return i;
>> +}
>> +
>>  /*
>> - * Copy one pte.  Returns 0 if succeeded, or -EAGAIN if one preallocated page
>> - * is required to copy this pte.
>> + * Copy set of contiguous ptes.  Returns number of ptes copied if succeeded
>> + * (always gte 1), or -EAGAIN if one preallocated page is required to copy the
>> + * first pte.
>>   */
>>  static inline int
>> -copy_present_pte(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>> -		 pte_t *dst_pte, pte_t *src_pte, unsigned long addr, int *rss,
>> -		 struct folio **prealloc)
>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>> +		  pte_t *dst_pte, pte_t *src_pte,
>> +		  unsigned long addr, unsigned long end,
>> +		  int *rss, struct folio **prealloc)
>>  {
>>  	struct mm_struct *src_mm = src_vma->vm_mm;
>>  	unsigned long vm_flags = src_vma->vm_flags;
>>  	pte_t pte = ptep_get(src_pte);
>>  	struct page *page;
>>  	struct folio *folio;
>> +	int nr = 1;
>> +	bool anon = false;
>> +	bool enforce_uffd_wp = userfaultfd_wp(dst_vma);
>> +	int nr_dirty = !!pte_dirty(pte);
>> +	int nr_writable = !!pte_write(pte);
>> +	int i, ret;
>>  
>>  	page = vm_normal_page(src_vma, addr, pte);
>> -	if (page)
>> +	if (page) {
>>  		folio = page_folio(page);
>> -	if (page && folio_test_anon(folio)) {
>> -		/*
>> -		 * If this page may have been pinned by the parent process,
>> -		 * copy the page immediately for the child so that we'll always
>> -		 * guarantee the pinned page won't be randomly replaced in the
>> -		 * future.
>> -		 */
>> -		folio_get(folio);
>> -		if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
>> -			/* Page may be pinned, we have to copy. */
>> -			folio_put(folio);
>> -			return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>> -						 addr, rss, prealloc, page);
>> +		anon = folio_test_anon(folio);
>> +		nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr, end,
>> +						pte, enforce_uffd_wp, &nr_dirty,
>> +						&nr_writable);
>> +		folio_ref_add(folio, nr);
>> +
>> +		for (i = 0; i < nr; i++, page++) {
>> +			if (anon) {
>> +				/*
>> +				 * If this page may have been pinned by the
>> +				 * parent process, copy the page immediately for
>> +				 * the child so that we'll always guarantee the
>> +				 * pinned page won't be randomly replaced in the
>> +				 * future.
>> +				 */
>> +				if (unlikely(page_try_dup_anon_rmap(
>> +						page, false, src_vma))) {
>> +					if (i != 0)
>> +						break;
>> +					/* Page may be pinned, we have to copy. */
>> +					folio_ref_sub(folio, nr);
>> +					ret = copy_present_page(
>> +						dst_vma, src_vma, dst_pte,
>> +						src_pte, addr, rss, prealloc,
>> +						page);
>> +					return ret == 0 ? 1 : ret;
>> +				}
>> +				rss[MM_ANONPAGES]++;
>> +				VM_BUG_ON(PageAnonExclusive(page));
>> +			} else {
>> +				page_dup_file_rmap(page, false);
>> +				rss[mm_counter_file(page)]++;
>> +			}
>>  		}
>> -		rss[MM_ANONPAGES]++;
>> -	} else if (page) {
>> -		folio_get(folio);
>> -		page_dup_file_rmap(page, false);
>> -		rss[mm_counter_file(page)]++;
>> -	}
>>  
>> -	/*
>> -	 * If it's a COW mapping, write protect it both
>> -	 * in the parent and the child
>> -	 */
>> -	if (is_cow_mapping(vm_flags) && pte_write(pte)) {
>> -		ptep_set_wrprotect(src_mm, addr, src_pte);
>> -		pte = pte_wrprotect(pte);
>> +		if (i < nr) {
>> +			folio_ref_sub(folio, nr - i);
>> +			nr = i;
>> +		}
>>  	}
>> -	VM_BUG_ON(page && folio_test_anon(folio) && PageAnonExclusive(page));
>>  
>>  	/*
>> -	 * If it's a shared mapping, mark it clean in
>> -	 * the child
>> +	 * If it's a shared mapping, mark it clean and write protected in the
>> +	 * child, and rely on a write fault to fix up the permissions. This
>> +	 * allows determining batch size without having to consider RO/RW
>> +	 * permissions. As an optimization, skip wrprotect if all ptes in the
>> +	 * batch have the same permissions.
>> +	 *
>> +	 * If its a private (CoW) mapping, mark it dirty in the child if _any_
>> +	 * of the parent mappings in the block were marked dirty. The contiguous
>> +	 * block of mappings are all backed by the same folio, so if any are
>> +	 * dirty then the whole folio is dirty. This allows determining batch
>> +	 * size without having to consider the dirty bit. Further, write protect
>> +	 * it both in the parent and the child so that a future write will cause
>> +	 * a CoW. As as an optimization, skip the wrprotect if all the ptes in
>> +	 * the batch are already readonly.
>>  	 */
>> -	if (vm_flags & VM_SHARED)
>> +	if (vm_flags & VM_SHARED) {
>>  		pte = pte_mkclean(pte);
>> -	pte = pte_mkold(pte);
>> +		if (nr_writable > 0 && nr_writable < nr)
>> +			pte = pte_wrprotect(pte);
>> +	} else {
>> +		if (nr_dirty)
>> +			pte = pte_mkdirty(pte);
>> +		if (nr_writable) {
>> +			ptep_set_wrprotects(src_mm, addr, src_pte, nr);
>> +			pte = pte_wrprotect(pte);
>> +		}
>> +	}
>>  
>> -	if (!userfaultfd_wp(dst_vma))
>> +	pte = pte_mkold(pte);
>> +	pte = pte_clear_soft_dirty(pte);
>> +	if (!enforce_uffd_wp)
>>  		pte = pte_clear_uffd_wp(pte);
>>  
>> -	set_pte_at(dst_vma->vm_mm, addr, dst_pte, pte);
>> -	return 0;
>> +	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
>> +	return nr;
> 
> I don't have any further comments and you have addressed my previous
> ones so feel free to add:
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> 
> However whilst I think the above CoW sequence looks correct it would be
> nice if someone else could take a look as well.

Thanks for the RB! David has taken a look at the CoW part and helped develop the
logic, so I'm pretty confident in it.

However, David also sent me some microbenchmarks for fork, DONTNEED, munmap, etc
for order-0 and PTE-mapped THP (2M). I'm seeing a ferw performance regressions
with those, which I'm currently trying to resolve. At the moment it's looking
like I'll have to expose some function to allow the core code to skip forward a
number of ptes so that in the contpte-mapped case, the core code only does
ptep_get() once per contpte block. As a result there will be some churn here.

I'm currently working out some bugs and hope to post an updated series with perf
numbers for those microbenchmarks by the end of the week, all being well.

> 
>>  }
>>  
>>  static inline struct folio *page_copy_prealloc(struct mm_struct *src_mm,
>> @@ -1021,6 +1115,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>  	int rss[NR_MM_COUNTERS];
>>  	swp_entry_t entry = (swp_entry_t){0};
>>  	struct folio *prealloc = NULL;
>> +	int nr_ptes;
>>  
>>  again:
>>  	progress = 0;
>> @@ -1051,6 +1146,8 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>  	arch_enter_lazy_mmu_mode();
>>  
>>  	do {
>> +		nr_ptes = 1;
>> +
>>  		/*
>>  		 * We are holding two locks at this point - either of them
>>  		 * could generate latencies in another task on another CPU.
>> @@ -1086,16 +1183,21 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>  			 * the now present pte.
>>  			 */
>>  			WARN_ON_ONCE(ret != -ENOENT);
>> +			ret = 0;
>>  		}
>> -		/* copy_present_pte() will clear `*prealloc' if consumed */
>> -		ret = copy_present_pte(dst_vma, src_vma, dst_pte, src_pte,
>> -				       addr, rss, &prealloc);
>> +		/* copy_present_ptes() will clear `*prealloc' if consumed */
>> +		nr_ptes = copy_present_ptes(dst_vma, src_vma, dst_pte, src_pte,
>> +					    addr, end, rss, &prealloc);
>> +
>>  		/*
>>  		 * If we need a pre-allocated page for this pte, drop the
>>  		 * locks, allocate, and try again.
>>  		 */
>> -		if (unlikely(ret == -EAGAIN))
>> +		if (unlikely(nr_ptes == -EAGAIN)) {
>> +			ret = -EAGAIN;
>>  			break;
>> +		}
>> +
>>  		if (unlikely(prealloc)) {
>>  			/*
>>  			 * pre-alloc page cannot be reused by next time so as
>> @@ -1106,8 +1208,9 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>  			folio_put(prealloc);
>>  			prealloc = NULL;
>>  		}
>> -		progress += 8;
>> -	} while (dst_pte++, src_pte++, addr += PAGE_SIZE, addr != end);
>> +		progress += 8 * nr_ptes;
>> +	} while (dst_pte += nr_ptes, src_pte += nr_ptes,
>> +		 addr += PAGE_SIZE * nr_ptes, addr != end);
>>  
>>  	arch_leave_lazy_mmu_mode();
>>  	pte_unmap_unlock(orig_src_pte, src_ptl);
> 

