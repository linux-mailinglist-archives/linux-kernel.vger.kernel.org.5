Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79378DE42
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjH3TAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242821AbjH3Jst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:48:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7351B3;
        Wed, 30 Aug 2023 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693388926; x=1724924926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orlWb/RTxKwxmmASqoBVNPU97JJXkwjIwCGq+9b7IOI=;
  b=gdtnRX8Qq4wUugYquYr/o/zeVJtMak6Ssb4r+ruzHn/jGz0UW0vxww1h
   gpFAkG4SCYVMBKOgqyoQvb19NaHx1ToZij6owjF9fGad7sHD3dNz3Vw9B
   pUd53TN6htMaKrjNRW6wBidt6DutVVToJdQHEK4zCCUZPKwm19IM2+67W
   AhMXSK1C0CvgeuxvSpC6a4Cwwx/g95OILPGIOanu9t6FqdR1FNKdpNo9i
   3uAp5xHXF3lPy+tTOEwLdITOCLztICcQhdUApWZ+Z10csOQyh2miWSc0m
   AJp5dmuRZeVd2zmw4bjkwwStKY8R0LEIUnjpGkcgsFuLGl98Oao5uv8ae
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461970656"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461970656"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:48:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732552815"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="732552815"
Received: from unknown (HELO localhost.localdomain) ([10.237.112.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 02:48:39 -0700
Date:   Wed, 30 Aug 2023 11:48:31 +0200
From:   Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: phy: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <ZO8QbyKphyTmuv/g@localhost.localdomain>
References: <20230830092119.458330-1-lukma@denx.de>
 <20230830092119.458330-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830092119.458330-2-lukma@denx.de>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Hi,

As the net is target you should add fixes tag which the commit that your
changes is fixing (workarounding :) )

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
= { 0 };

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
>  } };
>  
>  module_phy_driver(ksphy_driver);
> -- 
> 2.20.1
> 
