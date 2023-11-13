Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DDD7E9F33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjKMOw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKMOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:52:56 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C5171F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:52:50 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4STXNZ6dwMzMmnp;
        Mon, 13 Nov 2023 22:48:14 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 22:52:48 +0800
Message-ID: <712796da-60b2-4a33-8c21-75ab20c609c7@huawei.com>
Date:   Mon, 13 Nov 2023 22:52:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] variable-order, large folios for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230929114421.3761121-1-ryan.roberts@arm.com>
 <c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com>
 <ZVGxkMeY50JSesaj@casper.infradead.org>
 <f1fa098b-210e-41a9-80fc-aec212976610@arm.com>
 <479b3e2b-456d-46c1-9677-38f6c95a0be8@huawei.com>
 <f034dd2c-4ce1-47e5-a3a6-c3c1fcab5c4b@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <f034dd2c-4ce1-47e5-a3a6-c3c1fcab5c4b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/13 20:12, Ryan Roberts wrote:
> On 13/11/2023 11:52, Kefeng Wang wrote:
>>
>>
>> On 2023/11/13 18:19, Ryan Roberts wrote:
>>> On 13/11/2023 05:18, Matthew Wilcox wrote:
>>>> On Sun, Nov 12, 2023 at 10:57:47PM -0500, John Hubbard wrote:
>>>>> I've done some initial performance testing of this patchset on an arm64
>>>>> SBSA server. When these patches are combined with the arm64 arch contpte
>>>>> patches in Ryan's git tree (he has conveniently combined everything
>>>>> here: [1]), we are seeing a remarkable, consistent speedup of 10.5x on
>>>>> some memory-intensive workloads. Many test runs, conducted independently
>>>>> by different engineers and on different machines, have convinced me and
>>>>> my colleagues that this is an accurate result.
>>>>>
>>>>> In order to achieve that result, we used the git tree in [1] with
>>>>> following settings:
>>>>>
>>>>>       echo always >/sys/kernel/mm/transparent_hugepage/enabled
>>>>>       echo recommend >/sys/kernel/mm/transparent_hugepage/anon_orders
>>>>>
>>>>> This was on a aarch64 machine configure to use a 64KB base page size.
>>>>> That configuration means that the PMD size is 512MB, which is of course
>>>>> too large for practical use as a pure PMD-THP. However, with with these
>>>>> small-size (less than PMD-sized) THPs, we get the improvements in TLB
>>>>> coverage, while still getting pages that are small enough to be
>>>>> effectively usable.
>>>>
>>>> That is quite remarkable!
>>>
>>> Yes, agreed - thanks for sharing these results! A very nice Monday morning boost!
>>>
>>>>
>>>> My hope is to abolish the 64kB page size configuration.  ie instead of
>>>> using the mixture of page sizes that you currently are -- 64k and
>>>> 1M (right?  Order-0, and order-4)
>>>
>>> Not quite; the contpte-size for a 64K page size is 2M/order-5. (and yes, it is
>>> 64K/order-4 for a 4K page size, and 2M/order-7 for a 16K page size. I agree that
>>> intuitively you would expect the order to remain constant, but it doesn't).
>>>
>>> The "recommend" setting above will actually enable order-3 as well even though
>>> there is no HW benefit to this. So the full set of available memory sizes here
>>> is:
>>>
>>> 64K/order-0, 512K/order-3, 2M/order-5, 512M/order-13
>>>
>>>> , that 4k, 64k and 2MB (order-0,
>>>> order-4 and order-9) will provide better performance.
>>>>
>>>> Have you run any experiements with a 4kB page size?
>>>
>>> Agree that would be interesting with 64K small-sized THP enabled. And I'd love
>>> to get to a world were we universally deal in variable sized chunks of memory,
>>> aligned on 4K boundaries.
>>>
>>> In my experience though, there are still some performance benefits to 64K base
>>> page vs 4K+contpte; the page tables are more cache efficient for the former case
>>> - 64K of memory is described by 8 bytes in the former vs 8x16=128 bytes in the
>>> latter. In practice the HW will still only read 8 bytes in the latter but that's
>>> taking up a full cache line vs the former where a single cache line stores 8x
>>> 64K entries.
>>
>> We test some benchmark, eg, unixbench, lmbench, sysbench, with v5 on
>> arm64 board(for better evaluation of anon large folio, using ext4,
>> which don't support large folio for now), will test again and send
>> the results once v7 out.
> 
> Thanks for the testing and for posting the insights!
> 
>>
>> 1) base page 4k  + without anon large folio
>> 2) base page 64k + without anon large folio
>> 3) base page 4k  + with anon large folio + cont-pte(order = 4,0)
>>
>> Most of the test results from v5 show the 3) have a good improvement
>> vs 1), but still low than 2)
> 
> Do you have any understanding what the shortfall is for these particular
> workloads? Certainly the cache spatial locality benefit of the 64K page tables
> could be a factor. But certainly for the workloads I've been looking at, a
> bigger factor is often the fact that executable file-backed memory (elf
> segments) are not in 64K folios and therefore not contpte-mapped. If the iTLB is
> under pressure this can help a lot. I have a change (hack) to force all
> executable mappings to be read-ahead into 64K folios and this gives an
> improvement. But obviously that only works when the file system supports large
> folios (so not ext4 right now). It would certainly be interesting to see just
> how close to native 64K we can get when employing these extra ideas.

No detailed analysis, but with base page 64k,
  less page fault
  less TLB operation
  less zone-lock congestion(pcp)
  less buddy split/merge
  no reclaim/compact when allocate 64k page, and no fallback logical
  execfolio
  faster page table opreation?
  ...

> 
>> , also for some latency-sensitive
>> benchmark, 2) and 3) maybe have poor performance vs 1).
>>
>> Note, for pcp_allowed_order, order <= PAGE_ALLOC_COSTLY_ORDER=3, for
>> 3), we maybe enlarge it for better scalability when page allocation
>> on arm64, not test on v5, will try to enlarge it on v7.
> 
> Yes interesting! I'm hoping to post v7 this week - just waiting for mm-unstable
> to be rebased on v6.7-rc1. I'd be interested to see your results.
> 
Glad to see it.>>
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>
> 
> 
