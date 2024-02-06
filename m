Return-Path: <linux-kernel+bounces-55429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE0984BC9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4FE1C246E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C8FDF5A;
	Tue,  6 Feb 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="al8eteq6"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED612E7F;
	Tue,  6 Feb 2024 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707242274; cv=none; b=ehR2zinGwN4guX33FIV8UG0Zfccmbipho1oiO+sLmewS+DJWLq8lLeG0hysRuWa8rnGRpKo8NFGMzsAi+Bkyp4ARaJmodXjy8bw7ELM8nHhpX0oWTXFd1JRKW6JBhDLTKfj2A9ZO2vuYbeFpTo2FuQcJlbK1h956FqAyaev1xo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707242274; c=relaxed/simple;
	bh=8gDzuVCKdPwzA40a8tpp7lDmQXLj/dn5yzrujFEikao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLQlkOWJa75p2waFsOk9Nc+8dNJPfgORf5k4LCptMrYTa3imnFxBZEYQHnNvIKxDoxltoCOCiLkVp7y6PKBkpL+G8atfu6UivKUnbvNsP72YAM7jGdrlUwUC5EjeWmEwOgqHJNEk0o2xe5BxL7fecqZpBoQkOyKhQRmdnRWBCe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=al8eteq6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dY1XgAi9K5gzkFSgHzioxQghxSL/GzrupmQKs/QrvZg=; b=al8eteq6uu5wVhXaJruFjHGsKi
	nkM8GKEfD9055iMxGKvPF94GU/6vS2zxjUpdrI99wx1CvA4dhKPbSS61UzUEYemhevrpWFttguVra
	U6IraAOEPQQvsS5ID4UYTMWDc+qcENnCUXxUMDQZd/zFxUtxdJUEoQKurNBtMXUpZ7Rk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rXPhS-007A79-0S; Tue, 06 Feb 2024 18:57:38 +0100
Date: Tue, 6 Feb 2024 18:57:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <dbae1fca-9313-40e3-9b5c-0de1a8e177df@lunn.ch>
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
 <20240109232838.GA3626@francesco-nb>
 <ZafXQS1_4fHpEzL0@ninjato>
 <20240206172645.GA24848@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206172645.GA24848@francesco-nb>

On Tue, Feb 06, 2024 at 06:26:45PM +0100, Francesco Dolcini wrote:
> On Wed, Jan 17, 2024 at 02:33:53PM +0100, Wolfram Sang wrote:
> > > > +static int ksz9x31_resume(struct phy_device *phydev)
> > > > +{
> > > > +	phy_device_reset(phydev, 1);
> > > > +	phy_device_reset(phydev, 0);
> > > 
> > > Is something like that fine?
> > > Don't we need to reconfigure the ethernet phy completely on resume
> > > if we do reset it? kszphy_config_reset() is taking care of something,
> > > but I think that the phy being reset on resume is not handled
> > > correctly.
> > 
> > If the interface is up before suspending, then suspend will assert the
> > reset-line. If the interface is disabled before suspending, then close
> > will assert the reset line. Deassertion will happen on resume/open.
> > 
> > So, unless I am overlooking something, my code does not really add
> > something new. It only makes sure that the reset line always gets
> > asserted before deasserting. Because in the case that the interface has
> > never been up before, there is no instance which could assert reset. Or,
> > at least, I could not find one.
> > 
> > Makes sense? Tests work fine here, at least.
> 
> What I do not know, is what happen to any configuration that was done to
> the phy before.

I'm assuming here WoL was not enabled, so the PHY did actually
suspend.

mdio_bus_phy_suspend() calls phy_stop_machine() which will set the
state of the PHY to UP.

During resume mdio_bus_phy_resume() calls phy_init_hw(). That should
do a soft reset, call the config_init() callback, and configure
interrupts. After that phy_resume() is called and then
phy_state_machine(). Do to setting the state to UP, the state machine
will kick off auto-negotiation, which will cause any auto-neg
parameters to be written to the PHY.

> What if you have disabled gigabit ethernet from auto negotiation before
> suspend, it will be enabled again after the phy get out of reset.

If you have set in fixed mode, the wrongly named phy_config_aneg()
will set the fixed modes, same as it would set the auto-neg modes. So
they should be preserved over suspend/resume.
 
	Andrew

