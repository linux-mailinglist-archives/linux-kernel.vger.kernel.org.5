Return-Path: <linux-kernel+bounces-138282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C3689EF35
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF092282341
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39CD158D95;
	Wed, 10 Apr 2024 09:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4Yds2T8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA9154C0F;
	Wed, 10 Apr 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742645; cv=none; b=lQyceuGAEwi8zS7viCwMpqTZ58akq7MvNLgWynY8LtEI46cCz3N5/L2925XqHztUJd7eKNlDsjFOgt0RGt3Bs4sgtd4xsDHLpn0OrTpL6FphPLJ6RdXj/Vhk4j0QPaYTQCbkoM1ajAXVYX1hwu+G3L7HK7+E8Tt6miqhyrCTeT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742645; c=relaxed/simple;
	bh=9yBCOfKgxlkwBGNHOhriLBVSumh7h9MF0OaGeGig5vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob1hUupQ8UmnwklLE6VFXs3J/ZHZBwA6lzTWkxezZN+cKvHcWVfVeEZP8sLA7VfWJ+1HNn2DdGDG1hbOMoaCSu82/DsIB8dVrNcY9PpGJ7GJIWFM66n16YPLSIMvoP/Zzw38x5AHEAA8/8lTE0am3ayhk4ACuCbF+nDmQaOfoVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4Yds2T8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F951C43390;
	Wed, 10 Apr 2024 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712742644;
	bh=9yBCOfKgxlkwBGNHOhriLBVSumh7h9MF0OaGeGig5vI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y4Yds2T8BK59a1fZOyIHq1m+QNmg+YCXS5+MbFdrDGQQLIcneYVQuh6c25cHUkq0E
	 QAnywJxznFvHUL3K77yRQZptAgxjvI07nAWiBPIQcKwMyk2oK9NUHG9JhypFPnWXMI
	 tcjMRLZt2ymd0prVd6bre59nuTxghQPFTOXT8ZJuTRrI8No8kTIRZn7DcEKVYoItfU
	 mtQxH17+LWIX7AIOTqsrBI0elMYeaRDplU6A5Ec0LoDy86lQigC8wRaC2TFoxErR7Q
	 CaMBhHNgh4ivvm5mym6uDc1W3vhLwJP7ZrcinkZniQB3x5YBvMOsYCPE1AvQjDFahR
	 0hU9T9VkftnOg==
Date: Wed, 10 Apr 2024 10:50:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/5] clk: meson: axg: move reset controller's code
 to separate module
Message-ID: <20240410-supremacy-importer-9b5ac1957479@spud>
References: <20240328010831.884487-1-jan.dakinevich@salutedevices.com>
 <20240328010831.884487-2-jan.dakinevich@salutedevices.com>
 <1j7chfiz8e.fsf@starbuckisacylon.baylibre.com>
 <e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org>
 <f01cdd910ab35316b8012795f73fd2b34c8e6f8e.camel@pengutronix.de>
 <13617b7a892424d2b024c725505a6f4f.sboyd@kernel.org>
 <20240408-numerator-escargot-a642507a598e@spud>
 <20240409-shallow-voice-c84ed791bc7d@spud>
 <dde59dd2ef4da81528e31f65844e0b3f.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JPgr6dKZxpVy8iT7"
Content-Disposition: inline
In-Reply-To: <dde59dd2ef4da81528e31f65844e0b3f.sboyd@kernel.org>


