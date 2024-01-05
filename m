Return-Path: <linux-kernel+bounces-17868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34F82545A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE981C21798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2D02D620;
	Fri,  5 Jan 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VHzN0NrO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AF2D61B;
	Fri,  5 Jan 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oYkHg1D15kQrScL6uDog31ucMTQ1gHtOMHhxRiO58Dw=; b=VHzN0NrOusYaSJOab5F/XVEHAy
	ME9lsChygVo6Tc5hQAtWtSJY3A4paxJCLwtNf1Nmfms1Fl/SsllQS6vVWbEtnJ5zmc+57xlf73Cz4
	Y//Yd8HNLB+hMjtinImojOy1QQh1SU6eRF/8TaQnghZV+/RZf8/mNDpTbIU4Bfzc46tE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rLk4U-004SGe-Ub; Fri, 05 Jan 2024 14:17:10 +0100
Date: Fri, 5 Jan 2024 14:17:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <2c955f94-7c95-4f66-b739-f0967ec9c171@lunn.ch>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
 <20231221180047.1924733-8-maxime.chevallier@bootlin.com>
 <20240104153401.08ff9809@kernel.org>
 <20240105104311.03a35622@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105104311.03a35622@device-28.home>

> > > +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > > +{
> > > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > > +	struct net *net = sock_net(skb->sk);
> > > +	unsigned long ifindex = 1;  
> > 
> > This doesn't look right, if dump gets full you gotta pick up
> > when previous call left off.
> 
> I wasn't aware that this was the expected DUMP behaviour. So I should
> keep track of the last dev and last phy_index dumped in the dump_ctx I
> guess ? I'm not sure how I'm going to test this though, I only have
> devices with at most 2 PHYs :(

At a guess....

You are supposed to dump until you are out of space in the buffer. You
then return what you have, and expect another call so you can continue
with the rest.

Rather than fill the buffer, just hack the code to only put in a
single PHY, and then return with the same condition of a full
buffer. Hopefully you should get a second call, and you can then test
your logic for picking up from where you left off.

Another option might be to add PHY support to netdevsim. Add a debugfs
interface to allow you to create arbitrary PHY topologies? You can
then even add a test script.

     Andrew

