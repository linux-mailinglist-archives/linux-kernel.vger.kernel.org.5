Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3678E046
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbjH3TOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243201AbjH3KSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:18:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82D81B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:18:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbIH9-0000SY-5J; Wed, 30 Aug 2023 12:18:15 +0200
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qbIH7-0003o2-3S; Wed, 30 Aug 2023 12:18:13 +0200
Date:   Wed, 30 Aug 2023 12:18:13 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230830101813.GG31399@pengutronix.de>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830092119.458330-2-lukma@denx.de>
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

On Wed, Aug 30, 2023 at 11:21:19AM +0200, Lukasz Majewski wrote:
> The KSZ9477 errata points out (in 'Module 4') the link up/down problem
> when EEE (Energy Efficient Ethernet) is enabled in the device to which
> the KSZ9477 tries to auto negotiate.
> 
> The suggested workaround is to clear advertisement of EEE for PHYs in
> this chip driver.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  drivers/net/phy/micrel.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 87b090ad2874..469dcd8a5711 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -1418,6 +1418,35 @@ static int ksz9131_get_features(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int ksz9477_get_features(struct phy_device *phydev)
> +{
> +	__ETHTOOL_DECLARE_LINK_MODE_MASK(zero) = { 0, };
> +	int ret;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* KSZ9477 Errata DS80000754C
> +	 *
> +	 * Module 4: Energy Efficient Ethernet (EEE) feature select must be
> +	 * manually disabled
> +	 *   The EEE feature is enabled by default, but it is not fully
> +	 *   operational. It must be manually disabled through register
> +	 *   controls. If not disabled, the PHY ports can auto-negotiate
> +	 *   to enable EEE, and this feature can cause link drops when linked
> +	 *   to another device supporting EEE.
> +	 *
> +	 *   Although, the KSZ9477 MMD register
> +	 *   (MMD_DEVICE_ID_EEE_ADV.MMD_EEE_ADV) advertise that EEE is
> +	 *   operational one needs to manualy clear them to follow the chip
> +	 *   errata.
> +	 */
> +	linkmode_and(phydev->supported_eee, phydev->supported, zero);
> +
> +	return 0;
> +}
> +
>  #define KSZ8873MLL_GLOBAL_CONTROL_4	0x06
>  #define KSZ8873MLL_GLOBAL_CONTROL_4_DUPLEX	BIT(6)
>  #define KSZ8873MLL_GLOBAL_CONTROL_4_SPEED	BIT(4)
> @@ -4871,7 +4900,7 @@ static struct phy_driver ksphy_driver[] = {
>  	.handle_interrupt = kszphy_handle_interrupt,
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
> -	.get_features	= ksz9131_get_features,
> +	.get_features	= ksz9477_get_features,

Sorry, i didn't described all details how to implement it.

This code will break EEE support for the KSZ8563R switch.

Please search for MICREL_KSZ8_P1_ERRATA in the kernel source.
Then add new flag, for example MICREL_NO_EEE and use it in a similar
way how MICREL_KSZ8_P1_ERRATA was set and used. With this
implementation, first patch is not needed.

The code will be something like this:
   if (dev_flags & MICREL_NO_EEE)
      /* lots of comments */
      linkmode_and(phydev->supported_eee, phydev->supported, zero);
   else
      /* lots of other comments */
      linkmode_and(phydev->supported_eee, phydev->supported,
                   PHY_EEE_CAP1_FEATURES);

On the switch driver side i would expect something like this:
ksz_get_phy_flags(struct dsa_switch *ds, int port)

       swtich (dev->chip_id)
       case KSZ8830_CHIP_ID:
         ....
         break;
       case KSZ9477_CHIP_ID:
         return MICREL_NO_EEE;


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
