Return-Path: <linux-kernel+bounces-21406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 173AF828EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A193C28849C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0C13D99F;
	Tue,  9 Jan 2024 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="co1IF7FL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610633DB80;
	Tue,  9 Jan 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uUMg5TD5JrrVZUCVQclU7k/tLZTcoCPXga7lbuCsQMU=; b=co1IF7FLKVCpJqUCQqUR5EB/qv
	YXkGqpWrEBBfsI3LH5+1v17HBgHPMBD6whq8nE2IpEn7lLNShbguPyYueTMOezGhkqQEtreRfB+aZ
	dTAJFqShuO0G+i37mmcvvRSu4zvSe5UyoyAQz1/2oARsR0Aa0XtUOXJhhuA13kTy+zhI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rNJGm-004rs1-2U; Tue, 09 Jan 2024 22:04:20 +0100
Date: Tue, 9 Jan 2024 22:04:20 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <d9e86b0b-22cd-4055-90e1-44083ffbc05c@lunn.ch>
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>

> +static int ksz9x31_resume(struct phy_device *phydev)
> +{
> +	phy_device_reset(phydev, 1);
> +	phy_device_reset(phydev, 0);
> +
> +	return kszphy_resume(phydev);
> +}
> +
>  static int kszphy_probe(struct phy_device *phydev)
>  {
>  	const struct kszphy_type *type = phydev->drv->driver_data;
> @@ -4778,7 +4786,7 @@ static struct phy_driver ksphy_driver[] = {
>  	.get_strings	= kszphy_get_strings,
>  	.get_stats	= kszphy_get_stats,
>  	.suspend	= kszphy_suspend,
> -	.resume		= kszphy_resume,
> +	.resume		= ksz9x31_resume,

Humm, i'm not so sure about this.

phy_resume() is called by mdio_bus_phy_resume(). That first does a
call to phy_init_hw(), which will perform a soft reset on the PHY,
call the drivers config_init() callback, and the config_intr()
callback. Then it calls phy_resume().

Does phy_resume() hitting it with a reset clear out the configuration
done by config_init() and the interrupt configuration performed by
config_intr()?

	Andrew

