Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F77B775F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjHIMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHIMhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:37:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E529E10F3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:37:19 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLV0N4qggzmXSV;
        Wed,  9 Aug 2023 20:36:04 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 20:37:16 +0800
Message-ID: <a34778cb-61dd-4853-9961-afd7568cd0f7@huawei.com>
Date:   Wed, 9 Aug 2023 20:37:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
 <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
 <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <5BBFF5D3-3416-4C0E-9FDD-655661657D67@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 2023/8/8 2:45, Zi Yan wrote:
> On 7 Aug 2023, at 8:20, Kefeng Wang wrote:
> 
>> Hi Zi Yan and Matthew and Naoya,
>>
>> On 2023/8/4 13:54, Kefeng Wang wrote:
>>>
>>>
>>> On 2023/8/4 10:42, Zi Yan wrote:
>>>> On 3 Aug 2023, at 21:45, Kefeng Wang wrote:
>>>>
>>>>> On 2023/8/3 20:30, Matthew Wilcox wrote:
>>>>>> On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
>>>>>>>
>>
>> ...
>>
>>>>>
>>>>>
>>>>>     if (PageHuge(page))  // page must be a hugetlb page
>>>>>      if (PageHead(page)) // page must be a head page, not tail
>>>>>                isolate_hugetlb() // isolate the hugetlb page if head
>>>>>
>>>>> After using folio,
>>>>>
>>>>>     if (folio_test_hugetlb(folio)) // only check folio is hugetlb or not
>>>>>
>>>>> I don't check the page is head or not, since the follow_page could
>>>>> return a sub-page, so the check PageHead need be retained, right?
>>>>
>>>> Right. It will prevent the kernel from trying to isolate the same hugetlb page
>>>> twice when two pages are in the same hugetlb folio. But looking at the
>>>> code, if you try to isolate an already-isolated hugetlb folio, isolate_hugetlb()
>>>> would return false, no error would show up. But it changes err value
>>>> from -EACCES to -EBUSY and user will see a different page status than before.
>>>
>>
>> Before e66f17ff7177 ("mm/hugetlb: take page table lock in follow_huge_pmd()")
>> in v4.0, follow_page() will return NULL on tail page for Huagetlb page,
>> and move_pages() will return -ENOENT errno,but after that commit,
>> -EACCES is returned, which not match the manual,
>>
>>>
>>> When check man[1], the current -EACCES is not right, -EBUSY is not
>>> precise but more suitable for this scenario,
>>>
>>>        -EACCES
>>>                 The page is mapped by multiple processes and can be moved
>>>                 only if MPOL_MF_MOVE_ALL is specified.
>>>
>>>        -EBUSY The page is currently busy and cannot be moved.  Try again
>>>                 later.  This occurs if a page is undergoing I/O or another
>>>                 kernel subsystem is holding a reference to the page.
>>>       -ENOENT
>>>                 The page is not present.
>>>
>>>>
>>>> I wonder why we do not have follow_folio() and returns -ENOENT error pointer
>>>> when addr points to a non head page. It would make this patch more folio if
>>>> follow_folio() can be used in place of follow_page(). One caveat is that
>>>> user will see -ENOENT instead of -EACCES after this change.
>>>>
>>>
>>> -ENOENT is ok, but maybe the man need to be updated too.
>>
>> According to above analysis, -ENOENT is suitable when introduce the
>> follow_folio(), but when THP migrate support is introduced by
>> e8db67eb0ded ("mm: migrate: move_pages() supports thp migration") in
>> v4.14, the tail page will be turned into head page and return -EBUSY,
>>
>> So should we unify errno(maybe use -ENOENT) about the tail page?
>>
>>
>>>
>>>
>>>
>>> [1] https://man7.org/linux/man-pages/man2/move_pages.2.html
> 
> I think so. I think -EBUSY is more reasonable for tail pages. But there is
> some subtle difference between THP and hugetlb from current code:
> 
> For THP, compound_head() is used to get the head page for isolation, this means
> if user specifies a tail page address in move_pages(), the whole THP can be
> migrated.
> 
> For hugetlb, only if user specifies the head page address of a hugetlb page,
> the hugetlb page will be migrated. Otherwise, an error would show up.
> 
> Cc Mike to help us clarify the expected behavior of hugetlb.
> 
> Hi Mike, what is the expected behavior, if a user tries to use move_pages()
> to migrate a non head page of a hugetlb page?

Could you give some advise, thanks

> 
> --
> Best Regards,
> Yan, Zi
