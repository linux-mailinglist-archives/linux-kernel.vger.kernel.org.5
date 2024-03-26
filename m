Return-Path: <linux-kernel+bounces-119842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E688CD99
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EBDB22550
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6917413D25D;
	Tue, 26 Mar 2024 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fFVw0o79"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A56F13D272;
	Tue, 26 Mar 2024 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711482883; cv=none; b=pPYapWxvq3E11o5Eyfpv8Kb4HOQ6Rq6LrPesyEkpBBq+UnFXpjqgjo8K/53yx4KYyUHJSvxeqfuprnuVPEh3qp6+Y3elZiYQji6kiut8/f+neakX9IqkZlj0d+cDpBRnqpkDPh8APvcJ6sTY9VBrQtnwiMN9T89xWoQlw886dcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711482883; c=relaxed/simple;
	bh=l2Uqx7wrA6NoUxQ4rJTc5pIIxLEtsRzqWRIYJT+Ma08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMGJjAN3yrzAeqUdjsupzQ6X1OqY0Ji8p+w0ZFrvlul15EAzzcmusYN00/43FgCtCNdmsXLPz2t2lzabZ6uapPCWGbW7l/VX2W10tvTCRTxmHeCa1hlmM/DgRBVLUq8p/+XGRTk3DTGp4RaP1GyCGCZAf3x11PdstBiO1Wo6spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fFVw0o79; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711482872;
	bh=l2Uqx7wrA6NoUxQ4rJTc5pIIxLEtsRzqWRIYJT+Ma08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFVw0o79eIaWlD03wcbtDVuqaM2fT86wyggWSzLP5JOc8LeMOSRHlFogkIEfG/LP/
	 9O5pb7PYt4dBcQ+rh6r8CphFrXSlMRzIzHmz8gAjFzvxNnzWQlaNaf2UVdhsfMxd8L
	 WWl+9LT/RtHsUSmDowy3BDw2HuJH/4btYykTnPi4dbLd3TrkkFg8ZQvD3Q9I9lG4pp
	 VNcU+OLBcZHUcoNl7KkHHQ7JzjYzBIodazSwr6u5Pai/tDaIfyskbfhmZv+MUwnBti
	 UM8Hc9/Hgyg/MjYPKg0WaiwAEfiPphHojG3ByKXW1Tp4uJO+7mk20FKcpaKATTaigf
	 PyQX4EntyNBTw==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6205D37802F2;
	Tue, 26 Mar 2024 19:54:32 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id C7FED10608D9; Tue, 26 Mar 2024 20:54:31 +0100 (CET)
Date: Tue, 26 Mar 2024 20:54:31 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, boris.brezillon@collabora.com, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH] arm64: dts: rockchip: quartzpro64: Enable the GPU
Message-ID: <jbyqey5y5ngr7mkrrmdxrwyw5ogd7rq56af6mrmhsckboanvyp@tcaav2tridos>
References: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vy7v7ft7rt4enblx"
Content-Disposition: inline
In-Reply-To: <0f3759ee390f245dac447bbee038445ddfecbec0.1711383286.git.dsimic@manjaro.org>


--vy7v7ft7rt4enblx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 25, 2024 at 05:19:04PM +0100, Dragan Simic wrote:
> Following the approach used to enable the Mali GPU on the rk3588-evb1, [1]
> do the same for the Pine64 QuartzPro64, which uses nearly identical hardw=
are
> design as the RK3588 EVB1.
>=20
> The slight disadvantage is that the regulator coupling logic requires the
> regulators to be always on, which is also noted in the comments.  This is
> obviously something to be improved at some point in the future, but should
> be fine for now, especially because the QuartzPro64 isn't a battery-power=
ed
> board, so low power consumption isn't paramount.
>=20
> [1] https://lore.kernel.org/linux-rockchip/20240325153850.189128-5-sebast=
ian.reichel@collabora.com/
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---

