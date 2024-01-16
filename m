Return-Path: <linux-kernel+bounces-27666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D20382F3DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE11C23901
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C711CD2C;
	Tue, 16 Jan 2024 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6N2n1YU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C71CD0B;
	Tue, 16 Jan 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428879; cv=none; b=Rm8FFZ7Y+9Ym9W5RSn0uL5FuWniYfhboxIcORRp/cJDRhzGQO9mkdqQh6Pc1hN2TQ46vT2zTRRCM1RxW4XE9Isnfq577lsA3SPxOAbwqgOsDSO1Mkl6HfYEN/Cojhtf3jxuX/uWRb9BNLP//BRi3cn2HfVUvWZUPJ9sr31xmzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428879; c=relaxed/simple;
	bh=XqGWFN9qw3I7S+8oXQ8vgsY2LlPy6DwWiwVeRJX8jtY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ASnkLgqO2WT5Iwh1tW2ZomKiQwrqkRQL8Dy9tlpMCS4XBdf3C4mH2VoYChH35qN2BdfIVxFrSxBl0HLAqkPKKf5jkCNQM6SWOdOSMqGMIMLC+yspcNaq/niLBv0TXALILOi4waROX/CvHGKuVEArDYZHtzxg5SO4YWJDAThc65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6N2n1YU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F0DC433F1;
	Tue, 16 Jan 2024 18:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705428879;
	bh=XqGWFN9qw3I7S+8oXQ8vgsY2LlPy6DwWiwVeRJX8jtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6N2n1YUqR9yoVur4zZBArRAgQpi1c4PbX7YJQiZkk5Tk0FUOQ36hxNBnsT2IWICQ
	 R9tNDvd1IYAPiW3TvfFK6jgDw3/m9kgPp0JZolwPMRaIq4EdIKze144Q3Xy18C96sZ
	 PM7Ep81S2x6TUhvw/vewRFgnsBeqfoZP72vQP1vfHcnoXCKi6wXjbYqIOQG4h4dVuc
	 RijxzIZEfmIdbdilNNUQ/NPXJ8yMTlILAocahmsTk9CbyY06cvafMZ7SjR0w1dInwZ
	 qBdPcdZ7gVcF+sws/q8ujl6BGSRO8q3zXUz0OWA47XdnRtyA2S/+nhdqudhUESHd/2
	 lF44R599rR5Ew==
Date: Tue, 16 Jan 2024 18:14:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	linux4microchip@microchip.com
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: atmel,hlcdc: Convert to DT
 schema format
Message-ID: <20240116-flatten-animate-f30842548e9d@spud>
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-4-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+ECF9lc6dEAb7wF0"
Content-Disposition: inline
In-Reply-To: <20240116113800.82529-4-dharma.b@microchip.com>


