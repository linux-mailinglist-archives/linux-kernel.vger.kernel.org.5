Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18B07764EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHIQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjHIQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:22:12 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD04ED;
        Wed,  9 Aug 2023 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=vNh9sRdmMwRNZB9dpYFP0p0p4eAm0Xeb7TBvjnG8gGU=; b=R6ugOU5Tlm6ASl+dQ1QM6iWYQC
        0PuS0VwOlMM9oxwwg3GP5Fxb7sCSUjDal7QTPdr7LdGId/NaqwTb6UDhO6ELcgSCAIGSJpw/654o2
        Y8/VNIJJRC8WMXjwcWg8UmQTOp3MSGhz2edBTbCfQqXCRfr0k5BDbGxXdSFOUyqSR7yo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qTlwc-003b9L-U6; Wed, 09 Aug 2023 18:21:58 +0200
Date:   Wed, 9 Aug 2023 18:21:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Uwe =?utf-8?B?S2xlaW5lLUvilJzDgm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Ioana Ciornei <ciorneiioana@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andre Edich <andre.edich@microchip.com>,
        Antoine Tenart <atenart@kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Divya Koppera <Divya.Koppera@microchip.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Kresin <dev@kresin.me>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Michael Walle <michael@walle.cc>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nisar Sayed <Nisar.Sayed@microchip.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Willy Liu <willy.liu@realtek.com>,
        Yuiko Oshino <yuiko.oshino@microchip.com>
Subject: Re: [PATCH] net: phy: Don't disable irqs on shutdown if WoL is
 enabled
Message-ID: <2f717c52-0ae5-4702-ab34-7ce0bffe8c86@lunn.ch>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
 <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
 <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
 <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
 <ZNO4RwYzZYUTu1uk@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNO4RwYzZYUTu1uk@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thinking about this, I wonder whether we could solve your issue by
> disabling interrupts when the PHY is probed, rather than disabling
> them on shutdown - something like this? (not build tested)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 3e9909b30938..4d1a37487923 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
>  			goto out;
>  	}
>  
> +        phy_disable_interrupts(phydev);
> +
>  	/* Start out supporting everything. Eventually,
>  	 * a controller will attach, and may modify one
>  	 * or both of these values

At some point, the interrupt is going to be enabled again. And then
the WoL interrupt will fire. I think some PHY drivers actually need to
see that WoL interrupt. e.g. the marvell driver has this comment:

static int m88e1318_set_wol(struct phy_device *phydev,
                            struct ethtool_wolinfo *wol)
{
....
                /* If WOL event happened once, the LED[2] interrupt pin
                 * will not be cleared unless we reading the interrupt status
                 * register. If interrupts are in use, the normal interrupt
                 * handling will clear the WOL event. Clear the WOL event
                 * before enabling it if !phy_interrupt_is_valid()
                 */

So it seems like just probing the marvell PHY is not enough to clear
the WoL interrupt.

Can we be sure that the other PHY has reached a state it can handle
and clear an interrupt when we come to enable the interrupt? I think
not, especially in cases like NFS root, where the interface will be
put into use as soon as it exists, maybe before the other interface
has probed.

	Andrew
