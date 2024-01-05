Return-Path: <linux-kernel+bounces-17940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E6825570
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E965284B63
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3942DF91;
	Fri,  5 Jan 2024 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BJufwjuX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D132D7B0;
	Fri,  5 Jan 2024 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=izopWTWvdqzt1HzQ9a3B+UE3STlG/reta5QRNgEBykU=; b=BJufwjuXkd2K8Y6wocFOxdsPKC
	csMjMCug1ybY6/Lmv51EdvEHQ1myeL+3dCo1ucFwPgtxsGkkN8TU1vmwtJX3nyTobXRVTNfNzSFDl
	gtg6OMpPktlAJW4DUAdjbAX3Ru52VkA69gsBRTlc3pjWwAXbqya90BeEAg291X4/m3pc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLlJF-004Seu-Dj; Fri, 05 Jan 2024 15:36:29 +0100
Date: Fri, 5 Jan 2024 15:36:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, yuiko.oshino@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
Message-ID: <a2651f98-b598-4a05-9e05-d2912eeb55d2@lunn.ch>
References: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
 <ZZfPOky2p/ZJMKCQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZfPOky2p/ZJMKCQ@shell.armlinux.org.uk>

On Fri, Jan 05, 2024 at 09:43:22AM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 05, 2024 at 10:52:42AM +0200, Claudiu wrote:
> > The order of PHY-related operations in ravb_open() is as follows:
> > ravb_open() ->
> >   ravb_phy_start() ->
> >     ravb_phy_init() ->
> >       of_phy_connect() ->
> >         phy_connect_direct() ->
> > 	  phy_attach_direct() ->
> > 	    phy_init_hw() ->
> > 	      phydev->drv->soft_reset()
> > 	      phydev->drv->config_init()
> > 	      phydev->drv->config_intr()
> > 	    phy_resume()
> > 	      kszphy_resume()
> > 
> > The order of PHY-related operations in ravb_close is as follows:
> > ravb_close() ->
> >   phy_stop() ->
> >     phy_suspend() ->
> >       kszphy_suspend() ->
> >         genphy_suspend()
> > 	  // set BMCR_PDOWN bit in MII_BMCR
> 
> Andrew,
> 
> This looks wrong to me - shouldn't we be resuming the PHY before
> attempting to configure it?

Hummm. The opposite of phy_stop() is phy_start(). So it would be the
logical order to perform the resume as the first action of
phy_start(), not phy_attach_direct().

In phy_connect_direct(), we don't need the PHY to be operational
yet. That happens with phy_start().

The standard says:

  22.2.4.1.5 Power down

  The PHY may be placed in a low-power consumption state by setting
  bit 0.11 to a logic one. Clearing bit 0.11 to zero allows normal
  operation. The specific behavior of a PHY in the power-down state is
  implementation specific. While in the power-down state, the PHY
  shall respond to management transactions.

So i would say this PHY is broken, its not responding to all
management transactions. So in that respect, Claudiu fix is correct.

But i also somewhat agree with you, this looks wrong, but in a
different way to how you see it. However, moving the phy_resume() to
phy_start() seems a bit risky. So i'm not sure we should actually do
that.

	Andrew

