Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F60D77649F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjHIQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHIQB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:01:28 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E81FD8;
        Wed,  9 Aug 2023 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eOxZCgE9K/bIT0kCTxhTuxaKDLpBxYAgIThfi5ma4Bo=; b=xlCDOvwy1wpsIF5LfpfHLtBXS4
        7hNwpSURnjRUa5dFOHChAM+YM4et6q/KAkXpT4oXa7y2GC1ZQsMZD5JbqhNrQa8K4E/rgSt2JYB10
        DUzk1iDdRGfO7PQ7HiKofqrEhBwQ2f4ws72uv5XcIXyJo5SCCLqGJpuwpHZ7nX2IIv1WFWHTzFF1o
        VEXupjWUEv3A/r7uzC5VQglrSGdGg7dpt9klClsUbsMWOVmk9Pom4G6O62PIcJFVOooHCOw+2pjli
        8QCXGX+OF8ezpflLgFwIItklz6RLjbKz+yw87kw1FWzJovANcqlBTblwgoRd4ppczNd+nPK3cBZ4q
        k5nIdmqg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42930)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qTlcY-0002jf-2V;
        Wed, 09 Aug 2023 17:01:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qTlcV-0000rC-VT; Wed, 09 Aug 2023 17:01:11 +0100
Date:   Wed, 9 Aug 2023 17:01:11 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
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
Message-ID: <ZNO4RwYzZYUTu1uk@shell.armlinux.org.uk>
References: <20230804071757.383971-1-u.kleine-koenig@pengutronix.de>
 <20230808145325.343c5098@kernel.org>
 <1e438a02-6964-ce65-5584-e8ea57a694bb@gmail.com>
 <ZNLIOEBXNgPOnFSf@shell.armlinux.org.uk>
 <20230809142155.4dtmnmmecaycbtum@LXL00007.wbi.nxp.com>
 <ZNOivVJ+G/sRiwai@shell.armlinux.org.uk>
 <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809154418.hjkf43ndwfzretiy@LXL00007.wbi.nxp.com>
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

On Wed, Aug 09, 2023 at 06:44:18PM +0300, Ioana Ciornei wrote:
> On Wed, Aug 09, 2023 at 03:29:17PM +0100, Russell King (Oracle) wrote:
> > On Wed, Aug 09, 2023 at 05:21:55PM +0300, Ioana Ciornei wrote:
> > > That's a perfect summary of the problem that I was trying to fix.
> > > 
> > > The board in question is a LS1021ATSN which has two AR8031 PHYs that
> > > share an interrupt line. In case only one of the PHYs is probed and
> > > there are pending interrupts on the PHY#2 an IRQ storm will happen
> > > since there is no entity to clear the interrupt from PHY#2's registers.
> > > PHY#1's driver will get stuck in .handle_interrupt() indefinitely.
> > 
> > So I have two further questions:
> > 1. Is WoL able to be supported on this hardware?
> 
> I don't know if anyone cares about WoL on the AR8031 PHYs from this
> board.
> 
> Both of the PHYs are used in conjuction with 2 eTSEC controllers - which
> use the driver in drivers/net/ethernet/freescale/gianfar.c.
> 
> The Ethernet controller does have WoL support, which means that WoL could
> still be supported on the board even though we would forbid WoL on the
> AR8031 PHYs.
> 
> > 2. AR8031 has a seperate WOL_INT signal that can be used to wake up the
> >    system. Is this used in the hardware design?
> 
> No, WOL_INT is not connected.

Okay, so we don't need to care about WoL for your hardware setup.

Thinking about this, I wonder whether we could solve your issue by
disabling interrupts when the PHY is probed, rather than disabling
them on shutdown - something like this? (not build tested)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 3e9909b30938..4d1a37487923 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3216,6 +3216,8 @@ static int phy_probe(struct device *dev)
 			goto out;
 	}
 
+        phy_disable_interrupts(phydev);
+
 	/* Start out supporting everything. Eventually,
 	 * a controller will attach, and may modify one
 	 * or both of these values
@@ -3333,16 +3335,6 @@ static int phy_remove(struct device *dev)
 	return 0;
 }
 
-static void phy_shutdown(struct device *dev)
-{
-	struct phy_device *phydev = to_phy_device(dev);
-
-	if (phydev->state == PHY_READY || !phydev->attached_dev)
-		return;
-
-	phy_disable_interrupts(phydev);
-}
-
 /**
  * phy_driver_register - register a phy_driver with the PHY layer
  * @new_driver: new phy_driver to register
@@ -3376,7 +3368,6 @@ int phy_driver_register(struct phy_driver *new_driver, struct module *owner)
 	new_driver->mdiodrv.driver.bus = &mdio_bus_type;
 	new_driver->mdiodrv.driver.probe = phy_probe;
 	new_driver->mdiodrv.driver.remove = phy_remove;
-	new_driver->mdiodrv.driver.shutdown = phy_shutdown;
 	new_driver->mdiodrv.driver.owner = owner;
 	new_driver->mdiodrv.driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
