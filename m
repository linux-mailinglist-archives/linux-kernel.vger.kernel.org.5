Return-Path: <linux-kernel+bounces-165913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5208B934E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94722841B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0577B17BA8;
	Thu,  2 May 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEwDVHr4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6DC10A24;
	Thu,  2 May 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615819; cv=none; b=BZZnDqNkkfjYbbc7xZBfqTyF3ciQSUwyzDsL9DVMZnP5irNTNV4nNaIDDuGuQsPOv3rUko9tdaz+v5YoUwEQOjJ/0NZcnTaHBr4Uhc5GsK1ArLHPxVOYTgBh4/EvC84bwHlfNSBqh95Ifi0mhQ03GyCLs6dY1SnEI28MauCf1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615819; c=relaxed/simple;
	bh=UwkbNJ/LhEqQDshzKbZr9srvN+VwiPAypEJ5b7aSen0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Orf9YucxefwtnJeOJxkxHBHj7GUAZ1KhDpmOmh62LAKbuOYwyQp1+BT9ROER6qqr51mxHVXLX60CQ3QdMrjGEUKjqAfOZ1CToO/gjeCo2pt7fiMcq/pXxBC9McfwUpxeelCRS+sTDfeiIKTF9EbVFWbr57sOQ+ggoTVC13ccOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEwDVHr4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0FFC072AA;
	Thu,  2 May 2024 02:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714615818;
	bh=UwkbNJ/LhEqQDshzKbZr9srvN+VwiPAypEJ5b7aSen0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fEwDVHr4+Ss+Eh04xyBCaN8FBaK72OHECX0VAB9ibAy8X3pmCSx8ak9Xxf2qZy1nW
	 Yh5wtqCh4h8DSUD8wr4I+l90PHvY8VLVOzAEsgzTbmqiX0/pCfTLK/pSOT/13aHIen
	 NHRSQMnDSGzaseIyCd6EY266KB+ziaYK5JN0lPCqgyBfVtfEKoeF/EhsAj3au3IbVy
	 rEStbASdHIy5Ptm6jxJXiF4JIN6kmHI2SQHUDmPxGMZgbWPAWXeWahnsD4WMgNfpHr
	 iX8si+GSgLfPxRR9GUKWR9GWYLcIK3MQuMXh8+9IB/IaP29iu81CoVlVkiwA+Bly2x
	 oTvPnQKJBEj0A==
Date: Wed, 1 May 2024 19:10:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v12 09/13] net: Add the possibility to support
 a selected hwtstamp in netdevice
Message-ID: <20240501191016.52b5c92f@kernel.org>
In-Reply-To: <20240430-feature_ptp_netnext-v12-9-2c5f24b6a914@bootlin.com>
References: <20240430-feature_ptp_netnext-v12-0-2c5f24b6a914@bootlin.com>
	<20240430-feature_ptp_netnext-v12-9-2c5f24b6a914@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:49:52 +0200 Kory Maincent wrote:
>  static inline void hwtstamp_config_to_kernel(struct kernel_hwtstamp_config *kernel_cfg,
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index f0e4572cdad5..f6333b8a630d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -46,6 +46,7 @@
>  #include <uapi/linux/if_bonding.h>
>  #include <uapi/linux/pkt_cls.h>
>  #include <uapi/linux/netdev.h>
> +#include <linux/net_tstamp.h>
>  #include <linux/hashtable.h>
>  #include <linux/rbtree.h>
>  #include <net/net_trackers.h>
> @@ -2026,6 +2027,8 @@ enum netdev_reg_state {
>   *	@dpll_pin: Pointer to the SyncE source pin of a DPLL subsystem,
>   *		   where the clock is recovered.
>   *
> + *	@hwtstamp: Tracks which PTP performs hardware packet time stamping.
> + *
>   *	FIXME: cleanup struct net_device such that network protocol info
>   *	moves out.
>   */
> @@ -2400,6 +2403,8 @@ struct net_device {
>  	/** @page_pools: page pools created for this netdevice */
>  	struct hlist_head	page_pools;
>  #endif
> +
> +	struct hwtstamp_provider	*hwtstamp;
>  };
>  #define to_net_dev(d) container_of(d, struct net_device, dev)

Please avoid adding includes to netdevice.h.
IDK if you have more dependencies in later patches but for a pointer
member you don't even need a forward declaration, let alone include.

