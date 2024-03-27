Return-Path: <linux-kernel+bounces-121716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DCE88ECDF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6265AB252DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821CD14F106;
	Wed, 27 Mar 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WNRsxrqf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3614D6EF;
	Wed, 27 Mar 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561509; cv=none; b=bnXO1SQlylHf8kUEPYVca6HO9eYuT4/IdR38D9WN1B98oS8nYT41YXjli7+NSjTIfVO0I5EqytiDu5ylaLMZaLrXEK8KiB/aq/mgo/3RYA7e1Z7VuTO93E3uzHx1p3nyRlXp0IeNpKMF2t9VpiXKgscwK7EVMzdw8T7OkpKiREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561509; c=relaxed/simple;
	bh=hX7ksftxhBPlKhJ3ORnpry5arh/EO7LHpHr3IuMRQ5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpy9h2Joro2SwSJL3Yb20yGHU8YGSi8305jphmpE8zQPyjHI61qIeHCKLLNOOTmYa/16NWoWXBGtQsbt1zHxxAx3VYWigsU+Uwr/QGs5KTsK6WwWWspi4nx1dI3/gAtrmuRpdQZcY2+pxRenActdXg5SMEzLxa/29N68miJTg68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WNRsxrqf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711561505;
	bh=hX7ksftxhBPlKhJ3ORnpry5arh/EO7LHpHr3IuMRQ5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WNRsxrqfn2miKOO53mLdXP1QMBa+zq+Nx417t3L9yo31ttM6hnd2stHiOZbwOuoAo
	 1TwXsmMscpUYceSUY3+JW123Uf2L+Ws9Bgc/SoCwwVqBFuwF88tluSSUbm6EZejEpM
	 o1T+2ugLFOU8BGn4VvYMixfllU4I5Bqw2Z3Vs01WHGH9C7Iv0gqHzMH1X1cLQ0kjNX
	 o7Fv5ewsSuc9C9k6ewJaMLXXfM2u8NP3islICr4+cHuqNyIHKJ6K61HSjrgfKA4sUx
	 TahG9HxXwWaQ6JtKrWej69c+VC56vP5Qr+T/OjQ4pu4e0K3fGFq86+I6EUW/+Y77Wa
	 JinYBHFNovDDQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 06A7B3780C13;
	Wed, 27 Mar 2024 17:45:05 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id A3CED10608D9; Wed, 27 Mar 2024 18:45:04 +0100 (CET)
Date: Wed, 27 Mar 2024 18:45:04 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-kernel@vger.kernel.org, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Dragan Simic <dsimic@manjaro.org>, Shreeya Patel <shreeya.patel@collabora.com>, 
	Chris Morgan <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, 
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: Add VEPU121 to rk3588
Message-ID: <b3gjngpu4sszth3ajyowbplqsvu2su3hgktpf3cffopbrawz4y@ddcnnwnlecvq>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
 <20240327134115.424846-3-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3n3gcsm6jabdcoyz"
Content-Disposition: inline
In-Reply-To: <20240327134115.424846-3-linkmauve@linkmauve.fr>


