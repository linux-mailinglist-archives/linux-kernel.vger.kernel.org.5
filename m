Return-Path: <linux-kernel+bounces-39012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302A83C9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A591C2485D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECEA13474E;
	Thu, 25 Jan 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i4kTSfJW"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75B134740;
	Thu, 25 Jan 2024 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202621; cv=none; b=YDl2nuZmsMlp9qUYRRC2bM1KSvVLqrTcD60kHuh2tw5Lk1dxwHDRR8Qx0cgX4wPuPO9jeOgILM94j6RtuhkKiIbKh0Ah1i57gQyLOePlo7NvlZ4FLefac2izpN3F/8OZPN3iSKfL8tgFvYMVgEm1ZAsk8MeWjEuhCIq7KMTuLHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202621; c=relaxed/simple;
	bh=hoy6NzodINKskmf/TeFa/RWzHNCzvbvzMc/mq5Qsavw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIB2Y2ZsdSYrsizxKuoub11CDqdQbC4wiRKMCnn8gavVUr0HeVFg4EXOEjWfEgb0MXea0qZ9JIe06FOtHT7nVZBoHpyi5ohePA2FyE1i/fvJFTKSOkZjpEF9oZ04Rzx+1nZj5vKwmHXr5N6gMRWjiFmn4MG1kTLb/blYEYB4yDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i4kTSfJW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VopbMPXtrem8Fa4qu37vThYAtxXb9VUpg0EXsR2tYnY=; b=i4kTSfJWYIWI1vHQmBwECBZ063
	oT9tMDdbMVKUDVsAVn/39mz89nBrdCpqoXp2EAky9FnHoTg+POsDzDhDQSuXKM1rzZ0KrceUq/u1t
	gc2no9wb1uuUfQhcifk+yX/a3rPO9fn5m1Q0MejGFUczeB7PgEsozJosPFtrEZ8F5VS4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rT3F1-0066Y1-7d; Thu, 25 Jan 2024 18:10:15 +0100
Date: Thu, 25 Jan 2024 18:10:15 +0100
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
Message-ID: <c0d1c08e-e9a7-44d2-bc66-bb8179f5a170@lunn.ch>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
 <20231221180047.1924733-8-maxime.chevallier@bootlin.com>
 <20240104153401.08ff9809@kernel.org>
 <20240105104311.03a35622@device-28.home>
 <2c955f94-7c95-4f66-b739-f0967ec9c171@lunn.ch>
 <20240124145033.1c711fd1@device-28.home>
 <1092441f-c347-4f61-8405-7cc8a07d5850@lunn.ch>
 <20240125092225.45cdaa09@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125092225.45cdaa09@device-28.home>

> I do face a problem with fixed_phy though now that I've played around
> with it. As fixed_phys share the same global MDIO bus, what can happen
> is that netdevsim-registered PHYs can starve the dummy MDIO bus by
> exhausting all 32 mdio addresses, preventing real interfaces from
> getting their own fixed-phy instance.
> 
> I'll probably register a dedicated mdio bus per netdevsim (or even
> per-phy, so that we can imagine controling the returned register
> values), let's see how it goes.

I can see it being a problem, but how theoretical is it?

Anything using phylink does not need a fixed-link device, its just MAC
drivers making use of phylib. Its also only typically used with MACs
connected to switches, and you tend not to have too many of them on a
machine. And lastly, netdevsim is only really used for testing, and i
guess most tests run either on a desktop or server like machine which
does not have switches, probably does not even make use phylib, or the
tests are run in a VM which does not even have any PHYs, fixed or not.

So i'm wondering how much effort should be put into this, or should
the time be spent on other things?

    Andrew



