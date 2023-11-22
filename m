Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13627F4B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbjKVPkC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 10:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344547AbjKVPji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:39:38 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0B49FA;
        Wed, 22 Nov 2023 07:37:27 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d7e6a08299so229201a34.0;
        Wed, 22 Nov 2023 07:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700667446; x=1701272246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Axuz+35EuK//V55jI0luW/JRmpf/RhvJBWT8L3iWiA=;
        b=qP4Ve6wHz+J5Ptx5GnnfHFospatxSd47pu+pcFBu3LDYZk5GgBM1Pl1T2Nz8LZM287
         bqAEdv41F7RfAyJ0o14+C+bpmhrXn4enAjbxeOSz2Kjnr0L1V7drV5MW8/5BTHz3LnFz
         Pt/prkIb/xkSdDNhWn4hbbgbIo4JiMSIvTCv9tdjorbvPnul4ICbi0vGHUwR4xS0TwER
         i4fawXbQTzVJVutOuO0GT2xH7H3VfAw4zDCzBLjjr6GGx6trqP+qS0tR8Uq7tHUuSgcd
         TpVm0anx7vRn9ALksCSCRGhcpsnVWH2GdvXM/MZHrMABesMp2u8w2c9tqVkdZng6m/jL
         0k1Q==
X-Gm-Message-State: AOJu0Yzm3RBZjpk+9muauX8FvqR1/BTkcxHZ6BEGWDxXh1xQctMgwRcC
        2wVDZ79F8xPe084p1M2KAK8YZ7i61tY/Wjf00VgqMtYh
X-Google-Smtp-Source: AGHT+IGvTsFTy1Gu660SNigi19IvWsZLQFjXCW6ElAeXjNJ76kyEm2NA5mv4nEj/5nM/0of5A1U7zG0UvHvNv/e/z/Q=
X-Received: by 2002:a05:6870:2401:b0:1f9:5d11:cc7a with SMTP id
 n1-20020a056870240100b001f95d11cc7amr3211659oap.3.1700667446561; Wed, 22 Nov
 2023 07:37:26 -0800 (PST)
MIME-Version: 1.0
References: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3>
In-Reply-To: <170066723324.2477261.2506149141979712937.stgit@djiang5-mobl3>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Nov 2023 16:37:15 +0100
Message-ID: <CAJZ5v0giyyhZdkXW7AvZtZZHFNaFxrYKtdZkvthtuB_bXGqt1A@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Fix ARM32 platforms compile issue introduced by
 fw_table changes
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linus.walleij@linaro.org, rafael@kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, lenb@kernel.org,
        robert.moore@intel.com, Jonathan.Cameron@huawei.com,
        dan.j.williams@intel.com, guohanjun@huawei.com, arnd@arndb.de,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cfsworks@gmail.com
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

On Wed, Nov 22, 2023 at 4:34 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Linus reported that:
> After commit a103f46633fd the kernel stopped compiling for
> several ARM32 platforms that I am building with a bare metal
> compiler. Bare metal compilers (arm-none-eabi-) don't
> define __linux__.
>
> This is because the header <acpi/platform/acenv.h> is now
> in the include path for <linux/irq.h>:
>
>   CC      arch/arm/kernel/irq.o
>   CC      kernel/sysctl.o
>   CC      crypto/api.o
> In file included from ../include/acpi/acpi.h:22,
>                  from ../include/linux/fw_table.h:29,
>                  from ../include/linux/acpi.h:18,
>                  from ../include/linux/irqchip.h:14,
>                  from ../arch/arm/kernel/irq.c:25:
> ../include/acpi/platform/acenv.h:218:2: error: #error Unknown target environment
>   218 | #error Unknown target environment
>       |  ^~~~~
>
> The issue is caused by the introducing of splitting out the ACPI code to
> support the new generic fw_table code.
>
> Rafael suggested [1] moving the fw_table.h include in linux/acpi.h to below
> the linux/mutex.h. Remove the two includes in fw_table.h. Replace
> linux/fw_table.h include in fw_table.c with linux/acpi.h.
>
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
> Closes: https://lore.kernel.org/linux-acpi/20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org/
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Drop fw_table.h in fw_table.c since acpi.h already included. (Rafael)

Do you want me to apply this, or do you prefer to route it in a different way?

In the latter case, please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

> v2:
> - Remove linux/acpi.h include as well in fw_table.h. (Sam)
> ---
>  include/linux/acpi.h     |   22 +++++++++++-----------
>  include/linux/fw_table.h |    3 ---
>  lib/fw_table.c           |    2 +-
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 54189e0e5f41..4db54e928b36 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -15,7 +15,6 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/property.h>
>  #include <linux/uuid.h>
> -#include <linux/fw_table.h>
>
>  struct irq_domain;
>  struct irq_domain_ops;
> @@ -25,22 +24,13 @@ struct irq_domain_ops;
>  #endif
>  #include <acpi/acpi.h>
>
> -#ifdef CONFIG_ACPI_TABLE_LIB
> -#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
> -#define __init_or_acpilib
> -#define __initdata_or_acpilib
> -#else
> -#define EXPORT_SYMBOL_ACPI_LIB(x)
> -#define __init_or_acpilib __init
> -#define __initdata_or_acpilib __initdata
> -#endif
> -
>  #ifdef CONFIG_ACPI
>
>  #include <linux/list.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/fw_table.h>
>
>  #include <acpi/acpi_bus.h>
>  #include <acpi/acpi_drivers.h>
> @@ -48,6 +38,16 @@ struct irq_domain_ops;
>  #include <acpi/acpi_io.h>
>  #include <asm/acpi.h>
>
> +#ifdef CONFIG_ACPI_TABLE_LIB
> +#define EXPORT_SYMBOL_ACPI_LIB(x) EXPORT_SYMBOL_NS_GPL(x, ACPI)
> +#define __init_or_acpilib
> +#define __initdata_or_acpilib
> +#else
> +#define EXPORT_SYMBOL_ACPI_LIB(x)
> +#define __init_or_acpilib __init
> +#define __initdata_or_acpilib __initdata
> +#endif
> +
>  static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>  {
>         return adev ? adev->handle : NULL;
> diff --git a/include/linux/fw_table.h b/include/linux/fw_table.h
> index ff8fa58d5818..ca49947f0a77 100644
> --- a/include/linux/fw_table.h
> +++ b/include/linux/fw_table.h
> @@ -25,9 +25,6 @@ struct acpi_subtable_proc {
>         int count;
>  };
>
> -#include <linux/acpi.h>
> -#include <acpi/acpi.h>
> -
>  union acpi_subtable_headers {
>         struct acpi_subtable_header common;
>         struct acpi_hmat_structure hmat;
> diff --git a/lib/fw_table.c b/lib/fw_table.c
> index b51f30a28e47..294df54e33b6 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -7,7 +7,7 @@
>   *  Copyright (C) 2023 Intel Corp.
>   */
>  #include <linux/errno.h>
> -#include <linux/fw_table.h>
> +#include <linux/acpi.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>
>
>
