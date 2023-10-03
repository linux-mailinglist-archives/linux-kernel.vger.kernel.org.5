Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4897B6EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjJCQmh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 12:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjJCQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:42:35 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D8A1;
        Tue,  3 Oct 2023 09:42:32 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57bc11c197aso214266eaf.1;
        Tue, 03 Oct 2023 09:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351351; x=1696956151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKkyLIKRBwrttuTaw6tyidCw5flAmDkNCTeVl+fA7Zo=;
        b=EkItlwFabZqZQRzDUQSsYwR43wJuej6mheASb6w3DPst9usVYmna6KgeIaKJ0oM3Lj
         +/SdItnLCIrSlBR0PKiBxDhJAsjt854SAxqrQhYpoAO/LtOgbA+fePltlG7T8pBJCWpm
         bQdafsw6xCkQj9lPn15+2oYUD8LBv9gtniMnsKHz7NvfOV1KAjOw8EWZw6KVWbxzFBT0
         enuIYMCLVTnvT7kLetK7nOoEWHFflgI/UD7fhh7YsX61KK8ii7zG4C6bIIHLUQmg98uZ
         G35/n4eZRLAnqrRtcm7kCsSqbiWIajN7F4fwTpZGSGHGTLaa7GQOcFNk84qW3Ljd0/ZD
         U07w==
X-Gm-Message-State: AOJu0Ywl2i31Y0ZbC68zSReIGNywqD/zbJnMwMN2P+1i8U/q+RwuEzOO
        OWiooBokqAlIpBEilFp66u9xv1Kxv2934wYqRhg=
X-Google-Smtp-Source: AGHT+IHY2EvHqGgrssqorvgKH7eDJDVuZNaPkKMUvAD330Zdkl817tvj+ypXQ7WOUlePA7z8vnChoeHK9/c/VAIxNhA=
X-Received: by 2002:a05:6820:629:b0:57b:7e31:c12 with SMTP id
 e41-20020a056820062900b0057b7e310c12mr16614288oow.1.1696351351271; Tue, 03
 Oct 2023 09:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231003155930.2829763-1-quic_poza@quicinc.com>
In-Reply-To: <20231003155930.2829763-1-quic_poza@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 18:42:20 +0200
Message-ID: <CAJZ5v0j+KkyDFQMrPt3coBdZjXJE8-sKFBKzvKMp31MhT0z7=Q@mail.gmail.com>
Subject: Re: [PATCH v9] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 5:59 PM Oza Pawandeep <quic_poza@quicinc.com> wrote:
>
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
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>

For the general ACPI changes:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>
> Notes:
>     Will/Catalin: Rafael has acked and he prefers to take it via arm64 tree
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 4d537d56eb84..6792a1f83f2a 100644
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
> @@ -44,6 +45,24 @@
>
>  #define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
>         trbe_interrupt) + sizeof(u16))
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT              BIT(0) /* Core context Lost */
> +
> +static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
> +{
> +       if (arch_flags & CPUIDLE_CORE_CTXT)
> +               return CPUIDLE_FLAG_TIMER_STOP;
> +
> +       return 0;
> +}
> +#define arch_get_idle_state_flags arch_get_idle_state_flags
> +
> +#define CPUIDLE_TRACE_CTXT             BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT              BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT              BIT(3) /* GICD */
>
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index dc615ef6550a..3a34a8c425fe 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
>                 strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>                 state->exit_latency = lpi->wake_latency;
>                 state->target_residency = lpi->min_residency;
> -               if (lpi->arch_flags)
> -                       state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +               state->flags |= arch_get_idle_state_flags(lpi->arch_flags);
>                 if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>                         state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>                 state->enter = acpi_idle_lpi_enter;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a73246c3c35e..afd94c9b8b8a 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1480,6 +1480,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>
> +#ifdef CONFIG_ACPI_PROCESSOR_IDLE
> +#ifndef arch_get_idle_state_flags
> +static inline unsigned int arch_get_idle_state_flags(u32 arch_flags)
> +{
> +       return 0;
> +}
> +#endif
> +#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
> +
>  #ifdef CONFIG_ACPI_PPTT
>  int acpi_pptt_cpu_is_thread(unsigned int cpu);
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
> --
> 2.25.1
>
