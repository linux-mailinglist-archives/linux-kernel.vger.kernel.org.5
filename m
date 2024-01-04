Return-Path: <linux-kernel+bounces-17333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F0824BDC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD586286F05
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586942D612;
	Thu,  4 Jan 2024 23:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNCsURMM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF52D051;
	Thu,  4 Jan 2024 23:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4806FC433C8;
	Thu,  4 Jan 2024 23:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704411243;
	bh=gbY3raGSprk25DNxWli+kh8jpocIFdqypsvx82WgUEM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SNCsURMMk1K5/WdU5XxUz4qDQLQtlBxYUS00b14MiPQs9xQ9OvCH1uC6OJyvIPYP2
	 ixKQJk5224ThEFVWOiZ0WCSy70MIIM0wNX28ZWm6/5gIH3fhRTnw0g0CfBHl+vHxse
	 ekz8EljDuSEKsS0+1X9s0GBwSaCztJQPrS6CUBThMnlPqhKMufp8q08Eou2oV1esYi
	 CFdyZHT4mj1RyJiSaMaIa7N49Xg6h9ZYCJ+TgaK3KBL7LMgV6sRi2xW9D2BnyjXwoz
	 YwbBwBZzAECu1zPe9oPMC/QiWG0cJdSOrMTrOH6RrRRIQgY3HaSHtL8maTZEQv1/Nw
	 TX69v9oLBKRPA==
Date: Thu, 4 Jan 2024 15:34:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240104153401.08ff9809@kernel.org>
In-Reply-To: <20231221180047.1924733-8-maxime.chevallier@bootlin.com>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 19:00:40 +0100 Maxime Chevallier wrote:
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
> 
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> index 3ca6c21e74af..97ff787a7dd8 100644
> --- a/Documentation/networking/ethtool-netlink.rst
> +++ b/Documentation/networking/ethtool-netlink.rst
> @@ -2011,6 +2011,49 @@ The attributes are propagated to the driver through the following structure:
>  .. kernel-doc:: include/linux/ethtool.h
>      :identifiers: ethtool_mm_cfg
>  
> +PHY_GET
> +=======
> +
> +Retrieve information about a given Ethernet PHY sitting on the link. As there
> +can be more than one PHY, the DUMP operation can be used to list the PHYs
> +present on a given interface, by passing an interface index or name in
> +the dump request
> +
> +Request contents:
> +
> +  ====================================  ======  ==========================
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  ====================================  ======  ==========================
> +
> +Kernel response contents:
> +
> +  ===================================== ======  ==========================
> +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> +  ``ETHTOOL_A_PHY_INDEX``               u32     the phy's unique index, that can

The fact that lines are longer than the ===== markings doesn't generate
warnings in htmldoc?

> +                                                be used for phy-specific requests
> +  ``ETHTOOL_A_PHY_DRVNAME``             string  the phy driver name
> +  ``ETHTOOL_A_PHY_NAME``                string  the phy device name
> +  ``ETHTOOL_A_PHY_UPSTREAM_TYPE``       u32     the type of device this phy is
> +                                                connected to
> +  ``ETHTOOL_A_PHY_UPSTREAM_PHY``        nested  if the phy is connected to another
> +                                                phy, this nest contains info on
> +                                                that connection
> +  ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an sfp bus,
> +                                                the name of the sfp bus

Is upstream / downstream clear to everyone / from the spec.
I guess it's scoped to the netdev so upstream means "towards 
the netdev MAC"?

> +  ``ETHTOOL_A_PHY_ID``                  u32     the phy id if the phy is C22
> +  ===================================== ======  ==========================
> +
> +When ``ETHTOOL_A_PHY_UPSTREAM_TYPE`` is PHY_UPSTREAM_PHY, the PHY's parent is
> +another PHY. Information on the parent PHY will be set in the
> +``ETHTOOL_A_PHY_UPSTREAM_PHY`` nest, which has the following structure :
> +
> +  =================================== ======  ==========================
> +  ``ETHTOOL_A_PHY_UPSTREAM_INDEX``    u32     the PHY index of the upstream PHY
> +  ``ETHTOOL_A_PHY_UPSTREAM_SFP_NAME`` string  if this PHY is connected to it's
> +                                                parent PHY through an SFP bus, the
> +                                                name of this sfp bus
> +  =================================== ======  ==========================

