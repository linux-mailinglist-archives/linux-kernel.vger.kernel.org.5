Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691CD78082A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359030AbjHRJUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359070AbjHRJUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:20:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B1A30E6;
        Fri, 18 Aug 2023 02:20:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B231BD75;
        Fri, 18 Aug 2023 02:20:48 -0700 (PDT)
Received: from bogus (unknown [10.57.34.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D5FA3F762;
        Fri, 18 Aug 2023 02:20:05 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:19:31 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        jiles@qti.qualcomm.com
Subject: Re: [PATCH v2] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230818091931.iqh6bxiifk4wyc32@bogus>
References: <20230807154834.888328-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807154834.888328-1-quic_poza@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:48:34AM -0700, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states, which provide
> an architectural context loss flags field that can be used to describe the
> context that might be lost when an LPI state is entered.
> 
> - Core context Lost
>         - General purpose registers.
>         - Floating point and SIMD registers.
>         - System registers, include the System register based
>         - generic timer for the core.
>         - Debug register in the core power domain.
>         - PMU registers in the core power domain.
>         - Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
> 
> Qualcomm's custom CPUs preserves the architectural state,
> including keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to
> wake the core up without needing broadcast timer.
> 
> The patch fixes the evaluation of cpuidle arch_flags, and moves only to
> broadcast timer if core context lost is defined in ACPI LPI.
> 
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bd68e1b7f29f..5493b044864f 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -9,6 +9,7 @@
>  #ifndef _ASM_ACPI_H
>  #define _ASM_ACPI_H
>  
> +#include <linux/cpuidle.h>
>  #include <linux/efi.h>
>  #include <linux/memblock.h>
>  #include <linux/psci.h>
> @@ -42,6 +43,27 @@
>  #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
>  	spe_interrupt) + sizeof(u16))
>  
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> +
> +#ifndef arch_update_idle_state_flags
> +static __always_inline void arch_update_idle_state_flags(u32 arch_flags,
> +							unsigned int *sflags)
> +{
> +  if (arch_flags & CPUIDLE_CORE_CTXT) {
> +	*sflags |= CPUIDLE_FLAG_TIMER_STOP;
> +  }

I think there are whitespaces issue here for sure. Also you don't need
braces for single statement under if condition.

> +}
> +#define arch_update_idle_state_flags arch_update_idle_state_flags

I prefer to rename the function prepending underscore or something to
distinguish the macro name and function.

> +#endif
> +
> +#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
> +
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 9718d07cc2a2..420baec3465c 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1221,8 +1221,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
>  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency = lpi->wake_latency;
>  		state->target_residency = lpi->min_residency;
> -		if (lpi->arch_flags)
> -			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +		arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
>  		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>  			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>  		state->enter = acpi_idle_lpi_enter;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d584f94409e1..60f17c99465b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1471,6 +1471,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>  
> +#ifndef arch_update_idle_state_flags
> +static __always_inline void arch_update_idle_state_flags(u32 arch_flags,
> +							unsigned int *sflags)
> +{
> +
> +}
> +#define arch_update_idle_state_flags arch_update_idle_state_flags

Can this be simply
#define arch_update_idle_state_flags(..)	do {} while(0)

I don't see the need for both empty function and a macro.

With those fixed, you can add
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
