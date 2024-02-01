Return-Path: <linux-kernel+bounces-48740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A486A846082
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ABA288F18
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4575785288;
	Thu,  1 Feb 2024 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpD4ef5O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C585276;
	Thu,  1 Feb 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706813978; cv=none; b=k9lesqRsMmURAEK/qUHyNqNmFOmQPTppFqBy7IKHABiWlFHuzZTAWTKdqfmhI8xw4KBg1qQq2uJowO9jJD2r/YptzsdcbBqR+NSgFQCFHn8JVU7pvSotAQICuN0fo+9s582Hkwx9vnQGGoBkB0Yp+WwtV+clNjDTglzUq+s7gAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706813978; c=relaxed/simple;
	bh=I1NNXAkgesc7dKK6HS2ID8NMVYdnGuoGc/8FPQaG/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhVQFK9oI8lsbCo+K99dgh0Ye9lvfAz8tZGL6CG8Z8tuivocyUC3LUMruS+7Sq3fAq5k+V9nIvrJUphjoDjZi+Jiop0szFZmFnFdS+NBiGAeDw5lmNyS7rNuI6Eyskuc98wB1MmrzPOJw51g3FR1NkWiBtQc5UsyfFXchJ7y+Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpD4ef5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9CEC43394;
	Thu,  1 Feb 2024 18:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706813977;
	bh=I1NNXAkgesc7dKK6HS2ID8NMVYdnGuoGc/8FPQaG/B8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rpD4ef5OrMVjIPscn4IEXS/9g9WKcBMmDKBFa3kyUooemnxgqmRn8spZZiz30At7n
	 3aJw/14Ac/p94rgwHvpllfDNQ1nhNMqA4a3+roejfSbXeUNyWW95jwwM/v+yPm24YN
	 A/GOS7G8pDrAb2fA1ruCCN4/wKa6ODQpYhm3b0Xh4Q1O9y48Xei1adx8QNl4GOwoUm
	 +w+vHuUOX+c9gDOlS6K2gLxXa6p0cg+TcciextdkDVNcZPL2qq6tQrKtQls0Ku+pm1
	 HS3kswBOIw2kP9KScsbUvLlQOzZWsf5znJVqftfRt1PthT+m9usgrDE+1Zc3hRUxr9
	 ttjEHh290bmKg==
Date: Thu, 1 Feb 2024 18:59:30 +0000
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
Message-ID: <20240201-numbing-reconcile-64d05bb88e9c@spud>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
 <20240131125920.2879433-2-privatesub2@gmail.com>
 <20240131145244.4f534bac@donnerap.manchester.arm.com>
 <20240131-renewably-glimpse-a80339e8ff81@spud>
 <20240201174851.62e74089@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wPn/chEO+X1eK+Gn"
Content-Disposition: inline
In-Reply-To: <20240201174851.62e74089@donnerap.manchester.arm.com>


