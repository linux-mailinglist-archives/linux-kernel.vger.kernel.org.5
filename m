Return-Path: <linux-kernel+bounces-1615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F68150EB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6744328AC43
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDEE45BF1;
	Fri, 15 Dec 2023 20:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWpnZ5+J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4080C45976;
	Fri, 15 Dec 2023 20:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60920C433C8;
	Fri, 15 Dec 2023 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702671111;
	bh=EUiuIHWpQWay5Non15wnwY2bYiIVOSA0QToDDvFgkvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWpnZ5+JVYPcKTuLcXuH8iyhfMZjJmqZE14hu9sPks72iIxwQFNy9oxIuY1KhLCSi
	 TuWtX5oeU5k07pOON0GzP5edTlKbUML6BVygLNOzHJ1XKHlOQkxpkm1bJqgHLK00T0
	 tbMmkvOvyAKJInBePMR6S7lMEN6W+8AhheSMaFlX373hhcbuttEL70FhDod5eer1mu
	 rYd7aoWQ3oXl5Q1t8GRvO1E7fNw+TROFWTugq9yBXBMNTg8PzAiutHBZbFpi7UnLx9
	 ZYisAMAcLr+gVZTbxaPol66jJmRZSKCdSDUeiXJpwQkwP3DuCjUWoLCCSYUBn7CUEn
	 IZPMCGn4KOjbQ==
Received: (nullmailer pid 315123 invoked by uid 1000);
	Fri, 15 Dec 2023 20:11:48 -0000
Date: Fri, 15 Dec 2023 14:11:48 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 4/7] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Message-ID: <20231215201148.GA304363-robh@kernel.org>
References: <20231215-pinctrl-scmi-v1-0-0fe35e4611f7@nxp.com>
 <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215-pinctrl-scmi-v1-4-0fe35e4611f7@nxp.com>

On Fri, Dec 15, 2023 at 07:56:32PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SCMI v3.2 pinctrl protocol bindings and example.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml     | 99 ++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 4591523b51a0..bfd2b6a89979 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -247,6 +247,85 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@19:
> +    type: object
> +    allOf:
> +      - $ref: '#/$defs/protocol-node'
> +      - $ref: /schemas/pinctrl/pinctrl.yaml
> +      - if:
> +          properties:
> +            compatible:
> +              const: fsl,imx95-scmi-pinctrl
> +        then:
> +          patternProperties:
> +            "grp$": false
> +            "-pins$": true
> +        else:
> +          patternProperties:
> +            "grp$": false
> +            "-pins$": true
> +    unevaluatedProperties: false

This will not scale if each vendor adds to arm,scmi.yaml. You need to 
move this to its own file. That can have a ref to 
/schemas/firmware/arm,scmi.yaml#/$defs/protocol-node.

Here you can just say compatible is "fsl,imx95-scmi-pinctrl" and 
'additionalProperties: true'.

> +
> +    properties:
> +      reg:
> +        const: 0x19
> +
> +      '#pinctrl-cells':
> +        const: 0

Generally not used if 0.

> +
> +      compatible:
> +        const: fsl,imx95-scmi-pinctrl
> +
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        allOf:
> +          - $ref: /schemas/pinctrl/pincfg-node.yaml#
> +          - $ref: /schemas/pinctrl/pinmux-node.yaml#
> +        unevaluatedProperties: false
> +
> +        description:
> +          A pin multiplexing sub-node describe how to configure a
> +          set of pins is some desired function.
> +          A single sub-node may define several pin configurations.
> +          This sub-node is using default pinctrl bindings to configure
> +          pin multiplexing and using SCMI protocol to apply specified
> +          configuration using SCMI protocol.
> +
> +      'grp$':
> +        type: object
> +        description:
> +          Pinctrl node's client devices use subnodes for desired pin configuration.
> +          Client device subnodes use below standard properties.
> +
> +        properties:
> +          fsl,pins:
> +            description:
> +              each entry consists of 6 integers and represents the mux and config
> +              setting for one pin. The first 5 integers <mux_reg conf_reg input_reg
> +              mux_val input_val> are specified using a PIN_FUNC_ID macro, which can
> +              be found in <arch/arm64/boot/dts/freescale/imx95-pinfunc.h>. The last
> +              integer CONFIG is the pad setting value like pull-up on this pin. Please
> +              refer to i.MX95 Plus Reference Manual for detailed CONFIG settings.
> +            $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +            items:
> +              items:
> +                - description: |
> +                    "mux_reg" indicates the offset of mux register.
> +                - description: |
> +                    "conf_reg" indicates the offset of pad configuration register.
> +                - description: |
> +                    "input_reg" indicates the offset of select input register.
> +                - description: |
> +                    "mux_val" indicates the mux value to be applied.
> +                - description: |
> +                    "input_val" indicates the select input value to be applied.
> +                - description: |
> +                    "pad_setting" indicates the pad configuration value to be applied.
> +
> +    required:
> +      - reg
> +
>  additionalProperties: false
>  
>  $defs:
> @@ -401,6 +480,26 @@ examples:
>              scmi_powercap: protocol@18 {
>                  reg = <0x18>;
>              };
> +
> +            scmi_pinctrl: protocol@19 {
> +                reg = <0x19>;
> +                #pinctrl-cells = <0>;

Missing compatible. Schema should catch that...

> +
> +                i2c2-pins {
> +                    groups = "i2c2_a", "i2c2_b";
> +                    function = "i2c2";
> +                };
> +
> +                mdio-pins {
> +                    groups = "avb_mdio";
> +                    drive-strength = <24>;
> +                };
> +
> +                keys_pins: keys-pins {
> +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> +                    bias-pull-up;
> +                };
> +            };
>          };
>      };
>  
> 
> -- 
> 2.37.1
> 