--JPgr6dKZxpVy8iT7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 09, 2024 at 07:27:36PM -0700, Stephen Boyd wrote:
> Quoting Conor Dooley (2024-04-09 05:05:37)
> > On Mon, Apr 08, 2024 at 06:05:51PM +0100, Conor Dooley wrote:
> >=20
> > > > > Seconded, the clk-mpfs/reset-mpfs and clk-starfive-jh7110-sys/res=
et-
> > > > > starfive-jh7110 drivers are examples of this.
> > > > >=20
> > > > > > The auxiliary device creation function can also be in the
> > > > > > drivers/reset/ directory so that the clk driver calls some func=
tion
> > > > > > to create and register the device.
> > > > >=20
> > > > > I'm undecided about this, do you think mpfs_reset_controller_regi=
ster()
> > > > > and jh7110_reset_controller_register() should rather live with the
> > > > > reset aux drivers in drivers/reset/ ?
> > > >=20
> > > > Yes, and also mpfs_reset_read() and friends. We should pass the base
> > > > iomem pointer and parent device to mpfs_reset_adev_alloc() instead =
and
> > > > then move all that code into drivers/reset with some header file
> > > > exported function to call. That way the clk driver hands over the d=
ata
> > > > without having to implement half the implementation.
> > >=20
> > > I'll todo list that :)
> >=20
> > Something like the below?
> >=20
> > -- >8 --
> > From a12f281d2cb869bcd9a6ffc45d0c6a0d3aa2e9e2 Mon Sep 17 00:00:00 2001
> > From: Conor Dooley <conor.dooley@microchip.com>
> > Date: Tue, 9 Apr 2024 11:54:34 +0100
> > Subject: [PATCH] clock, reset: microchip: move all mpfs reset code to t=
he
> >  reset subsystem
> >=20
> > <insert something here>
> >=20
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Looks pretty good.
>=20
> >  static const struct of_device_id mpfs_clk_of_match_table[] =3D {
> > diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
> > index 7f3fb2d472f4..27cd68b4ee81 100644
> > --- a/drivers/reset/reset-mpfs.c
> > +++ b/drivers/reset/reset-mpfs.c
> > @@ -137,9 +139,67 @@ static int mpfs_reset_probe(struct auxiliary_devic=
e *adev,
> >         return devm_reset_controller_register(dev, rcdev);
> >  }
> > =20
> > +static void mpfs_reset_unregister_adev(void *_adev)
> > +{
> > +       struct auxiliary_device *adev =3D _adev;
> > +
> > +       auxiliary_device_delete(adev);
> > +       auxiliary_device_uninit(adev);
> > +}
> > +
> > +static void mpfs_reset_adev_release(struct device *dev)
> > +{
> > +       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> > +
> > +       kfree(adev);
> > +}
> > +
> > +static struct auxiliary_device *mpfs_reset_adev_alloc(struct device *c=
lk_dev)
> > +{
> > +       struct auxiliary_device *adev;
> > +       int ret;
> > +
> > +       adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> > +       if (!adev)
> > +               return ERR_PTR(-ENOMEM);
> > +
> > +       adev->name =3D "reset-mpfs";
> > +       adev->dev.parent =3D clk_dev;
> > +       adev->dev.release =3D mpfs_reset_adev_release;
> > +       adev->id =3D 666u;
> > +
> > +       ret =3D auxiliary_device_init(adev);
> > +       if (ret) {
> > +               kfree(adev);
> > +               return ERR_PTR(ret);
> > +       }
> > +
> > +       return adev;
> > +}
> > +
> > +int mpfs_reset_controller_register(struct device *clk_dev, void __iome=
m *base)
> > +{
> > +       struct auxiliary_device *adev;
> > +       int ret;
> > +
> > +       mpfs_reset_addr =3D base;
>=20
> Instead of a global this can be stashed in adev->dev.platform_data and
> grabbed in the driver probe?

I suppose, really I was just being "lazy" here and creating a global
rather than a `struct mpfs_reset` containing only the base address.

The test robot reported some issues with hexagon & COMPILE_TEST, so I'll
push it out again with this change and the fixes for the reported issues
and send the patch ones it gets the all clear.

Cheers,
Conor.

--JPgr6dKZxpVy8iT7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhZg7wAKCRB4tDGHoIJi
0hveAPwNpL7h191WykV2UuzkJO3pu772z/AWkwlY/yHmXJVsuwEApGRz5bEryU3C
JZ94q3AIj7Df4J7rHqDC1re2X9bNwwA=
=pOIQ
-----END PGP SIGNATURE-----

--JPgr6dKZxpVy8iT7--

