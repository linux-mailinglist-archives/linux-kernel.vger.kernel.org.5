Return-Path: <linux-kernel+bounces-66205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A173D855880
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B87928F58C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C73137E;
	Thu, 15 Feb 2024 00:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMf6Eq5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D85A59;
	Thu, 15 Feb 2024 00:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707958745; cv=none; b=kAa+bauCpxeXEZCk4eixAxA815zUk1jR+JYaIvAECg3aWxak7V66FSevvyUYMZA2Does/LpxmN+5gYtZXh4CrEDYdgQbJKroIyFUm7eBAl+5xnCyefymKibwbmnqnmX/f5++a8gAgR0uUZvxFR01LTWJRTQISsLVYXuuYkYNqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707958745; c=relaxed/simple;
	bh=Nl+odjlfK+R+k/m+CZLLi9s6iAFfj0YBGYAq3Za4WGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZSk4RywuHBbmpCFW7+iHXBQdNPF0tJdYTZ1Paat/+B6PJcQsvGIsHQmQHsmDOSBWdPK8PrPDOmEWANjfpO3UkoRkacVGMhb+3NGHlpZ6QDyxjcAWHV3x77+SFcr2Ye7rk93vBoBabxSpDhcdv6dwnZZdaEPOsjn1MxE9xXaqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMf6Eq5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE8AC433F1;
	Thu, 15 Feb 2024 00:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707958744;
	bh=Nl+odjlfK+R+k/m+CZLLi9s6iAFfj0YBGYAq3Za4WGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMf6Eq5RsvfPskmrJzatmYAiSPCm41VIsaNzxFrS0QiNVtEA2VPMn8J7L8y1+pejr
	 WuJsto4TmDDe5hdsHhdUrNBvNL3/yNSaDj0oLMpmz/VdDaUfrHZl6fWRtN3gSnC2ky
	 ykmOESm2qcDTvwibwgOoQ4SwG2Ss1zHETKGb5rOZUNv+s2DLmvHUErat+yqt3n+n1S
	 OcsInxQJwNmzMBmlK6l7RV4jmrVRCroySN8v0LgilU2biEn7gvTVJHbZZPYPiv78mb
	 fkWnpwTS2wMQLMBLKEAHNME6yx5OmVQFLLWG2PxsiyLBHlqDj2rJ8o/W+uDONbh4QQ
	 TvJi3MTFT1xfA==
Date: Wed, 14 Feb 2024 16:59:02 -0800
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
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v7 00/13] Introduce PHY listing and
 link_topology tracking
Message-ID: <20240214165902.55bf3a04@kernel.org>
In-Reply-To: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
References: <20240213150431.1796171-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 16:04:17 +0100 Maxime Chevallier wrote:
> This is V7 for the link topology addition, allowing to track all PHYs
> that are linked to netdevices.
> 
> The main change in V7 is the protection of the main internal API
> entrypoints (link_topo_init/cleanup, link_topo_add/del_phy) by
> IS_REACHABLE(CONFIG_PHYLIB).
> 
> That's restrictive, but it looks difficult to do otherwise while still keep the
> data structure opaque and not add dependency clutter with PHYLIB.
> 
> As you can tell, I'm unsure about this, so please don't hesitate to
> comment on that part :)
> 
> The other changes are very minor, the only one is a call to netdev_put
> in the .done() netlink callback.
> 
> As a remainder, here's what the PHY listings would look like :
>  - eth0 has a 88x3310 acting as media converter, and an SFP module with
>    an embedded 88e1111 PHY
>  - eth2 has a 88e1510 PHY

Needs a rebase, core has been busy lately:

Applying: net: phy: Introduce ethernet link topology representation
Using index info to reconstruct a base tree...
M	MAINTAINERS
M	drivers/net/phy/Makefile
M	drivers/net/phy/phy_device.c
M	include/linux/netdevice.h
M	include/linux/phy.h
M	net/core/dev.c
Falling back to patching base and 3-way merge...
Auto-merging net/core/dev.c
CONFLICT (content): Merge conflict in net/core/dev.c
Auto-merging include/linux/phy.h
Auto-merging include/linux/netdevice.h
Auto-merging drivers/net/phy/phy_device.c
Auto-merging drivers/net/phy/Makefile
Auto-merging MAINTAINERS
Recorded preimage for 'net/core/dev.c'
-- 
pw-bot: cr