--+ECF9lc6dEAb7wF0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 05:08:00PM +0530, Dharma Balasubiramani wrote:
> Convert the atmel,hlcdc binding to DT schema format.
>=20
> Adjust the clock-names property to clarify that the LCD controller expects
> one of these clocks (either sys_clk or lvds_pll_clk to be present but not
> both) along with the slow_clk and periph_clk. This alignment with the act=
ual
> hardware requirements will enable accurate device tree configuration for
> systems using the HLCDC IP.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify title (not include words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Add details of lvds_pll addition in commit message.
> - Ref endpoint and not endpoint-base.
> - Fix coding style.
>=20
> Note: Renaming hlcdc-display-controller, hlcdc-pwm to generic names throws
> errors from the existing DTS files.

I don't think that is important. If there is no code that depends on the
node names (and there is not in the mainline kernel, not sure about
anywhere else) the binding and the devicetree could easily adopt generic
node names.

> ...
> /home/dharma/Mainline/linux/arch/arm/boot/dts/microchip/at91sam9n12ek.dtb:
> hlcdc@f8038000: 'hlcdc-display-controller' does not match any of the
> regexes: 'pinctrl-[0-9]+'
> ---
>  .../devicetree/bindings/mfd/atmel,hlcdc.yaml  | 105 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-hlcdc.txt   |  56 ----------
>  2 files changed, 105 insertions(+), 56 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml b/Doc=
umentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> new file mode 100644
> index 000000000000..f624b60b76fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/atmel,hlcdc.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/atmel,hlcdc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCD Controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description: |
> +  The Atmel HLCDC (HLCD Controller) IP available on Atmel SoCs exposes t=
wo
> +  subdevices
> +    # a PWM chip:
> +    # a Display Controller:

The formatting here is a bit odd. I'd truncate this to
"subdevices: a PWM chip and a display controller." & drop the |.

> +properties:
> +  compatible:
> +    enum:
> +      - atmel,at91sam9n12-hlcdc
> +      - atmel,at91sam9x5-hlcdc
> +      - atmel,sama5d2-hlcdc
> +      - atmel,sama5d3-hlcdc
> +      - atmel,sama5d4-hlcdc
> +      - microchip,sam9x60-hlcdc
> +      - microchip,sam9x75-xlcdc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 3
> +
> +  clock-names:
> +    anyOf:
> +      - items:
> +          - enum:
> +              - sys_clk
> +              - lvds_pll_clk
> +      - contains:
> +          const: periph_clk
> +      - contains:
> +          const: slow_clk
> +    maxItems: 3

Why not just:
  clock-names:
    items:
      - const: periph_clk
      - enum: [sys_clk, lvds_pll_clk]
      - const: slow_clk

Cheers,
Conor.

> +
> +  hlcdc-display-controller:
> +    $ref: /schemas/display/atmel/atmel,hlcdc-display-controller.yaml
> +
> +  hlcdc-pwm:
> +    $ref: /schemas/pwm/atmel,hlcdc-pwm.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/at91.h>
> +    #include <dt-bindings/dma/at91.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    lcd_controller: lcd-controller@f0030000 {
> +      compatible =3D "atmel,sama5d3-hlcdc";
> +      reg =3D <0xf0030000 0x2000>;
> +      clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> +      clock-names =3D "periph_clk", "sys_clk", "slow_clk";
> +      interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +      hlcdc-display-controller {
> +        compatible =3D "atmel,hlcdc-display-controller";
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        port@0 {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +          reg =3D <0>;
> +
> +          hlcdc_panel_output: endpoint@0 {
> +            reg =3D <0>;
> +            remote-endpoint =3D <&panel_input>;
> +          };
> +        };
> +      };
> +
> +      hlcdc-pwm {
> +        compatible =3D "atmel,hlcdc-pwm";
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> +        #pwm-cells =3D <3>;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt b/Docu=
mentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> deleted file mode 100644
> index 7de696eefaed..000000000000
> --- a/Documentation/devicetree/bindings/mfd/atmel-hlcdc.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Device-Tree bindings for Atmel's HLCDC (High LCD Controller) MFD driver
> -
> -Required properties:
> - - compatible: value should be one of the following:
> -   "atmel,at91sam9n12-hlcdc"
> -   "atmel,at91sam9x5-hlcdc"
> -   "atmel,sama5d2-hlcdc"
> -   "atmel,sama5d3-hlcdc"
> -   "atmel,sama5d4-hlcdc"
> -   "microchip,sam9x60-hlcdc"
> -   "microchip,sam9x75-xlcdc"
> - - reg: base address and size of the HLCDC device registers.
> - - clock-names: the name of the 3 clocks requested by the HLCDC device.
> -   Should contain "periph_clk", "sys_clk" and "slow_clk".
> - - clocks: should contain the 3 clocks requested by the HLCDC device.
> - - interrupts: should contain the description of the HLCDC interrupt line
> -
> -The HLCDC IP exposes two subdevices:
> - - a PWM chip: see ../pwm/atmel-hlcdc-pwm.txt
> - - a Display Controller: see ../display/atmel/hlcdc-dc.txt
> -
> -Example:
> -
> -	hlcdc: hlcdc@f0030000 {
> -		compatible =3D "atmel,sama5d3-hlcdc";
> -		reg =3D <0xf0030000 0x2000>;
> -		clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> -		clock-names =3D "periph_clk","sys_clk", "slow_clk";
> -		interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> -
> -		hlcdc-display-controller {
> -			compatible =3D "atmel,hlcdc-display-controller";
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> -			#address-cells =3D <1>;
> -			#size-cells =3D <0>;
> -
> -			port@0 {
> -				#address-cells =3D <1>;
> -				#size-cells =3D <0>;
> -				reg =3D <0>;
> -
> -				hlcdc_panel_output: endpoint@0 {
> -					reg =3D <0>;
> -					remote-endpoint =3D <&panel_input>;
> -				};
> -			};
> -		};
> -
> -		hlcdc_pwm: hlcdc-pwm {
> -			compatible =3D "atmel,hlcdc-pwm";
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> -			#pwm-cells =3D <3>;
> -		};
> -	};
> --=20
> 2.25.1
>=20

--+ECF9lc6dEAb7wF0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZabHiAAKCRB4tDGHoIJi
0uasAQCiVJvgHAWSIdArOBPKYA0i6KIc1zXakFfntet4tkWOYwD/QHfy3s4v0Omb
AqUVcZAx5XPwUIZXDytRbbmWLaHJ/QM=
=yXNW
-----END PGP SIGNATURE-----

--+ECF9lc6dEAb7wF0--

