Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6A77923F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjHKOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbjHKOw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:52:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6842702;
        Fri, 11 Aug 2023 07:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A695C673A6;
        Fri, 11 Aug 2023 14:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE01C433C7;
        Fri, 11 Aug 2023 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691765576;
        bh=COHo4IWgjZScroVUYHPEPJCT0FXqzIIKPLX0dc9JXOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VShJqUTXr86A4eo3Cq5qNFDATWI/nvV5M7s7MhOkpwpOFugA4MGzdrwkoh7Q6ECLW
         fm40dsGrjoQXYSYSncg89+/seVDWNZ+01cRHE6a+GRX0gsYSFwPKHygFQgy2fQOIql
         zVRFocddYW1MqS1x5LQpNFBeMJJ8b+3mp6qJmLL5CeR9GM/+/Elav1KjkT35L17xtp
         EXr49eG+CpomusRESYHShe6o/3CEV2Qki4HvcVKcNMQxVhZGCGX7E6nXzvoYdb0MLN
         SxWngQFJ0A+RQE4U4thnM96FqTtL3BZrRC3DMOdmHNZY9Nw2RPaDG9Zagu3fEYohXf
         Bymq/h+ieirgA==
Received: (nullmailer pid 3450514 invoked by uid 1000);
        Fri, 11 Aug 2023 14:52:54 -0000
Date:   Fri, 11 Aug 2023 08:52:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Convert the sti pin controller bindings to
 YAML
Message-ID: <20230811145254.GA3414847-robh@kernel.org>
References: <20230810-dt-bindings-sti-v1-1-4f73ffc37d87@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810-dt-bindings-sti-v1-1-4f73ffc37d87@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 11:53:17PM +0200, Linus Walleij wrote:
> This rewrites the STi pin control bindings to use YAML.
> 
> These bindings came early in the development of pin control
> bindings so they are a bit obscure, and required a bit of
> uncommon regexp work.
> 
> The reason why these bindings need to be converted and
> preserved can be seen in the two new added compatibles,
> which are for the SpaceX Starlink chip "gllcff" which uses
> a derivative of this pin controller.

