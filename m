Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84937A9F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjIUUXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjIUUXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:23:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A51400D9;
        Thu, 21 Sep 2023 10:15:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBC9C4E769;
        Thu, 21 Sep 2023 15:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695310401;
        bh=5KINsh0TDXlKiSAfk5VwfB+f10kcRyJffTVpbAFpvPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hL9heK0LKVeUDo00ySxB6kCmIe7JPjgMJLu7uwZpbXlXPBF8J/Z2qo7qecubxEqtW
         OJGuS0xinXQRD3aH2v7jY/MObkSy58Ky78TNeZMi1/zAX7o2D83KqMes/ekf19XZMU
         hWlk4t/tGeh4Rdy2HZDfxUKjAQZhT1cNodYbmeIrLChUfXTRdyXpTXuWmRNtduuaeY
         YWzVWOU1cJqmRaGPnn4lK/4ei9YCX3ZgifJsMamwenJnBD6jOVPbWHX1m6kBPmKSRn
         FTopJOPOcGHSHTyvX/0g94xN6I7F3WdZM8UYD21TonSKGyqQ492615F/nR7c0Dd6nh
         rALEKhJ6bz8Ow==
Received: (nullmailer pid 383025 invoked by uid 1000);
        Thu, 21 Sep 2023 15:33:19 -0000
Date:   Thu, 21 Sep 2023 10:33:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hvilleneuve@dimonoff.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: sc16is7xx: convert to YAML
Message-ID: <20230921153319.GA379070-robh@kernel.org>
References: <20230920152015.1376838-1-hugo@hugovil.com>
 <20230920152015.1376838-5-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920152015.1376838-5-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:20:15AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Convert binding from text format to YAML.
> 
> Additions to original text binding:
>   - add rs485 reference.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  .../bindings/serial/nxp,sc16is7xx.txt         | 118 ----------------
>  .../bindings/serial/nxp,sc16is7xx.yaml        | 126 ++++++++++++++++++
>  2 files changed, 126 insertions(+), 118 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> deleted file mode 100644
> index d89815c5c562..000000000000
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
> +++ /dev/null
> @@ -1,118 +0,0 @@
> -* NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitter (UART)
> -* i2c as bus
> -
> -Required properties:
> -- compatible: Should be one of the following:
> -  - "nxp,sc16is740" for NXP SC16IS740,
> -  - "nxp,sc16is741" for NXP SC16IS741,
> -  - "nxp,sc16is750" for NXP SC16IS750,
> -  - "nxp,sc16is752" for NXP SC16IS752,
> -  - "nxp,sc16is760" for NXP SC16IS760,
> -  - "nxp,sc16is762" for NXP SC16IS762.
> -- reg: I2C address of the SC16IS7xx device.
> -- interrupts: Should contain the UART interrupt
> -- clocks: Reference to the IC source clock.
> -	OR (when there is no clock provider visible to the platform)
> -- clock-frequency: The source clock frequency for the IC.
> -
> -Optional properties:
> -- gpio-controller: Marks the device node as a GPIO controller.
> -- #gpio-cells: Should be two. The first cell is the GPIO number and
> -  the second cell is used to specify the GPIO polarity:
> -    0 = active high,
> -    1 = active low.
> -- nxp,irda-mode-ports: An array that lists the indices of the port that
> -		       should operate in IrDA mode.
> -- nxp,modem-control-line-ports: An array that lists the indices of the port that
> -				should have shared GPIO lines configured as
> -				modem control lines.
> -
> -Example:
> -        sc16is750: sc16is750@51 {
> -                compatible = "nxp,sc16is750";
> -                reg = <0x51>;
> -                clocks = <&clk20m>;
> -                interrupt-parent = <&gpio3>;
> -                interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> -                gpio-controller;
> -                #gpio-cells = <2>;
> -        };
> -
> -	sc16is752: sc16is752@53 {
> -		compatible = "nxp,sc16is752";
> -		reg = <0x53>;
> -		clocks = <&clk20m>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> -		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
> -		gpio-controller; /* Port 0 as GPIOs */
> -		#gpio-cells = <2>;
> -	};
> -
> -	sc16is752: sc16is752@54 {
> -		compatible = "nxp,sc16is752";
> -		reg = <0x54>;
> -		clocks = <&clk20m>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> -		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
> -	};
> -
> -* spi as bus
> -
> -Required properties:
> -- compatible: Should be one of the following:
> -  - "nxp,sc16is740" for NXP SC16IS740,
> -  - "nxp,sc16is741" for NXP SC16IS741,
> -  - "nxp,sc16is750" for NXP SC16IS750,
> -  - "nxp,sc16is752" for NXP SC16IS752,
> -  - "nxp,sc16is760" for NXP SC16IS760,
> -  - "nxp,sc16is762" for NXP SC16IS762.
> -- reg: SPI chip select number.
> -- interrupts: Specifies the interrupt source of the parent interrupt
> -  controller. The format of the interrupt specifier depends on the
> -  parent interrupt controller.
> -- clocks: phandle to the IC source clock.
> -
> -Optional properties:
> -- gpio-controller: Marks the device node as a GPIO controller.
> -- #gpio-cells: Should be two. The first cell is the GPIO number and
> -  the second cell is used to specify the GPIO polarity:
> -    0 = active high,
> -    1 = active low.
> -- nxp,irda-mode-ports: An array that lists the indices of the port that
> -		       should operate in IrDA mode.
> -- nxp,modem-control-line-ports: An array that lists the indices of the port that
> -				should have shared GPIO lines configured as
> -				modem control lines.
> -
> -Example:
> -	sc16is750: sc16is750@0 {
> -		compatible = "nxp,sc16is750";
> -		reg = <0>;
> -		clocks = <&clk20m>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -
> -	sc16is752: sc16is752@1 {
> -		compatible = "nxp,sc16is752";
> -		reg = <1>;
> -		clocks = <&clk20m>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> -		nxp,modem-control-line-ports = <1>; /* Port 1 as modem control lines */
> -		gpio-controller; /* Port 0 as GPIOs */
> -		#gpio-cells = <2>;
> -	};
> -
> -	sc16is752: sc16is752@2 {
> -		compatible = "nxp,sc16is752";
> -		reg = <2>;
> -		clocks = <&clk20m>;
> -		interrupt-parent = <&gpio3>;
> -		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> -		nxp,modem-control-line-ports = <0 1>; /* Ports 0 and 1 as modem control lines */
> -	};
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> new file mode 100644
> index 000000000000..508639e09e06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -0,0 +1,126 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/nxp,sc16is7xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP SC16IS7xx advanced Universal Asynchronous Receiver-Transmitter (UART)
> +
> +maintainers:
> +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,sc16is740
> +      - nxp,sc16is741
> +      - nxp,sc16is750
> +      - nxp,sc16is752
> +      - nxp,sc16is760
> +      - nxp,sc16is762
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: Reference to the IC source clock.
> +
> +  clock-frequency:
> +    description: |
> +      When there is no clock provider visible to the platform, this
> +      is the source crystal or external clock frequency for the IC in Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type here. 'clock-frequency' is already defined.

> +    minimum: 1
> +    maximum: 80000000
> +
> +  gpio-controller:
> +    description: Marks the device node as a GPIO controller.
> +    type: boolean

Just: 

gpio-controller: true
