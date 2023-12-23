Return-Path: <linux-kernel+bounces-10377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09881D381
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A577B21BF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC7CA5C;
	Sat, 23 Dec 2023 10:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="KsFZZxp+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BECA48
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:429:0:640:5a1a:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTP id DA6516143E;
	Sat, 23 Dec 2023 13:06:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 36N4Fpsm5Cg0-WtRmrpap;
	Sat, 23 Dec 2023 13:06:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1703325965; bh=A3ycyWTBajQnJsjcF9WYkiyN59WPkKLViyNv/IMfH38=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=KsFZZxp+DAMTBwZiy71wXED/drennhqFuea/IulxHyHM07TdynMaM07WDf9/wN8Lt
	 I4YzEcZk7kQfGL4GKktlFrIPzhX2lTIjLsK6SathnhuhrPorwGqMKGkEglqvr0w89H
	 OH7zHZ62oleV38BQJRHUbcxSERVVR8bRYTolqm/g=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <e0be87889c7d2a79e0d559ffcf9b08888f994b08.camel@maquefel.me>
Subject: Re: [PATCH v6 08/40] soc: Add SoC driver for Cirrus ep93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Joel Stanley <joel@jms.id.au>, Walker Chen
 <walker.chen@starfivetech.com>, Jonathan =?ISO-8859-1?Q?Neusch=E4fer?=
 <j.neuschaefer@gmx.net>, Huisong Li <lihuisong@huawei.com>, Arnd Bergmann
 <arnd@arndb.de>, Wei Xu <xuwei5@hisilicon.com>, Emil Renner Berthing
 <kernel@esmil.dk>, Linus Walleij <linus.walleij@linaro.org>, Alexander
 Sverdlin <alexander.sverdlin@gmail.com>, Hal Feng
 <hal.feng@starfivetech.com>,  linux-kernel@vger.kernel.org
Date: Sat, 23 Dec 2023 13:06:04 +0300
In-Reply-To: <ZXn51mcYslZzQ3y-@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	 <20231212-ep93xx-v6-8-c307b8ac9aa8@maquefel.me>
	 <ZXn51mcYslZzQ3y-@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 20:37 +0200, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 11:20:25AM +0300, Nikita Shubin wrote:
> > Add an SoC driver for the ep93xx. Currently there is only one thing
> > not fitting into any other framework, and that is the swlock
> > setting.
>=20
> ...
>=20
> > +/*
> > + * SoC driver for Cirrus EP93xx chips.
> > + * Copyright (C) 2022 Nikita Shubin <nikita.shubin@maquefel.me>
> > + *
> > + * Based on a rewrite of arch/arm/mach-ep93xx/core.c
> > + * Copyright (C) 2006 Lennert Buytenhek <buytenh@wantstofly.org>
> > + * Copyright (C) 2007 Herbert Valerio Riedel <hvr@gnu.org>
> > + *
> > + * Thanks go to Michael Burian and Ray Lehtiniemi for their key
> > + * role in the ep93xx Linux community
>=20
> Missing period.
>=20
> > + */
>=20
> ...
>=20
> > +#include <linux/bits.h>
> > +#include <linux/init.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/platform_device.h>
>=20
> Isn't this an incorrect header and should be auxiliary one?

This is still a platform driver, pinctrl, clk and reset are auxiliary
ones.

>=20
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
>=20
> + spinlock.h ?
>=20
> But since it's a new code, why not cleanup.h?
>=20
> > +#include <linux/sys_soc.h>
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum ep93xx_soc_model model =
=3D
> > (int)(uintptr_t)of_device_get_match_data(&pdev->dev);
>=20
> int?
>=20
> Maybe
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strict device *dev =3D &p=
dev->dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum ep93xx_soc_model mod=
el;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0model =3D (enum
> ep93xx_soc_model)(uintptr_t)device_get_match_data(dev);
>=20
> ?
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D &pdev=
->dev;
>=20
> Ah you even have this already!
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_info(dev, "EP93xx SoC re=
vision %s\n", attrs->revision);
>=20
> Hmm... Is this message anyhow useful?
>=20

Can we keep it please ? It makes us happy when we see it in logs for
historical reasons - it's been there since 2.4.

