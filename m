Return-Path: <linux-kernel+bounces-143015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 121CF8A3342
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A959B2603A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B543149C4B;
	Fri, 12 Apr 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BpkiKL99"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E91494C3;
	Fri, 12 Apr 2024 16:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938157; cv=none; b=QsXSZN9PmYXmXbQOalddCi0PZR21VVqd8Sqw8Ph7Aq/aqM39kDgQKuAziuBYZBTzVtBu6a2uvEbTttzlznGezK5i8LDHtbIM9ERp5HkgPRUZdJLuOmMtbx7i3pNUegMqnXDIC20LnJEQ0K0EhGTlAk+xxOo1jssS1Dmgz67D7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938157; c=relaxed/simple;
	bh=dU3V6Gu0KGvlhDaJGowbUsDhF9fkTIDZLblXxq3gcdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiAqOvCr0W84j3oLkW4rz97zqLe2KxM2RwkfkDwGTjeSSO7Q5g6Mkl9XK8Sa8oDD5yWfMdei7FiukrOJ8e6eNf71m/C4UADKxI38FX/F39YcMYTX3bk7m6h69G9ECnJ1GZWm65fCAqIkdcjx0WGHTQXj/Z+zbCmddcTmL61njWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BpkiKL99; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712938154;
	bh=dU3V6Gu0KGvlhDaJGowbUsDhF9fkTIDZLblXxq3gcdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpkiKL99SQrKKdw2SST9wNaqT2Pbi7yixEyuEVf27vkr3N85bQwkOzS7sR7tNpcCE
	 /ilX2jzIxNb9Daj4/gumPlZt9oFibx5mr6G8LkSYKxRjNNiAg8tva+LyEL/faTI/Xr
	 wI14qTGLfmUf0j6WAaiWED+q9j3yqNWvqCXG0vV0m8Z8GR2VgbP1tJ82apXQa0sQDL
	 GaslDAL3t2iR0n+5sHNessYjd8xSggdIp07YZU1+BGS7rN+zQGeHZEmAgT08YqUR4Q
	 QB/xJ51lnKNOJFsaF57QNHotN/u66NXGDIvWaN9ndi0+0kysZTkIOkNspWKnhXFMqx
	 qaMDX14ar9f0g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0CDE8378212C;
	Fri, 12 Apr 2024 16:09:14 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 9CA6A10608F9; Fri, 12 Apr 2024 18:09:13 +0200 (CEST)
Date: Fri, 12 Apr 2024 18:09:13 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jianfeng Liu <liujianfeng1994@gmail.com>, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, sfr@canb.auug.org.au, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove startup-delay-us from
 vcc3v3_pcie2x1l0 on rock-5b
Message-ID: <273slx5qkz6ja5qlfjgcaukuzifzsxkdabsld3qodvxaekbzet@ipir56a6afj3>
References: <20240401081302.942742-1-liujianfeng1994@gmail.com>
 <432000a6-1de9-4452-beb7-6954677e34c8@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3aqmahkcw5xmohz"
Content-Disposition: inline
In-Reply-To: <432000a6-1de9-4452-beb7-6954677e34c8@rock-chips.com>


--w3aqmahkcw5xmohz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 10, 2024 at 02:30:16PM +0800, Shawn Lin wrote:
> Hi Jianfeng,
>=20
> On 2024/4/1 16:13, Jianfeng Liu wrote:
> > Property startup-delay-us is copied from vendor dts and it will
> > make kernel not detect pcie wifi device. If I run command:
> > "echo 1 > /sys/bus/pci/rescan", pcie wifi device is detected, but
> > my wifi device RTL8822CE failed to load driver. Another device
> > RTL8723BE can load driver but no wifi signal is detected.
> >=20
> > Removing this property will fix issues above.
> >=20
> > Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
>=20
> startup-delay-us just make sure the power rail is stable before
> any action is taken to start the link, preventing the device from
> unable to work stably. So it shouldn't be the root cause I think.
>=20
> Could you help try this patch to checkout if it works for you?
>=20
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index d684214..df30127 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -167,7 +167,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *p=
ci)
>         struct rockchip_pcie *rockchip =3D to_rockchip_pcie(pci);
>=20
>         /* Reset device */
> -       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +       //gpiod_set_value_cansleep(rockchip->rst_gpio, 0);

