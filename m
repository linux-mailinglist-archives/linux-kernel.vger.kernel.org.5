Return-Path: <linux-kernel+bounces-121344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B6788E673
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887071F302B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A88D13A3F5;
	Wed, 27 Mar 2024 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Eya9hcjR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930012F5A9;
	Wed, 27 Mar 2024 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711544985; cv=none; b=PGuBZsh3RhY8NwdWqUEoyhn06OkFkEDF/oVVirUrA4ktbwkkJMQSmqCkt6PuKL7XD53W5i0HnWy8Vby0tYNA8PjNeSksVY3cZNWcclDWhEBhKNksdSEEIfSTvrV1acHbvfCbWn4a9jQtbGP88rG8+QBB8Tp4LxACY4RLLf+4j6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711544985; c=relaxed/simple;
	bh=81ZbrBdYxs8It1E/ipeLp8ojimGjd9cq7crq6evyxB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLs7wJ4K0UxPMfqYJJiwbxfDf+rcJj31yhAuYw3QxNpmleIybUjZdHpKclyCD7ruGZnA87s73q+8XSzujp1SSHfFDDx6Lpk1BPWGaqNe1HkSjjmzcb8NvdAe2CBSkZEqNOrkg81UufXrLBCIFo98AsGr/P3pyko56W+cbF6xVAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Eya9hcjR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711544981;
	bh=81ZbrBdYxs8It1E/ipeLp8ojimGjd9cq7crq6evyxB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eya9hcjRh4E3JmnGFEZl3RZ5rtWwXbwJAX/lowaAjLQWPxK7ahAScE24IK3dFEpmj
	 W8wLJOS3k2bsqiYv0UFXrP+fPrEhRqQGV0x4nhtXQPGzrQxa7jR6q5JwrqfFuZmG3V
	 MQFgrQZS1NaB8xH7Mu6ftq+yOLac0yaZO8mq4oyatmytOATko54g+7N9zbzGmm7ces
	 qEB0PWSDfz/Oo9I7bH+V+MlZ/bcyHZPDRhi+kY70h+pyZ8rEhT8hRIFnxBqZmZsJjI
	 982TJRluzxXmSWVW2sorV4lc9v9ORnv383AtBE0dRzJ2aSzqbEHecQBP7xHNXKcfw9
	 9t66wdhEpgp2g==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9E67537820F3;
	Wed, 27 Mar 2024 13:09:41 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 359D410608D9; Wed, 27 Mar 2024 14:09:41 +0100 (CET)
Date: Wed, 27 Mar 2024 14:09:41 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-kernel@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>, 
	Shreeya Patel <shreeya.patel@collabora.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Andy Yan <andy.yan@rock-chips.com>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add VEPU121 to rk3588
Message-ID: <lrwxcyc2djqd6u3b2j4whe67o7ukblfqfqlnplajwgmvvgst4e@4z5avent6zmv>
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-4-linkmauve@linkmauve.fr>
 <a60f6017-bd19-431e-8cff-7d73f6f114fe@linaro.org>
 <ZgQTrwOUtdZ1nRs0@desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bqhdij4d5wn3lvmi"
Content-Disposition: inline
In-Reply-To: <ZgQTrwOUtdZ1nRs0@desktop>


--bqhdij4d5wn3lvmi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 01:40:15PM +0100, Link Mauve wrote:
> On Thu, Mar 21, 2024 at 09:15:38AM +0100, Krzysztof Kozlowski wrote:
> > On 20/03/2024 18:37, Emmanuel Gil Peyrot wrote:
> > > The TRM (version 1.0 page 385) lists five VEPU121 cores, but only four
> > > interrupts are listed (on page 24), so I=E2=80=99ve only enabled four=
 of them
> > > for now.
> > >=20
> > > Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 80 +++++++++++++++++++++=
++
> > >  1 file changed, 80 insertions(+)
> > >=20
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/b=
oot/dts/rockchip/rk3588s.dtsi
> > > index 2a23b4dc36e4..fe77b56ac9a0 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> > > @@ -2488,6 +2488,86 @@ gpio4: gpio@fec50000 {
> > >  		};
> > >  	};
> > > =20
> > > +	jpeg_enc0: video-codec@fdba0000 {
> > > +		compatible =3D "rockchip,rk3588-vepu121";
> > > +		reg =3D <0x0 0xfdba0000 0x0 0x800>;
> > > +		interrupts =3D <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>;
> > > +		clocks =3D <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
> > > +		clock-names =3D "aclk", "hclk";
> > > +		iommus =3D <&jpeg_enc0_mmu>;
> > > +		power-domains =3D <&power RK3588_PD_VDPU>;
> > > +	};
> > > +
> > > +	jpeg_enc0_mmu: iommu@fdba0800 {
> > > +		compatible =3D "rockchip,rk3588-iommu";
> >=20
> > It does not look like you tested the DTS against bindings. Please run
> > `make dtbs_check W=3D1` (see
> > Documentation/devicetree/bindings/writing-schema.rst or
> > https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-s=
ources-with-the-devicetree-schema/
> > for instructions).
>=20
> Even on master I get an exception about this unresolvable file:
> referencing.exceptions.Unresolvable: cache-controller.yaml#
>=20
> Yet it seems to be present in only three files, all of them unrelated to
> the rockchip board I=E2=80=99m interested in (it seems), so I=E2=80=99m n=
ot sure what to
> do about that.

The trace looked like you tried using dt-schema with jsonschema
version 4.18+, which is known broken:

https://github.com/devicetree-org/dt-schema/issues/109

Greetings,

-- Sebastian

--bqhdij4d5wn3lvmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYEGo4ACgkQ2O7X88g7
+ppnpw/+IYqLzHk0LXotRxxmx2QRAz4gYpFyEku/kt2XkuQwtufZMFEqBQ5hBuzo
WMGDPKyTGKCUSGzxHo53ZnTsSQ4yvnlYmNJJ+invQuwR0AuN0oUdtU2TqGkTXTH5
VlCI3DM0yWjJDPE9MEWRj94dAuKJ/+21kYbiKXbsVlZz7vPvS3AMLUChqGzVW29h
GzwtgqGgwsLQQJnjJQ2MvoBDWqOO5Odg/CRmottxdbmxaHcaQ1shr25plFDjhdf7
qw+lR2cy64CkkQm8dzeVpoIUrD3Ow2KO4iuxlMkKkMFHvesb7Gxs/WDT4dj4q6yk
VQZTdxLe790Pq6v2CIDshZTTLpTIiWOL8vFCNVG7Dl6sSzqUliBKnYStPTa8yZbM
uFBz3GeG+Of8/a/ZetIUJXX5AOTVaSj/DcrbFqy4laQsYLPConDWwU4cDLBSXGy1
EOJKIaFnBA1zonoUGrKkvxhqcgoriWTVKVpmxkyHp4pW4O/ALldccEisOhpYfq3y
sfqiCH0aGDi0vR4hu9K8EQB6hyU7rXhC2K5VFmFKbEotcBakhLjd+mPcCpfvlfBp
rRez6hhL8PDpWPdbS7b4poD0HW5RR3dIgm1shBrr54NVn4wxiVAErRWOaYv+XniH
yglVBxWtvVeh9Zils+BVcew31B+9CEYMOvd4DUp1f8TluPCZtp0=
=12dq
-----END PGP SIGNATURE-----

--bqhdij4d5wn3lvmi--

