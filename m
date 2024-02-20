Return-Path: <linux-kernel+bounces-72585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3487285B591
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56C0285D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFBC5D477;
	Tue, 20 Feb 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm5E89nk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4A5A110;
	Tue, 20 Feb 2024 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418438; cv=none; b=TGWLIoqKL6pEA95qlGKGrP+Rx92ylKLlJXhmc10mwomBtwu4oLkTl7+aw7ldFb6k9y3NJkswWPOfktvlWJgLZ5cpdZeQnMfwQBMj6h0WARyvMjGco3xy4S+CvaODivf5ZhZ23CdB232lTCy7CYe6/jQjM5wZmzY1D1gq3fds9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418438; c=relaxed/simple;
	bh=2fx/Ssc/6vEiZR2sY8kt9a8iCnW1DDxkpIcLwL+vJD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzGnNbI8zgljtds1/sIjNrRT+E8ArprRYIkuxnua+MMUG9J6Xlo6gImkLR3+D/ptYuAV4QGLzL6yI38FAPn85FddYU7dIWSq189fFuaFRM05npFyx44BUaIetZwPvuDc960Zs7l0cRg8JLBo/hNFef0hWT2S0ZkD1evVh60Zm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm5E89nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22661C433F1;
	Tue, 20 Feb 2024 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708418438;
	bh=2fx/Ssc/6vEiZR2sY8kt9a8iCnW1DDxkpIcLwL+vJD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rm5E89nk2HRkQ+bEY1H7+DJvYFtC3dJbpxGpqVWX+4Ny0wLO5Prw9x2nDYKfJt6Nh
	 KKGaYZaWtJK0vUcr8XiY7jGdYlym4yokpKTacZsi6iTSQnp3ZVeaglRhWGaiqHY/dn
	 OfeikerJ0R0kNihtneUZsYRl2Pc5dY0V9Qu/th/5JltuzhvduD69mhBjVVofCwk0+h
	 ZHXjUsY6LlX43AEpGQjKGYccoLtJhwijsPqGAglKv9vCcWDSKphwIeHrMlBL3judIH
	 daRhGV+86OFsy/xOM2TsUdTufdpjZSHs5v1w+zqXnLw/mstRPRDKcwLAilQDJqRU/f
	 NtjQIUEl/wpfg==
Date: Tue, 20 Feb 2024 08:40:33 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stephen@networkplumber.org,
	f.fainelli@gmail.com, Johannes Berg <johannes.berg@intel.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH net-next v3] net: sysfs: Do not create sysfs for non BQL
 device
Message-ID: <20240220084033.GR40273@kernel.org>
References: <20240219104238.3782658-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219104238.3782658-1-leitao@debian.org>

On Mon, Feb 19, 2024 at 02:42:36AM -0800, Breno Leitao wrote:
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
> 
> This also removes the #ifdefs, since we can also use netdev_uses_bql() to
> check if the config is enabled. (as suggested by Jakub).
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks Breno,

I like that this removes sysfs entries for devices for which they do not
act on.  Although I understand it is not a complete solution - still not
all devices that have these entries use BQL - I think a key value there is
to alleviate potential confusion for users.  And as such, this is a step in
the right direction.

I also like that some #ifdefs disappear.

Reviewed-by: Simon Horman <horms@kernel.org>

..

