Return-Path: <linux-kernel+bounces-109331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A778817BE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23D6B21EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A20E85642;
	Wed, 20 Mar 2024 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B1VWiDKI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F6D85626;
	Wed, 20 Mar 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962119; cv=none; b=TSN4hwVK2XrMe3K+P2zYbkW5djcfSSvStO+0f0UHusx6UnoHMJOf4lIfmXlUbT5nwbwvPjxlMTca1x8ULLlRex4xlbiMmlvDTIcQpelNgxxpZJL7ddSGYB3pR2aURJ9zkNlpsuvh0IYjfxXZc/6GuUoXAHsFq0qil2akS+Fvl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962119; c=relaxed/simple;
	bh=z+JJu0xQoW3dM54mrpxZ3kL3VRvxY9C0AzdnCinEaxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljCXjXV6U49IYwqZigBfPKSpZgYFdRN7iPxndATNITuP4JtV6t5Kek+9N9iQt+90lC8x917VD7ih19JnHfDMnOpU95UKel+eNyk1gtuk74KFqubWS7gM485Z90fW5zYRWYVW9avNdmg0+2liHu2xAh9PYyEG6DklgRlnQymQAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B1VWiDKI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710962115;
	bh=z+JJu0xQoW3dM54mrpxZ3kL3VRvxY9C0AzdnCinEaxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1VWiDKI1tUhF4pRktoC0eVPZNgiRldDLP2xGOb75MPTlScONOBZX0rX4t3ATjZVG
	 oGRD9jWNegiZ6o80vmfWoCL7PCBh7MmHCrGLPGKT/aTG5+qcEKrRUuk2VvR5nkegrv
	 UCa5mSiGxrbyTF+FvV0iWAftyrJmb6mhk9A92+N9Ih+LgUP2gRWKLZSIuMngwTu9U8
	 Krpx6FxqZCTBuiKaPTl01PEWE0UI26CNo7wd0SsWBMkKcwvzcoQiaiW6UjmIm49p7s
	 XeAn6D7Zm8HIEu17xszWTg4ck4Vgqneq6usFWY33lTKV2CAC4Tm/KPWbR/eAjOheuj
	 mZjW/02iYvGQA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 99D173780BFE;
	Wed, 20 Mar 2024 19:15:15 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 3C9B21060704; Wed, 20 Mar 2024 20:15:15 +0100 (CET)
Date: Wed, 20 Mar 2024 20:15:15 +0100
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
Subject: Re: [PATCH 1/4] dt-bindings: iommu: rockchip: Fix rk3588 variant
Message-ID: <uund5em6hnexqpzxj3iazpu5gjbfwtdcolhkit4cljgfldiqyf@4jmgeh6aaw7v>
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-2-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hcmholarfddiyvvu"
Content-Disposition: inline
In-Reply-To: <20240320173736.2720778-2-linkmauve@linkmauve.fr>


--hcmholarfddiyvvu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Emmanuel,

On Wed, Mar 20, 2024 at 06:37:30PM +0100, Emmanuel Gil Peyrot wrote:
> The documentation got added in f8aa519976b38e67aae02d2db3e2998513305e80,
> but it hasn=E2=80=99t been added to the driver so it was unused.
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---

Everything is fine with f8aa519976b38e67aae02d2db3e2998513305e80
(well the patch description could be better :)) and this patch is
just wrong. The documentation explicitly adds the combination of
rk3588-iommu with rk3568-iommu as fallback. The idea is, that the
driver handles it just like an rk3568 iommu. If some differences
are found in the future, the driver can switch to handle the more
specific compatible without any DT changes (which is ABI).

I suggest watching this presentation:

https://www.youtube.com/watch?v=3D6iguKSJJfxo

Greetings,

-- Sebastian

>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 2 +-
>  drivers/iommu/rockchip-iommu.c            | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/=
dts/rockchip/rk3588s.dtsi
> index 87b83c87bd55..2a23b4dc36e4 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
> @@ -704,7 +704,7 @@ vp3: port@3 {
>  	};
> =20
>  	vop_mmu: iommu@fdd97e00 {
> -		compatible =3D "rockchip,rk3588-iommu", "rockchip,rk3568-iommu";
> +		compatible =3D "rockchip,rk3588-iommu";
>  		reg =3D <0x0 0xfdd97e00 0x0 0x100>, <0x0 0xfdd97f00 0x0 0x100>;
>  		interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
>  		clocks =3D <&cru ACLK_VOP>, <&cru HCLK_VOP>;
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index da79d9f4cf63..da0e93c139d1 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1361,6 +1361,9 @@ static const struct of_device_id rk_iommu_dt_ids[] =
=3D {
>  	{	.compatible =3D "rockchip,rk3568-iommu",
>  		.data =3D &iommu_data_ops_v2,
>  	},
> +	{	.compatible =3D "rockchip,rk3588-iommu",
> +		.data =3D &iommu_data_ops_v2,
> +	},
>  	{ /* sentinel */ }
>  };
> =20
> --=20
> 2.44.0
>=20

--hcmholarfddiyvvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmX7Nb8ACgkQ2O7X88g7
+po3QA//ZGRsC3BtWsJE9IZElMcFAVIscBSPpnfwYskq0O3KIoMWwvFQGlHgRQ9G
dAvpcGMTmFuhv3ZIqiltdO/+bIeOUztINGSzbWNz7uGhpXvTkVkjFzraNUnUKvNh
oR3U29wGba+FJJODcJ3uSapaPsX8RbCk/nZ2dV32SC1/XK6nOeKXHiqGHJoDNzKL
OIBE8QDo5+YuElwXkDFs336VtOo1jsyUTefahIfAlJh0MNCXJ8Gq+IoK9Rb0gBH5
HFmrJY4GodMvwQcNrAIW+FHnV/QNXIGZmbf57ktHUDU3oXqqTr313xTLwcbQO9bL
Go7UEqWBQV2iUtfsz8eKnmh001LQ6iPyBW/Da+Xv979UrgGemV4yZbn9gZnWeDiC
wUAnrdQGuyQBNYmdAL5LucuDnoWupwuPI6v6UuxkWI7aTUvESvuNGDHEK2ZhV15U
Y1Cz3x6g1o9RXKeMST767Xd1AOC/Zs3sunicG3elgWRvMEThrweqZ35fM9b5LSeW
q2JvJ5C85XF1Ast3dIXZ6EM/WwozjzzCGV+YjX8g7rmx/+3AixhXyzVLKHM81/j8
YVEwVmIXpBlwxf9mnUyduc7buIGMPYAevwrdk8R08ROhJN5D0YDEfvMGkiPRFiNx
TTunFW/jz6+B0GOKl9HomDGWAowhIlJvpJWLRtQ3uetHzFgW9LI=
=7AoS
-----END PGP SIGNATURE-----

--hcmholarfddiyvvu--

