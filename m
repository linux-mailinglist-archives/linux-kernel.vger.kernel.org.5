Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB079F2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjIMUXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjIMUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:23:50 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A645C1BC8;
        Wed, 13 Sep 2023 13:23:45 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7AC2E240009;
        Wed, 13 Sep 2023 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694636623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dRlWZ4ip0P9gSRRVNtyMvezGlxc/WATurc5AdssgGA=;
        b=ow2wxZiMqZilFqKiQdViBBKXgJ10OFn4QutLDJ8h5iKbCLUYsMCpLYwz44g75okO+hVLKP
        fYAPH+Hipn+rJTW6OyvP5lnO3oBKBsUsGvAQ0BEQ0ZfwJwOKn97N+YEPNXgZx+tVi+QEoM
        UaTSLemyUL/EQjpuVLvEgCyBrWG2xCkxiwdjZycMqoB+iord0lk4UQWV5M7DtX7kEnFaHD
        kEfNXSKmxUZyO3fmf798qZoTx2rc8/tti4htwWlIYYKUdSMQrJLoPh/6SWJqWoCZYZrgsW
        a6SKSmbf6HDufOEoQxAp83NCom5LQ0HSbs2RYME0xMhTOK30Q2SNNixNySpdEw==
Date:   Wed, 13 Sep 2023 22:23:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Scally <djrscally@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mtd@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
Message-ID: <20230913222338.07d1625b@xps-13>
In-Reply-To: <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com>
References: <20230913115001.23183-1-brgl@bgdev.pl>
        <20230913115001.23183-3-brgl@bgdev.pl>
        <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
        <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

linus.walleij@linaro.org wrote on Wed, 13 Sep 2023 22:12:40 +0200:

> On Wed, Sep 13, 2023 at 10:05=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Sep 13, 2023 at 2:50=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote: =20
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Use the new, less cumbersome interface for setting the GPIO as
> > > active-high that doesn't require first checking the current state. =20
> >
> > ...
> > =20
> > >          * here for older DTs so we can re-use the generic nand_gpio_=
waitrdy()
> > >          * helper, and be consistent with what other drivers do.
> > >          */
> > > -       if (of_machine_is_compatible("qi,lb60") &&
> > > -           gpiod_is_active_low(nand->busy_gpio))
> > > -               gpiod_toggle_active_low(nand->busy_gpio);
> > > +       if (of_machine_is_compatible("qi,lb60"))
> > > +               gpiod_set_active_high(nand->busy_gpio); =20
> >
> > Why not moving this quirk to gpiolib-of.c? =20
>=20
> That's a better idea here I think, it's clearly a quirk for a
> buggy device tree.

Agreed, it's just for backward compatibility purposes in a single
driver. I believe it should stay here.

Thanks,
Miqu=C3=A8l
