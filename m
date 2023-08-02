Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E276CAD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjHBKZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 06:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjHBKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 06:24:13 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303503582;
        Wed,  2 Aug 2023 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N1HgB4YiEzmJxeTSi3B7Jhbwy5EMd0guXdnsKoYE0Vc=; b=vBg/kp3AXeZ7PuHuRqKuhie8K+
        uWWP+teLk/qZdRjzIBiB6Msmrdb/9+QSNOvG3Q/7E/7GYZWQr9sJuY8EbpeClpuN8YehYfieNxTxI
        u+R7q11Vglqcj82S//5qKAC359vvsgf0A+hslga17piuypkiOExsHEQxD6NjAZAMr6LHezCBIjCof
        uvt+4Zh54BlNxBoZ9oYhrf3FdISvm1s2Oz6nPiVGy5ywiDs0By6zCwXHBD8tzImzM5Iizlv0giusO
        ocZQ9vmlXtnBPIGv27yPtjAIy/IEgMKPm7exxllbprrNCkPfLmI2lhdm2AHyf4q3vrlzMYfXw/Lxz
        1AmyHO+w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53728)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qR8zU-0005IT-2w;
        Wed, 02 Aug 2023 11:22:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qR8zS-0001e7-QR; Wed, 02 Aug 2023 11:22:02 +0100
Date:   Wed, 2 Aug 2023 11:22:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Bauer <mail@david-bauer.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>,
        Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH v3 1/2] net: phy: at803x: fix the wol setting functions
Message-ID: <ZMouSluMSC+bIi9x@shell.armlinux.org.uk>
References: <20230728215320.31801-1-leoyang.li@nxp.com>
 <20230728215320.31801-2-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728215320.31801-2-leoyang.li@nxp.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 04:53:19PM -0500, Li Yang wrote:
> In commit 7beecaf7d507 ("net: phy: at803x: improve the WOL feature"), it
> seems not correct to use a wol_en bit in a 1588 Control Register which is
> only available on AR8031/AR8033(share the same phy_id) to determine if WoL
> is enabled.  Change it back to use AT803X_INTR_ENABLE_WOL for determining
> the WoL status which is applicable on all chips supporting wol. Also update
> the at803x_set_wol() function to only update the 1588 register on chips
> having it.  After this change, disabling wol at probe from commit
> d7cd5e06c9dd ("net: phy: at803x: disable WOL at probe") is no longer
> needed.  So that part is removed.

Okay, having been through the AR8031, AR8033, and AR8035 datasheets that
I have, this is what I've gathered:

AR8031 and AR8033 are identical as far as WoL is concerned:
	In terms of hardware, these have a WOL_INT pin that is separate
	from the normal interrupt.

	MMD3 0x8012 (1588 register) bit 5 controls whether the WoL
	function is enabled or disabled. Defaults to enabled.

	BMCR in copper/fiber can be used to save more power.

	AR8035 details below also apply.

AR8035:
	No WOL_INT pin.

	No MMD3 0x8012 register.

	WoL interrupt enable in C22 register 0x12 bit 0
	WoL interrupt status in C22 register 0x13 bit 0
	WoL MAC address programmed in MMD3 registers 0x804a (bits 47:32)
	0x804b (bits 31:16) and 0x804c (bits 15:0)

So, what this means is that AR8035, the only possibility for WoL is via
the INT pin and the C22 interrupt enable/status registers.

For AR8031 and AR8033, it depends how the hardware is wired.

If WOL_INT is used to wake the system, then MMD3 0x8012 has to be used to
enable or disable that functionality. From my reading of the datasheets,
WOL_INT is unaffected by the C22 interrupt enable register settings.

If INT is used to wake the system, then it behaves the same as AR8035.
However, the datasheet doesn't make it clear whether MMD3 0x8012 bit 5
also has an effect - although I would lean more towards it having an
effect.

So, given that:

> diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> index c1f307d90518..1d61f7190367 100644
> --- a/drivers/net/phy/at803x.c
> +++ b/drivers/net/phy/at803x.c
> @@ -459,21 +459,27 @@ static int at803x_set_wol(struct phy_device *phydev,
>  			phy_write_mmd(phydev, MDIO_MMD_PCS, offsets[i],
>  				      mac[(i * 2) + 1] | (mac[(i * 2)] << 8));
>  
> -		/* Enable WOL function */
> -		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL,
> -				0, AT803X_WOL_EN);
> -		if (ret)
> -			return ret;
> +		/* Enable WOL function for 1588 */
> +		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> +			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +					     AT803X_PHY_MMD3_WOL_CTRL,
> +					     0, AT803X_WOL_EN);
> +			if (ret)
> +				return ret;
> +		}
>  		/* Enable WOL interrupt */
>  		ret = phy_modify(phydev, AT803X_INTR_ENABLE, 0, AT803X_INTR_ENABLE_WOL);
>  		if (ret)
>  			return ret;
>  	} else {
> -		/* Disable WoL function */
> -		ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL,
> -				AT803X_WOL_EN, 0);
> -		if (ret)
> -			return ret;
> +		/* Disable WoL function for 1588 */
> +		if (phydev->drv->phy_id == ATH8031_PHY_ID) {
> +			ret = phy_modify_mmd(phydev, MDIO_MMD_PCS,
> +					     AT803X_PHY_MMD3_WOL_CTRL,
> +					     AT803X_WOL_EN, 0);
> +			if (ret)
> +				return ret;
> +		}
>  		/* Disable WOL interrupt */
>  		ret = phy_modify(phydev, AT803X_INTR_ENABLE, AT803X_INTR_ENABLE_WOL, 0);
>  		if (ret)
> @@ -508,11 +514,11 @@ static void at803x_get_wol(struct phy_device *phydev,
>  	wol->supported = WAKE_MAGIC;
>  	wol->wolopts = 0;
>  
> -	value = phy_read_mmd(phydev, MDIO_MMD_PCS, AT803X_PHY_MMD3_WOL_CTRL);
> +	value = phy_read(phydev, AT803X_INTR_ENABLE);
>  	if (value < 0)
>  		return;
>  
> -	if (value & AT803X_WOL_EN)
> +	if (value & AT803X_INTR_ENABLE_WOL)
>  		wol->wolopts |= WAKE_MAGIC;
>  }
>  

The above all looks correct to me.

> @@ -858,9 +864,6 @@ static int at803x_probe(struct phy_device *phydev)
>  	if (phydev->drv->phy_id == ATH8031_PHY_ID) {
>  		int ccr = phy_read(phydev, AT803X_REG_CHIP_CONFIG);
>  		int mode_cfg;
> -		struct ethtool_wolinfo wol = {
> -			.wolopts = 0,
> -		};
>  
>  		if (ccr < 0)
>  			return ccr;
> @@ -876,13 +879,6 @@ static int at803x_probe(struct phy_device *phydev)
>  			priv->is_fiber = true;
>  			break;
>  		}
> -
> -		/* Disable WOL by default */
> -		ret = at803x_set_wol(phydev, &wol);
> -		if (ret < 0) {
> -			phydev_err(phydev, "failed to disable WOL on probe: %d\n", ret);
> -			return ret;
> -		}
>  	}
>  
>  	return 0;

This doesn't look correct to me, because in the case of AR8031 or
AR8033 using WOL_INT, because MMD3 0x8012 bit 5 defaults on reset to
being set, if we don't want WoL enabled after the PHY has been probed,
we need to clear it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
