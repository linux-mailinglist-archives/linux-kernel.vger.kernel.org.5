Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF277C4C9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjJKIFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjJKIFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:05:48 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E092
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:05:46 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S54wp0xLGzkYC2;
        Wed, 11 Oct 2023 16:01:46 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 11 Oct 2023 16:05:43 +0800
Message-ID: <f4aedda6-8da1-4479-a9d7-7a0cd3329720@huawei.com>
Date:   Wed, 11 Oct 2023 16:05:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/7] mm_types: add _last_cpupid into folio
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
 <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
 <ZSVEmhPCjZKyp97a@casper.infradead.org>
 <3b56b26b-a550-4e06-b355-55564b40cfb5@huawei.com>
 <874jixhfeu.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <874jixhfeu.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/11 13:55, Huang, Ying wrote:
> Kefeng Wang <wangkefeng.wang@huawei.com> writes:
> 
>> On 2023/10/10 20:33, Matthew Wilcox wrote:
>>> On Tue, Oct 10, 2023 at 02:45:38PM +0800, Kefeng Wang wrote:
>>>> At present, only arc/sparc/m68k define WANT_PAGE_VIRTUAL, both of
>>>> them don't support numa balancing, and the page struct is aligned
>>>> to _struct_page_alignment, it is safe to move _last_cpupid before
>>>> 'virtual' in page, meanwhile, add it into folio, which make us to
>>>> use folio->_last_cpupid directly.
>>> What do you mean by "safe"?  I think you mean "Does not increase the
>>> size of struct page", but if that is what you mean, why not just say so?
>>> If there's something else you mean, please explain.
>>
>> Don't increase size of struct page and don't impact the real order of
>> struct page as the above three archs without numa balancing support.
>>
>>> In any event, I'd like to see some reasoning that _last_cpupid is
>>> actually
>>> information which is logically maintained on a per-allocation basis,
>>> not a per-page basis (I think this is true, but I honestly don't know)
>>
>> The _last_cpupid is updated in should_numa_migrate_memory() from numa
>> fault(do_numa_page, and do_huge_pmd_numa_page), it is per-page(normal
>> page and PMD-mapped page). Maybe I misunderstand your mean, please
>> correct me.
> 
> Because PTE mapped THP will not be migrated according to comments and
> folio_test_large() test in do_numa_page().  Only _last_cpuid of the head
> page will be used (that is, on per-allocation basis).  Although in
> change_pte_range() in mprotect.c, _last_cpuid of tail pages may be
> changed, they are not used actually.  All in all, _last_cpuid is on
> per-allocation basis for now.

Thanks for clarification, yes, it's what I mean, too
> 
> In the future, it's hard to say.  PTE-mapped THPs or large folios give
> us an opportunity to check whether the different parts of a folio are
> accessed by multiple sockets, so that we should split the folio.  But
> this is just some possibility in the future.

It depends on memory access behavior of application,if multiple sockets
access a large folio/PTE-mappped THP frequently, split maybe better,
or it is enough to just migrate the entire folio.


> 
> --
> Best Regards,
> Huang, Ying
> 