Why is this a nest?

>  Request translation
>  ===================

> +enum {
> +	ETHTOOL_A_PHY_UNSPEC,
> +	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
> +	ETHTOOL_A_PHY_INDEX,			/* u32 */
> +	ETHTOOL_A_PHY_DRVNAME,			/* string */
> +	ETHTOOL_A_PHY_NAME,			/* string */
> +	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u8 */

The Documentation say it's a u32 as it should be, AFAICT.
But code and some comments use u8.

> +	ETHTOOL_A_PHY_UPSTREAM,			/* nest - _A_PHY_UPSTREAM_* */
> +	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
> +	ETHTOOL_A_PHY_ID,			/* u32 */
> +
> +	/* add new constants above here */
> +	__ETHTOOL_A_PHY_CNT,
> +	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
> +};

> +++ b/net/ethtool/phy.c
> @@ -0,0 +1,306 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2023 Bootlin
> + *
> + */

Do you really need 4 lines for the copyright? :)


> +/* Caller holds rtnl */
> +static ssize_t
> +ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct phy_link_topology *topo;
> +	struct phy_device_node *pdn;
> +	struct phy_device *phydev;
> +	unsigned long index;
> +	size_t size;
> +
> +	ASSERT_RTNL();
> +
> +	topo = &req_base->dev->link_topo;
> +
> +	size = nla_total_size(0);

no comment on this one?

> +
> +	xa_for_each(&topo->phys, index, pdn) {

Why count all the PHYs, you only output one on doit, right?

> +		phydev = pdn->phy;
> +
> +		/* ETHTOOL_A_PHY_INDEX */
> +		size += nla_total_size(sizeof(u32));
> +
> +		/* ETHTOOL_A_DRVNAME */
> +		size += nla_total_size(strlen(phydev->drv->name) + 1);
> +
> +		/* ETHTOOL_A_NAME */
> +		size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)) + 1);
> +
> +		/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
> +		size += nla_total_size(sizeof(u8));
> +
> +		/* ETHTOOL_A_PHY_ID */
> +		size += nla_total_size(sizeof(u32));
> +
> +		if (phy_on_sfp(phydev)) {
> +			const char *upstream_sfp_name = sfp_get_name(pdn->parent_sfp_bus);
> +
> +			/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
> +			if (upstream_sfp_name)
> +				size += nla_total_size(strlen(upstream_sfp_name) + 1);
> +
> +			/* ETHTOOL_A_PHY_UPSTREAM_INDEX */
> +			size += nla_total_size(sizeof(u32));
> +		}
> +
> +		/* ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME */
> +		if (phydev->sfp_bus) {
> +			const char *sfp_name = sfp_get_name(phydev->sfp_bus);
> +
> +			if (sfp_name)
> +				size += nla_total_size(strlen(sfp_name) + 1);
> +		}
> +	}
> +
> +	return size;
> +}

> +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> +				   struct nlattr **tb)
> +{
> +	struct phy_link_topology *topo = &req_base->dev->link_topo;
> +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> +	struct phy_device_node *pdn;
> +
> +	if (!req_base->phydev)
> +		return 0;

The PHY INDEX should probably be a required attr, with 
GENL_REQ_ATTR_CHECK()? Without phydev being specified
what's the point?

> +	pdn = xa_load(&topo->phys, req_base->phydev->phyindex);
> +	memcpy(&req_info->pdn, pdn, sizeof(*pdn));
> +
> +	return 0;
> +}

> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct net *net = sock_net(skb->sk);
> +	unsigned long ifindex = 1;

This doesn't look right, if dump gets full you gotta pick up
when previous call left off.

> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +
> +	if (ctx->phy_req_info->base.dev) {
> +		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
> +		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
> +		ctx->phy_req_info->base.dev = NULL;
> +	} else {
> +		for_each_netdev_dump(net, dev, ifindex) {
> +			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
> +			if (ret)
> +				break;
> +		}
> +	}
> +	rtnl_unlock();
> +
> +	if (ret == -EMSGSIZE && skb->len)
> +		return skb->len;
> +	return ret;
> +}
> +


