Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8717C5D85
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjJKTSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 15:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjJKTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 15:18:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB628F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dHVTyoH1m4OyurqBJf+ec2tvT0YYC2aXTW0LctZa08c=; b=4wWMl1j2vLJsFYoTshFkX7i2az
        fBfYySzA9xjf5O8JlzPkpVnAZ/8Bg8l7UPlfZXwRRdOxHaguOKCUQ/V8apfkNGQc6o3ggjF8TARi2
        JPBwPUbtgrkVJLraX8UF2B7ZiF69VAEv+6koteS5a5cJcXUcNBZFwelLRCFBZxKzZG9965DKv3Caq
        1kewTYXLo0lSTaCO+hH0hHNZ1hfPnacN6hzrbxBdDqWTfhc3LNNDnLPBuWtI0KjaF/dQ9CMX71sI6
        SuXU25RlpXIB7bIG5apm2YfN5qD05vdFYw2rc41gPJ3YQkQp37GcDpW0TsToUtENFG+Zh/SdW94mr
        h1BzvMMw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqeiq-00GXQ0-0x;
        Wed, 11 Oct 2023 19:18:20 +0000
Message-ID: <d7ba2ed2-88b6-417a-a9ea-f0238980a2d6@infradead.org>
Date:   Wed, 11 Oct 2023 12:18:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/msi: Fix compile error caused by GENERIC_MSI_IRQ
 and X86_LOCAL_APIC
Content-Language: en-US
To:     Lu Yao <yaolu@kylinos.cn>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20231008082827.279154-1-yaolu@kylinos.cn>
 <20231011055749.98840-1-yaolu@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231011055749.98840-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 22:57, Lu Yao wrote:
> When compiling the x86 kernel, if X86_LOCAL_APIC is not enabled but
> GENERIC_MSI_IRQ is selected in '.config', the following compilation
> error will occur:
> 
>   include/linux/gpio/driver.h:38:19: error:
>     field 'msiinfo' has incomplete type
> 
>   kernel/irq/msi.c:752:5: error: invalid use of incomplete typedef
>     'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
> 
>   kernel/irq/msi.c:740:1: error: control reaches end of non-void function
> 
> This is because file such as 'kernel/irq/msi.c' only depends on
> 'GENERIC_MSI_IRQ', and uses 'struct msi_alloc_info_t'. However,
> this struct depends on 'X86_LOCAL_APIC'.
> 
> When enable 'GENERIC_MSI_IRQ' or 'X86_LOCAL_APIC' will select
> 'IRQ_DOMAIN_HIERARCHY', so exposing this struct using
> 'IRQ_DOMAIN_HIERARCHY' rather than 'X86_LOCAL_APIC'.
> 
> Under the above conditions, if 'HPET_TIMER' is selected, the following
> compilation error will occur:
> 
>   arch/x86/kernel/hpet.c:550:13: error: ‘x86_vector_domain’ undeclared
> 
>   arch/x86/kernel/hpet.c:600:9: error: implicit declaration of
>     function ‘init_irq_alloc_info’
> 
> This is because 'x86_vector_domain' is defined in 'kernel/apic/vector.c'
> which is compiled only when 'X86_LOCAL_APIC' is enabled. So use
> 'X86_LOCAL_APIC' to expose these code rather than 'GENERIC_MSI_IRQ'.
> 
> Signed-off-by: Lu Yao <yaolu@kylinos.cn>


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> Change from v1:
>  * Fix arch/x86/kernel/hpet.c compiled error
> Thanks to Randy for the feedback.
> v1: https://lore.kernel.org/lkml/20231008082827.279154-1-yaolu@kylinos.cn/
> 
> ---
>  arch/x86/include/asm/hw_irq.h | 6 +++---
>  arch/x86/kernel/hpet.c        | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
> index 551829884734..b02c3cd3c0f6 100644
> --- a/arch/x86/include/asm/hw_irq.h
> +++ b/arch/x86/include/asm/hw_irq.h
> @@ -28,7 +28,7 @@
>  #include <asm/irq.h>
>  #include <asm/sections.h>
>  
> -#ifdef	CONFIG_X86_LOCAL_APIC
> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
>  struct irq_data;
>  struct pci_dev;
>  struct msi_desc;
> @@ -105,10 +105,10 @@ static inline void irq_complete_move(struct irq_cfg *c) { }
>  #endif
>  
>  extern void apic_ack_edge(struct irq_data *data);
> -#else	/*  CONFIG_X86_LOCAL_APIC */
> +#else	/*  CONFIG_IRQ_DOMAIN_HIERARCHY */
>  static inline void lock_vector_lock(void) {}
>  static inline void unlock_vector_lock(void) {}
> -#endif	/* CONFIG_X86_LOCAL_APIC */
> +#endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>  
>  /* Statistics */
>  extern atomic_t irq_err_count;
> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> index 1648aa0204d9..9904c0d46eba 100644
> --- a/arch/x86/kernel/hpet.c
> +++ b/arch/x86/kernel/hpet.c
> @@ -52,7 +52,7 @@ unsigned long				hpet_address;
>  u8					hpet_blockid; /* OS timer block num */
>  bool					hpet_msi_disable;
>  
> -#ifdef CONFIG_GENERIC_MSI_IRQ
> +#ifdef CONFIG_X86_LOCAL_APIC
>  static DEFINE_PER_CPU(struct hpet_channel *, cpu_hpet_channel);
>  static struct irq_domain		*hpet_domain;
>  #endif
> @@ -469,7 +469,7 @@ static void __init hpet_legacy_clockevent_register(struct hpet_channel *hc)
>  /*
>   * HPET MSI Support
>   */
> -#ifdef CONFIG_GENERIC_MSI_IRQ
> +#ifdef CONFIG_X86_LOCAL_APIC
>  static void hpet_msi_unmask(struct irq_data *data)
>  {
>  	struct hpet_channel *hc = irq_data_get_irq_handler_data(data);

-- 
~Randy
