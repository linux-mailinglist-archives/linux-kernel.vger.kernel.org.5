Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51B87F4287
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343761AbjKVJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbjKVJq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:46:59 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C8DD7C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:46:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jnv-0002VZ-G0; Wed, 22 Nov 2023 10:45:55 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jnu-00AmUJ-6q; Wed, 22 Nov 2023 10:45:54 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5jnu-003H57-3w; Wed, 22 Nov 2023 10:45:54 +0100
Date:   Wed, 22 Nov 2023 10:45:54 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next v5 1/3] net: dsa: microchip: ksz8: Make flow
 control, speed, and duplex on CPU port configurable
Message-ID: <20231122094554.GF590719@pengutronix.de>
References: <20231122092545.2895635-1-o.rempel@pengutronix.de>
 <20231122092545.2895635-2-o.rempel@pengutronix.de>
 <ZV3MAS1yKwz9sANL@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZV3MAS1yKwz9sANL@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 09:38:09AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 22, 2023 at 10:25:43AM +0100, Oleksij Rempel wrote:
> > Allow flow control, speed, and duplex settings on the CPU port to be
> > configurable. Previously, the speed and duplex relied on default switch
> > values, which limited flexibility. Additionally, flow control was
> > hardcoded and only functional in duplex mode. This update enhances the
> > configurability of these parameters.
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> > ---
> >  drivers/net/dsa/microchip/ksz8.h       |  4 ++
> >  drivers/net/dsa/microchip/ksz8795.c    | 54 +++++++++++++++++++++++++-
> >  drivers/net/dsa/microchip/ksz_common.c |  1 +
> >  3 files changed, 57 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
> > index ef653bbfde75..571c26ce71e4 100644
> > --- a/drivers/net/dsa/microchip/ksz8.h
> > +++ b/drivers/net/dsa/microchip/ksz8.h
> > @@ -54,5 +54,9 @@ int ksz8_reset_switch(struct ksz_device *dev);
> >  int ksz8_switch_init(struct ksz_device *dev);
> >  void ksz8_switch_exit(struct ksz_device *dev);
> >  int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
> > +void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
> > +			      unsigned int mode, phy_interface_t interface,
> > +			      struct phy_device *phydev, int speed, int duplex,
> > +			      bool tx_pause, bool rx_pause);
> >  
> >  #endif
> > diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> > index 8deb217638d3..3504e7238eba 100644
> > --- a/drivers/net/dsa/microchip/ksz8795.c
> > +++ b/drivers/net/dsa/microchip/ksz8795.c
> > @@ -1528,6 +1528,58 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
> >  	}
> >  }
> >  
> > +/**
> > + * ksz8_cpu_port_link_up - Configures the CPU port of the switch.
> > + * @dev: The KSZ device instance.
> > + * @speed: The desired link speed.
> > + * @duplex: The desired duplex mode.
> > + * @tx_pause: If true, enables transmit pause.
> > + * @rx_pause: If true, enables receive pause.
> > + *
> > + * Description:
> > + * The function configures flow control and speed settings for the CPU
> > + * port of the switch based on the desired settings, current duplex mode, and
> > + * speed.
> > + */
> > +static void ksz8_cpu_port_link_up(struct ksz_device *dev, int speed, int duplex,
> > +				  bool tx_pause, bool rx_pause)
> > +{
> > +	const u16 *regs = dev->info->regs;
> > +	u8 ctrl = 0;
> > +
> > +	/* SW_FLOW_CTRL, SW_HALF_DUPLEX, and SW_10_MBIT bits are bootstrappable
> > +	 * at least on KSZ8873. They can have different values depending on your
> > +	 * board setup.
> > +	 */
> > +	if (duplex) {
> > +		if (tx_pause || rx_pause)
> > +			ctrl |= SW_FLOW_CTRL;
> 
> Please don't make this dependent on duplex, and allow phylink to enforce
> that. For example, phylink_resolve_an_pause() will only enable tx/rx
> pause if in full duplex mode.

OK, thx.

> > +	} else {
> > +		ctrl |= SW_HALF_DUPLEX;
> > +	}
> > +
> > +	/* This hardware only supports SPEED_10 and SPEED_100. For SPEED_10
> > +	 * we need to set the SW_10_MBIT bit. Otherwise, we can leave it 0.
> > +	 */
> > +	if (speed == SPEED_10)
> > +		ctrl |= SW_10_MBIT;
> > +
> > +	ksz_rmw8(dev, regs[S_BROADCAST_CTRL], SW_HALF_DUPLEX | SW_FLOW_CTRL |
> > +		 SW_10_MBIT, ctrl);
> 
> So this is using SW_FLOW_CTRL with the S_BROADCAST_CTRL register...
> 
> > @@ -1576,8 +1628,6 @@ int ksz8_setup(struct dsa_switch *ds)
> >  	 */
> >  	ds->vlan_filtering_is_global = true;
> >  
> > -	ksz_cfg(dev, S_REPLACE_VID_CTRL, SW_FLOW_CTRL, true);
> 
> But previously it was being used with the S_REPLACE_VID_CTRL register.
> Doesn't make sense to me.

Yes, it looks suspicious. There are multiple ways to access same
register. Vladimir pointed to in in the v4 review. S_BROADCAST_CTRL is
used in most recent code. So, i decided to settle down to the variant.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
