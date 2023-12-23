Return-Path: <linux-kernel+bounces-10352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE1581D33A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8302284E84
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 08:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADBC8F56;
	Sat, 23 Dec 2023 08:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="onQozyUB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200238BE5;
	Sat, 23 Dec 2023 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:4212:0:640:eaad:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTP id BDE0160FA8;
	Sat, 23 Dec 2023 11:55:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GtLkxf7Jg8c0-ngXbzi6F;
	Sat, 23 Dec 2023 11:55:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1703321717; bh=qDvMSV6PVH/nDhWHl+NvBmgQ0eTfsFDftxt+1k/0RyQ=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=onQozyUBVAqgQMnlccqsJaffI+Q4TWZMweFRkn3FM6AUwfw5HU9+mUWYtEqzX9CsS
	 V0omKjhdeuFBTssf6QT3s/I3mfRqim+gAR9icqhmaQgPr/lwvkOJwwURiwn17HdMG8
	 lQN3EbKhmVbBwKUkqUsFPrlqRyOmVsooZfJX31W8=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <26adbdb01f238b7fb74b2bcd110c1bdec77ab4bc.camel@maquefel.me>
Subject: Re: [PATCH v6 05/40] pinctrl: add a Cirrus ep93xx SoC pin controller
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date: Sat, 23 Dec 2023 11:55:17 +0300
In-Reply-To: <ZXnvHYjgnc3VsXnX@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
	 <20231212-ep93xx-v6-5-c307b8ac9aa8@maquefel.me>
	 <ZXnvHYjgnc3VsXnX@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Andy!

On Wed, 2023-12-13 at 19:51 +0200, Andy Shevchenko wrote:
> On Tue, Dec 12, 2023 at 11:20:22AM +0300, Nikita Shubin wrote:
> > Add a pin control (only multiplexing) driver for ep93xx SoC so
> > we can fully convert ep93xx to device tree.
> >=20
> > This driver is capable of muxing ep9301/ep9302/ep9307/ep9312/ep9315
> > variants, this is chosen based on "compatible" in device tree.
>=20
> Mostly nit-picks below, with the exception to setting device node.
> See below.
>=20
> ...
>=20
> > +/*
> > + * There are several system configuration options selectable by
> > the DeviceCfg and SysCfg
> > + * registers. These registers provide the selection of several pin
> > multiplexing options and also
> > + * provide software access to the system reset configuration
> > options. Please refer to the
> > + * descriptions of the registers, =E2=80=9CDeviceCfg=E2=80=9D on page =
5-25 and
> > =E2=80=9CSysCfg=E2=80=9D on page 5-34, for a
> > + * detailed explanation.
> > + */
> > +#define EP93XX_SYSCON_DEVCFG_D1ONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(30=
) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_D0ONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(29=
) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_IONU2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(28=
) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_GONK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0B=
IT(27) /* done */
> > +#define EP93XX_SYSCON_DEVCFG_TONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0B=
IT(26) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_MONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0B=
IT(25) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_A2ONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(22=
) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_A1ONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0BIT(21=
) /* not used */
> > +#define EP93XX_SYSCON_DEVCFG_HONIDE=C2=A0=C2=A0=C2=A0=C2=A0BIT(11) /* =
done */
> > +#define EP93XX_SYSCON_DEVCFG_GONIDE=C2=A0=C2=A0=C2=A0=C2=A0BIT(10) /* =
done */
> > +#define EP93XX_SYSCON_DEVCFG_PONG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0B=
IT(9) /* done */
> > +#define EP93XX_SYSCON_DEVCFG_EONIDE=C2=A0=C2=A0=C2=A0=C2=A0BIT(8) /* d=
one */
> > +#define EP93XX_SYSCON_DEVCFG_I2SONSSP=C2=A0=C2=A0BIT(7) /* done */
> > +#define EP93XX_SYSCON_DEVCFG_I2SONAC97=C2=A0BIT(6) /* done */
> > +#define EP93XX_SYSCON_DEVCFG_RASONP3=C2=A0=C2=A0=C2=A0BIT(4) /* done *=
/
>=20
> What are these comments supposed to mean?
>=20
> ...
>=20
> > +static const struct pinctrl_ops ep93xx_pctrl_ops =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_groups_count =3D ep93xx=
_get_groups_count,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_group_name =3D ep93xx_g=
et_group_name,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.get_group_pins =3D ep93xx_g=
et_group_pins,
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.dt_node_to_map =3D pinconf_=
generic_dt_node_to_map_all,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.dt_free_map =3D pinconf_gen=
eric_dt_free_map,
>=20
> Hmm... Don you need to ifdef these fields?

From now on we can't live without CONFIG_OF, so i don't think it's
necessary.

>=20
> > +};
>=20
> ...
>=20
> > +static const struct pinfunction ep93xx_pmx_functions[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("spi", s=
pigrps, ARRAY_SIZE(spigrps)),
>=20
> Is array_size.h being included?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("ac97", =
ac97grps,
> > ARRAY_SIZE(ac97grps)),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("i2s", i=
2sgrps, ARRAY_SIZE(i2sgrps)),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("pwm", p=
wm1grps, ARRAY_SIZE(pwm1grps)),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("keypad"=
, keypadgrps,
> > ARRAY_SIZE(keypadgrps)),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("pata", =
idegrps, ARRAY_SIZE(idegrps)),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("lcd", r=
astergrps,
> > ARRAY_SIZE(rastergrps)),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PINCTRL_PINFUNCTION("gpio", =
gpiogrps,
> > ARRAY_SIZE(gpiogrps)),
> > +};
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (pmx->model) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case EP93XX_9301_PINCTRL:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0grp =3D &ep9301_pin_groups[group];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case EP93XX_9307_PINCTRL:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0grp =3D &ep9307_pin_groups[group];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case EP93XX_9312_PINCTRL:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0grp =3D &ep9312_pin_groups[group];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
>=20
> default?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmx->model =3D (int)(uintptr=
_t)id->driver_data;
>=20
> Is the model defined as int (signed)?
>=20
> Otherwise can we use proper type?
>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* using parent of_node to m=
atch in
> > get_pinctrl_dev_from_of_node() */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0device_set_of_node_from_dev(=
dev, adev->dev.parent);
>=20
> Hmm... This takes references in comparison to device_set_node(). Is
> it intended?

Nope, switched to "device_set_node(dev, dev_fwnode(adev-dev.parent));".

>=20
> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmx->pctl =3D devm_pinctrl_r=
egister(dev, &ep93xx_pmx_desc,
> > pmx);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(pmx->pctl))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(dev, PTR_ERR(pmx->pctl),
> > "could not register pinmux driver\n");
>=20
> It can be written as
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pmx->pctl =3D devm_pinctr=
l_register(dev, &ep93xx_pmx_desc,
> pmx);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D PTR_ERR_OR_ZERO(.=
..);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return dev_err_probe(dev, ret, "could not register
> pinmux driver\n");
>=20
> (makes line shorter). But it's up to you.
>=20


