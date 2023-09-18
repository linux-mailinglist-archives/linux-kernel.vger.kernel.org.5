Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705637A4706
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbjIRKb1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbjIRKbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:31:19 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA163DB;
        Mon, 18 Sep 2023 03:31:13 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5711d5dac14so1115020eaf.0;
        Mon, 18 Sep 2023 03:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695033073; x=1695637873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErCjYPZb5R42qd/bAiuaTdy6BusCKRPj6SWml5/mG+w=;
        b=kYiCcVp5Qfeq7r0DFhe/6Da+Ib83s9UHWbz6MoSQUpPgbkX+SRhpPukmTwRX+/gMtU
         kVrfTK6/r4Elb8+JhHKTxDB1un+3RRtVS2lmSjh2gOybBqJQcYARfBHNmbNlQpQjztlq
         dvlheDfXPZ6ndOpY1RNziS64B4H5i179+CYcIZ6wceOQq+pL6KpPUWFPXnHn9rHnGFLA
         8tq95clpBE+LtXQQyKUrPqP2qf2Q3AXpxvHYPCjmxwUIXMbWDj5JM8E9iuKWRFE0FeuR
         wmgd+PqruiacRX8VjJ2SvU8lRgVkYUwIKZV7OnkHcLJM3kZKFa+vZtNN4FgfFbDeiqHD
         Myag==
X-Gm-Message-State: AOJu0YzyRIr0QKOsRpkSr5Iv/MAlG9iJQ3t02I89ZVK5hEgmza/6J46r
        U0C8KgNfzUB8pfRxwOn3a0pb9idPqRmJWbonhbQ=
X-Google-Smtp-Source: AGHT+IGzicJIqnssObKvtpvoT+dKnNeRslejH1qfRD7ABvvgWon4Kl1kDhUo6Y/cnfvI6Y18Oa+llsz3SLwS5MWYg7g=
X-Received: by 2002:a4a:b483:0:b0:578:a06a:5d8f with SMTP id
 b3-20020a4ab483000000b00578a06a5d8fmr7599276ooo.1.1695033073091; Mon, 18 Sep
 2023 03:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230914213148.3560-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20230914213148.3560-1-guojinhui.liam@bytedance.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 12:30:58 +0200
Message-ID: <CAJZ5v0j+L=a0UEiCEXUYDtvscaVF29FPro9FNupMkJ7do2eBGw@mail.gmail.com>
Subject: Re: [PATCH v5] driver core: platform: set numa_node before platform_add_device()
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
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

On Thu, Sep 14, 2023 at 11:32 PM Jinhui Guo
<guojinhui.liam@bytedance.com> wrote:
>
> platform_add_device()

According to "git grep" this function is not present in 6.6-rc2.

If you mean platform_device_add(), please update the patch subject and
changelog accordingly.

> creates the numa_node attribute of sysfs according
> to whether dev_to_node(dev) is equal to NUMA_NO_NODE. So set the numa node
> of device before creating numa_node attribute of sysfs.

It would be good to also say that this needs to be done in
platform_device_register_full(), because that's where the platform
device object is allocated.

However, what about adding the NUMA node information to pdevinfo?  It
would be more straightforward to handle it then AFAICS.

> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
> V4 -> V5: Add Cc: stable line and changes from the previous submited
> patches
> V3 -> V4: Refactor code to be an ACPI function call
> V2 -> V3: Fix Signed-off name
> V1 -> V2: Fix compile error without enabling CONFIG_ACPI
>
>  drivers/acpi/acpi_platform.c | 4 +---
>  drivers/base/platform.c      | 1 +
>  include/linux/acpi.h         | 5 +++++
>  3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
> index 48d15dd785f6..adcbfbdc343f 100644
> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -178,11 +178,9 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
>         if (IS_ERR(pdev))
>                 dev_err(&adev->dev, "platform device creation failed: %ld\n",
>                         PTR_ERR(pdev));
> -       else {
> -               set_dev_node(&pdev->dev, acpi_get_node(adev->handle));
> +       else
>                 dev_dbg(&adev->dev, "created platform device %s\n",
>                         dev_name(&pdev->dev));
> -       }
>
>         kfree(resources);
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 76bfcba25003..35c891075d95 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -841,6 +841,7 @@ struct platform_device *platform_device_register_full(
>                         goto err;
>         }
>
> +       set_dev_node(&pdev->dev, ACPI_NODE_GET(ACPI_COMPANION(&pdev->dev)));
>         ret = platform_device_add(pdev);
>         if (ret) {
>  err:
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a73246c3c35e..6a349d53f19e 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -477,6 +477,10 @@ static inline int acpi_get_node(acpi_handle handle)
>         return 0;
>  }
>  #endif
> +
> +#define ACPI_NODE_GET(adev) ((adev) && (adev)->handle ? \
> +       acpi_get_node((adev)->handle) : NUMA_NO_NODE)
> +
>  extern int pnpacpi_disabled;
>
>  #define PXM_INVAL      (-1)
> @@ -770,6 +774,7 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
>  #define ACPI_COMPANION_SET(dev, adev)  do { } while (0)
>  #define ACPI_HANDLE(dev)               (NULL)
>  #define ACPI_HANDLE_FWNODE(fwnode)     (NULL)
> +#define ACPI_NODE_GET(adev)            NUMA_NO_NODE
>
>  #include <acpi/acpi_numa.h>
>
> --
> 2.20.1
>
