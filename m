Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136667F2335
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjKUBkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUBke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:40:34 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2803BC3;
        Mon, 20 Nov 2023 17:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=B1fysf3cQN9x0q/P/x3cZ79es+bupCMawmDAJDJfJlI=; b=nDw1mAFC5u95hiHGnudwGD3Gx7
        v1RB7Bv9HM615M9UbexMDjUOx+YSJsVvqRL8STd5OwddAbtJVqV9+IhxO7ZnmgfCrlSxIKITVtrLi
        s09gXa/hPlqgXszeuyMNFPCxW4O0dYh0PwBl932MrI95mKWQZpzl6NzhgnmCmogC8kV4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r5FkZ-000i8t-O3; Tue, 21 Nov 2023 02:40:27 +0100
Date:   Tue, 21 Nov 2023 02:40:27 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
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
        =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [RFC PATCH net-next v2 06/10] net: ethtool: Introduce a command
 to list PHYs on an interface
Message-ID: <97c04999-c3fe-421e-a8eb-642aff647536@lunn.ch>
References: <20231117162323.626979-1-maxime.chevallier@bootlin.com>
 <20231117162323.626979-7-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162323.626979-7-maxime.chevallier@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
> +		     struct netlink_ext_ack *extack)
> +{
> +	struct phy_device_node *pdn;
> +	struct phy_device *phydev;
> +	struct link_topology *lt;
> +	unsigned long index;
> +	size_t size;
> +
> +	lt = &req_base->dev->link_topo;
> +
> +	size = nla_total_size(0);
> +
> +	xa_for_each(&lt->phys, index, pdn) {
> +		phydev = pdn->phy;
> +
> +		/* ETHTOOL_A_PHY_INDEX */
> +		size += nla_total_size(sizeof(u32));
> +
> +		/* ETHTOOL_A_DRVNAME */
> +		size += nla_total_size(strlen(phydev->drv->name));
> +
> +		/* ETHTOOL_A_NAME */
> +		size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)));
> +
> +		/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
> +		size += nla_total_size(sizeof(u8));
> +
> +		/* ETHTOOL_A_PHY_ID */
> +		size += nla_total_size(sizeof(u32));
> +
> +		if (phy_on_sfp(phydev)) {
> +			/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
> +			if (sfp_get_name(pdn->parent_sfp_bus))
> +				size += nla_total_size(strlen(sfp_get_name(pdn->parent_sfp_bus)));

Have you tried a modular build?

sfp_get_name() could be in a module, and then you will get linker
errors. It is all a bit messy calling into phylib from ethtool :-(

This might actually be the only function you need? If so, its small
enough you can move it into a header as a static inline function.

       Andrew
