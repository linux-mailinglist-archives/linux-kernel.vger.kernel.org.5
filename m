Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F1C7C007E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjJJPh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJJPh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:37:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03571D8;
        Tue, 10 Oct 2023 08:37:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE456C433C7;
        Tue, 10 Oct 2023 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952274;
        bh=ccn0ErrI3BKGdflhAH1/B0pSw0wAE/4xTGwBpyvuDHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kG+srMFaKg3Sy4x78n9VSvAOJFgmN0tdjNSTW/JeDSUZzFPLVe3WowEvrDEfZ+JSv
         DegXXrPaqpdMdctSGVLgHgU2EsUP9+VL0GbCMLEuA27pJl2InJCFBZnTdq+OCQE7m3
         7dNritxb+Rz0HFEy0DvIWu+OWocGqGTSKH8pVS2BL1pO7s85X40JdKsKaLC4dHuuqE
         6BOR5JmgtWj5yM8HibBVEJems72H2ueDl2y4Ph2mcebhKw/g6AcnAqKMIuF3K8zlKJ
         JIbFWypFUL53+BB3R4sIBMKQoV1iih1afXuD6Zflj2N+sUaIM3Lvrq/FPs2WYICkrZ
         M3cIxSC17Pn1Q==
Date:   Tue, 10 Oct 2023 17:37:47 +0200
From:   Simon Horman <horms@kernel.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH net-next v5 01/16] net: Convert PHYs hwtstamp callback to
 use kernel_hwtstamp_config
Message-ID: <ZSVvywM8OLG12OhR@kernel.org>
References: <20231009155138.86458-1-kory.maincent@bootlin.com>
 <20231009155138.86458-2-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009155138.86458-2-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...

> diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
> index 7ab080ff02df..416484ea6eb3 100644
> --- a/drivers/net/phy/nxp-c45-tja11xx.c
> +++ b/drivers/net/phy/nxp-c45-tja11xx.c
> @@ -1022,24 +1022,21 @@ static bool nxp_c45_rxtstamp(struct mii_timestamper *mii_ts,
>  }
>  
>  static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
> -			    struct ifreq *ifreq)
> +			    struct kernel_hwtstamp_config *config,
> +			    struct netlink_ext_ack *extack)
>  {
>  	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
>  						mii_ts);
>  	struct phy_device *phydev = priv->phydev;
>  	const struct nxp_c45_phy_data *data;
> -	struct hwtstamp_config cfg;
>  
> -	if (copy_from_user(&cfg, ifreq->ifr_data, sizeof(cfg)))
> -		return -EFAULT;
> -
> -	if (cfg.tx_type < 0 || cfg.tx_type > HWTSTAMP_TX_ON)
> +	if (cfg->tx_type < 0 || cfg->tx_type > HWTSTAMP_TX_ON)

Hi Köry,

cfg is removed from this function by this patch, but is used here.

>  		return -ERANGE;
>  
>  	data = nxp_c45_get_data(phydev);
> -	priv->hwts_tx = cfg.tx_type;
> +	priv->hwts_tx = cfg->tx_type;
>  
> -	switch (cfg.rx_filter) {
> +	switch (cfg->rx_filter) {
>  	case HWTSTAMP_FILTER_NONE:
>  		priv->hwts_rx = 0;
>  		break;
> @@ -1047,7 +1044,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
>  	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>  	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>  		priv->hwts_rx = 1;
> -		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
> +		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
>  		break;
>  	default:
>  		return -ERANGE;
> @@ -1074,7 +1071,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
>  		nxp_c45_clear_reg_field(phydev, &data->regmap->irq_egr_ts_en);
>  
>  nxp_c45_no_ptp_irq:
> -	return copy_to_user(ifreq->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
> +	return 0;
>  }
>  

...
