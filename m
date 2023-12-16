Return-Path: <linux-kernel+bounces-2283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687A815A80
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E9B1C21994
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCABC30665;
	Sat, 16 Dec 2023 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ig4ekl2q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DE331599;
	Sat, 16 Dec 2023 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6J11fscbEWXi5PX4jfQdLlfFWK8+/piBgfKVLqJg8Ik=; b=Ig4ekl2qBEfEFncaQF1mhEZ82Q
	3ka07tPwQqffUtZ9ekd7rAMAjRN4x1QlklEEDxsAY4E5LnI7im3yqtxuTEvYRlJj1rkLvEM/mnRZ/
	Axr8XWiMDIzaQavibI/qU9nQ4eQL/WOi4qX1Lndg71ZDXjwYnNdHRc3HpYSEeJMJMN50=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEXo8-0036oV-OC; Sat, 16 Dec 2023 17:46:32 +0100
Date: Sat, 16 Dec 2023 17:46:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215213102.35994-1-dima.fedrau@gmail.com>

> +static int mv88q222x_config_aneg_gbit(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* send_s detection threshold, slave and master */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xa28);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xc28);
> +	if (ret < 0)
> +		return ret;

Same register with two different values?

There are a lot of magic values here. Does the datasheet names these
registers? Does it define the bits? Adding #defines would be good.

> +static int mv88q222x_config_aneg_preinit(struct phy_device *phydev)
> +{
> +	int ret, val, i;
> +
> +	/* Enable txdac */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0x8033, 0x6801);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Disable ANEG */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_T1_CTRL, 0x0);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set IEEE power down */
> +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x840);

0x800 is MDIO_CTRL1_LPOWER. What is the other? It seems like a speed
selection bit?

	  Andrew

