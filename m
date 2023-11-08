Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E857E5B12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjKHQW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjKHQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:22:26 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD9C6;
        Wed,  8 Nov 2023 08:22:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78010E0005;
        Wed,  8 Nov 2023 16:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699460542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhqyKIfQiLDCQw3+/m1qr9gZDzgsUQcERlUMieh/IsQ=;
        b=RhArlp78TEwwBeDaV2g1sCkmHpcm3fbuv8voGvoqtRKPHiXs8PEbcm5okdSo2WyoDDZbHS
        EvIOE20Hgq7CK43VMGcyoi1SFXRDyZsg6nR09lxJaCHsmyN0qRKskA0IfxFA97XZ/h1vV6
        4xWXIApsHmXpwbXskA2bvOt9XCXbf0jYJ3ajg0EfU0fj8N0peTHeQ0+t+if76tap70Vurf
        g5EfpEbTXQJv/1ESFQ02CVZ7hLvLbmsKrb6Lny5GoUoOjqI32l7Er+NBQYmXde4vdWgNqi
        LYnpHyWVsCgsuJzTcvB27Byh3/zRrnS0QJ8dl87MZVKn8szuTRu9X4XVmmFRLg==
Date:   Wed, 8 Nov 2023 17:22:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Howard Harte <hharte@magicandroidapps.com>
Subject: Re: [PATCH 2/6] dt-bindings: mtd: Rewrite gpio-control-nand in
 schema
Message-ID: <20231108172218.25309994@xps-13>
In-Reply-To: <20231108-fix-mips-nand-v1-2-5fc5586d04de@linaro.org>
References: <20231108-fix-mips-nand-v1-0-5fc5586d04de@linaro.org>
        <20231108-fix-mips-nand-v1-2-5fc5586d04de@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

linus.walleij@linaro.org wrote on Wed, 08 Nov 2023 15:33:50 +0100:

> This creates a schema for GPIO controlled NAND. The txt
> schema was old and wrong.
>=20
> Mark the old way of passing GPIOs in a long array as
> deprecated and encourage per-pin GPIO assignments with
> the named nnn-gpios phandles.
>=20
> I was unable to re-use raw-nand-chip.yaml or even
> nand-chip.yaml: the reason is that they both assume
> that we have potentially several NAND chips with chip
> selects and thus enforce a node name "nand@0" etc,
> which doesn't quite work for this device.

But what about nand-controller.yaml? This driver is just about
emulating what a NAND controller would do with GPIOs, any NAND chip can
be wired, no?

> Since the GPIO controlled NAND is both a NAND controller
> and a NAND chip jitted together,=20

Not really, it's just the controller part? I know for years
NAND controllers, ECC engines and NAND chips have been considered a
single hardware entity, but I believe this one is just about emulating
the host controller part.

> I have to modify the
> mtd.yaml nodename requirement to include nand-controller@
> as this is the nodename that this device should use.
>=20
> Deprecate the custom "band-width" property in favor of
> "nand-bus-width".
>=20
> Reported-by: Howard Harte <hharte@magicandroidapps.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Check the required section especially. Since there is no
> hardware default for anything when using GPIOs for this,
> I think all these parameters are compulsory.
> ---
>  .../devicetree/bindings/mtd/gpio-control-nand.txt  |  47 ------
>  .../devicetree/bindings/mtd/gpio-control-nand.yaml | 168 +++++++++++++++=
++++++
>  Documentation/devicetree/bindings/mtd/mtd.yaml     |   2 +-
>  3 files changed, 169 insertions(+), 48 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt =
b/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
> deleted file mode 100644
> index 486a17d533d7..000000000000
> --- a/Documentation/devicetree/bindings/mtd/gpio-control-nand.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -GPIO assisted NAND flash
> -
> -The GPIO assisted NAND flash uses a memory mapped interface to
> -read/write the NAND commands and data and GPIO pins for the control
> -signals.
> -
> -Required properties:
> -- compatible : "gpio-control-nand"
> -- reg : should specify localbus chip select and size used for the chip. =
 The
> -  resource describes the data bus connected to the NAND flash and all ac=
cesses
> -  are made in native endianness.
> -- #address-cells, #size-cells : Must be present if the device has sub-no=
des
> -  representing partitions.
> -- gpios : Specifies the GPIO pins to control the NAND device.  The order=
 of
> -  GPIO references is:  RDY, nCE, ALE, CLE, and nWP. nCE and nWP are opti=
onal.
> -
> -Optional properties:
> -- bank-width : Width (in bytes) of the device.  If not present, the width
> -  defaults to 1 byte.
> -- chip-delay : chip dependent delay for transferring data from array to
> -  read registers (tR).  If not present then a default of 20us is used.
> -- gpio-control-nand,io-sync-reg : A 64-bit physical address for a read
> -  location used to guard against bus reordering with regards to accesses=
 to
> -  the GPIO's and the NAND flash data bus.  If present, then after changi=
ng
> -  GPIO state and before and after command byte writes, this register wil=
l be
> -  read to ensure that the GPIO accesses have completed.
> -
> -The device tree may optionally contain sub-nodes describing partitions o=
f the
> -address space. See partition.txt for more detail.
> -
> -Examples:
> -
> -gpio-nand@1,0 {
> -	compatible =3D "gpio-control-nand";
> -	reg =3D <1 0x0000 0x2>;
> -	#address-cells =3D <1>;
> -	#size-cells =3D <1>;
> -	gpios =3D <&banka 1 0>,	/* RDY */
> -		<0>, 		/* nCE */
> -		<&banka 3 0>, 	/* ALE */
> -		<&banka 4 0>, 	/* CLE */
> -		<0>;		/* nWP */
> -
> -	partition@0 {
> -	...
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mtd/gpio-control-nand.yaml=
 b/Documentation/devicetree/bindings/mtd/gpio-control-nand.yaml
> new file mode 100644
> index 000000000000..5b30ee7ad4a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpio-control-nand.yaml
> @@ -0,0 +1,168 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/gpio-control-nand.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NAND memory exclusively connected to GPIO lines
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  It is possible to connect a NAND flash memory without any
> +  dedicated NAND controller hardware, using just general purpose
> +  I/O (GPIO) pins. This will not be fast, but it will work.
> +  The address and data lines of the chip will still need to be
> +  connected so that the contents of a NAND page can be
> +  memory-mapped and accessed after the special lines are toggled
> +  by GPIO.
> +
> +# The GPIO controlled NAND has wires going directly to one single
> +# NAND chip, so it is both a nand controller and a nand chip at
> +# the same time, but it does not have things such as chip select
> +# since the use is hammered down to one single chip only.
> +# There is no point for the chip itself to be a subnode of the
> +# controller so the raw NAND chip properties are added right into
> +# the controller node like this.

I kind of disagree here, this "piece of software" only replaces a NAND
controller. You always need a NAND chip in front of it, and that's a
specific piece of hardware anyway. Or maybe I don't understand the
hardware behind? (truly not impossible)

> +
> +allOf:
> +  - $ref: mtd.yaml#
> +
> +properties:
> +  $nodename:
> +    pattern: "^(nand|nand-controller)@[a-f0-9]+$"
> +
> +  compatible:
> +    const: gpio-control-nand
> +
> +  reg:
> +    description: |
> +      This should specify the address where the NAND page currently
> +      accessed gets memory-mapped, and the size of the page. Usually
> +      this will be the same as the page size of the NAND.

This is definitely a host controller parameter. Even if the hardware
only supports a single NAND chip, I believe it should be described as a
subnode with a dummy "reg =3D <0>;" property.

Thanks,
Miqu=C3=A8l
