Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D830378D33B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 08:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbjH3GQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 02:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbjH3GQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 02:16:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6CCD2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 23:16:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbEVA-00061g-4N; Wed, 30 Aug 2023 08:16:28 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbEV8-0007z2-B3; Wed, 30 Aug 2023 08:16:26 +0200
Date:   Wed, 30 Aug 2023 08:16:26 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Tristram.Ha@microchip.com
Cc:     lukma@denx.de, olteanv@gmail.com, linux@rempel-privat.de,
        Arun.Ramadoss@microchip.com, f.fainelli@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        Woojung.Huh@microchip.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830061626.GF31399@pengutronix.de>
References: <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
 <20230829101851.435pxwwse2mo5fwi@skbuf>
 <20230829132429.529283be@wsk>
 <20230829114739.GC31399@pengutronix.de>
 <20230829143829.68410966@wsk>
 <20230829144209.GD31399@pengutronix.de>
 <20230829172913.518210b0@wsk>
 <20230829171205.GE31399@pengutronix.de>
 <BYAPR11MB3558DDEACCFE005DA1D41CDCECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558DDEACCFE005DA1D41CDCECE7A@BYAPR11MB3558.namprd11.prod.outlook.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:23:26PM +0000, Tristram.Ha@microchip.com wrote:
> > Yes, removing linkmod_and() will not should not help. I said, "The
> > phydev->supported_eee should be cleared."
> > 
> > For example like this:
> > --- a/drivers/net/phy/micrel.c
> > +++ b/drivers/net/phy/micrel.c
> > @@ -1400,6 +1400,7 @@ static int ksz9131_config_aneg(struct phy_device *phydev)
> > 
> >  static int ksz9477_get_features(struct phy_device *phydev)
> >  {
> > +       __ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
> >         int ret;
> > 
> >         ret = genphy_read_abilities(phydev);
> > @@ -1413,7 +1414,7 @@ static int ksz9477_get_features(struct phy_device
> > *phydev)
> >          * KSZ8563R should have 100BaseTX/Full only.
> >          */
> >         linkmode_and(phydev->supported_eee, phydev->supported,
> > -                    PHY_EEE_CAP1_FEATURES);
> > +                    zero);
> > 
> >         return 0;
> >  }
> > 
> > You will need to clear it only on KSZ9477 variants with this bug.
> > This change is tested and it works on my KSZ9477-EVB.
>  
> I think this is best for disabling EEE support.
> I think before some customers asked for Ethtool EEE support not because
> they want to use it but to disable it because of link instability.
> KSZ9893/KSZ9563 switches should have the same problem.  The EEE problem
> depends on the link partner.  For example my laptop does not have problem
> even though EEE is enabled, although I am not sure if EEE is really
> active.  The problem here is just using two KSZ9477 switches and
> programming those PHY setup values and enabling EEE will make the link
> unstable.  Management decided to disable EEE feature to avoid customer
> support issues.
> Another issue is EEE should be disabled when using 1588 PTP.
> 

I'd like to share my thoughts on the concerns raised:

- KSZ9477 & EEE: Disabling EEE for the KSZ9477 makes sense, especially since
the datasheet doesn't list it as supported.

- EEE Support for KSZ9893 & KSZ9563: The datasheets for the KSZ9893 indicate
support for EEE. The erratum recommends making adjustments to the "transmit
Refresh Time for Waketx to meet the IEEE Refresh Time specification" instead of
turning it off completely. The same applies to KSZ9563. We should consider
these adjustments.

- General Experience with KSZ Chips*: From my experience with these chips,
irrespective of the EEE functionality, only the 1000/full and 100/full link
modes tend to be stable enough.

- Responsibility to Customers and Certifications: As a part of the product
supply chain, I believe in our commitment to honesty with our customers. When
we select components for end products, we trust their listed features. For
instance, designing for ENERGY STAR certification requires that all
copper-based physical network ports in an LNE product must be compliant with
IEEE 802.3 Clause 78, which mandates Energy Efficient Ethernet. If Microchip
promotes a KSZ* chip with EEE as a feature, it becomes a cornerstone of the end
product. Negating a key functionality, which was sold and then incorporated
into the product, could risk non-compliance with certification criteria.

- Consistency in Product Representation: If the overarching company decision is
to disable the EEE feature for all chips to preempt potential customer support
issues, our product information should mirror this change. It's crucial that we
neither misrepresent nor over-promise on features. Your deeper insights, given
your involvement with Microchip's strategy, would be most enlightening.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
