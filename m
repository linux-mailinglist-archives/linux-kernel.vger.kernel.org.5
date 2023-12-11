Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5C180C7A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjLKLHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjLKLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:07:47 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EC2B0;
        Mon, 11 Dec 2023 03:07:52 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1B0DE000E;
        Mon, 11 Dec 2023 11:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702292871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lAhFpsV1S54PTdsFeohfVvq4D1Bry0V4SWQaEvqmkcQ=;
        b=iBbc8StkgE3itF5NdrUN3K/zQbyy+ux8TUa3KZt+Z0IbKHgCBPLtce+yrrDZKX0YaRKzbx
        B81wusD7Lf+06jMJpoNqHEzMEtwlfLgA9zlm6qwLfEK7zUUzVuBI+5wn4qQCOoywZAlQIK
        +hShiEOMl1r88Cd2DunFVkfijcUhhRcQ9eypL65pMm8oRsFWvrSQO9h4uC89AGLVJzzMRt
        jnSLVXENCbXGF335vlDG8TsgLhZ/A1mBIkoKYzn94UgQksO508yyozwwZYHqx66k+AqzgG
        cIbOm4sXo0/VkeVljybRtr+e1LUzQalrqHiM02YcQN4Y2FKXpYNd32HiaOjt3w==
Date:   Mon, 11 Dec 2023 12:07:48 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Simon Horman <horms@kernel.org>
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
        =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 07/13] net: ethtool: Introduce a command
 to list PHYs on an interface
Message-ID: <20231211120748.0eeb15cc@device.home>
In-Reply-To: <20231209170457.GB5817@kernel.org>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
        <20231201163704.1306431-8-maxime.chevallier@bootlin.com>
        <20231209170457.GB5817@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Sat, 9 Dec 2023 17:04:57 +0000
Simon Horman <horms@kernel.org> wrote:

> On Fri, Dec 01, 2023 at 05:36:57PM +0100, Maxime Chevallier wrote:
> > As we have the ability to track the PHYs connected to a net_device
> > through the link_topology, we can expose this list to userspace. This
> > allows userspace to use these identifiers for phy-specific commands and
> > take the decision of which PHY to target by knowing the link topology.
> > 
> > Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> > devices on only one interface.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> ...
> 
> > diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c  
> 
> ...
> 
> > +static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
> > +				  struct netlink_callback *cb)
> > +{
> > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > +	struct phy_req_info *pri = ctx->phy_req_info;
> > +	struct phy_device_node *pdn;
> > +	unsigned long index = 1;
> > +	void *ehdr;
> > +	int ret;
> > +
> > +	pri->base.dev = dev;
> > +
> > +	xa_for_each(&dev->link_topo.phys, index, pdn) {
> > +		ehdr = ethnl_dump_put(skb, cb,
> > +				      ETHTOOL_MSG_PHY_GET_REPLY);
> > +		if (!ehdr) {
> > +			ret = -EMSGSIZE;
> > +			break;
> > +		}
> > +
> > +		ret = ethnl_fill_reply_header(skb, dev,
> > +					      ETHTOOL_A_PHY_HEADER);
> > +		if (ret < 0) {
> > +			genlmsg_cancel(skb, ehdr);
> > +			break;
> > +		}
> > +
> > +		memcpy(&pri->pdn, pdn, sizeof(*pdn));
> > +		ret = ethnl_phy_fill_reply(&pri->base, skb);
> > +
> > +		genlmsg_end(skb, ehdr);
> > +	}
> > +
> > +	return ret;  
> 
> Hi Maxime,
> 
> I am unsure if this can happen (or if I flagged this before)
> but if the loop runs zero times then ret is uninitialised here.
> 
> Flagged by Smatch

Ah true, let me also fix that in the next revision.

Thanks for the review,

Maxime

