Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF57C00CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjJJPwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjJJPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:52:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E24C4;
        Tue, 10 Oct 2023 08:52:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C4C433C8;
        Tue, 10 Oct 2023 15:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953135;
        bh=mYZCwt5HRNSmbVd7qcD/9Qla13X/6gnoEYkfuSGghUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kv2I+KjXv/r2Lpzhy1Ct+G1P/C2p2lqypWtlwBCoeZ0IX/mTE/cPoNVQHnlaKrLwi
         qiBGBHav0u5KwcjCJk8Q4g5y2kQeeBdEupLj3JauKg/qgDnhA2cw8cDV0vMPWAHOeG
         aHmzGfXCyYLG8UY2OaLGUOBAeYv8vc9sJB31raW+PA7rnO9O3zGhwbP81ILhYXS/pw
         XAbjPci4l+KKKOCObXn9fkViSN2mdL2gN2vj0X+HffreB8uC8vKHWySwY0gD3s8/Tx
         RBoIut1LVpaemqXF3QWM7Y9uVLY9ic4ip90zarm+BeTmZTDV83deQ4RfHhNeisfuet
         QuT8Te/zuFBEg==
Date:   Tue, 10 Oct 2023 17:52:08 +0200
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 13/16] net: Change the API of PHY default
 timestamp to MAC
Message-ID: <ZSVzKPIx/0ZYXPdj@kernel.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-14-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-14-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:51:35PM +0200, Köry Maincent wrote:

Hi Köry,

some minor feedback from my side.

...

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2ce74593d6e4..2d5a6d57acb3 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1411,6 +1411,68 @@ int phy_sfp_probe(struct phy_device *phydev,
>  }
>  EXPORT_SYMBOL(phy_sfp_probe);
>  
> +/* An allowlist for PHYs selected as default timesetamping.
> + * Its use is to keep compatibility with old PTP API which is selecting
> + * these PHYs as default timestamping.
> + * The new API is selecting the MAC as default timestamping.
> + */
> +const char * const phy_timestamping_allowlist[] = {

Should this be static?

As flagged by Sparse.

> +	"Broadcom BCM5411",
> +	"Broadcom BCM5421",
> +	"Broadcom BCM54210E",
> +	"Broadcom BCM5461",
> +	"Broadcom BCM54612E",
> +	"Broadcom BCM5464",
> +	"Broadcom BCM5481",
> +	"Broadcom BCM54810",
> +	"Broadcom BCM54811",
> +	"Broadcom BCM5482",
> +	"Broadcom BCM50610",
> +	"Broadcom BCM50610M",
> +	"Broadcom BCM57780",
> +	"Broadcom BCM5395",
> +	"Broadcom BCM53125",
> +	"Broadcom BCM53128",
> +	"Broadcom BCM89610",
> +	"NatSemi DP83640",
> +	"Microchip LAN8841 Gigabit PHY",
> +	"Microchip INDY Gigabit Quad PHY",
> +	"Microsemi GE VSC856X SyncE",
> +	"Microsemi GE VSC8575 SyncE",
> +	"Microsemi GE VSC8582 SyncE",
> +	"Microsemi GE VSC8584 SyncE",
> +	"NXP C45 TJA1103",
> +	NULL,
> +};
> +
> +/**
> + * phy_set_timestamp - set the default selected timestamping device
> + * @dev: Pointer to net_device
> + * @phydev: Pointer to phy_device
> + *
> + * This is used to set default timestamping device taking into account
> + * the new API choice, which is selecting the timestamping from MAC by
> + * default.
> + */

...

> @@ -1484,6 +1546,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  	phydev->phy_link_change = phy_link_change;
>  	if (dev) {
> +		phy_set_timestamp(dev, phydev);
>  		phydev->attached_dev = dev;
>  		dev->phydev = phydev;
>  
> @@ -1794,6 +1857,7 @@ EXPORT_SYMBOL_GPL(devm_phy_package_join);
>  void phy_detach(struct phy_device *phydev)
>  {
>  	struct net_device *dev = phydev->attached_dev;
> +	const struct ethtool_ops *ops = dev->ethtool_ops;

Elsewhere in this function it is assumed that dev may be NULL.
But here it is dereferenced unconditionally.

As flagged by Smatch.

>  	struct module *ndev_owner = NULL;
>  	struct mii_bus *bus;
>  
> @@ -1812,6 +1876,10 @@ void phy_detach(struct phy_device *phydev)
>  
>  	phy_suspend(phydev);
>  	if (dev) {
> +		if (ops->get_ts_info)
> +			dev->ts_layer = NETDEV_TIMESTAMPING;
> +		else
> +			dev->ts_layer = NO_TIMESTAMPING;
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
>  	}

...
