Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E547A0575
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjINNWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbjINNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:22:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD281BEF;
        Thu, 14 Sep 2023 06:21:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479F9C433C8;
        Thu, 14 Sep 2023 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694697716;
        bh=FzlNAs3rImdHO1pAdlHaXIjQ1hufjxExpSnTB4BHtY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdT53XN7rp75UYrl4UjRDK+k6N6DHdGyF4Kn9iog/QWHPhwnTa2HxE3vC6m9QotD1
         deWOexHV3XmrQB1CeMf61oxOky9wqkJ7a2c79anw2bV27je28pgHT4egk82wSWrew6
         F4YXa2AOSFG1iYoh11TIeLdONUNgOn8/f5ywnBOl+hBpg+rB4pD2nlR2j00BZJP9Nq
         pZ3LVr4Q3LZYdMLhXV8OA4EbbazUJU6p77bm5xi2tVQSlJQWq38atrhD+ILkiMlslq
         pftRuW4ekNk/BH5sUVItdiMY+jKYUOjSl1cX7pDzjWjQqf/38TvPT8wU/TUu8zFpow
         5DxsDkisXaeLA==
Date:   Thu, 14 Sep 2023 14:21:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     sudeep.holla@arm.com, catalin.marinas@arm.com, rafael@kernel.org,
        lenb@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast
 timer
Message-ID: <20230914132149.GA13461@willie-the-truck>
References: <20230912172933.3561144-1-quic_poza@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912172933.3561144-1-quic_poza@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:29:33AM -0700, Oza Pawandeep wrote:
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
> index 4d537d56eb84..a30b6e16628d 100644
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
> @@ -44,6 +45,25 @@
>  
>  #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
>  	trbe_interrupt) + sizeof(u16))
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

Why do you need the #ifndef/endif guards here? I'd have thought you'd
_always_ want this definition to be the one used, with the compiler
complaining otherwise.

Will
