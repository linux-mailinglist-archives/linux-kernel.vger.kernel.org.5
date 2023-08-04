Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2646976FC47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHDIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjHDIqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:46:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B18944234
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:46:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E1182F4;
        Fri,  4 Aug 2023 01:47:12 -0700 (PDT)
Received: from [10.57.77.247] (unknown [10.57.77.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14D9E3F6C4;
        Fri,  4 Aug 2023 01:46:27 -0700 (PDT)
Message-ID: <a2d71d20-973a-3642-877c-79f86e1acd97@arm.com>
Date:   Fri, 4 Aug 2023 09:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
To:     "Yin, Fengwei" <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        yuzhao@google.com, willy@infradead.org, david@redhat.com,
        shy828301@gmail.com, hughd@google.com
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <502afc9c-0760-76af-d224-2a3428089850@arm.com>
 <66332544-c102-9134-a1a5-c4e4a82b66b9@intel.com>
 <0e7c6b9d-77c4-8c06-4c5a-fdf24c3b003d@arm.com>
 <b9ec207a-8cbc-4014-1fb1-f1f437afd957@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b9ec207a-8cbc-4014-1fb1-f1f437afd957@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 00:15, Yin, Fengwei wrote:
> 
> 
> On 8/3/2023 9:20 PM, Ryan Roberts wrote:
>> On 03/08/2023 11:48, Yin Fengwei wrote:
>>>
>>>
>>> On 8/3/23 17:58, Ryan Roberts wrote:
>>>> On 28/07/2023 08:09, Yin Fengwei wrote:
>>>>> It will be used to check whether the folio is mapped to specific
>>>>> VMA and whether the mapping address of folio is in the range.
>>>>>
>>>>> Also a helper function folio_within_vma() to check whether folio
>>>>> is in the range of vma based on folio_in_range().
>>>>>
>>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>> ---
>>>>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 69 insertions(+)
>>>>>
>>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>>> index 5a03bc4782a2..63de32154a48 100644
>>>>> --- a/mm/internal.h
>>>>> +++ b/mm/internal.h
>>>>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>>>>  				   bool write, int *locked);
>>>>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>>>>  			       unsigned long bytes);
>>>>> +
>>>>
>>>> Hi Yin,
>>>>
>>>> I wanted to take a step back and consolidate my concerns about this function. I
>>>> should say that my understanding of the pgoff and index stuff is shaky and I
>>>> could therefore be wrong about some of this; if this is the case, then sorry for
>>>> the noise! But something about this function doesn't smell right to me, so I
>>>> figure its better to raise it...
>>> No worries. And thank you for looking at the code ans share the comments.
>>> That helps me a lot. Really appreciate it.
>>>
>>>>
>>>>> +/*
>>>>> + * Check whether the folio is in specific range
>>>>
>>>> What exactly is the function trying to do? I *think* the intention is to figure
>>>> out if a folio is fully and contiguously mapped within a range of virtual
>>>> addresses belonging to a specific virtual address space? And I assume you want
>>>> the answer to be precise? I'm assuming 'yes' for the below.
>>>>
>>>> I think the only way to do this is to actually check each PTE. And that causes a
>>>> problem, because a folio can straddle multiple PTE tables, which causes PTL
>>>> locking issues, and means having just a *pte pointer is insufficient if we need
>>>> to traverse multiple pte tables. So perhaps you need to allow for a false
>>>> negative in the case that the folio is not contained within a single pte table.
>>> Let's check the users of this function first:
>>>  mlock/munlock: Needs only care whether the folio is in the range of VM_LOCKED VMA
>>>  madvise: Needs to check whether the folio is in the range of VMA and
>>>           range [start, end).
>>
>> Sure but those 2 ranges (the vma and the user-supplied range) are known to
>> intersect, right? So really there is only one range of interest; the
>> intersection. I would argue that should be done in a higher level wrapper, and
>> is not part of the core primitive to work out if a folio is mapped to a
>> particular range of virtual addresses.
>>> This range is from user space. It could contain
>>>           VMA range (in this case, we only need to check VMA range) or is contained
>>>           by VMA range.
>>>
>>> So we check:
>>>   1. Whether the folio is in the range.
>>>
>>>      To do this, we need to first check whether the folio->index is in the
>>>      VMA range. If not, we know the folio is not in VMA range. Just return false
>>>      without further check.
>>
>> Right, so if the check fails, the folio is definitely not mapped by the vma, but
>> if it passes, it *might* be. Further checks are required. So why is this useful?
>> Why not just do the check that gives you the precise answer and skip this?
> What check can give precise answer? I don't think checking PTE is right at this
> stage. For following case (assume the folio is mapped in same page table and just
> care about the VMA2 range):
> 
> |-----------vma1-----------|------------vma2---------|
>                     |-------folio-----|
> 
> How can we tell whether the folio is in the range of VMA2 by just checking PTE?
> And in this case, why not bail out if we see folio is out range of VMA2?
> 
> 
> So only need to check PTE if we are sure the folio is in the range of VMA2:
> |-----------vma1-----------|------------vma2---------|
>                               |-------folio-----|
> 
>>
>>>
>>>      Then, we will check whether the folio is in the range which is defined as
>>>      [max(start, vma->vm_start), min(end, vma->vm_end)).
>>
>> As par above comment, I would personally factor this out of the primitive.
>>
>>>
>>>
>>>      This is the version in RFC as I was not aware of mremap case and forgot the
>>>      page cache case. So if no mremap with an anonymous folio, this check is enough.
>>>      But we need to add PTE check for mremap and page cache cases.
>>>
>>>   2. Check PTE for mremap in middle of large folio and page cache
>>>      If the folio is normal 4K and if the folio is in the range, it's not possible
>>>      the folio is partially mapped to two different VMA. So we are sure this folio
>>>      is in the range.
>>
>> But you test for small folio and exit early without checking the PTE. Given the
>> index check only told you that the folio *might be* mapped, I don't see how you
>> can return true at this point for a small folio, without looking at the PTE?
> Yes. We can do this. You can check the discussion on the RFC version. I did move
> the normal 4K folio check out of this function. Yu and Huge suggested to just ignore
> the normal 4K as this API can' handle it.
> 
> The thing changed from RFC is that we need to check PTE here. I tried to avoid to
> check PTE even for normal 4K folio.

I'll go read the RFC. I've made my point; if you and others are convinced this
is correct, then fair enough.

> 
>>
>> folio->index is just the page offset within the file it maps (or the (original)
>> VA/PAGE_SIZE for anon memory - I think?). And vma->vm_pgoff is the page offset
>> within the file that the vma starts at. So you could have a folio that contains
>> the contents of 1 file and a vma that maps another file, and the folio's index
>> might fall within the VMA, but it doesn't mean the folio is mapped by the vma;
>> its a different file.
>>
>> Or perhaps there is an assumption in the function's spec that the folio is known
>> to have at least one page mapped in the vma? That would change things... but you
>> should make that very clear in the spec. And in that case, you can move the
>> small folio check to the start and return true immediately.
> Yes. "At least one page mapped in VMA" is assumption here. I will make it clear in
> the comment.
> 
> 
> Regards
> Yin, Fengwei
> 
>>
>>>
>>>      Currently, check PTE didn't handle the case you mentioned. But my plan is
>>>      checking whether the folio is mapped cross page table (by checking whether
>>>      the folio start vaddr and end vaddr has same value for low aligned to PMD_SIZE).
>>>      If it cross, I will treat it as out of VMA range. Otherwise, we can reuse
>>>      current check because we know the PTE pointer is always valid.
>>>
>>>      Obviously, the PTE checking needs hold pte lock as you pointed out.
>>>
>>>
>>> My understanding:
>>> pgoff is important if we have folio and VMA and want to know the virtual address of
>>> the folio mapped to. Like first, check whether pgoff of folio belongs to VMA, then get
>>> vaddr by:
>>>       addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>> rmap_walk() also depends on pgoff. You can check the vma_address() and rmap_walk()
>>> implementation.
>>
>> Yes but the rmap is only traversing vmas that are already known to map the same
>> file that the folio contains pages for. (See rmap_walk_file(): it grabs the
>> "mapping" from the folio, then traverses the list of vmas within the range of
>> interest "vma_interval_tree_foreach"). Its a bit more complicated for anon
>> memory but I think the princple is the same.
>>
>>>
>>>>
>>>>> + *
>>>>> + * First, check whether the folio is in the range of vma.
>>>>> + * Then, check whether the folio is mapped to the range of [start, end].
>>>>> + * In the end, check whether the folio is fully mapped to the range.
>>>>> + *
>>>>> + * @pte page table pointer will be checked whether the large folio
>>>>> + *      is fully mapped to. Currently, if mremap in the middle of
>>>>> + *      large folio, the large folio could be mapped to to different
>>>>> + *      VMA and address check can't identify this situation.
>>>>> + */
>>>>> +static inline bool
>>>>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>>>>> +		unsigned long start, unsigned long end, pte_t *pte)
>>>>
>>>> The prototype looks odd to me; Fundamentally it seems to me that you need the
>>>> folio, start and end virtual addresses (the range you want to check that it is
>>>> in), the pte pointer and the virtual address that the pte represents. That
>>>> virtual address allows you to figure out the offset between the pa and va. Then
>>>> you can look at all the ptes to figure out if they reference the folio's pfns,
>>>> and use the va to pa mapping info to figure out if its within the specified range.
>>>>
>>>> I don't really understand why the vma is useful.
>>>>
>>>>> +{
>>>>> +	pte_t ptent;
>>>>> +	unsigned long i, nr = folio_nr_pages(folio);
>>>>> +	pgoff_t pgoff, addr;
>>>>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>>>>> +
>>>>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>>>>> +
>>>>> +	if (start < vma->vm_start)
>>>>> +		start = vma->vm_start;
>>>>> +	if (end > vma->vm_end)
>>>>> +		end = vma->vm_end;
>>>>> +
>>>>> +	pgoff = folio_pgoff(folio);
>>>>> +	/* if folio start address is not in vma range */
>>>>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>>>>> +		return false;
>>>>
>>>> Why is this pgoff calculation helpful? Surely it's only useful if the folio
>>>> belongs to the same file that the vma is mapping? Otherwise the folio's pgoff
>>>> might be referring to a completely different file than the vma's vm_pgoff. So
>>>> you will get spurious results.
>>>>
>>>>> +
>>>>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>>>>> +	if (addr < start || end - addr < folio_size(folio))
>>>>> +		return false;
>>>>> +
>>>>> +	/* not necessary to check pte for none large folio */
>>>>> +	if (!folio_test_large(folio))
>>>>> +		return true;
>>>>
>>>> I don't understand why you don't need to check the pte for a small folio? As
>>>> above, if the folio doesn't belong to the file that the vma is mapping the above
>>>> checks seem wrong and you can't conclude that the folio is mapped in the range
>>>> without looking at the pte?
>>>>
>>>>> +
>>>>> +	if (!pte)
>>>>> +		return false;
>>>>> +
>>>>> +	/* check whether parameter pte is associated with folio */
>>>>> +	ptent = ptep_get(pte);
>>>>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>>>>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>> +		return false;
>>>>> +
>>>>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>>>>
>>>> I think this could wander off the front or back of the pte table into arbitrary
>>>> memory if the folio is strddling multiple pte tables.
>>>>
>>>>> +	for (i = 0; i < nr; i++, pte++) {
>>>>> +		ptent = ptep_get(pte);
>>>>> +
>>>>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>>>>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>>>>
>>>> Doesn't !pte_present() also cover pte_none()? So I think the pte_none() check is
>>>> redundant?
>>> I think you are right. pte_none() can be removed here.
>>>
>>>
>>> Regards
>>> Yin, Fengwei
>>>
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>
>>>>> +			return false;
>>>>> +	}
>>>>> +
>>>>> +	return true;
>>>>> +}
>>>>> +
>>>>> +static inline bool
>>>>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>>>>> +{
>>>>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * mlock_vma_folio() and munlock_vma_folio():
>>>>>   * should be called with vma's mmap_lock held for read or write,
>>>>
>>