--wPn/chEO+X1eK+Gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 05:48:51PM +0000, Andre Przywara wrote:
> On Wed, 31 Jan 2024 21:22:06 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> Hi,
>=20
> > On Wed, Jan 31, 2024 at 02:52:44PM +0000, Andre Przywara wrote:
> > > On Wed, 31 Jan 2024 15:59:14 +0300
> > > Aleksandr Shubin <privatesub2@gmail.com> wrote:
> > >=20
> > > Hi,
> > >  =20
> > > > Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> > > > controller witch is different from the previous pwm-sun4i.
> > > >=20
> > > > The D1 and T113 are identical in terms of peripherals,
> > > > they differ only in the architecture of the CPU core, and
> > > > even share the majority of their DT. Because of that,
> > > > using the same compatible makes sense.
> > > > The R329 is a different SoC though, and should have
> > > > a different compatible string added, especially as there
> > > > is a difference in the number of channels.
> > > >=20
> > > > D1 and T113s SoCs have one PWM controller with 8 channels.
> > > > R329 SoC has two PWM controllers in both power domains, one of
> > > > them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> > > >=20
> > > > Add a device tree binding for them.
> > > >=20
> > > > Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > ---
> > > >  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 88 +++++++++++++++=
++++
> > > >  1 file changed, 88 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner=
,sun20i-pwm.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i=
-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> > > > new file mode 100644
> > > > index 000000000000..716f75776006
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.ya=
ml
> > > > @@ -0,0 +1,88 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Allwinner D1, T113-S3 and R329 PWM
> > > > +
> > > > +maintainers:
> > > > +  - Aleksandr Shubin <privatesub2@gmail.com>
> > > > +  - Brandon Cheo Fusi <fusibrandon13@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    oneOf:
> > > > +      - const: allwinner,sun20i-d1-pwm
> > > > +      - items:
> > > > +          - const: allwinner,sun20i-r329-pwm
> > > > +          - const: allwinner,sun20i-d1-pwm
> > > > +
> > > > +  reg:
> > > > +    maxItems: 1
> > > > +
> > > > +  "#pwm-cells":
> > > > +    const: 3
> > > > +
> > > > +  clocks:
> > > > +    items:
> > > > +      - description: Bus clock
> > > > +      - description: 24 MHz oscillator
> > > > +      - description: APB0 clock
> > > > +
> > > > +  clock-names:
> > > > +    items:
> > > > +      - const: bus
> > > > +      - const: hosc
> > > > +      - const: apb0
> > > > +
> > > > +  resets:
> > > > +    maxItems: 1
> > > > +
> > > > +  allwinner,pwm-channels:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > +    description: The number of PWM channels configured for this in=
stance
> > > > +    enum: [6, 9]
> > > > +
> > > > +allOf:
> > > > +  - $ref: pwm.yaml#
> > > > +
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: allwinner,sun20i-r329-pwm
> > > > +
> > > > +    then:
> > > > +      required:
> > > > +        - allwinner,pwm-channels
> > > > +
> > > > +    else:
> > > > +      properties:
> > > > +        allwinner,pwm-channels: false =20
> > >=20
> > > Do we really need to be that strict?
> > > If something compatible to D1 pops up in the future, just with a diff=
erent
> > > number of channels, we would need a new compatible string. =20
> >=20
> > Well, you would want to have a soc specific compatible anyway then,
> > right?
>=20
> So the idea would be to add any new (specific) compatible string to that
> list then, when we add them?
> I guess this would work, but strictly speaking any current driver would
> then only need to check this property for the R329 type? The Linux
> driver proposed in the next patch *always* honours the
> allwinner,pwm-channels property, which is IMHO the right way to implement
> this. And that's why I think the binding should reflect that, and not
> explicitly *forbid* the property for every one other than R329 (atm).
>=20
> With the current Linux driver, a potential new SoC using:
> 	"allwinner,sun20i-d2-pwm", "allwinner,sun20i-d1-pwm";
> 	allwinner,pwm-channels =3D <6>;
> would work without driver changes. A driver strictly written to this
> binding here might not, though, as it would be free to ignore the
> pwm-channels property.
>=20
> Does that make sense? So to encourage future compatibility, can we drop
> the "else" branch?

Oh true, I see what you mean now with the example you gave. I wouldn't
respin for this alone, since the else branch could be dropped when
another user showed up given the driver doesn't restrict things.
I'm okay with your suggestion though.

Cheer,
Conor.

--wPn/chEO+X1eK+Gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbvqEgAKCRB4tDGHoIJi
0isTAQDdFIn8101DHoxqtxIzz2mXhQfAvSLN9IhSEoRLYtQYEQEA1ZfnLAFf02Qr
FQmM5dsp/NBIxR7GwMaSW1en5yD5pgw=
=tg0K
-----END PGP SIGNATURE-----

--wPn/chEO+X1eK+Gn--

