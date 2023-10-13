Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7737C8ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjJMQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjJMQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:14:57 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3B465AC;
        Fri, 13 Oct 2023 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=GrwS+vcMsoSAhYMGFWj4mmzPUzSI7XQUIUxm/ba9Oes=; b=437tGYUjy0dzd+LEBxcKMzHlB8
        C993jtkni0Txa+O1ssK3iB7hyVKWDlKTQXuJrcxVDyRVbeYzEjTlX2xZm2DLk1lfvMmRjQ1HEzYpG
        8+aG9vIy5F5Eusv+Ec9uvwyG51TsJEyYfEyO7jnpxgVHo65qjjT5hKdie/CRdvQ2g5Cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qrKkx-0026yZ-8G; Fri, 13 Oct 2023 18:11:19 +0200
Date:   Fri, 13 Oct 2023 18:11:19 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
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
Message-ID: <6ef6418d-6e63-49bd-bcc1-cdc6eb0da2d5@lunn.ch>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-9-kory.maincent@bootlin.com>
 <2fbde275-e60b-473d-8488-8f0aa637c294@broadcom.com>
 <20231010102343.3529e4a7@kmaincent-XPS-13-7390>
 <20231013090020.34e9f125@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013090020.34e9f125@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > All these possibles timestamps go through exclusively the netdev API or the
> > phylib API. Even the software timestamping is done in the netdev driver,
> > therefore it goes through the netdev API and then should have the
> > NETDEV_TIMESTAMPING bit set.
> 
> Netdev vs phylib is an implementation detail of Linux.
> I'm also surprised that you changed this.
> 
> > > > + */
> > > > +enum {
> > > > +	NO_TIMESTAMPING = 0,
> > > > +	NETDEV_TIMESTAMPING = (1 << 0),
> > > > +	PHYLIB_TIMESTAMPING = (1 << 1),
> > > > +	SOFTWARE_TIMESTAMPING = (1 << 2) | (1 << 0),    

Just emphasising Jakubs point here. phylib is an implementation
detail, in that the MAC driver might be using firmware to drive its
PHY, and that firmware can do a timestamp in the PHY. The API being
defined here should be independent of the implementation details. So
it probably should be MAC_TIMESTAMPING and PHY_TIMESTAMPING, and leave
it to the driver to decide if its PHYLIB doing the actual work, or
firmware.

	Andrew
