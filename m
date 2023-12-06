Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E551E807697
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378442AbjLFR1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjLFR1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:27:04 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4FD4B;
        Wed,  6 Dec 2023 09:27:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D837FF805;
        Wed,  6 Dec 2023 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701883627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8pZVmJLBTU+1tWg81N7K3SrAOmJRHhU7sJoEUi0B8Q=;
        b=RspeMsNlXs4d9FVko5LXZ3Kk3UqyCUGNCdsvtlEh+T6qMnNVaAAJKhPfp1sYFoj6hjBTCj
        ylgCMP9ngNWeyY9LxI6KabuMqEtQLjDrdMBz0I8KZeukyXFLCrH/+DOIN9hm1hQNXh6Fev
        M2j9oMbc4cXuShB9qSFyhqctHwnyEyjn4pFjxv38xjVYiuEKCg1gVA0pQNxb0n/0n90Dhw
        mOEph1mESP0822WMO36jzvlFA6rPG8yWiPJgciDCB3+moMrWPzUx81vh7Yeeagnc8Lwjbn
        wXBVek6wM7IgU+NDmVLVqwaZypP0vkx7oVV44HsAtlAqZdMK3qzKnnkV8oZ5Vg==
Date:   Wed, 6 Dec 2023 18:27:05 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     mw@semihalf.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: mvpp2: add support for mii
Message-ID: <20231206182705.3ff798ad@device.home>
In-Reply-To: <20231206160125.2383281-1-eichest@gmail.com>
References: <20231206160125.2383281-1-eichest@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stefan,

On Wed,  6 Dec 2023 17:01:25 +0100
Stefan Eichenberger <eichest@gmail.com> wrote:

> Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> The description in Marvell's functional specification seems to be wrong.
> To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
> we need to clear it. This is also how U-Boot handles it.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
> ---
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 24 ++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 93137606869e..6f136f42e2bf 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -1513,10 +1513,21 @@ static void mvpp22_gop_init_rgmii(struct mvpp2_port *port)
>  	regmap_write(priv->sysctrl_base, GENCONF_PORT_CTRL0, val);
>  
>  	regmap_read(priv->sysctrl_base, GENCONF_CTRL0, &val);
> -	if (port->gop_id == 2)
> +	if (port->gop_id == 2) {
>  		val |= GENCONF_CTRL0_PORT2_RGMII;
> -	else if (port->gop_id == 3)
> +	} else if (port->gop_id == 3) {
>  		val |= GENCONF_CTRL0_PORT3_RGMII_MII;
> +
> +		/* According to the specification, GENCONF_CTRL0_PORT3_RGMII
> +		 * should be set to 1 for RGMII and 0 for MII. However, tests
> +		 * show that it is the other way around. This is also what
> +		 * U-Boot does for mvpp2, so it is assumed to be correct.
> +		 */
> +		if (port->phy_interface == PHY_INTERFACE_MODE_MII)
> +			val |= GENCONF_CTRL0_PORT3_RGMII;
> +		else
> +			val &= ~GENCONF_CTRL0_PORT3_RGMII;
> +	}
>  	regmap_write(priv->sysctrl_base, GENCONF_CTRL0, val);
>  }
>  
> @@ -1615,6 +1626,7 @@ static int mvpp22_gop_init(struct mvpp2_port *port, phy_interface_t interface)
>  		return 0;
>  
>  	switch (interface) {
> +	case PHY_INTERFACE_MODE_MII:
>  	case PHY_INTERFACE_MODE_RGMII:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
> @@ -6948,8 +6960,11 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  					MAC_10000FD;
>  		}
>  
> -		if (mvpp2_port_supports_rgmii(port))
> +		if (mvpp2_port_supports_rgmii(port)) {
>  			phy_interface_set_rgmii(port->phylink_config.supported_interfaces);
> +			__set_bit(PHY_INTERFACE_MODE_MII,
> +				  port->phylink_config.supported_interfaces);
> +		}
>  
>  		if (comphy) {
>  			/* If a COMPHY is present, we can support any of the
> @@ -6973,6 +6988,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  				  port->phylink_config.supported_interfaces);
>  			__set_bit(PHY_INTERFACE_MODE_SGMII,
>  				  port->phylink_config.supported_interfaces);
> +		} else if (phy_mode == PHY_INTERFACE_MODE_MII) {
> +			__set_bit(PHY_INTERFACE_MODE_100BASEX,
> +				  port->phylink_config.supported_interfaces);

Can you explain that part ? I don't understand why 100BaseX is being
reported as a supported mode here. This whole section of the function
is about detecting what can be reported based on the presence or not of
a comphy driver / hardcoded comphy config. I don't think the comphy
here has anything to do with MII / 100BaseX

If 100BaseX can be carried on MII (which I don't know), shouldn't it be
reported no matter what ?

Thanks,

Maxime


