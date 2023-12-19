Return-Path: <linux-kernel+bounces-4929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5CE8183F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8F32865DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7624B134C5;
	Tue, 19 Dec 2023 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNntwxVd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156E134B2;
	Tue, 19 Dec 2023 08:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49CAC433C7;
	Tue, 19 Dec 2023 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702976254;
	bh=Qdl2WTOHb4rTUwS9hPDzncPiZEnkbpJEzM85A3gmzoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNntwxVdsfrEB7fJ+mBfl5fRUwDuZSaMhdg+6Z0g4/+wp4Wc3XwfudEx4JdcLfO16
	 Mld/NrcEPGDK+Hu7SRevyZCr7gZGAPB1e3HSvMpW3SkrGW5R8SD48RgKcD9KqAsQgw
	 sEVKEsxp/aAGCWqASiwnW7CU6oDYK5jrN661HMTohdO+NDs4FwecRk4t7RDNTpRk9G
	 OogsU38OtIc8qsyAcec7Y03IBJyrUyX46+We9bQbEOYDFyZSE7yOlxtsqZECb6POwg
	 +n+unclTpiSz7n1RCfXlAcj0g9vvC+zIyTV9aEWXOqVV+RdCGIuAlZ1Au7ilG/ydHd
	 TprBpLr7klKhw==
Date: Tue, 19 Dec 2023 08:55:57 +0000
From: Simon Horman <horms@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Subject: Re: [PATCH net-next v4 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20231219085557.GB811967@kernel.org>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-8-maxime.chevallier@bootlin.com>

On Fri, Dec 15, 2023 at 06:12:29PM +0100, Maxime Chevallier wrote:
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
> 
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Hi Maxime,

some minor feedback from my side.

> +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> +				   struct nlattr **tb)
> +{
> +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> +	struct phy_link_topology *topo = &req_base->dev->link_topo;
> +	struct phy_device_node *pdn;

nit: Please consider arranging local variables in reverse xmas tree order -
     longest line to shortest.

> +
> +	if (!req_base->phydev)
> +		return 0;
> +
> +	pdn = xa_load(&topo->phys, req_base->phydev->phyindex);
> +	memcpy(&req_info->pdn, pdn, sizeof(*pdn));
> +
> +	return 0;
> +}

...

> +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> +				  struct netlink_callback *cb)
> +{
> +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> +	struct phy_req_info *pri = ctx->phy_req_info;
> +	struct phy_device_node *pdn;
> +	unsigned long index = 1;
> +	void *ehdr;
> +	int ret;
> +
> +	pri->base.dev = dev;
> +
> +	xa_for_each(&dev->link_topo.phys, index, pdn) {
> +		ehdr = ethnl_dump_put(skb, cb,
> +				      ETHTOOL_MSG_PHY_GET_REPLY);
> +		if (!ehdr) {
> +			ret = -EMSGSIZE;
> +			break;
> +		}
> +
> +		ret = ethnl_fill_reply_header(skb, dev,
> +					      ETHTOOL_A_PHY_HEADER);
> +		if (ret < 0) {
> +			genlmsg_cancel(skb, ehdr);
> +			break;
> +		}
> +
> +		memcpy(&pri->pdn, pdn, sizeof(*pdn));
> +		ret = ethnl_phy_fill_reply(&pri->base, skb);
> +
> +		genlmsg_end(skb, ehdr);
> +	}
> +
> +	return ret;

I'm unsure if it can happen, but if the loop runs zero times then
ret will be used uninitialised here.

Flagged by Smatch.

> +}

...

