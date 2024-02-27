Return-Path: <linux-kernel+bounces-83573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35E5869C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B296B3065D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CC31482FC;
	Tue, 27 Feb 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SR+lYKpz"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A931F14533F;
	Tue, 27 Feb 2024 16:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050333; cv=none; b=G5ZI9Pxc8hWkFpsdDHJZ5a3kZhvxWciZii+NbRYv5D/pg8QwYdjPW6jekys8NHHu58UqGnZK3jOe5Yg8SSgFnD7JhD6/efca8+uLeymbNEFy0aSspRuLJcRXcRkJ5jfGiXvbku30wgKB9jWiC4od+Zx1cAJdXMYEqu3Khs3fo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050333; c=relaxed/simple;
	bh=19neBC5EubG6CbCXy05obvW+BJGJ9FEAr9hCMDGwxUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl1QeAyam4eaQzQNNYuyu4CRcEwrm68mx8Fi9enN3SlBD41aBq1+/2Q9HiVegjX91GTMvdMRDu6GA8PuLaypv6Yb1e3I0Agvkpx05tViuMFoU6SnL+6ydcekkJA64ohcXP9oby6IcJrs/zyDBq9V/1MMYD+7sqbr3GqPy4ZhWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SR+lYKpz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JOoRwSmiX4D2HjFfMhasejwRBKICagkGvcW1hfqPDeg=; b=SR+lYKpzMzfnHjFr6ZK8w1hN5I
	lK42n7hCpMubD5Q3ThZUr9EZ2ENNz3bUYw7iZnPWP2b8rZTw3DRcjVLsOnYm3fbz24oX9R5ligiy+
	5MzUFjRtEsU0mswqFrhXv2/eNphoJWszK14STiGGffTJg8BotbsfU7V+dCy6K3DUBv6U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rf046-008rtK-Mh; Tue, 27 Feb 2024 17:12:22 +0100
Date: Tue, 27 Feb 2024 17:12:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>,
	linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <8d48af5b-e92b-431c-9bc0-ce6ef0e0ab2e@lunn.ch>
References: <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
 <Zdot-Mqw1z4ZEo8v@pengutronix.de>
 <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
 <e679f467-d4cd-4a1e-9bfc-92e2c9bf35d4@broadcom.com>
 <ZdzQG6t2slqEyH0m@shell.armlinux.org.uk>
 <fe071598-64eb-4dd2-8926-d4d0954e7e7e@lunn.ch>
 <Zd10qUJzq-2nG7b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd10qUJzq-2nG7b7@pengutronix.de>

On Tue, Feb 27, 2024 at 06:35:38AM +0100, Oleksij Rempel wrote:
> On Mon, Feb 26, 2024 at 07:59:28PM +0100, Andrew Lunn wrote:
> > On Mon, Feb 26, 2024 at 05:53:31PM +0000, Russell King (Oracle) wrote:
> > > On Mon, Feb 26, 2024 at 09:50:02AM -0800, Florian Fainelli wrote:
> > > > This is the source of the concern, we don't know which MAC drivers we might
> > > > end-up breaking by calling adjust_link(link == 1) twice in a row, hopefully
> > > > none, because they should be well written to only update the parameters that
> > > > need updating, but who knows?
> > > 
> > > Just quickly... There are some (I went through a bunch.) They don't
> > > support EEE. I haven't been through all though, so there could be
> > > some which support EEE and where adjust_link() with phydev->link=true
> > > twice in a row could result in badness.
> > 
> > So i think we all agree the MAC needs to see a down/up, even if the
> > link itself never went down. Anything else is too risky and will
> > probably break something somewhere.
> 
> Means, this patch should be dropped.

No.

This patch handles the case that EEE is changed, but does not require
an auto-neg cycle. If you drop this patch, that use case breaks.

You need to extend this patch to signal to the MAC a down followed by
an up. It is a fake down, the media side never goes down, but the MAC
needs to think it has in order to keep with the usual convention that
we never call adjust_link() twice with phydev->link not changing.

   Andrew

