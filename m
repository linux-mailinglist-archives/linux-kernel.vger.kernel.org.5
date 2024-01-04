Return-Path: <linux-kernel+bounces-17319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEC0824BBB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA001C2269F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94DE2D052;
	Thu,  4 Jan 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7uutDbO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7E2D036;
	Thu,  4 Jan 2024 23:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4408C433C7;
	Thu,  4 Jan 2024 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704409964;
	bh=pna8e9qSOEoIxNWRYi8FBs+Y3qy9hZxpLEHfzkPhAic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7uutDbOmNGjFWw3LNJOkzdRI12thZbYoWybuII94Oumo+hdXEvUXvCMvw0YYbjyB
	 eAI19/r67/1Wnl5uwHCoIGnbGMn6A7W20m2Mc0fFC2wQ08RxCydThkigdlrdvToazm
	 on7ChpgLLum9DQ7HJOPa3wnMKRb0lqG4qG5Ld+cjWesc/R9orAtE/A5IOzD/kTQVbD
	 hujps7Zm+aO0RSUAgfSgA83ELs2aofO/O7faW3mV2ex2gxpQ1JVhY0nx02iFP1fSR1
	 J4l1Mbgfa8NajA7xR9HQFOaghWhpitCqKQvVrp4FfyoGWXTJE0f2YhrYRfGJdcOF9z
	 QU7iTVyedRgvw==
Date: Thu, 4 Jan 2024 15:12:42 -0800
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
Message-ID: <20240104151242.52fa8cb4@kernel.org>
In-Reply-To: <20231221180047.1924733-2-maxime.chevallier@bootlin.com>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 19:00:34 +0100 Maxime Chevallier wrote:
> @@ -2441,6 +2442,7 @@ struct net_device {
>  #if IS_ENABLED(CONFIG_CGROUP_NET_PRIO)
>  	struct netprio_map __rcu *priomap;
>  #endif
> +	struct phy_link_topology	link_topo;

Perhaps others would disagree but can we make this a pointer instead?
Only allocate it on demand, when first PHY gets attached?
Both saves space and netdevice.h will no longer need to know the
definition of the struct.

Complete noob question but I thought PHYs get attached at ndo_open
time for drivers, don't they? We shouldn't want to re-ID in that case.

>  	struct phy_device	*phydev;
>  	struct sfp_bus		*sfp_bus;
>  	struct lock_class_key	*qdisc_tx_busylock;

> @@ -10872,6 +10873,8 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  #ifdef CONFIG_NET_SCHED
>  	hash_init(dev->qdisc_hash);
>  #endif
> +	phy_link_topo_init(&dev->link_topo);
> +
>  	dev->priv_flags = IFF_XMIT_DST_RELEASE | IFF_XMIT_DST_RELEASE_PERM;
>  	setup(dev);
>  

I think you're missing a call to xa_destroy() somewhere, no?

