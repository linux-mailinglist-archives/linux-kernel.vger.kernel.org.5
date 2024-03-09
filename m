Return-Path: <linux-kernel+bounces-97776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 154F2876F44
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78050B213B6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA2133070;
	Sat,  9 Mar 2024 05:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjoQp1I7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C37208A8;
	Sat,  9 Mar 2024 05:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709961524; cv=none; b=BX58rZlXcEgZHAlT/pdUixa87/Lg1D4WnEpk1l4M4srcLWY8Jue/7KZUOjwZG+gOamNZqIMZTcmpY9ge4iELi1z8EhV6NxKZOV8Yx5TaZxaoMsoZkqpdfLsOaTgIlkp8grMv4ijUwRBkI9Mx0gF8Xy9COm4MkjrebCkHQedk2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709961524; c=relaxed/simple;
	bh=LeOJqDDWbMWGLP8JBd1IaDSDKpHShxQbboLI47HRF54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lif9m+M7aW6kKLyDc4ZEfVCkwj4Q9qwJUSWI9Igjb9KUKlIoXb9tB6x7tIZXfr3FT9dGkq0UtGJZ1kTl4WqMmSO24xp5ITHLHelLJlyWAbZYteh1Q4ENx1LroXGjJYWlkWfgJmGGIBFhL0A1z9XGXfLFaaj4V04AoeO3hk/9gWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjoQp1I7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B593C433F1;
	Sat,  9 Mar 2024 05:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709961524;
	bh=LeOJqDDWbMWGLP8JBd1IaDSDKpHShxQbboLI47HRF54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gjoQp1I7j/FQbeAKrfTRBH0jvejb9O1X+5/SoY+smWzMo5piP2vEBpD6P6UWwU2nN
	 cqGS6nOubiS4t7BVkiIMfuFKwpS1YU1RIvcAwtGMuxMBfINfoNdYaMeQj11ZT1P4o1
	 m/RYS3DSi2vup+bcYb4jawuCEps1Zz1hAyI650Tp34D2dI5cdjYpr3kKXC/SVMXydh
	 zr5h+KpXa/NsMEqSp0YQvR4wVkpcXaIXgardsM/aDz7IUqpcHcwMu3bkHzoH1rAkLr
	 J1CI3QX3/d7sszxxdZ7EBIUR6mRzDGLBeu74Q1XhFQrYWKso0DEKVPNQ9naKcmKPNn
	 UVwrMzSpqTRVg==
Date: Fri, 8 Mar 2024 21:18:42 -0800
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
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v10 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240308211842.6d64b5bc@kernel.org>
In-Reply-To: <20240304151011.1610175-8-maxime.chevallier@bootlin.com>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
	<20240304151011.1610175-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Mar 2024 16:10:03 +0100 Maxime Chevallier wrote:
> +PHY_GET
> +=======
> +
> +Retrieve information about a given Ethernet PHY sitting on the link. As there
> +can be more than one PHY, the DUMP operation can be used to list the PHYs
> +present on a given interface, by passing an interface index or name in
> +the dump request

Could be worth re-stating the default behavior of the DO request?
That the DO will return the dev->phydev by default and if PHY_INDEX
is specified in the header, the particular PHY with that index?

> +	if (phydev->drv && nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name))

could you break the lines at 80 where it doesn't hurt readability?
This way:

	if (phydev->drv && 
	    nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name))

> +		return -EMSGSIZE;
> +
> +	if (ptype == PHY_UPSTREAM_PHY) {
> +		struct phy_device *upstream = pdn->upstream.phydev;
> +		const char *sfp_upstream_name;
> +
> +		/* Parent index */
> +		if (nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX, upstream->phyindex))
> +			return -EMSGSIZE;
> +
> +		if (pdn->parent_sfp_bus) {
> +			sfp_upstream_name = sfp_get_name(pdn->parent_sfp_bus);
> +			if (sfp_upstream_name && nla_put_string(skb,
> +								ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
> +								sfp_upstream_name))

ditto

> +				return -EMSGSIZE;
> +		}
> +	}

