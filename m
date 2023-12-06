Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02421807916
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442847AbjLFUBC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 15:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379471AbjLFUBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:01:00 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37BD6D;
        Wed,  6 Dec 2023 12:01:05 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-58de9deec94so15618eaf.0;
        Wed, 06 Dec 2023 12:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701892865; x=1702497665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voGLwO6rmAuNQZR2QcfhsiCq3DHL2t4UHHcQfpvAbW0=;
        b=NM4IN/LmkHLHJ/IkolKy1R7HucHdKLugHmgif2OFxHu/aPGlFQNstTb4fz3yfLEmtL
         +TpT8OmVvQXWWX1FT4YcUbNz7JrpIVo/57gDm1eHrGcedhJBepLFFrzV2ZOpxnqeMlM0
         KTiVVm/erU/CEJMfHYGht/kwBsbSFXciwO8o6T+KTJrYOUgW58/V6KFSR1m/jsmkHjMs
         BfvOGaC/0IZXpOWS6o5jtTuPteXtP149teRdUtS1HKRImF+fbORlSCJwnier/QUVzUut
         wvbHhbXB0pfsGzL1UC7AlCEtIcxatY4TaFgmI7Ac8CSFTEBREW+x8flrcaWQcQ0/Dwio
         aEVg==
X-Gm-Message-State: AOJu0YyqTi05xfwU0+PguamtHujs84CIC9/ESq6tF9wZLcMGYOnoivsy
        YPMYnXlCWN0j6SX8oKGIp73q8vurB6a/Z0N1kr0=
X-Google-Smtp-Source: AGHT+IHOjxMQIim+NAH4ehno9AKpR5Nu9pb7TM8dBQKiP/cNoCb67G/rcPvqa1hkAJ3Vf35k3jgyTa4Y4dYwrw3R6eY=
X-Received: by 2002:a05:6870:35ce:b0:1fa:60b0:9d9 with SMTP id
 c14-20020a05687035ce00b001fa60b009d9mr2792857oak.1.1701892865078; Wed, 06 Dec
 2023 12:01:05 -0800 (PST)
MIME-Version: 1.0
References: <OS3P286MB1951B46E88AB4A91E47A2696BDBEA@OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OS3P286MB1951B46E88AB4A91E47A2696BDBEA@OS3P286MB1951.JPNP286.PROD.OUTLOOK.COM>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Dec 2023 21:00:53 +0100
Message-ID: <CAJZ5v0gR3v3rs5nk5B61TjY8+sYeOGWD_uNBY4SKXEL0Qi4jZQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/video: Add quirk for the Colorful X15 AT 23 Laptop
To:     Yuluo Qiu <qyl27@outlook.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Celeste Liu <CoelacanthusHex@gmail.com>
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

On Sun, Nov 26, 2023 at 3:00 PM Yuluo Qiu <qyl27@outlook.com> wrote:
>
> The Colorful X15 AT 23 ACIP video-bus device report spurious
> ACPI_VIDEO_NOTIFY_CYCLE events resulting in spurious KEY_SWITCHVIDEOMODE
> events being reported to userspace (and causing trouble there) when
> an external screen plugged in.
>
> Add a quirk setting the report_key_events mask to
> REPORT_BRIGHTNESS_KEY_EVENTS so that the ACPI_VIDEO_NOTIFY_CYCLE
> events will be ignored, while still reporting brightness up/down
> hotkey-presses to userspace normally.
>
> Signed-off-by: Yuluo Qiu <qyl27@outlook.com>
> Co-developed-by: Celeste Liu <CoelacanthusHex@gmail.com>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> ---
>  drivers/acpi/acpi_video.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index d321ca7160d9..c54a364ffff3 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -503,6 +503,15 @@ static const struct dmi_system_id video_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
>                 },
>         },
> +       {
> +        .callback = video_set_report_key_events,
> +        .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
> +        .ident = "COLORFUL X15 AT 23",
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
> +               },
> +       },
>         /*
>          * Some machines change the brightness themselves when a brightness
>          * hotkey gets pressed, despite us telling them not to. In this case
> --

Applied as 6.8 material, thanks!
