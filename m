Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999F1805646
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbjLENoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjLENks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:40:48 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E627199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:40:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB08A139F;
        Tue,  5 Dec 2023 05:41:39 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA65A3F5A1;
        Tue,  5 Dec 2023 05:40:51 -0800 (PST)
Message-ID: <183cf38c-476e-44c4-a8c7-22ed43122b41@arm.com>
Date:   Tue, 5 Dec 2023 13:40:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 34/39] mm/rmap: introduce
 folio_try_dup_anon_rmap_[pte|ptes|pmd]()
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-35-david@redhat.com>
 <b7ef017b-f651-40f3-a2bd-70ebe9411dc1@arm.com>
 <88a341bf-0b6a-454a-aeb1-0699233eb37c@redhat.com>
 <e2db9119-0f8f-42d2-af13-529edb043bc6@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <e2db9119-0f8f-42d2-af13-529edb043bc6@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 13:32, David Hildenbrand wrote:
> On 05.12.23 14:17, David Hildenbrand wrote:
>> On 05.12.23 14:12, Ryan Roberts wrote:
>>> On 04/12/2023 14:21, David Hildenbrand wrote:
>>>> The last user of page_needs_cow_for_dma() and __page_dup_rmap() are gone,
>>>> remove them.
>>>>
>>>> Add folio_try_dup_anon_rmap_ptes() right away, we want to perform rmap
>>>> baching during fork() soon.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    include/linux/mm.h   |   6 --
>>>>    include/linux/rmap.h | 145 +++++++++++++++++++++++++++++--------------
>>>>    2 files changed, 100 insertions(+), 51 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 24c1c7c5a99c0..f7565b35ae931 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -1964,12 +1964,6 @@ static inline bool folio_needs_cow_for_dma(struct
>>>> vm_area_struct *vma,
>>>>        return folio_maybe_dma_pinned(folio);
>>>>    }
>>>>    -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>>>> -                      struct page *page)
>>>> -{
>>>> -    return folio_needs_cow_for_dma(vma, page_folio(page));
>>>> -}
>>>> -
>>>>    /**
>>>>     * is_zero_page - Query if a page is a zero page
>>>>     * @page: The page to query
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 21d72cc602adc..84439f7720c62 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -354,68 +354,123 @@ static inline void folio_dup_file_rmap_pmd(struct
>>>> folio *folio,
>>>>    #endif
>>>>    }
>>>>    -static inline void __page_dup_rmap(struct page *page, bool compound)
>>>> +static inline int __folio_try_dup_anon_rmap(struct folio *folio,
>>>
>>> __always_inline?
>>
>> Yes.
>>
>>>
>>>> +        struct page *page, unsigned int nr_pages,
>>>> +        struct vm_area_struct *src_vma, enum rmap_mode mode)
>>>>    {
>>>> -    VM_WARN_ON(folio_test_hugetlb(page_folio(page)));
>>>> +    int i;
>>>>    -    if (compound) {
>>>> -        struct folio *folio = (struct folio *)page;
>>>> +    VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>>>>    -        VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>>>> -        atomic_inc(&folio->_entire_mapcount);
>>>> -    } else {
>>>> -        atomic_inc(&page->_mapcount);
>>>> +    /*
>>>> +     * No need to check+clear for already shared PTEs/PMDs of the folio.
>>>> +     * This includes PTE mappings of (order-0) KSM folios.
>>>> +     */
>>>> +    if (likely(mode == RMAP_MODE_PTE)) {
>>>
>>> Presumbly if __always_inline then the compiler will remove this if/else and just
>>> keep the part indicated by mode? In which case "likely" is pretty useless? Same
>>> for all similar sites in the other patches.
>>
>> Yes, also had this in mind. As long as we use __always_inline it
>> shouldn't ever matter.
> 
> It seems to be cleanest to just do:
> 
> switch (mode) {
> case RMAP_MODE_PTE:
>     ...
>     break;
> case RMAP_MODE_PMD:
>     ...
>     break;
> }
> 

Agreed.

