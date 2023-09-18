Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA47A4784
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbjIRKrd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 06:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbjIRKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:47:09 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EE9B6;
        Mon, 18 Sep 2023 03:47:04 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-573128cd77dso586292eaf.0;
        Mon, 18 Sep 2023 03:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034023; x=1695638823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLR2rl0tJf4TvoCKE2Und3t7JkpsVQnKUyFiNGKDeXU=;
        b=KrVeQBohPWV1FrMOftNvmZySK5EKF3IGfenMSrq+54mN4ZbFhvzaIlnMtrsw5fduXf
         a+aPfyeIsr6AaCzmG7t/OTqJshQToAahbOUelqWEoWvYe3PCUfWQCjCqxGh8MxGoGAjG
         n4eSnaLtEFP6w09ILpDLPDRgLN9tG3SN9fvBY7ijLJurbD9rOoZIPB7r2+aChGW3uNYq
         NuwAu9D1AeoLadRDhcNJfaRi+9yu+LOdgQJl13oeKy/leghuFjCJoNK7okydmVr56JUo
         rTG2q3MxHZI8iBkL8jIoJ7EuznAAx3e29wrenGNSQIuC2tgQoNAa6KXLRVS3kRbH4Glo
         VGYQ==
X-Gm-Message-State: AOJu0YwELEWeK1AvnPaE9tSMgqhPfpYypx3KfcK0Ab1XixH71VIuUdfL
        nc3Dw2hnad2MPGH3+NmWD44Qm0409tubD7/9Jag=
X-Google-Smtp-Source: AGHT+IH32KNlt0aehU1kUyg6pQve4X57p60IvGk8JgWlQoxXocjrsbvQ83pxb4qEfaAqIcLuuLK+zOlQC/gpPSro0sE=
X-Received: by 2002:a4a:de83:0:b0:56e:94ed:c098 with SMTP id
 v3-20020a4ade83000000b0056e94edc098mr7737511oou.0.1695034023204; Mon, 18 Sep
 2023 03:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230915202511.1452091-1-quic_poza@quicinc.com>
In-Reply-To: <20230915202511.1452091-1-quic_poza@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 12:46:52 +0200
Message-ID: <CAJZ5v0h8bD-Cuk+wXiS3F4jm5GdH7yX4jgEqE3-9ho7A27HWzw@mail.gmail.com>
Subject: Re: [PATCH v7] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:25 PM Oza Pawandeep <quic_poza@quicinc.com> wrote:
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

I think that I've already ACKed it and I said that I would prefer it
to be routed via ARM64, because it essentially is all about ARM64.

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
>         trbe_interrupt) + sizeof(u16))
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT              BIT(0) /* Core context Lost */
> +
> +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
> +                                                       unsigned int *sflags)
> +{
> +       if (arch_flags & CPUIDLE_CORE_CTXT)
> +               *sflags |= CPUIDLE_FLAG_TIMER_STOP;
> +}
> +#define arch_update_idle_state_flags _arch_update_idle_state_flags
> +
> +#define CPUIDLE_TRACE_CTXT             BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT              BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT              BIT(3) /* GICD */
>
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index dc615ef6550a..5c1d13eecdd1 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1217,8 +1217,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
>                 strscpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>                 state->exit_latency = lpi->wake_latency;
>                 state->target_residency = lpi->min_residency;
> -               if (lpi->arch_flags)
> -                       state->flags |= CPUIDLE_FLAG_TIMER_STOP;
> +               arch_update_idle_state_flags(lpi->arch_flags, &state->flags);
>                 if (i != 0 && lpi->entry_method == ACPI_CSTATE_FFH)
>                         state->flags |= CPUIDLE_FLAG_RCU_IDLE;
>                 state->enter = acpi_idle_lpi_enter;
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
> +#define arch_update_idle_state_flags(af, sf)   do {} while (0)
> +#endif
> +#endif /* CONFIG_ACPI_PROCESSOR_IDLE */
> +
>  #ifdef CONFIG_ACPI_PPTT
>  int acpi_pptt_cpu_is_thread(unsigned int cpu);
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
> --
> 2.25.1
>
