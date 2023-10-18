Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5C7CDC88
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjJRNCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 09:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjJRNCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:02:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72C6CA3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 06:02:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DCA12F4;
        Wed, 18 Oct 2023 06:03:12 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.31.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B493F762;
        Wed, 18 Oct 2023 06:02:30 -0700 (PDT)
Date:   Wed, 18 Oct 2023 14:02:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea della Porta <andrea.porta@suse.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nik.borisov@suse.com
Subject: Re: [PATCH 4/4] arm64: Make Aarch32 emulation boot time configurable
Message-ID: <ZS_XYwHovY6B7Whp@FVFF77S0Q05N.cambridge.arm.com>
References: <cover.1697614386.git.andrea.porta@suse.com>
 <1029761eb218702d4aafa58d83c4bf9d3a760264.1697614386.git.andrea.porta@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1029761eb218702d4aafa58d83c4bf9d3a760264.1697614386.git.andrea.porta@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 01:13:22PM +0200, Andrea della Porta wrote:
> Distributions would like to reduce their attack surface as much as
> possible but at the same time they'd want to retain flexibility to
> cater to a variety of legacy software. This stems from the conjecture
> that compat layer is likely rarely tested and could have latent
> security bugs. Ideally distributions will set their default policy
> and also give users the ability to override it as appropriate.
> 
> To enable this use case, introduce CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED
> compile time option, which controls whether 32bit processes/syscalls
> should be allowed or not. This option is aimed mainly at distributions
> to set their preferred default behavior in their kernels.
> 
> To allow users to override the distro's policy, introduce the
> 'aarch32_emulation' parameter which allows overriding
> CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED state at boot time.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  arch/arm64/Kconfig                              | 9 +++++++++
>  arch/arm64/kernel/entry-common.c                | 8 +++++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 0a1731a0f0ef..a41c5e6f5d2e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1,3 +1,10 @@
> +	aarch32_emulation=	[ARM64]
> +			Format: <bool>
> +			When true, allows loading 32-bit programs and executing
> +			32-bit syscalls, essentially overriding
> +			AARCH32_EMULATION_DEFAULT_DISABLED at boot time. when false,
> +			unconditionally disables AARCH32 emulation.

Can we please drop the 'emulation' part of the name? We don't use that
terminology on arm64 for regular execution of compat tasks, and only use that
to refer to true emulation of deprecated instructions.

We already have the 'allow_mismatched_32bit_el0' option; can we please us a
name that aligns with that? e.g. 'allow_32bit_el0=false' to disable support.

Mark.

> +
>  	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
>  			Advanced Configuration and Power Interface
>  			Format: { force | on | off | strict | noirq | rsdt |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b10515c0200b..66c4cb273550 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1725,6 +1725,15 @@ config SETEND_EMULATION
>  	  If unsure, say Y
>  endif # ARMV8_DEPRECATED
>  
> +config AARCH32_EMULATION_DEFAULT_DISABLED
> +	bool "Aarch32 emulation disabled by default"
> +	default n
> +	depends on COMPAT
> +	help
> +	  Make Aarch32 emulation disabled by default. This prevents loading 32-bit
> +	  processes and access to 32-bit syscalls.
> +
> +	  If unsure, leave it to its default value.
>  endif # COMPAT
>  
>  menu "ARMv8.1 architectural features"
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 32761760d9dd..07f2b4e632b8 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -897,7 +897,13 @@ asmlinkage void noinstr el0t_32_error_handler(struct pt_regs *regs)
>  		__el0_error_handler_common(regs);
>  }
>  
> -bool __aarch32_enabled __ro_after_init = true;
> +bool __aarch32_enabled __ro_after_init = !IS_ENABLED(CONFIG_AARCH32_EMULATION_DEFAULT_DISABLED);
> +
> +static int aarch32_emulation_override_cmdline(char *arg)
> +{
> +	return kstrtobool(arg, &__aarch32_enabled);
> +}
> +early_param("aarch32_emulation", aarch32_emulation_override_cmdline);
>  #else /* CONFIG_COMPAT */
>  UNHANDLED(el0t, 32, sync)
>  UNHANDLED(el0t, 32, irq)
> -- 
> 2.35.3
> 
