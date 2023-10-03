Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13E67B7103
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbjJCSgY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjJCSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:36:22 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887E95;
        Tue,  3 Oct 2023 11:36:19 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c61dd1c229so263909a34.0;
        Tue, 03 Oct 2023 11:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358178; x=1696962978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy90cq1kuMyI11xZOKPFY3MxuNUWTItrB3fMlvJOfd4=;
        b=O9dLGlfaQu9dsp0LkMFVvkMVK9NXoFp9BD2ib+m6UkECPMwgttPL9+hxP1bK0bLuzy
         Ll/QY+gYRGA5g0chO+WX8vAOiJaAgc12ROBambSLISHZp2GxTr6O/Yyv6pDFMK3OsHW/
         +Bi99lprj7takUSJnKSn+iUBKB0O1lG2gWC6+VzPoLT3kD9eEKUF8ufYKnP7CHF2eKbO
         91CF6RVFvIJb4UocHewnnscmiWnvNoyMnqe7DxZ9JEYyjQD195KbvCOqn8SZNaYJyGoo
         EbfFboOlKix6iDKLaa3IAuY1jGL8FeqVwg8kgpPVgP8qAZvcctJGDkI9bFwfopHWCnpy
         dtuQ==
X-Gm-Message-State: AOJu0YwyLxHy/E3OJf7rhHDI1LKLmNSgqTwbF9GpkyP//WJjEfkKjdYb
        LHoUrFgQRJXKi0srNIdSF9TGpgrfvyBZtObenjU=
X-Google-Smtp-Source: AGHT+IFOz8NfzaTm+TQNu/A6JnOferW/Rsbvp5a+Se/KmXjyxbJucR7lDLEgD8KYWY1iGfGprX4gu2qrFiskX8eQ040=
X-Received: by 2002:a05:6808:2286:b0:3ae:100d:5320 with SMTP id
 bo6-20020a056808228600b003ae100d5320mr386644oib.2.1696358178605; Tue, 03 Oct
 2023 11:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230929202055.12724-1-linux@zary.sk>
In-Reply-To: <20230929202055.12724-1-linux@zary.sk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 20:36:07 +0200
Message-ID: <CAJZ5v0gqywy7o69fD4F4Snjb5Oh1Z44GD=C_WfkiSyW7NrxsGw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_ACPI=3A_video=3A_Add_acpi=5Fbacklight=3Dvendor_q?=
        =?UTF-8?Q?uirk_for_Toshiba_Port=C3=A9g=C3=A9_R100?=
To:     Ondrej Zary <linux@zary.sk>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 29, 2023 at 10:21 PM Ondrej Zary <linux@zary.sk> wrote:
>
> Toshiba Portégé R100 has both acpi_video and toshiba_acpi vendor
> backlight driver working. But none of them gets activated as it has
> a VGA with no kernel driver (Trident CyberBlade XP4m32).
>
> The DMI strings are very generic ("Portable PC") so add a custom
> callback function to check for Trident CyberBlade XP4m32 PCI device
> before enabling the vendor backlight driver (better than acpi_video
> as it has more brightness steps).
>
> Fixes: 5aa9d943e9b6 ("ACPI: video: Don't enable fallback path for creating ACPI backlight by default")
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/acpi/video_detect.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 442396f6ed1f..31205fee59d4 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -130,6 +130,16 @@ static int video_detect_force_native(const struct dmi_system_id *d)
>         return 0;
>  }
>
> +static int video_detect_portege_r100(const struct dmi_system_id *d)
> +{
> +       struct pci_dev *dev;
> +       /* Search for Trident CyberBlade XP4m32 to confirm Portégé R100 */
> +       dev = pci_get_device(PCI_VENDOR_ID_TRIDENT, 0x2100, NULL);
> +       if (dev)
> +               acpi_backlight_dmi = acpi_backlight_vendor;
> +       return 0;
> +}
> +
>  static const struct dmi_system_id video_detect_dmi_table[] = {
>         /*
>          * Models which should use the vendor backlight interface,
> @@ -270,6 +280,22 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 },
>         },
>
> +       /*
> +        * Toshiba Portégé R100 has working both acpi_video and toshiba_acpi
> +        * vendor driver. But none of them gets activated as it has a VGA with
> +        * no kernel driver (Trident CyberBlade XP4m32).
> +        * The DMI strings are generic so check for the VGA chip in callback.
> +        */
> +       {
> +        .callback = video_detect_portege_r100,
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Portable PC"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "Version 1.0"),
> +               DMI_MATCH(DMI_BOARD_NAME, "Portable PC")
> +               },
> +       },
> +
>         /*
>          * Models which need acpi_video backlight control where the GPU drivers
>          * do not call acpi_video_register_backlight() because no internal panel
> --

Applied as 6.7 material, thanks!
