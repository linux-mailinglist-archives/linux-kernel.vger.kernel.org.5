Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B91D7F605A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345492AbjKWNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbjKWNeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:34:11 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF0BA;
        Thu, 23 Nov 2023 05:34:14 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F59620005;
        Thu, 23 Nov 2023 13:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700746453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cinKUmZ4zkbIH1tUjGf+OdP+ZTy+Ry1+qtGbfY1mZ8A=;
        b=UOO8Za6HjSl2UudqbG/0pNhsaYzO/1IlyebbDxI+/Q1ridQHcUG1e2KxWTsYCLh74nqsWj
        Ny45otfpj5EqCSTIh4iBCX12ZggZ2RLloAGQu45f+254IcKVlH4TgyWocDfInwkt6K6/Qn
        ULGwlks2vcTfpsacv5Wy5TdOgl4FlYCptjDdUysrt2NsGpQHwp0oZ274nQFPBIQcB2CfzK
        NYfHUSG28wqYuGkZK8DsaPDzLDFanOI9yC4vs8EcLXNLuh746PR8flwQDE08+3GspoAQm/
        CIvfTaZgV89treUfuBt0ny2T8XYLoPC89uqJyCL7XorJeMdAxAvQjD3DDiJckw==
Date:   Thu, 23 Nov 2023 14:34:08 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 01/10] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231123143408.3cae1b04@device.home>
In-Reply-To: <9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
        <20231117162323.626979-2-maxime.chevallier@bootlin.com>
        <9079c9f5-5531-4c38-b9c9-975ed3d96104@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Tue, 21 Nov 2023 01:24:47 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
> > +		      enum phy_upstream upt, void *upstream)
> > +{
> > +	ret = xa_alloc_cyclic(&lt->phys, &phy->phyindex, pdn, xa_limit_32b,
> > +			      &lt->next_phy_index, GFP_KERNEL);
> > +	if (ret)
> > +		goto err;
> > +
> > +	return 0;  
> 
> It looks like that could be just return xa_alloc_cyclic(...);

Indeed, nice catch

> 
> > diff --git a/include/linux/link_topology.h b/include/linux/link_topology.h  
> 
> I think this filename is too generic. Maybe phy_link_topology.h, or
> move it into include/net.
> 
> > +struct phy_device *link_topo_get_phy(struct link_topology *lt, int phyindex);
> > +int link_topo_add_phy(struct link_topology *lt, struct phy_device *phy,
> > +		      enum phy_upstream upt, void *upstream);
> > +
> > +void link_topo_del_phy(struct link_topology *lt, struct phy_device *phy);  
> 
> What is the locking for these functions? Are you assuming RTNL? Maybe
> add ASSERT_RTNL(); into them to make this clear.

Indeed I assume it, I'll add an assert and document that clearly then.

> 
> > diff --git a/include/linux/link_topology_core.h b/include/linux/link_topology_core.h  
> 
> Again, i think this filename is too generic.
> 
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index a16c9cc063fe..7021a0d3d982 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -40,7 +40,6 @@
> >  #include <net/dcbnl.h>
> >  #endif
> >  #include <net/netprio_cgroup.h>
> > -
> >  #include <linux/netdev_features.h>  
> 
> Whitespace change.
> 
> >  #include <linux/neighbour.h>
> >  #include <uapi/linux/netdevice.h>
> > @@ -52,6 +51,7 @@
> >  #include <net/net_trackers.h>
> >  #include <net/net_debug.h>
> >  #include <net/dropreason-core.h>
> > +#include <linux/link_topology_core.h>
> >  
> >  struct netpoll_info;
> >  struct device;
> > @@ -2405,6 +2405,7 @@ struct net_device {
> >  #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
> >  	struct netprio_map __rcu *priomap;
> >  #endif
> > +	struct link_topology	link_topo;
> >  	struct phy_device	*phydev;
> >  	struct sfp_bus		*sfp_bus;
> >  	struct lock_class_key	*qdisc_tx_busylock;
> > diff --git a/include/linux/phy.h b/include/linux/phy.h
> > index 3cc52826f18e..d698180b1df0 100644
> > --- a/include/linux/phy.h
> > +++ b/include/linux/phy.h
> > @@ -543,6 +543,8 @@ struct macsec_ops;
> >   * @drv: Pointer to the driver for this PHY instance
> >   * @devlink: Create a link between phy dev and mac dev, if the external phy
> >   *           used by current mac interface is managed by another mac interface.
> > + * @phyindex: Unique id across the phy's parent tree of phys to address the PHY
> > + *	      from userspace, similar to ifindex. It's never recycled.
> >   * @phy_id: UID for this device found during discovery
> >   * @c45_ids: 802.3-c45 Device Identifiers if is_c45.
> >   * @is_c45:  Set to true if this PHY uses clause 45 addressing.
> > @@ -640,6 +642,7 @@ struct phy_device {
> >  
> >  	struct device_link *devlink;
> >  
> > +	int phyindex;  
> 
> Is this int, or unsigned int? Is a negative value possible and legal?

You're right this should be unsigned. I've also missed properly
documenting correct values and their meaning (like phyindex 0 would be
no index assigned).

> 
> > +enum phy_upstream {
> > +	PHY_UPSTREAM_MAC,
> > +	PHY_UPSTREAM_SFP,
> > +	PHY_UPSTREAM_PHY,
> > +};  
> 
> Please document what these actually mean.

I'll do this as well.

Thank you for reviewing,

Maxime

> 
>        Andrew

