Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB297CA5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjJPKnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjJPKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:43:23 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066E7210B;
        Mon, 16 Oct 2023 03:41:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0A181C0009;
        Mon, 16 Oct 2023 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697452902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vT9G5NQZZ2eFijBoTns5foUBCOXcsCpnGULg2LBKId4=;
        b=mNYix7oANrLWcPA45+MCZhVDWozUj6f8PfqSzJqKysm1KuHJKww2ZZKGHzyDTEA2pFZ89M
        GQL7cVUygSHhtDqKDGhuWpIDjZHMs+X/thryopJPYiizCwuNlElaLc2SZ92J9f/7dgg3Sn
        OyUMUelmsPPYlkOdzCI9ZLHzzUmJdI2aCw31stMkro65apZFzdGCXKqoxlfVxZnx5d8Mgg
        1ks4wZl5bCVkhEQmLYZlI7exvP7f9Lc+5fRA/wvVZk404CeBuzJf8RQAtoRNZhiLFyzweM
        Dw13OEMhp7QgdQx6bh2TMIWFL90IIUzrnqHVsGKBKTNmKUI9XkDqOZUh5Je4TA==
Date:   Mon, 16 Oct 2023 12:41:34 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 08/16] net: ethtool: Add a command to expose
 current time stamping layer
Message-ID: <20231016124134.6b271f07@kmaincent-XPS-13-7390>
In-Reply-To: <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
        <20231009155138.86458-9-kory.maincent@bootlin.com>
        <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
        <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
        <20231013090020.34e9f125@kernel.org>
        <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 18:11:19 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > All these possibles timestamps go through exclusively the netdev API or
> > > the phylib API. Even the software timestamping is done in the netdev
> > > driver, therefore it goes through the netdev API and then should have the
> > > NETDEV_TIMESTAMPING bit set.  
> > 
> > Netdev vs phylib is an implementation detail of Linux.
> > I'm also surprised that you changed this.
> >   
> > > > > + */
> > > > > +enum {
> > > > > +	NO_TIMESTAMPING = 0,
> > > > > +	NETDEV_TIMESTAMPING = (1 << 0),
> > > > > +	PHYLIB_TIMESTAMPING = (1 << 1),
> > > > > +	SOFTWARE_TIMESTAMPING = (1 << 2) | (1 << 0),      
> 
> Just emphasising Jakubs point here. phylib is an implementation
> detail, in that the MAC driver might be using firmware to drive its
> PHY, and that firmware can do a timestamp in the PHY. The API being
> defined here should be independent of the implementation details. So
> it probably should be MAC_TIMESTAMPING and PHY_TIMESTAMPING, and leave
> it to the driver to decide if its PHYLIB doing the actual work, or
> firmware.

That is one reason why I moved to NETDEV_TIMESTAMPING, we don't know if it will
really be the MAC that does the timestamping, as the firmware could ask the PHY
to does it, but it surely goes though the netdev driver.

> Netdev vs phylib is an implementation detail of Linux.
> I'm also surprised that you changed this.

This is the main reason I changed this. This is Linux implementation purpose to
know whether it should go through netdev or phylib, and then each of these
drivers could use other timestamps which are hardware related.

As I have answered to Florian maybe you prefer to separate the Linux
implementation detail and the hardware timestamping like this:

> Or maybe do you prefer to use defines like this:
> # define NETDEV_TIMESTAMPING (1 << 0)
> # define PHYLIB_TIMESTAMPING (1 << 1)
> 
> enum {
> 	NO_TIMESTAMPING = 0,
> 	MAC_TIMESTAMPING = NETDEV_TIMESTAMPING,
> 	PHY_TIMESTAMPING = PHYLIB_TIMESTAMPING,
> 	SOFTWARE_TIMESTAMPING = (1 << 2) | NETDEV_TIMESTAMPING,
> 	...
> 	MAC_DMA_TIMESTAMPING = (2 << 2) | NETDEV_TIMESTAMPING,
> 	MAC_PRECISION_TIMESTAMPING = (3 << 2) | NETDEV_TIMESTAMPING,
> };


> > The gist of what I'm proposing is for the core ethtool netlink message
> > handler to get just the phc_index as an attribute. No other information
> > as to what it represents. Not that it's netdev, DMA, phylib PHY or whatnot.
> > 
> > The ethtool kernel code would iterate through the stuff registered in
> > the system for the netdev, calling get_ts_info() or phy_ts_info() on it,
> > until it finds something which populates struct ethtool_ts_info ::
> > phc_index with the phc_index retrieved from netlink.
> > 
> > Then, ethtool just talks with the timestamper that matched that phc_index.
> > 
> > Same idea would be applied for the command that lists all timestamping
> > layers for a netdev. Check get_ts_info(), phy_ts_info(dev->phydev), and
> > can be extended in the future.  
> 
> I see, that could work. The user would then dig around sysfs to figure
> out which PHC has what characteristics?

I am not an expert but there are net drivers that enable
SOF_TIMESTAMPING_TX/RX/RAW_HARDWARE without phc. In that case we won't ever be
able to enter the get_ts_info() with you proposition.
Still I am wondering why hardware timestamping capabilities can be enabled
without phc.
