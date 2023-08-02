Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02DA76DAEA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjHBWpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjHBWpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:45:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A196213F;
        Wed,  2 Aug 2023 15:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=1UcJsU12/KrKnVoMkRz5A+Cc9aIwAd1y+80OQ5wKfdI=; b=jInjYDz7xVlxQvYMJx/l8ko6gq
        i2KciupKuVKQQ5G99+LO6MpAmKWWOQLTYOYxf+prAnp5K6oN8ju3yQvZUEfyLmu5ALRh/z0YIWmiT
        M86UKbSajjeicSg62JDMzOckbLDkqx2Kn5++7y6aGh0dh9ARwtmh/F+OLaqP0hkZz3HQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qRKVX-002vfn-Om; Thu, 03 Aug 2023 00:39:55 +0200
Date:   Thu, 3 Aug 2023 00:39:55 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <0b227994-2577-4a74-b604-79410f5607b8@lunn.ch>
References: <20230802201824.3683-1-nick.hawkins@hpe.com>
 <20230802201824.3683-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802201824.3683-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +config GXP_UMAC_MDIO
> +	tristate "GXP UMAC mdio support"
> +	depends on ARCH_HPE || COMPILE_TEST
> +	depends on OF_MDIO && HAS_IOMEM
> +	depends on MDIO_DEVRES
> +        help

nitpick: help should be indented same as depends.

> +	  Say y here to support the GXP UMAC MDIO bus. The
> +	  MDIO(mdio0) interface from the primary MAC (umac0)
> +	  is used for external PHY status and configuration.

Is it an external MDIO bus? So anything could be connected to it,
e.g. an Ethernet switch. 

> +	  The MDIO(mdio1) interface from the secondary MAC
> +	  (umac1) is routed to the SGMII/100Base-X IP blocks
> +	  on the two SERDES interface connections.

Is this one purely internal? If so, then the text is valid. If it also
goes external, there is no reason you could not put a PHY or an
Ethernet switch on it. You can then skip using the first MDIO bus all
together.

> +#define UMAC_MII                0x00  /* R/W MII Register */
> +#define UMAC_MII_PHY_ADDR_MASK  0x001F0000
> +#define UMAC_MII_PHY_ADDR_SHIFT 16
> +#define UMAC_MII_MOWNER         0x00000200
> +#define UMAC_MII_MRNW           0x00000100

Are these two bits? If so, please use BIT().

> +static int umac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
> +{
> +	struct umac_mdio_priv *umac_mdio = bus->priv;
> +	unsigned int status;
> +	unsigned int value;
> +	int ret;
> +
> +	status = __raw_readl(umac_mdio->base + UMAC_MII);
> +
> +	status &= ~(UMAC_MII_PHY_ADDR_MASK | UMAC_MII_REG_ADDR_MASK);
> +	status |= ((phy_id << UMAC_MII_PHY_ADDR_SHIFT) &
> +			UMAC_MII_PHY_ADDR_MASK);
> +	status |= (reg & UMAC_MII_REG_ADDR_MASK);
> +	status |= UMAC_MII_MRNW; /* set bit for read mode */
> +	__raw_writel(status, umac_mdio->base + UMAC_MII);
> +
> +	status |= UMAC_MII_MOWNER; /* set bit to activate mii transfer */
> +	__raw_writel(status, umac_mdio->base + UMAC_MII);

I assume UMAC_MII_MOWNER must be set in a separate operation? But
using __raw_writel() i'm not sure there is any barrier between the two
writes.

	Andrew
