Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F17E996F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjKMJvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjKMJvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:51:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D6510D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:51:05 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4STPhq1SclzPpGX;
        Mon, 13 Nov 2023 17:46:51 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 17:51:02 +0800
Message-ID: <330c9fd5-fa24-4b07-a3e7-2923e4ab4c89@huawei.com>
Date:   Mon, 13 Nov 2023 17:51:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] mm: ksm: use more folio api in
 ksm_might_need_to_copy()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20231107135216.415926-1-wangkefeng.wang@huawei.com>
 <20231107135216.415926-2-wangkefeng.wang@huawei.com>
 <ZUpIlkO0E7+i2hCg@casper.infradead.org>
 <81e0289c-225c-4468-959c-937d3678cb2d@huawei.com>
 <ZUuUVDbiWETJ2OU1@casper.infradead.org>
 <67eedbab-bf15-4bc3-88ce-36fc074393bd@huawei.com>
 <d5fed34e-359d-4a06-85bd-27694bcf6e4d@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <d5fed34e-359d-4a06-85bd-27694bcf6e4d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2023/11/13 16:32, David Hildenbrand wrote:
> On 09.11.23 08:09, Kefeng Wang wrote:
>>
>>
>> On 2023/11/8 21:59, Matthew Wilcox wrote:
>>> On Wed, Nov 08, 2023 at 09:40:09AM +0800, Kefeng Wang wrote:
>>>>
>>>>
>>>> On 2023/11/7 22:24, Matthew Wilcox wrote:
>>>>> On Tue, Nov 07, 2023 at 09:52:11PM +0800, Kefeng Wang wrote:
>>>>>>     struct page *ksm_might_need_to_copy(struct page *page,
>>>>>> -            struct vm_area_struct *vma, unsigned long address)
>>>>>> +            struct vm_area_struct *vma, unsigned long addr)
>>>>>>     {
>>>>>>         struct folio *folio = page_folio(page);
>>>>>>         struct anon_vma *anon_vma = folio_anon_vma(folio);
>>>>>> -    struct page *new_page;
>>>>>> +    struct folio *new_folio;
>>>>>> -    if (PageKsm(page)) {
>>>>>> -        if (page_stable_node(page) &&
>>>>>> +    if (folio_test_ksm(folio)) {
>>>>>> +        if (folio_stable_node(folio) &&
>>>>>>                 !(ksm_run & KSM_RUN_UNMERGE))
>>>>>>                 return page;    /* no need to copy it */
>>>>>>         } else if (!anon_vma) {
>>>>>>             return page;        /* no need to copy it */
>>>>>> -    } else if (page->index == linear_page_index(vma, address) &&
>>>>>> +    } else if (page->index == linear_page_index(vma, addr) &&
>>>>>
>>>>> Hmm.  page->index is going away.  What should we do here instead?
>>>>
>>>> Do you mean to replace page->index to folio->index, or kill index from
>>>> struct page?
>>>
>>> I'm asking you what we should do.
>>>
>>> Tail pages already don't have a valid ->index (or ->mapping).
>>> So presumably we can't see a tail page here today.  But will we in 
>>> future?
>>
>> I think we could replace page->index to page_to_pgoff(page).
> 
> What the second part of that code does is check whether a page might 
> have been a KSM page before swapout.
> 
> Once a KSM page is swapped out, we lose the KSM marker. To recover, we 
> have to check whether the new page logically "fits" into the VMA.
> 
> Large folios are never KSM folios, and we only swap in small folios (and 
> in the future, once we would swap in large folios, they couldn't have 
> been KSM folios before).
> 
> So you could return early in the function if we have a large folio and 
> make all operations based on the (small) folio.

Sure, I will add folio_test_large check ahead and convert page->index to 
folio->index, and adjust the logical if ksm and swapin support large 
folio, thanks.
