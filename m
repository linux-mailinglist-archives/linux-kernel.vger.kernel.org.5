Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3783E7F44F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbjKVLfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbjKVLfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:35:06 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89757112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 03:35:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C731595;
        Wed, 22 Nov 2023 03:35:49 -0800 (PST)
Received: from [10.57.82.227] (unknown [10.57.82.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 766B13F7A6;
        Wed, 22 Nov 2023 03:34:59 -0800 (PST)
Message-ID: <8e82e857-dc43-4d06-b72b-17a9f47fedeb@arm.com>
Date:   Wed, 22 Nov 2023 11:34:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: add software prefetches for AmpereOne
Content-Language: en-GB
To:     Huang Shijie <shijie@os.amperecomputing.com>
Cc:     will@kernel.org, mark.rutland@arm.com, suzuki.poulose@arm.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        robh@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
        patches@amperecomputing.com, catalin.marinas@arm.com
References: <20231122092855.4440-1-shijie@os.amperecomputing.com>
 <20231122092855.4440-5-shijie@os.amperecomputing.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231122092855.4440-5-shijie@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-22 9:28 am, Huang Shijie wrote:
> 0) Background:
>     We found that AmpereOne benefits from aggressive prefetches when
>     using 4K page size.
> 
> 1) This patch:
>      1.1) adds new WORKAROUND_AMPERE_AC03_PREFETCH capability.
>      1.2) uses MIDR_AMPERE1 to filter the processor.
>      1.3) uses alternative_if to alternative the code
>           for AmpereOne.
>      1.4) adds software prefetches for the specific loop.
>      	 Also add a macro add_prefetch.
> 
> 2) Test result:
>      In hugetlb or tmpfs, We can get big seqential read performance improvement
>      up to 1.3x ~ 1.4x.

Frankly the copy_template code is pretty terrible anyway, so the fact 
that you're not touching anything *else* (memcpy(), copy_page(), etc.) 
makes me wonder whether you'd benefit from just a better baseline to 
begin with (unless the underlying concern really is something more 
specific like the hardware prefetcher failing to recognise LDTR/STTR). 
The last attempt to improve this derailed into questioning the usercopy 
API semantics themselves, but for reference that would be my original 
patches at [0] (more optimised, but some copy_to_user() fault fixups are 
buggy), and/or Mark's follow-up at [1] (less aggressive but still better 
than the current code, and doesn't touch copy_from_user()).

Thanks,
Robin.


[0] 
https://lore.kernel.org/linux-arm-kernel/cover.1664363162.git.robin.murphy@arm.com/
[1] 
https://lore.kernel.org/linux-arch/20230321122514.1743889-1-mark.rutland@arm.com/

> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> ---
>   arch/arm64/Kconfig.platforms   |  7 +++++++
>   arch/arm64/kernel/cpu_errata.c |  9 +++++++++
>   arch/arm64/lib/copy_template.S | 31 +++++++++++++++++++++++++++++++
>   arch/arm64/tools/cpucaps       |  1 +
>   4 files changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 6069120199bb..74ab8bea0019 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -8,6 +8,13 @@ config ARCH_ACTIONS
>   	help
>   	  This enables support for the Actions Semiconductor S900 SoC family.
>   
> +config ARCH_AMPEREONE
> +	bool "AmpereOne Platforms"
> +	help
> +	  This enables support for the ARMv8 based AmpereOne chipsets.
> +	  AmpereOne is the next generation of Cloud Native Processors from
> +	  Ampere.
> +
>   config ARCH_SUNXI
>   	bool "Allwinner sunxi 64-bit SoC Family"
>   	select ARCH_HAS_RESET_CONTROLLER
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 5706e74c5578..c0060d3086d0 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -744,6 +744,15 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   		.capability = ARM64_WORKAROUND_AMPERE_AC03_CPU_38,
>   		ERRATA_MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>   	},
> +#endif
> +#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
> +	{
> +		.desc = "Optimization for AmpereOne chip",
> +		.capability = ARM64_WORKAROUND_AMPERE_AC03_PREFETCH,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = is_affected_midr_range,
> +		.midr_range = MIDR_ALL_VERSIONS(MIDR_AMPERE1)
> +	},
>   #endif
>   	{
>   	}
> diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
> index 79b32569260c..b707c3ec6820 100644
> --- a/arch/arm64/lib/copy_template.S
> +++ b/arch/arm64/lib/copy_template.S
> @@ -41,6 +41,18 @@
>   	b.ne	.Ltail63
>   .endm
>   
> +#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
> +.macro add_prefetch
> +	/*
> +	 * Add prefetch two cache lines by prfm to optimize the
> +	 * performance. The 2K offset is the best offset which
> +	 * we get from the tests.
> +	 */
> +	prfm	pldl2keep, [src, #2048]
> +	prfm	pldl2keep, [src, #2112]
> +.endm
> +#endif
> +
>   /*
>    * Copy a buffer from src to dest (alignment handled by the hardware)
>    *
> @@ -156,6 +168,13 @@ D_h	.req	x14
>   	b	.Lexitfunc
>   
>   .Lcpy_over64:
> +#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
> +alternative_if  ARM64_WORKAROUND_AMPERE_AC03_PREFETCH
> +	cmp	count, #PAGE_SIZE
> +	b.ge	.Lcpy_over_pagesize
> +alternative_else_nop_endif
> +#endif
> +
>   	subs	count, count, #128
>   	b.ge	.Lcpy_body_large
>   	/*
> @@ -182,4 +201,16 @@ D_h	.req	x14
>   	.p2align	L1_CACHE_SHIFT
>   .Lcpy_body_large:
>   	loop_for_copy_128_bytes
> +
> +#if defined(CONFIG_ARCH_AMPEREONE) && defined(CONFIG_ARM64_4K_PAGES)
> +	b	.Lexitfunc
> +
> +	.p2align        L1_CACHE_SHIFT
> +.Lcpy_over_pagesize:
> +alternative_if  ARM64_WORKAROUND_AMPERE_AC03_PREFETCH
> +	subs	count, count, #128
> +	loop_for_copy_128_bytes add_prefetch
> +alternative_else_nop_endif
> +#endif
> +
>   .Lexitfunc:
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index dea3dc89234b..13e197abf249 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -100,3 +100,4 @@ WORKAROUND_NVIDIA_CARMEL_CNP
>   WORKAROUND_QCOM_FALKOR_E1003
>   WORKAROUND_REPEAT_TLBI
>   WORKAROUND_SPECULATIVE_AT
> +WORKAROUND_AMPERE_AC03_PREFETCH
