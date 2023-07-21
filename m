Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7E975CC52
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjGUPqK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jul 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGUPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:46:08 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980F719A1;
        Fri, 21 Jul 2023 08:46:06 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-99b76201110so502266b.1;
        Fri, 21 Jul 2023 08:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689954365; x=1690559165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGvIa/xbSavlOQUbfsNYc+o6CuZLv/AsmDlHcyaG6tw=;
        b=Gvq6IP9GOoJYRGHk3sOKVCakNsxMyHcp7XCRi0EVA3T7Dsus9MMDuTotAWNRd9jsuv
         XC5ZhiFwe7MRdtNJwQkanZg03sXYkLoMWR1a6vG5Ru+exb+cdJGjmb9x6ZSEB1tXLICO
         i+SpjgorYyy98OiutSqUEuBIt9Wnje1fA1Q0mu5jrRRndYNgbHgEztg+FytXW3OlSqnF
         Zen8GxjfDguPNZmBsjadIJYL32FKykIM/uC3vwPLw6LbcHLnuXGOIvMm9EnDG7JPGS48
         ev4JyhBJND/RBwL6gt4XDVhJcG0M2nuUywj4tbw+2SjPI24dN//ZjFJTNoc/PxrEi6Bq
         kwKw==
X-Gm-Message-State: ABy/qLYVktjbDNEcX3/czt0Nko2UTdCY2+uqbBznyFzFzRiWifwlKZqm
        FA7KjCUZdBW3DreXvMoXeFVWSEp3lY6eePum31w=
X-Google-Smtp-Source: APBJJlHA7wRpEujJotjk7wbsJSyzNtc5iS9PhfO2eienfXnd1i5ITFRJeWo2qI/yIye/Zs4LgU98cLvGh5eW6ejlzos=
X-Received: by 2002:a17:906:518e:b0:974:5480:6270 with SMTP id
 y14-20020a170906518e00b0097454806270mr1724059ejk.0.1689954364736; Fri, 21 Jul
 2023 08:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230721152143.3108017-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230721152143.3108017-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 21 Jul 2023 17:45:53 +0200
Message-ID: <CAJZ5v0j=ohJ_oUpCY-F_joty9qq3Mz2Bigqa3dHaFaWP2k6ONQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: video: Put ACPI video and its child devices to
 D0 at boot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, hdegoede@redhat.com
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update!

On Fri, Jul 21, 2023 at 5:22 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Screen brightness can only be changed once on HP ZBook Fury 16 G10.
>
> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> for all ACPI devices:
>
>     Scope (\_SB.PC00.GFX0)
>     {
>         Scope (DD1F)
>         {
>             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
>             {
>                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
>                 {
>                     \_SB.PC00.LPCB.EC0.SSBC ()
>                 }
>             }
>             ...
>         }
>         ...
>     }
>
> The \_SB.PC00.GFX0.DD1F is the panel device, and its _PS0 needs to be
> executed to make the brightness control work properly.
>
> _PS0 doesn't get invoked for this device because _PSC is missing,
> which violates ACPI spec 6.3, section 7.3.6. Commit 7cd8407d53ef
> ("ACPI / PM: Do not execute _PS0 for devices without _PSC during
> initialization") tried to workaround missing _PSC on defective
> firmwares, but got reverted because of regression.
>
> So the safest approach is to use acpi_device_fix_up_power_extended() to
> put ACPI video and its child devices to D0 to workaround the issue.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217683
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Hans, what do you think?

> ---
> v3:
>  - Wording change to make it clear it's a firmware issue.
>  - Specify the device name in comment.
>
> v2:
>  - Wording
>  - Bugzilla
>  - Add comment
>
>  drivers/acpi/acpi_video.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 62f4364e4460..1732780a672b 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2027,6 +2027,12 @@ static int acpi_video_bus_add(struct acpi_device *device)
>         if (error)
>                 goto err_put_video;
>
> +       /*
> +        * HP ZBook Fury 16 G10 requires ACPI video's child devices have _PS0
> +        * evaluated to have functional panel brightness control.
> +        */
> +       acpi_device_fix_up_power_extended(device);
> +
>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>                video->flags.multihead ? "yes" : "no",
> --
> 2.34.1
>
