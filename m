Return-Path: <linux-kernel+bounces-137766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5755289E6D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87ECD1C2112F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6060663E;
	Wed, 10 Apr 2024 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISrXgCPK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBF37C;
	Wed, 10 Apr 2024 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708920; cv=none; b=rg+ABBFyzFrn1XzjZsFQ7oza6xR+10n4VYfUhZtx+5xbb8x2A6EV6jlxlF+/+mjQXjbhIFwzC8V1cBtMIQ9iMZmmCPtu/zmjbttcPHSG6Lyf5E5ITBlJnakh8fMFutrUWGlrrD6Jdah98LmPFT+0TxqsB1ZBdzBoEc6z9j5YLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708920; c=relaxed/simple;
	bh=VSxgUq61kUsWcaZWrEgm3dkEBvUqhH37KU47deGe+AU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzA/cku44c5QznBCbSPqtghZR7CVrLSllHusvCj12NGoEGWJaku4im5IROFGW8vmg94mPq6SczBipHmq0AFn/Yv4W7jMYiP4+i75DnodnU6Tgw87BNsc7tVZTRiV2vqSwLOyIKwoIZx8F9fxwTCBCe7776q0b5hGWPxFpBkGzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISrXgCPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6735C433F1;
	Wed, 10 Apr 2024 00:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712708920;
	bh=VSxgUq61kUsWcaZWrEgm3dkEBvUqhH37KU47deGe+AU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ISrXgCPKLpqKRgiS//7EoTZzE9qjUj8g7mz3ovtn182yhRaNMrNxz9Q6wu+d9rY/9
	 pnTvcXPnMSeYW+SopTgfHOxUP1ZxtwZshdr+ue6cDN69ZMlU6jD/RchFgZR0ttEria
	 l67+ArarCX8Oa1YC7tvUrG26BK9cTYo3EAoL/4/5E9MnrZ6RVNLU1ABFFnWNacojsN
	 l28iSlBxesUsbs2nLiZ1GdkA5TsbvOH1n8wTwYUwotkexUq0U5nLq4Q6/B1JEVlePB
	 yFz2+nluQpceH3+Q8t2oEa/UsvyHS/xthh4wNhQsLF0vEVBO+VmcA7nF+S2ShUJi8A
	 BQQBkzvgIJr4w==
Date: Tue, 9 Apr 2024 17:28:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: John Fraker <jfraker@google.com>, netdev@vger.kernel.org, Praveen
 Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Shailend Chand <shailend@google.com>, Willem de
 Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 Junfeng Guo <junfeng.guo@intel.com>, Ziwei Xiao <ziweixiao@google.com>,
 Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org,
 kory.maincent@bootlin.com, andrew@lunn.ch, richardcochran@gmail.com
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Message-ID: <20240409172838.247738f3@kernel.org>
In-Reply-To: <661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
References: <20240408180918.2773238-1-jfraker@google.com>
	<661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 09 Apr 2024 10:29:55 -0400 Willem de Bruijn wrote:
> This device calls skb_tx_timestamp in its ndo_start_xmit: the
> prerequisite for SOF_TIMESTAMPING_TX_SOFTWARE.
> 
> All devices support SOF_TIMESTAMPING_RX_SOFTWARE by virtue of
> net_timestamp_check being called in the device independent code.
> 
> To ethtool timestamping maintainers: It's quite unnecessary to have
> each device advertise SOF_TIMESTAMPING_RX_SOFTWARE |
> SOF_TIMESTAMPING_SOFTWARE. In __ethtool_get_ts_info we could just
> always add those flags to the result from the callees.
> 
>         if (phy_has_tsinfo(phydev))
>                 return phy_ts_info(phydev, info);
>         if (ops->get_ts_info)
>                 return ops->get_ts_info(dev, info);
> 
>         info->so_timestamping = SOF_TIMESTAMPING_RX_SOFTWARE |
>                                 SOF_TIMESTAMPING_SOFTWARE;

My gut tells me we force drivers to set the ethtool op because
while at it they will probably also implement tx stamping.

Even more unhelpful point I'll risk making is that we could 
add a test and make people who submit new drivers run it :)

