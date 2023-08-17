Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACE777FC0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352612AbjHQQ0K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 12:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353688AbjHQQZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:25:48 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3235A0;
        Thu, 17 Aug 2023 09:25:17 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-56e280cc606so5185eaf.1;
        Thu, 17 Aug 2023 09:25:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692289475; x=1692894275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBBBHCM2okzA85vCsBAXaRkTASvm3O3EAAP4Nr5CObQ=;
        b=E6tSIcSVZEkhyo/wx4xbOkLj+L8kBMTgZAJbR33gba5SQ2rFzlIEnrI+Rdoy5Q6tFi
         +Jdj//hHc+8gY2w8unDClEwfN1yBqj1EUvOKrYzopvV9veLtUdd6LbyQKvZSm+nniwRb
         Uo8OOTfOLxjSdEb/gDEcA2RywL8HTBp405KF3NPo/cNXX6L3VnKDlilcxIjOc03D4Lub
         CpikVzSL+A1mgGdoB+JFNTI/RuS8VDIaAnC2xTMotiP15I2PplU4OiV7xOrW6kPJwawt
         E8eGCEso5VcZ6K7VBKCLhGv2tcDbMkWet7LOhKPAo41EdeUPpupqqcXqLVWZ9bc7GOdf
         ZUjg==
X-Gm-Message-State: AOJu0Yz9I2VQWUmQHsUPvpWPaPri2OEoj10lpY45pudI59j5ywiC66m5
        2TcTIlWWhhGXex+M6wI4r3k58wRI/1WUX/m+34o=
X-Google-Smtp-Source: AGHT+IHmB8LvuyQMhT+BbqoPdh2FW8j6LBRbkY7adbl/KChJqESzuYS//cTk0uEV7J22TETXJodYBJVm2Hwhv7Gc3b8=
X-Received: by 2002:a4a:e0cd:0:b0:56e:72e0:9c5f with SMTP id
 e13-20020a4ae0cd000000b0056e72e09c5fmr209182oot.1.1692289474487; Thu, 17 Aug
 2023 09:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230728183921.17230-1-mario.limonciello@amd.com>
In-Reply-To: <20230728183921.17230-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 18:24:22 +0200
Message-ID: <CAJZ5v0iDJtTjZXB3HLZgLX2tLF5DW8Da2-S77zDLsBvH1A1kpA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev,
        August Wikerfors <git@augustwikerfors.se>,
        Hans de Goede <hdegoede@redhat.com>
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

On Fri, Jul 28, 2023 at 8:58 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
> is incorrect in the MADT and the value from the DSDT should be used.
>
> Reported-by: August Wikerfors <git@augustwikerfors.se>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Is this still needed after the recent changes from Hans?

> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 1dd8d5aebf678..1a826419d5837 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -481,6 +481,17 @@ static const struct dmi_system_id lg_laptop[] = {
>         { }
>  };
>
> +static const struct dmi_system_id lenovo_laptop[] = {
> +       {
> +               .ident = "Lenovo Yoga 7 14ARB7",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
> +               },
> +       },
> +       { }
> +};
> +
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
> @@ -494,6 +505,7 @@ static const struct irq_override_cmp override_table[] = {
>         { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +       { lenovo_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false}
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --
> 2.34.1
>