--3n3gcsm6jabdcoyz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 02:41:12PM +0100, Emmanuel Gil Peyrot wrote:
> The TRM (version 1.0 page 385) lists five VEPU121 cores, but only four
> interrupts are listed (on page 24), so I=E2=80=99ve only enabled four of =
them
> for now.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 80 +++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi
> index 87b83c87bd55..510ed3db9d01 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -2488,6 +2488,86 @@ gpio4: gpio@fec50000 {
>  		};
>  	};
> =20
> +	jpeg_enc0: video-codec@fdba0000 {
> +		compatible =3D "rockchip,rk3588-vepu121", "rockchip,rk3568-vepu";
> +		reg =3D <0x0 0xfdba0000 0x0 0x800>;
> +		interrupts =3D <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
> +		clock-names =3D "aclk", "hclk";
> +		iommus =3D <&jpeg_enc0_mmu>;
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +	};
> +
> +	jpeg_enc0_mmu: iommu@fdba0800 {
> +		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		reg =3D <0x0 0xfdba0800 0x0 0x40>;
> +		interrupts =3D <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER0>, <&cru HCLK_JPEG_ENCODER0>;
> +		clock-names =3D "aclk", "iface";
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	jpeg_enc1: video-codec@fdba4000 {
> +		compatible =3D "rockchip,rk3588-vepu121", "rockchip,rk3568-vepu";
> +		reg =3D <0x0 0xfdba4000 0x0 0x800>;
> +		interrupts =3D <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER1>, <&cru HCLK_JPEG_ENCODER1>;
> +		clock-names =3D "aclk", "hclk";
> +		iommus =3D <&jpeg_enc1_mmu>;
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +	};
> +
> +	jpeg_enc1_mmu: iommu@fdba4800 {
> +		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		reg =3D <0x0 0xfdba4800 0x0 0x40>;
> +		interrupts =3D <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER1>, <&cru HCLK_JPEG_ENCODER1>;
> +		clock-names =3D "aclk", "iface";
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	jpeg_enc2: video-codec@fdba8000 {
> +		compatible =3D "rockchip,rk3588-vepu121", "rockchip,rk3568-vepu";
> +		reg =3D <0x0 0xfdba8000 0x0 0x800>;
> +		interrupts =3D <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER2>, <&cru HCLK_JPEG_ENCODER2>;
> +		clock-names =3D "aclk", "hclk";
> +		iommus =3D <&jpeg_enc2_mmu>;
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +	};
> +
> +	jpeg_enc2_mmu: iommu@fdba8800 {
> +		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		reg =3D <0x0 0xfdba8800 0x0 0x40>;
> +		interrupts =3D <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER2>, <&cru HCLK_JPEG_ENCODER2>;
> +		clock-names =3D "aclk", "iface";
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +		#iommu-cells =3D <0>;
> +	};
> +
> +	jpeg_enc3: video-codec@fdbac000 {
> +		compatible =3D "rockchip,rk3588-vepu121", "rockchip,rk3568-vepu";
> +		reg =3D <0x0 0xfdbac000 0x0 0x800>;
> +		interrupts =3D <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER3>, <&cru HCLK_JPEG_ENCODER3>;
> +		clock-names =3D "aclk", "hclk";
> +		iommus =3D <&jpeg_enc3_mmu>;
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +	};
> +
> +	jpeg_enc3_mmu: iommu@fdbac800 {
> +		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		reg =3D <0x0 0xfdbac800 0x0 0x40>;
> +		interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clocks =3D <&cru ACLK_JPEG_ENCODER3>, <&cru HCLK_JPEG_ENCODER3>;
> +		clock-names =3D "aclk", "iface";
> +		power-domains =3D <&power RK3588_PD_VDPU>;
> +		#iommu-cells =3D <0>;
> +	};
> +
>  	av1d: video-codec@fdc70000 {
>  		compatible =3D "rockchip,rk3588-av1-vpu";
>  		reg =3D <0x0 0xfdc70000 0x0 0x800>;
> --=20
> 2.44.0
>=20

--3n3gcsm6jabdcoyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYEWyAACgkQ2O7X88g7
+pp64g//VuBdzDZqo0tjZDv6WWUacbktDLhSTLzmhgvHqXd4ANQlWsPWHs9MxVD2
Q5llAWFD7WNAXQSAaoUNSCXyC1akYQanSqZMJrDFHbeTFw5lSDVkZZ57TsEchhJv
CUwulPRlu+zv1gDf3kQNtd7QvWBPimS5gdJf4KnP5rtiLn/ZUZQm7c7XbbNdCxtL
wwUAHb4JN/DDWlwXhnbdvEfOG7/ejqY2xwxNDPjUxftdVh1w0OZLksUCxYwqfUvd
dzxry+uCLv94IwLQyOs31vmIy858r0pHo6H6mNfG4dTmp/A1L7MaxXaMy/bO+huk
obWVHt7AYio8cu4WWWXYN7relACBX8Ktrojo40TQAs1Te581x4vfLMWLu8X6vp/y
dgsDAQjcrjmfVaFyWStn+5HaUBQNG0IGcvdQ3yWiFCi1qoSMkmLM0lZEJZ/Syq8r
VKcjw5fkYPxkncvcEIzGsRZ/PUK8zS6ezTUv5+SRBg3PzUNEnS7+Y805VIHczcWy
+/0GN5ufEIj8yV78Y+L1q2Y7QPteEtAIts+aCGCyXONZeMM2C6MCfr/4CiAEGT99
rlqUBIqZA11cyyykCtx3FVk1yR8iWeahExJSOrkNxWG9TIRYFPX3BhMWWJDMCgEC
yPi57J8vQF0ZQS2YE+NBqUuGO+tFJDO/yyCYMMstDV9qJNSAugI=
=GOki
-----END PGP SIGNATURE-----

--3n3gcsm6jabdcoyz--

