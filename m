Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBCE7F4779
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbjKVNPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 08:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343964AbjKVNO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:14:56 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36988D40;
        Wed, 22 Nov 2023 05:14:53 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d7e6a08299so209112a34.0;
        Wed, 22 Nov 2023 05:14:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700658892; x=1701263692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYp1qA6Rj8R+cs9YseE9JWdxZsiJT+korOEyoXcPVv4=;
        b=cpoJKCW32sfBaIcuv+DIDy/AFCJhiLlz+9Mz7klBm3ixt7e8e+hlOPt475RJM+hLY1
         NR/iKnsDxYEM93LootEmX5VeBucsuWi5YoYvnvuk3cHuDFR1OUjRHZ97JNvnCVCzmXHL
         jzsjUbjPixN+30u9eieYUJWSasutNab/KQpLOwApLGEYkVHWri7g/pyPvIDe24C372ER
         rkpw0arMevY/ASziZa9HETMeZfCZVGlpW/+VbfJgEQMi3pb0FrfEzSz4e8zD1BykWLM6
         Rtf3Ydr4FaDLf979/ftC2hGwYZchCHAhxs1aUfyLSYDgnTrQbLz7JnzeZEtG1a3uL8uh
         3P3g==
X-Gm-Message-State: AOJu0Yzi+mDL/Kn6+r4W12Bty7hXoqdZAQNAgM+nbNO6AVi1jIzJYc5E
        w2TwMXlWTcEelHiPk4eXYVYQZw1qwbqOTURkvf4=
X-Google-Smtp-Source: AGHT+IGLaqddtZJrV7cWRhrcczCAU1dJlp3v3FkD9l6DHotgDfOqpiCeWd08F8MrY56cvJDLtFQNUfFZGkEEJfDGWyo=
X-Received: by 2002:a05:6870:2401:b0:1f9:5d11:cc7a with SMTP id
 n1-20020a056870240100b001f95d11cc7amr2688101oap.3.1700658892377; Wed, 22 Nov
 2023 05:14:52 -0800 (PST)
MIME-Version: 1.0
References: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
In-Reply-To: <170060515641.2447486.11798332619205301829.stgit@djiang5-mobl3>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Nov 2023 14:14:41 +0100
Message-ID: <CAJZ5v0hkGfqzHwmhBKqwhcEchncM6kEgx_TJgJGgjiR5yMZkLg@mail.gmail.com>
Subject: Re: [PATCH v2] acpi: Fix ARM32 platforms compile issue introduced by
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

On Tue, Nov 21, 2023 at 11:19 PM Dave Jiang <dave.jiang@intel.com> wrote:
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
> the linux/mutex.h. Remove the two includes in fw_table.h. Add include of
> linux/acpi.h in fw_table.c before the fw_table.h include.
>
> Link: https://lore.kernel.org/linux-acpi/CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com/
> Fixes: a103f46633fd ("acpi: Move common tables helper functions to common lib")
> Reported-by: Linus Walleij <linus.walleij@linaro.org>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Remove linux/acpi.h include as well in fw_table.h. (Sam)
> ---
>  include/linux/acpi.h     |   22 +++++++++++-----------
>  include/linux/fw_table.h |    3 ---
>  lib/fw_table.c           |    1 +
>  3 files changed, 12 insertions(+), 14 deletions(-)
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
> index b51f30a28e47..c4831f3378be 100644
> --- a/lib/fw_table.c
> +++ b/lib/fw_table.c
> @@ -7,6 +7,7 @@
>   *  Copyright (C) 2023 Intel Corp.
>   */
>  #include <linux/errno.h>
> +#include <linux/acpi.h>
>  #include <linux/fw_table.h>

Because fw_table.h is included via acpi.h, do you still need to
include it directly here?

>  #include <linux/init.h>
>  #include <linux/kernel.h>
>
>
>
