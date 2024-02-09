Return-Path: <linux-kernel+bounces-59748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE784FB34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AF41F29DC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44007EF06;
	Fri,  9 Feb 2024 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmXERWD4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9D7E115;
	Fri,  9 Feb 2024 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500528; cv=none; b=fk4Z3OkAdwilOio5CIg2PG5A0yuB4SJWpUS7wd+0GqQk2xiIL4fBiHrlUs2X6qJF7iRTVWO+sTSwR0D33hBxjRCvByHdOWVl+E8QCTgWiqWEIF7k5vCiZtyZbWIwDlRpN0vi99w3AP9mpdxYwE3eg6oUixL9RghBn6p2xkNsRc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500528; c=relaxed/simple;
	bh=HF9PftpJsOvVmalzJ2URbYmTYhyNPvu3Hk7v1fBL/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuvtAGdCzyIzoJSA0j6LfQgqFF5qFFo+yEfGKA9JEauzyrXs5A9XqT1vgbhUImivM82IBzdZAj3+BkdGxZ3iuL4YVSxh5oYTlhODMMDnJNC0quu01PwTlUAEt8jrGxKGl1QjkNKi1Tns4K0qxTx7Eb4v6CKQ018Mkcfo7A6LSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmXERWD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C992C433F1;
	Fri,  9 Feb 2024 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707500527;
	bh=HF9PftpJsOvVmalzJ2URbYmTYhyNPvu3Hk7v1fBL/aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cmXERWD4o3IX37eOr45+H2TjuzQgGl46WADdo35xY6KpftoYOEkD+OdAuJb3GycgC
	 1ySOeHpBhi1mGt3MBJos2MddUJgbGky+nd8ei8yhw4HnR351m4B9cQe3bw7018i4wD
	 Wdt/c5U+wuAhQLpe76toLC7rHaGvnIwQIdNc+Wb+ehQ4T6p8x3XwPg5QbAgF9Xitvg
	 bwUrvmz+lmChMYRRvr+xLik5/eZG7freTmCi3hIn6CTlVh+Dmu2C4GHNeNKxYZjkLK
	 SxoJhnvyd/dHX0jp9b799ULXoBx+NRw5KemrRcT4sLL8MwfDjIeFETOSjtZ9HGIZbl
	 tnFo5gLqFVYjQ==
Date: Fri, 9 Feb 2024 17:42:00 +0000
From: Conor Dooley <conor@kernel.org>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
	f.fainelli@gmail.com, kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com, anand.gore@broadcom.com, dregan@mail.com,
	kamal.dasu@broadcom.com, tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com, devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
Message-ID: <20240209-jalapeno-estate-a1371c281bc7@spud>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
 <20240207202257.271784-4-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4eFKpvXR/FSb5KR1"
Content-Disposition: inline
In-Reply-To: <20240207202257.271784-4-william.zhang@broadcom.com>


--4eFKpvXR/FSb5KR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2024 at 12:22:48PM -0800, William Zhang wrote:
> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
> board boot strap for broadband board designs because they do not specify
> ecc setting in dts but rather using the strap setting.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

If Miquel is happy with this, then I am too.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> ---
>=20
> Changes in v5:
> - Update the description for this ecc strap property
> - Add check to make sure brcm,nand-ecc-use-strap and
>   nand-ecc-strength/brcm,nand-oob-sector-size can not be used at the
>   same time
>=20
> Changes in v4:
> - Move ecc strap property to this separate patch and remove some
> non-binding related text from the description
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  .../bindings/mtd/brcm,brcmnand.yaml           | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/D=
ocumentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index 6a717bcedfd3..52a4c993b6f1 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -146,6 +146,13 @@ patternProperties:
>            layout.
>          $ref: /schemas/types.yaml#/definitions/uint32
> =20
> +      brcm,nand-ecc-use-strap:
> +        description:
> +          This property requires the host system to get the ECC strength
> +          and step size from the SoC NAND boot strap setting. This is a
> +          common hardware design on BCMBCA based boards.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
>      unevaluatedProperties: false
> =20
>  allOf:
> @@ -195,6 +202,18 @@ allOf:
>        required:
>          - interrupt-names
> =20
> +  - if:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          required:
> +            - brcm,nand-ecc-use-strap
> +    then:
> +      patternProperties:
> +        "^nand@[a-f0-9]$":
> +          properties:
> +            nand-ecc-strength: false
> +            brcm,nand-oob-sector-size: false
> +
>  unevaluatedProperties: false
> =20
>  required:
> --=20
> 2.37.3
>=20

--4eFKpvXR/FSb5KR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcZj6AAKCRB4tDGHoIJi
0txwAP9L9cpXbp0KAt/EmZ9qFjK+FmzE6kOodOMW0T5ocDkcTgD/U7ygxkY+t+lE
Ip1OM3oe2ziXosKS9QoxgxRpePiD1gc=
=n7ED
-----END PGP SIGNATURE-----

--4eFKpvXR/FSb5KR1--

