Return-Path: <linux-kernel+bounces-18015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079B7825730
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2615CB2355B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822902E824;
	Fri,  5 Jan 2024 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EgTCbj7n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954232E634;
	Fri,  5 Jan 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D2A61C0003;
	Fri,  5 Jan 2024 15:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704470006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2g80y/5MAB47CRr2+a6WSVdW/+13sNXPjnzgr6k2OQw=;
	b=EgTCbj7n3pDZeCmRS8rzp6gpHWce/IvZbRd5r6tCGGYSNrGwZBgsWkC3l/IreGV6fNhJmV
	IpuLzJi0p8sITMce+O3dEE2lGSk1cwsr2nD3UDWjF6qp5EytRban2Mcn6EaWzGICTUyCo2
	symVy7+qUi5+9SBBokGLwZY0OjX4e5A/9pDZHFBZnnIbZsjjvF2fqVE0vlXgLY306A7UI3
	G5tfLwcvTgKrf6DETSwHokVmOqLOpjeuTJ1AngYaJiTQOvb2Nldowyk+/xLAxXFP8ARnRo
	D4zQZavWUGGk59kbSvcoL6m6KcwVgGcAvPIDNSiio587SP6MMR3b31zQkhxeow==
Date: Fri, 5 Jan 2024 16:53:23 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Claudiu
 <claudiu.beznea@tuxon.dev>, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yuiko.oshino@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH net] net: phy: micrel: populate .soft_reset for KSZ9131
Message-ID: <20240105165323.1105ecaf@device-28.home>
In-Reply-To: <a2651f98-b598-4a05-9e05-d2912eeb55d2@lunn.ch>
References: <20240105085242.1471050-1-claudiu.beznea.uj@bp.renesas.com>
	<ZZfPOky2p/ZJMKCQ@shell.armlinux.org.uk>
	<a2651f98-b598-4a05-9e05-d2912eeb55d2@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 5 Jan 2024 15:36:29 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Jan 05, 2024 at 09:43:22AM +0000, Russell King (Oracle) wrote:
> > On Fri, Jan 05, 2024 at 10:52:42AM +0200, Claudiu wrote:  
> > > The order of PHY-related operations in ravb_open() is as follows:
> > > ravb_open() ->
> > >   ravb_phy_start() ->
> > >     ravb_phy_init() ->
> > >       of_phy_connect() ->
> > >         phy_connect_direct() ->
> > > 	  phy_attach_direct() ->
> > > 	    phy_init_hw() ->
> > > 	      phydev->drv->soft_reset()
> > > 	      phydev->drv->config_init()
> > > 	      phydev->drv->config_intr()
> > > 	    phy_resume()
> > > 	      kszphy_resume()
> > > 
> > > The order of PHY-related operations in ravb_close is as follows:
> > > ravb_close() ->
> > >   phy_stop() ->
> > >     phy_suspend() ->
> > >       kszphy_suspend() ->
> > >         genphy_suspend()
> > > 	  // set BMCR_PDOWN bit in MII_BMCR  
> > 
> > Andrew,
> > 
> > This looks wrong to me - shouldn't we be resuming the PHY before
> > attempting to configure it?  
> 
> Hummm. The opposite of phy_stop() is phy_start(). So it would be the
> logical order to perform the resume as the first action of
> phy_start(), not phy_attach_direct().
> 
> In phy_connect_direct(), we don't need the PHY to be operational
> yet. That happens with phy_start().
> 
> The standard says:
> 
>   22.2.4.1.5 Power down
> 
>   The PHY may be placed in a low-power consumption state by setting
>   bit 0.11 to a logic one. Clearing bit 0.11 to zero allows normal
>   operation. The specific behavior of a PHY in the power-down state is
>   implementation specific. While in the power-down state, the PHY
>   shall respond to management transactions.
> 
> So i would say this PHY is broken, its not responding to all
> management transactions. So in that respect, Claudiu fix is correct.
> 
> But i also somewhat agree with you, this looks wrong, but in a
> different way to how you see it. However, moving the phy_resume() to
> phy_start() seems a bit risky. So i'm not sure we should actually do
> that.

Looking at other PHYs similar to it like the 9031, the .soft_reset()
was added to fix some similar issues :

Issue :
https://lore.kernel.org/netdev/a63ca542-db96-40ed-201d-59c609f565ce@gmail.com/

Fix :
https://lore.kernel.org/netdev/6d3b1dce-7633-51a1-0556-97cd03304c2c@gmail.com/

We couldn't get a proper explanation back then. Could it be that they
suffer from the same problem, but that it was more clearly documented
for the 9131 ?

Maxime

