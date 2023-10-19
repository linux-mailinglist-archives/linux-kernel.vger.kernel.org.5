Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6247CEED1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 06:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjJSEuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 00:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSEuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 00:50:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FE99F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 21:50:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtKz1-0006Fb-1L; Thu, 19 Oct 2023 06:50:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qtKyz-002iBt-EU; Thu, 19 Oct 2023 06:50:05 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtKyz-00FDKV-BM; Thu, 19 Oct 2023 06:50:05 +0200
Date:   Thu, 19 Oct 2023 06:50:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231019045005.GC3595737@pengutronix.de>
References: <20231018113913.3629151-1-o.rempel@pengutronix.de>
 <20231018113913.3629151-6-o.rempel@pengutronix.de>
 <f4cfb974-42c6-492c-80fd-85bbeaada9d1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4cfb974-42c6-492c-80fd-85bbeaada9d1@gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 11:20:50AM -0700, Florian Fainelli wrote:
> On 10/18/23 04:39, Oleksij Rempel wrote:
> > Introduce Wake on Magic Packet (WoL) functionality to the ksz9477
> > driver.
> > 
> > Major changes include:
> > 
> > 1. Extending the `ksz9477_handle_wake_reason` function to identify Magic
> >     Packet wake events alongside existing wake reasons.
> > 
> > 2. Updating the `ksz9477_get_wol` and `ksz9477_set_wol` functions to
> >     handle WAKE_MAGIC alongside the existing WAKE_PHY option, and to
> >     program the switch's MAC address register accordingly when Magic
> >     Packet wake-up is enabled. This change will prevent WAKE_MAGIC
> >     activation if the related port has a different MAC address compared
> >     to a MAC address already used by HSR or an already active WAKE_MAGIC
> >     on another port.
> > 
> > 3. Adding a restriction in `ksz_port_set_mac_address` to prevent MAC
> >     address changes on ports with active Wake on Magic Packet, as the
> >     switch's MAC address register is utilized for this feature.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> This looks good to me, just one suggestion below
> 
> [snip]
> 
> > +	if (pme_ctrl_old == pme_ctrl)
> > +		return 0;
> > +
> > +	/* To keep reference count of MAC address, we should do this
> > +	 * operation only on change of WOL settings.
> > +	 */
> > +	if (!(pme_ctrl_old & PME_WOL_MAGICPKT) &&
> > +	    (pme_ctrl & PME_WOL_MAGICPKT)) {
> 
> Maybe use a temporary variable for that condition since you re-use it below
> in case you failed to perform the write of the pme_ctrl value. It would be
> more readable IMHO, something like:
> 
> 	bool magicpkt_was_disabled = !(pme_ctrl_old & PME_WOL_MAGICPKT) &&
> (pme_ctrl & PME_WOL_MAGICPKT));

Sounds good. I'll update it.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
