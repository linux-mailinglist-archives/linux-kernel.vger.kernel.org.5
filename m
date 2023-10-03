Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6720E7B712A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbjJCSj2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240807AbjJCSj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:39:26 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6890;
        Tue,  3 Oct 2023 11:39:23 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b68555467so115922eaf.0;
        Tue, 03 Oct 2023 11:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696358363; x=1696963163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojh0GlprYqfF4cES3KrVg8rZgISvukWPZ0bGNIr9lsc=;
        b=en8U3/kHZ14ldFsqt6niKdDBC6pd+EZ8H0cN6Z1ZDTESRKSzWGd1B3WIDOvtOFCVAa
         ho2xti13uc2unMz3oEHaZiQ1gOG7rbqXUiJxjthDtMEjB9tyrYxnwJ8WTS0MuY6LVyty
         IzpZF8tQ/27az2Hw085nLJe8jx9wmkQ7f/19g0tp1PaNitBzQFZtT7T/ogiwEqD1LOYL
         p4XufJomWxDCL/x27xIMhKCdmwBGPFXMwCb9NZHpl31hauZv0nj31LUXpy3v7ERuq2/4
         wd4uuy7wxGTRMpSLoj14kKCcE7H0O9JktsXAuDkhL/sceHJ8rdR8x8llNDACpajdsZLy
         vvzw==
X-Gm-Message-State: AOJu0YzY3PaloRvS7fplaGA7bPZJYjXmzc/hGGMl/oQGJkcKLY/R9V7e
        FnafjaYiHZCswhsaI8+kFHsnDN9StwdM17M7IqDetZsO
X-Google-Smtp-Source: AGHT+IGIPULYGzQU1uU2lrfZfjw8XgoLLWATNuwr7it5GWVlqYL9FcAZaNIzPNZ2SUaDhSa0Ts+6j6eYn8cl97w/rPk=
X-Received: by 2002:a4a:df07:0:b0:57b:73f6:6f80 with SMTP id
 i7-20020a4adf07000000b0057b73f66f80mr245642oou.0.1696358363021; Tue, 03 Oct
 2023 11:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230929134010.25644-1-wse@tuxedocomputers.com>
In-Reply-To: <20230929134010.25644-1-wse@tuxedocomputers.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Oct 2023 20:39:11 +0200
Message-ID: <CAJZ5v0iH4PGaCdSuQ-4Pu7oXbzrw+zLxpEqMjtMgcNFextgfqw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Do IRQ override on TongFang GMxXGxx
To:     Werner Sembach <wse@tuxedocomputers.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 29, 2023 at 3:40 PM Werner Sembach <wse@tuxedocomputers.com> wrote:
>
> The TongFang GMxXGxx/TUXEDO Stellaris/Pollaris Gen5 needs IRQ overriding
> for the keyboard to work. Adding an entry for this laptop to the
> override_table makes the internal keyboard functional again.

You said "again", so it used to work.  Do you know which commit broke it?

> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>

What's the oldest kernel version you want this to be applied to?

> ---
>  drivers/acpi/resource.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 32cfa3f4efd3d..3aff81820e321 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,13 +470,25 @@ static const struct dmi_system_id asus_laptop[] = {
>         { }
>  };
>
> -static const struct dmi_system_id tongfang_gm_rg[] = {
> +static const struct dmi_system_id tongfang_gm[] = {
>         {
>                 .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>                 .matches = {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>                 },
>         },
> +       {
> +               .ident = "TongFang GMxXGxx/TUXEDO Polaris 15 Gen5 AMD",
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
> +               },
> +       },
> +       {
> +               .ident = "TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD",
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6XGxX"),
> +               },
> +       },
>         { }
>  };
>
> @@ -536,7 +548,7 @@ struct irq_override_cmp {
>  static const struct irq_override_cmp override_table[] = {
>         { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +       { tongfang_gm, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>         { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>         { pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>         { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> --
> 2.34.1
>
