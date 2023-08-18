Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B79781300
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379473AbjHRSlg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Aug 2023 14:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379468AbjHRSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:41:21 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5523035A5;
        Fri, 18 Aug 2023 11:41:11 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56e280cc606so193582eaf.1;
        Fri, 18 Aug 2023 11:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692384070; x=1692988870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxaxABvM2KRinXBpk7hKZ7+Pm85gTTTzoE4vwMCrLDE=;
        b=bnVPDPOZaBTW5pbY1xL4zfD8Z8S7AxC5pV2k5j/+HTiNyiG1tQh8zgcse0CFrY4UKs
         60355C4OzpQZ2yN9zoxWFSAsehO/yV2BZniBURVU1Yf2Wu6Uzb0Nmj28S/+xlmr6Ow9v
         x70ekVgjnvSYhK9cLvVReWmhq++E7+c+GEdrvgshS3wg1EndnonhdQl/dha/YYXfylZ0
         MX7CG4DVkBtmf1RgsAzKNPr3MWsaMCgPNMgW9ShI6ZpcdxpBCw3IaQsvH+qxPhCuI/9O
         i2RxENhIazNh84RLpkz5NiYeAHPs1T9oH7oRlZWVr+IjijtqX2zkCD+BoI8005hD7Y1b
         MwQQ==
X-Gm-Message-State: AOJu0YzKByFyuAG2tfA/GuJZY0PWENDoqa1vPEUDHQEfV0q+QJ/wBJ6y
        C82jWuxQj0khyugWhdvP5AjL5ZCidzw3Wdpt5xkE+tkp
X-Google-Smtp-Source: AGHT+IEzrcS4tAIi93tcHt5JR+XQT9QwHpYG3Ho5LC+r1qhozZSr5AtB9Y4EsH9NYvba1f880li/2rA8WnTc454q8j4=
X-Received: by 2002:a4a:be17:0:b0:56e:72e0:9c5f with SMTP id
 l23-20020a4abe17000000b0056e72e09c5fmr57856oop.1.1692384070574; Fri, 18 Aug
 2023 11:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230817093011.1378-1-sumitg@nvidia.com> <20230817093011.1378-3-sumitg@nvidia.com>
In-Reply-To: <20230817093011.1378-3-sumitg@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Aug 2023 20:40:59 +0200
Message-ID: <CAJZ5v0hkm6eou9E+CVwasURjPG3RtVH+TMvvzGqVwQnDDrBocA@mail.gmail.com>
Subject: Re: [Patch 2/2] ACPI: processor: Add support to configure CPUFREQ
 reduction pctg
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, lenb@kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjayc@nvidia.com, ksitaraman@nvidia.com, srikars@nvidia.com,
        jbrasen@nvidia.com, bbasu@nvidia.com
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

On Thu, Aug 17, 2023 at 11:31 AM Sumit Gupta <sumitg@nvidia.com> wrote:
>
> From: Srikar Srimath Tirumala <srikars@nvidia.com>
>
> Add support to configure the CPUFREQ reduction percentage and set the
> maximum number of throttling steps accordingly. Current implementation
> of processor_thermal performs software throttling in fixed steps of
> "20%" which can be too coarse for some platforms. Change that by adding
> new config to provide the reduction percentage.
>
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/acpi/Kconfig             | 15 +++++++++++++++
>  drivers/acpi/processor_thermal.c | 19 ++++++++++++++++---
>  2 files changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 00dd309b6682..287cf58defbf 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -254,6 +254,21 @@ config ACPI_DOCK
>  config ACPI_CPU_FREQ_PSS
>         bool
>
> +config ACPI_CPU_FREQ_THERM_HAS_PARAMS
> +       bool "CPU frequency throttling control"
> +       depends on ACPI_PROCESSOR
> +
> +config ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
> +       int "Minimum throttle percentage for processor_thermal cooling device"
> +       depends on ACPI_CPU_FREQ_THERM_HAS_PARAMS
> +       default 20
> +       help
> +         The processor_thermal driver uses this config to calculate the
> +         percentage amount by which cpu frequency must be reduced for each
> +         cooling state. The config is also used to calculate the maximum number
> +         of throttling steps or cooling states supported by the driver. Value
> +         must be an unsigned integer in the range [1, 50].
> +

I don't think that the new Kconfig symbols are particularly useful.
At least they don't help the distro vendors that each would need to
pick up a specific value for their kernel anyway.

I also wonder how the users building their own kernels are supposed to
determine the values suitable for the target systems.

>  config ACPI_PROCESSOR_CSTATE
>         def_bool y
>         depends on ACPI_PROCESSOR
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_thermal.c
> index b7c6287eccca..ee443cc69b73 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -25,8 +25,20 @@
>   * _any_ cpufreq driver and not only the acpi-cpufreq driver.
>   */
>
> -#define CPUFREQ_THERMAL_MIN_STEP 0
> -#define CPUFREQ_THERMAL_MAX_STEP 3
> +#define CPUFREQ_THERMAL_MIN_STEP       0
> +#ifdef CONFIG_ACPI_CPU_FREQ_THERM_HAS_PARAMS
> +#define CPUFREQ_THERMAL_PCTG           CONFIG_ACPI_CPU_FREQ_THERM_MIN_THROT_PCTG
> +
> +/* Derive the MAX_STEP from minimum throttle percentage so that the reduction
> + * percentage does end up becoming negative. Also cap the MAX_STEP so that
> + * the CPU performance doesn't become 0.
> + */
> +#define CPUFREQ_THERMAL_MAX_STEP       ((100 / CPUFREQ_THERMAL_PCTG) - 1)
> +
> +#else
> +#define CPUFREQ_THERMAL_MAX_STEP       3
> +#define CPUFREQ_THERMAL_PCTG           20
> +#endif
>
>  static DEFINE_PER_CPU(unsigned int, cpufreq_thermal_reduction_pctg);
>
> @@ -113,7 +125,8 @@ static int cpufreq_set_cur_state(unsigned int cpu, int state)
>                 if (!policy)
>                         return -EINVAL;
>
> -               max_freq = (policy->cpuinfo.max_freq * (100 - reduction_pctg(i) * 20)) / 100;
> +               max_freq = (policy->cpuinfo.max_freq *
> +                           (100 - reduction_pctg(i) * CPUFREQ_THERMAL_PCTG)) / 100;
>
>                 cpufreq_cpu_put(policy);
>
> --
