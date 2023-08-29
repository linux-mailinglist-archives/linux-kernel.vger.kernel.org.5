Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ADF78CA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbjH2RMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbjH2RMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:12:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50963AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:18 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qb2G7-0006Hf-RH; Tue, 29 Aug 2023 19:12:07 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qb2G5-0007PG-Gy; Tue, 29 Aug 2023 19:12:05 +0200
Date:   Tue, 29 Aug 2023 19:12:05 +0200
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
Message-ID: <20230829171205.GE31399@pengutronix.de>
References: <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
 <20230829114739.GC31399@pengutronix.de>
 <20230829143829.68410966@wsk>
 <20230829144209.GD31399@pengutronix.de>
 <20230829172913.518210b0@wsk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829172913.518210b0@wsk>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 05:29:13PM +0200, Lukasz Majewski wrote:
> Hi Oleksij,
> > On other hand, since this functionality is not listed as supported by
> > the KSZ9477 datasheet (No word about IEEE 802.3az Energy Efficient
> > Ethernet (EEE)) compared to KSZ8565R datasheet (where EEE support is
> > listed) and it is confirmed to work not stable enough, then it should
> > be disabled properly.
> 
> I've described this problem in more details here:
> https://lore.kernel.org/lkml/20230829132429.529283be@wsk/
> 
> -------->8---------
> The issue is that ksz9477_config_init() (drivers/net/phy/micrel.c) is
> executed AFTER generic phy_probe():
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/phy_device.c#L3256
> in which the EEE advertisement registers are read.
> 
> Hence, those registers needs to be cleared earlier - as I do in
> ksz9477_setup() in drivers/net/dsa/microchip/ksz9477.
> 
> Here the precedence matters ...
> ----------8<-------------
> 
> > The phydev->supported_eee should be cleared.
> > See ksz9477_get_features().
> > 
> 
> Removing the linkmod_and() from ksz9477_get_features():
> https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/micrel.c#L1408
> 
> doesn't help.

Yes, removing linkmod_and() will not should not help. I said, "The
phydev->supported_eee should be cleared."

For example like this:
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1400,6 +1400,7 @@ static int ksz9131_config_aneg(struct phy_device *phydev)
 
 static int ksz9477_get_features(struct phy_device *phydev)
 {
+       __ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
        int ret;
 
        ret = genphy_read_abilities(phydev);
@@ -1413,7 +1414,7 @@ static int ksz9477_get_features(struct phy_device *phydev)
         * KSZ8563R should have 100BaseTX/Full only.
         */
        linkmode_and(phydev->supported_eee, phydev->supported,
-                    PHY_EEE_CAP1_FEATURES);
+                    zero);
 
        return 0;
 }

You will need to clear it only on KSZ9477 variants with this bug.
This change is tested and it works on my KSZ9477-EVB.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
