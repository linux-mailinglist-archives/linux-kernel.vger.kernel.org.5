Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86417660F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjG1BGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjG1BGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:06:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B397113
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:06:19 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RBqC01h5nzLnvh;
        Fri, 28 Jul 2023 09:03:40 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 09:06:16 +0800
Message-ID: <b2aaeed0-26b4-bb00-de17-6a2f2cb183ff@huawei.com>
Date:   Fri, 28 Jul 2023 09:06:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <mawupeng1@huawei.com>, <catalin.marinas@arm.com>,
        <akpm@linux-foundation.org>, <sudaraja@codeaurora.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
To:     <david@redhat.com>, <anshuman.khandual@arm.com>, <will@kernel.org>
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
 <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
 <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
 <732e0db0-eb41-6c58-85b7-46257b4ba0b7@redhat.com>
 <3149f5f8-7878-dfe1-5745-870fddcc1108@huawei.com>
 <a8775e0b-a206-3ec8-7499-a3c3cfd782e2@redhat.com>
Content-Language: en-US
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <a8775e0b-a206-3ec8-7499-a3c3cfd782e2@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/26 15:50, David Hildenbrand wrote:
> On 26.07.23 08:20, mawupeng wrote:
>>
>>
>> On 2023/7/24 14:11, David Hildenbrand wrote:
>>> On 24.07.23 07:54, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 7/24/23 06:55, mawupeng wrote:
>>>>>
>>>>> On 2023/7/21 18:36, Will Deacon wrote:
>>>>>> On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
>>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>>
>>>>>>> During our test, we found that kernel page table may be unexpectedly
>>>>>>> cleared with rodata off. The root cause is that the kernel page is
>>>>>>> initialized with pud size(1G block mapping) while offline is memory
>>>>>>> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
>>>>>>> when offline a memory block, the call trace is shown below,
>>>
>>> Is someone adding memory in 2 GiB granularity and then removing parts of it in 128 MiB granularity? That would be against what we support using the add_memory() / offline_and_remove_memory() API and that driver should be fixed instead.
>>
>> Yes, this kind of situation.
>>
>> The problem occurs in the following scenarios:
>> 1. use mem=xxG to reserve memory.
>> 2. add_momory to online memory.
>> 3. offline part of the memroy via offline_and_remove_memory.
>>
>> During my research, ACPI memory removal use memory_subsys_offline to offline memory section and
>> this will not delete page table entry which do not trigger this kind of problem.
>>
>> So I understand what you are talking about.
>> 1. 3rd-party driver shouldn't use add_memory/offline_and_remove_memory to online/offline memory.
>>     If it have to use, this can be achieved by driver.
>> 2. memory_subsys_offline is perfered to do such thing.
> 
> No, my point is that
> 
> 1) If you use add_memory() and offline_and_remove_memory() in the *same
>    granularity* it has to be working, otherwise it has to be fixed.
> 
> 2) If you use add_memory() and offline_and_remove_memory() in different
>    granularity (especially, add_memory() in bigger granularity) , then
>    change your code to do add_memory() in the same granularity.
> 
> 
> If you run into 1), then we populated a PUD for boot memory that also covers yet unpopulated physical memory ranges that are later populated by add_memory(). If that's the case, then we can either fix it by
> 
> a) Not doing that. Use PMD tables instead for that piece of memory.
> 
> b) Detecting that that PUD still covers memory and refusing to remove
>    that PUD.
> 
> c) Rejecting to hotadd memory in this situation at that location. We
>    have mhp_get_pluggable_range() -> arch_get_mappable_range() to kind-
>    of handle something like that.

Thank you for your patient answer.

This I do understand and answer my question.

> 
