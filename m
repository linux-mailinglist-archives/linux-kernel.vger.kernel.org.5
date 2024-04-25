Return-Path: <linux-kernel+bounces-157943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E18B190C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075D21C21DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0045617984;
	Thu, 25 Apr 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWvVgedG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400771859;
	Thu, 25 Apr 2024 02:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714013497; cv=none; b=InL272luOnlOl0etVGdCWB6GSxiWatTAJOismgY6FJ55wJysJcY9h/QxOivnIsb5Ez3kuMJ6QU4H/D/y3CqdMyzFwW5bmkE6sBN9k5dkHV/dd7LL5qiKgFcHUVuExjzD91u4aCfHD+LMIIT8XEJo8NxYA+C7i2UoBTWPifTmkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714013497; c=relaxed/simple;
	bh=ZbW7mYhSc8Jfh2D+tFZUJ0MPnxJa6BZOEY+fHDg2O6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYErU2xk6ewTQw7AolOD0C4o9Gl+6pxLsjqCmRkTxdyJ3lz0FLtxn7QgG0xmBiMpFXs37y9leZyVtOtYlfsJP5Z266UNi0ivm/c5c5NlT9oUitPJWltFiZVm1ZVOvW8xeA0kG9yNbtLIioSpWyshnSKsSZwmzBOr8DMdYgVVnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWvVgedG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70113C113CD;
	Thu, 25 Apr 2024 02:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714013496;
	bh=ZbW7mYhSc8Jfh2D+tFZUJ0MPnxJa6BZOEY+fHDg2O6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FWvVgedGgqZQxZMR4xZBhYjPqE5DP6fu40tm3JDYOA/ZjCDlNWoPSj6pD60MEcrnq
	 IphIE6TU9nM/VQtnwnFsh0E4kdawivpaDfbRQhFwZTfqRbR7tBjBAkT6y43ZwHCKwO
	 aBuAZv8djQulxEU+imUiGFTOMFiKjA8fEeikIcNKIWE7xm7aW3bI7W3lV3E/g1/AVi
	 77zzyW73ACcR/PEpL5bpvvVdY0i6SEcaHkW1dDIkVRqJUJ4ksdS6EpKexm0lQLoRiT
	 6RBuDJw05l2CR9M4oWSBBx1g68eUg4YDVZKV06TJH33Ia/2jC1QZvJetoTR1/aT6OO
	 VRoqh1TXGWTgw==
Date: Wed, 24 Apr 2024 19:51:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <yanan@huawei.com>
Subject: Re: [PATCH v2] net: ipv6: fix wrong start position when receive
 hop-by-hop fragment
Message-ID: <20240424195135.76d0f232@kernel.org>
In-Reply-To: <20240422091917.3221601-1-gaoxingwang1@huawei.com>
References: <20240422011052.2932165-1-gaoxingwang1@huawei.com>
	<20240422091917.3221601-1-gaoxingwang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 17:19:17 +0800 gaoxingwang wrote:
> In IPv6, ipv6_rcv_core will parse the hop-by-hop type extension header and increase skb->transport_header by one extension header length.
> But if there are more other extension headers like fragment header at this time, the skb->transport_header points to the second extension header,
> not the transport layer header or the first extension header.
> 
> This will result in the start and nexthdrp variable not pointing to the same position in ipv6frag_thdr_trunced,
> and ipv6_skip_exthdr returning incorrect offset and frag_off.Sometimes,the length of the last sharded packet is smaller than the calculated incorrect offset, resulting in packet loss.
> We can use network header to offset and calculate the correct position to solve this problem.
> 
> Fixes: 9d9e937b1c8b (ipv6/netfilter: Discard first fragment not including all headers)

nits:
 - this is not correct format for Fixes, missing quotes
 - please wrap the message at 72 chars
 - please make sure you add spaces after punctuation
 - please make sure you don't send new version of the patch in reply to
   old, add a lore link to previous version under --- instead

About the code - how are you testing this?
What's the packet you're saying we drop?

If transport_header can't be trusted there may be more in this
function to fix..
-- 
pw-bot: cr

