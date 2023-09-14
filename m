Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E679FE6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjINIaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbjINIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:30:22 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E4BCD8;
        Thu, 14 Sep 2023 01:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1694680215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3QNlCsd4KrtdLCl8FujpLR9D66KZlMKVr8PFtC9Zj8=;
        b=tIBeXCzmhsYqsWsjrwpnqguwuBD5fXYC/Eb4uuoG7n3c3EEb7DyvSU4Y9dpM1IUgC0bySP
        sG97FPryrWMEsDiLl/oJcqji3jRNgnJ6zBwkJCJXtRnpV2RmtcooQ8L6WNXv9o0oMYkE9c
        SXsy27g2omhA+TmEn9Kgnnz6BYKzv5U=
Message-ID: <4de724a1630eda74f4f304dc224dc981eb3b0875.camel@crapouillou.net>
Subject: Re: [PATCH 2/5] mtd: rawnand: ingenic: use gpiod_set_active_high()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
Date:   Thu, 14 Sep 2023 10:30:13 +0200
In-Reply-To: <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
References: <20230913115001.23183-1-brgl@bgdev.pl>
         <20230913115001.23183-3-brgl@bgdev.pl>
         <CAHp75Ve8aK4Pfid1JYWH86mKy-Zb-G2QDPrJYmRzPCYOsn1TqQ@mail.gmail.com>
         <CACRpkdYtYDJa6fo6RnizHNzUsyazBQxEaNMznaij8rBF4ie+ew@mail.gmail.com>
         <20230913222338.07d1625b@xps-13>
         <CAHp75Vd2a06rnGCEiJW0reN00amso0RyvgLT516nZiYLYZ-xcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 14 septembre 2023 =C3=A0 10:02 +0300, Andy Shevchenko a =C3=A9crit=
=C2=A0:
> On Wed, Sep 13, 2023 at 11:23=E2=80=AFPM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
> > linus.walleij@linaro.org=C2=A0wrote on Wed, 13 Sep 2023 22:12:40 +0200:
> > > On Wed, Sep 13, 2023 at 10:05=E2=80=AFPM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Sep 13, 2023 at 2:50=E2=80=AFPM Bartosz Golaszewski
> > > > <brgl@bgdev.pl> wrote:
>=20
> ...
>=20
> > > > Why not moving this quirk to gpiolib-of.c?
> > >=20
> > > That's a better idea here I think, it's clearly a quirk for a
> > > buggy device tree.
> >=20
> > Agreed, it's just for backward compatibility purposes in a single
> > driver. I believe it should stay here.
>=20
> I believe Linus was for moving.

Which Linus? Because the one who's also the gpio maintainer just wrote
above that it was better to keep it in the driver.

Cheers,
-Paul

>=20
> gpiolib-of.c contains a lot of quirks, including this one. Calling
> these new (or old) APIs for overriding polarity in many cases
> shouldn't be needed if were no issues with DT or something like that.
>=20

