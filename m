Return-Path: <linux-kernel+bounces-82722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBB8688B4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C69B2430E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6825336E;
	Tue, 27 Feb 2024 05:35:49 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A3C52F95
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012149; cv=none; b=DdiDbaNPyj9nT1uk4mo0ZimqQQg7hWbOKyq5KgdobILTfAvzmd11ZTYvhY2sOA7YYLxof/U2bnZal+nDnsb4lJK8PgnZVjMVGAyV1H3F0niFRD1GhDJbV+54jk5MO8g6CP8AiTp+S+zki/ggmX1cINx63yYXHMdJa9ZNucTDMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012149; c=relaxed/simple;
	bh=4DdQpD7qe+yF9pbBdc/REKtzDvw2NiDp7vBjTxEljjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWstNPpBYVQWr0ILKh5kcw+1mNpoWUNGybcBvlRQkSAdvwc+pOm72fV7E50JEwAio7WL3Q5a0dgu4hRT1Uv/6j6p+NOp2OzxmFX9kt0SNHVp+8My5CQy5WT2TI6LfW2M/pe6jkvBXucfNsOMWoZJU5MCmohkRgHMDOJsckcPs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1req7x-0001wq-Az; Tue, 27 Feb 2024 06:35:41 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1req7u-0038HM-3k; Tue, 27 Feb 2024 06:35:38 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1req7u-00AVXW-03;
	Tue, 27 Feb 2024 06:35:38 +0100
Date: Tue, 27 Feb 2024 06:35:38 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <Zd10qUJzq-2nG7b7@pengutronix.de>
References: <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
 <Zdot-Mqw1z4ZEo8v@pengutronix.de>
 <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
 <e679f467-d4cd-4a1e-9bfc-92e2c9bf35d4@broadcom.com>
 <ZdzQG6t2slqEyH0m@shell.armlinux.org.uk>
 <fe071598-64eb-4dd2-8926-d4d0954e7e7e@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe071598-64eb-4dd2-8926-d4d0954e7e7e@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2024 at 07:59:28PM +0100, Andrew Lunn wrote:
> On Mon, Feb 26, 2024 at 05:53:31PM +0000, Russell King (Oracle) wrote:
> > On Mon, Feb 26, 2024 at 09:50:02AM -0800, Florian Fainelli wrote:
> > > This is the source of the concern, we don't know which MAC drivers we might
> > > end-up breaking by calling adjust_link(link == 1) twice in a row, hopefully
> > > none, because they should be well written to only update the parameters that
> > > need updating, but who knows?
> > 
> > Just quickly... There are some (I went through a bunch.) They don't
> > support EEE. I haven't been through all though, so there could be
> > some which support EEE and where adjust_link() with phydev->link=true
> > twice in a row could result in badness.
> 
> So i think we all agree the MAC needs to see a down/up, even if the
> link itself never went down. Anything else is too risky and will
> probably break something somewhere.

Means, this patch should be dropped. Are there other changes required?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

