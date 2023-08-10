Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA66777614
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjHJKlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjHJKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:40:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5474710FE;
        Thu, 10 Aug 2023 03:40:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 631762F4;
        Thu, 10 Aug 2023 03:41:39 -0700 (PDT)
Received: from [10.1.27.169] (XHFQ2J9959.cambridge.arm.com [10.1.27.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 645A93F6C4;
        Thu, 10 Aug 2023 03:40:55 -0700 (PDT)
Message-ID: <09b0f874-b84a-45a5-ab9b-53e348eae3df@arm.com>
Date:   Thu, 10 Aug 2023 11:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v1] mm: add a total mapcount for large folios
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
References: <20230809083256.699513-1-david@redhat.com>
 <181fcc79-b1c6-412f-9ca1-d1f21ef33e32@arm.com>
 <60b5b2a2-1d1d-661c-d61e-855178fff44d@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <60b5b2a2-1d1d-661c-d61e-855178fff44d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 20:17, David Hildenbrand wrote:
> On 09.08.23 21:07, Ryan Roberts wrote:
>> On 09/08/2023 09:32, David Hildenbrand wrote:
>>> Let's track the total mapcount for all large folios in the first subpage.
>>>
>>> The total mapcount is what we actually want to know in folio_mapcount()
>>> and it is also sufficient for implementing folio_mapped(). This also
>>> gets rid of any "raceiness" concerns as expressed in
>>> folio_total_mapcount().
>>>
>>> With sub-PMD THP becoming more important and things looking promising
>>> that we will soon get support for such anon THP, we want to avoid looping
>>> over all pages of a folio just to calculate the total mapcount. Further,
>>> we may soon want to use the total mapcount in other context more
>>> frequently, so prepare for reading it efficiently and atomically.
>>>
>>> Make room for the total mapcount in page[1] of the folio by moving
>>> _nr_pages_mapped to page[2] of the folio: it is not applicable to hugetlb
>>> -- and with the total mapcount in place probably also not desirable even
>>> if PMD-mappable hugetlb pages could get PTE-mapped at some point -- so we
>>> can overlay the hugetlb fields.
>>>
>>> Note that we currently don't expect any order-1 compound pages / THP in
>>> rmap code, and that such support is not planned. If ever desired, we could
>>> move the compound mapcount to another page, because it only applies to
>>> PMD-mappable folios that are definitely larger. Let's avoid consuming
>>> more space elsewhere for now -- we might need more space for a different
>>> purpose in some subpages soon.
>>>
>>> Maintain the total mapcount also for hugetlb pages. Use the total mapcount
>>> to implement folio_mapcount(), total_mapcount(), folio_mapped() and
>>> page_mapped().
>>>
>>> We can now get rid of folio_total_mapcount() and
>>> folio_large_is_mapped(), by just inlining reading of the total mapcount.
>>>
>>> _nr_pages_mapped is now only used in rmap code, so not accidentially
>>> externally where it might be used on arbitrary order-1 pages. The remaining
>>> usage is:
>>>
>>> (1) Detect how to adjust stats: NR_ANON_MAPPED and NR_FILE_MAPPED
>>>   -> If we would account the total folio as mapped when mapping a
>>>      page (based on the total mapcount), we could remove that usage.
>>>
>>> (2) Detect when to add a folio to the deferred split queue
>>>   -> If we would apply a different heuristic, or scan using the rmap on
>>>      the memory reclaim path for partially mapped anon folios to
>>>      split them, we could remove that usage as well.
>>>
>>> So maybe, we can simplify things in the future and remove
>>> _nr_pages_mapped. For now, leave these things as they are, they need more
>>> thought. Hugh really did a nice job implementing that precise tracking
>>> after all.
>>>
>>> Note: Not adding order-1 sanity checks to the file_rmap functions for
>>>        now. For anon pages, they are certainly not required right now.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> Cc: Hugh Dickins <hughd@google.com>
>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>>> Cc: Yang Shi <shy828301@gmail.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> Other than the nits and query on zeroing _total_mapcount below, LGTM. If zeroing
>> is correct:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Thanks for the review!
> 
> [...]
> 
>>>     static inline int total_mapcount(struct page *page)
>>
>> nit: couldn't total_mapcount() just be implemented as a wrapper around
>> folio_mapcount()? What's the benefit of PageCompound() check instead of just
>> getting the folio and checking if it's large? i.e:
> 
> Good point, let me take a look tomorrow if the compiler can optimize in both
> cases equally well.
> 
> [...]
> 
>>>   diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 5f498e8025cc..6a614c559ccf 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -1479,7 +1479,7 @@ static void __destroy_compound_gigantic_folio(struct
>>> folio *folio,
>>>       struct page *p;
>>>         atomic_set(&folio->_entire_mapcount, 0);
>>> -    atomic_set(&folio->_nr_pages_mapped, 0);
>>> +    atomic_set(&folio->_total_mapcount, 0);
>>
>> Just checking this is definitely what you intended? _total_mapcount is -1 when
>> it means "no pages mapped", so 0 means 1 page mapped?
> 
> I was blindly doing what _entire_mapcount is doing: zeroing out the values. ;)
> 
> But let's look into the details: in __destroy_compound_gigantic_folio(), we're
> manually dissolving the whole compound page. So instead of actually returning a
> compound page to the buddy (where we would make sure the mapcounts are -1, to
> then zero them out !), we simply zero-out the fields we use and then dissolve
> the compound page: to be left with a bunch of order-0 pages where the memmap is
> in a clean state.
> 
> (the buddy doesn't handle that page order, so we have to do things manually to
> get to order-0 pages we can reuse or free)
> 

Yeah fair enough, thanks for the explanation.

