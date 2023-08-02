Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD2F76CBD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjHBLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjHBLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:35:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7470C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:35:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B87E113E;
        Wed,  2 Aug 2023 04:35:51 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 504F13F6C4;
        Wed,  2 Aug 2023 04:35:06 -0700 (PDT)
Message-ID: <9bba9369-e3f5-53da-bf8f-8ab887d3c3ae@arm.com>
Date:   Wed, 2 Aug 2023 12:35:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] mm: add functions folio_in_range() and
 folio_within_vma()
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        yuzhao@google.com, willy@infradead.org, david@redhat.com,
        shy828301@gmail.com, hughd@google.com
References: <20230728070929.2487065-1-fengwei.yin@intel.com>
 <20230728070929.2487065-2-fengwei.yin@intel.com>
 <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
In-Reply-To: <55c9e3f7-099d-6f57-32da-1f318a9688a0@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 12:14, Ryan Roberts wrote:
> On 28/07/2023 08:09, Yin Fengwei wrote:
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Also a helper function folio_within_vma() to check whether folio
>> is in the range of vma based on folio_in_range().
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 5a03bc4782a2..63de32154a48 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,75 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>  				   bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>  			       unsigned long bytes);
>> +
>> +/*
>> + * Check whether the folio is in specific range
>> + *
>> + * First, check whether the folio is in the range of vma.
>> + * Then, check whether the folio is mapped to the range of [start, end].
>> + * In the end, check whether the folio is fully mapped to the range.
>> + *
>> + * @pte page table pointer will be checked whether the large folio
>> + *      is fully mapped to. Currently, if mremap in the middle of
>> + *      large folio, the large folio could be mapped to to different
>> + *      VMA and address check can't identify this situation.
>> + */
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +		unsigned long start, unsigned long end, pte_t *pte)
> 
> This api seems a bit redundant to me. Wouldn't it be better to remove the vma
> parameter and instead fix up the start/end addresses in folio_within_vma()?

I have created a function as part of my "pte batch-zap" patch set [1], which
counts the number of contiguously mapped pages of a folio
(folio_nr_pages_cont_mapped()). I wonder if actually this should be the
primitive, which can be shared for more cases. Then your folio_within_vma()
function could just compare the nr_pages to folio_nr_pages() to decide if the
folio is fully and contiguously mapped in the VMA.

I also wonder if you should change the name of folio_within_vma() to something
like folio_test_cont_in_vma() to disambiguate from the case where the folio may
be fully mapped with a discontiguity (although perhaps that's not possible
because a mremap would result in distinct vmas... would a new mmap in the hole
cause a merge of all 3?).

[1] https://lore.kernel.org/linux-mm/20230727141837.3386072-4-ryan.roberts@arm.com/

> 
>> +{
>> +	pte_t ptent;
>> +	unsigned long i, nr = folio_nr_pages(folio);
>> +	pgoff_t pgoff, addr;
>> +	unsigned long vma_pglen = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>> +
>> +	VM_WARN_ON_FOLIO(folio_test_ksm(folio), folio);
>> +
>> +	if (start < vma->vm_start)
>> +		start = vma->vm_start;
>> +	if (end > vma->vm_end)
>> +		end = vma->vm_end;
>> +
>> +	pgoff = folio_pgoff(folio);
>> +	/* if folio start address is not in vma range */
>> +	if (pgoff < vma->vm_pgoff || pgoff > vma->vm_pgoff + vma_pglen)
>> +		return false;
>> +
>> +	addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
>> +	if (addr < start || end - addr < folio_size(folio))
>> +		return false;
>> +
>> +	/* not necessary to check pte for none large folio */
>> +	if (!folio_test_large(folio))
>> +		return true;
>> +
>> +	if (!pte)
>> +		return false;
>> +
>> +	/* check whether parameter pte is associated with folio */
>> +	ptent = ptep_get(pte);
>> +	if (pte_none(ptent) || !pte_present(ptent) ||
>> +			pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +		return false;
>> +
>> +	pte -= pte_pfn(ptent) - folio_pfn(folio);
>> +	for (i = 0; i < nr; i++, pte++) {
>> +		ptent = ptep_get(pte);
>> +
>> +		if (pte_none(ptent) || !pte_present(ptent) ||
>> +				pte_pfn(ptent) - folio_pfn(folio) >= nr)
>> +			return false;
>> +	}
> 
> I don't think I see anything to ensure you don't wander off the end (or start)
> of the pgtable? If the folio is mremapped so that it straddles multiple tables
> (or is bigger than a single table?) then I think pte can become invalid? Perhaps
> you intended start/end to always be within the same pgtable, but that is not
> guarranteed in the case that folio_within_vma() is making the call.
> 
> Also I want to check that this function is definitely always called under the
> PTL for the table that pte belongs to?
> 
>> +
>> +	return true;
>> +}
>> +
>> +static inline bool
>> +folio_within_vma(struct folio *folio, struct vm_area_struct *vma, pte_t *pte)
>> +{
>> +	return folio_in_range(folio, vma, vma->vm_start, vma->vm_end, pte);
>> +}
>> +
>>  /*
>>   * mlock_vma_folio() and munlock_vma_folio():
>>   * should be called with vma's mmap_lock held for read or write,
> 