Is this removal actually needed?

>=20
>         rockchip_pcie_enable_ltssm(rockchip);
>=20
> @@ -180,7 +180,7 @@ static int rockchip_pcie_start_link(struct dw_pcie *p=
ci)
>          * We need more extra time as before, rather than setting just
>          * 100us as we don't know how long should the device need to rese=
t.
>          */
> -       msleep(100);
> +       msleep(300);
>         gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
>=20
>         return 0;
> @@ -311,6 +311,8 @@ static int rockchip_pcie_probe(struct platform_device
> *pdev)
>         if (ret)
>                 return ret;
>=20
> +       gpiod_set_value_cansleep(rockchip->rst_gpio, 0);

I suppose it makes sense to use GPIOD_OUT_LOW in
rockchip_pcie_resource_get(), so that the GPIO is requested low from
the start instead of being high for a very short amount of time.

Greetings,

-- Sebastian

> +
>         /* DON'T MOVE ME: must be enable before PHY init */
>         rockchip->vpcie3v3 =3D devm_regulator_get_optional(dev, "vpcie3v3=
");
>=20
>=20
>=20
> > ---
> >   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 1 -
> >   1 file changed, 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index d6bf2ee07..a9af654a0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -76,7 +76,6 @@ vcc3v3_pcie2x1l0: vcc3v3-pcie2x1l0-regulator {
> >   		regulator-boot-on;
> >   		regulator-min-microvolt =3D <3300000>;
> >   		regulator-max-microvolt =3D <3300000>;
> > -		startup-delay-us =3D <50000>;
> >   		vin-supply =3D <&vcc5v0_sys>;
> >   	};
> >=20
> > --
> > 2.34.1
> >=20
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>=20

--w3aqmahkcw5xmohz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYZXJ8ACgkQ2O7X88g7
+poq6w//dbFA18vJCILXgGK1j5A0KZ53Xji2T9WW5oeSKb8ypl6VgtPlKKdZIRDV
zwHp6X+QXnzHP4wMfEDTxnmaYX0c5YVY3/ZpXVya2stFTuczmh2ugb9H7DgN1BD9
XCQ4D1GGo3tBAuOfx10ovjjrSkvp5E4e3yI55ibR/BwuI7nQeKR/1A79Sqm/zx/s
IG2vwZN1RsncE0kd9Ot1CNoOvAefrtMrmN0lBBMaDyOdN+rTfkV6w0FtyW+vdGff
+A0A0P0RZF8Vnr2Q6Bwp2f1aL6SA2d+tjqEYNlwno5lyZqR+pVsy8KfIsnf39TLk
5btkAnjFYAc40ulCFUF3jRSp9pC5DCmEET7pU5RWP5cqdiy/mZMJuac2qRsPIJvJ
KjVRafxtRNCsVasFLD6I8wxouyStu0S0wRqs/Hft+WfJWSVDk1spbvrKBcPC5FVr
EM82IWmEfKUxztKl4jItlJT55aF0EcIP/jrc4TNqW9bHS5tQXqX3QPvCotapwWon
GrEdPMLNlIChIMwRZs0r5HKirfWgRGweaBst3tWtk/GjF+zO240zi3xSU7g4hJ0V
WeddNgOZryXHH7vbN1oZeSpjiVZZ3F7n/YulUf003/9IkVjyhzWoWK+53luhU6AA
ZKQ4IdSoLQ4nvV9fDDUyuwS6ClPp+oN7h3NZZtNRsSuhq+n9Z8c=
=D3Tl
-----END PGP SIGNATURE-----

--w3aqmahkcw5xmohz--

