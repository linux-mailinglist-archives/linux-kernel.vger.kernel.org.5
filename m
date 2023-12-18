Return-Path: <linux-kernel+bounces-3230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9A6816982
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36198283973
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18213AFB;
	Mon, 18 Dec 2023 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ljw2XM+R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1211CBB;
	Mon, 18 Dec 2023 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 095D320008;
	Mon, 18 Dec 2023 09:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702890696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OBTXeobvAao2elv1Us1jNoj3BBwaFsWehDBGjdTmWM=;
	b=Ljw2XM+RwyZdoABuOUgAfR696duSJac4s6RgaCinY934AISWquhy9TW12Gvzpp68InQPwS
	lg76IM3Akkj4De6hNnul/qsEFeAgKB4KbybIrS9k474TrTSXmc6Yo5aYznH0V1Nf2lGJkT
	OBVBKIiL7bF6CEv1BpJb4Uw8YMX0sPtLHSvhIBvuKxaDKB1EhdvMyQZoz33OJfABfmfu8B
	garW0o5+GWV7udu48PCDgkZozPWhisc76tJFFeX4xD4LYLgM7mqrcbIx/di2rNiW8/7gLY
	uErOyachtoHKLRvY+g482lkSvVE6cB0bx11pTAKjyaBA40lwT5Wekfs5XVCy5w==
Date: Mon, 18 Dec 2023 10:11:31 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231218101131.04160623@device-28.home>
In-Reply-To: <20231215214523.ntk5kec32mb5vqjs@skbuf>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-1-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-2-maxime.chevallier@bootlin.com>
	<20231215171237.1152563-2-maxime.chevallier@bootlin.com>
	<20231215214523.ntk5kec32mb5vqjs@skbuf>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Vlad, PHy maintainers,

On Fri, 15 Dec 2023 23:45:23 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

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
> 
> I haven't done too much with the patch set yet, so I don't understand
> exactly from the comment what this is protecting. But I get the
> following assertion failure with DSA:
> 
> [    4.157160] ------------[ cut here ]------------
> [    4.161805] RTNL: assertion failed at drivers/net/phy/phy_link_topology.c (35)
> [    4.169124] WARNING: CPU: 0 PID: 26 at drivers/net/phy/phy_link_topology.c:35 phy_link_topo_add_phy+0x128/0x130
> [    4.179263] Modules linked in:
> [    4.209232] pc : phy_link_topo_add_phy+0x128/0x130
> [    4.214040] lr : phy_link_topo_add_phy+0x128/0x130
> [    4.293822] Call trace:
> [    4.296271]  phy_link_topo_add_phy+0x128/0x130
> [    4.300730]  phy_attach_direct+0xbc/0x3c4
> [    4.304752]  phylink_fwnode_phy_connect+0xa8/0xf8
> [    4.309473]  phylink_of_phy_connect+0x1c/0x28
> [    4.313844]  dsa_user_create+0x318/0x5ac
> [    4.317778]  dsa_port_setup+0x100/0x144
> [    4.321626]  dsa_register_switch+0xe90/0x11f8
> [    4.325997]  sja1105_probe+0x2bc/0x2e4
> [    4.329759]  spi_probe+0xa4/0xc4
> [    4.332995]  really_probe+0x16c/0x3fc
> [    4.336669]  __driver_probe_device+0xa4/0x168
> [    4.341041]  driver_probe_device+0x3c/0x220
> [    4.345238]  __device_attach_driver+0x128/0x1cc
> [    4.349784]  bus_for_each_drv+0xf4/0x14c
> [    4.353719]  __device_attach+0xfc/0x1bc
> [    4.357567]  device_initial_probe+0x14/0x20
> [    4.361764]  bus_probe_device+0x94/0x100
> [    4.385371] ---[ end trace 0000000000000000 ]---
> 
> Someone please correct me if I'm wrong, but at least up until now, calling
> this unlocked has been quite harmless, because we call dsa_user_phy_setup()
> before register_netdevice(), and thus, the net_device is pretty much
> inaccessible to the world when we attach it to the PHY.

Ok so I'll give it more thought on that part, and analyze better the
access paths that ca be problematic. I'll update the doc accordingly,
as this is non-trivial. I haven't been able to test it on a DSA setup,
nor on a !phylink mac, so thanks a lot for testing :)
> 
> And, while having the phydev->attached_dev pointer populated technically
> makes the net_device now accessible from the PHY, this is a moot point,
> because no user space command targets the PHY directly. They all target
> the netdev, and through that, netdev->phydev. The netdev is still
> unregistered, so it's ok to not have rtnl_lock().
> 
> It is rather going to be something that concerns those drivers which call
> phy_attach_direct() after registering, for example from ndo_open().

In that case this is fine, right ? As ndo_open runs with rtnl held,
phy-targetting netlink commands (that indeed goes through the netdev)
will be also serialized ? I might be missing the point though :(

> Interestingly, phylink_disconnect_phy() has an ASSERT_RTNL() in it
> even though the phylink_attach_phy() derivatives do not. I'm unable
> to ascertain whether a previous unregister_netdevice() call makes this
> requirement redundant or not.
> 
> > +
> > +	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> > +	if (!pdn)
> > +		return -ENOMEM;
> > +
> > +	pdn->phy = phy;
> > +	switch (upt) {
> > +	case PHY_UPSTREAM_MAC:
> > +		pdn->upstream.netdev = (struct net_device *)upstream;
> > +		if (phy_on_sfp(phy))
> > +			pdn->parent_sfp_bus = pdn->upstream.netdev->sfp_bus;
> > +		break;
> > +	case PHY_UPSTREAM_PHY:
> > +		pdn->upstream.phydev = (struct phy_device *)upstream;
> > +		if (phy_on_sfp(phy))
> > +			pdn->parent_sfp_bus = pdn->upstream.phydev->sfp_bus;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		goto err;
> > +	}
> > +	pdn->upstream_type = upt;
> > +
> > +	ret = xa_alloc_cyclic(&topo->phys, &phy->phyindex, pdn, xa_limit_32b,
> > +			      &topo->next_phy_index, GFP_KERNEL);
> > +	if (ret)
> > +		goto err;
> > +
> > +	return 0;
> > +
> > +err:
> > +	kfree(pdn);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);  


