Return-Path: <linux-kernel+bounces-89204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81786EBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EABC41F2538A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B97D5EE6C;
	Fri,  1 Mar 2024 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5hnCEe7J"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4FE58AA2;
	Fri,  1 Mar 2024 22:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332725; cv=none; b=u00/ACCAWAI1ux9QIwttASM/pnuqq+FqDKGeVRdoOgmHPR18jC7J11doudQw6mR+X2YftmoajJlrZ6pnseJW3XZPfhWVzhVagRAOHhHFiB+pQrfhuloI6drEFUXO+549w+Dq6Qtcth/pjN7qx7Uiz9poIBsJhtPP7nBT0D2NaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332725; c=relaxed/simple;
	bh=C9fObou1QGzt4uneeySbp7ggNXccPusKJQusLbBhhqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO6ius2D6Oj0EkvHyIEkeqj1a3GEORJUgv9Jq51xuqMGBRCVwhzehEXmmiXmMZmTL+ZyKZplKCpumzsCoGPY10UuNH9Tfion4ukqMa4HOhSQmhrXBF0zrOIM/5H8WNlInOWPqywQ7SwKYjg5c+ew2d822V8FkzQm6yoed6zdSmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5hnCEe7J; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aMBepLHt9KOhTSKMxp2ZxKrSNDdYzAaav19hviKd2ZM=; b=5hnCEe7Jji8OQXYRKU/4Ea439+
	Di/8AOpweoRL8bL/alOpkLjpeyzVmkiqmWCgpjKZpvYiZVvcuTgnvtS1R5EK/EagR76WHJa1KLIon
	RpNh5NKPO3r6fDeAB79pbCLYL2qvWOZLq06SAWacPCdYsmA23u3tm+xh+INa5n2PExjA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rgBWm-009B3c-Ip; Fri, 01 Mar 2024 23:38:52 +0100
Date: Fri, 1 Mar 2024 23:38:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v8 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <8cafe975-e898-4f6a-9389-0a655d6dae22@lunn.ch>
References: <20240301100153.927743-1-o.rempel@pengutronix.de>
 <20240301100153.927743-6-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301100153.927743-6-o.rempel@pengutronix.de>

On Fri, Mar 01, 2024 at 11:01:50AM +0100, Oleksij Rempel wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> The MAC driver changes its EEE hardware configuration in its
> adjust_link callback. This is called when auto-neg
> completes. Disabling EEE via eee_enabled false will trigger an
> autoneg, and as a result the adjust_link callback will be called with
> phydev->enable_tx_lpi set to false. Similarly, eee_enabled set to true
> and with a change of advertised link modes will result in a new
> autoneg, and a call the adjust_link call.
> 
> If set_eee is called with only a change to tx_lpi_enabled which does
> not trigger an auto-neg, it is necessary to call the adjust_link
> callback so that the MAC is reconfigured to take this change into
> account.
> 
> When setting phydev->enable_tx_lpi, take both eee_enabled and
> tx_lpi_enabled into account, so the MAC drivers just needs to act on
> phydev->enable_tx_lpi and not the whole EEE configuration.
> The same check should be done for tx_lpi_timer too.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

> +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> +				      struct ethtool_keee *data)
> +{
> +	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
> +	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
> +		eee_to_eeecfg(data, &phydev->eee_cfg);
> +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> +		if (phydev->link) {
> +			phydev->link = false;
> +			phy_link_down(phydev);
> +			phydev->link = true;
> +			phy_link_up(phydev);
> +		}
> +	}
> +}
> +

Thanks

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

