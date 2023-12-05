Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B199805B81
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjLEO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346023AbjLEO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:58:12 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323CA1B6;
        Tue,  5 Dec 2023 06:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Niv+uFMMZ47PdYI45Y9AoLriOrLQtx81cAeZSJ25KPY=; b=ECiJfHJrsr/f0L+71GqdBnpXnC
        lNdo5YsQfw3YwR5YsupiWzdR/S/Lzz8Oo81W0jeZ/BB+e6wGAQMJBGJUZo/X1Cc3c//0boPlHxrC9
        Tds6aGdauv5GLQFy3nLOSw5BH7pHcLIRAaVqF6tV64N7xI3LjkMv7FItwu21vhjhdYvUNeKr2TYme
        gr78D0OUB2OVMIfP6iBCP6ZKx3FFRFGgg8TsQLLlcB7gL+3eWh/c6/h4iAfxzd/YtJwmVoR1i4fps
        01GQ2rAgoeBr8uyA82aCDmza9wcGEEh/GrGnK7oNGfbQeiSK82MFYntbBH6LvVkpTe+NGJispS/4Q
        CwS1tqWg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36310)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rAWsF-0006vo-0d;
        Tue, 05 Dec 2023 14:58:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rAWsH-0001nv-2u; Tue, 05 Dec 2023 14:58:13 +0000
Date:   Tue, 5 Dec 2023 14:58:13 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 08/12] net: phy: at803x: move specific at8031
 WOL bits to dedicated function
Message-ID: <ZW86hcgt8nhbSpfq@shell.armlinux.org.uk>
References: <20231201001423.20989-1-ansuelsmth@gmail.com>
 <20231201001423.20989-9-ansuelsmth@gmail.com>
 <bdbe618d4fd38469e4e139ce4ebd161766f2e4d5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdbe618d4fd38469e4e139ce4ebd161766f2e4d5.camel@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:32:55AM +0100, Paolo Abeni wrote:
> On Fri, 2023-12-01 at 01:14 +0100, Christian Marangi wrote:
> > Move specific at8031 WOL enable/disable to dedicated function to make
> > at803x_set_wol more generic.
> > 
> > This is needed in preparation for PHY driver split as qca8081 share the
> > same function to toggle WOL settings.
> > 
> > In this new implementation WOL module in at8031 is enabled after the
> > generic interrupt is setup. This should not cause any problem as the
> > WOL_INT has a separate implementation and only relay on MAC bits.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/at803x.c | 42 ++++++++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index 02ac71f98466..2de7a59c0faa 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -466,27 +466,11 @@ static int at803x_set_wol(struct phy_device *phydev,
> >  			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
> >  				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
> >  
> > -		/* Enable WOL function for 1588 */
> > -		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> > -			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > -					     AT803X_PHY_MMD3_WOL_CTRL,
> > -					     0, AT803X_WOL_EN);
> > -			if (ret)
> > -				return ret;
> > -		}
> >  		/* Enable WOL interrupt */
> >  		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > -		/* Disable WoL function for 1588 */
> > -		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> > -			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > -					     AT803X_PHY_MMD3_WOL_CTRL,
> > -					     AT803X_WOL_EN, 0);
> > -			if (ret)
> > -				return ret;
> > -		}
> >  		/* Disable WOL interrupt */
> >  		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
> >  		if (ret)
> > @@ -1611,6 +1595,30 @@ static int at8031_config_init(struct phy_device *phydev)
> >  	return at803x_config_init(phydev);
> >  }
> >  
> > +static int at8031_set_wol(struct phy_device *phydev,
> > +			  struct ethtool_wolinfo *wol)
> > +{
> > +	int ret;
> > +
> > +	/* First setup MAC address and enable WOL interrupt */
> > +	ret = at803x_set_wol(phydev, wol);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (wol->wolopts & WAKE_MAGIC)
> > +		/* Enable WOL function for 1588 */
> > +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				     AT803X_PHY_MMD3_WOL_CTRL,
> > +				     0, AT803X_WOL_EN);
> > +	else
> > +		/* Disable WoL function for 1588 */
> > +		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> > +				     AT803X_PHY_MMD3_WOL_CTRL,
> > +				     AT803X_WOL_EN, 0);
> > +
> > +	return ret;
> 
> If I read correctly, the above changes the order of some WoL
> initialization steps: now WOL_CTRL is touched after
> AT803X_INTR_ENABLE_WOL. Is that correct?

It is fine.

AT803X_INTR_ENABLE_WOL enables or disables whether the INT pin (which
is used for any interrupt from the PHY) is used to signal WOL - it's
the interrupt enable for the WoL function.

The MMD3 WOL_EN bit controls whether the WoL function is enabled, and
thus whether the WOL_INT pin will signal WoL. WOL_EN should not be
set until we have initialised the WoL function, and thus that needs
to happen _after_ the MAC address has been programmed.

Clearing WOL_EN afterwards is not a problem because it will already
have been setup, or is in its power-on default state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