Well, this trips up the tools pretty good...

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-st.txt     | 174 ---------------
>  .../bindings/pinctrl/st,sti-pinctrl.yaml           | 238 +++++++++++++++++++++
>  2 files changed, 238 insertions(+), 174 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
> deleted file mode 100644
> index 48b9be48af18..000000000000
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-st.txt
> +++ /dev/null
> @@ -1,174 +0,0 @@
> -*ST pin controller.
> -
> -Each multi-function pin is controlled, driven and routed through the
> -PIO multiplexing block. Each pin supports GPIO functionality (ALT0)
> -and multiple alternate functions(ALT1 - ALTx) that directly connect
> -the pin to different hardware blocks.
> -
> -When a pin is in GPIO mode, Output Enable (OE), Open Drain(OD), and
> -Pull Up (PU) are driven by the related PIO block.
> -
> -ST pinctrl driver controls PIO multiplexing block and also interacts with
> -gpio driver to configure a pin.
> -
> -GPIO bank can have one of the two possible types of interrupt-wirings.
> -
> -First type is via irqmux, single interrupt is used by multiple gpio banks. This
> -reduces number of overall interrupts numbers required. All these banks belong to
> -a single pincontroller.
> -		  _________
> -		 |	   |----> [gpio-bank (n)    ]
> -		 |	   |----> [gpio-bank (n + 1)]
> -	[irqN]-- | irq-mux |----> [gpio-bank (n + 2)]
> -		 |	   |----> [gpio-bank (...  )]
> -		 |_________|----> [gpio-bank (n + 7)]
> -
> -Second type has a dedicated interrupt per gpio bank.
> -
> -	[irqN]----> [gpio-bank (n)]
> -
> -
> -Pin controller node:
> -Required properties:
> -- compatible	: should be "st,stih407-<pio-block>-pinctrl"
> -- st,syscfg		: Should be a phandle of the syscfg node.
> -- st,retime-pin-mask	: Should be mask to specify which pins can be retimed.
> -	If the property is not present, it is assumed that all the pins in the
> -	bank are capable of retiming. Retiming is mainly used to improve the
> -	IO timing margins of external synchronous interfaces.
> -- ranges : defines mapping between pin controller node (parent) to gpio-bank
> -  node (children).
> -
> -Optional properties:
> -- interrupts	: Interrupt number of the irqmux. If the interrupt is shared
> -  with other gpio banks via irqmux.
> -  a irqline and gpio banks.
> -- reg		: irqmux memory resource. If irqmux is present.
> -- reg-names	: irqmux resource should be named as "irqmux".
> -
> -GPIO controller/bank node.
> -Required properties:
> -- gpio-controller : Indicates this device is a GPIO controller
> -- #gpio-cells	  : Must be two.
> -     - First cell: specifies the pin number inside the controller
> -     - Second cell: specifies whether the pin is logically inverted.
> -       - 0 = active high
> -       - 1 = active low
> -- st,bank-name	  : Should be a name string for this bank as specified in
> -  datasheet.
> -
> -Optional properties:
> -- interrupts	: Interrupt number for this gpio bank. If there is a dedicated
> -  interrupt wired up for this gpio bank.
> -
> -- interrupt-controller : Indicates this device is a interrupt controller. GPIO
> -  bank can be an interrupt controller iff one of the interrupt type either via
> -irqmux or a dedicated interrupt per bank is specified.
> -
> -- #interrupt-cells: the value of this property should be 2.
> -     - First Cell: represents the external gpio interrupt number local to the
> -       gpio interrupt space of the controller.
> -     - Second Cell: flags to identify the type of the interrupt
> -       - 1 = rising edge triggered
> -       - 2 = falling edge triggered
> -       - 3 = rising and falling edge triggered
> -       - 4 = high level triggered
> -       - 8 = low level triggered
> -for related macros look in:
> -include/dt-bindings/interrupt-controller/irq.h
> -
> -Example:
> -	pin-controller-sbc {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		compatible = "st,stih407-sbc-pinctrl";
> -		st,syscfg = <&syscfg_sbc>;
> -		reg = <0x0961f080 0x4>;
> -		reg-names = "irqmux";
> -		interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>;
> -		interrupt-names = "irqmux";
> -		ranges = <0 0x09610000 0x6000>;
> -
> -		pio0: gpio@9610000 {
> -			gpio-controller;
> -			#gpio-cells = <2>;
> -			interrupt-controller;
> -			#interrupt-cells = <2>;
> -			reg = <0x0 0x100>;
> -			st,bank-name = "PIO0";
> -		};
> -		...
> -		pin-functions nodes follow...
> -	};
> -
> -
> -Contents of function subnode node:
> -----------------------
> -Required properties for pin configuration node:
> -- st,pins	: Child node with list of pins with configuration.
> -
> -Below is the format of how each pin conf should look like.
> -
> -<bank offset mux mode rt_type rt_delay rt_clk>
> -
> -Every PIO is represented with 4-7 parameters depending on retime configuration.
> -Each parameter is explained as below.
> -
> --bank		: Should be bank phandle to which this PIO belongs.
> --offset		: Offset in the PIO bank.
> --mux		: Should be alternate function number associated this pin.
> -		Use same numbers from datasheet.
> --mode		:pin configuration is selected from one of the below values.
> -		IN
> -		IN_PU
> -		OUT
> -		BIDIR
> -		BIDIR_PU
> -
> --rt_type	Retiming Configuration for the pin.
> -		Possible retime configuration are:
> -
> -		-------		-------------
> -		value		args
> -		-------		-------------
> -		NICLK		<delay> <clk>
> -		ICLK_IO		<delay> <clk>
> -		BYPASS		<delay>
> -		DE_IO		<delay> <clk>
> -		SE_ICLK_IO	<delay> <clk>
> -		SE_NICLK_IO	<delay> <clk>
> -
> -- delay	is retime delay in pico seconds as mentioned in data sheet.
> -
> -- rt_clk	:clk to be use for retime.
> -		Possible values are:
> -		CLK_A
> -		CLK_B
> -		CLK_C
> -		CLK_D
> -
> -Example of mmcclk pin which is a bi-direction pull pu with retime config
> -as non inverted clock retimed with CLK_B and delay of 0 pico seconds:
> -
> -pin-controller {
> -	...
> -	mmc0 {
> -		pinctrl_mmc: mmc {
> -			st,pins {
> -				mmcclk = <&PIO13 4 ALT4 BIDIR_PU NICLK 0 CLK_B>;
> -				...
> -			};
> -		};
> -	...
> -	};
> -};
> -
> -sdhci0:sdhci@fe810000{
> -	...
> -	interrupt-parent = <&pio3>;
> -	#interrupt-cells = <2>;
> -	interrupts = <3 IRQ_TYPE_LEVEL_HIGH>; /* Interrupt line via PIO3-3 */
> -	interrupt-names = "card-detect";
> -	pinctrl-names = "default";
> -	pinctrl-0	= <&pinctrl_mmc>;
> -};
> diff --git a/Documentation/devicetree/bindings/pinctrl/st,sti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,sti-pinctrl.yaml
> new file mode 100644
> index 000000000000..846b9438ac06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/st,sti-pinctrl.yaml
> @@ -0,0 +1,238 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/st,sti-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST STi/GLLCFF GPIO and Pin Mux/Config controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  In the ST STi/GLLCFF pin controller each multi-function pin is controlled,
> +  driven and routed through the PIO multiplexing block. Each pin supports
> +  GPIO functionality (ALT0) and multiple alternate functions(ALT1 - ALTx)
> +  that directly connect the pin to different hardware blocks.
> +
> +  The STi SoCs are used for consumer electronics. The GLLCFF SoCs are
> +  used for SpaceX Starlink.
> +
> +  When a pin is in GPIO mode, Output Enable (OE), Open Drain(OD), and
> +  Pull Up (PU) are driven by the related PIO block.
> +
> +  ST pinctrl driver controls PIO multiplexing block and also interacts with
> +  gpio driver to configure a pin.
> +
> +  GPIO bank can have one of the two possible types of interrupt-wirings.
> +
> +  First type is via irqmux, single interrupt is used by multiple gpio banks. This
> +  reduces number of overall interrupts numbers required. All these banks belong to
> +  a single pincontroller.
> +                  _________
> +                 |         |----> [gpio-bank (n)    ]
> +                 |         |----> [gpio-bank (n + 1)]
> +        [irqN]-- | irq-mux |----> [gpio-bank (n + 2)]
> +                 |         |----> [gpio-bank (...  )]
> +                 |_________|----> [gpio-bank (n + 7)]
> +
> +  Second type has a dedicated interrupt per gpio bank.
> +
> +        [irqN]----> [gpio-bank (n)]
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,gllcff-pinctrl
> +      - st,gllcff-flash-pinctrl
> +      - st,stih407-front-pinctrl
> +      - st,stih407-rear-pinctrl
> +      - st,stih407-flash-pinctrl
> +      - st,stih407-sbc-pinctrl
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
> +  reg: true
> +
> +  reg-names:
> +    const: irqmux
> +
> +  ranges: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    const: irqmux
> +
> +  st,syscfg:
> +    description: Should be a phandle of the syscfg node
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: syscon node to be used with the pin controller
> +
> +patternProperties:
> +  # GPIO banks below the main node
> +  '^(gpio|pio)@[0-9a-f]+$':
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      gpio-controller: true
> +
> +      '#gpio-cells':
> +        const: 2
> +
> +      interrupt-controller: true
> +
> +      '#interrupt-cells':
> +        const: 2
> +
> +      reg:
> +        maxItems: 1
> +
> +      resets:
> +        maxItems: 1
> +
> +      gpio-line-names: true
> +
> +      st,bank-name:
> +        description:
> +          Should be a name string for this bank as specified in the datasheet.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - PIO0
> +          - PIO1
> +          - PIO2
> +          - PIO3
> +          - PIO4
> +          - PIO5
> +          - PIO10
> +          - PIO11
> +          - PIO12
> +          - PIO13
> +          - PIO14
> +          - PIO15
> +          - PIO16
> +          - PIO17
> +          - PIO18
> +          - PIO19
> +          - PIO20
> +          - PIO30
> +          - PIO31
> +          - PIO32
> +          - PIO33
> +          - PIO34
> +          - PIO35
> +          - PIO40
> +          - PIO41
> +          - PIO42
> +
> +      st,retime-pin-mask:
> +        description:
> +          Should be mask to specify which pins can be retimed.
> +          If the property is not present, it is assumed that all the pins in the
> +          bank are capable of retiming. Retiming is mainly used to improve the
> +          IO timing margins of external synchronous interfaces.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 63
> +
> +    patternProperties:
> +      "^(.+-hog(-[0-9]+)?)$":
> +        type: object
> +        required:
> +          - gpio-hog
> +
> +    required:
> +      - gpio-controller
> +      - '#gpio-cells'
> +      - reg
> +      - st,bank-name
> +
> +  # Explicitly match all other nodes, EXCEPT the gpio nodes
> +  # these contain the actual pin control states
> +  '^(cec|rc|sbc_serial|i2c|keyscan|gmac|pwm|spi|serial|mmc|tsin|tsout|mtsin|systrace|usb|i2s_out|i2s_in|spdif_out|fsm|nand)[0-9]*$':

