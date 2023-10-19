Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C407CF468
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345098AbjJSJtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 05:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjJSJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 05:49:19 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF5E184
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 02:49:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtPeK-0000PU-NG; Thu, 19 Oct 2023 11:49:04 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qtPeI-002lD7-FX; Thu, 19 Oct 2023 11:49:02 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtPeI-00FFi4-Cl; Thu, 19 Oct 2023 11:49:02 +0200
Date:   Thu, 19 Oct 2023 11:49:02 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        netdev@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH net-next v2 3/3] net: phy: micrel: Fix forced link mode
 for KSZ886X switches
Message-ID: <20231019094902.GB3632494@pengutronix.de>
References: <20231012065502.2928220-1-o.rempel@pengutronix.de>
 <20231012065502.2928220-1-o.rempel@pengutronix.de>
 <20231012065502.2928220-4-o.rempel@pengutronix.de>
 <20231012065502.2928220-4-o.rempel@pengutronix.de>
 <20231013122646.bjiy6soo3pdquk53@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231013122646.bjiy6soo3pdquk53@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, Oct 13, 2023 at 03:26:46PM +0300, Vladimir Oltean wrote:
> Hi Oleksij,
> 
> On Thu, Oct 12, 2023 at 08:55:02AM +0200, Oleksij Rempel wrote:
> > Address a link speed detection issue in KSZ886X PHY driver when in
> > forced link mode. Previously, link partners like "ASIX AX88772B"
> > with KSZ8873 could fall back to 10Mbit instead of configured 100Mbit.
> > 
> > The issue arises as KSZ886X PHY continues sending Fast Link Pulses (FLPs)
> > even with autonegotiation off, misleading link partners in autoneg mode,
> > leading to incorrect link speed detection.
> > 
> > Now, when autonegotiation is disabled, the driver sets the link state
> > forcefully using KSZ886X_CTRL_FORCE_LINK bit. This action, beyond just
> > disabling autonegotiation, makes the PHY state more reliably detected by
> > link partners using parallel detection, thus fixing the link speed
> > misconfiguration.
> > 
> > With autonegotiation enabled, link state is not forced, allowing proper
> > autonegotiation process participation.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> 
> Have you considered denying "ethtool -s swpN autoneg off" in "net.git"
> (considering that it doesn't work properly), and re-enabling it in
> "net-next.git"?

Yes, but for ksz8 task I don't have budget to go this way.

> >  drivers/net/phy/micrel.c | 32 +++++++++++++++++++++++++++++---
> >  1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> > index 927d3d54658e..599ebf54fafe 100644
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -1729,9 +1729,35 @@ static int ksz886x_config_aneg(struct phy_device *phydev)
> >  {
> >  	int ret;
> >  
> > -	ret = genphy_config_aneg(phydev);
> > -	if (ret)
> > -		return ret;
> > +	if (phydev->autoneg != AUTONEG_ENABLE) {
> > +		ret = genphy_setup_forced(phydev);
> > +		if (ret)
> > +			return ret;
> 
> __genphy_config_aneg() will call genphy_setup_forced() as appropriate,
> and additionally it will resync the master-slave resolution to a forced
> value, if needed. So I think it's better to call genphy_config_aneg()
> from the common code path, and just use the "if (phydev->autoneg)" test
> to keep the vendor-specific register in sync with the autoneg setting.

ack. Will update it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
