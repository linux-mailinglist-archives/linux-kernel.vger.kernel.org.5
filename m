Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C635C763E96
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjGZSe1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 14:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGZSe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:34:26 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389C26A6;
        Wed, 26 Jul 2023 11:34:25 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5671db01ee0so17558eaf.1;
        Wed, 26 Jul 2023 11:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396464; x=1691001264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOnTsM7a3cFSdlS6WfiIYIlbUyN4/ClgkUHf/cbi78E=;
        b=hVNOPiI7iUrVKopaNgkVA3Vml2uqqGiEFenwE67ttrclS6af8Uh0uyfwgzrIdmw66c
         XYnnipEiJTBTyRVwf7CoBmSplOsDam+REGPoYChk2efYKL6yrY89R7G3UDro+hno05T2
         cZhrqAR1BeWdIAF7PKLNLxOjUtNScRlQa8xuVFvatoeatea8g9JCHEMS24ds8WOrNDFL
         20vU/+H28IonYxjHhbiIRwtuVvPoA32pPq7jW9h5LJUOPeTvMAnR/zLydaDzhFL4UUB3
         bq4QQ3iCr9hiavTTF9vGiFeqTBKIPc30Jl8p/0Nsl7Z4LaLbzZJ5UDJiCTcTdi2rluEW
         N8NQ==
X-Gm-Message-State: ABy/qLbEyzQsRKaarlwGir5NFc5CAi9YNt0szEEHnjmeBb5g/7avmCdh
        XuzL8Olo5qFR94Z6HLzKAWrspJ+4dgaZMqaAwGyEqY0N
X-Google-Smtp-Source: APBJJlGGZgwVpKDbvbnPzNymJ/4cNCne6LH/SypiHat8HrSUEP+a6BG4CcR3gSbrf83Ff+ioYKqIPpkL+by2yLgyjs8=
X-Received: by 2002:a4a:c449:0:b0:566:951e:140c with SMTP id
 h9-20020a4ac449000000b00566951e140cmr2181640ooq.1.1690396464243; Wed, 26 Jul
 2023 11:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230726112759.18814-1-rf@opensource.cirrus.com> <33cdbf63-8fe4-da7e-5d36-6e63fe303b24@redhat.com>
In-Reply-To: <33cdbf63-8fe4-da7e-5d36-6e63fe303b24@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 20:34:13 +0200
Message-ID: <CAJZ5v0hGSqOvnLMhpiC42Rx4YBrs0OKDhh9iRTNnR4BX0JDmDQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Create platform device for CS35L56
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Richard Fitzgerald <rf@opensource.cirrus.com>, rafael@kernel.org,
        lenb@kernel.org, markgross@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 4:13 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Richard,
>
> On 7/26/23 13:27, Richard Fitzgerald wrote:
> > From: Simon Trimmer <simont@opensource.cirrus.com>
> >
> > The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
> > is used in multiples, and can be connected either to I2C or SPI.
> >
> > There will be multiple instances under the same Device() node. Add it
> > to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
> > driver.
> >
> > Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> > Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>
> Thanks, patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>
> I have 1 other serial-multi-instantiate.c patches in my fixes branch (see below) and since this just adds new hw-ids I think this can go upstream through my fixes branch too.
>
> Rafael, do you agree with me taking this upstream as a 6.5 fix? And if yes may I have your ack for that ?

Sure.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> About that 1 patch, that adds a new IRQ type: IRQ_RESOURCE_AUTO and I wonder if this patch should not use that same new type right from the start:
>
> https://git.kernel.org/pub/scm/linux/kernel/agit/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=676b7c5ecab36274442887ceadd6dee8248a244f
>
> This makes me realize that I should probably have pinged you and ask for feedback on that patch since it was send by a community member rather then by Cirrus. Note this is currently in Linus' master tree, so any fixes to it need to be submitted on top (not that I expect any issues since it still behaves as before on acpi_dev_gpio_irq_get() success and only adds an platform_get_irq() fallback when that fails).
>
> Regards,
>
> Hans
>
>
>
> > ---
> >  drivers/acpi/scan.c                             |  1 +
> >  drivers/platform/x86/serial-multi-instantiate.c | 12 ++++++++++++
> >  2 files changed, 13 insertions(+)
> >
> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 5b145f1aaa1b..87e385542576 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1714,6 +1714,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
> >               {"BSG1160", },
> >               {"BSG2150", },
> >               {"CSC3551", },
> > +             {"CSC3556", },
> >               {"INT33FE", },
> >               {"INT3515", },
> >               /* Non-conforming _HID for Cirrus Logic already released */
> > diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> > index f3dcbdd72fec..dcf2914b97c9 100644
> > --- a/drivers/platform/x86/serial-multi-instantiate.c
> > +++ b/drivers/platform/x86/serial-multi-instantiate.c
> > @@ -316,6 +316,17 @@ static const struct smi_node cs35l41_hda = {
> >       .bus_type = SMI_AUTO_DETECT,
> >  };
> >
> > +static const struct smi_node cs35l56_hda = {
> > +     .instances = {
> > +             { "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> > +             { "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> > +             { "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> > +             { "cs35l56-hda", IRQ_RESOURCE_GPIO, 0 },
> > +             {}
> > +     },
> > +     .bus_type = SMI_AUTO_DETECT,
> > +};
> > +
> >  /*
> >   * Note new device-ids must also be added to ignore_serial_bus_ids in
> >   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> > @@ -324,6 +335,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
> >       { "BSG1160", (unsigned long)&bsg1160_data },
> >       { "BSG2150", (unsigned long)&bsg2150_data },
> >       { "CSC3551", (unsigned long)&cs35l41_hda },
> > +     { "CSC3556", (unsigned long)&cs35l56_hda },
> >       { "INT3515", (unsigned long)&int3515_data },
> >       /* Non-conforming _HID for Cirrus Logic already released */
> >       { "CLSA0100", (unsigned long)&cs35l41_hda },
>
