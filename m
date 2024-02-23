Return-Path: <linux-kernel+bounces-78325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 879EC8611EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD67281D28
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F097C6E9;
	Fri, 23 Feb 2024 12:49:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3976C83
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692594; cv=none; b=M6bHyexWTbfpFDkeF55ZKP1PCTn9W/7KY4HN9AlYm6cnP/C4KNdkmNyde+3TwQX6akLNEEPVedHsC3YUjKVVEESkyjvvj4ouZr0uiu7qOZgXiKZ5B98Hba3FZYiVWS+FF8rvnAZSwv+gMKzQseMhs/JSyGCuAkbU+b9m1P/fNI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692594; c=relaxed/simple;
	bh=Z69H1wxWWYdXs8q/7YDlQLtBE7Izos6W67qIanP/aSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNYRcM5pA+r7evnFD7sZmH/H4A0Oj3UjDRHUw8f0VJ3n4Xm+sp2uhWqmM4WWY0gRXNjFKCYd0JXnLt+570RjUhjlMGRXSpd2Bt9QePPbErH0/djFaKkE/HOFFos2QwPQFcEY6Lf/0t3yqHyngb5h/xCzgzSufbJP993EF6yRd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rdUza-0004PF-08; Fri, 23 Feb 2024 13:49:30 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rdUzX-002QYz-LA; Fri, 23 Feb 2024 13:49:27 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rdUzX-004HCl-1l;
	Fri, 23 Feb 2024 13:49:27 +0100
Date: Fri, 23 Feb 2024 13:49:27 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <ZdiUVxHNJ2KV0OYf@pengutronix.de>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2024 at 10:38:20AM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
> > +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> > +				      struct ethtool_keee *data)
> > +{
> > +	if (phydev->eee_cfg.tx_lpi_enabled !=
> > +	    data->tx_lpi_enabled) {
> > +		eee_to_eeecfg(data, &phydev->eee_cfg);
> > +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> > +		if (phydev->link)
> > +			phy_link_up(phydev);
> 
> I'm not convinced this is a good idea. Hasn't phylib previously had
> the guarantee that the link will go down between two link-up events?
> So calling phy_link_up() may result in either the MAC driver ignoring
> it, or modifying registers that are only supposed to be modified while
> the MAC side is down.

Ok, I'll drop this patch.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

