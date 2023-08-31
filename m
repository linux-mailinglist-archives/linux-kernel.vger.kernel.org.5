Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFAA78EA48
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244696AbjHaKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHaKhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:37:39 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18236CF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 03:37:36 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbf31-0002Kq-EB; Thu, 31 Aug 2023 12:37:11 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbf2z-00067y-Fd; Thu, 31 Aug 2023 12:37:09 +0200
Date:   Thu, 31 Aug 2023 12:37:09 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lukasz Majewski <lukma@denx.de>, Tristram.Ha@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230831103709.GC17603@pengutronix.de>
References: <20230831072527.537839-1-lukma@denx.de>
 <ZPBrMMPiWubgFEZ0@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPBrMMPiWubgFEZ0@shell.armlinux.org.uk>
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

On Thu, Aug 31, 2023 at 11:28:00AM +0100, Russell King (Oracle) wrote:
> On Thu, Aug 31, 2023 at 09:25:27AM +0200, Lukasz Majewski wrote:
> > diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
> > index 8bef1ab62bba..eed474fc7308 100644
> > --- a/include/linux/micrel_phy.h
> > +++ b/include/linux/micrel_phy.h
> > @@ -44,6 +44,7 @@
> >  #define MICREL_PHY_50MHZ_CLK	0x00000001
> >  #define MICREL_PHY_FXEN		0x00000002
> >  #define MICREL_KSZ8_P1_ERRATA	0x00000003
> > +#define MICREL_NO_EEE	0x00000004
> 
> Erm... Maybe someone should clarify this... we have in the code the
> following tests for these "flags":
> 
> 	/* Support legacy board-file configuration */
> 	if (phydev->dev_flags & MICREL_PHY_50MHZ_CLK) {
> 	        priv->rmii_ref_clk_sel = true;
> 	        priv->rmii_ref_clk_sel_val = true;
> 	}
> 
> 	/* Skip auto-negotiation in fiber mode */
> 	if (phydev->dev_flags & MICREL_PHY_FXEN) {
> 	        phydev->speed = SPEED_100;
> 	        return 0;
> 	}
> 
> 	if (phydev->dev_flags & MICREL_KSZ8_P1_ERRATA)
> 		return -EOPNOTSUPP;
> 
> 	/* According to KSZ9477 Errata DS80000754C (Module 4) all EEE modes
> 	 * in this switch shall be regarded as broken.
> 	 */
> 	if (phydev->dev_flags & MICREL_NO_EEE)
> 	        phydev->eee_broken_modes = -1;
> 
> Is it intentional that setting MICREL_PHY_50MHZ_CLK on its own also
> activates the MICREL_KSZ8_P1_ERRATA and vice versa? Is it intentional
> that setting MICREL_PHY_FXEN also activates MICREL_KSZ8_P1_ERRATA and
> vice versa?
> 
> To me, this looks horribly broken, and this patch just perpetuates the
> brokenness (but at least 0x4 doesn't overlap with the other flags.)
> 
> If it is intentional, then MICREL_KSZ8_P1_ERRATA should be defined to
> make it explicit - in other words, as
> (MICREL_PHY_FXEN|MICREL_PHY_50MHZ_CLK). If not, all these flags should
> be defined using (1 << n) or BIT() to make it explicit that they're a
> bit, and not just a hex number that gets incremented when the next flag
> is added.

Indeed, it is broken. I'll send a fix for this one.
MICREL_KSZ8_P1_ERRATA should be BIT(3)
and MICREL_NO_EEE BIT(4)

Thx!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
