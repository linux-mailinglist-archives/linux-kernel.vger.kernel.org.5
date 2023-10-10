Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A667BF821
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjJJKAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbjJJKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:00:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27623A4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:00:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EFCA1FB;
        Tue, 10 Oct 2023 03:00:54 -0700 (PDT)
Received: from [10.1.30.177] (XHFQ2J9959.cambridge.arm.com [10.1.30.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F1A43F762;
        Tue, 10 Oct 2023 03:00:11 -0700 (PDT)
Message-ID: <03c77958-5d02-4611-b6d4-2a5c94425e70@arm.com>
Date:   Tue, 10 Oct 2023 11:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <5caf5aee-9142-46f6-9a04-5b6e36880b21@arm.com>
 <3430F048-0B75-4D2F-A097-753E8B1866B2@nvidia.com>
 <13347394-fc63-44b2-9fa0-455f56d9b19d@arm.com>
 <96622D29-4CC6-4281-96B1-319E5F317EDD@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <96622D29-4CC6-4281-96B1-319E5F317EDD@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2023 16:52, Zi Yan wrote:
> (resent as plain text)
> On 9 Oct 2023, at 10:10, Ryan Roberts wrote:
> 
>> On 09/10/2023 14:24, Zi Yan wrote:
>>> On 2 Oct 2023, at 8:32, Ryan Roberts wrote:
>>>
>>>> Hi Zi,
>>>>
>>>> On 12/09/2023 17:28, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> Hi all,
>>>>>
>>>>> This patchset enables >0 order folio memory compaction, which is one of
>>>>> the prerequisitions for large folio support[1]. It is on top of
>>>>> mm-everything-2023-09-11-22-56.
>>>>
>>>> I've taken a quick look at these and realize I'm not well equipped to provide
>>>> much in the way of meaningful review comments; All I can say is thanks for
>>>> putting this together, and yes, I think it will become even more important for
>>>> my work on anonymous large folios.
>>>>
>>>>
>>>>>
>>>>> Overview
>>>>> ===
>>>>>
>>>>> To support >0 order folio compaction, the patchset changes how free pages used
>>>>> for migration are kept during compaction. Free pages used to be split into
>>>>> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
>>>>> page order stored in page->private is zeroed, and page reference is set to 1).
>>>>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
>>>>> on their order without post allocation process. When migrate_pages() asks for
>>>>> a new page, one of the free pages, based on the requested page order, is
>>>>> then processed and given out.
>>>>>
>>>>>
>>>>> Optimizations
>>>>> ===
>>>>>
>>>>> 1. Free page split is added to increase migration success rate in case
>>>>> a source page does not have a matched free page in the free page lists.
>>>>> Free page merge is possible but not implemented, since existing
>>>>> PFN-based buddy page merge algorithm requires the identification of
>>>>> buddy pages, but free pages kept for memory compaction cannot have
>>>>> PageBuddy set to avoid confusing other PFN scanners.
>>>>>
>>>>> 2. Sort source pages in ascending order before migration is added to
>>>>> reduce free page split. Otherwise, high order free pages might be
>>>>> prematurely split, causing undesired high order folio migration failures.
>>>>
>>>> Not knowing much about how compaction actually works, naively I would imagine
>>>> that if you are just trying to free up a known amount of contiguous physical
>>>> space, then working through the pages in PFN order is more likely to yield the
>>>> result quicker? Unless all of the pages in the set must be successfully migrated
>>>> in order to free up the required amount of space...
>>>
>>> During compaction, pages are not freed, since that is the job of page reclaim.
>>
>> Sorry yes - my fault for using sloppy language. When I said "free up a known
>> amount of contiguous physical space", I really meant "move pages in order to
>> recover an amount of contiguous physical space". But I still think the rest of
>> what I said applies; wouldn't you be more likely to reach your goal quicker if
>> you sort by PFN?
> 
> Not always. If the in-use folios on the left are order-2, order-2, order-4
> (all contiguous in one pageblock) and free pages on the right are order-4 (pageblock N),
> order-2, order-2 (pageblock N-1) and it is not a single order-8, since there are
> in-use folios in the middle), going in PFN order will not get you an order-8 free
> page, since first order-4 free page will be split into two order-2 for the first
> two order-2 in-use folios. But if you migrate in the the descending order of
> in-use page orders, you can get an order-8 free page at the end.
> 
> The patchset minimizes free page splits to avoid the situation described above,
> since once a high order free page is split, the opportunity of migrating a high order
> in-use folio into it is gone and hardly recoverable.

OK I get it now - thanks!

> 
> 
>>> The goal of compaction is to get a high order free page without freeing existing
>>> pages to avoid potential high cost IO operations. If compaction does not work,
>>> page reclaim would free pages to get us there (and potentially another follow-up
>>> compaction). So either pages are migrated or stay where they are during compaction.
>>>
>>> BTW compaction works by scanning in use pages from lower PFN to higher PFN,
>>> and free pages from higher PFN to lower PFN until two scanners meet in the middle.
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
> 
> 
> Best Regards,
> Yan, Zi

