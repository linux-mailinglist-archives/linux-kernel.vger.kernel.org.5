Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62155760D95
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjGYIvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjGYIuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:50:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD1B35AD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:48:19 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R99Z06KWBzNmgb;
        Tue, 25 Jul 2023 16:44:24 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 16:47:47 +0800
Message-ID: <9fcfe47f-9289-8eb5-ce4e-9f66648b0e89@huawei.com>
Date:   Tue, 25 Jul 2023 16:47:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH -next v2] arm64: fix build warning for
 ARM64_MEMSTART_SHIFT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <ryan.roberts@arm.com>, <joey.gouly@arm.com>,
        <ardb@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724172751.3048501-1-chris.zjh@huawei.com>
 <ZL6UvLlyz3MyVfjr@arm.com> <4938685e-d293-4970-b964-3b9f560d45dd@arm.com>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <4938685e-d293-4970-b964-3b9f560d45dd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/25 12:22, Anshuman Khandual 写道:
>
> On 7/24/23 20:41, Catalin Marinas wrote:
>> On Mon, Jul 24, 2023 at 05:27:51PM +0000, Zhang Jianhua wrote:
>>> When building with W=1, the following warning occurs.
>>>
>>> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>>>    129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>>>        |                                         ^~~~~~~~~
>>> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>>>    142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>>>        |     ^~~~~~~~~~~~~~~~~~~~
>> Another thing that's missing here is that the warning is probably when
>> this file is included from asm-offests.h or some .S file.
>>
>>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>>> index 577773870b66..51bdce66885d 100644
>>> --- a/arch/arm64/include/asm/kernel-pgtable.h
>>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>>> @@ -125,12 +125,14 @@
>>>    * (64k granule), or a multiple that can be mapped using contiguous bits
>>>    * in the page tables: 32 * PMD_SIZE (16k granule)
>>>    */
>>> -#if defined(CONFIG_ARM64_4K_PAGES)
>>> +#if defined(CONFIG_ARM64_4K_PAGES) && defined(PUD_SHIFT)
>>>   #define ARM64_MEMSTART_SHIFT		PUD_SHIFT
>> That's not the correct fix since PUD_SHIFT should always be defined.
>> When CONFIG_PGTABLE_LEVELS == 3, pgtable-types.h includes
>> asm-generic/pgtable-nopud.h and this defines PUD_SHIFT. We either got
> Right, PUD_SHIFT is always defined irrespective of page table levels.
>
>> ARM64_MEMSTART_SHIFT defined in the wrong file or kernel-pgtable.h does
>> not pull the relevant headers (either directly or via an included
>> header). Even if kernel-pgtable.h ends up including the nopud/nopmd
>> headers, P*D_SHIFT is guarded by an #indef __ASSEMBLY__ in those files.
>>
>> Something like below appears to fix this, though I'm not particularly
>> fond of guarding the ARM64_MEMSTART_* definitions by #ifndef
>> __ASSEMBLY__ for no apparent reason (could add a comment though):
>>
>> -----------------------8<---------------------------
>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>> index 577773870b66..fcea7e87a6ca 100644
>> --- a/arch/arm64/include/asm/kernel-pgtable.h
>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>> @@ -118,6 +118,8 @@
>>   #define SWAPPER_RX_MMUFLAGS	(SWAPPER_RW_MMUFLAGS | PTE_RDONLY)
>>   #endif
>>   
>> +#ifndef __ASSEMBLY__
>> +
>>   /*
>>    * To make optimal use of block mappings when laying out the linear
>>    * mapping, round down the base of physical memory to a size that can
>> @@ -145,4 +147,6 @@
>>   #define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_SHIFT)
>>   #endif
>>   
>> +#endif /* __ASSEMBLY__ */
>> +
>>   #endif	/* __ASM_KERNEL_PGTABLE_H */
>> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> index e4944d517c99..22b36f2d5d93 100644
>> --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> @@ -6,6 +6,7 @@
>>   #define __ASM_PGTABLE_HWDEF_H
>>   
>>   #include <asm/memory.h>
>> +#include <asm/pgtable-types.h>
>>   
>>   /*
>>    * Number of page-table levels required to address 'va_bits' wide
>> diff --git a/arch/arm64/include/asm/pgtable-types.h b/arch/arm64/include/asm/pgtable-types.h
>> index b8f158ae2527..ae86e66fdb11 100644
>> --- a/arch/arm64/include/asm/pgtable-types.h
>> +++ b/arch/arm64/include/asm/pgtable-types.h
>> @@ -11,6 +11,8 @@
>>   
>>   #include <asm/types.h>
>>   
>> +#ifndef __ASSEMBLY__
>> +
>>   typedef u64 pteval_t;
>>   typedef u64 pmdval_t;
>>   typedef u64 pudval_t;
>> @@ -44,6 +46,8 @@ typedef struct { pteval_t pgprot; } pgprot_t;
>>   #define pgprot_val(x)	((x).pgprot)
>>   #define __pgprot(x)	((pgprot_t) { (x) } )
>>   
>> +#endif /* __ASSEMBLY__ */
>> +
>>   #if CONFIG_PGTABLE_LEVELS == 2
>>   #include <asm-generic/pgtable-nopmd.h>
>>   #elif CONFIG_PGTABLE_LEVELS == 3
>> -----------------------8<---------------------------
>>
>> To avoid guarding the ARM64_MEMSTART_* definitions, we could instead
>> move the P*D_SHIFT definitions in asm-generic/pgtable-nop*d.h outside
>> the #ifndef __ASSEMBLY__ block.
> OR could ARM64_MEMSTART_SHIFT and ARM64_MEMSTART_ALIGN computation blocks
> be moved inside arch/arm64/mm/init.c, where it is used exclusively. Seems
> to be solving the problem as well.

This method can avoid the current compilation warning, but does not 
solve the problem

that PUD_SHIFT and PMD_SHIFT undefined in fact, and it is contrary to 
XXX_SHIFT should

always be defined. Maybe it would be more appropriate to solve this 
issue directly.

