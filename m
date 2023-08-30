Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B1378DD4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbjH3Ssu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbjH3Kwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:52:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 26D1A1BE;
        Wed, 30 Aug 2023 03:52:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12BDB2F4;
        Wed, 30 Aug 2023 03:53:12 -0700 (PDT)
Received: from bogus (unknown [10.57.36.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AF933F64C;
        Wed, 30 Aug 2023 03:52:31 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:51:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230830105134.dskqqq55npsclibq@bogus>
References: <20230829201101.3330337-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230829201101.3330337-1-quic_poza@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 01:11:01PM -0700, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states,
> which provide an architectural context loss flags field that can
> be used to describe the context that might be lost when an LPI
> state is entered.
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
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bd68e1b7f29f..0d455b02971e 100644
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
> @@ -42,6 +43,26 @@
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
> +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
> +							unsigned int *sflags)
> +{
> +	if (arch_flags & CPUIDLE_CORE_CTXT)
> +		*sflags |= CPUIDLE_FLAG_TIMER_STOP;
> +}
> +#define arch_update_idle_state_flags _arch_update_idle_state_flags
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
> index d584f94409e1..d49488fdbc49 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1471,6 +1471,10 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>  
> +#ifndef arch_update_idle_state_flags
> +#define arch_update_idle_state_flags	do {} while (0);

I think I suggested it in v2 as without that you will get the warnings the
kernel build bot has posted now.

#define arch_update_idle_state_flags(af, sf)	do {} while (0)

Add the parameters and drop the leading ';'.

-- 
Regards,
Sudeep
