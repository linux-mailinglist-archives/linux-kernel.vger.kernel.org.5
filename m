Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF2C7F41CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbjKVJi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjKVJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:38:25 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790A810C;
        Wed, 22 Nov 2023 01:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mnhtNd6IwKv5NoftYNEBxPIdZzAbq3PonPgsgvFvYdI=; b=i3perO0k9ztjIFMSyxM49VKgYP
        H7MDcZguh7B39KiLP93Zmm1eOYR740+ovLJdu2lwg6jm17DwzfIQuyW+2O7TXC5D13DbwWqjqHrQb
        LK09ak1sASV7iKfZDhcFAfQK7HOp8DjU4uEICJ8YRFtUFZeUj+Ao2wSoOxI69j1LK+tBom8V4SpH4
        MEeUdcD42z8eyXgLdbuxmPfJfQDhfup08pgmjXGckPXS+ZI+Hw/ABN2ZdVs7Q7JS8x/S2O23JV3rn
        TIsqMVgBetuxM61qE92tDPmp/kV29o/E7aiUmUwjgQPgRPv1/mPzRlH8USQn53+LoX5D2gqBO4oYn
        fd+U56gg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52816)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5jgO-0008G8-23;
        Wed, 22 Nov 2023 09:38:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5jgP-00054V-JE; Wed, 22 Nov 2023 09:38:09 +0000
Date:   Wed, 22 Nov 2023 09:38:09 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
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
Message-ID: <ZV3MAS1yKwz9sANL@shell.armlinux.org.uk>
References: <20231122092545.2895635-1-o.rempel@pengutronix.de>
 <20231122092545.2895635-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122092545.2895635-2-o.rempel@pengutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 10:25:43AM +0100, Oleksij Rempel wrote:
> Allow flow control, speed, and duplex settings on the CPU port to be
> configurable. Previously, the speed and duplex relied on default switch
> values, which limited flexibility. Additionally, flow control was
> hardcoded and only functional in duplex mode. This update enhances the
> configurability of these parameters.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> ---
>  drivers/net/dsa/microchip/ksz8.h       |  4 ++
>  drivers/net/dsa/microchip/ksz8795.c    | 54 +++++++++++++++++++++++++-
>  drivers/net/dsa/microchip/ksz_common.c |  1 +
>  3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
> index ef653bbfde75..571c26ce71e4 100644
> --- a/drivers/net/dsa/microchip/ksz8.h
> +++ b/drivers/net/dsa/microchip/ksz8.h
> @@ -54,5 +54,9 @@ int ksz8_reset_switch(struct ksz_device *dev);
>  int ksz8_switch_init(struct ksz_device *dev);
>  void ksz8_switch_exit(struct ksz_device *dev);
>  int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu);
> +void ksz8_phylink_mac_link_up(struct ksz_device *dev, int port,
> +			      unsigned int mode, phy_interface_t interface,
> +			      struct phy_device *phydev, int speed, int duplex,
> +			      bool tx_pause, bool rx_pause);
>  
>  #endif
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index 8deb217638d3..3504e7238eba 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -1528,6 +1528,58 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
>  	}
>  }
>  
> +/**
> + * ksz8_cpu_port_link_up - Configures the CPU port of the switch.
> + * @dev: The KSZ device instance.
> + * @speed: The desired link speed.
> + * @duplex: The desired duplex mode.
> + * @tx_pause: If true, enables transmit pause.
> + * @rx_pause: If true, enables receive pause.
> + *
> + * Description:
> + * The function configures flow control and speed settings for the CPU
> + * port of the switch based on the desired settings, current duplex mode, and
> + * speed.
> + */
> +static void ksz8_cpu_port_link_up(struct ksz_device *dev, int speed, int duplex,
> +				  bool tx_pause, bool rx_pause)
> +{
> +	const u16 *regs = dev->info->regs;
> +	u8 ctrl = 0;
> +
> +	/* SW_FLOW_CTRL, SW_HALF_DUPLEX, and SW_10_MBIT bits are bootstrappable
> +	 * at least on KSZ8873. They can have different values depending on your
> +	 * board setup.
> +	 */
> +	if (duplex) {
> +		if (tx_pause || rx_pause)
> +			ctrl |= SW_FLOW_CTRL;

Please don't make this dependent on duplex, and allow phylink to enforce
that. For example, phylink_resolve_an_pause() will only enable tx/rx
pause if in full duplex mode.

> +	} else {
> +		ctrl |= SW_HALF_DUPLEX;
> +	}
> +
> +	/* This hardware only supports SPEED_10 and SPEED_100. For SPEED_10
> +	 * we need to set the SW_10_MBIT bit. Otherwise, we can leave it 0.
> +	 */
> +	if (speed == SPEED_10)
> +		ctrl |= SW_10_MBIT;
> +
> +	ksz_rmw8(dev, regs[S_BROADCAST_CTRL], SW_HALF_DUPLEX | SW_FLOW_CTRL |
> +		 SW_10_MBIT, ctrl);

So this is using SW_FLOW_CTRL with the S_BROADCAST_CTRL register...

> @@ -1576,8 +1628,6 @@ int ksz8_setup(struct dsa_switch *ds)
>  	 */
>  	ds->vlan_filtering_is_global = true;
>  
> -	ksz_cfg(dev, S_REPLACE_VID_CTRL, SW_FLOW_CTRL, true);

But previously it was being used with the S_REPLACE_VID_CTRL register.
Doesn't make sense to me.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
