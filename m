Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3575B5AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjGTRdC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Jul 2023 13:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjGTRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:32:56 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C475D10FC;
        Thu, 20 Jul 2023 10:32:52 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-99b49e51f62so33697766b.1;
        Thu, 20 Jul 2023 10:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874371; x=1690479171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7T5HNwRHzExJ+6WQXE/C5RIMl/1/7UGFVhFvWScmu0=;
        b=GKKzGoxOQ6q0uv5x9XhPmylXczJVmMfW8BFJevyxRjOMjkcnoVHnJKBXbgVwZk1eQX
         IZ6O7UQpCDuG95cqkHKiR+WHYdiQRhAupQrQ4Wx39eK/TUAdNeqLtRFVAWL64nwIdbOy
         R1R7z0I1t2XqqBt4uwOwQ9PLDaF5J0pZFj9/fpczVaRBvNdZ4jRCSpUMdEk0XvLc6ubi
         UfBeZeVWTjqMav4pEJwsDoi8Whmm2VqK6U1y7Cn/Ve5AQ7KuhXLaDWFZ7lvfkIfTppNR
         5Thm3lIft537fUbwj0p2HQfil5NGyHs4ep4Aa+uNjh5RXYAUbNxSHQjr14RPSvd2MBIV
         +1Lg==
X-Gm-Message-State: ABy/qLb3Ct6o6rxgbGtoDpucQBXySXwIRMS49y2L7ByBi+IWj9FpVzEt
        3GbRy/koVqALxCthboV3QzsiayGTX3GH/dg9wbsj/ESDt6w=
X-Google-Smtp-Source: APBJJlHJ/EvszG8Kf1nCTMWu349JzgjYjlWJlJd+pdOh6jdOjPA7P6uWCuq3aKuBusyZmoNV+11qiQTjUxna6ie3SJU=
X-Received: by 2002:a17:906:535b:b0:997:d069:a880 with SMTP id
 j27-20020a170906535b00b00997d069a880mr2479278ejo.1.1689874371008; Thu, 20 Jul
 2023 10:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230719023223.2971481-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230719023223.2971481-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 20 Jul 2023 19:32:39 +0200
Message-ID: <CAJZ5v0g4ngM4Z_nvzMfdgsMjjjc2QXkr-ZGxZBzDufbrqO6Kvw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Put ACPI video and its child devices to
 D0 at boot
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     rafael@kernel.org, lenb@kernel.org, hdegoede@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 19, 2023 at 4:33 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Screen brightness can only be changed once on some HP laptops.
>
> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> for all ACPI devices:

No, it doesn't and it won't.  For the reason why please see the
comment in acpi_bus_init_power().

BTW, missing _PSC for a device that has _PS0 violates Section 7.3.6.
_PSC (Power State Current) of the ACPI specification, so this is a
platform firmware problem.

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
> _PS0 doesn't get invoked for all ACPI devices because of commit
> 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
> during initialization"). For now use acpi_device_fix_up_power_extended()
> to put ACPI video and its child devices to D0 to workaround the issue.

The above paragraph is misleading the reader into thinking that the
issue was introduced by a kernel change while the issue really is
there in the platform firmware and it is the missing _PSC.

Blaming kernel changes for platform firmware defects is not really productive.

So this really is a workaround for defective platform firmware on the
affected systems and it should be documented as such.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217683
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2:
>  - Wording
>  - Bugzilla
>  - Add comment
>
>  drivers/acpi/acpi_video.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 62f4364e4460..bac614e9fe56 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2027,6 +2027,13 @@ static int acpi_video_bus_add(struct acpi_device *device)
>         if (error)
>                 goto err_put_video;
>
> +
> +       /*
> +        * Some HP laptops require ACPI video's child devices have _PS0
> +        * evaluated to have functional panel brightness control.

So the comment should mention the platform firmware defect and it
shouldn't say "some" but explicitly identify the defective platforms.

> +        */
> +       acpi_device_fix_up_power_extended(device);
> +

And the code change itself is simple enough, so it can be made as long
as it is fine with Hans.

>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>                video->flags.multihead ? "yes" : "no",
> --
