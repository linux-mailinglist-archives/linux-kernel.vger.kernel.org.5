Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9AF77689D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjHITYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjHITXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:23:51 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464135A0;
        Wed,  9 Aug 2023 12:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rVBVEarv10WJ3d8bv6YMiZguKfZCsICwHORbHdRDPlM=; b=Kr96FqR7ST6Lcbqxz0+Bz5vQnd
        TWKzjqtfGKJGiyiLFjblZO3SHBPAdCSTkSeRTn/tzfMuwFWRuNYSV5XqnK8JWCn/M6qyK+NnZdunh
        Taf+raiYD8NtOlGn22z4XP9YN1GskYai1jxXqjZnn164aNrGHjtiKvoF12oh/rjJJQBcLFZLcmPqe
        YzMmlXIyKSLqOPCCOTjJ31u7lUgLgkDdkk7hdPSZNIPFtbKTHBCdp8V0QKvbFnDDC1c2aL71cjs4V
        5yDg022ZgbscRTe8DEcUEhAxi7ttvd5oy6uCJyuM8pW3RFVzLuBAW0yLCHACHqpj3luSYHePxyzu4
        zofwgvVQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46016)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qToea-0002xB-0Y;
        Wed, 09 Aug 2023 20:15:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qToeV-0000zF-TP; Wed, 09 Aug 2023 20:15:27 +0100
Date:   Wed, 9 Aug 2023 20:15:27 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <ZNPlzyxYqgpPUn6K@shell.armlinux.org.uk>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
 <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
 <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
 <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
 <ZNO4RwYzZYUTu1uk@shell.armlinux.org.uk>
 <2f717c52-0ae5-4702-ab34-7ce0bffe8c86@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f717c52-0ae5-4702-ab34-7ce0bffe8c86@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 06:21:58PM +0200, Andrew Lunn wrote:
> > Thinking about this, I wonder whether we could solve your issue by
> > disabling interrupts when the PHY is probed, rather than disabling
> > them on shutdown - something like this? (not build tested)
> > 
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index 3e9909b30938..4d1a37487923 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
> >  			goto out;
> >  	}
> >  
> > +        phy_disable_interrupts(phydev);
> > +
> >  	/* Start out supporting everything. Eventually,
> >  	 * a controller will attach, and may modify one
> >  	 * or both of these values
> 
> At some point, the interrupt is going to be enabled again. And then
> the WoL interrupt will fire. I think some PHY drivers actually need to
> see that WoL interrupt. e.g. the marvell driver has this comment:
> 
> static int m88e1318_set_wol(struct phy_device *phydev,
>                             struct ethtool_wolinfo *wol)
> {
> ....
>                 /* If WOL event happened once, the LED[2] interrupt pin
>                  * will not be cleared unless we reading the interrupt status
>                  * register. If interrupts are in use, the normal interrupt
>                  * handling will clear the WOL event. Clear the WOL event
>                  * before enabling it if !phy_interrupt_is_valid()
>                  */
> 
> So it seems like just probing the marvell PHY is not enough to clear
> the WoL interrupt.
> 
> Can we be sure that the other PHY has reached a state it can handle
> and clear an interrupt when we come to enable the interrupt? I think
> not, especially in cases like NFS root, where the interface will be
> put into use as soon as it exists, maybe before the other interface
> has probed.

I suppose the question to Ioana would be - are the two AR8031 PHYs on
the same MDIO bus? If they are, then we're safe, because both will be
probed consecutively (because they're using the same driver.)

I know it would be desirable to have a generic solution to this, but
I don't think that is sanely achievable if we have multiple different
PHYs sharing an interrupt line over multiple different MDIO buses
and multiple different PHY drivers.

So, I'm suggesting we try to do a best-effort solution to solve Ioana's
problem so that we can restore Uwe's WoL behaviour without causing
Ioana's issue to regress. It does mean that if someone has a more weird
setup (such as I describe in my paragraph above) it won't work, but
then it also didn't used to work before Ioana's patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
