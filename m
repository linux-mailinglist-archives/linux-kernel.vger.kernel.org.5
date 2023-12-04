Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2D9803E24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjLDTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjLDTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:14:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EE2E6;
        Mon,  4 Dec 2023 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=KckcuocL2z013G2jrCsZXwyF7IERThcABs04nHeio4Q=; b=uLGPocLJryyVBdclvJmHRrEnpC
        YndbkH1IgbGIOzzYzSwEKth5SwUHdzaHgzpTN9eMopfPocO6/lTlWXIYz+D0bfuZq8dJQpUBKZzPX
        6wQYf6WjajFJ/LCT01aQ+9ieH2dJMcVNqee+608ZySrxSiUcrdjXtVpRl+pKDvy+qtgrJpGTmVNNp
        wCiqHi9roalMj7f1uoNq82hjk3rFGoa2fUeV8SYMYZXVK4Z+dH6ilGlAGSPRQPAmb65llmza0tRVo
        Si7PliuCEBT29WN0umlmDS9EVfCkY6xv5yYuQHKyrsTCYP0kQAZlfY8uzJEdyMecnP05yrFtBN4gR
        SZyMXzWg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAEOJ-005QO4-3B;
        Mon, 04 Dec 2023 19:14:04 +0000
Message-ID: <694baf13-65d0-4877-b6c7-56e3006f83be@infradead.org>
Date:   Mon, 4 Dec 2023 11:14:03 -0800
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/23 18:19, Baoquan He wrote:
> When dropping select of KEXEC and dependency on ARCH_SUPPORTS_KEXEC
> from CRASH_DUMP, compiling error is reported when below config items are
> set:
> -----------------------
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ......
> -----------------------
> 

[]

> 
> Currently, riscv's ARCH_SUPPORTS_KEXEC has dependency on MMU. Before
> dropping ARCH_SUPPORTS_KEXEC, disabling CONFIG_MMU will unset
> CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE, CONFIG_CRASH_CORE. Hence
> crash_core related codes won't be compiled.
> 
> ---------------------
> arch/riscv/Kconfig:
> config ARCH_SUPPORTS_KEXEC
>         def_bool MMU
> ---------------------
> 
> After dropping ARCH_SUPPORTS_KEXEC, CONFIG_CRASH_DUMP, CONFIG_KEXEC_CORE,
> CONFIG_CRASH_CORE can be set independently of CONFIG_MMU. However, there
> are several macro definitions, such as VA_BITS, VMEMMAP_START, VMEMMAP_END,
> MODULES_VADDR, MODULES_END are only available when CONFIG_MMU=y. Then
> compiling errors are triggered.
> 
> Here, add CONFIG_MMU ifdeffery in arch_crash_save_vmcoreinfo() to export
> those symbols when CONFIG_MMU is enabled.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/riscv/kernel/crash_core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
> index 55f1d7856b54..8706736fd4e2 100644
> --- a/arch/riscv/kernel/crash_core.c
> +++ b/arch/riscv/kernel/crash_core.c
> @@ -5,17 +5,19 @@
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> -	VMCOREINFO_NUMBER(VA_BITS);
>  	VMCOREINFO_NUMBER(phys_ram_base);
>  
>  	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
>  	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>  	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> +#ifdef CONFIG_MMU
> +	VMCOREINFO_NUMBER(VA_BITS);
>  	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>  	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>  #ifdef CONFIG_64BIT
>  	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>  	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
> +#endif
>  #endif
>  	vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
>  	vmcoreinfo_append_str("NUMBER(va_kernel_pa_offset)=0x%lx\n",

Both riscv 32-bit and 64-bit complain:

../arch/riscv/kernel/crash_core.c: In function 'arch_crash_save_vmcoreinfo':
../arch/riscv/kernel/crash_core.c:11:58: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'int' [-Wformat=]
   11 |         vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
      |                                                        ~~^
      |                                                          |
      |                                                          long unsigned int
      |                                                        %x


Otherwise this builds without failure.

Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy
