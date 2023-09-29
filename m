Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7EC7B364D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjI2PFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjI2PFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:05:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E361B0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:05:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709F0C433C7;
        Fri, 29 Sep 2023 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695999905;
        bh=IvLxKbqu0MJgGbtWdNSigZb9rbYGAOtYXK50iU/aEPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFxxC1pPrNlbYvtFzBpbAcD4+6LoMtcr9+nAuoZy0+t0EpMWsm2UhfDbTbzMORVJO
         3m2gT+1NH4ebANnLQq4MAACqQIeyHRQDazOZJz39dKaEB+RK9BBAwVjx6gG3Ac7eU3
         Qwea7jAO9LOUszza6bK5Pqf3Xz4oK8wNIqmuq2e9PLri8X6xRPufmr0fIYGJzbOc/P
         jKVD2ol3IC6jeYDjJTM93XWeu8LlgEe0c+v6yPg3bG2/G5acJAWmDsdizIfpek2Yyw
         c/Oo8LfAlGwIEvnZAU1seLIkkVL9oqItcqZpOzgUZMl5Lum2DMvjO/f0CErD/f0xV3
         WxR7HHGjB1tkA==
Date:   Fri, 29 Sep 2023 16:04:59 +0100
From:   Will Deacon <will@kernel.org>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     sudeep.holla@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v8] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230929150459.GA30623@willie-the-truck>
References: <20230918172140.2825357-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918172140.2825357-1-quic_poza@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 10:21:40AM -0700, Oza Pawandeep wrote:
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
> Fixes: a36a7fecfe607 ("Add support for Low Power Idle(LPI) states")
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>
> ---
> 
> Notes:
>     Will/Catalin: Rafael has acked and he prefers to take it via arm64 tree
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 4d537d56eb84..269d21209723 100644
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
> @@ -44,6 +45,23 @@
>  
>  #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
>  	trbe_interrupt) + sizeof(u16))
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT		BIT(0) /* Core context Lost */
> +
> +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
> +							unsigned int *sflags)

Why can't this just be 'static inline'?

> +{
> +	if (arch_flags & CPUIDLE_CORE_CTXT)
> +		*sflags |= CPUIDLE_FLAG_TIMER_STOP;
> +}
> +#define arch_update_idle_state_flags _arch_update_idle_state_flags

Usually, the function and the macro have the same name for this pattern,
so I think it would be more consistent to drop the leading underscore
from the C function name.

> +
> +#define CPUIDLE_TRACE_CTXT		BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT		BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT		BIT(3) /* GICD */
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index dc615ef6550a..5c1d13eecdd1 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
>  		strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency = lpi->wake_latency;
>  		state->target_residency = lpi->min_residency;
> -		if (lpi->arch_flags)
> -			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +		arch_update_idle_state_flags(lpi->arch_flags, &state->flags);

Hmm, I know Rafael has Acked this, but I think this is pretending to be
more generic than it really is. While passing in a pointer to the flags
field allows the arch code to set and clear arbitrary flags, we're calling
this before we've set CPUIDLE_FLAG_RCU_IDLE, so that cannot be changed.

Why not just name it like it is and return the arch flags directly:

	state->flags |= arch_get_idle_state_flags(lpi->arch_flags);

?

>  		if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>  			state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>  		state->enter = acpi_idle_lpi_enter;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a73246c3c35e..07a825c76bab 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1480,6 +1480,12 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>  
> +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +#ifndef arch_update_idle_state_flags
> +#define arch_update_idle_state_flags(af, sf)	do {} while (0)

I'd prefer defining this to point at an empty static inline function so
that we get evaluation and type-checking of the arguments.

> +#endif
> +#endif /* CONFIG_ACPI_PROCESSOR_IDLE */

Why do you need the outer CONFIG_ guards here?

Will
