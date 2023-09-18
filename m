Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C647A4C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjIRPf6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Sep 2023 11:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjIRPfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:35:36 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC3173E;
        Mon, 18 Sep 2023 08:31:04 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-273e3d8b57aso876631a91.0;
        Mon, 18 Sep 2023 08:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050794; x=1695655594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttSOZU5jatbg8vHOMifgIm1wH7BtkDUeEHF0pV5Xpts=;
        b=vNf6NvTwjnydGu15xUPmcJrxyP/D98P7iFNvGorvHSH0pEpTdN6xmbyKxzPgpydTyF
         3M2RWhpAxaib96rdmwqxvu/oahTN3qjf+xxUilR/KPZX5Y+1AIsSONkUMBfUUV8ELkED
         fVFGfIkbyP8Sre8+Wx2X3W3BMD4vxiIB6lxdlI3MpN7AXcQ3Mr9X9W7LqFbo0yubfYuB
         a+gieI2bIeHP+LF5IF0fj4oKv3jrkV/aZ3il7W0nO7goi8L3NYiklg15XPNeg5CMdpF2
         aZHao4hEX1RY4QuV1s5kDMdo3RqZcbOnMts4ksqXlgS9P+eybL3HowG9aAyeV05yVkzX
         zKBg==
X-Gm-Message-State: AOJu0YyjUj++I/WYPTdZ8OUhZzDQEbCAyUYrR32Sci6AyCIxoMYGvos2
        vQDQWl4k0VBmTNw+XD7VrhAhjvzqJRsT9C+WfjqvFL+Y
X-Google-Smtp-Source: AGHT+IFY6CslyWtF7cqkve/+Y36/K0OtKaF82z7c5seokvb+l8f2uZUSxPIzROUlIhPAVAw+xxhF7Lokf4RKQXdt8gQ=
X-Received: by 2002:a4a:dc93:0:b0:573:4a72:6ec with SMTP id
 g19-20020a4adc93000000b005734a7206ecmr9145014oou.1.1695047653501; Mon, 18 Sep
 2023 07:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230918134527.252-1-guojinhui.liam@bytedance.com>
In-Reply-To: <20230918134527.252-1-guojinhui.liam@bytedance.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 16:34:02 +0200
Message-ID: <CAJZ5v0id5sAs711-oCgV7kHfJQOKBWN=JTt1wJkpx4qZqE_18Q@mail.gmail.com>
Subject: Re: [PATCH v6] driver core: platform: set numa_node before platform_device_add()
To:     Jinhui Guo <guojinhui.liam@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
        lizefan.x@bytedance.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
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

On Mon, Sep 18, 2023 at 3:46 PM Jinhui Guo <guojinhui.liam@bytedance.com> wrote:
>
> Setting the devices' numa_node needs to be done in
> platform_device_register_full(), because that's where the
> platform device object is allocated.
>
> Fixes: 4a60406d3592 ("driver core: platform: expose numa_node to users in sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309122309.mbxAnAIe-lkp@intel.com/
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

No, I haven't given you this tag.

I don't think that Greg has given you the one above either.

Please don't add tage that you haven't received to your patches,
because they are not applicable with incorrect tags.

> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
> V5 -> V6:
>   1. Update subject to correct function name platform_device_add().
>   2. Provide a more clear and accurate description of the changes
>      made in commit (suggested by Rafael J. Wysocki).
>   3. Add reviewer name.
>
> V4 -> V5:
>   Add Cc: stable line and changes from the previous submited patches.
>
> V3 -> V4:
>   Refactor code to be an ACPI function call.
>
> V2 -> V3:
>   Fix Signed-off name.
>
> V1 -> V2:
>   Fix compile error without enabling CONFIG_ACPI.
> ---
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
