Return-Path: <linux-kernel+bounces-51124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F0B8486D3
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B0052852D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929B5EE8E;
	Sat,  3 Feb 2024 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSh5vQ8u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6205D8E7;
	Sat,  3 Feb 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971797; cv=none; b=GAxqcKYXDlcFkc+fMP6FnK5QKJZEXpGoIosKUI6gje3ex2+YFCO2CDwuANaR7oaAdZvNoz/BHjWM5hoKgb02ww38TWePKzrlIRT3tJSNZzpcu156iKFnX13Bl7tva85c/eejF0HamroB2dmHp5DJErafhXHIihzCdYeUK7PWQCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971797; c=relaxed/simple;
	bh=5ctG5h8mEiQAu9NdNXA4+XFyWIp25c6pytmgpTEtD2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snpFT7VF3i2rKY8jOR94rvsSmeW4jwIr8OSI1gd16or7/J9nQdrnvYAR4y1x3ug3eszPzBBm8RHGdq4xlglRtlnuX267k1zX/rlkvX1HGTOhJ7L4+uW7//oCDwJiQbd7bIfjoYkAdAM25Sz1LRiuJPVSl3HxJJWH/ur0pO51YmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSh5vQ8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D780C433F1;
	Sat,  3 Feb 2024 14:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706971797;
	bh=5ctG5h8mEiQAu9NdNXA4+XFyWIp25c6pytmgpTEtD2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uSh5vQ8usObzfCmqjYrQoE5B1ZtZ3tDCGsR4EBCuLPWMoozl4vy84blzVU9AJA4XT
	 puueVthAvgqm5TXxSI5NPwIxq4W6cgJg7duKCBUpDO/9cwHe+hKSRcjaNi73dZ2ZzQ
	 tQeMHvHKBfkVKea7kVSeA42jRL4P5ocf4d1Mh5DhoZ/Oa1FV8YdXsdRqcJLCefdL0w
	 QtLYEnmrF0XjgrXbwsc8543J0UY3duyIrQLjAj22Iu20KE0cArltNnSjnHgUpra/ri
	 KFmQk1qcxDQb4xNzOjkDGE2NGnef7J4tHp81ui6URq920Ghs5Hs5BTgNUH4ELNAnf2
	 rCb8buZ0u6CYg==
Date: Sat, 3 Feb 2024 14:49:50 +0000
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
Subject: Re: [PATCH v4 03/12] dt-bindings: mtd: brcmnand: Add ecc strap
 property
Message-ID: <20240203-expenses-tarmac-c564bc7ae34f@spud>
References: <20240203002834.171462-1-william.zhang@broadcom.com>
 <20240203002834.171462-4-william.zhang@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z/AOuDAE/L8fKLSt"
Content-Disposition: inline
In-Reply-To: <20240203002834.171462-4-william.zhang@broadcom.com>


--z/AOuDAE/L8fKLSt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 04:28:24PM -0800, William Zhang wrote:
> Add brcm,nand-ecc-use-strap to get ecc and spare area size settings from
> board boot strap for broadband board designs because they do not specify
> ecc setting in dts but rather using the strap setting.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>=20
> ---
>=20
> Changes in v4:
> - Move ecc strap property to this separate patch and remove some
> non-binding related text from the description
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml b/D=
ocumentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> index d0168d55c73e..2599d902ec3a 100644
> --- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> @@ -147,6 +147,14 @@ patternProperties:
>            layout.
>          $ref: /schemas/types.yaml#/definitions/uint32
> =20
> +      brcm,nand-ecc-use-strap:
> +        description:
> +          This flag indicates the ecc strength and spare area size should
> +          be retrieved from the SoC NAND boot strap setting instead of
> +          nand-ecc-strength and brcm,nand-oob-sector-size or auto detect=
ion.

I'm still on the fence about this being overly prescriptive about the
operating systems behaviour. I think it would be good to say why the
strap values are better than those explicitly provided in DT rather than
just saying "these strap values should be used".

> +          This is commonly used by the BCMBCA SoC board design.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
>      unevaluatedProperties: false
> =20
>  allOf:
> --=20
> 2.37.3
>=20

--z/AOuDAE/L8fKLSt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZb5SjgAKCRB4tDGHoIJi
0tWnAP9mesDP/aST3xwWYHD8YvKXyojpcT4bQMcvlk7eIb6bLQEA++HFzMX/8fDp
xvzyDoEeIOF7mwJLYnJs2aHZBWDl3Qc=
=qcHg
-----END PGP SIGNATURE-----

--z/AOuDAE/L8fKLSt--

