Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0786E80CE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 15:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjLKOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343747AbjLKOVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 09:21:00 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B05A5D1;
        Mon, 11 Dec 2023 06:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3ZV48LQITHOdv4wAedeujOP64YpOp9FQs7bVs74eoQA=; b=TTAR4WIFUcT7OOvA4W3jlDpybH
        yZH6lFm5YDaAPk3c8IiHfrT80eA4u8p60YuzuM93UbLkZGL8LTeegW9b2Kiux59uOwpLndn0EDEOu
        rV4pJEWujufHhEDVM7exXtk9S6Q2xxMe9XV1A482ghStTfPmNqMARIHKrsBfjmc0Q0jw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rCgy5-002cri-9G; Mon, 11 Dec 2023 15:09:09 +0100
Date:   Mon, 11 Dec 2023 15:09:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     Simon Horman <horms@kernel.org>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
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
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Subject: Re: [RFC PATCH net-next v3 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <67557c83-4318-4557-ac96-858053b5f89b@lunn.ch>
References: <20231201163704.1306431-1-maxime.chevallier@bootlin.com>
 <20231201163704.1306431-2-maxime.chevallier@bootlin.com>
 <20231209170241.GA5817@kernel.org>
 <20231211120623.03b1ced4@device.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211120623.03b1ced4@device.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > @@ -10832,6 +10833,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> > >  #ifdef CONFIG_NET_SCHED
> > >  	hash_init(dev->qdisc_hash);
> > >  #endif
> > > +	phy_link_topo_init(&dev->link_topo);
> > > +  
> > 
> > I don't think this can work unless PHYLIB is compiled as a built-in.
> 
> Inded, I need to better clarify and document the dependency with
> PHYLIB.

It is getting harder and harder to make the phylib core a module :-(

How much work does phy_link_topo_init() do? Could it be an inline
function? Are there other dependencies?

Also look at ethtool_phy_ops and e.g. how plca_get_cfg_prepare_data()
uses it.

	Andrew
