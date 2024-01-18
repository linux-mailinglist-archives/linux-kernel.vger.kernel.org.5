Return-Path: <linux-kernel+bounces-30547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2355E832045
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BE4B23D92
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254662E641;
	Thu, 18 Jan 2024 20:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xqTtGfaJ"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD22E820;
	Thu, 18 Jan 2024 20:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705608568; cv=none; b=QqfffUSOs9nkiXmaXeMN9fu7JdHp5dWyZBmSM/RNzWOk2hFjrtgxXW11PveuvMjaC60UE0NV0U28yGM7xm/BqXDYcHrcBFx2tgeQlXmg5v7m4+yDjmEHDW+jKNonfKX/d9zszbF2OsSatwZ40SkARDdCLPk2QP+e7U36tLVGesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705608568; c=relaxed/simple;
	bh=+1BBAmhjPr21bsmB0fbG6/lTejPku0zieqaCETcpZqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjItywnXH3Y5yNIIwJhohWnHmE1Z4VtJn954HKNaaY//Q1OovN9vzHHtWw8mdys1zukwmJ4ugzd0kGFE7ldJwm+zEWB8KV0qbCN7FcZG+Y61bq11rMXk0nmeh/ior489HgUyiMdEkduiP3soKmfNPlmivecNRHnpewWB7Hkw43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xqTtGfaJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0oxztr42FkjOzBi9aAnhLgr6FBfDil+TPxe0I/CkkSI=; b=xqTtGfaJv5Ieq5SM02K26en2n4
	GKLn0wi8mP3Au/l5kQCJsfS76l8A2gPDxHmNgCktbyW9jhp73+zxRPHhp8N/TI/JE6Z6vlusiLJex
	biODChGpk/ruC1X2ATRUo6fp6KTamezypQnW9wdCoogiAy6EB5cn0Ln5peFbHA3Bqllg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rQYhK-005VJS-W8; Thu, 18 Jan 2024 21:09:11 +0100
Date: Thu, 18 Jan 2024 21:09:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andre Werner <andre.werner@systec-electronic.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: adin1100: Fix nullptr exception for phy
 interrupts
Message-ID: <4e30f871-c7b7-4dc5-ba4c-629a63dc3261@lunn.ch>
References: <20240118104341.10832-1-andre.werner@systec-electronic.com>
 <322d5543-4d13-48a7-af58-daa8cc840f05@lunn.ch>
 <727d83ab-3315-4b5c-84da-25f8ffd6aca5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727d83ab-3315-4b5c-84da-25f8ffd6aca5@gmail.com>

On Thu, Jan 18, 2024 at 06:36:16PM +0100, Heiner Kallweit wrote:
> On 18.01.2024 17:53, Andrew Lunn wrote:
> > On Thu, Jan 18, 2024 at 11:43:41AM +0100, Andre Werner wrote:
> >> If using ADIN1100 as an external phy, e.g. in combination with
> >> "smsc95xx", we ran into nullptr exception by creating a link.
> >>
> >> In our case the "smsc95xx" does not check for an available interrupt handler
> >> on external phy driver to use poll instead of interrupts if no handler is
> >> available. So we decide to implement a small handler in the phy driver
> >> to support other MACs as well.
> >>
> >> I update the driver to add an interrupt handler because libphy
> >> does not check if their is a interrupt handler available either.
> >>
> >> There are several interrupts maskable at the phy, but only link change interrupts
> >> are handled by the driver yet.
> >>
> >> We tested the combination "smsc95xx" and "adin1100" with Linux Kernel 6.6.9
> >> and Linux Kernel 6.1.0, respectively.
> > 
> > Hi Andre
> > 
> > A few different things....
> > 
> > Please could you give more details of the null pointer
> > exception. phylib should test if the needed methods have been
> > implemented in the PHY driver, and not tried to use interrupts when
> > they are missing. It should of polled the PHY. So i would like to
> > understand what went wrong. Maybe we have a phylib core bug we should
> > be fixing. Or a bug in the smsc95xx driver.
> > 
> Seems to be a bug in smsc95xx. The following is the relevant code piece.
> 
> ret = mdiobus_register(pdata->mdiobus);
> 	if (ret) {
> 		netdev_err(dev->net, "Could not register MDIO bus\n");
> 		goto free_mdio;
> 	}
> 
> 	pdata->phydev = phy_find_first(pdata->mdiobus);
> 	if (!pdata->phydev) {
> 		netdev_err(dev->net, "no PHY found\n");
> 		ret = -ENODEV;
> 		goto unregister_mdio;
> 	}
> 
> 	pdata->phydev->irq = phy_irq;
> 
> The interrupt is set too late, after phy_probe(), where we have this:
> 
> if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
> 		phydev->irq = PHY_POLL;
> 
> So we would have two steps:
> 1. Fix the smsc95xx bug (as the same issue could occur with another PHY type)

Its not so nice to fix.

Normally you would do something like:

        pdata->mdiobus->priv = dev;
        pdata->mdiobus->read = smsc95xx_mdiobus_read;
        pdata->mdiobus->write = smsc95xx_mdiobus_write;
        pdata->mdiobus->reset = smsc95xx_mdiobus_reset;
        pdata->mdiobus->name = "smsc95xx-mdiobus";
        pdata->mdiobus->parent = &dev->udev->dev;

        snprintf(pdata->mdiobus->id, ARRAY_SIZE(pdata->mdiobus->id),
                 "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);

	pdata->mdiobus->irq[X] = phy_irq;

	ret = mdiobus_register(pdata->mdiobus);

By setting pdata->mdiobus->irq[X] before registering the PHY, the irq
number gets passed to the phydev->irq very early on. If everything is
O.K, interrupts are then used.

However, because of the use of phy_find_first(), we have no idea what
address on the bus the PHY is using. So we don't know which member of
irq[] to set. Its not ideal, but one solution is to set them all.

However, a better solution is to perform the validation again in
phy_attach_direct(). Add a second:

	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
        	phydev->irq = PHY_POLL;

which will force phydev->irq back to polling.

      Andrew

