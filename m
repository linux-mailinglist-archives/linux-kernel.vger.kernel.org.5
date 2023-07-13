Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2E7526A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjGMPVy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jul 2023 11:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbjGMPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:21:50 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BDA1FDB;
        Thu, 13 Jul 2023 08:21:49 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98e1fc9d130so25506066b.0;
        Thu, 13 Jul 2023 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261707; x=1691853707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTGT1Ug3FquYRrJnkoPEsCW46sTDvUy1j7X26gKlfoU=;
        b=F/t67BtbqDS/zYMvYUCo7rZsLHthfc6JDvzd3K2phgPVtJICOb58pdpz6deKsRMowt
         oyZfgzo4PPDy+yX4I5uih19aMSyk/knnE9u/nqQHx0QAyZnM7w6GQHLmM+N7YAR8Pok7
         c8S6l3NnNJuXguicmSTFaN9N8NUkzj0x4w9XUr8lKf5xS2NxcEgG6cmL6rhsfMuRXk5V
         sMhgmgxLnqRoRTD9KKFT+IkF7ZpWOpybQF19ZHX3RQYqpbStTs1NXp1zN3vr1Cyl0SLf
         l9BLDF4PgbYsiAo1kFOktrncR2BhggoUuk+Odti7SV26kxaRsZs8nyz8NVcvfbMmJmA0
         ZsQg==
X-Gm-Message-State: ABy/qLYuBUByYqeZD9XBJRmFiso4CL7FCRP/3yvMtARsCzOY1IeeY4WJ
        UcfDFGtgt2pIfLftETf9W6Viq6W3/5xIxGAJlZQ=
X-Google-Smtp-Source: APBJJlFb9KXGI0y8sSeu+2CMZbP9koLthLQiycvsdK6ENDZF6BZzXHwTqH7ra72NJA489+u8PclGU40HHEfJfA0ccMA=
X-Received: by 2002:a17:906:51db:b0:994:1808:a353 with SMTP id
 v27-20020a17090651db00b009941808a353mr1662084ejk.6.1689261707365; Thu, 13 Jul
 2023 08:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230703080252.2899090-1-michal.wilczynski@intel.com> <20230703080252.2899090-8-michal.wilczynski@intel.com>
In-Reply-To: <20230703080252.2899090-8-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Jul 2023 17:21:36 +0200
Message-ID: <CAJZ5v0hxr1h3HVq-Q5QRos3J7mDVNv0rYEZ0O1x5dfxfYeuD+Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/9] acpi/nfit: Move handler installing logic to driver
To:     Michal Wilczynski <michal.wilczynski@intel.com>,
        dan.j.williams@intel.com
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        vishal.l.verma@intel.com, lenb@kernel.org, dave.jiang@intel.com,
        ira.weiny@intel.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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

On Mon, Jul 3, 2023 at 10:03 AM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
>
> Call acpi_dev_install_notify_handler() at the end of .add() callback.
> Call acpi_dev_remove_notify_handler() at the beginning of
> acpi_nfit_shutdown(). Change arguments passed to the notify function to
> match with what's required by acpi_dev_install_notify_handler(). Remove
> .notify callback initialization in acpi_driver.
>
> Introduce a new devm action acpi_nfit_remove_notify_handler.
>
> Move acpi_nfit_notify() upwards in the file, so it can be used inside
> acpi_nfit_add() and acpi_nfit_remove_notify_handler().

Dan, any objections?

> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 41 +++++++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 07204d482968..124e928647d3 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3282,6 +3282,24 @@ static void acpi_nfit_put_table(void *table)
>         acpi_put_table(table);
>  }
>
> +static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
> +{
> +       struct acpi_device *adev = data;
> +
> +       device_lock(&adev->dev);
> +       __acpi_nfit_notify(&adev->dev, handle, event);
> +       device_unlock(&adev->dev);
> +}
> +
> +static void acpi_nfit_remove_notify_handler(void *data)
> +{
> +       struct acpi_device *adev = data;
> +
> +       acpi_dev_remove_notify_handler(adev,
> +                                      ACPI_DEVICE_NOTIFY,
> +                                      acpi_nfit_notify);
> +}
> +
>  void acpi_nfit_shutdown(void *data)
>  {
>         struct acpi_nfit_desc *acpi_desc = data;
> @@ -3368,7 +3386,20 @@ static int acpi_nfit_add(struct acpi_device *adev)
>
>         if (rc)
>                 return rc;
> -       return devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +
> +       rc = devm_add_action_or_reset(dev, acpi_nfit_shutdown, acpi_desc);
> +       if (rc)
> +               return rc;
> +
> +       rc = acpi_dev_install_notify_handler(adev,
> +                                            ACPI_DEVICE_NOTIFY,
> +                                            acpi_nfit_notify);
> +       if (rc)
> +               return rc;
> +
> +       return devm_add_action_or_reset(dev,
> +                                       acpi_nfit_remove_notify_handler,
> +                                       adev);
>  }
>
>  static void acpi_nfit_remove(struct acpi_device *adev)
> @@ -3446,13 +3477,6 @@ void __acpi_nfit_notify(struct device *dev, acpi_handle handle, u32 event)
>  }
>  EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>
> -static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
> -{
> -       device_lock(&adev->dev);
> -       __acpi_nfit_notify(&adev->dev, adev->handle, event);
> -       device_unlock(&adev->dev);
> -}
> -
>  static const struct acpi_device_id acpi_nfit_ids[] = {
>         { "ACPI0012", 0 },
>         { "", 0 },
> @@ -3465,7 +3489,6 @@ static struct acpi_driver acpi_nfit_driver = {
>         .ops = {
>                 .add = acpi_nfit_add,
>                 .remove = acpi_nfit_remove,
> -               .notify = acpi_nfit_notify,
>         },
>  };
>
> --
