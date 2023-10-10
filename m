Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DC87C00F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjJJP7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjJJP7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:59:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A951B6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=rJgL4rw3kxKAK5R0je1XMzNfxr6vfwIpg8Oe5KINLE8=; b=Noyw/Q4vI5v1GiqTOZn1BAisZR
        NRCXGcpJpWD+a6LVCB95S0GjpZZODyf89BU7s/+Q2xsd2TTh2gPCK+1wtRy2auKmJSmiVWHuNMg0G
        J9/qZPD8Ds/M/6b0aZX8BMsi+U3OU5Ck6VQmM1P8nJfnMmb8nz7PcwguKUstHaZB35O1VXZsjEGQl
        1k2ndiImIc5Xj5mVPpfRTY3ib/6Rt65ENJN3xg2NPWkIpanW9m7k4y4+GX3sXQYBFp4NxbrPevyFS
        qgql5rOJiRKT1bseRlVJbX1KT0ljmchDwfk6TQ5yCF/OnTwtRFcTSGuMbhzagWSaAp37NC/BY2Vn/
        pJeoD1og==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqF8d-00DjRJ-0x;
        Tue, 10 Oct 2023 15:59:15 +0000
Message-ID: <6b5e3bd0-8002-49b0-ae23-f091f9b465b5@infradead.org>
Date:   Tue, 10 Oct 2023 08:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/msi: Fix compile error "incomplete typedef
 'msi_alloc_info_t'"
Content-Language: en-US
To:     yaolu <yaolu@kylinos.cn>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20231008082827.279154-1-yaolu@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231008082827.279154-1-yaolu@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/8/23 01:28, yaolu wrote:
> When compiling the x86 kernel, if X86_64 || SMP || X86_32_NON_STANDARD ||
> X86_UP_APIC || PCI_MSI is not enabled in '.config' and GENERIC_MSI_IRQ is
> selected, the following compilation error will occur:
> 
>> include/linux/gpio/driver.h:38:19: error:
>>   field 'msiinfo' has incomplete type
>> kernel/irq/msi.c:752:5: error: invalid use of incomplete typedef
>>   'msi_alloc_info_t' {aka 'struct irq_alloc_info'}
>> kernel/irq/msi.c:740:1: error: control reaches end of non-void function
> 
> This is because 'X86_LOCAL_APIC' is not defined, but file such as
> 'kernel/irq/msi.c' only depends on 'GENERIC_MSI_IRQ', and uses
> 'struct msi_alloc_info_t'. When enable 'GENERIC_MSI_IRQ' will select
> 'IRQ_DOMAIN_HIERARCHY', so exposing this struct using
> 'IRQ_DOMAIN_HIERARCHY' rather than 'X86_LOCAL_APIC'.
> 
> Signed-off-by: yaolu <yaolu@kylinos.cn>

Thank for the patch. This reduces the build error count from around 190 down to
two remaining problems for me:

../arch/x86/kernel/hpet.c: In function ‘hpet_create_irq_domain’:
../arch/x86/kernel/hpet.c:550:13: error: ‘x86_vector_domain’ undeclared (first use in this function)
  550 |         if (x86_vector_domain == NULL)
      |             ^~~~~~~~~~~~~~~~~
../arch/x86/kernel/hpet.c:550:13: note: each undeclared identifier is reported only once for each function it appears in
../arch/x86/kernel/hpet.c: In function ‘hpet_assign_irq’:
../arch/x86/kernel/hpet.c:600:9: error: implicit declaration of function ‘init_irq_alloc_info’ [-Werror=implicit-function-declaration]
  600 |         init_irq_alloc_info(&info, NULL);
      |         ^~~~~~~~~~~~~~~~~~~


I haven't looked into how to fix this yet...

> ---
>  arch/x86/include/asm/hw_irq.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
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

-- 
~Randy
