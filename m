Return-Path: <linux-kernel+bounces-27640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B38982F389
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE28C285169
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B42B1CD10;
	Tue, 16 Jan 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIFPiJwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592361CD01;
	Tue, 16 Jan 2024 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427751; cv=none; b=RyDc89O+IM0gitLXKp3bZGNGH9b0Y3eQvMlE0awOAb8Y6sQQJkMsa1kFK9bne2wdADuZ/Kx7jJPVV0r/dJvGKYRCIC4s4JAbzhJIGZR9bEJtLK3coLD/b2AogIpUG29OfR2xuISdcIhF+aF6jWshssH/VslwohVszGXJ4/u3Q2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427751; c=relaxed/simple;
	bh=A7WpPOEyCtH2adKAYF4nilFbx0bdiAYZdsfDGpAubDg=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=uCWYezOPA7aOAsk+pe3Bc42tH+IIYBqRZJpbqBe1LjYaN4VQ+s13L6T79iofeCdyJab5S4sknJkAI60LR1jGiXWW/g/xKHQGxI3I9vR7UnuKHDAUJFuaKujACSv9fYXQYi2kA8JQDnZfttufikuNSCvjRo+amarg1wC0Q9ZIfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIFPiJwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CA3BC433C7;
	Tue, 16 Jan 2024 17:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705427750;
	bh=A7WpPOEyCtH2adKAYF4nilFbx0bdiAYZdsfDGpAubDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIFPiJwhUgdRy26zRTMTIuX5fW2jwJKHQQTkKOxwN2HvpVn/od3MRM9C4W/I7qUgi
	 K1QyRJ8Ie6+XBd2ke2Loy8Ex0b2GvEwK0AsAYQc0CqPHl5rgo0W6FVo4NHhfHkB6aS
	 RFDcsruqxnHWSnJul+f5Fyp8CHEG8QmGuLCPHN7sr/RpR2Fe1fynQm0iUojU9wXs+B
	 /JDad+LE7e7FVd9WbnnU+RfcdtqcAi9Jqq0uGM2WtYTvg1LyVWpPs+a6EZ+PaWzIrw
	 psQRNYsdftFcEmk7IYLU+Q0UNsQZTSttxRajtNYuDZ9a0HG3vVMHPZBKCOvRx4w0vp
	 6IJlabfVJ4fzw==
Date: Tue, 16 Jan 2024 17:55:43 +0000
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
Subject: Re: [PATCH v2 1/3] dt-bindings: display: convert Atmel's HLCDC to DT
 schema
Message-ID: <20240116-coastal-amply-e495b07726df@spud>
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-2-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M3diZ8Ne17+OylG0"
Content-Disposition: inline
In-Reply-To: <20240116113800.82529-2-dharma.b@microchip.com>


