Return-Path: <linux-kernel+bounces-79775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87381862684
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390F21F21E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4BF481C6;
	Sat, 24 Feb 2024 17:57:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A25E1362
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797471; cv=none; b=p57Ohfrgj+ustYeFDfPO7I71NVJHAdX+6pUNTPOnXsRr9FQdTn9QEOMRPtwO44NhqlZEy7iJomZCG+aKdMkdAKa1e9bQfyEs8eDtBevVQKU7Ki/GyP7kEH0lE3mBpyaAIpAZCwhxt1pC6DL/2LaJSC7xpJt07iNABdWALxJwXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797471; c=relaxed/simple;
	bh=tR5PRCTus2EF210gXUkGX6tXvo6hwHDBhRUrqzTaugI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZTUyYuVlz8nZk8PTMlndtgmv4KA4DUrbRj7n4EPmrHkj9X8kFLJ61O6OucuZLE+DI0IdiAeXqrQwnQdccsH5ZM8bRhb/orNzztlYMyIXqfVc8FfewT+B0vmXYwMa2mD5J+35/ZRGNlYD2ZIt4ccHQW6J8+gW9oNee1hht7rs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rdwH0-0001uP-7w; Sat, 24 Feb 2024 18:57:18 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rdwGu-002ef9-Po; Sat, 24 Feb 2024 18:57:12 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rdwGu-005pID-2F;
	Sat, 24 Feb 2024 18:57:12 +0100
Date: Sat, 24 Feb 2024 18:57:12 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH net-next v6 5/8] net: phy: Immediately call adjust_link
 if only tx_lpi_enabled changes
Message-ID: <Zdot-Mqw1z4ZEo8v@pengutronix.de>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2024 at 09:53:06AM -0800, Florian Fainelli wrote:
> On 2/23/24 05:26, Russell King (Oracle) wrote:
> > On Fri, Feb 23, 2024 at 02:17:59PM +0100, Andrew Lunn wrote:
> > > On Fri, Feb 23, 2024 at 10:38:20AM +0000, Russell King (Oracle) wrote:
> > > > On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
> > > > > +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> > > > > +				      struct ethtool_keee *data)
> > > > > +{
> > > > > +	if (phydev->eee_cfg.tx_lpi_enabled !=3D
> > > > > +	    data->tx_lpi_enabled) {
> > > > > +		eee_to_eeecfg(data, &phydev->eee_cfg);
> > > > > +		phydev->enable_tx_lpi =3D eeecfg_mac_can_tx_lpi(&phydev->eee_c=
fg);
> > > > > +		if (phydev->link)
> > > > > +			phy_link_up(phydev);
> > > >=20
> > > > I'm not convinced this is a good idea. Hasn't phylib previously had
> > > > the guarantee that the link will go down between two link-up events?
> > > > So calling phy_link_up() may result in either the MAC driver ignori=
ng
> > > > it, or modifying registers that are only supposed to be modified wh=
ile
> > > > the MAC side is down.
> > >=20
> > > When auto-neg is used, we expect the link to go down and come back up
> > > again.
> > >=20
> > > Here we are dealing with the case that autoneg is not used. The MAC
> > > needs informing somehow. If we want to preserve the down/up, we could
> > > call phy_link_down() and then phy_link_up() back to back.
> >=20
> > Would it be better to have a separate callback for EEE state (as I
> > mentioned in another comment on this series?) That would be better
> > for future SmartEEE support.
>=20
> That sounds like a good approach to me. The additional callback also helps
> figure out which drivers use the API and it should be simpler to audit for
> changes in the future, too.

At this point I need help to understand how to proceed.
What exactly do you have in mind? Some description like following would
be helpful:
Add callback with name phy_link_set_eee(), which should be executed in
function bla/blup..

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

