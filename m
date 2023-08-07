Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057C37723BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjHGMVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjHGMVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:21:04 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC71710E2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:20:43 -0700 (PDT)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RKFgr319fz1Z1Yh;
        Mon,  7 Aug 2023 20:17:28 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 20:20:15 +0800
Message-ID: <de0100e4-d673-428b-8d50-11ae2b7a9641@huawei.com>
Date:   Mon, 7 Aug 2023 20:20:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: migrate: use a folio in add_page_for_migration()
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Zi Yan <ziy@nvidia.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
References: <20230802095346.87449-1-wangkefeng.wang@huawei.com>
 <20230802095346.87449-2-wangkefeng.wang@huawei.com>
 <ZMpKYfNWA/jNgEuL@casper.infradead.org>
 <001ee9b0-ea25-a896-e3ae-9a9b05a46546@huawei.com>
 <ZMud3RreEpsvFKuA@casper.infradead.org>
 <fb2a22cf-14ae-3594-f5f3-8680c2100d70@huawei.com>
 <F2621E68-F36E-493C-8619-ADFE05050823@nvidia.com>
 <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
In-Reply-To: <d184ba78-97d1-a264-fc31-87dfdbe6fdff@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zi Yan and Matthew and Naoya,

On 2023/8/4 13:54, Kefeng Wang wrote:
> 
> 
> On 2023/8/4 10:42, Zi Yan wrote:
>> On 3 Aug 2023, at 21:45, Kefeng Wang wrote:
>>
>>> On 2023/8/3 20:30, Matthew Wilcox wrote:
>>>> On Thu, Aug 03, 2023 at 03:13:21PM +0800, Kefeng Wang wrote:
>>>>>

...

>>>
>>>
>>>    if (PageHuge(page))  // page must be a hugetlb page
>>>     if (PageHead(page)) // page must be a head page, not tail
>>>               isolate_hugetlb() // isolate the hugetlb page if head
>>>
>>> After using folio,
>>>
>>>    if (folio_test_hugetlb(folio)) // only check folio is hugetlb or not
>>>
>>> I don't check the page is head or not, since the follow_page could
>>> return a sub-page, so the check PageHead need be retained, right?
>>
>> Right. It will prevent the kernel from trying to isolate the same 
>> hugetlb page
>> twice when two pages are in the same hugetlb folio. But looking at the
>> code, if you try to isolate an already-isolated hugetlb folio, 
>> isolate_hugetlb()
>> would return false, no error would show up. But it changes err value
>> from -EACCES to -EBUSY and user will see a different page status than 
>> before.
> 

Before e66f17ff7177 ("mm/hugetlb: take page table lock in 
follow_huge_pmd()")
in v4.0, follow_page() will return NULL on tail page for Huagetlb page,
and move_pages() will return -ENOENT errno,but after that commit,
-EACCES is returned, which not match the manual,

> 
> When check man[1], the current -EACCES is not right, -EBUSY is not
> precise but more suitable for this scenario,
> 
>       -EACCES
>                The page is mapped by multiple processes and can be moved
>                only if MPOL_MF_MOVE_ALL is specified.
> 
>       -EBUSY The page is currently busy and cannot be moved.  Try again
>                later.  This occurs if a page is undergoing I/O or another
>                kernel subsystem is holding a reference to the page.
>      -ENOENT
>                The page is not present.
> 
>>
>> I wonder why we do not have follow_folio() and returns -ENOENT error 
>> pointer
>> when addr points to a non head page. It would make this patch more 
>> folio if
>> follow_folio() can be used in place of follow_page(). One caveat is that
>> user will see -ENOENT instead of -EACCES after this change.
>>
> 
> -ENOENT is ok, but maybe the man need to be updated too.

According to above analysis, -ENOENT is suitable when introduce the
follow_folio(), but when THP migrate support is introduced by
e8db67eb0ded ("mm: migrate: move_pages() supports thp migration") in
v4.14, the tail page will be turned into head page and return -EBUSY,

So should we unify errno(maybe use -ENOENT) about the tail page?


> 
> 
> 
> [1] https://man7.org/linux/man-pages/man2/move_pages.2.html