This seems to be the source of a lot of the warnings, but I'm not sure 
why exactly. I'll investigate.

Or you can use 'additionalProperties' to match on anything that doesn't 
have an explicit match. More below.

> +    type: object
> +    additionalProperties: false
> +
> +    patternProperties:
> +      '[-_0-9a-z]+$':

This allows pretty much anything. If that's what you want/need, 
use 'additionalProperties':

       additionalProperties:
         type: object
         properties:
           st,pins:
             ...

> +        type: object
> +        additionalProperties: false
> +
> +        patternProperties:
> +          '^st,pins':

Did you mean for this to really be a pattern? No '$' on the end, so this 
is equivalent to '^st,pins.*$'. Actual driver and dts files indicate 
this is not a pattern, but a fixed node name of 'st,pins'.

> +            type: object
> +            additionalProperties: false
> +            description: The st,pins is a custom key equals value list. The value
> +              is a phandle with 4 or 7 parameters.
> +
> +            patternProperties:
> +              ^[-_0-9a-zA-Z]+$:

This is where I was expecting the tools to get hung up as this will 
match practically any property. The way things work now is we extract 
property types from all the schemas. This is a flat list, so property 
names and types are global. That list is then used to decode the 
dtb before validation. There's some heuristics for dealing with multiple 
types for the same property name.

