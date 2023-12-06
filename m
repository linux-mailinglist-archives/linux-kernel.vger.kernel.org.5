Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B47806A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377110AbjLFIz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:55:26 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBA71A098
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:55:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAngg-0000fJ-VT; Wed, 06 Dec 2023 09:55:22 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1rAnge-00DvAH-SO; Wed, 06 Dec 2023 09:55:20 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1rAnge-005Wq9-PI; Wed, 06 Dec 2023 09:55:20 +0100
Date:   Wed, 6 Dec 2023 09:55:20 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v1 3/3] net: dsa: microchip: Fix PHY loopback
 configuration for KSZ8794 and KSZ8873
Message-ID: <20231206085520.GA1293736@pengutronix.de>
References: <20231121152426.4188456-1-o.rempel@pengutronix.de>
 <20231121152426.4188456-3-o.rempel@pengutronix.de>
 <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35045f6ef6a5b274063186c065a8215088b94cd5.camel@redhat.com>
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

On Thu, Nov 23, 2023 at 11:52:57AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On Tue, 2023-11-21 at 16:24 +0100, Oleksij Rempel wrote:
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
> 
> This looks like a bugfix, so possibly worth a Fixes tag? Given the
> dependency on the previous refactor, I think we can take it via net-
> next.
> 
> @Andrew, Florian, Vladimir: do you have any specific preference here?

I do not think any one cares about supporting this switch variant in
stable :)

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
