Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5119578DE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjH3S5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243435AbjH3LAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:00:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82A11BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:59:58 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbIvG-000610-89; Wed, 30 Aug 2023 12:59:42 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbIvF-000544-3I; Wed, 30 Aug 2023 12:59:41 +0200
Date:   Wed, 30 Aug 2023 12:59:41 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830105941.GH31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
 <20230830101813.GG31399@pengutronix.de>
 <20230830125224.1012459f@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830125224.1012459f@wsk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:52:24PM +0200, Lukasz Majewski wrote:
> Hi Oleksij,
> 
> > On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> > > The KSZ9477 errata points out (in 'Module 4') the link up/down
> > > problem when EEE (Energy Efficient Ethernet) is enabled in the
> > > device to which the KSZ9477 tries to auto negotiate.
> > > 
> > > The suggested workaround is to clear advertisement of EEE for PHYs
> > > in this chip driver.
> > > 
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > ---
> > >  drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 30 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > > index 87b090ad2874..469dcd8a5711 100644
> > > --- a/drivers/net/phy/micrel.c
> > > +++ b/drivers/net/phy/micrel.c
> > > @@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct
> > > phy_device *phydev) return 0;
> > >  }
> > >  
> > > +static int ksz9477_get_features(struct phy_device *phydev)
> > > +{
> > > +	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
> > > +	int ret;
> > > +
> > > +	ret = genphy_read_abilities(phydev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* KSZ9477 Errata DS80000754C
> > > +	 *
> > > +	 * Module 4: Energy Efficient Ethernet (EEE) feature
> > > select must be
> > > +	 * manually disabled
> > > +	 *   The EEE feature is enabled by default, but it is not
> > > fully
> > > +	 *   operational. It must be manually disabled through
> > > register
> > > +	 *   controls. If not disabled, the PHY ports can
> > > auto-negotiate
> > > +	 *   to enable EEE, and this feature can cause link drops
> > > when linked
> > > +	 *   to another device supporting EEE.
> > > +	 *
> > > +	 *   Although, the KSZ9477 MMD register
> > > +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that
> > > EEE is
> > > +	 *   operational one needs to manualy clear them to follow
> > > the chip
> > > +	 *   errata.
> > > +	 */
> > > +	linkmode_and(phydev->supported_eee, phydev->supported,
> > > zero); +
> > > +	return 0;
> > > +}
> > > +
> > >  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
> > >  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
> > >  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> > > @@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] = {
> > >  	.handle_interrupt = kszphy_handle_interrupt,
> > >  	.suspend	= genphy_suspend,
> > >  	.resume		= genphy_resume,
> > > -	.get_features	= ksz9131_get_features,
> > > +	.get_features	= ksz9477_get_features,  
> > 
> > Sorry, i didn't described all details how to implement it.
> > 
> > This code will break EEE support for the KSZ8563R switch.
> > 
> 
> And then another switch (KSZ8563R) pops up.... with regression....

Initially ksz9477_get_features() was introduced to fix KSZ8563R.

> In the micrel.c the ksz9477_get_features was only present in:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L4832
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L4874
> so I only changed it there.
> 
> Apparently the KSZ8563R re-uses the KSZ9477 code.

Most (all?) switch variant support by the ksz9477 DSA driver share the same
PHYid, so it is not possible to identify it by the micrel.c PHY driver.
As far as a know, the only commonly accepted way to notify about some quirks
between this both drivers is not user dev_flags.

Regards,
Oleskij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
