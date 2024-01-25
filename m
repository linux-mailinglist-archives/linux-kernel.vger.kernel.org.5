Return-Path: <linux-kernel+bounces-38963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB483C90C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D661F2379E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95355133981;
	Thu, 25 Jan 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2zHOe3H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4C113B7A9;
	Thu, 25 Jan 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201603; cv=none; b=NIgmSexQ3m+bp4YGPnEwtgGHKD74UpJ1ufnTaGMOTPIrtHH0u7F8zDc8XjL2v8vw1nHEO2zTmj/eHv+sknbJNv7E4X813oA5f9c+zWE6b74dmU0aoI+GWTK8Z17pHy6cQ8Q3d32+eaGO/NcYPqz6TBtWdCs4+4QV7bUsv462Nyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201603; c=relaxed/simple;
	bh=fFqYQf2Ioug03KTYcEhivp25SqR4a74lXWToRhDCB5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/RMYXux+Ry34kJ4j2M9I2RPwghxixQ4og7E4KffavBbuda3QBdA0FMJMlBCiSIUW2uEgg6WzDsrC99jTZYbZc9M0d3+BSELQY9iC4zGz+hPXfdkfQa9jKVp4xinefEoBa+Yd6PC/A72m6GbZ4JJdxj/MkLZlCJJpxdHI0xP21E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2zHOe3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EFDC433C7;
	Thu, 25 Jan 2024 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706201603;
	bh=fFqYQf2Ioug03KTYcEhivp25SqR4a74lXWToRhDCB5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k2zHOe3HSp+eKRDlV3Qg6LSBTVwzBH+zN24FBQ7roQjk4a86ORFgTl+yH5A+rIFBE
	 E3kro04MtEqR+cnxhq2mP8RmsrCXpl419C8lEV7a/F3xe/yvuMhPvPjshZdiGTDnHP
	 mNZpMQdQB+kQFxLovuP0J8/8qW2aXhrWoPiK0CF9e//+K18ooG2gyEkPQDxAej2iO9
	 3pMia+ApD1qEEWb7qnd/LVakVI6GPuyC05GWbJHlIY/SeVMpugqAngPRA5fzgVCW+b
	 nvTbPfxzO7AhZatULg5V2ltFaHwQHHXpeyOn9DrwbySw12Ec6+1GuYMy2FJUr70L4k
	 RIRwjLMSb+OnA==
Date: Thu, 25 Jan 2024 16:53:17 +0000
From: Conor Dooley <conor@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Bai Ping <ping.bai@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: timer: nxp,sysctr-timer: support
 i.MX95
Message-ID: <20240125-hesitant-coronary-913ecc6bbd8b@spud>
References: <20240125-imx-sysctr-v2-0-7332470cd7ae@nxp.com>
 <20240125-imx-sysctr-v2-1-7332470cd7ae@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3xUZ7W5LVUTSJCCk"
Content-Disposition: inline
In-Reply-To: <20240125-imx-sysctr-v2-1-7332470cd7ae@nxp.com>


--3xUZ7W5LVUTSJCCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 07:09:47PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX95 System counter module compatible string, the SCMI
> firmware blocks access to control register, so should not
> add "nxp,sysctr-timer" as fallback.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yam=
l b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> index 2b9653dafab8..161c09d9e2c3 100644
> --- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
> @@ -18,7 +18,10 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: nxp,sysctr-timer
> +    items

This is just an enum, no need for the items.

Thanks,
Conor.

> +      - enum:
> +          - nxp,imx95-sysctr-timer
> +          - nxp,sysctr-timer
> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.37.1
>=20

--3xUZ7W5LVUTSJCCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKR/QAKCRB4tDGHoIJi
0ifmAQCP5ByEO4rLsnM1nRFgS/Pldy/Nt4in+j58Ai4EzqtfwgD/RSeJ/IdREcS5
abSK65muMRwu0y69T/ZiAjWRUXbZsA4=
=QIUL
-----END PGP SIGNATURE-----

--3xUZ7W5LVUTSJCCk--

