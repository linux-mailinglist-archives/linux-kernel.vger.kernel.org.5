Return-Path: <linux-kernel+bounces-67845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B79A8571BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216C9282654
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2B0145FF4;
	Thu, 15 Feb 2024 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AHhoeY/K"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F65145B32;
	Thu, 15 Feb 2024 23:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040607; cv=none; b=JsnvIXx8ozUOCnDeZJwJ7FoFAAZziQJ9EAciOcIkHOGYCP0P2apq3DjxzdBtL5QntuK7O6aNr9mAJg0H32bmRJ/EIz0NhsXypr/bJLttunW3WIwOxRE7wR9TNOrB2eKDe+f67HEZtjDV81s3s+Kr8FzrIwD8pWRNMnBKVnM9dhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040607; c=relaxed/simple;
	bh=rzXQp+0xgZRh+hAEef1Ws6p+fPGbGwqJv//E1UQ0gH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpKDoikVAN4VrykIz8WVEVNVJQPx/rvaXdLWql0juZod9vy5oNWlrghueAf9uUrfWqiT0AAw2zMn31iW4VgwQ6j0mEPMmM0JIiteAE7Dgos4nsDKfIyUA1T+HAigrRt83EUUbxl/wYhCVZngiyQZI6cyeWFZfHqhDu4FNT36VB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AHhoeY/K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LYlr5KosbRmI8zuJFutDt7+/kwZBdkeoiz+ZEDuMca8=; b=AHhoeY/KWWcBuiZ9AWj0IDMXml
	bcS7EOHm1+6aJvNT8cUBTR/AVx7sZ+sPEj0MPpygrijA3WKI7t0k1JhPMB3sI7mfCfRAdEQ8L8Alz
	TcGdDYduEqaEZV4DyNavYfUirYiwuUIj7lgAC0REMgQ4ECDpdaVpcCy9m/jAKWYLotMY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ralO4-007veu-E2; Fri, 16 Feb 2024 00:43:28 +0100
Date: Fri, 16 Feb 2024 00:43:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 09/14] net: phy: marvell-88q2xxx: add cable
 test support
Message-ID: <ecfac8c1-de0d-4ccc-ad24-5e62b3d1bf5a@lunn.ch>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-10-dima.fedrau@gmail.com>
 <fe604759-d1cd-4a4d-ba64-69936b3e6598@lunn.ch>
 <20240215210350.GB3103@debian>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215210350.GB3103@debian>

On Thu, Feb 15, 2024 at 10:03:50PM +0100, Dimitri Fedrau wrote:
> Am Wed, Feb 14, 2024 at 06:54:58PM +0100 schrieb Andrew Lunn:
> > > +static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
> > > +					   bool *finished)
> > > +{
> > > +	int ret;
> > > +	u32 dist;
> > > +
> > > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*finished = true;
> > 
> > That looks odd. Is there no status bit which says it has completed? Is
> > it guaranteed to complete within a fixed time? How is it guaranteed that
> > mv88q222x_cable_test_get_status() is called at the necessary delay after 
> > mv88q222x_cable_test_start()?
> > 
> According to the datasheet and the Marvell API bits(0:1) can be used to
> check if the test has completed. Sample code waits 500ms before checking
> the bits. If the test is not completed after the delay the corresponding
> function returns with an error.

Thanks for the explanation.

> 
> I just used bits(7:4) where 2'b1000 means that the test is in progress,
> and setting *finished = false. I didn't introduced any delay, relying
> on the reschedule delay of the PHY state machine. I didn't notice any
> problems with this approach. Anyway if the test does not complete for
> whatever reasons we get stuck here, right ?

It should not happen, and if it does, its a bug in the PHY
firmware. And if that happens, the PHY is probably dead anyway.

phylib does allow you to break out of the cable test state by calling
phy_stop(). That generally happens when you admin down the interface.

So please do check the test has completed.

	Andrew

