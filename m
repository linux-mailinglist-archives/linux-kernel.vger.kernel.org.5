Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9465F805639
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbjLENkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345471AbjLENkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:40:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E0D1C19B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:40:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DCD42F4;
        Tue,  5 Dec 2023 05:41:10 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DBA93F5A1;
        Tue,  5 Dec 2023 05:40:22 -0800 (PST)
Message-ID: <181a1623-9285-415e-9ec6-6b6548ca7487@arm.com>
Date:   Tue, 5 Dec 2023 13:40:20 +0000
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
 <bb8e060f-74f0-4b1f-9003-40b2757295ca@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <bb8e060f-74f0-4b1f-9003-40b2757295ca@redhat.com>
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

On 05/12/2023 13:18, David Hildenbrand wrote:
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
> 
> Ah, no, I did this for a reason. This function lives in a header, so it will
> always be inlined.
> 

Really? It will certainly be duplicated across every compilation unit, but
that's separate from being inlined - if the optimizer is off, won't it just end
up as an out-of-line function in every compilation unit?

