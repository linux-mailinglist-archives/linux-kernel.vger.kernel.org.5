Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA947FD923
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjK2OTe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 09:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjK2OTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:19:32 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1BAF;
        Wed, 29 Nov 2023 06:19:39 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d7e6a08299so523606a34.0;
        Wed, 29 Nov 2023 06:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701267578; x=1701872378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew+114t4O/dSvPLleyNuMWD8sdkOQ563S7FzU1A3if4=;
        b=YmrqP+eQI8QjXAJk7/QruOSDH7iILj/DY+TCgwxcCAoYNpqrxxTP/r8mi0fmY+6spQ
         2wuEqk7R5G1E7Ad6g/4HvdzV37SmhrLAL0p4KXpB0en6cXMS6BlmCxhdRUfDrwW1tJtA
         ygaX3ekhVNvJ4u8XdLccnkEFlfMhOzabzrQ8qXSuIEt47o/pE2/ismXibDmRHd/54LWD
         UXgNP89TwgOGUGTzmD6awH0aZxVUQtTHmBbVks8AgElNsyMs1nSzgyvbF1HE/WIdqS3U
         KQylEpRCJxeLxZ2/5fyiHoY2/W4xg4xD01V4PQdhfoPs4T9CSY21v/PDWAT/VxxwcKKC
         rl2g==
X-Gm-Message-State: AOJu0YzYftTzhHxzsfvjaSMn2leJg8j/KklCMWJ9t2KrT+Jvkz9ucvT1
        giNFdhhHnGo2Ckn9nHbzcxVxr1PZulFWPVWFJ1T9fx44
X-Google-Smtp-Source: AGHT+IHxYXiCCS4giv7ST1MukOIwNIxxF1tKEvGvDo4EEU5SkC0s6yUhJWoinlBrd5GBC8IbpA5VKggu/1oyws/wwH8=
X-Received: by 2002:a05:6820:e17:b0:58d:1ce9:bfad with SMTP id
 el23-20020a0568200e1700b0058d1ce9bfadmr17006551oob.0.1701267578494; Wed, 29
 Nov 2023 06:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20231025111806.2416524-1-michal.wilczynski@intel.com> <20231025111806.2416524-5-michal.wilczynski@intel.com>
In-Reply-To: <20231025111806.2416524-5-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Nov 2023 15:19:27 +0100
Message-ID: <CAJZ5v0h2G6i0qXvSyFJeC4zsML3yxGZvUt-nUPs2Z3iHEM845A@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] ACPI: acpi_video: Replace acpi_driver with platform_driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, andriy.shevchenko@linux.intel.com,
        lenb@kernel.org
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

Hi Hans,

On Wed, Oct 25, 2023 at 2:35 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> The acpi_video driver uses struct acpi_driver to register itself while it
> would be more logically consistent to use struct platform_driver for this
> purpose, because the corresponding platform device is present and the
> role of struct acpi_device is to amend the other bus types. ACPI devices
> are not meant to be used as proper representation of hardware entities,
> but to collect information on those hardware entities provided by the
> platform firmware.
>
> Use struct platform_driver for registering the acpi_video driver.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>

Do you have any particular concerns regarding this change?  For
example, are there any setups that can break because of it?

> ---
>  drivers/acpi/acpi_video.c | 41 ++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 0c93b0ef0feb..5b9fb3374a2e 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -25,6 +25,7 @@
>  #include <linux/dmi.h>
>  #include <linux/suspend.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>  #include <acpi/video.h>
>  #include <linux/uaccess.h>
>
> @@ -75,8 +76,8 @@ static int register_count;
>  static DEFINE_MUTEX(register_count_mutex);
>  static DEFINE_MUTEX(video_list_lock);
>  static LIST_HEAD(video_bus_head);
> -static int acpi_video_bus_add(struct acpi_device *device);
> -static void acpi_video_bus_remove(struct acpi_device *device);
> +static int acpi_video_bus_probe(struct platform_device *pdev);
> +static void acpi_video_bus_remove(struct platform_device *pdev);
>  static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data);
>
>  /*
> @@ -97,14 +98,13 @@ static const struct acpi_device_id video_device_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, video_device_ids);
>
> -static struct acpi_driver acpi_video_bus = {
> -       .name = "video",
> -       .class = ACPI_VIDEO_CLASS,
> -       .ids = video_device_ids,
> -       .ops = {
> -               .add = acpi_video_bus_add,
> -               .remove = acpi_video_bus_remove,
> -               },
> +static struct platform_driver acpi_video_bus = {
> +       .probe = acpi_video_bus_probe,
> +       .remove_new = acpi_video_bus_remove,
> +       .driver = {
> +               .name = "video",
> +               .acpi_match_table = video_device_ids,
> +       },
>  };
>
>  struct acpi_video_bus_flags {
> @@ -1525,8 +1525,8 @@ static int acpi_video_bus_stop_devices(struct acpi_video_bus *video)
>
>  static void acpi_video_bus_notify(acpi_handle handle, u32 event, void *data)
>  {
> -       struct acpi_device *device = data;
> -       struct acpi_video_bus *video = acpi_driver_data(device);
> +       struct acpi_video_bus *video = data;
> +       struct acpi_device *device = video->device;
>         struct input_dev *input;
>         int keycode = 0;
>
> @@ -1969,8 +1969,9 @@ static int acpi_video_bus_put_devices(struct acpi_video_bus *video)
>
>  static int instance;
>
> -static int acpi_video_bus_add(struct acpi_device *device)
> +static int acpi_video_bus_probe(struct platform_device *pdev)
>  {
> +       struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>         struct acpi_video_bus *video;
>         bool auto_detect;
>         int error;
> @@ -2010,7 +2011,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
>         video->device = device;
>         strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
>         strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
> -       device->driver_data = video;
> +       platform_set_drvdata(pdev, video);
>
>         acpi_video_bus_find_cap(video);
>         error = acpi_video_bus_check(video);
> @@ -2059,7 +2060,7 @@ static int acpi_video_bus_add(struct acpi_device *device)
>                 goto err_del;
>
>         error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> -                                               acpi_video_bus_notify, device);
> +                                               acpi_video_bus_notify, video);
>         if (error)
>                 goto err_remove;
>
> @@ -2081,11 +2082,11 @@ static int acpi_video_bus_add(struct acpi_device *device)
>         return error;
>  }
>
> -static void acpi_video_bus_remove(struct acpi_device *device)
> +static void acpi_video_bus_remove(struct platform_device *pdev)
>  {
> -       struct acpi_video_bus *video = acpi_driver_data(device);
> +       struct acpi_video_bus *video = platform_get_drvdata(pdev);
>
> -       acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +       acpi_dev_remove_notify_handler(video->device, ACPI_DEVICE_NOTIFY,
>                                        acpi_video_bus_notify);
>
>         mutex_lock(&video_list_lock);
> @@ -2200,7 +2201,7 @@ int acpi_video_register(void)
>
>         dmi_check_system(video_dmi_table);
>
> -       ret = acpi_bus_register_driver(&acpi_video_bus);
> +       ret = platform_driver_register(&acpi_video_bus);
>         if (ret)
>                 goto leave;
>
> @@ -2220,7 +2221,7 @@ void acpi_video_unregister(void)
>  {
>         mutex_lock(&register_count_mutex);
>         if (register_count) {
> -               acpi_bus_unregister_driver(&acpi_video_bus);
> +               platform_driver_unregister(&acpi_video_bus);
>                 register_count = 0;
>                 may_report_brightness_keys = false;
>         }
> --
> 2.41.0
>
>
