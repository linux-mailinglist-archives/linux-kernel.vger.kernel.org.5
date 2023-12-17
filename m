Return-Path: <linux-kernel+bounces-2690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3290816096
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD39B22419
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEDF46421;
	Sun, 17 Dec 2023 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EaKGOjUm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DDE47F5E;
	Sun, 17 Dec 2023 16:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gQ4VXb6aTdqcaOkXb5g9GnK1Q/37tTNEjG1RRH6Dcn0=; b=EaKGOjUm/Lmqo4HWwoN5DYsu9V
	cR4Xv0Rpt0TZSVgkRoBB0REzy+MCPnFok4MnDE8pQtr9mZg4X/9EiSk7WJwhTVBWa7xpRImVdEwLq
	pT63WDfGl9guNcHF3SexzzyXxp/ccpD6BIefUN0W9Tjt6ptTHf5t/hp1oUUSEvoyagM8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEuRy-003A5K-R1; Sun, 17 Dec 2023 17:57:10 +0100
Date: Sun, 17 Dec 2023 17:57:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <ede222d4-11da-4b95-a685-17cb480694dd@lunn.ch>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
 <20231215214523.ntk5kec32mb5vqjs@skbuf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215214523.ntk5kec32mb5vqjs@skbuf>

On Fri, Dec 15, 2023 at 11:45:23PM +0200, Vladimir Oltean wrote:
> On Fri, Dec 15, 2023 at 06:12:23PM +0100, Maxime Chevallier wrote:
> > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > index d8e9335d415c..89daaccc9276 100644
> > --- a/drivers/net/phy/phy_device.c
> > +++ b/drivers/net/phy/phy_device.c
> > @@ -1491,6 +1500,11 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
> >  
> >  		if (phydev->sfp_bus_attached)
> >  			dev->sfp_bus = phydev->sfp_bus;
> > +
> > +		err = phy_link_topo_add_phy(&dev->link_topo, phydev,
> > +					    PHY_UPSTREAM_MAC, dev);
> > +		if (err)
> > +			goto error;
> >  	}
> >  
> >  	/* Some Ethernet drivers try to connect to a PHY device before
> > @@ -1816,6 +1830,7 @@ void phy_detach(struct phy_device *phydev)
> >  	if (dev) {
> >  		phydev->attached_dev->phydev = NULL;
> >  		phydev->attached_dev = NULL;
> > +		phy_link_topo_del_phy(&dev->link_topo, phydev);
> >  	}
> >  	phydev->phylink = NULL;
> >  
> > diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> > new file mode 100644
> > index 000000000000..22f6372d002c
> > --- /dev/null
> > +++ b/drivers/net/phy/phy_link_topology.c
> > +int phy_link_topo_add_phy(struct phy_link_topology *topo,
> > +			  struct phy_device *phy,
> > +			  enum phy_upstream upt, void *upstream)
> > +{
> > +	struct phy_device_node *pdn;
> > +	int ret;
> > +
> > +	/* Protects phy and upstream */
> > +	ASSERT_RTNL();
> 
> Something to think for the PHY library maintainers. This is probably
> the first time when the rtnl_lock() requirement is asserted at
> phy_attach_direct() time.

There are two use cases here for plain MAC drivers.

1) phy_attach_direct() is called from probe. RTNL is normally not
held, the driver would have to take it before making the call.

2) phy_attach_direct() is called from ndo_open. In that case,
__dev_open() has a ASSERT_RTNL() so we can assume RTNL has been taken.

So i don't think we can assume RTNL is held, but it might be held.

We need a better understanding what is being protected here.

   Andrew

