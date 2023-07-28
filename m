Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255717662B2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 06:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjG1EBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjG1EBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 00:01:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FAE02D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 21:01:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1AF72F4;
        Thu, 27 Jul 2023 21:02:01 -0700 (PDT)
Received: from [10.163.51.135] (unknown [10.163.51.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB4483F6C4;
        Thu, 27 Jul 2023 21:01:14 -0700 (PDT)
Message-ID: <306b2bc5-9637-0743-b8bb-7a60aa1ad65d@arm.com>
Date:   Fri, 28 Jul 2023 09:31:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        mawupeng <mawupeng1@huawei.com>, will@kernel.org
Cc:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        sudaraja@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
 <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
 <c49c5f19-99d3-0a1f-88c6-03f60587b38c@arm.com>
 <732e0db0-eb41-6c58-85b7-46257b4ba0b7@redhat.com>
 <3149f5f8-7878-dfe1-5745-870fddcc1108@huawei.com>
 <a8775e0b-a206-3ec8-7499-a3c3cfd782e2@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <a8775e0b-a206-3ec8-7499-a3c3cfd782e2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/23 13:20, David Hildenbrand wrote:
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

Is that case possible ?

__create_pgd_mapping() is called to create the mapping both in hotplug
and boot memory cases. alloc_init_pud() ensures [1], that both virtual
and physical address ranges are PUD_MASK aligned, before creating a
huge or block page entry.

(addr | next | phys) & ~PUD_MASK) == 0 

> 
> a) Not doing that. Use PMD tables instead for that piece of memory.
> 
> b) Detecting that that PUD still covers memory and refusing to remove
>    that PUD.
> 
> c) Rejecting to hotadd memory in this situation at that location. We
>    have mhp_get_pluggable_range() -> arch_get_mappable_range() to kind-
>    of handle something like that.
>
