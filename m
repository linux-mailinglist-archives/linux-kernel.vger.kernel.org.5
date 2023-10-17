Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6217CBB11
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjJQGZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbjJQGZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:25:51 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053FBEA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:25:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qsdWK-00083B-1E; Tue, 17 Oct 2023 08:25:36 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qsdWJ-002Fvi-Bu; Tue, 17 Oct 2023 08:25:35 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qsdWJ-00Erxi-8m; Tue, 17 Oct 2023 08:25:35 +0200
Date:   Tue, 17 Oct 2023 08:25:35 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: Re: [PATCH net-next v4 4/9] net: dsa: microchip: ksz9477: add Wake
 on LAN support
Message-ID: <20231017062535.GC3539182@pengutronix.de>
References: <20231016141256.2011861-1-o.rempel@pengutronix.de>
 <20231016141256.2011861-5-o.rempel@pengutronix.de>
 <18c20ed3-c117-4124-af3c-33df562b7f02@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18c20ed3-c117-4124-af3c-33df562b7f02@lunn.ch>
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

On Mon, Oct 16, 2023 at 04:59:24PM +0200, Andrew Lunn wrote:
> > +int ksz9477_set_wol(struct ksz_device *dev, int port,
> > +		    struct ethtool_wolinfo *wol)
> > +{
> > +	u8 pme_conf, pme_ctrl = 0;
> > +	int ret;
> > +
> > +	if (wol->wolopts & ~WAKE_PHY)
> > +		return -EINVAL;
> 
> EOPNOTSUPP might be better here. I'm assuming there is no other way
> WoL can be supported, since this is a combined MAC/PHY device. 

EOPNOTSUPP is typically returned when WoL isn’t supported at all. In
this instance, WoL is supported but an invalid option has been given.
Nonetheless, I don’t have a strong opinion on this matter currently, and
am ready to go with whichever option is recommended.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
