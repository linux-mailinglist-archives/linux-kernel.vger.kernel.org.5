Return-Path: <linux-kernel+bounces-121713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351FF88ECDA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FB41F2EEF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA314E2D9;
	Wed, 27 Mar 2024 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="d8ARsdob"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173B14D281;
	Wed, 27 Mar 2024 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561485; cv=none; b=tgLHOz1Z+QY7KVfUpxyjSZPPHA5RIE+Zqjph3BSD7vLQNIPF643AkMy6yB7+zeP9Wxytw6cRjPpYrjtxllXqUEq8cce9IMH9pPVdOVzL+sh8GiyrWfGo+JA1P9/PxJTMVeiXB2NVRA0PngP/LxFROAtEvvYGmPRIkwPErnfSTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561485; c=relaxed/simple;
	bh=CXkByOqBPbKZe9eVXPJpPOkJ1DM+X1hSruvjT3Mg1VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlCDFghDvvIBlZdHWKms3tTTuLUhahY53wsaw+kDYlb2N4J4eaSrfUYv60+EyeXU1E2i+HTEe2J5pXnoUQ2A/qHjKTVI3273+EKwbrX/pf8Ol20Jy8p6KdoJcx1uCiGCidD8cVhkt13VSEXtrqaDmVYiey4Z8rA+2niF8sesBcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=d8ARsdob; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711561481;
	bh=CXkByOqBPbKZe9eVXPJpPOkJ1DM+X1hSruvjT3Mg1VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8ARsdobC7J6xJrdjCncvaR+KU/sXFNu6mJhI5mDtxctuZu9QudjRK2BmK8ZtnH7T
	 p0Q3c8kSjTVaeWztANfGa5XdFaEaIoB6UK1Oe3Tsg7BUl5qTTkpcXneyDBBRGQzNHr
	 kwAr6/51FLy9NKOdXxDZhgNvhDjv/rRWVnPpmbHbczYs6r+HRP3N2TEfe50ivZkXq2
	 v86WUfr46Sin8Jwe3Hew/vIfpapkgAL0M1DNL8NI0S9I6QRYF7bBva+Aj4TgP2MZSr
	 OQbvV/jG5Iv1UymaCsE9/lLxhkA//H2quyB5y4DrD+jZrceJO0VZVp1cfs8WQj5mrz
	 bS2sRQVe8YVbA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C206F3780C13;
	Wed, 27 Mar 2024 17:44:41 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 61A9810608D9; Wed, 27 Mar 2024 18:44:41 +0100 (CET)
Date: Wed, 27 Mar 2024 18:44:41 +0100
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
Subject: Re: [PATCH v2 1/2] media: dt-binding: media: Document =?utf-8?Q?r?=
 =?utf-8?B?azM1ODjigJlz?= VEPU121
Message-ID: <slcatcuemy67vzpffpkfae3nl6cspl2i552reg5kfb2kiqizph@6mizgczdxaoq>
References: <20240327134115.424846-1-linkmauve@linkmauve.fr>
 <20240327134115.424846-2-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtzkc6b6fd7hw3mr"
Content-Disposition: inline
In-Reply-To: <20240327134115.424846-2-linkmauve@linkmauve.fr>


--mtzkc6b6fd7hw3mr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

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
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

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

--mtzkc6b6fd7hw3mr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYEWwEACgkQ2O7X88g7
+ppeUw/7BmJGGQaOaqtdWI5UfDshWNPMP1M3soxWvm414UxmhcM70ho2GpVfXy5H
d3d9z6cviDdZpV/n5/jKxIX6V3HQRfiErMOuRuXNucF5xhclurKvjEPAOlHF7iJD
wc1JGWXHTNeIiQTHQrXy5xtXoNOPkasAZlJhl94HTCdwWCUPTMzIT/XRHZctHw76
gl7XK72P+Zf0a01iwoeMuT7mRwc2GPq7wG/tHCHKH9b5rjc4PsIIbCTvZqFnNvGT
XaSLv51JJrv4r1L5h90ztEPfpzmSJzjT8nCMRaCardIVyWmBVZqRyRvu6XBZBuTn
AwpevquLQ0K8ic73rmR0jSRJkYVG9pCuH4gtk9F39+Qe3f3p9oT6ZBi33cdpGdgh
nD28w6nH2QETds93j8EzMiBeZnTClEz+xgmaxYFCEk4Nuaok8qWfzIzg5iFvKIDw
rOxHoozydZvj9eQvt7lVUeuTzedT+JAZkn3XTSw9QudfzvY+TRE4nY4aJnUpxUEe
D0VFzsVn45/zBTsxTUFLw8XFYyW5KEujj5m+vRbACQpYfhk53Vf5r/jZzHKjB9gZ
AIUH3rEuDo82oAnYPrYhjGOKbNNSX74lpOCienrfJu2OjLE/4suGKRGkW7TbFU8C
9Qqv38fDYHS5BEMbLzY790wtqJBYL5NDDEtTncDqR4HcllE12m0=
=2t0W
-----END PGP SIGNATURE-----

--mtzkc6b6fd7hw3mr--

