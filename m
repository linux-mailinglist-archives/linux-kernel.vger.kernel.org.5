Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B777CDC98
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJRNFA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 18 Oct 2023 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjJRNE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 09:04:58 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E759119;
        Wed, 18 Oct 2023 06:04:56 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-582a82e6d10so10282eaf.0;
        Wed, 18 Oct 2023 06:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697634295; x=1698239095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0SRSPeAfVm/OB4Q86vFV9kJ7aNqnSHVhsB69HY3UnI=;
        b=MXPzXyEfhZKaHYhUoVcMY49WBpGGN4dYDNA3DDPyZafsLfFLV3lenVRbyKTHIZBO4A
         Ut5G7KmZ0SNWHs6ltdihN413ul8Dyagr3Jp2/gglvWfejSr0MFZBlra3J4zt0VcHkeeK
         v5f0yeXUNV+EEJ+GsL9qdvaBEW68Qldvx4ObLuIVVFv/1zdZ9UyqyRCrOnblWUL0zoW6
         Cf4r/1M0NfGuUNgIe9u4InkhGWsnJ0eog4SHw6Q6fOw3yA30z3xE9wUi+pqKgEBF9cso
         AoCDl2sDkuc0Fh6PFU0Rjd4Qu2CbEkwtGY5KaEdhGfisZ2zc6M7HkjyhFIgp5CWl0vpe
         CPRA==
X-Gm-Message-State: AOJu0YxSakaxgK549IcSzK+sUSidcZZUSUghEsgAyrPK9glJa1Kyv49f
        ZtGFZXAb5tlReuT4L5wOxtKwijDrtdExaMojqj0=
X-Google-Smtp-Source: AGHT+IG57X3mbn4wBvOm5puVsKIvyX8GcNe2LUDaudB1ZSTZwuqMifIfoBTQX8YgUfnsWPlF16tTzjXeFrD39Ja0WKE=
X-Received: by 2002:a4a:d898:0:b0:581:84e9:a7ad with SMTP id
 b24-20020a4ad898000000b0058184e9a7admr5226358oov.1.1697634295252; Wed, 18 Oct
 2023 06:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231014105426.26389-1-sumitg@nvidia.com> <20231014105426.26389-3-sumitg@nvidia.com>
In-Reply-To: <20231014105426.26389-3-sumitg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Oct 2023 15:04:43 +0200
Message-ID: <CAJZ5v0ivZd-+wRtCNE4t1P=SjJSEJmW6s7GyuYELWg-v87Tw2w@mail.gmail.com>
Subject: Re: [Patch v5 2/2] ACPI: processor: reduce CPUFREQ thermal reduction
 pctg for Tegra241
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        jonathanh@nvidia.com, bbasu@nvidia.com, sanjayc@nvidia.com,
        ksitaraman@nvidia.com, srikars@nvidia.com, jbrasen@nvidia.com
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

On Sat, Oct 14, 2023 at 12:55 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>
> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>
> Current implementation of processor_thermal performs software throttling
> in fixed steps of "20%" which can be too coarse for some platforms.
> We observed some performance gain after reducing the throttle percentage.
> Change the CPUFREQ thermal reduction percentage and maximum thermal steps
> to be configurable. Also, update the default values of both for Nvidia
> Tegra241 (Grace) SoC. The thermal reduction percentage is reduced to "5%"
> and accordingly the maximum number of thermal steps are increased as they
> are derived from the reduction percentage.
>
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> Co-developed-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/arm64/Makefile          |  1 +
>  drivers/acpi/arm64/thermal_cpufreq.c | 20 ++++++++++++++++
>  drivers/acpi/processor_thermal.c     | 35 +++++++++++++++++++++++++---
>  include/linux/acpi.h                 |  9 +++++++
>  4 files changed, 62 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/acpi/arm64/thermal_cpufreq.c
>
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 143debc1ba4a..3f181d8156cc 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -5,3 +5,4 @@ obj-$(CONFIG_ACPI_GTDT)         += gtdt.o
>  obj-$(CONFIG_ACPI_APMT)        += apmt.o
>  obj-$(CONFIG_ARM_AMBA)         += amba.o
>  obj-y                          += dma.o init.o
> +obj-$(CONFIG_ACPI)             += thermal_cpufreq.o
> diff --git a/drivers/acpi/arm64/thermal_cpufreq.c b/drivers/acpi/arm64/thermal_cpufreq.c
> new file mode 100644
> index 000000000000..de834fb013e7
> --- /dev/null
> +++ b/drivers/acpi/arm64/thermal_cpufreq.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/acpi.h>
> +
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +#define SMCCC_SOC_ID_T241      0x036b0241
> +
> +int acpi_thermal_cpufreq_pctg(void)
> +{
> +       s32 soc_id = arm_smccc_get_soc_id_version();
> +
> +       /*
> +        * Check JEP106 code for NVIDIA Tegra241 chip (036b:0241) and
> +        * reduce the CPUFREQ Thermal reduction percentage to 5%.
> +        */
> +       if (soc_id == SMCCC_SOC_ID_T241)
> +               return 5;
> +
> +       return 0;
> +}
> +#endif

