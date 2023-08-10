Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A0E776DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjHJBtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHJBtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:49:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425810DA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:49:17 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RLqXK0Sj2zkXwR;
        Thu, 10 Aug 2023 09:46:25 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 09:49:15 +0800
Message-ID: <2da95492-079b-43b1-a950-d290984a21c0@huawei.com>
Date:   Thu, 10 Aug 2023 09:49:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Zi Yan <ziy@nvidia.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
References: <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
 <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
 <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
 <20230809205316.GA3537@monkey> <20230809224424.GB3537@monkey>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230809224424.GB3537@monkey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/10 6:44, Mike Kravetz wrote:
> On 08/09/23 13:53, Mike Kravetz wrote:
>> On 08/09/23 20:37, Kefeng Wang wrote:
>>>>
>>>> Cc Mike to help us clarify the expected behavior of hugetlb.
>>>>
>>>> Hi Mike, what is the expected behavior, if a user tries to use move_pages()
>>>> to migrate a non head page of a hugetlb page?
>>>
>>> Could you give some advise, thanks
>>>
>>
>> Sorry, I was away for a while.
>>
>> It seems unfortunate that move_pages says the passed user addresses
>> should be aligned to page boundaries.  However, IIUC this is not checked
>> or enforced.  Otherwise, passing a hugetlb page should return the same
>> error.
>>
>> One thought would be that hugetlb mappings should behave the same
>> non-hugetlb mappings.  If passed the address of a hugetlb tail page, align
>> the address to a hugetlb boundary and migrate the page.  This changes the
>> existing behavior.  However, it would be hard to imagine anyone depending
>> on this.
>>
>> After taking a closer look at the add_page_for_migration(), it seems to
>> just ignore passed tail pages and do nothing for such passed addresses.
>> Correct?  Or, am I missing something?  Perhaps that is behavior we want/
>> need to preserve?
> 
> My mistake, status -EACCES is returned when passing a tail page of a
> hugetlb page.
> 

As mentioned in previous mail， before e66f17ff7177 ("mm/hugetlb: take
page table lock in follow_huge_pmd()") in v4.0, follow_page() will
return NULL on tail page for Huagetlb page, so move_pages() will return
-ENOENT errno, but after that commit, -EACCES is returned.

Meanwhile, the behavior of THP/HUGETLB is different, the whole THP will 
be migrated on a tail page, but HUGETLB will return -EACCES(after v4.0)
or -ENOENT(before v4.0) on tail page.

> Back to the question of 'What is the expected behavior if a tail page is
> passed?'.  I do not think we have defined an expected behavior.  If
> anything is 'expected' I would say it is -EACCES as returned today.
> 

My question is,

Should we keep seem behavior between HUGETLB and THP, or only change the
errno from -EACCES to -ENOENT/-EBUSY.

I would like to drop PageHead() check for Hugetlb to keep seem behavior,
which will keep seem error code if isolate fail or success on head/tail
page.

Thanks.

> BTW - hugetlb pages not migrated due to passing a tail page does not
> seem to contribute to a 'Positive return value' indicating the number of
> non-migrated pages.
