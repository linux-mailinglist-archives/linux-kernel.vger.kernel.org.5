Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6CD8079E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379510AbjLFU6k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLFU6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:58:37 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A628DC;
        Wed,  6 Dec 2023 12:58:44 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58de9deec94so21994eaf.0;
        Wed, 06 Dec 2023 12:58:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896323; x=1702501123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VteboLc0PuWVvYglmZVfyeUmWI8ColgUVaYDoWTMUuk=;
        b=IEAciPc5rtiIfN024Ww/2B0YoAxwZcs8rycx7ueswpPW2tUMNsKbJZm8NAZeAVskzm
         Qm9Ssy7s81GKMhVmm9xgzwcnBUzQLYyw5TypPWMUoK4LwS/huI/364XpKyAxOEg24LW/
         lmvUjniR3e4tYdyDFJf+Dwd1lMqlVFE20kgsRG7YeRbykPQqb9yTIZ3rbZ1PnDjr/7Z0
         +xgU4GvKbBtxtNMleUdLNcb+KVsmIcqhIX1/llWn8zsZa7meEywDYHn3mIENjRL2hjEO
         b+EbmWcCTMZHgJb/aRDBkKHP3L1JjGh1Ueq9H7+gBgBgnN/arNGgoBAFL8jZWgrdia1V
         XYVw==
X-Gm-Message-State: AOJu0YyRnFEFXs9fkfN03t2Dd0gGkqwK4bbjnvNr6e9BOWchCUXBL9Hg
        6ofylTTLsCMAM4odkhWH6U8+EQuSJzcuLOZTFpE=
X-Google-Smtp-Source: AGHT+IFo94aQzIA1juguyuAHtJCCdYflVfUEjabXs6GmVmLiIxNMiKEEABWlyYvFUGS5UrmDXUsjl2IIqLYbp7pTkqo=
X-Received: by 2002:a05:6870:9e84:b0:1fa:f195:e3b4 with SMTP id
 pu4-20020a0568709e8400b001faf195e3b4mr3122262oab.2.1701896323415; Wed, 06 Dec
 2023 12:58:43 -0800 (PST)
MIME-Version: 1.0
References: <20231205063537.872834-1-li.meng@amd.com> <20231205063537.872834-5-li.meng@amd.com>
In-Reply-To: <20231205063537.872834-5-li.meng@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 21:58:32 +0100
Message-ID: <CAJZ5v0ju-Thhz2_rQVbTosTsBaRoyQW2kjtPWWTsiT_Yi2DbsQ@mail.gmail.com>
Subject: Re: [PATCH V12 4/7] cpufreq: Add a notification message that the
 highest perf has changed
To:     Meng Li <li.meng@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 7:38 AM Meng Li <li.meng@amd.com> wrote:
>
> ACPI 6.5 section 8.4.6.1.1.1 specifies that Notify event 0x85 can be
> emmitted to cause the the OSPM to re-evaluate the highest performance

Typos above.  Given the number of iterations of this patch, this is
kind of disappointing.

> register. Add support for this event.

Also it would be nice to describe how this is supposed to work at
least roughly, so it is not necessary to reverse-engineer the patch to
find out that.

> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#processor-device-notification-values
> ---
>  drivers/acpi/processor_driver.c |  6 ++++++
>  drivers/cpufreq/cpufreq.c       | 13 +++++++++++++
>  include/linux/cpufreq.h         |  5 +++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 4bd16b3f0781..29b2fb68a35d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -27,6 +27,7 @@
>  #define ACPI_PROCESSOR_NOTIFY_PERFORMANCE 0x80
>  #define ACPI_PROCESSOR_NOTIFY_POWER    0x81
>  #define ACPI_PROCESSOR_NOTIFY_THROTTLING       0x82
> +#define ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED      0x85
>
>  MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI Processor Driver");
> @@ -83,6 +84,11 @@ static void acpi_processor_notify(acpi_handle handle, u32 event, void *data)
>                 acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                                   dev_name(&device->dev), event, 0);
>                 break;
> +       case ACPI_PROCESSOR_NOTIFY_HIGEST_PERF_CHANGED:
> +               cpufreq_update_highest_perf(pr->id);

And the design appears to be a bit ad-hoc here.

Because why does it have anything to do with cpufreq?

> +               acpi_bus_generate_netlink_event(device->pnp.device_class,
> +                                                 dev_name(&device->dev), event, 0);
> +               break;
>         default:
>                 acpi_handle_debug(handle, "Unsupported event [0x%x]\n", event);
>                 break;
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 934d35f570b7..14a4cbc6dd05 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2717,6 +2717,19 @@ void cpufreq_update_limits(unsigned int cpu)
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_update_limits);
>
> +/**
> + * cpufreq_update_highest_perf - Update highest performance for a given CPU.
> + * @cpu: CPU to update the highest performance for.
> + *
> + * Invoke the driver's ->update_highest_perf callback if present
> + */
> +void cpufreq_update_highest_perf(unsigned int cpu)
> +{
> +       if (cpufreq_driver->update_highest_perf)
> +               cpufreq_driver->update_highest_perf(cpu);
> +}
> +EXPORT_SYMBOL_GPL(cpufreq_update_highest_perf);
> +
>  /*********************************************************************
>   *               BOOST                                              *
>   *********************************************************************/
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 1c5ca92a0555..f62257b2a42f 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -235,6 +235,7 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
>  void refresh_frequency_limits(struct cpufreq_policy *policy);
>  void cpufreq_update_policy(unsigned int cpu);
>  void cpufreq_update_limits(unsigned int cpu);
> +void cpufreq_update_highest_perf(unsigned int cpu);
>  bool have_governor_per_policy(void);
>  bool cpufreq_supports_freq_invariance(void);
>  struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
> @@ -263,6 +264,7 @@ static inline bool cpufreq_supports_freq_invariance(void)
>         return false;
>  }
>  static inline void disable_cpufreq(void) { }
> +static inline void cpufreq_update_highest_perf(unsigned int cpu) { }
>  #endif
>
>  #ifdef CONFIG_CPU_FREQ_STAT
> @@ -380,6 +382,9 @@ struct cpufreq_driver {
>         /* Called to update policy limits on firmware notifications. */
>         void            (*update_limits)(unsigned int cpu);
>
> +       /* Called to update highest performance on firmware notifications. */
> +       void            (*update_highest_perf)(unsigned int cpu);
> +
>         /* optional */
>         int             (*bios_limit)(int cpu, unsigned int *limit);
>
> --
> 2.34.1
>
>
