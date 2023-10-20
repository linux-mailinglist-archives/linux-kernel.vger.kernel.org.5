Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80447D0A97
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376488AbjJTIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376433AbjJTIer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:34:47 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA731A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:34:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtkxs-0002nG-8p; Fri, 20 Oct 2023 10:34:40 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qtkxq-002z2N-QK; Fri, 20 Oct 2023 10:34:38 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qtkxq-00FPk0-NI; Fri, 20 Oct 2023 10:34:38 +0200
Date:   Fri, 20 Oct 2023 10:34:38 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Woojung Huh <woojung.huh@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
        devicetree@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eric Dumazet <edumazet@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v6 5/9] net: dsa: microchip: ksz9477: Add Wake
 on Magic Packet support
Message-ID: <20231020083438.GD3637381@pengutronix.de>
References: <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-1-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019122850.1199821-6-o.rempel@pengutronix.de>
 <20231019172953.ajqtmnnthohnlek7@skbuf>
 <20231020050856.GB3637381@pengutronix.de>
 <20231020082350.f3ttjnn6qfcmskno@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020082350.f3ttjnn6qfcmskno@skbuf>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 11:23:50AM +0300, Vladimir Oltean wrote:
> On Fri, Oct 20, 2023 at 07:08:56AM +0200, Oleksij Rempel wrote:
> > On Thu, Oct 19, 2023 at 08:29:53PM +0300, Vladimir Oltean wrote:
> > > I don't get it, why do you release the reference on the MAC address as
> > > soon as you successfully get it? Without a reference held, the
> > > programmed address still lingers on, but the HSR offload code, on a
> > > different port with a different MAC address, can change it and break WoL.
> > 
> > It is ksz9477_get_wol() function. We do not actually need to program
> > here the MAC address, we only need to test if we would be able to get
> > it. To show the use more or less correct information on WoL
> > capabilities. For example, instead showing the user that Wake on Magic
> > is supported, where we already know that is not the case, we can already
> > show correct information. May be it will be better to have
> > extra option for ksz_switch_macaddr_get() to not allocate and do the
> > refcounting or have a separate function.
> 
> Ah, yes, it is from get_wol(). Maybe a ksz_switch_macaddr_tryget(ds, port)
> which returns bool (true if dev->switch_macaddr is NULL, or if non-NULL
> and ether_addr_equal(dev->switch_macaddr->addr, port addr))?

Ack, something like this.
I'll send new version later.

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
