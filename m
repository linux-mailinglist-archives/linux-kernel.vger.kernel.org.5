Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D476E7FD304
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjK2Jnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2Jnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:43:41 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DB9D6C;
        Wed, 29 Nov 2023 01:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bQSKiMQ1OYHCQRJw6c03yQbIRGLTECipgyg/iexwTys=; b=Nc6FRW+t4EOZ49d5C5KkvXIq//
        Z+47V8YM8oDP1G9CR8DY7AAn7nlzPbJwzHQ9AkL73rKlTuIZcspW1DbScT/JcT7NtjGlxVg9RDqMo
        4h3PT4LAEkC7hyjb5PXZmqlJjNL/wtbWvf+m/Fdkj89cu0gDp5WBSNnmk1RVvnQkocAYyrDLW8e6X
        KOkq4ws0z9MGQ0jpl96bksElfF86+6QNvGHN+DTsnbfhnPH6zxr/Urukm1Tfww01g+Guwq9O8Dtq8
        wnpY604FdpuNDV78VUzEfi1cRa8PqnlCvdzQ9XuH6ZQf4WGc8sOnn2I8iVlAZYZQwdIeChxXCNprB
        Bz6mvJOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33810)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8H6Y-0008WQ-2H;
        Wed, 29 Nov 2023 09:43:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8H6a-0003sj-99; Wed, 29 Nov 2023 09:43:40 +0000
Date:   Wed, 29 Nov 2023 09:43:40 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 09/14] net: phy: at803x: remove specific qca808x
 check from at803x functions
Message-ID: <ZWcHzAXyIl++F1Sm@shell.armlinux.org.uk>
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-10-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129021219.20914-10-ansuelsmth@gmail.com>
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

On Wed, Nov 29, 2023 at 03:12:14AM +0100, Christian Marangi wrote:
> Remove specific qca808x check from at803x generic functions.
> 
> While this cause a bit of code duplication, this is needed in
> preparation for splitting the driver per PHY family and detaching
> qca808x specific bits from the at803x driver.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/phy/at803x.c | 107 ++++++++++++++++++++++++++-------------
>  1 file changed, 71 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index 8f5878ccb1a8..475b96165f45 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -1043,24 +1043,6 @@ static int at803x_config_aneg(struct phy_device *phydev)
>  	 */
>  	ret = 0;

Doesn't this become unnecessary?
>  
> -	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
> -		int phy_ctrl = 0;
> -
> -		/* The reg MII_BMCR also needs to be configured for force mode, the
> -		 * genphy_config_aneg is also needed.
> -		 */
> -		if (phydev->autoneg == AUTONEG_DISABLE)
> -			genphy_c45_pma_setup_forced(phydev);
> -
> -		if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
> -			phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> -
> -		ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> -				MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	return __genphy_config_aneg(phydev, ret);

... since you can just call genphy_config_aneg() here now?

> @@ -1845,6 +1815,47 @@ static int qca8327_suspend(struct phy_device *phydev)
>  	return qca83xx_suspend(phydev);
>  }
>  
> +static int qca808x_config_aneg(struct phy_device *phydev)
> +{
> +	int phy_ctrl = 0;
> +	int ret;
> +
> +	ret = at803x_config_mdix(phydev, phydev->mdix_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Changes of the midx bits are disruptive to the normal operation;
> +	 * therefore any changes to these registers must be followed by a
> +	 * software reset to take effect.
> +	 */
> +	if (ret == 1) {
> +		ret = genphy_soft_reset(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Do not restart auto-negotiation by setting ret to 0 defautly,
> +	 * when calling __genphy_config_aneg later.
> +	 */
> +	ret = 0;
> +
> +	/* The reg MII_BMCR also needs to be configured for force mode, the
> +	 * genphy_config_aneg is also needed.
> +	 */
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		genphy_c45_pma_setup_forced(phydev);
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising))
> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G, phy_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __genphy_config_aneg(phydev, ret);
> +}

... but is it _really_ worth duplicating the entire function just to
deal with the QCA8081 difference? On balance, I think the original code
is better.

Overall, I'm getting the impression that you have a mental hang-up about
drivers checking the PHY ID in their method drivers... there's
absolutely nothing wrong with that. When the result of trying to
eliminate those results in bloating a driver, then the cleanup is not
a cleanup anymore, it creates bloat and makes future maintenance
harder.

Sorry, but no, I don't like this patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
