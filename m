Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC17CA642
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjJPLJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:09:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0407A83;
        Mon, 16 Oct 2023 04:09:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so7355279a12.2;
        Mon, 16 Oct 2023 04:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697454541; x=1698059341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDaXo5MTP4dUtT2V4pjnvLHYZsmOGF0BPQquHVNEV4Q=;
        b=DnK5M0I7D9snjD45PPJVyro+tB+/HvcYc27wzai+XPGh7pHpdIXnmnCzqtHFbV3TOM
         /2nnTgEw2C43jfPtHIH4PE5W4BpHIWmllJhQZ6fiuYnTV0FbB4LvVSByo0Nat6RJ58Kl
         l+jAuJO4PsCBkLM5ptKB/fo9QuWo0WbeUyYYstMss/r5raa01NuKRZRhxv+mvM9dZbjM
         8es+0HyC6YSuZXqFtSmaUzPcwIiskhkHKBjHliMSnOy+9fW76tWT3wDN+F797+BLxFOa
         CEwThvTJ7syFbumNx8aNS1lt1lfOQ44uhiiUj+dOrAUF4cb5AKUskH2CS6wcYRM3d0vh
         z2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697454541; x=1698059341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDaXo5MTP4dUtT2V4pjnvLHYZsmOGF0BPQquHVNEV4Q=;
        b=kiXIp+qh7auHifDSUCMnOOxwIygMMBEf0M0aahK+j8roptM1BN7TtFOLyEosLJz19w
         YU3iqDjH3AvrHmvyN/NILR9TqKcYFYhq2HJOVgZsDLKP1t7HqrqOUtiC0Vx8LRZCiYYG
         YCaJhPNisphaPxGd4UG2mdsRZmTGp14WKThrRUZjjtdt2cuo8mPeoa4elACIPX61pEim
         ULlT7io1qXYgxJyKzZT639avar/FpqBCHauLcWZVe2cD4udwLzW+pfJ6kuUyV1iaF6dc
         IJk86vUZ3eDSaq7EF8Dc0baNwxhJ4TA1CbWs+RJ96OCmWzUR2ZTprOqkscneCft6JeXw
         UcEQ==
X-Gm-Message-State: AOJu0Yz5ZMpGVvophBPqSf9zo1ejuai+xB557JhVFRiyJKq/wPzKO/R8
        UvMLxDXCCFa3uR1P63LwF4N0kjQ6JFyjVw==
X-Google-Smtp-Source: AGHT+IGvxW1HlHJOzu2eVLozsnUNyEAyJ1WzlS5teJ9Anku85o1gYAixK4qMjJv3NB0bFi87s9t/lA==
X-Received: by 2002:a05:6402:2712:b0:53e:708c:40be with SMTP id y18-20020a056402271200b0053e708c40bemr5252469edd.6.1697454541137;
        Mon, 16 Oct 2023 04:09:01 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id c11-20020aa7c98b000000b00536ad96f867sm15269923edt.11.2023.10.16.04.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:09:00 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:08:58 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231016110858.ljvjssqujuesu7kd@skbuf>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:12:54AM +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?

Removing that remark seems in order.

> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 243 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 244 insertions(+), 110 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> new file mode 100644
> index 000000000000..954db04147f8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
> @@ -0,0 +1,243 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell MV88E6xxx DSA switch family
> +
> +maintainers:
> +  - Andrew Lunn <andrew@lunn.ch>
> +
> +description:
> +  The Marvell MV88E6xxx switch series has been produced and sold
> +  by Marvell since at least 2010. The switch has a few compatibles which
> +  just indicate the base address of the switch, then operating systems
> +  can investigate switch ID registers to find out which actual version
> +  of the switch it is dealing with.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,mv88e6085
> +          - marvell,mv88e6190
> +          - marvell,mv88e6250
> +    description: |
> +      marvell,mv88e6085: This switch uses base address 0x10.
> +        This switch and its siblings will be autodetected from
> +        ID registers found in the switch, so only "marvell,mv88e6085" should be
> +        specified. This includes the following list of MV88Exxxx switches:
> +        6085, 6095, 6097, 6123, 6131, 6141, 6161, 6165, 6171, 6172, 6175, 6176,
> +        6185, 6240, 6320, 6321, 6341, 6350, 6351, 6352
> +      marvell,mv88e6190: This switch uses base address 0x00.
> +        This switch and its siblings will be autodetected from
> +        ID registers found in the switch, so only "marvell,mv88e6190" should be
> +        specified. This includes the following list of MV88Exxxx switches:
> +        6190, 6190X, 6191, 6290, 6361, 6390, 6390X
> +      marvell,mv88e6250: This switch uses base address 0x08 or 0x18.
> +        This switch and its siblings will be autodetected from
> +        ID registers found in the switch, so only "marvell,mv88e6250" should be
> +        specified. This includes the following list of MV88Exxxx switches:
> +        6220, 6250
> +
> +  reg:
> +    maxItems: 1
> +
> +  eeprom-length:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Set to the length of an EEPROM connected to the switch. Must be
> +      set if the switch can not detect the presence and/or size of a connected
> +      EEPROM, otherwise optional.
> +
> +  reset-gpios:
> +    description:
> +      GPIO to be used to reset the whole device
> +    maxItems: 1
> +
> +  interrupts:
> +    description: The switch provides an external interrupt line, but it is
> +      not always used by target systems.
> +    maxItems: 1
> +
> +  interrupt-controller:
> +    description: The switch has an internal interrupt controller used by
> +      the different sub-blocks.
> +
> +  '#interrupt-cells':
> +    description: The internal interrupt controller only supports triggering
> +      on active high level interrupts so the second cell must alway be set to
> +      IRQ_TYPE_LEVEL_HIGH.
> +    const: 2
> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches have an varying combination of
> +    internal and external MDIO buses, in some cases a combined bus that
> +    can be used both internally and externally. This node is for the
> +    primary bus, used internally and sometimes also externally.
> +
> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches that have a separate external
> +      MDIO bus use this port to access external components on the MDIO bus.
> +
> +    properties:
> +      compatible:
> +        const: marvell,mv88e6xxx-mdio-external
> +
> +    required:
> +      - compatible
> +
> +$ref: dsa.yaml#
> +
> +patternProperties:
> +  "^(ethernet-)?ports$":
> +    type: object
> +    patternProperties:
> +      "^(ethernet-)?port@[0-9]+$":
> +        type: object
> +        description: Ethernet switch ports
> +
> +        $ref: dsa-port.yaml#
> +
> +        unevaluatedProperties: false
> +
> +oneOf:
> +  - required:
> +      - ports
> +  - required:
> +      - ethernet-ports
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch0: switch@0 {

ethernet-switch is preferred

> +            compatible = "marvell,mv88e6085";
> +            reg = <0>;
> +            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +            interrupt-parent = <&gpio0>;

I don't see interrupt-parent as an accepted property in the schema.
Should interrupts-extended also be accepted?

> +            interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            ports {

ethernet-ports is preferred

> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    label = "lan1";
> +                };
> +                port@1 {
> +                    reg = <1>;
> +                    label = "lan2";
> +                };
> +                port@2 {
> +                    reg = <2>;
> +                    label = "lan3";
> +                };
> +                port@3 {
> +                    reg = <3>;
> +                    label = "lan4";
> +                };
> +                port@4 {
> +                    reg = <4>;
> +                    label = "wan";
> +                };
> +
> +                port@5 {
> +                    reg = <5>;
> +                    phy-mode = "sgmii";
> +                    ethernet = <&eth2>;
> +
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                    };
> +                };
> +            };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;

One blank link here

> +                switch0phy0: switch0phy@0 {

ethernet-phy@0

> +                    reg = <0>;
> +                    interrupt-parent = <&switch0>;
> +                    interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;

interrupts-extended = <&switch0 0 IRQ_TYPE_LEVEL_HIGH>; would be shorter

> +                };
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch1: switch@0 {
> +            compatible = "marvell,mv88e6190";
> +            reg = <0>;
> +            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0>;
> +                    label = "lan1";
> +                };
> +                port@1 {
> +                    reg = <1>;
> +                    label = "lan2";
> +                };
> +                port@2 {
> +                    reg = <2>;
> +                    label = "lan3";
> +                };
> +                port@3 {
> +                    reg = <3>;
> +                    label = "lan4";
> +                };

FWIW, this example would be rejected by real-life DSA, because a CPU
port is missing (no port has an "ethernet" phandle).

> +            };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                switch1phy0: switch1phy@0 {

ethernet-phy@0

> +                    reg = <0>;
> +                    interrupt-parent = <&switch1>;
> +                    interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
> +                };
> +            };
> +
> +            mdio-external {
> +                compatible = "marvell,mv88e6xxx-mdio-external";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                switch1phy9: switch1phy@9 {

ethernet-phy@9

> +                    reg = <9>;
> +                };
> +            };
> +        };
> +    };
