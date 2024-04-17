Return-Path: <linux-kernel+bounces-148803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF08A879E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC6B263A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA7146013;
	Wed, 17 Apr 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKGBtSPH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC092140389;
	Wed, 17 Apr 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367842; cv=none; b=tIK9dtWfEySHzyEF4gnWaWfr9n3Y76vwQBQxqhiYJ0bZS/JdFYOLcOoYDnxzM8TubYbPnHCNoXHPzhPqXGSWHmFG89TV1QyWMRaNBtJx5W/aF/QloIuouRAq9QRl3vzwXJGFE30r8LhDyUjkmFR5R+R2n1sNd0zcSUmSJNoTIL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367842; c=relaxed/simple;
	bh=T10GCAoSEXIyxHwYZsHjVKz3I8WrET0txqcl9LUivpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOYZAbbQqhQhHtqhOygi/qihJ6YGbB59ZCWnTiV7XIUTAD37H/Ugdr4P9ap/NE/nbzlw37WIcAU8L/P2BNDTXeECjJ/9sshzNJvPewRj7fwyPdJE2+f53fUaeNg3q+GH+00bc1uEbi5sKsIlyFEZ5Mz1iibg9TEgl6CultQTkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKGBtSPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B2CC072AA;
	Wed, 17 Apr 2024 15:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713367842;
	bh=T10GCAoSEXIyxHwYZsHjVKz3I8WrET0txqcl9LUivpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QKGBtSPHZ3Kq1JXJ3zaKvhalMQyl0Ndix07pcYRGqQLr9rwZIgiaFbWsYsfSinVC3
	 eG9Yoj5NpU8W7vjGU/vauD83qs1zW9o5BnhJzqgpiuXefklvXlsE8vza55C1tImQ32
	 IFt/Uhg5zZFFlls6T8AID07HPBvZQ2iXw+5Q/UZstC1UhKvkk0x80nVQnZeLy41HFn
	 WZvnP1a2SvYAIhaqXoUo6gFR3YSyaSXFxM0OBtHaAJmpmFytLqB1EOMFRyhP/i+ilP
	 aLB8LhNhit6GjgwNianbWOudrfNoBgtoIJn+XMzWLdenW8DH1hjKF5hh+bSK4fBbih
	 GKISv7jf29hMg==
Date: Wed, 17 Apr 2024 16:30:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Pratik Farkase <pratikfarkase94@gmail.com>
Cc: Pratik Farkase <pratik.farkase@wsisweden.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: serial: brcm,bcm2835-aux-uart: convert
 to dtschema
Message-ID: <20240417-cornbread-grass-01fef5866624@spud>
References: <20240417135111.20375-1-pratik.farkase@wsisweden.com>
 <20240417-obscure-denial-ae7c53d0e321@spud>
 <CACy_QWNpUtDz16RWOHf_-xBhtwt_66_4xCaSf+wzPKFz9c6D0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/VMrDNL5G58/U56J"
Content-Disposition: inline
In-Reply-To: <CACy_QWNpUtDz16RWOHf_-xBhtwt_66_4xCaSf+wzPKFz9c6D0A@mail.gmail.com>


--/VMrDNL5G58/U56J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 05:19:18PM +0200, Pratik Farkase wrote:
> On Wed, Apr 17, 2024 at 4:54=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Wed, Apr 17, 2024 at 03:51:10PM +0200, Pratik Farkase wrote:
> > > Convert the Broadcom BCM2835 Auxiliary UART to newer DT schema.
> > > Created DT schema based on the .txt file which had
> > > `compatible`, `reg` `clocks` and `interrupts` as the
> > > required properties. This binding is used by Broadcom BCM2835
> > > SOC used in some Raspberry PI boards.
> > > Changes from original file:
> > > Implemented complete example which the original txt binding lacked.
> > >
> > > Signed-off-by: Pratik Farkase <pratik.farkase@wsisweden.com>
> > > ---
> > > Changes in v2
> > > - Updated Maintainers list according to feedback
> > > - Fixed typo `Auxiliar` to `Auxiliary`
> > > ---
> > > ---
> > >  .../bindings/serial/brcm,bcm2835-aux-uart.txt | 18 -------
> > >  .../serial/brcm,bcm2835-aux-uart.yaml         | 48 +++++++++++++++++=
++
> > >  2 files changed, 48 insertions(+), 18 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm=
2835-aux-uart.txt
> > >  create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm=
2835-aux-uart.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-au=
x-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart=
=2Etxt
> > > deleted file mode 100644
> > > index b5cc6297cd1b..000000000000
> > > --- a/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.=
txt
> > > +++ /dev/null
> > > @@ -1,18 +0,0 @@
> > > -* BCM2835 AUXILIAR UART
> > > -
> > > -Required properties:
> > > -
> > > -- compatible: "brcm,bcm2835-aux-uart"
> > > -- reg: The base address of the UART register bank.
> > > -- interrupts: A single interrupt specifier.
> > > -- clocks: Clock driving the hardware; used to figure out the baud ra=
te
> > > -  divisor.
> > > -
> > > -Example:
> > > -
> > > -     uart1: serial@7e215040 {
> > > -             compatible =3D "brcm,bcm2835-aux-uart";
> > > -             reg =3D <0x7e215040 0x40>;
> > > -             interrupts =3D <1 29>;
> > > -             clocks =3D <&aux BCM2835_AUX_CLOCK_UART>;
> > > -     };
> > > diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm2835-au=
x-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uar=
t.yaml
> > > new file mode 100644
> > > index 000000000000..5d4d37371d6b
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.=
yaml
> > > @@ -0,0 +1,48 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/serial/brcm,bcm2835-aux-uart.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: BCM2835 AUXILIARY UART
> > > +
> > > +maintainers:
> > > +  - Pratik Farkase <pratikfarkase94@gmail.com>
> > > +  - Florian Fainelli <florian.fainelli@broadcom.com>
> > > +  - Stefan Wahren <wahrenst@gmx.net>
> > > +
> > > +allOf:
> > > +  - $ref: serial.yaml
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: brcm,bcm2835-aux-uart
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - interrupts
> > > +  - clocks
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/bcm2835.h>
> > > +    #include <dt-bindings/clock/bcm2835-aux.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> >
> > Only 1 of these headers seems used, there's only one define below.
> >
> > > +    uart1: serial@7e215040 {
> >
> > The label is unused and can be dropped.
> I did not understand this part. What do you suggest i change it into?
> I took the example from original dtsi file:
> arch/arm/boot/dts/broadcom/bcm283x.dtsi

s/uart1: //
The "uart1" part is a label. The dtsi needs it so that the &uart1 syntax
can be used from a dts file to set properties etc, but that's no
required in bindings where there are no references to the node, so we
remove them.

Hope that helps,
Conor.

> >
> > Otherwise,
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--/VMrDNL5G58/U56J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh/rHAAKCRB4tDGHoIJi
0pLSAP4hwHK2HYpQZqO9UFv9hKkwsu03hDqMcUz5NwYjY2yAkQD/fKG+RTqnSxkO
72S3AQAMmZo6zHiHeK72RNrk1Nbk0AY=
=KhE3
-----END PGP SIGNATURE-----

--/VMrDNL5G58/U56J--

