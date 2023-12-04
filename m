Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B154B80339E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbjLDM5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjLDM5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:57:04 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35BC8D2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:57:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 421031424;
        Mon,  4 Dec 2023 04:57:57 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E2F63F5A1;
        Mon,  4 Dec 2023 04:57:07 -0800 (PST)
Message-ID: <83497a70-45c3-4386-8994-92207ab521bd@arm.com>
Date:   Mon, 4 Dec 2023 12:57:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <800937DA-BAD0-4C60-B155-AECCA21E955E@nvidia.com>
 <1a0f5cb8-421c-4f28-a986-f3c381406e81@arm.com>
 <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
 <6dd6164a-1dd5-46e7-bcf7-b62ff5c6e8ec@arm.com>
 <890f4455-bf1b-437b-a355-7895e4dd3085@redhat.com>
 <52b042b9-ec95-4db0-b38a-f7f1cea0b90c@arm.com>
 <635de797-1219-40b0-b4b2-7eba758749a5@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <635de797-1219-40b0-b4b2-7eba758749a5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 12:43, David Hildenbrand wrote:
> On 04.12.23 13:39, Ryan Roberts wrote:
>> On 04/12/2023 12:28, David Hildenbrand wrote:
>>> On 04.12.23 13:26, Ryan Roberts wrote:
>>>>>>>
>>>>>>> Also, struct page (memmap) might not be always contiguous, using struct page
>>>>>>> points to represent folio range might not give the result you want.
>>>>>>> See nth_page() and folio_page_idx() in include/linux/mm.h.
>>>>>>
>>>>>> Is that true for pages within the same folio too? Or are all pages in a folio
>>>>>> guarranteed contiguous? Perhaps I'm better off using pfn?
>>>>>
>>>>> folio_page_idx() says not all pages in a folio is guaranteed to be contiguous.
>>>>> PFN might be a better choice.
>>>>
>>>> Hi Zi, Matthew,
>>>>
>>>> Zi made this comment a couple of months back that it is incorrect to assume
>>>> that
>>>> `struct page`s within a folio are (virtually) contiguous. I'm not sure if
>>>> that's
>>>> really the case though? I see other sites in the source that do page++ when
>>>> iterating over a folio. e.g. smaps_account(), splice_folio_into_pipe(),
>>>> __collapse_huge_page_copy(), etc.
>>>>
>>>> Any chance someone could explain the rules?
>>>
>>> With the vmemmap, they are contiguous. Without a vmemmap, but with sparsemem, we
>>> might end up allocating one memmap chunk per memory section (e.g., 128 MiB).
>>>
>>> So, for example, a 1 GiB hugetlb page could cross multiple 128 MiB sections, and
>>> therefore, the memmap might not be virtually consecutive.
>>
>> OK, is a "memory section" always 128M or is it variable? If fixed, does that
>> mean that it's impossible for a THP to cross section boundaries? (because a THP
>> is always smaller than a section?)
> 
> Section size is variable (see SECTION_SIZE_BITS), but IIRC, buddy allocations
> will never cross them.
> 
>>
>> Trying to figure out why my original usage in this series was wrong, but
>> presumably the other places that I mentioned are safe.
> 
> If only dealing with buddy allocations, *currently* it might always fall into a
> single memory section.

OK that makes sense - thanks!

> 

