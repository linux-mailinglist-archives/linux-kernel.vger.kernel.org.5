Return-Path: <linux-kernel+bounces-87981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531486DBC0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 971541C23922
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D74069314;
	Fri,  1 Mar 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcS3hDub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DA18464;
	Fri,  1 Mar 2024 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276352; cv=none; b=YYiWMho4ncPBrKmR7qBDE+LiG/Q4AFohxtav2IWSVEsQo2t7Fh98b/+9kGQybx68kBGxP+l8qUiB2Fap1Ys8D9+Yjbk9cobOtNPzIXpBlTqZJ2gf0wGwrs3YDcKq8gcbNLkgiFraovhHueyVq8dmzMORz/oYg4aVC2FsAfcO6fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276352; c=relaxed/simple;
	bh=jL1paCHEOa9QLVRu5Ik8YUZsHarWWAgotaMOmfcOHv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFPzhGCzLnLm8p/2zRqmYJfhdVUsTsWB1lmO+JlseHzD4a0H2HVy6oZd4XZED+MTNduIuzhKrz6+KHHmYTUOLU/eECkhGEJVJplS++CAYt4M2h+APejmTpCh2C/hCOt8ED3UHVjCkMRUcmw8zkQtMaXtVm1zvLoahROo7iLG8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcS3hDub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CD6C433C7;
	Fri,  1 Mar 2024 06:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709276352;
	bh=jL1paCHEOa9QLVRu5Ik8YUZsHarWWAgotaMOmfcOHv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VcS3hDub6/Yc/PAbRjoUwgS8EtjeYp8Fw7QbenSaHDgjcV2ngKGKtCWzx4IS1E0pn
	 ZTm3hvXBHI0TI4h/yNEVKEBnwC1v3YDu8QO0BY4tsRzKs0w42F73XhNf4Zb9aC3A8v
	 LQPnh8BaZqjOfUN7N+Jml5NF5iAxW2YOLAHy0wb4MQIXcSaDkljxuKmuYPPgdh5D+i
	 2rY6QXASkRSPICmAcCph2Ha7GQp2DreG8P2pQqXlU2OOEOgueZPUDUmMIcTCIYGjzN
	 guFkKnFmP2ths4UFOjhbHqbFaSvcO6AOTNH+gROcGZB+4yGVi2W3uysUiR8UclLZ/7
	 cU0nJSpFlf1CQ==
Date: Thu, 29 Feb 2024 22:59:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, Simon Horman <horms@kernel.org>, Jiri
 Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, Coco Li
 <lixiaoyan@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netdev: Use flexible array for trailing private bytes
Message-ID: <20240229225910.79e224cf@kernel.org>
In-Reply-To: <20240229213018.work.556-kees@kernel.org>
References: <20240229213018.work.556-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Feb 2024 13:30:22 -0800 Kees Cook wrote:
> Introduce a new struct net_device_priv that contains struct net_device
> but also accounts for the commonly trailing bytes through the "size" and
> "data" members.

I'm a bit unclear on the benefit. Perhaps I'm unaccustomed to "safe C".

> As many dummy struct net_device instances exist still,
> it is non-trivial to but this flexible array inside struct net_device

put

Non-trivial, meaning what's the challenge?
We also do somewhat silly things with netdev lifetime, because we can't
assume netdev gets freed by netdev_free(). Cleaning up the "embedders"
would be beneficial for multiple reasons.

> itself. But we can add a sanity check in netdev_priv() to catch any
> attempts to access the private data of a dummy struct.
> 
> Adjust allocation logic to use the new full structure.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 118c40258d07..b476809d0bae 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1815,6 +1815,8 @@ enum netdev_stat_type {
>  	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
>  };
>  
> +#define	NETDEV_ALIGN		32

Unless someone knows what this is for it should go.
Align priv to cacheline size.

>  /**
>   *	struct net_device - The DEVICE structure.
>   *

> @@ -2665,7 +2673,14 @@ void dev_net_set(struct net_device *dev, struct net *net)
>   */
>  static inline void *netdev_priv(const struct net_device *dev)
>  {
> -	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> +	struct net_device_priv *priv;
> +
> +	/* Dummy struct net_device have no trailing data. */
> +	if (WARN_ON_ONCE(dev->reg_state == NETREG_DUMMY))
> +		return NULL;

This is a static inline with roughly 11,000 call sites, according to 
a quick grep. Aren't WARN_ONCE() in static inlines creating a "once"
object in every compilation unit where they get used?

> +	priv = container_of(dev, struct net_device_priv, dev);
> +	return (u8 *)priv->data;
>  }

