Return-Path: <linux-kernel+bounces-17998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B618256B9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55D31C22D52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58C2E64B;
	Fri,  5 Jan 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSYVL9PT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A72E630;
	Fri,  5 Jan 2024 15:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CF9C433C7;
	Fri,  5 Jan 2024 15:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704468874;
	bh=HlJFqg+osmXCgn/pXd3UWCmw8xaEkh4vZNHNpeYjElM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GSYVL9PTXAYSwpNALY1SVn2NXlMKmUEVgTF9+mh8uTuYpAxYLi2Wdx7VA4uK5leMy
	 8viMtR4nB43HoWEFWWkdnF4cPnTP9UW6zMAQ/q2+389q2YWnq44ojIUj1d0ivO24K5
	 2+A9bV8FRiOukLRlFbCSiImG/YQ1voZ5crrKPv8GFwSJ6FOOAr6i9m86dLuxWwYIdz
	 vhv/bxh8tEjpzhJMMapIt++UdSNp5c135AkkTURe7pxgk2gkHsnILYAWIpS1TIHpmq
	 L6wp54OdzK9K9CHBdzlnrymMOCM29X/X6GZ/BFng9LqIkXpSBbOC5Y+5EaK8rH+2+5
	 7ttzvqPCjh6PA==
Date: Fri, 5 Jan 2024 07:34:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20240105073432.671159e9@kernel.org>
In-Reply-To: <20240105102918.24398552@device-28.home>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-2-maxime.chevallier@bootlin.com>
	<20240104151242.52fa8cb4@kernel.org>
	<20240105102918.24398552@device-28.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jan 2024 10:29:18 +0100 Maxime Chevallier wrote:
> I'll give it a try, it could be doable to try to keep the index for
> _some_ PHYs. I had a first try at this in the very first iteration, but
> that was lost when converting to xarray for the index management. Since
> the phy_device keeps track of its own index, we can try to re-use it,
> but I can see it becoming difficult if we destroy the topology when all
> PHYs are detached (after ndo_close).

What I was thinking is if phy already has phyindex, and that index is
unused in the xarray of netdev in question - try to use that phyindex
instead of allocating a new one?
IDK if phys can move between netdevs, or get freed/recreated
automatically - otherwise it should work? (If user unbinds and rebinds
the PHY driver for instance that's their fault, we can renumber).

