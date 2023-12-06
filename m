Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD506807406
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442550AbjLFPyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379416AbjLFPym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:54:42 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008EDE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:54:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAuEU-0005eJ-Fi; Wed, 06 Dec 2023 16:54:42 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rAuES-00DzeT-4b; Wed, 06 Dec 2023 16:54:40 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAuES-005aMs-1i; Wed, 06 Dec 2023 16:54:40 +0100
Date:   Wed, 6 Dec 2023 16:54:40 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231206155440.GA1324895@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
 <20231206085520.GA1293736@pengutronix.de>
 <20231206151406.75eglqtsrrb4vegf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206151406.75eglqtsrrb4vegf@skbuf>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:14:06PM +0200, Vladimir Oltean wrote:
> On Wed, Dec 06, 2023 at 09:55:20AM +0100, Oleksij Rempel wrote:
> > On Thu, Nov 23, 2023 at 11:52:57AM +0100, Paolo Abeni wrote:
> > > Hi,
> > > 
> > > On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
> > > > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > > > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > > > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > > > for both chip variants, which is actually for LED configuration. This
> > > > update ensures the correct registers and bits are used for the PHY
> > > > loopback feature:
> > > > 
> > > > - For KSZ8794: Use 0xF / Bit 7.
> > > > - For KSZ8873: Use 0xD / Bit 0.
> > > > 
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > 
> > > This looks like a bugfix, so possibly worth a Fixes tag? Given the
> > > dependency on the previous refactor, I think we can take it via net-
> > > next.
> > > 
> > > @Andrew, Florian, Vladimir: do you have any specific preference here?
> > 
> > I do not think any one cares about supporting this switch variant in
> > stable :)
> > 
> > Regards,
> > Oleksij
> 
> Sorry, this simply fell through the cracks.
> 
> How is PHY loopback even supposed to be triggered? User space flips
> NETIF_F_LOOPBACK on the netdev, driver ndo_set_features() catches it and
> calls phy_loopback() and this calls into phylib's phydev->drv->set_loopback()
> or the generic genphy_loopback()?

correct.

> I don't see DSA implementing ndo_set_features(), nor offering NETIF_F_LOOPBACK.
> The PHY is integrated, so DSA is the only relevant netdev driver. Is
> there any other way to test this functionality?

yes - net_selftest()

> If not, I think it's a case of "tree falling in the woods and nobody
> hearing it". Not "stable" material. But it definitely has nothing to do
> with not caring about the switch variant.

Sorry, my intention is not to criticize anyone. I am not getting
feedbacks or bug reports for ksz88xx variants, so it seems like not many
people use it in upstream.

When I have time slots to work on this driver, I try to use them to do
fixes and also clean up the code. Since there is some sort of fog of
uncertainty about when I get the next time slot, or even if I get it at
all, I am trying to push both fixes and cleanups together.

But, you are right, it is not a good reason for not caring about stable :)

What is the decision about this patch set?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
