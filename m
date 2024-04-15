Return-Path: <linux-kernel+bounces-145373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C191F8A54CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E34B28251A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C580BF5;
	Mon, 15 Apr 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2U66kEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17474422;
	Mon, 15 Apr 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191853; cv=none; b=hY1E1gppPI+sBNRXN0h0Yt54wme1BvGMHsTp6Lby812MBDPuYmvsu+4JwgIgLN/UC7OMQxXgxE1mnBju2y+BqHJ4qCQNLG+YCzNBGfYmzECQ3fxoK5hgHUC2Vhnpc8nYX7ofj4altIpFYMujnAi+sXGUPKG6HRsJ45vSTdgbmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191853; c=relaxed/simple;
	bh=mhUTj1riFLU3WHmFNiIh/KGH9u9Lzss54tsfYYbbsfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkaPJzc0qp1LAEH64uRK3Asl2nj13ls/4Sfq4tvAFPcunjpGLro7b5RUJdpBFG2VoKfsD1y3x3X38ykZ/qbYGYmMtomxGQb3XZB0J18lShJQE4f8h14h8rBipbpclvzW6zEbk9Fzz/eGHZ/SmVJGwXIi7N2BE+wvQOAdGXlZNUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2U66kEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FF7C113CC;
	Mon, 15 Apr 2024 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713191853;
	bh=mhUTj1riFLU3WHmFNiIh/KGH9u9Lzss54tsfYYbbsfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t2U66kEO+CY77xF9l7sIh9Ip3rc/M8/iXuG6/yMWgrA8zVpGB60XMLPPjckC1fu7u
	 2pja8k0crXLGrpwpD6PXfgqW7aDrV7FK7BIT7aZrS5I/QCILxH9iLayUKBdc/xSSvp
	 U2IJOQYQUHor5PEJhYwzbaVvRJP/uFMdVmTA9nQGUX3X/JbzS5ynwZzsUzhck9xwZ9
	 bjzX4IyrfQMmCL8L4anEf1AuNVYtQxrvGpK+CldFvTSwgDaC/kp/uZQ9+IkZznjBVF
	 mvT1L6h21IEN4B+4NGIHPaJnoqj9+mZ/6FhNfFY6myMH5A58NnZrt8zQGQ5C/PiUtp
	 dUYc/J/0UvDbA==
Date: Mon, 15 Apr 2024 15:37:28 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 2/7] netdev_features: convert NETIF_F_LLTX
 to priv_flag IFF_LLTX
Message-ID: <20240415143728.GB2320920@kernel.org>
References: <20240405133731.1010128-1-aleksander.lobakin@intel.com>
 <20240405133731.1010128-3-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405133731.1010128-3-aleksander.lobakin@intel.com>

On Fri, Apr 05, 2024 at 03:37:26PM +0200, Alexander Lobakin wrote:
> NETIF_F_LLTX can't be changed via Ethtool and is not a feature, rather
> an attribute, very similar to IFF_NO_QUEUE.
> Free one netdev_features_t bit and make it a private flag.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

..

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 0c198620ac93..065dd68fe97c 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1649,6 +1649,8 @@ struct net_device_ops {
>   * @IFF_SEE_ALL_HWTSTAMP_REQUESTS: device wants to see calls to
>   *	ndo_hwtstamp_set() for all timestamp requests regardless of source,
>   *	even if those aren't HWTSTAMP_SOURCE_NETDEV.
> + @ @IFF_LLTX: device supports lockless Tx. Mainly used by logical interfaces,

Hi Alexander,

Sorry if this has already been flagged - I thought so but I can't find it now.

" @ @IFF_LLTX:" should probably be " * @IFF_LLTX:"

Flagged by ./scripts/kernel-doc -none

> + *	such as tunnels.
>   */
>  enum netdev_priv_flags {
>  	IFF_802_1Q_VLAN			= 1<<0,

..

