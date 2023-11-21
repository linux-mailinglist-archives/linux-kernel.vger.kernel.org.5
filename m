Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245267F36ED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 20:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjKUTtm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Nov 2023 14:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 14:49:41 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636B19B;
        Tue, 21 Nov 2023 11:49:38 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-587af6285c0so550692eaf.1;
        Tue, 21 Nov 2023 11:49:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700596177; x=1701200977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FRB8L2BFXCqVe1FSVyDwiIP934VPN4CvJ7Olvn+VsE=;
        b=DZLsoeuOeRQH9uA+J1JXkdNuArCgvCcEmucICo0mCyBr4OAW6Fl2Wv3l6rT4MJJCOJ
         r+hsFZ1gZT6wcLn+jf/AbMmay09KVNkGVJSOdyH5btOD9ZaIUaZkwYAQS0FPn5UbiM9S
         531uiG/3jGvuHaX22mw6HgxcAU5qMHrM7Y0Ft1FFtFFntA52C4DHceXcXBEVMueXKeJ1
         mg0kjTMVKkx6Oi+AV4vyOpTmRboFWe4hlLwDCJCE+vMS8WDdXY8/rzAEtyJ09QTlv3hK
         pMDbN/LKnCXNZiyG4c1UQIEYYAN7oJlVtIaagHZ/AgpWM+fHkfjqihLz4T6DZDQ4XJBh
         GpMw==
X-Gm-Message-State: AOJu0Yx2OBBZu4tJ7dELl9uTu1j0XwRofV/HSX8jVTfMTsF7yzoIVWtd
        Yg5nj/CcEcTdsSINoGGqrMDpbO0hQfGHvd3SqBfdXla5
X-Google-Smtp-Source: AGHT+IHszKON8c3K4slOi0TCGKHAR8YZMBGl01M49UO3RTDfMtrN2AMKaO/S2C3+gqH+beTHNY3LUeme1NyEwF8c/Jc=
X-Received: by 2002:a4a:d0b6:0:b0:586:abc4:2c18 with SMTP id
 t22-20020a4ad0b6000000b00586abc42c18mr512137oor.0.1700596177577; Tue, 21 Nov
 2023 11:49:37 -0800 (PST)
MIME-Version: 1.0
References: <262a7526-9e0a-4688-85b4-8546a6580ad0@ancud.ru>
In-Reply-To: <262a7526-9e0a-4688-85b4-8546a6580ad0@ancud.ru>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 21 Nov 2023 20:49:26 +0100
Message-ID: <CAJZ5v0h8GhHDguSuO2v05k15uQyYvNqUpO=Ott=t8-QdoueW4g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: check for error while searching for backlit
 device parent
To:     Nikita Kiryushin <kiryushin@ancud.ru>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Matthew Garrett <mjg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
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

On Thu, Nov 9, 2023 at 2:49 PM Nikita Kiryushin <kiryushin@ancud.ru> wrote:
>
> If acpi_get_parent called in acpi_video_dev_register_backlight fails
> (for example, acpi_ut_acquire_mutex fails inside acpi_get_parent),
> this can lead to incorrect (uninitialized) acpi_parent handler being
> passed to acpi_get_pci_dev for detecting parent pci device.
>
> Check acpi_get_parent result and set parent device only in case of success.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 9661e92c10a9 ("acpi: tie ACPI backlight devices to PCI devices if
> possible")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
>   drivers/acpi/acpi_video.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 0b7a01f38b65..1d550887349a 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1717,12 +1717,12 @@ static void
> acpi_video_dev_register_backlight(struct acpi_video_device *device)
>                 return;
>         count++;
>   -     acpi_get_parent(device->dev->handle, &acpi_parent);
> -
> -       pdev = acpi_get_pci_dev(acpi_parent);
> -       if (pdev) {
> -               parent = &pdev->dev;
> -               pci_dev_put(pdev);
> +       if (ACPI_SUCCESS(acpi_get_parent(device->dev->handle, &acpi_parent))) {
> +               pdev = acpi_get_pci_dev(acpi_parent);
> +               if (pdev) {
> +                       parent = &pdev->dev;
> +                       pci_dev_put(pdev);
> +               }
>         }
>         memset(&props, 0, sizeof(struct backlight_properties));
> --

Applied as 6.8 material with some minor adjustments in the subject and
changeolog, but please note that your mailer garbles the patch context
lines.

Thanks!
