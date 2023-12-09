Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2CC80B55D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjLIRE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:04:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58CA121
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:05:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9783C433C7;
        Sat,  9 Dec 2023 17:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702141504;
        bh=23L3WN6QiOepynHV4/l1rgY8ayFp8shdyR9qFwIfo4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuW3s/gq4XmvI+zazP8ZslY+PEh1eN/BTZsf9FuLTCy32Wy27zQJQDo+9kpSkce3w
         z36SwtpUkKPn35Wgp/vZK0KiGYpa4onEEzFdybM0ipkJlaz0x/jCIqga5fMvFx44SJ
         IWSwlPu/c84PKciUaUW/SOuUBj5p9kxhCWB2ImoSdTDP42v5W5rhUqrf/27jXDyS6n
         0nqwiHIsmRP3hsU/nzMGz0hBqRo5ogqw71a8gCh7KPRy2v2Itk6+FqUjQ34oIBokQW
         k7OjDpgnPDDvxBSXWIMCGGQg2adV8tUHfv36S2tuQf/JwF7Jm0m0zJZfBhlg7Cw08u
         wvHZh7zjxuItA==
Date:   Sat, 9 Dec 2023 17:04:57 +0000
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
Subject: Re: [RFC PATCH net-next v3 07/13] net: ethtool: Introduce a command
 to list PHYs on an interface
Message-ID: <20231209170457.GB5817@kernel.org>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
 <20231201163704.1306431-8-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201163704.1306431-8-maxime.chevallier@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 05:36:57PM +0100, Maxime Chevallier wrote:
> As we have the ability to track the PHYs connected to a net_device
> through the link_topology, we can expose this list to userspace. This
> allows userspace to use these identifiers for phy-specific commands and
> take the decision of which PHY to target by knowing the link topology.
> 
> Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> devices on only one interface.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

...

> diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c

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

Hi Maxime,

I am unsure if this can happen (or if I flagged this before)
but if the loop runs zero times then ret is uninitialised here.

Flagged by Smatch

> +}

...
