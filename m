Return-Path: <linux-kernel+bounces-67173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 213108567E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCD33B2EC74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF34132C21;
	Thu, 15 Feb 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMmjruRo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA34113248E;
	Thu, 15 Feb 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708010701; cv=none; b=niQx7yJ3X0eChXXfDLYRq7AlAud6cNWckvYb1n37l/mOGZczKXPOxm7rAzk/XelKkS2J2MTZzldBlLnU2BK1/jIXN6zLFZkcff1E0nd+K4ryr85YIQDLricDM8UuxcA4SUqweyjNguzejbiscoXyvA71e+DP3Mwk6QUJwawfYYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708010701; c=relaxed/simple;
	bh=uhxRO4ebIbwjJVX5/1bnO3OZrGC6rJ1h4nCHDG4vJzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CutOOY1R2/dtpMIkmN0BvIg9os/XeoIO3isea0uZDiQnqd/oCJGd1irICyoiTJW9tQGvM0Nvh2PrFHbToQdmC1fuhcdxI0TW8V2pTQa9VD6NDeY3pHX6vC4klqeRsuHXZ4iTzmBYZqCONuzA5ZPNQ6xiKpnlErhVuEe3b7FvPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMmjruRo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5FBC433C7;
	Thu, 15 Feb 2024 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708010701;
	bh=uhxRO4ebIbwjJVX5/1bnO3OZrGC6rJ1h4nCHDG4vJzY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QMmjruRo5WurqTin0+zFj9UxmGTzuVcWMCfGelFp0VapOWM+oqTRS2eJohSFyghJl
	 IKKYi/vAI9HKEKEB3eGB+fVqHHc66pHjqlmzZNjZ456kTdv9Jf0T8yCCuRMYZuq5fw
	 HdmVV0sWij6ZIN7bOLlt2OOR82/7pwBERcENhiSrt33JPV7aMvTxig+rjyhFGrzsI5
	 xciFFaeWoI9mESL3MblWHz3NKaAVT5FAs+36H/x4pOvi9UefK3f/k96QaEugPp+e8t
	 J4i26Y+OSsTunQjKYOjbalqKn2YrMH+uorlXDYBgeahdCTC2lptqCs+upD3czpXqX3
	 lDzkeR+hjvo+A==
Date: Thu, 15 Feb 2024 07:24:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 Johannes Berg <johannes.berg@intel.com>, Amritha Nambiar
 <amritha.nambiar@intel.com>
Subject: Re: [PATCH net-next] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <20240215072459.2e3697ee@kernel.org>
In-Reply-To: <20240215112729.1778958-1-leitao@debian.org>
References: <20240215112729.1778958-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 03:27:27 -0800 Breno Leitao wrote:
> Creation of sysfs entries is expensive, mainly for workloads that
> constantly creates netdev and netns often.
> 
> Do not create BQL sysfs entries for devices that don't need,
> basically those that do not have a real queue, i.e, devices that has
> NETIF_F_LLTX and IFF_NO_QUEUE, such as `lo` interface.
> 
> This will remove the /sys/class/net/eth0/queues/tx-X/byte_queue_limits/
> directory for these devices.
> 
> In the example below, eth0 has the `byte_queue_limits` directory but not
> `lo`.
> 
> 	# ls /sys/class/net/lo/queues/tx-0/
> 	traffic_class  tx_maxrate  tx_timeout  xps_cpus  xps_rxqs
> 
> 	# ls /sys/class/net/eth0/queues/tx-0/byte_queue_limits/
> 	hold_time  inflight  limit  limit_max  limit_min

I'm tempted to also get rid of the #ifdefs while at it.

> +static bool netdev_uses_bql(struct net_device *dev)
> +{
> +	if (dev->features & NETIF_F_LLTX ||
> +	    dev->priv_flags & IFF_NO_QUEUE)
> +		return false;
> +
> +	return true;

make this
	return IS_ENABLED(CONFIG_BQL);

And throw in something like:

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a09d507c5b03..119075dff0ee 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1454,6 +1454,9 @@ static const struct attribute_group dql_group = {
        .name  = "byte_queue_limits",
        .attrs  = dql_attrs,
 };
+#else
+/* Fake declaration, all the code using it should be dead */
+extern const struct attribute_group dql_group;
 #endif /* CONFIG_BQL */
 
 #ifdef CONFIG_XPS

You should then be able to remove the #ifdef CONFIG_BQL around the
uses of netdev_uses_bql(), compiler will realize it always returns
false and eliminate the code making use of &dql_group.

