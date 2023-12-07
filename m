Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2503480800D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjLGFPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:15:01 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FBD51
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:15:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rB6j2-0007mN-LF; Thu, 07 Dec 2023 06:15:04 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rB6j0-00E7QO-Lq; Thu, 07 Dec 2023 06:15:02 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rB6j0-005f4k-Iq; Thu, 07 Dec 2023 06:15:02 +0100
Date:   Thu, 7 Dec 2023 06:15:02 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Eric Dumazet <edumazet@google.com>,
        kernel@pengutronix.de, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231207051502.GB1324895@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <20231207002823.2qx24nxjhn6e43w4@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207002823.2qx24nxjhn6e43w4@skbuf>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:28:23AM +0200, Vladimir Oltean wrote:
> On Tue, Nov 21, 2023 at 04:24:26PM +0100, Oleksij Rempel wrote:
> > Correct the PHY loopback bit handling in the ksz8_w_phy_bmcr and
> > ksz8_r_phy_bmcr functions for KSZ8794 and KSZ8873 variants in the ksz8795
> > driver. Previously, the code erroneously used Bit 7 of port register 0xD
> > for both chip variants, which is actually for LED configuration. This
> > update ensures the correct registers and bits are used for the PHY
> > loopback feature:
> > 
> > - For KSZ8794: Use 0xF / Bit 7.
> > - For KSZ8873: Use 0xD / Bit 0.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> 
> How did you find, and how did you test this, and on which one of the switches?

I tested it by using "ethtool -t lanX" command on KSZ8873. Before this
patch the link will stop to work _after_ end of the selftest. The
selftest will fail too.

After this patch, the selftest is passed, except of the TCP test. And
link is working _after_ the selftest,

> Opening the KSZ8873 datasheet, I am confused about their description of
> the "far-end loopback". They make it sound as if this loops the packets
> _received_ from the media side of PHY port A back to the transmit side
> of PHY port A. But the route that these packets take is through the MAC
> of PHY port A, then the switching fabric, then PHY port B which reflects
> them back to PHY port A, where they finally egress.
> 
> Actually, they even go as far as saying that if you set the loopback bit
> of port 1, the packets that will be looped back will be from port 2's
> RXP/RXM to TXP/TXM pins, and viceversa.
> 
> If true, I believe this isn't the behavior expected by phy_loopback(),
> where the TX signals from the media side of the PHY are looped back into
> the RX side.
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
