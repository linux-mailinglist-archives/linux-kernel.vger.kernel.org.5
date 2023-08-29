Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A257F78C395
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjH2Lr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjH2Lrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:47:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040A612D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 04:47:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qaxC9-0005k9-Ke; Tue, 29 Aug 2023 13:47:41 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qaxC7-000743-Uk; Tue, 29 Aug 2023 13:47:39 +0200
Date:   Tue, 29 Aug 2023 13:47:39 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        f.fainelli@gmail.com, andrew@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, Woojung.Huh@microchip.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230829114739.GC31399@pengutronix.de>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829132429.529283be@wsk>
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

Hi Lukasz,

On Tue, Aug 29, 2023 at 01:24:29PM +0200, Lukasz Majewski wrote:
> Hi Vladimir,
> 
> > Hi Lukasz,
> > 
> > On Tue, Aug 29, 2023 at 10:35:33AM +0200, Lukasz Majewski wrote:
> > > Hi Vladimir,
> > >   
> > > > On Fri, Aug 25, 2023 at 06:48:41PM +0000,
> > > > Tristram.Ha@microchip.com wrote:  
> > > > > > > IMHO adding functions to MMD modification would facilitate
> > > > > > > further development (for example LED setup).    
> > > > > > 
> > > > > > We already have some KSZ9477 specific initialization done in
> > > > > > the Micrel PHY driver under drivers/net/phy/micrel.c, can we
> > > > > > converge on the PHY driver which has a reasonable amount of
> > > > > > infrastructure for dealing with workarounds, indirect or
> > > > > > direct MMD accesses etc.?    
> > > > > 
> > > > > Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893
> > > > > switches are special and only used inside those switches.
> > > > > Putting all the switch related code in Micrel PHY driver does
> > > > > not really help.  When the switch is reset all those PHY
> > > > > registers need to be set again, but the PHY driver only
> > > > > executes those code during PHY initialization.  I do not know
> > > > > if there is a good way to tell the PHY to re-initialize again.
> > > > >   
> > > > 
> > > > Suppose there was a method to tell the PHY driver to re-initialize
> > > > itself. What would be the key points in which the DSA switch
> > > > driver would need to trigger that method? Where is the switch
> > > > reset at runtime?  
> > > 
> > > Tristam has explained why adding the internal switch PHY errata to
> > > generic PHY code is not optimal.  
> > 
> > Yes, and I didn't understand that explanation, so I asked a
> > clarification question.
> 
> Ok. Let's wait for Tristram's answer.
> 
> > 
> > > If adding MMD generic code is a problem - then I'm fine with just
> > > clearing proper bits with just two indirect writes in the
> > > drivers/net/dsa/microchip/ksz9477.c
> > > 
> > > I would also prefer to keep the separate ksz9477_errata() function,
> > > so we could add other errata code there.
> > > 
> > > Just informative - without this patch the KSZ9477-EVB board's
> > > network is useless when the other peer has EEE enabled by default
> > > (like almost all non managed ETH switches).  
> > 
> > No, adding direct PHY MMD access code to the ksz9477 switch driver is
> > not even the biggest problem - even though, IIUC, the "workaround" to
> > disable EEE advertisement could be moved to ksz9477_get_features() in
> > drivers/net/phy/micrel.c, where phydev->supported_eee could be
> > cleared.
> 
> To be even more interesting (after looking into the PHY micrel.c code):
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L1804
> 
> The errata from this patch is already present.
> 
> The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c) is
> executed AFTER generic phy_probe():
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L3256
> in which the EEE advertisement registers are read.
> 
> Hence, those registers needs to be cleared earlier - as I do in
> ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.
> 
> Here the precedence matters ...
> > 
> > The biggest problem that I see is that Oleksij Rempel has "just" added
> > EEE support to the KSZ9477 earlier this year, with an ack from Arun
> > Ramadoss: 69d3b36ca045 ("net: dsa: microchip: enable EEE support").
> > I'm not understanding why the erratum wasn't a discussion topic then.
> 
> +1

As this erratum states:  "this feature _can_ cause link drops".
For example I was indeed able to have EEE relates issue between this
switch and a link partner with AR8035 PHY. Following patch addressing
this issue:
https://lore.kernel.org/all/20230327142202.3754446-8-o.rempel@pengutronix.de/
So, in this case KSZ9477 was not the bad side.

Since this erratum do not describe exact cause of this issue or specific
link partners where this functionality is not working, I would prefer to
give the user the freedom of choice.

The same issue we have with Pause Frame support. It is not always a good
choice, but user has freedom to configure it.

Today I wont to create a test setup with different EEE capable link
partners on one side and KSZ9477 on other side and let it run some days.
Just to make sure.

Beside, are you able to reproduce this issue?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
