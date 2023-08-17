Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFC177EEA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347475AbjHQBUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347473AbjHQBTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:19:45 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E913026AB;
        Wed, 16 Aug 2023 18:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=k5AnX52HD8DrL7Os7PUELSo5Kpp0aTUuVSiOe7uZSvA=; b=zJTv3OespTvnIpKqpdeTzp2Apm
        rRuzIwgp6H8nV64WxkoetxEnVFauAI9aiNe6529+zOAFcL/3+Z0hl5k4KnwjtlxoXi805URdVwk1k
        R6HZDUvpDIh3Xt5jHZxiqynp/sNZB6iMssAFh+DYMqa+xHxEKQO21dw4vf80S8NJI1xY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qWRfh-004Kkc-So; Thu, 17 Aug 2023 03:19:33 +0200
Date:   Thu, 17 Aug 2023 03:19:33 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     nick.hawkins@hpe.com
Cc:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        verdun@hpe.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] net: hpe: Add GXP UMAC MDIO
Message-ID: <16d8e283-79f7-44bb-af5f-b84cdf7c9d79@lunn.ch>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
 <20230816215220.114118-3-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816215220.114118-3-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 04:52:17PM -0500, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The GXP contains two Universal Ethernet MACs that can be
> connected externally to several physical devices. From an external
> interface perspective the BMC provides two SERDES interface connections
> capable of either SGMII or 1000Base-X operation. The BMC also provides
> a RMII interface for sideband connections to external Ethernet controllers.
> 
> The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
> SERDES interface.  The secondary MAC (umac1) can be mapped to only
> the second SGMII/1000-Base X Serdes interface or it can be mapped for
> RMII sideband.
> 
> The MDIO(mdio0) interface from the primary MAC (umac0) is used for
> external PHY status and configuration. The MDIO(mdio1) interface from
> the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks

I think that is a typo. 100BaseX does not exist, the nearest is 100BaseFX.

> +config GXP_UMAC_MDIO
> +	tristate "GXP UMAC mdio support"
> +	depends on ARCH_HPE || COMPILE_TEST
> +	depends on OF_MDIO && HAS_IOMEM
> +	depends on MDIO_DEVRES
> +	help
> +	  Say y here to support the GXP UMAC MDIO bus. The
> +	  MDIO (mdio0) interface from the primary MAC (umac0)
> +	  is used for external PHY status and configuration.
> +	  The MDIO (mdio1) interface from the secondary MAC
> +	  (umac1) is routed to the SGMII/100Base-X IP blocks

Same here.

> --- a/drivers/net/mdio/Makefile
> +++ b/drivers/net/mdio/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_MDIO_BCM_UNIMAC)		+= mdio-bcm-unimac.o
>  obj-$(CONFIG_MDIO_BITBANG)		+= mdio-bitbang.o
>  obj-$(CONFIG_MDIO_CAVIUM)		+= mdio-cavium.o
>  obj-$(CONFIG_MDIO_GPIO)			+= mdio-gpio.o
> +obj-$(CONFIG_GXP_UMAC_MDIO)		+= mdio-gxp-umac.o
>  obj-$(CONFIG_MDIO_HISI_FEMAC)		+= mdio-hisi-femac.o

Don't you think this looks out of place. The only one not CONFIG_MDIO ?

> +static int umac_mdio_write(struct mii_bus *bus, int phy_id, int reg, u16 value)
> +{
> +	struct umac_mdio_priv *umac_mdio = bus->priv;
> +	unsigned int status;
> +	int ret;
> +
> +	writel(value, umac_mdio->base + UMAC_MII_DATA);

...

> +	if (ret)
> +		dev_err(bus->parent, "mdio read time out\n");

cut/paste error.


    Andrew

---
pw-bot: cr
