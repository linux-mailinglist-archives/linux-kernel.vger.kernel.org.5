Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3857BEF95
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379211AbjJJAPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344700AbjJJAPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:15:46 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C6B0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1696896940; bh=asTxnfcz7WqzjvZNDDi3T3zgLacfGziMSUDFrjvbCuM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MylMqM4nRy+DrXRa+em5n6HbdgNH/OW7HkjV/ZmWGEqdqME+A8CizR3FvLsLM+Yyh
         UVLn65wLUYjKODmn7hWvgZ1Z9001IGRJkVy2Qui3TcWPDWpz7kljmYSj2B0Wc3Y5bd
         TaSXlRX6D6LYL2vsqEt6UTcnQo3QdlT4XF1ejQLc=
Received: from [IPV6:240e:388:8d29:7200:a9cd:3b9b:8239:95ad] (unknown [IPv6:240e:388:8d29:7200:a9cd:3b9b:8239:95ad])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 39A6E600A6;
        Tue, 10 Oct 2023 08:15:40 +0800 (CST)
Message-ID: <42b0e6f6-c2b5-49c6-b1f2-0200bef913da@xen0n.name>
Date:   Tue, 10 Oct 2023 08:15:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loongarch/mm: disable WUC for pgprot_writecombine as
 same as ioremap_wc
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Icenowy Zheng <uwu@icenowy.me>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Weihao Li <liweihao@loongson.cn>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Jun Yi <yijun@loongson.cn>, Baoquan He <bhe@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zhihong Dong <donmor3000@hotmail.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231009042841.635366-1-uwu@icenowy.me>
 <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <4f1af31b-15be-cb47-6b34-45de1b5696be@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/23 22:32, Sui Jingfeng wrote:
> Hi,
>
>
> On 2023/10/9 12:28, Icenowy Zheng wrote:
>> Currently the code disables WUC only disables it for ioremap_wc(), which
>> is only used when mapping writecombine pages like ioremap() (mapped to
>> the kernel space). For VRAM mapped in TTM/GEM, it's mapped with a
>> crafted pgprot with pgprot_writecombine() function, which isn't
>> corrently disabled now.
>>
>> Disable WUC for pgprot_writecombine() (fallback to SUC) too.
>>
>> This improves AMDGPU driver stability on Loongson 3A5000 machines.
>>
>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
>> ---
>> Changes since v1:
>> - Removed _WC macros
>> - Mention ioremap_wc in commit message
>>
>>   arch/loongarch/include/asm/io.h           |  5 ++---
>>   arch/loongarch/include/asm/pgtable-bits.h |  4 +++-
>>   arch/loongarch/kernel/setup.c             | 10 +++++-----
>>   3 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/io.h 
>> b/arch/loongarch/include/asm/io.h
>> index 0dcb36b32cb25..290aad87a8847 100644
>> --- a/arch/loongarch/include/asm/io.h
>> +++ b/arch/loongarch/include/asm/io.h
>> @@ -52,10 +52,9 @@ static inline void __iomem 
>> *ioremap_prot(phys_addr_t offset, unsigned long size,
>>    * @offset:    bus address of the memory
>>    * @size:      size of the resource to map
>>    */
>> -extern pgprot_t pgprot_wc;
>> -
>>   #define ioremap_wc(offset, size)    \
>> -    ioremap_prot((offset), (size), pgprot_val(pgprot_wc))
>> +    ioremap_prot((offset), (size), pgprot_val( \
>> +        wc_enabled ? PAGE_KERNEL_WUC : PAGE_KERNEL_SUC))
>>     #define ioremap_cache(offset, size)    \
>>       ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
>> diff --git a/arch/loongarch/include/asm/pgtable-bits.h 
>> b/arch/loongarch/include/asm/pgtable-bits.h
>> index 35348d4c4209a..a3d827701736d 100644
>> --- a/arch/loongarch/include/asm/pgtable-bits.h
>> +++ b/arch/loongarch/include/asm/pgtable-bits.h
>> @@ -92,6 +92,8 @@
>>     #ifndef __ASSEMBLY__
>>   +extern bool wc_enabled;
>> +
>>   #define _PAGE_IOREMAP        pgprot_val(PAGE_KERNEL_SUC)
>>     #define pgprot_noncached pgprot_noncached
>> @@ -111,7 +113,7 @@ static inline pgprot_t 
>> pgprot_writecombine(pgprot_t _prot)
>>   {
>>       unsigned long prot = pgprot_val(_prot);
>>   -    prot = (prot & ~_CACHE_MASK) | _CACHE_WUC;
>> +    prot = (prot & ~_CACHE_MASK) | (wc_enabled ? _CACHE_WUC : 
>> _CACHE_SUC);
>>         return __pgprot(prot);
>>   }
>> diff --git a/arch/loongarch/kernel/setup.c 
>> b/arch/loongarch/kernel/setup.c
>> index 7783f0a3d742c..465c1dbb6f4b4 100644
>> --- a/arch/loongarch/kernel/setup.c
>> +++ b/arch/loongarch/kernel/setup.c
>> @@ -161,19 +161,19 @@ static void __init smbios_parse(void)
>>   }
>>     #ifdef CONFIG_ARCH_WRITECOMBINE
>> -pgprot_t pgprot_wc = PAGE_KERNEL_WUC;
>> +bool wc_enabled = true;
>>   #else
>> -pgprot_t pgprot_wc = PAGE_KERNEL_SUC;
>> +bool wc_enabled;
>>   #endif
>>   -EXPORT_SYMBOL(pgprot_wc);
>> +EXPORT_SYMBOL(wc_enabled);
>>     static int __init setup_writecombine(char *p)
>>   {
>>       if (!strcmp(p, "on"))
>> -        pgprot_wc = PAGE_KERNEL_WUC;
>> +        wc_enabled = true;
>>       else if (!strcmp(p, "off"))
>> -        pgprot_wc = PAGE_KERNEL_SUC;
>> +        wc_enabled = false;
>>       else
>>           pr_warn("Unknown writecombine setting \"%s\".\n", p);
>
>
> Good catch!
>
> But this will make the write combine(WC) mappings completely unusable 
> on LoongArch.
> This is nearly equivalent to say that LoongArch don't support write 
> combine at all.
> But the write combine(WC) mappings works fine for software based drm 
> drivers,
> such as drm/loongson and drm/ast etc. Even include drm/radeon and 
> drm/amdgpu with
> pure software rendering setup (by putting Option "Accel" "off" into 
> 10-amdgpu.conf
> or 10-radeon.conf) After merge this patch, the performance drop 
> dramatically for
> 2D software rendering based display controller drivers.
>
> Well, this patch itself is a good catch, as it is a fix for the commit 
> <16c52e503043>
> ("LoongArch: Make WriteCombine configurable for ioremap()"). But I'm 
> afraid that
> both of this commit and the <16c52e503043> commit are not a *real* fix 
> write combine
> related issue on LoongArch. It just negative sidestep of the real 
> problem.
Sure, but given the public information I have access to, I don't think 
it's possible to "really" fix the root cause with software only. Do you 
have any insight on this, given from your perspective and language, such 
a solution seems to exist?

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

