Return-Path: <linux-kernel+bounces-81926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38129867C54
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F81F297B88
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15B12CDA3;
	Mon, 26 Feb 2024 16:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6UaQbr33"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0618112C55F;
	Mon, 26 Feb 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965877; cv=none; b=tpQY9Rx1WhCKzkpN1BxdV4gkHJjzLSSXHJRMplaogGVesPwFzEo5qBTHLFnrMHTN7AFlwXWHmTKn2jV66yB+zxa1/qrBTgXEB5spdrqEIGkDlF9tk2PLupefNvfZR9J1TSmNV4a8wsKHEUD0u1wwO8bC4OJELKZYszqo2QqkSpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965877; c=relaxed/simple;
	bh=2cC/qsuNQsXbbz+8yooGwMCr+WBfFCZgH3VG+mTM184=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssJHwN9GKxGu9WWCTsm72N82O7tZ9nGsx7nEykFR0qH4H8UfOTSc5MkWKL3CwYunkGlEdUt47VFkLuKLnJUU8trHHlCi0ARfQnc14e9ka2saUPwjzpS4wNgVwZXvMKRKE/5g9p3axHDmh3T/wvn5NeI5sKhqoy136yaXSl4TpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6UaQbr33; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fcMmbwH20hlzGHDT13qM5dHjc11AwHNty8n4xGkTVaU=; b=6UaQbr33atA+6ymp+NcdZPU6br
	9dgd95Z/HtBuOdZtagB50eg97f8wLfphVDn8qu82XcdTIam1tu0l/V2UYpIUc0pttDSzUdjfQOiXR
	2Tlr/9/WaM243kcn2bjci/PRPJMdby+4MwpFMCEUIEoNXIR07causqgJUm3j+23Kz+II=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ree5f-008kBh-Fv; Mon, 26 Feb 2024 17:44:31 +0100
Date: Mon, 26 Feb 2024 17:44:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Wei Fang <wei.fang@nxp.com>,
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
Message-ID: <c6b0716d-f093-4aba-8453-c89a562ab581@lunn.ch>
References: <20240223094425.691209-1-o.rempel@pengutronix.de>
 <20240223094425.691209-6-o.rempel@pengutronix.de>
 <Zdh1nMWZDynP/AMc@shell.armlinux.org.uk>
 <84e1368d-ec6a-48af-945b-509528c45dff@lunn.ch>
 <Zdic+ua5LnWxjLPn@shell.armlinux.org.uk>
 <6af3406a-7968-41e5-bf6e-71d020d8b28a@broadcom.com>
 <Zdot-Mqw1z4ZEo8v@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdot-Mqw1z4ZEo8v@pengutronix.de>

On Sat, Feb 24, 2024 at 06:57:12PM +0100, Oleksij Rempel wrote:
> On Fri, Feb 23, 2024 at 09:53:06AM -0800, Florian Fainelli wrote:
> > On 2/23/24 05:26, Russell King (Oracle) wrote:
> > > On Fri, Feb 23, 2024 at 02:17:59PM +0100, Andrew Lunn wrote:
> > > > On Fri, Feb 23, 2024 at 10:38:20AM +0000, Russell King (Oracle) wrote:
> > > > > On Fri, Feb 23, 2024 at 10:44:22AM +0100, Oleksij Rempel wrote:
> > > > > > +static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
> > > > > > +				      struct ethtool_keee *data)
> > > > > > +{
> > > > > > +	if (phydev->eee_cfg.tx_lpi_enabled !=
> > > > > > +	    data->tx_lpi_enabled) {
> > > > > > +		eee_to_eeecfg(data, &phydev->eee_cfg);
> > > > > > +		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
> > > > > > +		if (phydev->link)
> > > > > > +			phy_link_up(phydev);
> > > > > 
> > > > > I'm not convinced this is a good idea. Hasn't phylib previously had
> > > > > the guarantee that the link will go down between two link-up events?
> > > > > So calling phy_link_up() may result in either the MAC driver ignoring
> > > > > it, or modifying registers that are only supposed to be modified while
> > > > > the MAC side is down.
> > > > 
> > > > When auto-neg is used, we expect the link to go down and come back up
> > > > again.
> > > > 
> > > > Here we are dealing with the case that autoneg is not used. The MAC
> > > > needs informing somehow. If we want to preserve the down/up, we could
> > > > call phy_link_down() and then phy_link_up() back to back.
> > > 
> > > Would it be better to have a separate callback for EEE state (as I
> > > mentioned in another comment on this series?) That would be better
> > > for future SmartEEE support.
> > 
> > That sounds like a good approach to me. The additional callback also helps
> > figure out which drivers use the API and it should be simpler to audit for
> > changes in the future, too.
> 
> At this point I need help to understand how to proceed.
> What exactly do you have in mind? Some description like following would
> be helpful:
> Add callback with name phy_link_set_eee(), which should be executed in
> function bla/blup..

When i first did this patchset, SmartEEE was out of scope. One
question we should decide is, is it still out of scope, and we should
first get 'dumb' EEE fixed everywhere, and than come back and look at
SmartEEE? Or do we want to consider SmartEEE now?

The idea of this patchset was to push as much as possible down into
phylib. The MAC needs to say it supports EEE. I left handling of the
tx_lpi_timer to the MAC driver, because the PHY has nothing it can do
with that value. phylib then just needs to tell the MAC to enable or
disable EEE when autoneg has completed. That i made part of the adjust
link callback because that is the only callback we have, and most
developers seem to understand it, and the locking around it. However,
it does get messy when EEE can change without an auto-neg, as pointed
out here.

If we are leaving SmartEEE out of scope for the moment, i would say
just doing a down/up is sufficient, lets get this merged and all
'dumb' EEE fixed.

If we want feature creep and to think about SmartEEE then we need a
few changes in the overall design.

We need to make eee_get and eee_set transparent to the MAC driver,
since the PHY could be doing it all. So phylib needs to track
tx_lpi_timer. If the MAC driver indicates it can do 'dumb' EEE we
probably want to use that in preference to SmartEEE, since i guess the
MAC can also save a little power in LPI mode. So the adjust link
callback needs to say: Enable MAC EEE with this value of tx_lpi_timer,
or turn off MAC EEE. When using SmartEEE it will never actually do
either.

The current phylib model is that adjust_link is the only callback, and
the MAC driver peeks into phydev to find what it needs. I would
probably stick to that model, and not add MAC callbacks. phylink is
slightly different, mac_link_up() passes everything the MAC needs to
know as parameters, so one of my patches adds an extra parameter to
indicate if EEE should be enabled or disabled. That would need
extending with the tx_lpi_timer value.

	  Andrew

