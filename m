Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B95805C6F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjLERIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLERIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:08:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F189DA9;
        Tue,  5 Dec 2023 09:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=1llierF4zA5793A0h8X4gsP2jzq0+KwCB4rIq5DDmzk=; b=VZUbUKqL5NX+XS5uyMthkp/nId
        OVaS08z9q7+cJ/3uONusQZfOFscvx0ZTXbIZSnZT6EdhPkAutf+jaoCPUWR1+i1iKmTSBkWhWqC9z
        rLAvq6LZuTWic/4zPopHcUaTSjoDKVAKgJbPild6F4eMt0OLO7Jk7siA51jy2isnDjzc5tfX5tsRY
        USwbjhPxdzSuFN9BPjemmk9vEwRdLxgahXg+SOkZgs5yP4BoUpnDF46pypE5PeFkhwc0JwAVrdOiX
        r2KD3WhCfOfl1FwGLCedvoOedXoLU0gokVgNE8o/V8nipxbt0kMPNBF80tW1ZOwooSuZ6rhIXM22E
        eJ12iGJw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAYuW-007zp0-1J;
        Tue, 05 Dec 2023 17:08:40 +0000
Message-ID: <5f9f018a-dc4f-42f0-ba90-2f44d2f61a7c@infradead.org>
Date:   Tue, 5 Dec 2023 09:08:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv, crash: don't export some symbols when
 CONFIG_MMU=n
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org,
        ignat@cloudflare.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kexec@lists.infradead.org, eric_devolder@yahoo.com
References: <ZW00/Cfk47Cc3kGo@MiWiFi-R3L-srv>
 <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
 <694baf13-65d0-4877-b6c7-56e3006f83be@infradead.org>
 <ZW7OsX4zQRA3mO4+@MiWiFi-R3L-srv>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZW7OsX4zQRA3mO4+@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 23:18, Baoquan He wrote:
> On 12/04/23 at 11:14am, Randy Dunlap wrote:

[]

>>
>> Both riscv 32-bit and 64-bit complain:
>>
>> ../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
>> ../arch/riscv/kernel/crash_core.c:11:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
>>    11 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>>       |                                                        ~~^
>>       |                                                          |
>>       |                                                          long unsigned int
>>       |                                                        %x
> 
> Thanks for all these testing.
> 
> This warning is irrelevant to the kexec patch, it's becasue 
> VMALLOC_START is defined as 0 which is int when CONFIG_MMU=n.
> 
> Below patch can fix the warning.
> 
> From 46984a0287e5f1b41ae3e9adfcfa0d26b71db8f4 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Tue, 5 Dec 2023 11:02:55 +0800
> Subject: [PATCH] riscv: fix VMALLC_START definition
> Content-type: text/plain
> 
> When below config items are set, compiler complained:
> 
> --------------------
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ......
> -----------------------
> 
> -------------------------------------------------------------------
> arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
> arch/riscv/kernel/crash_core.c:11:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
> 11 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>    |                                                        ~~^
>    |                                                          |
>    |                                                          long unsigned int
>    |                                                        %x
> ----------------------------------------------------------------------
> 
> This is because on riscv macro VMALLOC_START has different type when
> CONFIG_MMU is set or unset.
> 
> arch/riscv/include/asm/pgtable.h:
> --------------------------------------------------
> 
> Changing it to _AC(0, UL) in case CONFIG_MMU=n can fix the warning.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


Thanks.

> ---
>  arch/riscv/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 294044429e8e..ab00235b018f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -899,7 +899,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  #define PAGE_KERNEL		__pgprot(0)
>  #define swapper_pg_dir		NULL
>  #define TASK_SIZE		0xffffffffUL
> -#define VMALLOC_START		0
> +#define VMALLOC_START		_AC(0, UL)
>  #define VMALLOC_END		TASK_SIZE
>  
>  #endif /* !CONFIG_MMU */

-- 
~Randy
