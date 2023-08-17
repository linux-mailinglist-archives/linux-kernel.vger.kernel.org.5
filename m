Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C454B77FD36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354094AbjHQRtk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354118AbjHQRtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:49:21 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48999FD;
        Thu, 17 Aug 2023 10:49:20 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-56d67c5e87cso16958eaf.0;
        Thu, 17 Aug 2023 10:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294559; x=1692899359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3kJKBjM8HeUH9yQyk9NqrnEPzqgaX/ykR5hFJ5dGi8=;
        b=eYaudM3LeYeTw6tWb8Q/36A3har7HQ9RReySYEZ4DninScxJucsxBJ8xwzZPqJHTMj
         LULpKkvVQLlAM12sEj0PCmdSjGgZNA2GpBDEt+f2mo4Vd9XIAgPgmo/SCmJv1/Cf0Qce
         01WhEjq5mA6dyo48b1Si7jjnmD8CcXy+pF9RA6IGhDdhrpGz6IINjlowU9zE3V+McSTG
         BymyemvviHIH0Tg8m8Q7CGvE0U5gpOkmRhfjsthJBXfwio8pxOvLE8SIlYVf4W4Z+b1t
         LsNIBdAhM3gymFWa8i9N90/tDCFF4VhBpA3czMKRpHP6Gq8IWxc96D7zj9tyDJW9OzyC
         9GxA==
X-Gm-Message-State: AOJu0Yw92kAZoCJ6OyN7hzY523ARN0UPOfEGoTQ4BAEFt74gO+XEX2Pz
        mmVBSj2sl1v0qy6J2o+2TAa6xdpHCVbEMo79f0A=
X-Google-Smtp-Source: AGHT+IHQAj18DF5FMKJCfqRgpf97T7Vbzi6PVutl3QcQI8lJuQ6AEmA6vxmsO8gwukYaA8PvCYSRlWNSVlkkXyYCgKI=
X-Received: by 2002:a4a:d581:0:b0:56e:487f:8caa with SMTP id
 z1-20020a4ad581000000b0056e487f8caamr455288oos.1.1692294558381; Thu, 17 Aug
 2023 10:49:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230807154834.888328-1-quic_poza@quicinc.com>
In-Reply-To: <20230807154834.888328-1-quic_poza@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:49:07 +0200
Message-ID: <CAJZ5v0h_m_kzJfatUeDxwhECHJQH0H7S37aqBQannDFj2ptKEw@mail.gmail.com>
Subject: Re: [PATCH v2] cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer
To:     Oza Pawandeep <quic_poza@quicinc.com>
Cc:     sudeep.holla@arm.com, catalin.marinas@arm.com, will@kernel.org,
        rafael@kernel.org, lenb@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, jiles@qti.qualcomm.com
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

On Mon, Aug 7, 2023 at 5:48 PM Oza Pawandeep <quic_poza@quicinc.com> wrote:
>
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
>         spe_interrupt) + sizeof(u16))
>
> +/*
> + * Arm® Functional Fixed Hardware Specification Version 1.2.
> + * Table 2: Arm Architecture context loss flags
> + */
> +#define CPUIDLE_CORE_CTXT              BIT(0) /* Core context Lost */
> +
> +#ifndef arch_update_idle_state_flags
> +static __always_inline void arch_update_idle_state_flags(u32 arch_flags,
> +                                                       unsigned int *sflags)
> +{
> +  if (arch_flags & CPUIDLE_CORE_CTXT) {
> +       *sflags |= CPUIDLE_FLAG_TIMER_STOP;
> +  }
> +}
> +#define arch_update_idle_state_flags arch_update_idle_state_flags
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
> index d584f94409e1..60f17c99465b 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1471,6 +1471,15 @@ static inline int lpit_read_residency_count_address(u64 *address)
>  }
>  #endif
>
> +#ifndef arch_update_idle_state_flags
> +static __always_inline void arch_update_idle_state_flags(u32 arch_flags,
> +                                                       unsigned int *sflags)
> +{
> +
> +}
> +#define arch_update_idle_state_flags arch_update_idle_state_flags
> +#endif
> +
>  #ifdef CONFIG_ACPI_PPTT
>  int acpi_pptt_cpu_is_thread(unsigned int cpu);
>  int find_acpi_cpu_topology(unsigned int cpu, int level);
> --

If I'm to apply this, an ACK from the ARM people is requisite.

Thanks!
