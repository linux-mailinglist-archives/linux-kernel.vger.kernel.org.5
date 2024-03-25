Return-Path: <linux-kernel+bounces-117424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813888AB3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0BA728E55A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6FA7FBD2;
	Mon, 25 Mar 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d2JaH/4t"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32407F7DC;
	Mon, 25 Mar 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382350; cv=none; b=NjB0Bp9guVACBtFJ+z0FlzyQJC8LJTqpOfHLOwK8bPPgVXM/P6qtEQCxwFnCKMumRZLdemscbAADCkTNJxdMfXzziY2ymPhCLN9O5oOaUt878ZYkUlWDe4dp+qifc17j1ZMwGHsXcEzZCiTdKnzp0vAaMjevc1tjitOURisF6Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382350; c=relaxed/simple;
	bh=z6TktM9oeZYfD2iw3BnLyXq0E5TG0XoAbr6D5qI8LfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcNc6RwO3LgL3wGRqZyyGGY/5gB1Hj3JBFJUDESWNxEMIuV3RsAx9kVTLHfP6HDrV3VZCoeq9nlkIQTEqhsfVK4TEIzROFXS/vB51QSeOJGKpU7aiqxZDBjU/VoeEljlDFRwk6GuQQMRlwwrDx87ckAxM6SBYFyBigD8+ZdzE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d2JaH/4t; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711382347;
	bh=z6TktM9oeZYfD2iw3BnLyXq0E5TG0XoAbr6D5qI8LfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2JaH/4tV0LyVi0uyRz3byEOEifMu162pRb26KxjcEUxZ5VvtYxVsHk/rmSVV57bD
	 7byKasfozdy+2czFVurHQ7KjR4IltkaPUvLq6P3evAaYL6i4pG5bXSAHBlY2/0O6hP
	 q26QHHeeOTN3SPezNEI90RM8dn3ZGJiVYxyodSkuv2Myr+nAcMkx+GY0E4/Fwyrpnr
	 w+DkvDV/oof3kyfGe/O+rCGFKivV6YNPkSXUqsxx9W4nnXrL91mI3/eO1fBG0L5CTH
	 HdLeM6/ZS4PgqjBuBxFSIgNAx6p/qJK4IRUedivCsRs7V+aTWYjWASZWvpAem//4ff
	 OXQRIwFVCUHYw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D48337813B7;
	Mon, 25 Mar 2024 15:59:07 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 769C3106074E; Mon, 25 Mar 2024 16:58:47 +0100 (CET)
Date: Mon, 25 Mar 2024 16:58:47 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Subject: Re: [PATCH v1 3/4] arm64: dts: rockchip: rk3588-rock5b: Enable GPU
Message-ID: <a6uu7b3y7d4nirxbplc5cj4oeuyblx2grpvvldeovofhx3tnqc@dlse3vixhpws>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
 <20240325153850.189128-4-sebastian.reichel@collabora.com>
 <20240325164441.1dab4018@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rdf73uqhcgedopzb"
Content-Disposition: inline
In-Reply-To: <20240325164441.1dab4018@collabora.com>


--rdf73uqhcgedopzb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 04:44:41PM +0100, Boris Brezillon wrote:
> On Mon, 25 Mar 2024 16:37:20 +0100
> Sebastian Reichel <sebastian.reichel@collabora.com> wrote:
>=20
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> >=20
> > Enable the Mali GPU in the Rock 5B.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> I don't remember writing this patch ;-), maybe I screwed authorship at
> some point, dunno.

mh, I cherry-picked the DT patches from your branch before
cleaning them up.

> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm=
64/boot/dts/rockchip/rk3588-rock-5b.dts
> > index 1fe8b2a0ed75..096ee7a98b89 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> > @@ -180,6 +180,11 @@ &cpu_l3 {
> >  	cpu-supply =3D <&vdd_cpu_lit_s0>;
> >  };
> > =20
> > +&gpu {
> > +	mali-supply =3D <&vdd_gpu_s0>;
> > +	status =3D "okay";
> > +};
> > +
> >  &i2c0 {
> >  	pinctrl-names =3D "default";
> >  	pinctrl-0 =3D <&i2c0m2_xfer>;
> > @@ -470,6 +475,7 @@ rk806_dvs3_null: dvs3-null-pins {
> > =20
> >  		regulators {
> >  			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> > +				regulator-always-on;
>=20
> Hm, should we mention why the regulator is always on here?

In case of the EVB1 it's needed because the generic coupler driver
cannot handle regulators that are not always on. I'm not sure why
it was added for the Rock 5B. I will check if it works without that
flag.

Greetings,

-- Sebastian

--rdf73uqhcgedopzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYBny4ACgkQ2O7X88g7
+poZyQ/9G9QEr+2KbYk/fyuDkbFekDi5Glgsc2BnOzUb7Fc/xRgFCjcxrHlYKwgO
PiNmoQd3mtYg5dV9LXrAk6CCSwMulGLpYvPbeb2CWrSRz2GdzKFuSbSz1Cu8QcUi
taJwzSCCIkKA6yp6KJU8zasTVOhfOMuuWymfKomL6nE/4UqoLCMWNurt5IAuyWQw
ygipqVELxmkDFoS2yx3s2wDi/MrvG5jWVTeX8d4WWyfAyl4SIeiHlpwFNZ1QjFBr
39RxnW7Z/OxyASUHg6YV5ysoxd4Mo07XBxEEzjsMCvUxoc6PvQxsQjZYJ330Qa7c
vbGsrlG3359jmybiFZyJnAcXgwyA9Ly5AtRP+XcO20gCDBe55pTuAr5zMQe2943c
6jApERBuQTbMSsQHoUXFi6zDKhfs2I8GM4vKmk1zOk5slDCWnYHfrG7qMtkzAKN6
R7hPsj7DuBdNP0i6kiepHUqhU3G+LzsyqxD0Jh4VxiRiNiRUcOAyQT0JY29AkXhT
hYyF5n8Q5Y7DvtqH2NKGRoXsLhI/jo6FXU9aBeuTVxYCdCNe4gkDkCWtHLSmMIu3
wdPwJy2lq9GLaNd0Z9IHc06ymM5Uy9RyzhhHcrWJvPKDeAKfl264bcqJbwySjmug
jvvGSbwi1CX+a+6iKqfXAvYwxUBJ1pLI/Jxqeyz0Ml/zMeREsAY=
=Gono
-----END PGP SIGNATURE-----

--rdf73uqhcgedopzb--

