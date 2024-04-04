Return-Path: <linux-kernel+bounces-131117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 002BF898346
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A899028C78F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334E71B20;
	Thu,  4 Apr 2024 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cOULh+T8"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13C7172C;
	Thu,  4 Apr 2024 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712219922; cv=none; b=X++blMbWpoGI6L7VbX3wMK+gX9rPDnF+Cc3jBEao1maIrjtq+woFee/GD+N3Gb3HgWVMXX/bZg9WcNt6oeBIjJkSTR3BynhCW2P4AO0S9f5E39OM7squGWBmnp7QmoysWQFGlu81vqIrNohG5N7uzMqd1mncw+TjxBSGmOuEpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712219922; c=relaxed/simple;
	bh=NXDp9fT+0znhv12w33a7uWZcEGlFFH4+BEMYf6tRYBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr+KqnDWikugZdkrg1C8xCTEynikuPIvgZLWmAfWy50ixwZgR9KaecK/VyWl48oLamEXAoHq3/baaaxNw8JVnlzBHcYPr4YzZY1c4XLEBYToA62srSqwyfSqDsAw5VIdk2nHYctXypPRq/Hm9yYpdAxV6KZWgyKW8csUmjdwg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cOULh+T8; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay8-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::228])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id CFB54C089B;
	Thu,  4 Apr 2024 08:38:37 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 432ED1BF20E;
	Thu,  4 Apr 2024 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712219910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgvOBYUv+YR+r+p5EFl1tLWF9neUclhq/ma3+kacwA4=;
	b=cOULh+T8sdtlXD7SmlUA0IOvIPd34zcwacPNaE0zSa5VGX4OnJOEhkwrLa9QOK7x7OVbbv
	eHe7yddb0K7kAcwEDUfSA/bS2zjHbxT/NbjaMEbfrptATARz8XdpV3yRyjwJ9kj6WbM00v
	1v+C3V2x6Vop+WixAMMXz87zUSFd1wYUJx7bhZ9kXKM7BGZIo1jdUdAUTOhEv8Unr4o8SF
	mAZpWcb78nEWuV2bEtW/m0zprJ+3RHw5aA4gqjQodRMATI9v8TbAoEm+O9sXj5yJFY0e9L
	sBQaG/t1J2tcoLS6Bqi7Q3bYlkNtL3uq6EkYDQtz+WUD+IIoisd9Opo1Z1qobQ==
Date: Thu, 4 Apr 2024 10:38:25 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20240404103825.6a596bec@device-28.home>
In-Reply-To: <20240308211842.6d64b5bc@kernel.org>
References: <20240304151011.1610175-1-maxime.chevallier@bootlin.com>
	<20240304151011.1610175-8-maxime.chevallier@bootlin.com>
	<20240308211842.6d64b5bc@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

Sorry for the late reply...

On Fri, 8 Mar 2024 21:18:42 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon,  4 Mar 2024 16:10:03 +0100 Maxime Chevallier wrote:
> > +PHY_GET
> > +=======
> > +
> > +Retrieve information about a given Ethernet PHY sitting on the link. As there
> > +can be more than one PHY, the DUMP operation can be used to list the PHYs
> > +present on a given interface, by passing an interface index or name in
> > +the dump request  
> 
> Could be worth re-stating the default behavior of the DO request?
> That the DO will return the dev->phydev by default and if PHY_INDEX
> is specified in the header, the particular PHY with that index?
> 
> > +	if (phydev->drv && nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name))  
> 
> could you break the lines at 80 where it doesn't hurt readability?
> This way:
> 
> 	if (phydev->drv && 
> 	    nla_put_string(skb, ETHTOOL_A_PHY_DRVNAME, phydev->drv->name))

Ack, will do

