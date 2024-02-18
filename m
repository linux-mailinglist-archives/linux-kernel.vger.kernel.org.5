Return-Path: <linux-kernel+bounces-70598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916F28599AB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0D2281692
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B533876035;
	Sun, 18 Feb 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="A4qtgmbz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9374297;
	Sun, 18 Feb 2024 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294047; cv=none; b=MVUoMaR6nlDVLQ0LwBzWxjpdjzlj9q3anCc5wMxH15mzOiRJDviNpghCeFjTwi8l2Cbhm6eTQIe7BF9Nzq4bYW4xQT1gTBzQSzqhyOqzmzUapvCD+PdBrVlVON3tswLIh1QvxNawbCsLU+X9al8sG8W5l9Ge8t6iE7//9B2dgNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294047; c=relaxed/simple;
	bh=e0yWxLc3AYNv/5zFp3fPm6gjPgJpcMpeFj9+grm07MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOGZH284DD43dxah3r8lb28BQRA+eT+gO2zvvnkf9SyvZ5ssQtzKFBQZlwPJ/XWU22il5y3eWF+tcdnwBlteT+1vc7u1tqRzoPhxBSRlXQfmjunTOOBtDeuDbYAWgyfEujBUV8HgLt+K2gjpEeFMXqnGytYXf7JFu6FP299JQtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=A4qtgmbz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NadklAa6Tnip8w2TUfxFFu3aktzUd6Kx6TcCLDek8NE=; b=A4qtgmbzFk7aBDbe/5E1HGAoLz
	+VhQCph3UweeUHCROTXnLDt1OCD543Lw8LyR/FEpU8ocfQMox+OFHPxZZH2PZE3lh1/dEFxjfNl78
	beRrqUd3jBgZvenJ8ekSn3vqA/9RNKWM67KhmRyceOr8PrlDbOmTD6l4pUQD178cUocM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbpJU-00893B-FH; Sun, 18 Feb 2024 23:07:08 +0100
Date: Sun, 18 Feb 2024 23:07:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 1/6] net: phy: add support for defining
 multiple PHY IDs in PHY driver
Message-ID: <5233847b-a94b-4cd2-b976-232755f209d5@lunn.ch>
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-2-ansuelsmth@gmail.com>
 <ZdJbciylnw8+ve8V@shell.armlinux.org.uk>
 <65d2613d.170a0220.2eb48.a510@mx.google.com>
 <829f8c7d-c09b-4264-818a-3f7b047ec44f@lunn.ch>
 <65d2682a.5d0a0220.3fef2.efe4@mx.google.com>
 <ZdJpyGkFRiRufySw@shell.armlinux.org.uk>
 <65d26c13.df0a0220.63f42.d8e6@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d26c13.df0a0220.63f42.d8e6@mx.google.com>

> With the allocated mdio_devic_id it would result in this snipped
> 
> 	const struct mdio_device_id *driver_dev_id;
> 	struct mdio_device_id *dev_id;
> 	int err = 0;
> 
> 	phydev->drv = phydrv;
> 	/* Fill the mdio_device_id for the PHY istance.
> 	 * If PHY driver provide an array of PHYs, search the right one,
> 	 * in the other case fill it with the phy_driver data.
> 	 */
> 	if (phy_driver_match(phydrv, phydev, &driver_dev_id) && driver_dev_id) {
> 		/* If defined, overwrite the PHY driver dev name with a
> 		 * more specific one from the matching dev_id.
> 		 */
> 		phydev->dev_id = driver_dev_id;
> 		if (driver_dev_id->name)
> 			drv->name = driver_dev_id->name;

What is drv here? You should not be changing the name within the
driver structure, since that is shared by a number of devices.

       Andrew

