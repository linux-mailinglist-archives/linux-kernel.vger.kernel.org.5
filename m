Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1C7F4037
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbjKVIgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjKVIgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:36:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7D486109
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:36:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC36B1595;
        Wed, 22 Nov 2023 00:36:48 -0800 (PST)
Received: from [10.57.72.55] (unknown [10.57.72.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 857E83F73F;
        Wed, 22 Nov 2023 00:35:58 -0800 (PST)
Message-ID: <11d8391a-96ad-4d91-a761-8675fb0bd509@arm.com>
Date:   Wed, 22 Nov 2023 08:35:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] arm64/mm: Wire up PTE_CONT for user mappings
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
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-13-ryan.roberts@arm.com>
 <87v89vmjus.fsf@nvdebian.thelocal>
 <bc49d4df-5d64-4eaf-951c-37dc5d4389d4@arm.com>
 <87il5umijf.fsf@nvdebian.thelocal>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87il5umijf.fsf@nvdebian.thelocal>
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

On 22/11/2023 06:01, Alistair Popple wrote:
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 21/11/2023 11:22, Alistair Popple wrote:
>>>
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>> [...]
>>>
>>>> +static void contpte_fold(struct mm_struct *mm, unsigned long addr,
>>>> +			pte_t *ptep, pte_t pte, bool fold)
>>>> +{
>>>> +	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
>>>> +	unsigned long start_addr;
>>>> +	pte_t *start_ptep;
>>>> +	int i;
>>>> +
>>>> +	start_ptep = ptep = contpte_align_down(ptep);
>>>> +	start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>>>> +	pte = pfn_pte(ALIGN_DOWN(pte_pfn(pte), CONT_PTES), pte_pgprot(pte));
>>>> +	pte = fold ? pte_mkcont(pte) : pte_mknoncont(pte);
>>>> +
>>>> +	for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE) {
>>>> +		pte_t ptent = __ptep_get_and_clear(mm, addr, ptep);
>>>> +
>>>> +		if (pte_dirty(ptent))
>>>> +			pte = pte_mkdirty(pte);
>>>> +
>>>> +		if (pte_young(ptent))
>>>> +			pte = pte_mkyoung(pte);
>>>> +	}
>>>> +
>>>> +	__flush_tlb_range(&vma, start_addr, addr, PAGE_SIZE, true, 3);
>>>> +
>>>> +	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>>>> +}
>>>> +
>>>> +void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
>>>> +			pte_t *ptep, pte_t pte)
>>>> +{
>>>> +	/*
>>>> +	 * We have already checked that the virtual and pysical addresses are
>>>> +	 * correctly aligned for a contpte mapping in contpte_try_fold() so the
>>>> +	 * remaining checks are to ensure that the contpte range is fully
>>>> +	 * covered by a single folio, and ensure that all the ptes are valid
>>>> +	 * with contiguous PFNs and matching prots. We ignore the state of the
>>>> +	 * access and dirty bits for the purpose of deciding if its a contiguous
>>>> +	 * range; the folding process will generate a single contpte entry which
>>>> +	 * has a single access and dirty bit. Those 2 bits are the logical OR of
>>>> +	 * their respective bits in the constituent pte entries. In order to
>>>> +	 * ensure the contpte range is covered by a single folio, we must
>>>> +	 * recover the folio from the pfn, but special mappings don't have a
>>>> +	 * folio backing them. Fortunately contpte_try_fold() already checked
>>>> +	 * that the pte is not special - we never try to fold special mappings.
>>>> +	 * Note we can't use vm_normal_page() for this since we don't have the
>>>> +	 * vma.
>>>> +	 */
>>>> +
>>>> +	struct page *page = pte_page(pte);
>>>> +	struct folio *folio = page_folio(page);
>>>> +	unsigned long folio_saddr = addr - (page - &folio->page) * PAGE_SIZE;
>>>> +	unsigned long folio_eaddr = folio_saddr + folio_nr_pages(folio) * PAGE_SIZE;
>>>> +	unsigned long cont_saddr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
>>>> +	unsigned long cont_eaddr = cont_saddr + CONT_PTE_SIZE;
>>>> +	unsigned long pfn;
>>>> +	pgprot_t prot;
>>>> +	pte_t subpte;
>>>> +	pte_t *orig_ptep;
>>>> +	int i;
>>>> +
>>>> +	if (folio_saddr > cont_saddr || folio_eaddr < cont_eaddr)
>>>> +		return;
>>>> +
>>>> +	pfn = pte_pfn(pte) - ((addr - cont_saddr) >> PAGE_SHIFT);
>>>> +	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
>>>> +	orig_ptep = ptep;
>>>> +	ptep = contpte_align_down(ptep);
>>>> +
>>>> +	for (i = 0; i < CONT_PTES; i++, ptep++, pfn++) {
>>>> +		subpte = __ptep_get(ptep);
>>>> +		subpte = pte_mkold(pte_mkclean(subpte));
>>>> +
>>>> +		if (!pte_valid(subpte) ||
>>>> +		    pte_pfn(subpte) != pfn ||
>>>> +		    pgprot_val(pte_pgprot(subpte)) != pgprot_val(prot))
>>>> +			return;
>>>> +	}
>>>> +
>>>> +	contpte_fold(mm, addr, orig_ptep, pte, true);
>>>> +}
>>>> +EXPORT_SYMBOL(__contpte_try_fold);
>>>> +
>>>> +void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>>>> +			pte_t *ptep, pte_t pte)
>>>> +{
>>>> +	/*
>>>> +	 * We have already checked that the ptes are contiguous in
>>>> +	 * contpte_try_unfold(), so we can unfold unconditionally here.
>>>> +	 */
>>>> +
>>>> +	contpte_fold(mm, addr, ptep, pte, false);
>>>
>>> I'm still working my way through the series but 
>>
>> Thanks for taking the time to review!
>>
>>> calling a fold during an
>>> unfold stood out as it seemed wrong. Obviously further reading revealed
>>> the boolean flag that changes the functions meaning but I think it would
>>> be better to refactor that.
>>
>> Yes that sounds reasonable.
>>
>>>
>>> We could easily rename contpte_fold() to eg. set_cont_ptes() and factor
>>> the pte calculation loop into a separate helper
>>> (eg. calculate_contpte_dirty_young() or some hopefully better name)
>>> called further up the stack. That has an added benefit of providing a
>>> spot to add the nice comment for young/dirty rules you provided in the
>>> patch description ;-)
>>>
>>> In other words we'd have something like:
>>>
>>> void __contpte_try_unfold() {
>>>      pte = calculate_contpte_dirty_young(mm, addr, ptep, pte);
>>>      pte = pte_mknoncont(pte);
>>>      set_cont_ptes(mm, addr, ptep, pte);
>>> }
>>
>> My concern with this approach is that calculate_contpte_dirty_young() has side
>> effects; it has to clear each PTE as it loops through it prevent a race between
>> our reading access/dirty and another thread causing access/dirty to be set. So
>> its not just a "calculation", its the teardown portion of the process too. I
>> guess its a taste thing, so happy for it to be argued the other way, but I would
>> prefer to keep it all together in one function.
>>
>> How about renaming contpte_fold() to contpte_convert() or contpte_repaint()
>> (other suggestions welcome), and extracting the pte_mkcont()/pte_mknoncont()
>> part (so we can remove the bool param):
>>
>> void __contpte_try_unfold() {
>> 	pte = pte_mknoncont(pte);
>> 	contpte_convert(mm, addr, ptep, pte);
>> }
> 
> Thanks. That works for me, although sadly I don't have any better ideas
> for names atm.

Thanks - I'll make this change for v3 and go with contpte_convert().

> 
>  - Alistair
> 
>> Thanks,
>> Ryan
>>
>>>
>>> Which IMHO is more immediately understandable.
>>>
>>>  - Alistair
>>>
> 