> 
> > +		return -EMSGSIZE;
> > +
> > +	if (ptype == PHY_UPSTREAM_PHY) {
> > +		struct phy_device *upstream = pdn->upstream.phydev;
> > +		const char *sfp_upstream_name;
> > +
> > +		/* Parent index */
> > +		if (nla_put_u32(skb, ETHTOOL_A_PHY_UPSTREAM_INDEX, upstream->phyindex))
> > +			return -EMSGSIZE;
> > +
> > +		if (pdn->parent_sfp_bus) {
> > +			sfp_upstream_name = sfp_get_name(pdn->parent_sfp_bus);
> > +			if (sfp_upstream_name && nla_put_string(skb,
> > +								ETHTOOL_A_PHY_UPSTREAM_SFP_NAME,
> > +								sfp_upstream_name))  
> 
> ditto

Indeed :)

> 
> > +				return -EMSGSIZE;
> > +		}
> > +	}  
> 
> > +int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +	struct phy_req_info req_info = {};
> > +	struct nlattr **tb = info->attrs;
> > +	struct sk_buff *rskb;
> > +	void *reply_payload;
> > +	int reply_len;
> > +	int ret;
> > +
> > +	ret = ethnl_parse_header_dev_get(&req_info.base,
> > +					 tb[ETHTOOL_A_PHY_HEADER],
> > +					 genl_info_net(info), info->extack,
> > +					 true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	rtnl_lock();
> > +
> > +	ret = ethnl_phy_parse_request(&req_info.base, tb);
> > +	if (ret < 0)
> > +		goto err_unlock_rtnl;
> > +
> > +	/* No PHY, return early */
> > +	if (!req_info.pdn.phy)
> > +		goto err_unlock_rtnl;
> > +
> > +	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
> > +	if (ret < 0)
> > +		goto err_unlock_rtnl;
> > +	reply_len = ret + ethnl_reply_header_size();
> > +
> > +	rskb = ethnl_reply_init(reply_len, req_info.base.dev,
> > +				ETHTOOL_MSG_PHY_GET_REPLY,
> > +				ETHTOOL_A_PHY_HEADER,
> > +				info, &reply_payload);
> > +	if (!rskb) {
> > +		ret = -ENOMEM;
> > +		goto err_unlock_rtnl;
> > +	}
> > +
> > +	ret = ethnl_phy_fill_reply(&req_info.base, rskb);
> > +	if (ret)
> > +		goto err_free_msg;
> > +
> > +	rtnl_unlock();
> > +	ethnl_parse_header_dev_put(&req_info.base);
> > +	genlmsg_end(rskb, reply_payload);
> > +
> > +	return genlmsg_reply(rskb, info);
> > +
> > +err_free_msg:
> > +	nlmsg_free(rskb);
> > +err_unlock_rtnl:
> > +	rtnl_unlock();
> > +	ethnl_parse_header_dev_put(&req_info.base);
> > +	return ret;
> > +}
> > +
> > +struct ethnl_phy_dump_ctx {
> > +	struct phy_req_info	*phy_req_info;
> > +	unsigned long ifindex;
> > +	unsigned long phy_index;
> > +};
> > +
> > +int ethnl_phy_start(struct netlink_callback *cb)
> > +{
> > +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);  
> 
> You can save some chars by using genl_info_dump() here
> 
> > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > +	struct nlattr **tb = info->info.attrs;  
> 
> then you can ditch this
> 
> > +	int ret;
> > +
> > +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(cb->ctx));
> > +
> > +	ctx->phy_req_info = kzalloc(sizeof(*ctx->phy_req_info), GFP_KERNEL);
> > +	if (!ctx->phy_req_info)
> > +		return -ENOMEM;
> > +
> > +	ret = ethnl_parse_header_dev_get(&ctx->phy_req_info->base,
> > +					 tb[ETHTOOL_A_PHY_HEADER],  
> 
> and:
> 
> 					 info->attrs[ETHTOOL_A_PHY_HEADER],

Nice improvement, thanks !

> 
> > +					 sock_net(cb->skb->sk), cb->extack,
> > +					 false);  
> 
> leaking ctx->phy_req_info on error?

Ah true, I relied on .done() but if ret is an error, it won't be
called... thanks !

> 
> > +	ctx->ifindex = 0;
> > +	ctx->phy_index = 0;
> > +	return ret;
> > +}  
> 
> > +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> > +				  struct netlink_callback *cb)
> > +{
> > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > +	struct phy_req_info *pri = ctx->phy_req_info;
> > +	struct phy_device_node *pdn;
> > +	int ret = 0;
> > +	void *ehdr;
> > +
> > +	pri->base.dev = dev;
> > +
> > +	xa_for_each_start(&dev->link_topo->phys, ctx->phy_index, pdn, ctx->phy_index) {
> > +		ehdr = ethnl_dump_put(skb, cb,
> > +				      ETHTOOL_MSG_PHY_GET_REPLY);  
> 
> this one OTOH fits on a line :)
> 
> > +		if (!ehdr) {
> > +			ret = -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		ret = ethnl_fill_reply_header(skb, dev,
> > +					      ETHTOOL_A_PHY_HEADER);  
> 
> ditto

Ack for both :)

> 
> > +		if (ret < 0) {
> > +			genlmsg_cancel(skb, ehdr);
> > +			break;
> > +		}
> > +
> > +		memcpy(&pri->pdn, pdn, sizeof(*pdn));
> > +		ret = ethnl_phy_fill_reply(&pri->base, skb);  
> 
> On a DO fill() shouldn't fail, because we size the skb, but if we pack
> many entries into the skb on a DUMP it can. So:
> 
> 		if (ret < 0) {
> 			genlmsg_cancel(skb, ehdr);
> 			break;
> 		}
> 
> no?

True, I'll add that

> 
> > +		genlmsg_end(skb, ehdr);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > +{
> > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > +	struct net *net = sock_net(skb->sk);
> > +	struct net_device *dev;
> > +	int ret = 0;
> > +
> > +	rtnl_lock();
> > +
> > +	if (ctx->phy_req_info->base.dev) {
> > +		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
> > +	} else {
> > +		for_each_netdev_dump(net, dev, ctx->ifindex) {
> > +			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
> > +			if (ret)
> > +				break;
> > +
> > +			ctx->phy_index = 0;
> > +		}
> > +	}
> > +	rtnl_unlock();
> > +
> > +	if (ret == -EMSGSIZE && skb->len)
> > +		return skb->len;  
> 
> you can remove this if thanks to (very recent) commit b5a899154aa9

Ah nice ! thanks :)

> 
> > +	return ret;
> > +}  
> 
> Very sorry for the late review, BTW :(

No worries. I'll send a new version very shortly, taking all you
comments into account, thanks for taking a look at this !

Maxime


