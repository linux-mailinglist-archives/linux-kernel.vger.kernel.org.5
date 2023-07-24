Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C4475EBA2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjGXGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXGg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:36:27 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3410D0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:35:59 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8VhG49D2zHqbw;
        Mon, 24 Jul 2023 14:32:30 +0800 (CST)
Received: from [10.67.110.73] (10.67.110.73) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:35:03 +0800
Message-ID: <b09eef83-db27-d716-d8e2-505f37053ecd@huawei.com>
Date:   Mon, 24 Jul 2023 14:35:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH -next] arm64: fix -Wundef warning for PUD_SHIFT
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <joey.gouly@arm.com>,
        <mark.rutland@arm.com>, <ardb@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230724103055.2379274-1-chris.zjh@huawei.com>
 <b31592db-d589-c425-1f5f-1c981ec72a65@arm.com>
From:   "zhangjianhua (E)" <chris.zjh@huawei.com>
In-Reply-To: <b31592db-d589-c425-1f5f-1c981ec72a65@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/24 11:26, Anshuman Khandual 写道:
>
> On 7/24/23 16:00, Zhang Jianhua wrote:
>> When building with W=1, the following warning occurs.
>>
>> arch/arm64/include/asm/kernel-pgtable.h:129:41: error: "PUD_SHIFT" is not defined, evaluates to 0 [-Werror=undef]
>>    129 | #define ARM64_MEMSTART_SHIFT            PUD_SHIFT
>>        |                                         ^~~~~~~~~
>> arch/arm64/include/asm/kernel-pgtable.h:142:5: note: in expansion of macro ‘ARM64_MEMSTART_SHIFT’
>>    142 | #if ARM64_MEMSTART_SHIFT < SECTION_SIZE_BITS
>>        |     ^~~~~~~~~~~~~~~~~~~~
>>
>> The reason is that PUD_SHIFT isn't defined if CONFIG_PGTABLE_LEVELS ==
>> 3, and at this time PUD_SHIFT is equal to PGDIR_SHIFT, so define it.
> CONFIG_PGTABLE_LEVELS equals 3 only with CONFIG_VA_BITS = 39.
>
>> Fixes: 06e9bf2fd9b3 ("arm64: choose memstart_addr based on minimum sparsemem section alignment")
> This is not a fix, ARM64_MEMSTART_ALIGN would fallback being (1UL << SECTION_SIZE_BITS)
> when PUD_SHIFT is undefined (aka 0) but agreed that it's not clean.
Yes, it wouldn't be wrong in the end.
>> Signed-off-by: Zhang Jianhua <chris.zjh@huawei.com>
>> ---
>> v2:
>> 	Define PUD_SHIFT before use it instead of judgement
>> ---
>> ---
>>   arch/arm64/include/asm/kernel-pgtable.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
>> index 577773870b66..996a144e2929 100644
>> --- a/arch/arm64/include/asm/kernel-pgtable.h
>> +++ b/arch/arm64/include/asm/kernel-pgtable.h
>> @@ -59,6 +59,10 @@
>>   #define EARLY_KASLR	(0)
>>   #endif
>>   
>> +#ifndef PUD_SHIFT
>> +#define PUD_SHIFT PGDIR_SHIFT
>> +#endif
> Rather ARM64_MEMSTART_SHIFT block needs to be re-written in a more pgtable levels agnostic
> manner ? OR maybe something like this.
>
> diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
> index 577773870b66..5a83b4b249e8 100644
> --- a/arch/arm64/include/asm/kernel-pgtable.h
> +++ b/arch/arm64/include/asm/kernel-pgtable.h
> @@ -125,12 +125,14 @@
>    * (64k granule), or a multiple that can be mapped using contiguous bits
>    * in the page tables: 32 * PMD_SIZE (16k granule)
>    */
> -#if defined(CONFIG_ARM64_4K_PAGES)
> +#if defined(CONFIG_ARM64_4K_PAGES) && defined(PUD_SHIFT)
>   #define ARM64_MEMSTART_SHIFT           PUD_SHIFT
> -#elif defined(CONFIG_ARM64_16K_PAGES)
> +#elif defined(CONFIG_ARM64_16K_PAGES) && defined(CONT_PMD_SHIFT)
>   #define ARM64_MEMSTART_SHIFT           CONT_PMD_SHIFT
> -#else
> +#elif defined(CONFIG_AR64_64K_PAGES) && defined(PMD_SHIFT)
>   #define ARM64_MEMSTART_SHIFT           PMD_SHIFT
> +#else
> +#define ARM64_MEMSTART_SHIFT           PGDIR_SHIFT
>   #endif
>
> The only cases where PUD_SHIFT or PMD_SHIFT (along with CONT_PMD_SHIFT) would not be defined is
> when XXX_SHIFT level itself matches PGDIR_SHIFT.
Thanks for your reply, this modification seems more comprehensive and 
appropriate. I will send v2 patch soon.
>> +
>>   #define SPAN_NR_ENTRIES(vstart, vend, shift) \
>>   	((((vend) - 1) >> (shift)) - ((vstart) >> (shift)) + 1)
>>
