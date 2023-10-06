Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BF67BBFD3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjJFTsM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Oct 2023 15:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbjJFTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:48:10 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E17683;
        Fri,  6 Oct 2023 12:48:09 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-57be74614c0so127028eaf.1;
        Fri, 06 Oct 2023 12:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696621688; x=1697226488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qtrIYwt5+xezRUeXv6ZO7TiBtw+EXKB+lTOgWGj6zc=;
        b=geaaONrtbJLwZrZ7CqUjqXeVvokZ9Lb147ZzF8l33U8qYe1VKrsxhWctoWzXCHxN9m
         gMonZiHeVkibn47+opHE2p2+8HAdrissYXJjWSgvSXiVnyH3JuTyU8rN69N8NmeLLTqd
         3fhXeWDCTRdwIvCgV+XWKKvx6mYGrmiJ+YvqgY7CipwVZP6vBuRyQc/LCtXhFvVHHLlf
         MFbTf6zgLXvCzmirWJCiaxyaDKQiTyPKX67cRvSKzx7e44gKfvPQ/Zt8r2gD2Ayw0mbS
         8gbT5BgpWBGQ4xuD1hZnuye/8c6JSGewep5KFvqHE5C/GZwX4DFL478HDfKAlw7S9nFD
         PAng==
X-Gm-Message-State: AOJu0YyT/8Lu3+cUXkJICvXxzYvBCegrkbOF6qYeZcj8GG4/fELNkleT
        gHcIJGabXMd8Vui1o7sIw5CQQApvwilrK+t1j+U=
X-Google-Smtp-Source: AGHT+IEbHKyLXUN+VeQaWG8yOuLIjWf9zRSx8HK/NyYMqdeOBCTAZuxVI14uQ14DfqOzLaioiwUl95A/vx+uEm8kmaE=
X-Received: by 2002:a4a:b807:0:b0:57b:3b64:7ea5 with SMTP id
 g7-20020a4ab807000000b0057b3b647ea5mr8300446oop.1.1696621688430; Fri, 06 Oct
 2023 12:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com> <20231006173055.2938160-4-michal.wilczynski@intel.com>
In-Reply-To: <20231006173055.2938160-4-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 Oct 2023 21:47:57 +0200
Message-ID: <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        andriy.shevchenko@intel.com, lenb@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com
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

On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> AC driver uses struct acpi_driver incorrectly to register itself. This
> is wrong as the instances of the ACPI devices are not meant to
> be literal devices, they're supposed to describe ACPI entry of a
> particular device.
>
> Use platform_driver instead of acpi_driver. In relevant places call
> platform devices instances pdev to make a distinction with ACPI
> devices instances.
>
> Drop unnecessary casts from acpi_bus_generate_netlink_event() and
> acpi_notifier_call_chain().
>
> Add a blank line to distinguish pdev API vs local ACPI notify function.
>
> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/ac.c | 70 +++++++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index f809f6889b4a..298defeb5301 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -33,8 +33,9 @@ MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION("ACPI AC Adapter Driver");
>  MODULE_LICENSE("GPL");
>
> -static int acpi_ac_add(struct acpi_device *device);
> -static void acpi_ac_remove(struct acpi_device *device);
> +static int acpi_ac_probe(struct platform_device *pdev);
> +static void acpi_ac_remove(struct platform_device *pdev);
> +
>  static void acpi_ac_notify(acpi_handle handle, u32 event, void *data);
>
>  static const struct acpi_device_id ac_device_ids[] = {
> @@ -51,21 +52,10 @@ static SIMPLE_DEV_PM_OPS(acpi_ac_pm, NULL, acpi_ac_resume);
>  static int ac_sleep_before_get_state_ms;
>  static int ac_only;
>
> -static struct acpi_driver acpi_ac_driver = {
> -       .name = "ac",
> -       .class = ACPI_AC_CLASS,
> -       .ids = ac_device_ids,
> -       .ops = {
> -               .add = acpi_ac_add,
> -               .remove = acpi_ac_remove,
> -               },
> -       .drv.pm = &acpi_ac_pm,
> -};
> -
>  struct acpi_ac {
>         struct power_supply *charger;
>         struct power_supply_desc charger_desc;
> -       struct acpi_device *device;
> +       struct device *dev;

I'm not convinced about this change.

If I'm not mistaken, you only use the dev pointer above to get the
ACPI_COMPANION() of it, but the latter is already found in _probe(),
so it can be stored in struct acpi_ac for later use and then the dev
pointer in there will not be necessary any more.

That will save you a bunch of ACPI_HANDLE() evaluations and there's
nothing wrong with using ac->device->handle.  The patch will then
become almost trivial AFAICS and if you really need to get from ac to
the underlying platform device, a pointer to it can be added to struct
acpi_ac without removing the ACPI device pointer from it.

>         unsigned long long state;
>         struct notifier_block battery_nb;
>  };
