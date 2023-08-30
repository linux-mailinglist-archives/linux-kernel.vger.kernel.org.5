Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CE378D898
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjH3Say (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243652AbjH3LUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:20:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FEF1BB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 04:20:50 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbJFR-0008Lm-P3; Wed, 30 Aug 2023 13:20:33 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbJFQ-0006pn-1b; Wed, 30 Aug 2023 13:20:32 +0200
Date:   Wed, 30 Aug 2023 13:20:32 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830112032.GI31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
 <ZO8jIQJLE53GH6G6@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZO8jIQJLE53GH6G6@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:08:17PM +0100, Russell King (Oracle) wrote:
> On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> > +	/* KSZ9477 Errata DS80000754C
> > +	 *
> > +	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
> > +	 * manually disabled
> > +	 *   The EEE feature is enabled by default, but it is not fully
> > +	 *   operational. It must be manually disabled through register
> > +	 *   controls. If not disabled, the PHY ports can auto-negotiate
> > +	 *   to enable EEE, and this feature can cause link drops when linked
> > +	 *   to another device supporting EEE.
> > +	 *
> > +	 *   Although, the KSZ9477 MMD register
> > +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that EEE is
> > +	 *   operational one needs to manualy clear them to follow the chip
> > +	 *   errata.
> > +	 */
> > +	linkmode_and(phydev->supported_eee, phydev->supported, zero);
> 
> Hi,
> 
> I'm wondering whether you had a reason to write the above, rather than
> use the simpler:
> 
> 	linkmode_zero(phydev->supported_eee);

Ah, I wondered what was the proper name for this and was not able to
found it.

Thank you!

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