> +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +	struct phy_req_info req_info = {};
> +	struct nlattr **tb = info->attrs;
> +	struct sk_buff *rskb;
> +	void *reply_payload;
> +	int reply_len;
> +	int ret;
> +
> +	ret = ethnl_parse_header_dev_get(&req_info.base,
> +					 tb[ETHTOOL_A_PHY_HEADER],
> +					 genl_info_net(info), info->extack,
> +					 true);
> +	if (ret < 0)
> +		return ret;
> +
> +	rtnl_lock();
> +
> +	ret = ethnl_phy_parse_request(&req_info.base, tb);
> +	if (ret < 0)
> +		goto err_unlock_rtnl;
> +
> +	/* No PHY, return early */
> +	if (!req_info.pdn.phy)
> +		goto err_unlock_rtnl;
> +
> +	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
> +	if (ret < 0)
> +		goto err_unlock_rtnl;
> +	reply_len = ret + ethnl_reply_header_size();
> +
> +	rskb = ethnl_reply_init(reply_len, req_info.base.dev,
> +				ETHTOOL_MSG_PHY_GET_REPLY,
> +				ETHTOOL_A_PHY_HEADER,
> +				info, &reply_payload);
> +	if (!rskb) {
> +		ret = -ENOMEM;
> +		goto err_unlock_rtnl;
> +	}
> +
> +	ret = ethnl_phy_fill_reply(&req_info.base, rskb);
> +	if (ret)
> +		goto err_free_msg;
> +
> +	rtnl_unlock();
> +	ethnl_parse_header_dev_put(&req_info.base);
> +	genlmsg_end(rskb, reply_payload);
> +
> +	return genlmsg_reply(rskb, info);
> +
> +err_free_msg:
> +	nlmsg_free(rskb);
> +err_unlock_rtnl:
> +	rtnl_unlock();
> +	ethnl_parse_header_dev_put(&req_info.base);
> +	return ret;
> +}
> +
> +struct ethnl_phy_dump_ctx {
> +	struct phy_req_info	*phy_req_info;
> +	unsigned long ifindex;
> +	unsigned long phy_index;
> +};
> +
> +int ethnl_phy_start(struct netlink_callback *cb)
> +{
> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);

You can save some chars by using genl_info_dump() here

> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct nlattr **tb = info->info.attrs;

then you can ditch this

> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> +
> +	ctx->phy_req_info = kzalloc(sizeof(*ctx->phy_req_info), GFP_KERNEL);
> +	if (!ctx->phy_req_info)
> +		return -ENOMEM;
> +
> +	ret = ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
> +					 tb[ETHTOOL_A_PHY_HEADER],

and:

					 info->attrs[ETHTOOL_A_PHY_HEADER],

> +					 sock_net(cb->skb->sk), cb->extack,
> +					 false);

leaking ctx->phy_req_info on error?

> +	ctx->ifindex = 0;
> +	ctx->phy_index = 0;
> +	return ret;
> +}

> +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> +				  struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct phy_req_info *pri = ctx->phy_req_info;
> +	struct phy_device_node *pdn;
> +	int ret = 0;
> +	void *ehdr;
> +
> +	pri->base.dev = dev;
> +
> +	xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx->phy_index) {
> +		ehdr = ethnl_dump_put(skb, cb,
> +				      ETHTOOL_MSG_PHY_GET_REPLY);

this one OTOH fits on a line :)

> +		if (!ehdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = ethnl_fill_reply_header(skb, dev,
> +					      ETHTOOL_A_PHY_HEADER);

ditto

> +		if (ret < 0) {
> +			genlmsg_cancel(skb, ehdr);
> +			break;
> +		}
> +
> +		memcpy(&pri->pdn, pdn, sizeof(*pdn));
> +		ret = ethnl_phy_fill_reply(&pri->base, skb);

On a DO fill() shouldn't fail, because we size the skb, but if we pack
many entries into the skb on a DUMP it can. So:

		if (ret < 0) {
			genlmsg_cancel(skb, ehdr);
			break;
		}

no?

> +		genlmsg_end(skb, ehdr);
> +	}
> +
> +	return ret;
> +}
> +
> +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct net *net = sock_net(skb->sk);
> +	struct net_device *dev;
> +	int ret = 0;
> +
> +	rtnl_lock();
> +
> +	if (ctx->phy_req_info->base.dev) {
> +		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
> +	} else {
> +		for_each_netdev_dump(net, dev, ctx->ifindex) {
> +			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
> +			if (ret)
> +				break;
> +
> +			ctx->phy_index = 0;
> +		}
> +	}
> +	rtnl_unlock();
> +
> +	if (ret == -EMSGSIZE && skb->len)
> +		return skb->len;

you can remove this if thanks to (very recent) commit b5a899154aa9

> +	return ret;
> +}

Very sorry for the late review, BTW :(

