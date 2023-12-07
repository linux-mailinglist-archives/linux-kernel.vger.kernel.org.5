Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8C808D40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443749AbjLGPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443714AbjLGPvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:51:01 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805CD1BC0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:50:36 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmJcJ6v7bzWjPk;
        Thu,  7 Dec 2023 23:49:36 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 23:50:32 +0800
Message-ID: <b2876d37-a342-41f6-9613-dd4bfaa5841b@huawei.com>
Date:   Thu, 7 Dec 2023 23:50:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/10] Multi-size THP for anonymous memory
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
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
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
CC:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <b8f5a47a-af1e-44ed-a89b-460d0be56d2c@huawei.com>
 <82068e6a-937b-43db-8496-76fdf3158080@arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <82068e6a-937b-43db-8496-76fdf3158080@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/6 18:08, Ryan Roberts wrote:
> On 05/12/2023 14:19, Kefeng Wang wrote:
>>
>>
>> On 2023/12/4 18:20, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> A new week, a new version, a new name... This is v8 of a series to implement
>>> multi-size THP (mTHP) for anonymous memory (previously called "small-sized THP"
>>> and "large anonymous folios"). Matthew objected to "small huge" so hopefully
>>> this fares better.
>>>
>>> The objective of this is to improve performance by allocating larger chunks of
>>> memory during anonymous page faults:
>>>
>>> 1) Since SW (the kernel) is dealing with larger chunks of memory than base
>>>      pages, there are efficiency savings to be had; fewer page faults, batched PTE
>>>      and RMAP manipulation, reduced lru list, etc. In short, we reduce kernel
>>>      overhead. This should benefit all architectures.
>>> 2) Since we are now mapping physically contiguous chunks of memory, we can take
>>>      advantage of HW TLB compression techniques. A reduction in TLB pressure
>>>      speeds up kernel and user space. arm64 systems have 2 mechanisms to coalesce
>>>      TLB entries; "the contiguous bit" (architectural) and HPA (uarch).
>>>
>>> This version changes the name and tidies up some of the kernel code and test
>>> code, based on feedback against v7 (see change log for details).
>>>
>>> By default, the existing behaviour (and performance) is maintained. The user
>>> must explicitly enable multi-size THP to see the performance benefit. This is
>>> done via a new sysfs interface (as recommended by David Hildenbrand - thanks to
>>> David for the suggestion)! This interface is inspired by the existing
>>> per-hugepage-size sysfs interface used by hugetlb, provides full backwards
>>> compatibility with the existing PMD-size THP interface, and provides a base for
>>> future extensibility. See [8] for detailed discussion of the interface.
>>>
>>> This series is based on mm-unstable (715b67adf4c8).
>>>
>>>
>>> Prerequisites
>>> =============
>>>
>>> Some work items identified as being prerequisites are listed on page 3 at [9].
>>> The summary is:
>>>
>>> | item                          | status                  |
>>> |:------------------------------|:------------------------|
>>> | mlock                         | In mainline (v6.7)      |
>>> | madvise                       | In mainline (v6.6)      |
>>> | compaction                    | v1 posted [10]          |
>>> | numa balancing                | Investigated: see below |
>>> | user-triggered page migration | In mainline (v6.7)      |
>>> | khugepaged collapse           | In mainline (NOP)       |
>>>
>>> On NUMA balancing, which currently ignores any PTE-mapped THPs it encounters,
>>> John Hubbard has investigated this and concluded that it is A) not clear at the
>>> moment what a better policy might be for PTE-mapped THP and B) questions whether
>>> this should really be considered a prerequisite given no regression is caused
>>> for the default "multi-size THP disabled" case, and there is no correctness
>>> issue when it is enabled - its just a potential for non-optimal performance.
>>>
>>> If there are no disagreements about removing numa balancing from the list (none
>>> were raised when I first posted this comment against v7), then that just leaves
>>> compaction which is in review on list at the moment.
>>>
>>> I really would like to get this series (and its remaining comapction
>>> prerequisite) in for v6.8. I accept that it may be a bit optimistic at this
>>> point, but lets see where we get to with review?
>>>
>>>
>>> Testing
>>> =======
>>>
>>> The series includes patches for mm selftests to enlighten the cow and khugepaged
>>> tests to explicitly test with multi-size THP, in the same way that PMD-sized
>>> THP is tested. The new tests all pass, and no regressions are observed in the mm
>>> selftest suite. I've also run my usual kernel compilation and java script
>>> benchmarks without any issues.
>>>
>>> Refer to my performance numbers posted with v6 [6]. (These are for multi-size
>>> THP only - they do not include the arm64 contpte follow-on series).
>>>
>>> John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
>>> some workloads at [11]. (Observed using v6 of this series as well as the arm64
>>> contpte series).
>>>
>>> Kefeng Wang at Huawei has also indicated he sees improvements at [12] although
>>> there are some latency regressions also.
>>
>> Hi Ryan,
>>
>> Here is some test results based on v6.7-rc1 +
>> [PATCH v7 00/10] Small-sized THP for anonymous memory +
>> [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
>>
>> case1: basepage 64K
>> case2: basepage 4K + thp=64k + PAGE_ALLOC_COSTLY_ORDER = 3
>> case3: basepage 4K + thp=64k + PAGE_ALLOC_COSTLY_ORDER = 4
> 
> Thanks for sharing these results. With the exception of a few outliers, It looks
> like the ~rough conclusion is that bandwidth improves, but not as much as 64K
> base pages, and latency regresses, but also not as much as 64K base pages?

It depends on the test cases, both sides have their own advantages and
disadvantages, but 64k base page is still better in most cases.

> 
> I expect that over time, as we add more optimizations, we will get bandwidth
> closer to 64K base pages; one crucial one is getting executable file-backed
> memory into contpte mappings, for example.

Yes, this should spend some time to optimize, also maybe provide more
policy, eg order chosen, per-task/per-cg control?

> 
> It's probably not time to switch PAGE_ALLOC_COSTLY_ORDER quite yet; but
> something to keep an eye on and consider down the road?

This one just for test and it seems not to obtain large gain in
unixbench/lmbench testcases, also it shouldn't be considered in this
patchset.
