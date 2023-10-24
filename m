Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E57D5B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjJXTLb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 15:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344307AbjJXTLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:11:22 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15985172D;
        Tue, 24 Oct 2023 12:11:10 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1d542f05b9aso856739fac.1;
        Tue, 24 Oct 2023 12:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698174670; x=1698779470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcA54zDLoesBIrcjaHX+r3abJJ7T9P6KPfRRYuwNMO0=;
        b=RbwbknzfrdS5GHHa7E4wlY3IjcCDCji4Xv83xaKjfTCxFxywDmUBKI4uSFI4vNYYh9
         yxIU36tuS9/cxjcdD+i86DPqdFrcHjA/KHPo07YHTB/3xjyvvSx72qrK1uTheYlu/dWT
         2vTtrJDV4tj/ndL+zuF17uReBF44Qz64q79U6rXZA+wYa8DnlW9b3x1hlBgcZ3OKyINe
         CpF4bH85/04AMz6ismEQw77euweRVAc6rS7qRpFTJvzhjNjXBAc2q2LRsvKJI3UtOjtg
         9Hycj0q4DGwVebIecodYZ2tZAloPx9wra9wbTrm/u3UgC4b4GjGWqCiLrV1eH2qQBmyV
         4zfg==
X-Gm-Message-State: AOJu0Yx/rIDUzB7KIOxmiEZ+kR8gasnBbGAs3ezBzzmmUetl5sqfJYLj
        TO8/8HdUaPTMf7qdt+wlmQJYuFD6gkCbSB3wCdH+dWBi
X-Google-Smtp-Source: AGHT+IH/jIcC8ruGdjXSairRuR8nx6ZRa/785O0bWbKPEGV3/MCmBTQKh0LOqyUw+K2Nykj37IghltPIVBJkSBamaXQ=
X-Received: by 2002:a05:6871:220e:b0:1e9:adec:bf5e with SMTP id
 sc14-20020a056871220e00b001e9adecbf5emr13384947oab.2.1698174670028; Tue, 24
 Oct 2023 12:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231018190945.252428-1-michal.wilczynski@intel.com> <20231018190945.252428-2-michal.wilczynski@intel.com>
In-Reply-To: <20231018190945.252428-2-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 21:10:58 +0200
Message-ID: <CAJZ5v0gg=bTK1hKM14x9pE-XPCofr3SEn5Yg1ez8PY8cQ494WA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: acpi_pad: Replace acpi_driver with platform_driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org
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

On Wed, Oct 18, 2023 at 10:37 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> The acpi_pad driver uses struct acpi_driver to register itself while it
> would be more logically consistent to use struct platform_driver for this
> purpose, because the corresponding platform device is present and the
> role of struct acpi_device is to amend the other bus types. ACPI devices
> are not meant to be used as proper representation of hardware entities,
> but to collect information on those hardware entities provided by the
> platform firmware.
>
> Use struct platform_driver for registering the acpi_pad driver.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/acpi_pad.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7a453c5ff303..25068f2c5b4d 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/perf_event.h>
> +#include <linux/platform_device.h>
>  #include <asm/mwait.h>
>  #include <xen/xen.h>
>
> @@ -430,8 +431,9 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
>         }
>  }
>
> -static int acpi_pad_add(struct acpi_device *device)
> +static int acpi_pad_probe(struct platform_device *pdev)
>  {
> +       struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>         acpi_status status;
>
>         strcpy(acpi_device_name(device), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
> @@ -450,8 +452,10 @@ static int acpi_pad_add(struct acpi_device *device)
>         return 0;
>  }
>
> -static void acpi_pad_remove(struct acpi_device *device)
> +static void acpi_pad_remove(struct platform_device *pdev)
>  {
> +       struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +
>         mutex_lock(&isolated_cpus_lock);
>         acpi_pad_idle_cpus(0);
>         mutex_unlock(&isolated_cpus_lock);
> @@ -467,13 +471,12 @@ static const struct acpi_device_id pad_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, pad_device_ids);
>
> -static struct acpi_driver acpi_pad_driver = {
> -       .name = "processor_aggregator",
> -       .class = ACPI_PROCESSOR_AGGREGATOR_CLASS,
> -       .ids = pad_device_ids,
> -       .ops = {
> -               .add = acpi_pad_add,
> -               .remove = acpi_pad_remove,
> +static struct platform_driver acpi_pad_driver = {
> +       .probe = acpi_pad_probe,
> +       .remove_new = acpi_pad_remove,
> +       .driver = {
> +               .name = "processor_aggregator",
> +               .acpi_match_table = pad_device_ids,
>         },
>  };
>
> @@ -487,12 +490,12 @@ static int __init acpi_pad_init(void)
>         if (power_saving_mwait_eax == 0)
>                 return -EINVAL;
>
> -       return acpi_bus_register_driver(&acpi_pad_driver);
> +       return platform_driver_register(&acpi_pad_driver);
>  }
>
>  static void __exit acpi_pad_exit(void)
>  {
> -       acpi_bus_unregister_driver(&acpi_pad_driver);
> +       platform_driver_unregister(&acpi_pad_driver);
>  }
>
>  module_init(acpi_pad_init);
> --

Applied as 6.7 material along with the rest of the series, thanks!
