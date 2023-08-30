Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D378DB35
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjH3Sio convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Aug 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbjH3QUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:20:55 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D689D2;
        Wed, 30 Aug 2023 09:20:53 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bc9353be9bso1443483a34.1;
        Wed, 30 Aug 2023 09:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693412452; x=1694017252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeS9OdEd68YpyalTdlPZMygmVCYg7KL4ZpDyn/xRe/4=;
        b=WoekO6vnwNoSIo6QNnKfk2wvZOPC+eVHQ8AoN7YLfbD6na4Go2C/uUXBn6USkCRVUm
         FrC5WAPq7X/2B5PWgZH4h2LOyUFyYmuHVK+TBDf4ar6ImjHxIpM9BQ+75WGwR87qXzV2
         JlZXpY2wLlkHmSMqoMKVnv+sEbUddeu0p+GIZNpzXRpSXkreyGsv1tXl4Hn78vYd9Ssu
         EUMxyOXCmhH2KQXydpl1prcjnLErzRW+rgsu4EsoaB2TKqmuupJ5Afv1rm0ADu9sl4kD
         siBtIFnfc+f82Op8BvInsKebB0/B1KafKEVueftMSsxTCZYWU1gmVhke2ye0NJWPDUvE
         zluQ==
X-Gm-Message-State: AOJu0YweeBiGltrcZELXlQPq63TZszfDKv+7vmXTlcJacWY27O6vMDKg
        hfXHVE4tjsHp870zR75Rzg0Ljaxoy+mUkEAzh+w=
X-Google-Smtp-Source: AGHT+IH7TEnfirEhx1gwGguuo2Dzd1et6vj1TBhatbD8UHOw6mPS4F5+8/4Z5y4aVW7DqlbyShcDP4i3A6P7NkHJkKQ=
X-Received: by 2002:a4a:de8f:0:b0:573:55af:777c with SMTP id
 v15-20020a4ade8f000000b0057355af777cmr2802339oou.0.1693412452678; Wed, 30 Aug
 2023 09:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230830161539.3864065-1-quic_poza@quicinc.com>
In-Reply-To: <20230830161539.3864065-1-quic_poza@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Aug 2023 18:20:41 +0200
Message-ID: <CAJZ5v0hurpTXp_x3rGjuZX4KMmoU3Gf9Jb9Zf+anjs__tpcw4w@mail.gmail.com>
Subject: Re: [PATCH v4] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
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

On Wed, Aug 30, 2023 at 6:15 PM Oza Pawandeep <quic_poza@quicinc.com> wrote:
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
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Oza Pawandeep <quic_poza@quicinc.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI core changes in this patch and I would prefer it to go in
via ARM64.

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
>         spe_interrupt) + sizeof(u16))
>
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT              BIT(0) /* Core context Lost */
> +
> +#ifndef arch_update_idle_state_flags
> +static __always_inline void _arch_update_idle_state_flags(u32 arch_flags,
> +                                                       unsigned int *sflags)
> +{
> +       if (arch_flags & CPUIDLE_CORE_CTXT)
> +               *sflags |= CPUIDLE_FLAG_TIMER_STOP;
> +}
> +#define arch_update_idle_state_flags _arch_update_idle_state_flags
> +#endif
> +
> +#define CPUIDLE_TRACE_CTXT             BIT(1) /* Trace context loss */
> +#define CPUIDLE_GICR_CTXT              BIT(2) /* GICR */
> +#define CPUIDLE_GICD_CTXT              BIT(3) /* GICD */
> +
>  /* Basic configuration for ACPI */
>  #ifdef CONFIG_ACPI
>  pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 9718d07cc2a2..420baec3465c 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1221,8 +1221,7 @@ static int acpi_processor_setup_lpi_states(struct acpi_processor *pr)
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
> index d584f94409e1..c320b474ed56 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1471,6 +1471,10 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>
> +#ifndef arch_update_idle_state_flags
> +#define arch_update_idle_state_flags(af, sf)   do {} while (0)
> +#endif
> +
>  #ifdef CONFIG_ACPI_PPTT
>  int acpi_pptt_cpu_is_thread(unsigned int cpu);
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
> --
