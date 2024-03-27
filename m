Return-Path: <linux-kernel+bounces-121693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8088EC8A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B9A1C2E70B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF42114D45F;
	Wed, 27 Mar 2024 17:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XloCsd3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D6B1304A6;
	Wed, 27 Mar 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560213; cv=none; b=MwGS8B7BQo1LdZY0nvO4NlFyf+uvWQRq1CkV8ACTPx6oUoo2FxL3z30q5jgZFC61t4g/GhzBxK7J6Ue3h5FkObKN2hcjpbay4Jtd5JuAkGRy0ghvesQm52wCiNW2y0TOCNawGCg43JW1MJZY8o6rspxHIHbYGuwStj2fuO5eioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560213; c=relaxed/simple;
	bh=IVW7vlTiLrTDILy6sOFcmkVPU3+mDVNBvceJINH+rOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tw2w7YuD+QQtrPFVaHi3BnF7jq5XDb4BO9wFCAVTLoI2b3P43Nk49qml3zmCpqpuWM20oXUUUiQWCY94WN6s+BggVVqTvYuiFLNrAG6tyXtS+Prh2+d/nij7ZnIORdlYf6T4EiwssZsvTGa45vUHx23Y0xtfvIMpnCwEHPPqbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XloCsd3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA95C433C7;
	Wed, 27 Mar 2024 17:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711560212;
	bh=IVW7vlTiLrTDILy6sOFcmkVPU3+mDVNBvceJINH+rOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XloCsd3HB0EhyIQa5CzYWfgKyeewc6Oqo0by9UfFEbxWZIexiepINomz0U7NH5PpD
	 F7bO68lQDu8aBGYCYKPh66JaFzTlN2DyebgDzfYB4hNllLQDTQQJxjeyQ5rsGCWop3
	 NY2JuvbsjVzpVoLUX2m4D3n/TPYD45DL2vRUvg0QtaVGIeoGYg/860IfICZRzrBHmW
	 swdOfcf5VB1xJkpsYGQ4LUKJzG0fsn5jzUqOvxKvJVukcS+rdwwTX6aVBmNFHsvWrP
	 UykPBL0SCRFrQXScdsu6Vh8CVXQmMixz4lSY0QfeN8TIFNjWADxiNWPKZsetBKIVXd
	 wUw//P4t3xOXQ==
Date: Wed, 27 Mar 2024 17:23:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Cc: linux-kernel@vger.kernel.org,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2 1/2] media: =?utf-8?Q?dt-bin?=
 =?utf-8?Q?ding=3A_media=3A_Document_rk3588=E2=80=99s?= VEPU121
Message-ID: <20240327-doze-uncheck-475f3feaee57@spud>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
 <20240327134115.424846-2-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4zuSRA0OEooBf1eF"
Content-Disposition: inline
In-Reply-To: <20240327134115.424846-2-linkmauve@linkmauve.fr>


--4zuSRA0OEooBf1eF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 02:41:11PM +0100, Emmanuel Gil Peyrot wrote:
> This encoder-only device is present four times on this SoC, and should
> support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> encoding).
>=20
> According to the TRM[1], there is also the VEPU580 encoder which
> supports H.264 and H.265, and various VDPU* decoders, of which only the
> VDPU981 is currently supported.  This patch describes only the VEPU121.
>=20
> [1] https://github.com/FanX-Tek/rk3588-TRM-and-Datasheet
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml   | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu=
=2Eyaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> index 9d90d8d0565a..4c6cb21da041 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> @@ -15,8 +15,12 @@ description:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - rockchip,rk3568-vepu
> +    oneOf:
> +      - const: rockchip,rk3568-vepu
> +      - items:
> +          - enum:
> +              - rockchip,rk3588-vepu121
> +          - const: rockchip,rk3568-vepu
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.44.0
>=20

--4zuSRA0OEooBf1eF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRWDgAKCRB4tDGHoIJi
0lutAP9RUO+UBR6Pi5FROQ2xaLNqi5TaQoaK43MSDUy1PTIC0AEA7wsfYNyJUltg
R8OsUeBnoheFQXxeCQ5knEZaXqMNKQ0=
=eiO7
-----END PGP SIGNATURE-----

--4zuSRA0OEooBf1eF--

