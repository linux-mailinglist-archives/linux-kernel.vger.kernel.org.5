Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D20805636
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442185AbjLENha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345466AbjLENh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:37:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67778A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:37:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB4FC139F;
        Tue,  5 Dec 2023 05:38:21 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7BD353F5A1;
        Tue,  5 Dec 2023 05:37:33 -0800 (PST)
Message-ID: <17d64bc7-3a84-4562-821c-439950e1da91@arm.com>
Date:   Tue, 5 Dec 2023 13:37:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 23/39] mm/rmap: introduce
 folio_remove_rmap_[pte|ptes|pmd]()
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
 <20231204142146.91437-24-david@redhat.com>
 <b113e197-d802-4972-b2df-a47d334629f6@arm.com>
 <58be47c1-c34e-46a2-a32b-a993f7dee664@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <58be47c1-c34e-46a2-a32b-a993f7dee664@redhat.com>
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

On 05/12/2023 13:09, David Hildenbrand wrote:
>>> +static __always_inline void __folio_remove_rmap(struct folio *folio,
>>> +        struct page *page, unsigned int nr_pages,
>>> +        struct vm_area_struct *vma, enum rmap_mode mode)
>>> +{
>>>       atomic_t *mapped = &folio->_nr_pages_mapped;
>>> -    int nr = 0, nr_pmdmapped = 0;
>>> -    bool last;
>>> +    int last, nr = 0, nr_pmdmapped = 0;
>>
>> nit: you're being inconsistent across the functions with signed vs unsigned for
>> page counts (e.g. nr, nr_pmdmapped) - see __folio_add_rmap(),
>> __folio_add_file_rmap(), __folio_add_anon_rmap().
>>
> 
> Definitely.
> 
>> I suggest pick one and stick to it. Personally I'd go with signed int (since
>> that's what all the counters in struct folio that we are manipulating are,
>> underneath the atomic_t) then check that nr_pages > 0 in
>> __folio_rmap_sanity_checks().
> 
> Can do, but note that the counters are signed to detect udnerflows. It doesn't
> make sense here to pass a negative number.

I agree it doesn't make sense to pass negative - hence the check.

These 2 functions are inconsistent on size, but agree on signed:

long folio_nr_pages(struct folio *folio)
int folio_nr_pages_mapped(struct folio *folio)

I don't have a strong opinon.

> 
>>
>>>       enum node_stat_item idx;
>>>   -    VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>>> -    VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>>> +    __folio_rmap_sanity_checks(folio, page, nr_pages, mode);
>>>         /* Is page being unmapped by PTE? Is this its last map to be removed? */
>>> -    if (likely(!compound)) {
>>> -        last = atomic_add_negative(-1, &page->_mapcount);
>>> -        nr = last;
>>> -        if (last && folio_test_large(folio)) {
>>> -            nr = atomic_dec_return_relaxed(mapped);
>>> -            nr = (nr < COMPOUND_MAPPED);
>>> -        }
>>> -    } else if (folio_test_pmd_mappable(folio)) {
>>> -        /* That test is redundant: it's for safety or to optimize out */
>>> +    if (likely(mode == RMAP_MODE_PTE)) {
>>> +        do {
>>> +            last = atomic_add_negative(-1, &page->_mapcount);
>>> +            if (last && folio_test_large(folio)) {
>>> +                last = atomic_dec_return_relaxed(mapped);
>>> +                last = (last < COMPOUND_MAPPED);
>>> +            }
>>>   +            if (last)
>>> +                nr++;
>>> +        } while (page++, --nr_pages > 0);
>>> +    } else if (mode == RMAP_MODE_PMD) {
>>>           last = atomic_add_negative(-1, &folio->_entire_mapcount);
>>>           if (last) {
>>>               nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
>>> @@ -1517,7 +1528,7 @@ void page_remove_rmap(struct page *page, struct
>>> vm_area_struct *vma,
>>>            * is still mapped.
>>>            */
>>>           if (folio_test_pmd_mappable(folio) && folio_test_anon(folio))
>>
>> folio_test_pmd_mappable() -> folio_test_large()
>>
>> Since you're converting this to support batch PTE removal, it might as well also
>> support smaller-than-pmd too?
> 
> I remember that you have a patch for that, right? :)
> 
>>
>> I currently have a patch to do this same change in the multi-size THP series.
>>
> 
> Ah, yes, and that should go in first.
> 
> 