To support this binding, I think we're going to need some sort of 
conditional information to use. For this case, the node name might work. 
I'll have to investigate this some.

The other option is just drop this for now and put an 
'additionalProperties: true' with a note.

> +                description: the parameters to the phandle configures the pin.
> +                   Arg 0 = pio node phandle for the bank of the pin
> +                   Arg 1 = pin offset for the pin in the pio unit
> +                   Arg 2 = mux alternate function taken from the datasheet
> +                   Arg 3 = pin configuration mode for the pin, bits for a register
> +                   Arg 5 = retiming configuration for the pin
> +                   Arg 6 = retiming delay in picoseconds
> +                   Arg 7 = retiming clock to be used for the delay
> +                $ref: /schemas/types.yaml#/definitions/phandle-array
> +                minItems: 1
> +                maxItems: 1
> +                items:
> +                  minItems: 4
> +                  maxItems: 7
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - reg
> +  - reg-names
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pinctrl@961f080 {
> +      compatible = "st,stih407-sbc-pinctrl";
> +      #address-cells = <1>;
> +      #size-cells = <1>;
> +      st,syscfg = <&syscfg_sbc>;
> +      reg = <0x0961f080 0x4>;
> +      reg-names = "irqmux";
> +      interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names = "irqmux";
> +      ranges = <0 0x09610000 0x6000>;
> +
> +      pio0: gpio@9610000 {
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        reg = <0x0 0x100>;
> +        st,bank-name = "PIO0";
> +      };
> +
> +      sbc_serial0 {
> +        pinctrl_sbc_serial0: sbc_serial0-0 {
> +          st,pins {
> +            tx = <&pio0 4 1 (1 << 27)>;
> +            rx = <&pio0 5 1 0>;
> +          };
> +        };
> +      };
> +    };
> +...
> 
> ---
> base-commit: d6f3b83206bdbd9b969663f0eeedd963bdc13fcb
> change-id: 20230810-dt-bindings-sti-644ff6350456
> 
> Best regards,
> -- 
> Linus Walleij <linus.walleij@linaro.org>
> 
