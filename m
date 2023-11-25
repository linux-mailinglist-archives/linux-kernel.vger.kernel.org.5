Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972BD7F87C5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 03:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjKYCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 21:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKYCWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 21:22:09 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2E10F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 18:22:13 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ScbB62NhwzsRCl;
        Sat, 25 Nov 2023 10:18:38 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 25 Nov 2023 10:22:10 +0800
Message-ID: <2dbbd4e7-036f-4643-b05f-5967f4253ab8@huawei.com>
Date:   Sat, 25 Nov 2023 10:22:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
Content-Language: en-US
To:     Dmytro Maluka <dmaluka@chromium.org>,
        Michal Hocko <mhocko@suse.com>
CC:     Liu Shixin <liushixin2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kemi Wang <kemi.wang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
 <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
 <YwTYMGtcS4/F/xQO@dhcp22.suse.cz> <ZWDjbrHx6XNzAtl_@google.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZWDjbrHx6XNzAtl_@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/11/25 1:54, Dmytro Maluka wrote:
> On Tue, Aug 23, 2022 at 03:37:52PM +0200, Michal Hocko wrote:
>> On Tue 23-08-22 20:46:43, Liu Shixin wrote:
>>> On 2022/8/23 15:50, Michal Hocko wrote:
>>>> On Mon 22-08-22 14:12:07, Andrew Morton wrote:
>>>>> On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>>>>
>>>>>> The page on pcplist could be used, but not counted into memory free or
>>>>>> avaliable, and pcp_free is only showed by show_mem() for now. Since commit
>>>>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>>>>> significant decrease in the display of free memory, with a large number
>>>>>> of cpus and zones, the number of pages in the percpu list can be very
>>>>>> large, so it is better to let user to know the pcp count.
>>>>>>
>>>>>> On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
>>>>>> maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
>>>>>> After the patch, the lists can hold 324MB. It has been observed to be 114MB
>>>>>> in the idle state after system startup in practice(increased 80 MB).
>>>>>>
>>>>> Seems reasonable.
>>>> I have asked in the previous incarnation of the patch but haven't really
>>>> received any answer[1]. Is this a _real_ problem? The absolute amount of
>>>> memory could be perceived as a lot but is this really noticeable wrt
>>>> overall memory on those systems?
> 
> Let me provide some other numbers, from the desktop side. On a low-end
> chromebook with 4GB RAM and a dual-core CPU, after commit b92ca18e8ca5
> (mm/page_alloc: disassociate the pcp->high from pcp->batch) the max
> amount of PCP pages increased 56x times: from 2.9MB (1.45 per CPU) to
> 165MB (82.5MB per CPU).
> 
> On such a system, memory pressure conditions are not a rare occurrence,
> so several dozen MB make a lot of difference.

And with mm: PCP high auto-tuning merged in v6.7， the pcp could be more 
bigger than before.

> 
> (The reason it increased so much is because it now corresponds to the
> low watermark, which is 165MB. And the low watermark, in turn, is so
> high because of khugepaged, which bumps up min_free_kbytes to 132MB
> regardless of the total amount of memory.)
> 
>>> This may not obvious when the memory is sufficient. However, as products monitor the
>>> memory to plan it. The change has caused warning.
>>
>> Is it possible that the said monitor is over sensitive and looking at
>> wrong numbers? Overall free memory doesn't really tell much TBH.
>> MemAvailable is a very rough estimation as well.
>>
>> In reality what really matters much more is whether the memory is
>> readily available when it is required and none of MemFree/MemAvailable
>> gives you that information in general case.
>>
>>> We have also considered using /proc/zoneinfo to calculate the total
>>> number of pcplists. However, we think it is more appropriate to add
>>> the total number of pcplists to free and available pages. After all,
>>> this part is also free pages.
>>
>> Those free pages are not generally available as exaplained. They are
>> available to a specific CPU, drained under memory pressure and other
>> events but still there is no guarantee a specific process can harvest
>> that memory because the pcp caches are replenished all the time.
>> So in a sense it is a semi-hidden memory.
> 
> I was intuitively assuming that per-CPU pages should be always available
> for allocation without resorting to paging out allocated pages (and thus
> it should be non-controversially a good idea to include per-CPU pages in
> MemFree, to make it more accurate).
> 
> But looking at the code in __alloc_pages() and around, I see you are
> right: we don't try draining other CPUs' PCP lists *before* resorting to
> direct reclaim, compaction etc.
> 
> BTW, why not? Shouldn't draining PCP lists be cheaper than pageout() in
> any case?

Same question here, could drain pcp before direct reclaim?

> 
>> That being said, I am still not convinced this is actually going to help
>> all that much. You will see a slightly different numbers which do not
>> tell much one way or another and if the sole reason for tweaking these
>> numbers is that some monitor is complaining because X became X-epsilon
>> then this sounds like a weak justification to me. That epsilon happens
>> all the time because there are quite some hidden caches that are
>> released under memory pressure. I am not sure it is maintainable to
>> consider each one of them and pretend that MemFree/MemAvailable is
>> somehow precise. It has never been and likely never will be.
>> -- 
>> Michal Hocko
>> SUSE Labs
