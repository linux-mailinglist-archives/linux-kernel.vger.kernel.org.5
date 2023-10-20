Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A957D0780
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 07:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345092AbjJTFJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 01:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjJTFJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 01:09:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C093FB8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 22:09:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qthko-0001Lr-Dt; Fri, 20 Oct 2023 07:08:58 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qthkm-002xCC-Tz; Fri, 20 Oct 2023 07:08:56 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qthkm-00FNf4-Pe; Fri, 20 Oct 2023 07:08:56 +0200
Date:   Fri, 20 Oct 2023 07:08:56 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231020050856.GB3637381@pengutronix.de>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019172953.ajqtmnnthohnlek7@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231019172953.ajqtmnnthohnlek7@skbuf>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 08:29:53PM +0300, Vladimir Oltean wrote:
> On Thu, Oct 19, 2023 at 02:28:46PM +0200, Oleksij Rempel wrote:
....
> > @@ -109,10 +110,22 @@ void ksz9477_get_wol(struct ksz_device *dev, int port,
> >  
> >  	wol->supported = WAKE_PHY;
> >  
> > +	/* Check if at this moment we would be able to get the MAC address
> > +	 * and use it for WAKE_MAGIC support. This result may change dynamically
> > +	 * depending on configuration of other ports.
> > +	 */
> > +	ret = ksz_switch_macaddr_get(dev->ds, port, NULL);
> > +	if (!ret) {
> > +		wol->supported |= WAKE_MAGIC;
> > +		ksz_switch_macaddr_put(dev->ds);
> 
> I don't get it, why do you release the reference on the MAC address as
> soon as you successfully get it? Without a reference held, the
> programmed address still lingers on, but the HSR offload code, on a
> different port with a different MAC address, can change it and break WoL.

It is ksz9477_get_wol() function. We do not actually need to program
here the MAC address, we only need to test if we would be able to get
it. To show the use more or less correct information on WoL
capabilities. For example, instead showing the user that Wake on Magic
is supported, where we already know that is not the case, we can already
show correct information. May be it will be better to have
extra option for ksz_switch_macaddr_get() to not allocate and do the
refcounting or have a separate function.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
