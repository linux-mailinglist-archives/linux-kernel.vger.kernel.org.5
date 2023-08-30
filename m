Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D071E78DF27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbjH3TYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245098AbjH3O1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:27:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149D124
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:27:19 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbM9l-0005o1-43; Wed, 30 Aug 2023 16:26:53 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbM9i-0006uX-Ue; Wed, 30 Aug 2023 16:26:50 +0200
Date:   Wed, 30 Aug 2023 16:26:50 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830142650.GL31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
 <20230830101813.GG31399@pengutronix.de>
 <20230830125224.1012459f@wsk>
 <20230830105941.GH31399@pengutronix.de>
 <20230830135151.683303db@wsk>
 <20230830121738.GJ31399@pengutronix.de>
 <ZO83htinyfAp4mWw@shell.armlinux.org.uk>
 <20230830130649.GK31399@pengutronix.de>
 <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZO9Ejx9G8laNRasu@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 02:30:55PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 30, 2023 at 03:06:49PM +0200, Oleksij Rempel wrote:
> > On Wed, Aug 30, 2023 at 01:35:18PM +0100, Russell King (Oracle) wrote:
> > > On Wed, Aug 30, 2023 at 02:17:38PM +0200, Oleksij Rempel wrote:
> > > > On Wed, Aug 30, 2023 at 01:51:51PM +0200, Lukasz Majewski wrote:
> > > > > Hi Oleksij,
> > > > 
> > > > > It looks like the most optimal solution would be the one proposed by
> > > > > Tristam:
> > > > > https://www.spinics.net/lists/netdev/msg932044.html
> > > > 
> > > > In this case, please add the reason why it would work on this HW and
> > > > will not break by any changes in PHYlib or micrel.c driver.
> > > > 
> > > > If I remember it correctly, in KSZ9477 variants, if you write to EEE
> > > > advertisement register, it will affect the state of a EEE capability
> > > > register. Which break IEEE 802.3 specification and the reason why
> > > > ksz9477_get_features() actually exist. But can be used as workaround if
> > > > it is written early enough before PHYlib tried to read EEE capability
> > > > register.
> > > > 
> > > > Please confirm my assumption by applying your workaround and testing it
> > > > with ethtool --show-eee lanX.
> > > > 
> > > > It should be commented in the code with all kind of warnings:
> > > > Don't move!!! We use one bug to workaround another bug!!! If PHYlib
> > > > start scanning PHYs before this code is executed, then thing may break!!
> > > 
> > > Why would phylib's scanning cause breakage?
> > > 
> > > phylib's scanning for PHYs is about reading the ID registers etc. It
> > > doesn't do anything until the PHY has been found, and then the first
> > > thing that happens when the phy_device structure is created is an
> > > appropriate driver is located, and the driver's ->probe function
> > > is called.
> > > 
> > > If that is successful, then the fewatures are read. If the PHY
> > > driver's ->features member is set, then that initialises the
> > > "supported" mask and we read the EEE abilities.
> > > 
> > > If ->features is not set, then we look to see whether the driver
> > > provides a ->get_features method, and call that.
> > > 
> > > Otherwise we use the generic genphy_c45_pma_read_abilities() or
> > > genphy_read_abilities() depending whether the PHY's is_c45 is set
> > > or not.
> > > 
> > > So, if you want to do something very early before features are read,
> > > then either don't set .features, and do it early in .get_features
> > > before calling anything else, or do it in the ->probe function.
> > 
> > Let me summarize my view on the problem, so may be you can suggest a better
> > way to solve it.
> > - KSZ9477, KSZ8565, KSZ9893, KSZ9563, seems to have different quirks by
> >   the same PHYid. micrel.c driver do now know what exact HW is actually
> >   in use.
> > - A set of PHY workarounds was moved from dsa/microchip/ksz9477.c to
> >   micrel.c, one of this workaround was clearing EEE advertisement
> >   register, which by accident was clearing EEE capability register.
> >   Since EEE cap was cleared by the dsa/microchip/ksz9477.c code before
> >   micrel.c was probed, PHYlib was assuming that his PHY do not supports
> >   EEE and dint tried to use it.
> >   After moving this code to micrel.c, it is now trying to change EEE
> >   advertisement state without letting PHYlib to know about it and PHYlib
> >   re enables it as actually excepted.
> > - so far, only KSZ9477 seems to be broken beyond repair, so it is better
> >   to disable EEE without giving it as a choice for user configuration.
> 
> We do have support in phylib for "broken EEE modes" which DT could set
> for the broken PHYs, and as it is possible to describe the DSA PHYs in
> DT. This sets phydev->eee_broken_modes.
> 
> phydev->eee_broken_modes gets looked at when genphy_config_aneg() or
> genphy_c45_an_config_aneg() gets called - which will happen when the
> PHY is being "started".
> 
> So, you could add the DT properties as appropriate to disable all the
> EEE modes.
> 
> Alternatively, in your .config_init function, you could detect your
> flag and force eee_broken_modes to all-ones.

@Lukasz,

can you please try to set eee_broken_modes to all-ones. Somewhat like
this:
ksz9477_config_init()
...
   ...quirks...

   if (phydev->dev_flages & .. NO_EEE...)
       phydev->eee_broken_modes = -1;

   err = genphy_restart_aneg(phydev);
   ...

@Russell, thx!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
