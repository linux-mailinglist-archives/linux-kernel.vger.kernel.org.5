Return-Path: <linux-kernel+bounces-42952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A8840936
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA5E28B99E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C39154433;
	Mon, 29 Jan 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdHsffo5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69EB15442B;
	Mon, 29 Jan 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540377; cv=none; b=rEdb6F1nhJD2GhyEJVX6Lgdth9OVsvo+curVEZzWf1ssl5m1RWviliWQoH9gUY7ENiPWt50PFDhNyPUb+taTadCAOgisg/4g33/WDNxjeMvIJBjRihFigc2xkzadwI7BKKvnc24IE5QP0u66QODgLsM9v0CsZhuIjGeexYqvfpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540377; c=relaxed/simple;
	bh=3l8vvbKif7wVC7bMTkrcO4TBaNj6h0QNy/ZaLjauggs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjnoy9u8Zgpe8UUQWDseAVkDqojbByVcDg4M31t3bIbNUEPi4emu+hOfwKopA+HqdUkv6ZbhgBJ/VRbIRKsxjXLqwJ2kjNMuW0w87PLpAKzwkzqXktZFOv9GOwipsVuEs5CHjVVhgU55Ap+1ClQa0uXmiLgQOrRCYmUz90LDQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdHsffo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB376C433F1;
	Mon, 29 Jan 2024 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706540377;
	bh=3l8vvbKif7wVC7bMTkrcO4TBaNj6h0QNy/ZaLjauggs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdHsffo5LUizRilMlDjB1Uv2hRYUcIxYkrso2AOiHRmM0i3yI39QhMvvxkv3UQQdN
	 RBsKGPDjuExrtQHT6Z1wAJadW+tSKB+hlfufpA9RunqHTE2pVfQGlG92hl65fbH+lL
	 81wM8rhC2dvaJ9GR47tng6u1VMDeBXY4+52D859SzGMSaYobiIH8/aJjrQxmnHpwO4
	 +lN63QzEjpsW/1TZK4uEsBGHH8/dazlH7OC7g77K26aDvm1kKSczNuzADp6WwcrjCj
	 fQk2AxtQCTMe0XrJEjyV7nxbEraMsi1rXYoKHEGIy+SV8bln2uSby2RIYu7h+hiH4K
	 8Kr7MZB9RWhEA==
Date: Mon, 29 Jan 2024 14:59:31 +0000
From: Conor Dooley <conor@kernel.org>
To: William Qiu <william.qiu@starfivetech.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-can@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 1/4] dt-bindings: vendor-prefixes: Add cast vendor
 prefix
Message-ID: <20240129-pavement-fondue-31f29ac2033c@spud>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129031239.17037-2-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cogiGBIc/MCqykSX"
Content-Disposition: inline
In-Reply-To: <20240129031239.17037-2-william.qiu@starfivetech.com>


--cogiGBIc/MCqykSX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 11:12:36AM +0800, William Qiu wrote:
> Add prefix for Computer-Aided Software Technologies, Inc.
>=20
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Doc=
umentation/devicetree/bindings/vendor-prefixes.yaml
> index 1a0dc04f1db4..b9c6ce99d24d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -242,6 +242,8 @@ patternProperties:
>      description: Capella Microsystems, Inc
>    "^cascoda,.*":
>      description: Cascoda, Ltd.
> +  "^cast,.*":
> +    description: Computer-Aided Software Technologies, Inc.
>    "^catalyst,.*":
>      description: Catalyst Semiconductor, Inc.
>    "^cavium,.*":
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--cogiGBIc/MCqykSX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbe9UwAKCRB4tDGHoIJi
0vnBAP4h9TeV8gpl0bK+1Wd48qmmmXDASj7WbF2vhDFdPDrdXgEArDrOKaRpACUE
s0brDp0M/KU4k7zpGc/9tpYV64sqgg8=
=vPXn
-----END PGP SIGNATURE-----

--cogiGBIc/MCqykSX--

