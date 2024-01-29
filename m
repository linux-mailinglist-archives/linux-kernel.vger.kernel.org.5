Return-Path: <linux-kernel+bounces-43200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCBD8410C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40E81F22BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1976C85;
	Mon, 29 Jan 2024 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+K69jKW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373F76C79;
	Mon, 29 Jan 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706549437; cv=none; b=Ye7lYxlLBRFUKrH6DwSomNjG2L//fbli3w11vBgM8WSFfFFRDi0Fe4HedROKeJ8pw5b0UQfon2VpdOOkZcySXiS0sdWyawjoBMbks8agVfEgoS5sDHLm0Gf/qqZVur+H+4gDbXGS/0JDgjiNlE6y634nNdxp+82dxjUprt3aTXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706549437; c=relaxed/simple;
	bh=OXQd1RnjO7UJeTnd9b35uKkSkUJf85ceg9kIDyszIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bherHQ9hz6l9zYgm5bcqTXUky8cwJA9z+mjET0JMORDS8UOQo9pLn0p6qa8n1w6C5kF6qXR7N6EGycEUOSkRQozpdh5VbyfnviwUj6/1GDGqrmqvJUFTAQlnXmpkNiqE8Ybq0DnCN1Lmsrn2qNuJJjOjIN162nClDHxJ9y47I78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+K69jKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E4CC433C7;
	Mon, 29 Jan 2024 17:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706549436;
	bh=OXQd1RnjO7UJeTnd9b35uKkSkUJf85ceg9kIDyszIk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+K69jKWZIF69OHl7PMAE41J0uqd1KVWsmsLishPqiVhnQXmGHaePGHbFCGBWgtDD
	 833c7oemkGkJ7LfpHyexjIZnfGU0Vi+PWWnI5YUWXbZFvOtRalWswI1jfLu4rjdSgu
	 MKoK5Jb7qx+divI6WtIGPx+HXtAm5mNGWi76TRKXD6ppuDCZF+9rNGt756SwvJa8iq
	 4VihGKgCQ/HeC700lCi7aVVw7ggiZVLsM+c0o6uXdcBp4Q1Cq1TMfg6Or0rd7fvQdf
	 WUQptqLE3iI4BMV63lNP9SahrI6VOONxYXfSFvWQrJEyA3aKs6EkrE10vJVDmwkeeE
	 GHa19xQe2PbLg==
Date: Mon, 29 Jan 2024 17:30:30 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
Message-ID: <20240129-magical-unclaimed-e725e2491ccb@spud>
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ygn/mpQIjskR0FcW"
Content-Disposition: inline
In-Reply-To: <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com>


--Ygn/mpQIjskR0FcW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 03:16:14PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on RZ/Five SoC
> is almost identical to one found on the RZ/G2L SoC with below differences,
> * Additional BUS error interrupt
> * Additional ECCRAM error interrupt
> * Has additional mask control registers for NMI/IRQ/TINT
>=20
> Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/Five
> SoC.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../renesas,rzg2l-irqc.yaml                   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller=
/renesas,rzg2l-irqc.yaml
> index d3b5aec0a3f7..3abc01e48934 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2=
l-irqc.yaml
> @@ -23,6 +23,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - renesas,r9a07g043f-irqc   # RZ/Five
>            - renesas,r9a07g043u-irqc   # RZ/G2UL
>            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
>            - renesas,r9a07g054-irqc    # RZ/V2L
> @@ -88,6 +89,12 @@ properties:
>        - description: GPIO interrupt, TINT30
>        - description: GPIO interrupt, TINT31
>        - description: Bus error interrupt
> +      - description: ECCRAM0 TIE1 interrupt
> +      - description: ECCRAM0 TIE2 interrupt
> +      - description: ECCRAM0 overflow interrupt
> +      - description: ECCRAM1 TIE1 interrupt
> +      - description: ECCRAM1 TIE2 interrupt
> +      - description: ECCRAM1 overflow interrupt
> =20
>    interrupt-names:
>      minItems: 41
> @@ -134,6 +141,12 @@ properties:
>        - const: tint30
>        - const: tint31
>        - const: bus-err
> +      - const: eccram0-tie1
> +      - const: eccram0-tie2
> +      - const: eccram0-ovf
> +      - const: eccram1-tie1
> +      - const: eccram1-tie2
> +      - const: eccram1-ovf

I think the restrictions already in the file become incorrect with this
patch:
  - if:
      properties:
        compatible:
          contains:
            enum:
              - renesas,r9a07g043u-irqc
              - renesas,r9a08g045-irqc
    then:
      properties:
        interrupts:
          minItems: 42
        interrupt-names:
          minItems: 42
      required:
        - interrupt-names

This used to require all 42 interrupts for the two compatibles here
and at least the first 41 otherwise. Now you've increased the number of
interrupts to 48 thereby removing the upper limits on the existing
devices.

Given the commit message, I figure that providing 48 interrupts for
(at least some of) those devices would be incorrect?

Cheers,
Conor.

> =20
>    clocks:
>      maxItems: 2
> @@ -180,6 +193,20 @@ allOf:
>        required:
>          - interrupt-names
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a07g043f-irqc
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 48
> +        interrupt-names:
> +          minItems: 48
> +      required:
> +        - interrupt-names
> +
>  unevaluatedProperties: false
> =20
>  examples:
> --=20
> 2.34.1
>=20

--Ygn/mpQIjskR0FcW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbfgtgAKCRB4tDGHoIJi
0oqzAQDRsNsMgRYlDd+DmTlEOCZC0GxDFYdGkW9k02+U2C2kUAD/Q+SgbLDfDyC8
+6lTLc/HCbiewN8LWm/xBVSaQNYbWwk=
=5vqQ
-----END PGP SIGNATURE-----

--Ygn/mpQIjskR0FcW--

