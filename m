Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB18055F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442210AbjLENb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345403AbjLENbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:31:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48F611B5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:31:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E99139F;
        Tue,  5 Dec 2023 05:32:15 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72AC43F5A1;
        Tue,  5 Dec 2023 05:31:27 -0800 (PST)
Message-ID: <1ba5dd86-a201-4243-bab0-349395468236@arm.com>
Date:   Tue, 5 Dec 2023 13:31:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/39] mm/rmap: interface overhaul
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
 <993ea322-8cdb-4ab1-84d3-0a1cb40049c9@arm.com>
 <067753e4-faf0-4bc0-9703-ec97b7de705e@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <067753e4-faf0-4bc0-9703-ec97b7de705e@redhat.com>
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

On 05/12/2023 09:56, David Hildenbrand wrote:
>>>
>>> Ryan has series where we would make use of folio_remove_rmap_ptes() [1]
>>> -- he carries his own batching variant right now -- and
>>> folio_try_dup_anon_rmap_ptes()/folio_dup_file_rmap_ptes() [2].
>>
>> Note that the contpte series at [2] has a new patch in v3 (patch 2), which could
>> benefit from folio_remove_rmap_ptes() or equivalent. My plan was to revive [1]
>> on top of [2] once it is merged.
>>
>>>
>>> There is some overlap with both series (and some other work, like
>>> multi-size THP [3]), so that will need some coordination, and likely a
>>> stepwise inclusion.
>>
>> Selfishly, I'd really like to get my stuff merged as soon as there is no
>> technical reason not to. I'd prefer not to add this as a dependency if we can
>> help it.
> 
> It's easy to rework either series on top of each other. The mTHP series has
> highest priority,
> no question, that will go in first.

Music to my ears! It would be great to either get a reviewed-by or feedback on
why not, for the key 2 patches in that series (3 & 4) and also your opinion on
whether we need to wait for compaction to land (see cover letter). It would be
great to get this into linux-next ASAP IMHO.

> 
> Regarding the contpte, I think it needs more work. Especially, as raised, to not
> degrade
> order-0 performance. Maybe we won't make the next merge window (and you already
> predicated
> that in some cover letter :P ). Let's see.

Yeah that's ok. I'll do the work to fix the order-0 perf. And also do the same
for patch 2 in that series - would also be really helpful if you had a chance to
look at patch 2 - its new for v3.

> 
> But again, the conflicts are all trivial, so I'll happily rebase on top of
> whatever is
> in mm-unstable. Or move the relevant rework to the front so you can just carry
> them/base on them. (the batched variants for dup do make the contpte code much
> easier)

So perhaps we should aim for mTHP, then this, then contpte last, benefiting from
the batching.

> 
> [...]
> 
>>>
>>>
>>> New (extended) hugetlb interface that operate on entire folio:
>>>   * hugetlb_add_new_anon_rmap() -> Already existed
>>>   * hugetlb_add_anon_rmap() -> Already existed
>>>   * hugetlb_try_dup_anon_rmap()
>>>   * hugetlb_try_share_anon_rmap()
>>>   * hugetlb_add_file_rmap()
>>>   * hugetlb_remove_rmap()
>>>
>>> New "ordinary" interface for small folios / THP::
>>>   * folio_add_new_anon_rmap() -> Already existed
>>>   * folio_add_anon_rmap_[pte|ptes|pmd]()
>>>   * folio_try_dup_anon_rmap_[pte|ptes|pmd]()
>>>   * folio_try_share_anon_rmap_[pte|pmd]()
>>>   * folio_add_file_rmap_[pte|ptes|pmd]()
>>>   * folio_dup_file_rmap_[pte|ptes|pmd]()
>>>   * folio_remove_rmap_[pte|ptes|pmd]()
>>
>> I'm not sure if there are official guidelines, but personally if we are
>> reworking the API, I'd take the opportunity to move "rmap" to the front of the
>> name, rather than having it burried in the middle as it is for some of these:
>>
>> rmap_hugetlb_*()
>>
>> rmap_folio_*()
> 
> No strong opinion. But we might want slightly different names then. For example,
> it's "bio_add_folio" and not "bio_folio_add":
> 
> 
> rmap_add_new_anon_hugetlb()
> rmap_add_anon_hugetlb()
> ...
> rmap_remove_hugetlb()
> 
> 
> rmap_add_new_anon_folio()
> rmap_add_anon_folio_[pte|ptes|pmd]()
> ...
> rmap_dup_file_folio_[pte|ptes|pmd]()
> rmap_remove_folio_[pte|ptes|pmd]()
> 
> Thoughts?

Having now reviewed your series, I have a less strong opinion, perhaps it's
actually best with your original names; "folio" is actually the subject after
all; it's the thing being operated on.


> 
>>
>> I guess reading the patches will tell me, but what's the point of "ptes"? Surely
>> you're either mapping at pte or pmd level, and the number of pages is determined
>> by the folio size? (or presumably nr param passed in)
> 
> It's really (currently) one function to handle 1 vs. multiple PTEs. For example:
> 
> void folio_remove_rmap_ptes(struct folio *, struct page *, unsigned int nr,
>         struct vm_area_struct *);
> #define folio_remove_rmap_pte(folio, page, vma) \
>     folio_remove_rmap_ptes(folio, page, 1, vma)
> void folio_remove_rmap_pmd(struct folio *, struct page *,
>         struct vm_area_struct *);

Yeah now that I've looked at the series, this makes sense. "ptes" was originally
making me think of contpte, but I suspect I'll be the only one with that
association :)
> 
> 
> Once could let the compiler generate specialized variants for the single-pte
> versions to make the order-0 case faster. For now it's just a helper macro.
> 

