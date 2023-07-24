Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7675E9AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGXCYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGXCY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:24:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA380E53
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:24:10 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R8MpC3W0xztRZ0;
        Mon, 24 Jul 2023 09:22:11 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 09:25:22 +0800
Message-ID: <35a0dad6-4f3b-f2c3-f835-b13c1e899f8d@huawei.com>
Date:   Mon, 24 Jul 2023 09:25:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC:     <mawupeng1@huawei.com>, <catalin.marinas@arm.com>,
        <akpm@linux-foundation.org>, <sudaraja@codeaurora.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <anshuman.khandual@arm.com>
Subject: Re: [RFC PATCH] arm64: mm: Fix kernel page tables incorrectly deleted
 during memory removal
Content-Language: en-US
To:     <will@kernel.org>
References: <20230717115150.1806954-1-mawupeng1@huawei.com>
 <20230721103628.GA12601@willie-the-truck>
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20230721103628.GA12601@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/21 18:36, Will Deacon wrote:
> On Mon, Jul 17, 2023 at 07:51:50PM +0800, Wupeng Ma wrote:
>> From: Ma Wupeng <mawupeng1@huawei.com>
>>
>> During our test, we found that kernel page table may be unexpectedly
>> cleared with rodata off. The root cause is that the kernel page is
>> initialized with pud size(1G block mapping) while offline is memory
>> block size(MIN_MEMORY_BLOCK_SIZE 128M), eg, if 2G memory is hot-added,
>> when offline a memory block, the call trace is shown below,
>>
>>  offline_and_remove_memory
>>     try_remove_memory
>>       arch_remove_memory
>>        __remove_pgd_mapping
>>          unmap_hotplug_range
>>            unmap_hotplug_p4d_range
>>              unmap_hotplug_pud_range
>>                if (pud_sect(pud))
>>                  pud_clear(pudp);
> 
> Sorry, but I'm struggling to understand the problem here. If we're adding
> and removing a 2G memory region, why _wouldn't_ we want to use large 1GiB
> mappings?


> Or are you saying that only a subset of the memory is removed,
> but we then accidentally unmap the whole thing?

Yes, umap a subset but the whole thing page table entry is removed.

> 
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 95d360805f8a..44c724ce4f70 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -44,6 +44,7 @@
>>  #define NO_BLOCK_MAPPINGS	BIT(0)
>>  #define NO_CONT_MAPPINGS	BIT(1)
>>  #define NO_EXEC_MAPPINGS	BIT(2)	/* assumes FEAT_HPDS is not used */
>> +#define NO_PUD_MAPPINGS		BIT(3)
>>  
>>  int idmap_t0sz __ro_after_init;
>>  
>> @@ -344,7 +345,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
>>  		 */
>>  		if (pud_sect_supported() &&
>>  		   ((addr | next | phys) & ~PUD_MASK) == 0 &&
>> -		    (flags & NO_BLOCK_MAPPINGS) == 0) {
>> +		    (flags & (NO_BLOCK_MAPPINGS | NO_PUD_MAPPINGS)) == 0) {
>>  			pud_set_huge(pudp, phys, prot);
>>  
>>  			/*
>> @@ -1305,7 +1306,7 @@ struct range arch_get_mappable_range(void)
>>  int arch_add_memory(int nid, u64 start, u64 size,
>>  		    struct mhp_params *params)
>>  {
>> -	int ret, flags = NO_EXEC_MAPPINGS;
>> +	int ret, flags = NO_EXEC_MAPPINGS | NO_PUD_MAPPINGS;
> 
> I think we should allow large mappings here and instead prevent partial
> removal of the block, if that's what is causing the issue.

This could solve this problem.
Or we can prevent  partial removal? Or rebulid page table entry which is not removed?

> 
> Will
