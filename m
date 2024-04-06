Return-Path: <linux-kernel+bounces-134000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2585889ABEB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1501F21768
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D73C6AC;
	Sat,  6 Apr 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Yva0p4QL"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745D3F8D4;
	Sat,  6 Apr 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712419672; cv=none; b=WMUIhZTs/KtbBwwoeT6LCVQ419LsV+PoxzAgM939waNbYNz3k1wHI4+uy6eyNm5GEHJqBSjoogcbKUETKiIH4okqLqVH4OlzE94k8NrnpcUBn8R4UdCviSg9Zph1OZwzW61Ug0whEL3Xj3P5YzGc99Mdvx24F3rmui4I/f/kY9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712419672; c=relaxed/simple;
	bh=3MH6xRpqIpnSprqXrq70BtOwwayuxEjLhibVKg4SMLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkNs+h/SibvhCoZaiK3f5qTQshsojbHxjkqdAs/SOG89jlCRHyQxaSwU8AWWvAyLboiXt4fjtBI4Od3BRBUfq08t5CE76r1q930qFrBfLc83pxrCz2KlaoPUkWU0uAYX7MO92aaXISIlsWBVR3bLxYjvxvSB90VVZHyYfJV9IVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Yva0p4QL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qQ3n2ZRE/couwmhnDhXXSavtEX8krCNtDnPAhcPo4Bs=; b=Yva0p4QLaSWRVoTW3jTYrUEiXy
	j5bsbh8UL4xLQ19xx3SmA/Fu26G7uEx9nPqP5p6SM9/Wm6OgoP9/bF4sgop4P5R+vAg9vdXgBGGL7
	IADcRt8SHuTw6IcI77XTI9SV56JNtOallR4EMo8InkilUkn7/QUkxv/DxhA/KaguQLlo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt8a4-00CNcW-2q; Sat, 06 Apr 2024 18:07:48 +0200
Date: Sat, 6 Apr 2024 18:07:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v11 13/13] Documentation: networking: document
 phy_link_topology
Message-ID: <333ae4dc-7ce9-47e8-b4bf-f85462fa95b2@lunn.ch>
References: <20240404093004.2552221-1-maxime.chevallier@bootlin.com>
 <20240404093004.2552221-14-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404093004.2552221-14-maxime.chevallier@bootlin.com>

On Thu, Apr 04, 2024 at 11:30:03AM +0200, Maxime Chevallier wrote:
> The newly introduced phy_link_topology tracks all ethernet PHYs that are
> attached to a netdevice. Document the base principle, internal and
> external APIs. As the phy_link_topology is expected to be extended, this
> documentation will hold any further improvements and additions made
> relative to topology handling.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

