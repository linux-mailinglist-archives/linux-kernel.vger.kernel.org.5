Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031980B558
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjLIRCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIRCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:02:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B845FA
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:02:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E851C433C7;
        Sat,  9 Dec 2023 17:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702141368;
        bh=nRJiA/c/xx7fFzg+0MvluRUxFBY1g4LX9RtAoR1rb7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DB/SMpLN3+TSmIJTzyBHUsFWgUxwjdSaEWhrwKajdPhTmjj29bhCaUo+Zw8tMAcBU
         r738kfP9NIslgrbcsmvxqIQCp9Ml+JACSPnN8T+2l7A3Up0BZmxk537Qkh4YRjvhKk
         W1T+uHnXLv14X7u5PyCRIPjh42BzD+/jddjwXIP5//E8eCtDTpoGWoQOynniJhRtvw
         U9BRNCgB/3WIGqoH7yF+urooe72ZwdZTc4Z12dp6XKjRTMqNL/yOi59W2Eg1TKzDzY
         GxWZhJgE/2admwfwdhjDYOXEm3UNFjhz6sMSypzc9EZvAK+t8OTlYIJl5FoS73S/9y
         VKQxpiTGaMOnw==
Date:   Sat, 9 Dec 2023 17:02:41 +0000
From:   Simon Horman <horms@kernel.org>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Herve Codina <herve.codina@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231209170241.GA5817@kernel.org>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
 <20231201163704.1306431-2-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201163704.1306431-2-maxime.chevallier@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:36:51PM +0100, Maxime Chevallier wrote:
> Link topologies containing multiple network PHYs attached to the same
> net_device can be found when using a PHY as a media converter for use
> with an SFP connector, on which an SFP transceiver containing a PHY can
> be used.
> 
> With the current model, the transceiver's PHY can't be used for
> operations such as cable testing, timestamping, macsec offload, etc.
> 
> The reason being that most of the logic for these configuration, coming
> from either ethtool netlink or ioctls tend to use netdev->phydev, which
> in multi-phy systems will reference the PHY closest to the MAC.
> 
> Introduce a numbering scheme allowing to enumerate PHY devices that
> belong to any netdev, which can in turn allow userspace to take more
> precise decisions with regard to each PHY's configuration.
> 
> The numbering is maintained per-netdev, in a phy_device_list.
> The numbering works similarly to a netdevice's ifindex, with
> identifiers that are only recycled once INT_MAX has been reached.
> 
> This prevents races that could occur between PHY listing and SFP
> transceiver removal/insertion.
> 
> The identifiers are assigned at phy_attach time, as the numbering
> depends on the netdevice the phy is attached to.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Hi Maxime,

some minor feedback from my side.

...

> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index f65e85c91fc1..3cf7774df57e 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Linux PHY drivers
>  
>  libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
> -				   linkmode.o
> +				   linkmode.o phy_link_topology.o
>  mdio-bus-y			+= mdio_bus.o mdio_device.o
>  
>  ifdef CONFIG_MDIO_DEVICE
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c

...

> @@ -265,6 +266,14 @@ static void phy_mdio_device_remove(struct mdio_device *mdiodev)
>  
>  static struct phy_driver genphy_driver;
>  
> +static struct phy_link_topology *phy_get_link_topology(struct phy_device *phydev)
> +{
> +	if (phydev->attached_dev)
> +		return &phydev->attached_dev->link_topo;
> +
> +	return NULL;
> +}
> +

This function is declared static but is unused, which causes
allmodconfig W=1 builds to fail. Perhaps it could be introduced
in a latter patch where it is used?

...

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c

...

> +void phy_link_topo_init(struct phy_link_topology *topo)
> +{
> +	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
> +	topo->next_phy_index = 1;
> +}

...

> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h

...

> +#else
> +static struct phy_device *phy_link_topo_get_phy(struct phy_link_topology *topo,
> +						u32 phyindex)
> +{
> +	return NULL;
> +}
> +
> +static int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +				 struct phy_device *phy,
> +				 enum phy_upstream upt, void *upstream)
> +{
> +	return 0;
> +}
> +
> +static void phy_link_topo_del_phy(struct phy_link_topology *topo,
> +				  struct phy_device *phy)
> +{
> +}
> +#endif

nit: functions in .h should be declared static inline

...

> diff --git a/net/core/dev.c b/net/core/dev.c

...

> @@ -10832,6 +10833,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  #ifdef CONFIG_NET_SCHED
>  	hash_init(dev->qdisc_hash);
>  #endif
> +	phy_link_topo_init(&dev->link_topo);
> +

I don't think this can work unless PHYLIB is compiled as a built-in.

>  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
>  	setup(dev);
>  
> -- 
> 2.42.0
> 
