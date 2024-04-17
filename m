Return-Path: <linux-kernel+bounces-149032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A0F8A8AC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991A31C230AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A7173325;
	Wed, 17 Apr 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbJEYXxa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B318C19;
	Wed, 17 Apr 2024 18:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377246; cv=none; b=LnzOPOWL9dqv+IzkNFF2geiCdFb4eDMBrAOh8Zfs6plecbJwe2U1bDj0plpfovqvrOrbwQarpe76gUFd1Q2uCq2QHg44hW9y73PbS/qMH7f3Oe5+9X5R9O5XqC+CNjHTP74Ro5idQCQz7EhbC+c2GbvFcrW+3KFGO2MR8ZDy77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377246; c=relaxed/simple;
	bh=TOQT+ROLVGODSZZzDLrHzeqr30Nr45aSCcdnwYTfuis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeqNPZnPSAh+oAQ/RnlSUV8XQzA9WsJMLwUCC9PQPhPOkhkgkV31KM+DivHg+XDp1vKkbFhwQ8y3v9Gs/QXzTTxX+zCdftvLdwMTV82RvilnZIJ6tALhAGhU9zE4dpsdl5YMy4cURQXyJei8YCghoJoEwq4DSwFsXHPe1V+TQSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbJEYXxa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E391EC072AA;
	Wed, 17 Apr 2024 18:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713377244;
	bh=TOQT+ROLVGODSZZzDLrHzeqr30Nr45aSCcdnwYTfuis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GbJEYXxaVWv2RmvjdIC015OQ+Tiz7UNUBsJ9fcR+MgxN7rX+cVopikvhM5L+lIl4v
	 aZnRDFniuJB6eJdEIgmF6cgMP2bbeLEA4yFeRsk8NWKhB1nn7rnZxT4kY+AhY5oLCA
	 Ezgg/r54tYzKk9p/ikaizbVHkaBzpIH7rJJ/yRBM3sKYQ0q0IUEFChWdhlqbp+38Wl
	 VVV29KlNRDflMk8FNtO/dP8BY6P/oVpxREKkid+Ph7zK1injZTfUzGXPyZD6zTZ3NV
	 xnYjb94kJqK++VJF0hdba/OPb28FZtRyGO5TWQcLqfOSBOZ0x3xQ+78/8vgYTvWxYF
	 +9fUCqWj4iaEQ==
Date: Wed, 17 Apr 2024 11:07:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
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
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next] net: phy: link_topology: Don't stub-away the
 topology creation
Message-ID: <20240417180721.GA3212605@dev-arch.thelio-3990X>
References: <20240417142707.2082523-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417142707.2082523-1-maxime.chevallier@bootlin.com>

Hi Maxime,

On Wed, Apr 17, 2024 at 04:27:05PM +0200, Maxime Chevallier wrote:
> Some of the phy_link_topology operations are protected by IS_REACHABLE,
> which can lead to scenarios where the consumer, built as modules, sees the topology
> unstubbed, whereas the initialization didn't occur.
> 
> Don't stub away the creation of the topology, it has no dependency on
> any other parts like phylib, so we can make it always available.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Closes: https://lore.kernel.org/netdev/2e11b89d-100f-49e7-9c9a-834cc0b82f97@gmail.com/
> Closes: https://lore.kernel.org/netdev/20240409201553.GA4124869@dev-arch.thelio-3990X/
> ---
> Hi Nathan, Heiner,
> 
> I'm currently at EOSS, so I'm sending this patch without having been
> able to properly test it (build-tested only), but as this addresses an
> issue for people using -next, I'm sending this anyway, sorry about that.

No worries, thanks for continuing to take a look. Unfortunately, this
patch fails to build during the linking stage for me with my
configuration:

x86_64-linux-ld: vmlinux.o: in function `free_netdev':
net/core/dev.c:11060:(.text+0xb14030): undefined reference to `phy_link_topo_destroy'
x86_64-linux-ld: vmlinux.o: in function `alloc_netdev_mqs':
net/core/dev.c:10966:(.text+0xb142d6): undefined reference to `phy_link_topo_create'

> Hopefully it can address the issue for now, I haven't given-up on your
> idea to introduce a config option Heiner :)
> 
> Thanks,
> 
> Maxime
> 
>  include/linux/phy_link_topology_core.h | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/include/linux/phy_link_topology_core.h b/include/linux/phy_link_topology_core.h
> index 0a6479055745..61e2592f24ac 100644
> --- a/include/linux/phy_link_topology_core.h
> +++ b/include/linux/phy_link_topology_core.h
> @@ -4,22 +4,7 @@
>  
>  struct phy_link_topology;
>  
> -#if IS_REACHABLE(CONFIG_PHYLIB)
> -
>  struct phy_link_topology *phy_link_topo_create(struct net_device *dev);
>  void phy_link_topo_destroy(struct phy_link_topology *topo);
>  
> -#else
> -
> -static inline struct phy_link_topology *phy_link_topo_create(struct net_device *dev)
> -{
> -	return NULL;
> -}
> -
> -static inline void phy_link_topo_destroy(struct phy_link_topology *topo)
> -{
> -}
> -
> -#endif
> -
>  #endif /* __PHY_LINK_TOPOLOGY_CORE_H */
> -- 
> 2.44.0
> 