FWIW

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/a=
rm64/boot/dts/rockchip/rk3588-quartzpro64.dts
> index 67414d72e2b6..68d432c61ea5 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
> @@ -285,6 +285,12 @@ &gmac0_rgmii_clk
>  	status =3D "okay";
>  };
> =20
> +&gpu {
> +	mali-supply =3D <&vdd_gpu_s0>;
> +	sram-supply =3D <&vdd_gpu_mem_s0>;
> +	status =3D "okay";
> +};
> +
>  &i2c2 {
>  	status =3D "okay";
> =20
> @@ -491,11 +497,15 @@ rk806_dvs3_null: dvs3-null-pins {
>  		regulators {
>  			vdd_gpu_s0: dcdc-reg1 {
>  				regulator-name =3D "vdd_gpu_s0";
> +				/* regulator coupling requires always-on */
> +				regulator-always-on;
>  				regulator-boot-on;
>  				regulator-enable-ramp-delay =3D <400>;
>  				regulator-min-microvolt =3D <550000>;
>  				regulator-max-microvolt =3D <950000>;
>  				regulator-ramp-delay =3D <12500>;
> +				regulator-coupled-with =3D <&vdd_gpu_mem_s0>;
> +				regulator-coupled-max-spread =3D <10000>;
> =20
>  				regulator-state-mem {
>  					regulator-off-in-suspend;
> @@ -545,11 +555,15 @@ regulator-state-mem {
> =20
>  			vdd_gpu_mem_s0: dcdc-reg5 {
>  				regulator-name =3D "vdd_gpu_mem_s0";
> +				/* regulator coupling requires always-on */
> +				regulator-always-on;
>  				regulator-boot-on;
>  				regulator-enable-ramp-delay =3D <400>;
>  				regulator-min-microvolt =3D <675000>;
>  				regulator-max-microvolt =3D <950000>;
>  				regulator-ramp-delay =3D <12500>;
> +				regulator-coupled-with =3D <&vdd_gpu_s0>;
> +				regulator-coupled-max-spread =3D <10000>;
> =20
>  				regulator-state-mem {
>  					regulator-off-in-suspend;

--vy7v7ft7rt4enblx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYDJ/MACgkQ2O7X88g7
+prAXw//VFNyf9UpzEvJ2gmtgoAy+Uuxc8F9f3S6P58m/22P+THFPE3nNh1KnLZ4
1uhZc3Gj2sf0nvXTr2Zl6fdV0Sr0xEKUlQGnXAcxH33nZ/TGWhjFu3ivzF59L98T
RwXbIIQWKQyBjcyrwF1ssq9zdt9ywbTAGUcjnt7NzuJ+S8+W3eoyvJzEXT7ij+fa
rShpniZV50t8DeqNLKgbSyOybguQRRo7cgKwrgQGeoNxb1IXkmkOzhmZ07fd84i0
cusDkWNh2sk0wIL0xw9HRKuay2lY8PiPnS+th+hNf6SC5oF/CQfXjtXE//fNHhkI
0L9xLtdPKt3zeKSSe9kB2xZMC4UO1Q1bxPAOT2hzoF/vHb5Tp8mO4usGTrGNHspc
OiAtZt+V+4JblDIiVGSc2KLuERFxEvsQMkKilCOQbNDoWwsC/E9aGbcgt0lkaRKi
AE4i79EE3uHiIR1q8dg28P4JZpt1LjjZIq7QjUWSIqOwXWGOY8d6yflJn9z1bQZm
YfukUZ3IyYfJxHHt2zL7qIAXTj3oMzr69XYnAvVuZbZkzYOQ1wcduuSC7tr+AN0Q
ZuJ152h5AtoviSvADObkhjzYoH5NTd2ep2/MMy2qdtkPt4i5kTmtt7VMpl2szzhk
AS0FfOoWCSS5Uj6y7k0SyE1B72dYHej+raY8jySawgt+kQV4cyU=
=tY+0
-----END PGP SIGNATURE-----

--vy7v7ft7rt4enblx--