--M3diZ8Ne17+OylG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Tue, Jan 16, 2024 at 05:07:58PM +0530, Dharma Balasubiramani wrote:
> Convert the existing DT binding to DT schema of the Atmel's HLCDC display
> controller.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> changelog
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify filename like compatible.
> - Modify title (drop words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Remove pinctrl properties which aren't required.
> - Ref endpoint and not endpoint-base.
> - Drop redundant info about bus-width description and add ref to video-in=
terfaces.
> - Move 'additionalProperties' after 'Required'.
> - Drop parent node and it's other sub-device node which are not related h=
ere.
> - Add compatible to example 2 and add comments that bus-width is the diff=
 between two examples.
> ---
>  .../atmel/atmel,hlcdc-display-controller.yaml | 110 ++++++++++++++++++
>  .../bindings/display/atmel/hlcdc-dc.txt       |  75 ------------
>  2 files changed, 110 insertions(+), 75 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/atmel/atmel=
,hlcdc-display-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/display/atmel/hlcdc=
-dc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-=
display-controller.yaml b/Documentation/devicetree/bindings/display/atmel/a=
tmel,hlcdc-display-controller.yaml
> new file mode 100644
> index 000000000000..f022c294cfbc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/atmel/atmel,hlcdc-display=
-controller.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/atmel/atmel,hlcdc-display-con=
troller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's High LCD Controller (HLCDC)
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description: |

This | is not needed as you have no formatting to preserve.

> +  The LCD Controller (LCDC) consists of logic for transferring LCD image
> +  data from an external display buffer to a TFT LCD panel. The LCDC has =
one
> +  display input buffer per layer that fetches pixels through the single =
bus
> +  host interface and a look-up table to allow palletized display
> +  configurations.
> +
> +properties:
> +  compatible:
> +    const: atmel,hlcdc-display-controller
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  port@0:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    unevaluatedProperties: false
> +    description:
> +      Output endpoint of the controller, connecting the LCD panel signal=
s.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      reg:
> +        maxItems: 1
> +
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint

$ref: /schemas/media/video-interfaces.yaml#

to match approximately all other endpoints?

> +        unevaluatedProperties: false
> +        description:
> +          Endpoint connecting the LCD panel signals.
> +
> +        properties:
> +          bus-width:
> +            description: Endpoint bus width.
> +            $ref: /schemas/media/video-interfaces.yaml#

and then bus-width's type is already defined for you, no?

> +            enum: [ 12, 16, 18, 24 ]
> +
> +required:
> +  - '#address-cells'
> +  - '#size-cells'
> +  - compatible
> +  - port@0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    //Example 1
> +
> +    display-controller {
> +      compatible =3D "atmel,hlcdc-display-controller";
> +      pinctrl-names =3D "default";
> +      pinctrl-0 =3D <&pinctrl_lcd_base &pinctrl_lcd_rgb888>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      port@0 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        reg =3D <0>;
> +
> +        hlcdc_panel_output: endpoint@0 {
> +          reg =3D <0>;
> +          remote-endpoint =3D <&panel_input>;
> +        };
> +      };
> +    };
> +
> +  - |
> +    //Example 2 With a video interface override to force rgb565, bus-wid=
th=3D16
> +
> +    display-controller {
> +      compatible =3D "atmel,hlcdc-display-controller";
> +      pinctrl-names =3D "default";
> +      pinctrl-0 =3D <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      port@0 {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        reg =3D <0>;

Should be a newline here before the child node.

Cheers,
Conor.

> +        hlcdc_panel_output2: endpoint@0 {
> +          reg =3D <0>;
> +          remote-endpoint =3D <&panel_input>;
> +          bus-width =3D <16>;
> +        };
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt=
 b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> deleted file mode 100644
> index 923aea25344c..000000000000
> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
> +++ /dev/null
> @@ -1,75 +0,0 @@
> -Device-Tree bindings for Atmel's HLCDC (High LCD Controller) DRM driver
> -
> -The Atmel HLCDC Display Controller is subdevice of the HLCDC MFD device.
> -See ../../mfd/atmel-hlcdc.txt for more details.
> -
> -Required properties:
> - - compatible: value should be "atmel,hlcdc-display-controller"
> - - pinctrl-names: the pin control state names. Should contain "default".
> - - pinctrl-0: should contain the default pinctrl states.
> - - #address-cells: should be set to 1.
> - - #size-cells: should be set to 0.
> -
> -Required children nodes:
> - Children nodes are encoding available output ports and their connections
> - to external devices using the OF graph representation (see ../graph.txt=
).
> - At least one port node is required.
> -
> -Optional properties in grandchild nodes:
> - Any endpoint grandchild node may specify a desired video interface
> - according to ../../media/video-interfaces.txt, specifically
> - - bus-width: recognized values are <12>, <16>, <18> and <24>, and
> -   override any output mode selection heuristic, forcing "rgb444",
> -   "rgb565", "rgb666" and "rgb888" respectively.
> -
> -Example:
> -
> -	hlcdc: hlcdc@f0030000 {
> -		compatible =3D "atmel,sama5d3-hlcdc";
> -		reg =3D <0xf0030000 0x2000>;
> -		interrupts =3D <36 IRQ_TYPE_LEVEL_HIGH 0>;
> -		clocks =3D <&lcdc_clk>, <&lcdck>, <&clk32k>;
> -		clock-names =3D "periph_clk","sys_clk", "slow_clk";
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
> -
> -Example 2: With a video interface override to force rgb565; as above
> -but with these changes/additions:
> -
> -	&hlcdc {
> -		hlcdc-display-controller {
> -			pinctrl-names =3D "default";
> -			pinctrl-0 =3D <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
> -
> -			port@0 {
> -				hlcdc_panel_output: endpoint@0 {
> -					bus-width =3D <16>;
> -				};
> -			};
> -		};
> -	};
> --=20
> 2.25.1
>=20

--M3diZ8Ne17+OylG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZabDHwAKCRB4tDGHoIJi
0rzVAQDXJ1TQ1k0nCXBFIKNZ39yzTXWYH98QUx/HdCzWsNYangD8ChAiKtj801cY
BMVPytUV5tnGQJvaA2g/fcfgvl5suQM=
=84qM
-----END PGP SIGNATURE-----

--M3diZ8Ne17+OylG0--

