Return-Path: <linux-kernel+bounces-109388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82188187A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA47F1F2257B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51838594B;
	Wed, 20 Mar 2024 20:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xR4qmmjm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15E85933;
	Wed, 20 Mar 2024 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965821; cv=none; b=V9w8SbhYRbS6T/R/torpGsv3IFbXXixJlu/QcUKc8o8+byD7gRrOtpW5m0MtnlAPAsuTFQo5e7Y/bfsc8ktQ6wV6Bg+41iLoyY6Smq3U6DYcDNVBs7PUpzfgbFlSCCBOgDFOnE9KSu0v7FmSG8AUtqCP7V4hNIkuTni6e4gk5xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965821; c=relaxed/simple;
	bh=nj7MzyFExeNZhnwzBI8kDS3G0ZyqJ2Qb0WQL/c4YNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuKtofglu3UHcMUNuCTW2sg5dgBG4dvtla/igviHQVjKGadCnxwFTEHPez441vIic/hiIyFdom6NkwyFgDJvqAfLMGLBKyiVRYIJeZCTnDPyp+eqIO9a4dLeXgi9YLw/rD2PX0Dp7rFKsl94QYJyzVMTiPdTAQN+8aCDQ4mUGZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xR4qmmjm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710965817;
	bh=nj7MzyFExeNZhnwzBI8kDS3G0ZyqJ2Qb0WQL/c4YNTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xR4qmmjmVsPHZiwnD1RdLOW7zqjrJdorBZiwzDr7tAN4XceB3s8mavvGGo/RQpYbq
	 NErdndNsfObCsEajJM53XCuwRLGcmy53XT9RFdZTSH4PbU0himWp5bJ6ziSE6/gwZP
	 C+3wBjpB+7JYKlT9V2UvkOAawuOAjtG47Vn/INijwJydYJtYlKn1YjaMJ9KMRhBYOi
	 0gexHeXZAZViBT6JVTZzrmy3WYVRDysem/ZwN1/lwkMbWa5LfMAOOKPzCA7feecy/A
	 gzWzdXJxx9r6eEj1gU7PBa9Hud6lVpNwRFiE+hXGibLtyr3PO+MHEey9XOkFsgFNhO
	 cgoeR/01S4SaQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 762FA37814A4;
	Wed, 20 Mar 2024 20:16:57 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id F3F9B1060704; Wed, 20 Mar 2024 21:16:56 +0100 (CET)
Date: Wed, 20 Mar 2024 21:16:56 +0100
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
Subject: Re: [PATCH 2/4] media: dt-binding: media: Document =?utf-8?Q?rk35?=
 =?utf-8?B?ODjigJlz?= vepu121
Message-ID: <uxdndbyetuxxt6icjw7ptlsq6h2ltup7dc35vwbs2i3qvmid2c@33gztzqf7ehm>
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
 <20240320173736.2720778-3-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h5b2n4ltpigo6emq"
Content-Disposition: inline
In-Reply-To: <20240320173736.2720778-3-linkmauve@linkmauve.fr>


--h5b2n4ltpigo6emq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 20, 2024 at 06:37:31PM +0100, Emmanuel Gil Peyrot wrote:
> This encoder-only device is present four times on this SoC, and should
> support everything the rk3568 vepu supports (so JPEG, H.264 and VP8
> encoding).
>=20
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../devicetree/bindings/media/rockchip,rk3568-vepu.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu=
=2Eyaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> index 9d90d8d0565a..947ad699cc5e 100644
> --- a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> +++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3568-vepu
> +      - rockchip,rk3588-vepu121

Looks like they are fully compatible. In that case it's better to
use a fallback compatible (i.e. like the iommu binding), which does
not need any drivers changes. So binding should be like this:

compatible:
  oneOf:
    - const: rockchip,rk3568-vepu
    - items:
      - enum:
          - rockchip,rk3588-vepu121
      - const: rockchip,rk3568-vepu

Then in DT (i.e. the following patch) you use

compatible =3D "rockchip,rk3588-vepu121", "rockchip,rk3568-vepu";

And patch 4/4 can be dropped.

Greetings,

-- Sebastian

--h5b2n4ltpigo6emq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmX7RC4ACgkQ2O7X88g7
+pq/5g/+IlGV2VBxSGO7OhBFSPRfHCOwTmN5HMpgyVmMQ0b/V+5c4KFuNR5EJJL/
X0ysDd35GBI8qi8M9h3SziSkGjMqyW+HEWKvsTX+nk+AiQav93ze2cVJdcbbHvh8
HGJc1Wu3FxvjIpTGResLeDEPxYxJLtABD+jUE7/897Ra15JBmVRkhutCMljxKZve
lu4/9vWD2D0gDLOlo3Foxrt4zPrGzQuRQQ+0ATrc+auWQmxgXqztnNJXjDBvOfoo
+6822tBJH03S0dp1/i+rmkZO9qPSqh2dcLURkAThhr5YI7fmHhjGjKfo/aDXvmBD
olNJcBjTtkswotDHN/i/arBcQIgPyYAZgoKSwVGR9yq+PbRJyliF63pFVlXZSfIc
rOEU3+5j5ydliUe8VKV1mVJBzvTB47xnccHSS89CjhhrovYl2u8wDNexy9YWo4WN
tB2msuOHWH+m3YbVAln6IYRt5OxX0MF5rhoFiB5HFWY9xpfmhUFAaUKPfwCibWDp
WjH4S2VHQh2kFfyjPvTMSZME6QPCKkgCaxOkyEJFVUABge2Bb/fZHx2yekNghF7i
GpEYx+FuzFMkli7dcJ+gPX4rEQLkb4wEiUnW0+yIvB+5L660JARx7i+uDakR/C9Z
59dOdJSv6tFDkvu/rqTeQBKssjO5505TiDVwYcn55iFKCMGcUk0=
=pn+0
-----END PGP SIGNATURE-----

--h5b2n4ltpigo6emq--

