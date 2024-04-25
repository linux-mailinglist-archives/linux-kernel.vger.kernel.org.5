Return-Path: <linux-kernel+bounces-158819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0DC8B254C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20A31F23760
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5041B14BF89;
	Thu, 25 Apr 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="B/tLuWPl"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2781184D2D;
	Thu, 25 Apr 2024 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059475; cv=none; b=uELu/YQhykgLbU7hk1q6Q+6n9N5852ufpxIoShhTwQ+oVTB/o3jXe1fBcx0KQya8Hg8bG5dO0ERsdy2a7inhrOPYFGQ0KQvrXglDzFo/i3XWqiBIevnTkUQSYTWgika2sryJ1OafZ1udjrFeTq+EmCFwYllC41grgYDuJJyjau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059475; c=relaxed/simple;
	bh=TQ/IMaQSQUBfEjQdb7XmGSR/6+c5RT7iuARKdBoCyR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdCn2urSFcPjlSG9vXfQebeoFqgCVSDdS7FUjAaz06GnyhR5cmTiLoCH+IaUVAXt2Ce3xGPtNWAVpbqK1271VoX4g9IqTmntKI8nDf+MdQ4PcAP9WgqAw3yr6grWrBeMf3+Zw8ssLtntqbHJl6eb+7xNzyaGaBGMLVzQiJSavgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=B/tLuWPl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+nXxaAUOW4lfzHbDCaI6nz0stAky/8ykgKzIVjuNI0U=; b=B/tLuWPlOLDKNO1iW2Ezj29OUk
	WTMG4duEi+g4B0typzSnuggrUlh9x2pZTGhPfKXGUUvCXYLFgH5IMK3cqlerAJgQfMVh3iKFJFkr0
	KDEF6viTCHIuWiU3GplSzav2mpfHD229evx7m2eAWN6lKdeCEvHS/Q0NGqqEuJDCut40=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s01AM-00Dzys-Pb; Thu, 25 Apr 2024 17:37:42 +0200
Date: Thu, 25 Apr 2024 17:37:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH 3/3] net: phy: mediatek: add support for built-in 2.5G
 ethernet PHY on MT7988
Message-ID: <9241a551-1547-41c6-aae2-54dd45e49c2f@lunn.ch>
References: <20240425023325.15586-1-SkyLake.Huang@mediatek.com>
 <20240425023325.15586-4-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425023325.15586-4-SkyLake.Huang@mediatek.com>

> +static int mt7988_2p5ge_phy_config_init(struct phy_device *phydev)
> +{
> +	int ret, i;
> +	const struct firmware *fw;
> +	struct device *dev = &phydev->mdio.dev;
> +	struct device_node *np;
> +	void __iomem *pmb_addr;
> +	void __iomem *md32_en_cfg_base;
> +	struct mtk_i2p5ge_phy_priv *priv = phydev->priv;
> +	u16 reg;
> +	struct pinctrl *pinctrl;

Reverse Christmas Tree please.

> +static int mt7988_2p5ge_phy_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	u32 adv;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		/* Configure half duplex with genphy_setup_forced,
> +		 * because genphy_c45_pma_setup_forced does not support.
> +		 */

The English in that comment is wrong.

Ah, it appears to be a copy/paste, e.g. from mxl-gpy.c. In fact, a lot
of this function is identical to gpy_config_aneg(). Maybe it should be
pulled out into a helper.

> +static int mt7988_2p5ge_phy_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +
> +	/* We don't support HDX at MAC layer on mt7988.
> +	 * So mask phy's HDX capabilities, too.
> +	 */

This comment seems to contradict the comment above? 

Also, this code does not mask anything, it sets bits.  What does
genphy_read_abilities() find out about the device? If the hardware
confirms to the standard, it should not indicate is supports 1/2
duplex, genphy_read_abilities() should then not return those link
modes, but it should return 10, 100 and 1000 full duplex.

> +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);

What does genphy_c45_pma_read_abilities() report about the device?

> +static int mt7988_2p5ge_phy_read_status(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE) {
> +		if (phydev->autoneg_complete) {
> +			ret = genphy_c45_read_lpa(phydev);
> +			if (ret < 0)
> +				return ret;
> +
> +			/* Read the link partner's 1G advertisement */
> +			ret = phy_read(phydev, MII_STAT1000);
> +			if (ret < 0)
> +				return ret;
> +			mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, ret);

> +		} else if (!linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +					      phydev->advertising) &&
> +			   linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +					     phydev->advertising)) {
> +			extend_an_new_lp_cnt_limit(phydev);
> +		}

A comment about what is happening here would be good.

> +	} else if (phydev->autoneg == AUTONEG_DISABLE) {
> +		linkmode_zero(phydev->lp_advertising);
> +	}

This if does not make much sense.

> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_LINK_STATUS_MISC);
> +	if (ret < 0)
> +		return ret;
> +	phydev->duplex = (ret & MTK_PHY_FDX_ENABLE) ? DUPLEX_FULL : DUPLEX_HALF;

Do does it support half duplex or not?

   Andrew

