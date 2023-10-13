Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783F37C85F9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJMMnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJMMnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:43:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1B91;
        Fri, 13 Oct 2023 05:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fPquRdX+fyaXxcACERQp1ldJLvmp6A1Oj12yYYIMkoM=; b=Sl/UoMzLoDOWtNKjOlu/f0ns0S
        /BHqoWpqfH9f1sEuGuvowgltG3yVND2t4/0s7/JgQtRJdXHA2t5Tu88q0nKQqKpX+SF2ILZY4tg9f
        dFDROcdQ1FoqHvxHAcnyKTWmcONwhdycPJoyTNHJdGgT7DcMVVc+XUYs7fzg0QnEn1kU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrHVU-0025g3-A6; Fri, 13 Oct 2023 14:43:08 +0200
Date:   Fri, 13 Oct 2023 14:43:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] RFC: dt-bindings: marvell: Rewrite in schema
Message-ID: <d971d7c1-c6b5-44a4-81cf-4f634e760e87@lunn.ch>
References: <20231013-marvell-88e6152-wan-led-v1-0-0712ba99857c@linaro.org>
 <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-marvell-88e6152-wan-led-v1-2-0712ba99857c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - marvell,mv88e6060

The 6060 is a separate driver. Its not part of mv88e6xxx. So it should
have a binding document of its own.

> +  '#interrupt-cells':
> +    description: The internal interrupt controller only supports triggering
> +      on IRQ_TYPE_LEVEL_HIGH
> +      # FIXME: what is this? this should be one cell should it not?
> +      # the Linux mv88e6xxx driver does not implement .irq_set_type in its irq_chip
> +      # so at least in that implementation the type is flat out ignored.
> +    const: 2

This interrupt controller is for the embedded PHYs. Its is hard wired
active high.

> +  mdio-external:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Marvell MV88E6xxx switches have an external mdio bus to
> +      access switch ports.

This is used to access external PHYs attached to the ports, not the
ports themselves.

> +
> +  mdio1:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description: Older version of mdio-external
> +    deprecated: true
> +    properties:
> +      compatible:
> +        const: marvell,mv88e6xxx-mdio-external

The driver only looks at the compatible. It does not care what the
node is called. So you are going to need to change the driver if you
want this in the schema.

     Andrew
