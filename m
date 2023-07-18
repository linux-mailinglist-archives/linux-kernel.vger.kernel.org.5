Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE67C757DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjGRNcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjGRNcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:32:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7480397;
        Tue, 18 Jul 2023 06:32:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA7432F4;
        Tue, 18 Jul 2023 06:32:48 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62063F6C4;
        Tue, 18 Jul 2023 06:32:03 -0700 (PDT)
Date:   Tue, 18 Jul 2023 14:32:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, jiles@qti.qualcomm.com
Subject: Re: [PATCH] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230718133201.qsulwupte6l6bmdm@bogus>
References: <20230712172458.2507434-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712172458.2507434-1-quic_poza@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:24:58AM -0700, Oza Pawandeep wrote:
> Arm® Functional Fixed Hardware Specification defines LPI states,
> which provides an architectural context loss flags field
> that can be used to describe the context that might be lost
> when an LPI state is entered.
> 
> - Core context Lost
> 	- General purpose registers.
> 	- Floating point and SIMD registers.
> 	- System registers, include the System register based
> 	- generic timer for the core.
> 	- Debug register in the core power domain.
> 	- PMU registers in the core power domain.
> 	- Trace register in the core power domain.
> - Trace context loss
> - GICR
> - GICD
> 
> Qualcomm's custom CPUs preserves the architectural state,
> including keeping the power domain for local timers active.
> when core is power gated, the local timers are sufficient to
> wake the core up without needing broadcast timer.
> 
> The patch fixes the evaluation of cpuidle arch_flags,
> and moves only to broadcast timer if core context lost
> is defined in ACPI LPI.
> 
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index bd68e1b7f29f..9c335968316c 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -42,6 +42,24 @@
>  #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
>  	spe_interrupt) + sizeof(u16))
>  
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> +
> +#ifndef arch_acpi_lpi_timer_stopped
> +static __always_inline bool arch_acpi_lpi_timer_stopped(u32 arch_flags)

As mentioned by you above, the core context is not just timer context, so
calling this function so is misleading.

> +{
> +  return arch_flags & CPUIDLE_CORE_CTXT;
> +}
> +#define arch_acpi_lpi_timer_stopped arch_acpi_lpi_timer_stopped
> +#endif
> +
> +#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
> +

Do we really need to define these unused bitfields ? DO you have plans to
use them ?

>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 9718d07cc2a2..8ea1f2b3bf96 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1221,7 +1221,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
>  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency = lpi->wake_latency;
>  		state->target_residency = lpi->min_residency;
> -		if (lpi->arch_flags)
> +		if (arch_acpi_lpi_timer_stopped(lpi->arch_flags))

While setting CPUIDLE_FLAG_TIMER_STOP if any flags set is already
questionable, checking for arch specific flag in the generic code is even
more questionable now. I wonder if it makes more sense to have a arch
specific helper to update the state->flags based on how arch specific
interpretation of lpi->arch_flags ?

>  			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>  		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>  			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d584f94409e1..b24f1cd1cebb 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1471,6 +1471,14 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>  
> +#ifndef arch_acpi_lpi_timer_stopped
> +static __always_inline bool arch_acpi_lpi_timer_stopped(u32 arch_flags)
> +{
> +  return (arch_flags != 0);
> +}
> +#define arch_acpi_lpi_timer_stopped arch_acpi_lpi_timer_stopped
> +#endif
> +

This looks ugly and main reason for my above comment. I am thinking of
arch_update_idle_state_flags(lpi->arch_flags, &state->flags) and make
it do nothing on non arm platforms. I don't think we will be breaking
anything(i.e. no need to check arch_flags != 0. It is incorrect strictly
speaking but there are no non-arm users ATM, but that doesn't mean we can
trickle the arch specific LPI FFH details into the generic code.

-- 
Regards,
Sudeep