This part needs an ACK from the ARM folks.

> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index b7c6287eccca..52f316e4e260 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -26,7 +26,16 @@
>   */
>
>  #define CPUFREQ_THERMAL_MIN_STEP 0
> -#define CPUFREQ_THERMAL_MAX_STEP 3
> +
> +static int cpufreq_thermal_max_step __read_mostly = 3;
> +
> +/*
> + * Minimum throttle percentage for processor_thermal cooling device.
> + * The processor_thermal driver uses it to calculate the percentage amount by
> + * which cpu frequency must be reduced for each cooling state. This is also used
> + * to calculate the maximum number of throttling steps or cooling states.
> + */
> +static int cpufreq_thermal_pctg __read_mostly = 20;

I'd call this cpufreq_thermal_reduction_step, because the value
multiplied by it already is in percent.

>
>  static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>
> @@ -71,7 +80,7 @@ static int cpufreq_get_max_state(unsigned int cpu)
>         if (!cpu_has_cpufreq(cpu))
>                 return 0;
>
> -       return CPUFREQ_THERMAL_MAX_STEP;
> +       return cpufreq_thermal_max_step;
>  }
>
>  static int cpufreq_get_cur_state(unsigned int cpu)
> @@ -113,7 +122,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>                 if (!policy)
>                         return -EINVAL;
>
> -               max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
> +               max_freq = (policy->cpuinfo.max_freq *
> +                           (100 - reduction_pctg(i) * cpufreq_thermal_pctg)) / 100;
>
>                 cpufreq_cpu_put(policy);
>
> @@ -126,10 +136,29 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>         return 0;
>  }
>
> +static void acpi_thermal_cpufreq_config(void)
> +{
> +       int cpufreq_pctg = acpi_thermal_cpufreq_pctg();
> +
> +       if (!cpufreq_pctg)
> +               return;
> +
> +       cpufreq_thermal_pctg = cpufreq_pctg;
> +
> +       /*
> +        * Derive the MAX_STEP from minimum throttle percentage so that the reduction
> +        * percentage doesn't end up becoming negative. Also, cap the MAX_STEP so that
> +        * the CPU performance doesn't become 0.
> +        */
> +       cpufreq_thermal_max_step = (100 / cpufreq_thermal_pctg) - 1;

Why don't you use the local variable in the expression on the right-hand side?

Also please note that the formula doesn't allow the default
combination of reduction_step and max_step to be produced which is a
bit odd.

What would be wrong with max_step = 60 / reduction_step?

> +}
> +
>  void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy)
>  {
>         unsigned int cpu;
>
> +       acpi_thermal_cpufreq_config();
> +
>         for_each_cpu(cpu, policy->related_cpus) {
>                 struct acpi_processor *pr = per_cpu(processors, cpu);
>                 int ret;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ba3f601b6e3d..407617670221 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1541,4 +1541,13 @@ static inline void acpi_device_notify(struct device *dev) { }
>  static inline void acpi_device_notify_remove(struct device *dev) { }
>  #endif
>
> +#ifdef CONFIG_HAVE_ARM_SMCCC_DISCOVERY
> +int acpi_thermal_cpufreq_pctg(void);
> +#else
> +static inline int acpi_thermal_cpufreq_pctg(void)
> +{
> +       return 0;
> +}
> +#endif
> +

This can go into drivers/acpi/internal.h as far as I'm concerned.

>  #endif /*_LINUX_ACPI_H*/
> --
