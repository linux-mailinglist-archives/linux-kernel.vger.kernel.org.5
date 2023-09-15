Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BB7A1516
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbjIOFEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjIOFE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:04:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E1E4273A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:03:34 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id EA380212BE69; Thu, 14 Sep 2023 22:03:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA380212BE69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694754213;
        bh=v7KFZXd51V9ndVZorLelXyjbgQ74bOjbTon9qIAaES4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=m3gYhw8JXvIBrtSYX8onzg71AFcX2fX4GOewQWjPqhvoCtkk3R0UKmZZV+A9Zc+KA
         6DM2nAHh9VVcmijfhjTPsXZlery8j4xs2uknsXuoZWbD2+ap944LPFzFYJBJY5E5lS
         6yR97KDevw0FNTzrIX/1xs9J1ejUmJxayFwcPOYc=
Date:   Thu, 14 Sep 2023 22:03:33 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, mikelley@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/of: split x86_dtb_init for early
 x86_flattree_get_config call
Message-ID: <20230915050333.GA4911@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692949657-16446-1-git-send-email-ssengar@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 12:47:36AM -0700, Saurabh Sengar wrote:
> Fetching the device tree configuration before initmem_init is necessary
> to allow the parsing of NUMA node information. However moving entire
> x86_dtb_init before initmem_init is not correct as APIC/IO-APIC enumeration
> has to be after initmem_init. Thus, split the x86_dtb_init function to
> incorporate a call to x86_flattree_get_config before initmem_init, and
> leaving the ACPI/IOAPIC registration sequence as is.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
>  - split the x86_dtb_init to call x86_flattree_get_config early
> 
>  arch/x86/include/asm/prom.h  | 5 +++++
>  arch/x86/kernel/devicetree.c | 6 +-----
>  arch/x86/kernel/setup.c      | 2 ++
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
> index b716d291d0d4..65dee2420624 100644
> --- a/arch/x86/include/asm/prom.h
> +++ b/arch/x86/include/asm/prom.h
> @@ -31,6 +31,11 @@ static inline void x86_dtb_init(void) { }
>  #define of_ioapic 0
>  #endif
>  
> +#ifdef CONFIG_OF_EARLY_FLATTREE
> +void x86_flattree_get_config(void);
> +#else
> +static inline void x86_flattree_get_config(void) { }
> +#endif
>  extern char cmd_line[COMMAND_LINE_SIZE];
>  
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 87d38f17ff5c..afd09924094e 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -278,7 +278,7 @@ static void __init dtb_apic_setup(void)
>  }
>  
>  #ifdef CONFIG_OF_EARLY_FLATTREE
> -static void __init x86_flattree_get_config(void)
> +void __init x86_flattree_get_config(void)
>  {
>  	u32 size, map_len;
>  	void *dt;
> @@ -300,14 +300,10 @@ static void __init x86_flattree_get_config(void)
>  	unflatten_and_copy_device_tree();
>  	early_memunmap(dt, map_len);
>  }
> -#else
> -static inline void x86_flattree_get_config(void) { }
>  #endif
>  
>  void __init x86_dtb_init(void)
>  {
> -	x86_flattree_get_config();
> -
>  	if (!of_have_populated_dt())
>  		return;
>  
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index b9145a63da77..ef73704fa27f 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1221,6 +1221,8 @@ void __init setup_arch(char **cmdline_p)
>  
>  	early_acpi_boot_init();
>  
> +	x86_flattree_get_config();
> +
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>  
> -- 
> 2.34.1

Kind reminder to review this patch series.

- Saurabh
