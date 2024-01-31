Return-Path: <linux-kernel+bounces-47154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 008038449EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD25A2862E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E64939ACA;
	Wed, 31 Jan 2024 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8x09sGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B839840;
	Wed, 31 Jan 2024 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736134; cv=none; b=XgPFth/iUzuLzeWFfmqpMqbshwsNeF3aLyKL57e0Si6A+Q3Ays1XmNfA3j+vW3BsXCPaVM57gBgxk7BukZyQADruCLoJuCIMtEgo6xazLnFGRZejV7Dr6Cg4qbfI2okJos2XwsSiv9vuNQGUOftUR3T/GzE1ByfpXFMm0HFFC7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736134; c=relaxed/simple;
	bh=6/S3gn/MU54WmcTkqkBqwpun43sj6keFl/lVKEDYooU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liTiWMdbDhQptMo4+gvVzu1qhJHMTevFai4zTAcrMD8z98wewz8uagaowzIETMdh+bmJfOYa7v+JCGf0i/3KZ5lsexvPLLqZgqDrALFmKnu5Y1CXtZ2EKIErfG20PXaay39VBkl84E140QjgfMRqeeV/5U4ERgmh7ueVaznZTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8x09sGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AA4C433C7;
	Wed, 31 Jan 2024 21:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706736134;
	bh=6/S3gn/MU54WmcTkqkBqwpun43sj6keFl/lVKEDYooU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8x09sGYO00YuYlSGlkT2akkv0shyGx869qM0+Nclutea46M8UdJZb/sudyW+01w3
	 Jicz2TGobc8mmXGtUcRO676xFf5CxWOa+rr3tiHFrVxliKJSUjU+ESbv/my7hu12XJ
	 Epun7n4H9pPPOm3amIXwK03nbrD1z9rMwAk623ucM6/AByBA+sy8d26F4V+3Df6WT5
	 3JUZm7wUEB+1M9GEh6bTCy784yonSr1hbrTs7VC8MH/9c9eAYCULOtp9g3n7KSzZmL
	 OP6X8RZVQ3PJD+aolPH6o2ZuKmj1B0asR2j5rKV1NVyNASsT8UjvMjYRCpcD6aGRY3
	 Y1uZup2ac2gKQ==
Date: Wed, 31 Jan 2024 21:22:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	John Watts <contact@jookia.org>,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20240131-renewably-glimpse-a80339e8ff81@spud>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
 <20240131125920.2879433-2-privatesub2@gmail.com>
 <20240131145244.4f534bac@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lXyhdNnqG2jz+p5F"
Content-Disposition: inline
In-Reply-To: <20240131145244.4f534bac@donnerap.manchester.arm.com>


--lXyhdNnqG2jz+p5F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 02:52:44PM +0000, Andre Przywara wrote:
> On Wed, 31 Jan 2024 15:59:14 +0300
> Aleksandr Shubin <privatesub2@gmail.com> wrote:
>=20
> Hi,
>=20
> > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > controller witch is different from the previous pwm-sun4i.
> >=20
> > The D1 and T113 are identical in terms of peripherals,
> > they differ only in the architecture of the CPU core, and
> > even share the majority of their DT. Because of that,
> > using the same compatible makes sense.
> > The R329 is a different SoC though, and should have
> > a different compatible string added, especially as there
> > is a difference in the number of channels.
> >=20
> > D1 and T113s SoCs have one PWM controller with 8 channels.
> > R329 SoC has two PWM controllers in both power domains, one of
> > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> >=20
> > Add a device tree binding for them.
> >=20
> > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 88 +++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun=
20i-pwm.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm=
=2Eyaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > new file mode 100644
> > index 000000000000..716f75776006
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Allwinner D1, T113-S3 and R329 PWM
> > +
> > +maintainers:
> > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: allwinner,sun20i-d1-pwm
> > +      - items:
> > +          - const: allwinner,sun20i-r329-pwm
> > +          - const: allwinner,sun20i-d1-pwm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 3
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus clock
> > +      - description: 24 MHz oscillator
> > +      - description: APB0 clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: hosc
> > +      - const: apb0
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  allwinner,pwm-channels:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The number of PWM channels configured for this instan=
ce
> > +    enum: [6, 9]
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: allwinner,sun20i-r329-pwm
> > +
> > +    then:
> > +      required:
> > +        - allwinner,pwm-channels
> > +
> > +    else:
> > +      properties:
> > +        allwinner,pwm-channels: false
>=20
> Do we really need to be that strict?
> If something compatible to D1 pops up in the future, just with a different
> number of channels, we would need a new compatible string.

Well, you would want to have a soc specific compatible anyway then,
right?

> If we would leave this else branch out, we could just specify some
> number differing from the default, and be good.

If it were compatible with the d1, then the "then:" branch would apply,
provided you used the fallback correctly. Although if the number of
channels were different, we'd likely end up with modifications here to
limit it to the correct values for each soc.

Cheers,
Conor.

> The number of channels really looks like a parameter to the IP, it's
> modelled like this in the manual (PCR: 0x0100 + 0x0000 + N * 0x0020).

--lXyhdNnqG2jz+p5F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbq5/gAKCRB4tDGHoIJi
0m7lAQDMB3FXHeE2sd+nUCjULoFP3QBAMejcAL5DVTHwwcfoCwEAmITUfiKctPUZ
aRVAUnCJ7PvSkH3019Ou5tyacXCp1gY=
=b0st
-----END PGP SIGNATURE-----

--lXyhdNnqG2jz+p5F--

