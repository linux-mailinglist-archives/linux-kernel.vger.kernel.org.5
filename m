Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63957CFDFA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346273AbjJSPgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbjJSPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:35:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E57124;
        Thu, 19 Oct 2023 08:35:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso833922266b.2;
        Thu, 19 Oct 2023 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697729756; x=1698334556; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bapCqAMbgu3T6/FtlwwPNVuJjdsU2V/iyClL9uMUXbg=;
        b=iQ+2AqRrqr+lzWP7hiFRZNgmIlHqZybF7gCL5nRNQ4zV3F1Bl5MQwTGecXCan7WFEs
         BgI96n7KaR7Qxvx/mITax9QANYV9ZzUAc6AG/n6Xp8bd7q/XpqeJj5zC7joEWiJ8MbE8
         75kpeCaG0+OGvcX3M3FU0pckfSiOHIWHADYhQr+oA9dtG5t2ZJuL87gh6FVNz5tcDSxL
         JxQvvHrTDyCUn5Teh1/gQiGVWICb9bEP5H39PaME8nc2s0zOtk9qUP7q4vtsMQc4pQF4
         kuNv/HJ6v5eMCD+44pWB1xw8SXrS5Y5LuUivmDM3zZQjn/dId5jLKVSTZ4tdnfOXlhKD
         9sYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697729756; x=1698334556;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bapCqAMbgu3T6/FtlwwPNVuJjdsU2V/iyClL9uMUXbg=;
        b=uNh8X81NtXl7mJR5Z/zSGkScBzt8C2omOBFQYbbpoY5WoTWFuaJYMcv5LKYRtd7FjI
         ByESX5UO3aDtS/me/YT8z9yKmP4F4T59vWYPZSTLlULVuyupIHx/jE1cWnYEAbR+rZ5R
         t6CAyn2O2BD/AKv4nwrGK09MQYPjf1ijP1rbTZNL+ktEJ0ln91hbDXWnYHGfX1qSssdG
         j4YPALek6buX1z2kuUoDn0rG7bmBPBV8hnDvdlkKa+Weya4N9vHUSAyZ3bJXPYpnsG8K
         Ug+3jevfXu6Ar5WnOnF30sOASYEgy7frjVQNiVUDixf5uOtoP8zfkM7d5cCyy026m74p
         lwhQ==
X-Gm-Message-State: AOJu0YxtwnJlfYvSaChl7mcQ/A7b8IOTeTW7PrMi+UkNCFJDqsaq4iIF
        qc3kgz/c0z89ek/fx/aUpQA=
X-Google-Smtp-Source: AGHT+IHL5rppVOHOKlxz1NwCPSHxB58aBndvCHLDrW1DD7D+DHnPhnsqImvMU6Gjd+wnFMn82NlQAg==
X-Received: by 2002:a17:906:6a0e:b0:9c7:59d1:b2ce with SMTP id qw14-20020a1709066a0e00b009c759d1b2cemr1886240ejc.5.1697729755566;
        Thu, 19 Oct 2023 08:35:55 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062d4a00b009944e955e19sm3816278eji.30.2023.10.19.08.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 08:35:55 -0700 (PDT)
Date:   Thu, 19 Oct 2023 18:35:52 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
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
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite MV88E6xxx
 in schema
Message-ID: <20231019153552.nndysafvblrkl2zn@skbuf>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:03:45AM +0200, Linus Walleij wrote:
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        switch0: ethernet-switch@0 {
> +            compatible = "marvell,mv88e6085";
> +            reg = <0>;
> +            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +            interrupts-extended = <&gpio0 27 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            ethernet-ports {
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
> +
> +                switch0phy0: ethernet-phy@0 {
> +                    reg = <0>;
> +                    interrupts-extended = <&switch0 0 IRQ_TYPE_LEVEL_HIGH>;
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
> +        switch1: ethernet-switch@0 {
> +            compatible = "marvell,mv88e6190";
> +            reg = <0>;
> +            reset-gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +            interrupts-extended = <&gpio0 27 IRQ_TYPE_LEVEL_LOW>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +
> +            ethernet-ports {
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
> +            };
> +
> +            mdio {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                switch1phy0: ethernet-phy@0 {
> +                    reg = <0>;
> +                    interrupts-extended = <&switch1 0 IRQ_TYPE_LEVEL_HIGH>;
> +                };
> +            };
> +
> +            mdio-external {
> +                compatible = "marvell,mv88e6xxx-mdio-external";
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                switch1phy9: ethernet-phy@9 {
> +                    reg = <9>;
> +                };
> +            };
> +        };
> +    };

Yikes, both these examples are actually broken, for a reason that was
extensively discussed with Arınç in the past, and that he tried to
automatically detect through dt-schema but was ultimately told it's too
complicated.
https://patchwork.kernel.org/project/netdevbpf/cover/20230916110902.234273-1-arinc.unal@arinc9.com/

Long story short: the "mdio" node is also the ds->slave_mii_bus (soon to
be ds->user_mii_bus after Florian's inclusivity changes). Having a
slave_mii_bus makes DSA know what to do with port nodes like this, which
don't have an explicit phy-handle:

	port@3 {
	    reg = <3>;
	    label = "lan4";
	};

but actually, call phy_connect() on the ds->slave_mii_bus at address 3
(the port "reg").

The issue is that phy_connect() won't work if ds->slave_mii_bus has an
OF presence, and ethernet-phy@3 isn't defined under it (which it isn't,
you only put ethernet-phy@9). The super detailed reason is that the
OF-based __of_mdiobus_register() does this:

	/* Mask out all PHYs from auto probing.  Instead the PHYs listed in
	 * the device tree are populated after the bus has been registered */
	mdio->phy_mask = ~0;

So either:

- you delete the "mdio" node and the ethernet-phys under it, or
- you add all ethernet-phys under the mdio node, and put phy-handles
  from ports to each of them, and phy-modes of "internal"

What you have now is exactly what won't work, i.e. an OF-based
slave_mii_bus with a non-OF-based phy_connect().

I don't want to see DT examples that are structurally broken, sorry,
because then we wonder why users are confused.

Personally, I would opt for adding the more modern explicit phy-handle
and phy-mode everywhere. Those also work with the U-Boot DM_DSA driver.
Just because we tolerate the bindings defined in the dark ages of DT
doesn't mean we should make an example out of them.

Also, you seem to have duplicated some work also done by Arınç but not
finalized (the mv88e6xxx schema conversion, on which you were also
copied). Let me add Marek here too, to make sure he's aware of 2
previous attempts and doesn't start working on a 3rd one :)

One other thing I see as a deal breaker for this schema conversion is
that $nodename for Marvell needs to allow basically anything (invalidating
the constraint from ethernet-switch.yaml), because we can't change node
names in the case of some boards, otherwise we risk breaking them
(see MOX). If the schema starts emitting warnings for those node names,
then it's inevitable that some pixie in the future will eventually break
them by "fixing" the node name.
