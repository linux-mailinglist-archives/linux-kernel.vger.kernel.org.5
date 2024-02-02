Return-Path: <linux-kernel+bounces-49065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646A846574
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAABB259EC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAE26FBB;
	Fri,  2 Feb 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="c0kNUhLc"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A563AD;
	Fri,  2 Feb 2024 01:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837724; cv=none; b=ueV6xPjUBtp5mynErLLzU5xUQ8DZrwTf6te2RJfMGuz5FEEc34ogFoLl+mdLBsHci1uPtRWbPiuK2qIYoOGQ10cwxjo0OQVnVtvRqC/NZKNVG4igecOdHHuQZtzzDB89poyrUD0sYcP4eL649c9DJADBZi6ePjpWoid5x6vShsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837724; c=relaxed/simple;
	bh=byn2POXh2oOuWy72oilG/vfGimtqV+4BabC/M/lIcF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB18LSRTj0sMKRUZfglAPFzx1kYd0b7XruvS8YdalYWtQBFDtZBwE47RzM1K4tiafImtTzDyfuVtrJxSDPUAEBAz8u/j8eG3o1Gk8WjgIbNDZ3Mpa185+wMIdFkEDQl+HNKkdGeAwm06IAKvJt4YS9+41pxp8uxNyCdA8333SCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=c0kNUhLc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D1Zk9eHb/+VoL10gbkI+Wk7ITnBQURZGS/tiJLappS4=; b=c0kNUhLcPT6EjXrjJCWLtufBdz
	DyfPuatxs06fFMN9zRmii+2p/tgmnS0nqfKXaE5LBI5uVaJOjmM3yPmtUCeWgZPV8EENHRM+D8CcX
	Y2AZ3NJTzcRKuAfuOWihWMvKPuF9KYsNGVYE0uOaWJTVcK3CsL4oTSYufzqrSDQgIQ4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rViSV-006jj6-Ss; Fri, 02 Feb 2024 02:35:11 +0100
Date: Fri, 2 Feb 2024 02:35:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Rowand <frowand.list@gmail.com>,
	Robert Marko <robert.marko@sartura.hr>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH v5 7/9] net: phy: qcom: add support for QCA807x
 PHY Family
Message-ID: <a530f40c-b8fd-4da1-b4df-f80ab05f0394@lunn.ch>
References: <20240201151747.7524-1-ansuelsmth@gmail.com>
 <20240201151747.7524-8-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201151747.7524-8-ansuelsmth@gmail.com>

> +static int qca807x_read_fiber_status(struct phy_device *phydev)
> +{
> +	int ss, err, lpa, old_link = phydev->link;
> +
> +	/* Update the link, but return if there was an error */
> +	err = genphy_update_link(phydev);
> +	if (err)
> +		return err;
> +
> +	/* why bother the PHY if nothing can have changed */
> +	if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
> +		return 0;
> +
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;
> +
> +	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
> +		lpa = phy_read(phydev, MII_LPA);
> +		if (lpa < 0)
> +			return lpa;
> +
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> +				 phydev->lp_advertising, lpa & LPA_LPACK);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
> +				 phydev->lp_advertising, lpa & LPA_1000XFULL);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
> +				 phydev->lp_advertising, lpa & LPA_1000XPAUSE);
> +		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
> +				 phydev->lp_advertising,
> +				 lpa & LPA_1000XPAUSE_ASYM);
> +
> +		phy_resolve_aneg_linkmode(phydev);
> +	}

This looks a lot like genphy_c37_read_status(). Can it be used?

> +
> +	/* Read the QCA807x PHY-Specific Status register fiber page,
> +	 * which indicates the speed and duplex that the PHY is actually
> +	 * using, irrespective of whether we are in autoneg mode or not.
> +	 */
> +	ss = phy_read(phydev, AT803X_SPECIFIC_STATUS);
> +	if (ss < 0)
> +		return ss;
> +
> +	if (ss & AT803X_SS_SPEED_DUPLEX_RESOLVED) {
> +		switch (FIELD_GET(AT803X_SS_SPEED_MASK, ss)) {
> +		case AT803X_SS_SPEED_100:
> +			phydev->speed = SPEED_100;
> +			break;
> +		case AT803X_SS_SPEED_1000:
> +			phydev->speed = SPEED_1000;
> +			break;
> +		}
> +
> +		if (ss & AT803X_SS_DUPLEX)
> +			phydev->duplex = DUPLEX_FULL;
> +		else
> +			phydev->duplex = DUPLEX_HALF;
> +	}
> +
> +	return 0;
> +}


> +static int qca807x_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct phy_package_shared *shared = phydev->shared;
> +	struct qca807x_shared_priv *priv = shared->priv;
> +	unsigned int tx_driver_strength = 0;
> +	const char *package_mode_name;
> +
> +	of_property_read_u32(shared->np, "qcom,tx-driver-strength",
> +			     &tx_driver_strength);
> +	switch (tx_driver_strength) {
> +	case 140:
> +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_140MV;
> +		break;
> +	case 160:
> +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_160MV;
> +		break;
> +	case 180:
> +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_180MV;
> +		break;
> +	case 200:

..

> +	case 500:
> +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_500MV;
> +		break;
> +	case 600:
> +	default:

If its missing default to 600. But if its an invalid value, return
-EINVAL.

> +		priv->tx_driver_strength = PQSGMII_TX_DRIVER_600MV;
> +	}
> +
> +	priv->package_mode = PHY_INTERFACE_MODE_NA;
> +	if (!of_property_read_string(shared->np, "qcom,package-mode",
> +				     &package_mode_name)) {
> +		if (!strcasecmp(package_mode_name,
> +				phy_modes(PHY_INTERFACE_MODE_PSGMII)))
> +			priv->package_mode = PHY_INTERFACE_MODE_PSGMII;
> +
> +		if (!strcasecmp(package_mode_name,
> +				phy_modes(PHY_INTERFACE_MODE_QSGMII)))
> +			priv->package_mode = PHY_INTERFACE_MODE_QSGMII;

Again, return -EINVAL if it is neither.

> +static int qca807x_phy_package_config_init_once(struct phy_device *phydev)
> +{
> +	struct phy_package_shared *shared = phydev->shared;
> +	struct qca807x_shared_priv *priv = shared->priv;
> +	int val, ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	/* Set correct PHY package mode */
> +	val = __phy_package_read(phydev, QCA807X_COMBO_ADDR,
> +				 QCA807X_CHIP_CONFIGURATION);
> +	val &= ~QCA807X_CHIP_CONFIGURATION_MODE_CFG_MASK;
> +	if (priv->package_mode == PHY_INTERFACE_MODE_QSGMII)
> +		val |= QCA807X_CHIP_CONFIGURATION_MODE_QSGMII_SGMII;
> +	else
> +		val |= QCA807X_CHIP_CONFIGURATION_MODE_PSGMII_ALL_COPPER;

What about priv->package_mode == PHY_INTERFACE_MODE_NA;

     Andrew

