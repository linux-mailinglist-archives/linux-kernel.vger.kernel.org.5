Return-Path: <linux-kernel+bounces-69983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD61859146
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC7D1F221D2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6127A7D417;
	Sat, 17 Feb 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r8rhlLNO"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6971E515;
	Sat, 17 Feb 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708189661; cv=none; b=T7mdOhMfVboUTiwGUSz+zUin/QerKLcsY3/zeFnmSKjJMEC3dtakad5lbbBzYQtiRr5a08q9rHaljzrzHWxSiOblqegvtvEGUZuiOkMkm7UD7rQfYmYqN5+ye1Pn0IyiKFYliAvX5upXOyRN+19PW6NeNZoowh0Q1b8p6ztR0fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708189661; c=relaxed/simple;
	bh=P7I4J4DdTmbjWZu4aPEcn7nHHUmnnyqGemw9zvzq0QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGw2ln+/1GEi8rqyFLzFOLRfECl2uy0rrH+XInavUXxqSDfIJ8DuAJLZDS+uAE+YLHNscmqb8iICrtgTBW1pGnK9JiyuwLz3/PWcIe4pXTrXZxyz7DaxRY4BaPKElBHu2LSNexFAmXW6RHhYLIiDNrJzC7g0tE1RJyX+uI2jZDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r8rhlLNO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GRWtM/ktgdCwvK0hR9nKaqw64qBDSz1jmEq5mVbyKEI=; b=r8rhlLNO/6AsRMW9Zz9sSPI1in
	X85y7Wf6RkjfunwAJY5tc8qcYWnXOm36cfDJOK73KUO8Ke/FKjLRhKm5+yJePUl0hi0wN+fMH30Y7
	a0G/rEr7JEyNyx1aUeIrYTgC5bG5UOpx80RLwapFYOKc1X6p0WBitYkafxeD2Kc0Ha54=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbO9z-0084Zo-Cv; Sat, 17 Feb 2024 18:07:31 +0100
Date: Sat, 17 Feb 2024 18:07:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v8 04/13] net: Change the API of PHY default
 timestamp to MAC
Message-ID: <b8926fe5-81ef-40ea-9e87-5e84b368b745@lunn.ch>
References: <20240216-feature_ptp_netnext-v8-0-510f42f444fb@bootlin.com>
 <20240216-feature_ptp_netnext-v8-4-510f42f444fb@bootlin.com>
 <87jzn4gtlv.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzn4gtlv.fsf@nvidia.com>

On Fri, Feb 16, 2024 at 10:09:36AM -0800, Rahul Rameshbabu wrote:
> 
> On Fri, 16 Feb, 2024 16:52:22 +0100 Kory Maincent <kory.maincent@bootlin.com> wrote:
> > Change the API to select MAC default time stamping instead of the PHY.
> > Indeed the PHY is closer to the wire therefore theoretically it has less
> > delay than the MAC timestamping but the reality is different. Due to lower
> > time stamping clock frequency, latency in the MDIO bus and no PHC hardware
> > synchronization between different PHY, the PHY PTP is often less precise
> > than the MAC. The exception is for PHY designed specially for PTP case but
> > these devices are not very widespread. For not breaking the compatibility
> > default_timestamp flag has been introduced in phy_device that is set by
> > the phy driver to know we are using the old API behavior.
> >
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> 
> Overall, I agree with the motivation and reasoning behind the patch. It
> takes dedicated effort to build a good phy timestamping mechanism, so
> this approach is good. I do have a question though. In this patch if we
> set the phy as the default timestamp mechanism, does that mean for even
> non-PTP applications, the phy will be used for timestamping when
> hardware timestamping is enabled? If so, I think this might need some
> thought because there are timing applications in general when a
> timestamp closest to the MAC layer would be best.

Could you give some examples? It seems odd to me, the application
wants a less accurate timestamp?

Is it more about overheads? A MAC timestamp might be less costly than
a PHY timestamp?

Or is the application not actually doing PTP, it does not care about
the time of the packet on the wire, but it is more about media access
control? Maybe the applications you are talking about are misusing the
PTP API for something its not intended?

    Andrew

