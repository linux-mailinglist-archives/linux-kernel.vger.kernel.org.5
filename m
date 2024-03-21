Return-Path: <linux-kernel+bounces-109632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7B881BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1578F281FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA653BA4B;
	Thu, 21 Mar 2024 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNBlNzNG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B108B651;
	Thu, 21 Mar 2024 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992823; cv=none; b=Q7Uwa85EeiPIyXFZDq5N6sLwvpKyJtXDx/7kiwM1zTFv05jX//wvk7dKjexLfAf3UTeop1JXgXqbJ94vTWAWdAxp/wgMKDSmWXQGz/6+19P/6wr1mZMTtApZDSDhigsY7CxRexymcvvlQzd0u1zmH5+D0i6YKj6P+FBxc3MSyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992823; c=relaxed/simple;
	bh=UjsWGfC89SDoNkzeY4LPC8JcQOjMf7eJwJBKewmtRqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPAp+5tuobMnSgRae1aB/A/Uhyz0jgq+lMazSUqlBKC4dX7MzhUpOLsGaPf6N0tZbvHunlR20z6gman+hktit5qaMQpB+4dePNxe+JgDjfd/nvNnAZtWSCU+LZ0JpAV4ekM8Ha8fVtpXogVxTfIu58bXMOmA7Ogbj84p9Jbruuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNBlNzNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0298AC433C7;
	Thu, 21 Mar 2024 03:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710992822;
	bh=UjsWGfC89SDoNkzeY4LPC8JcQOjMf7eJwJBKewmtRqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VNBlNzNGmyYIT0jm/sLX0LuDA9AxU6BAbqarAIsgmSBFEAQMmpFGFmY5uv6xVUm7e
	 sLu7X/EVlbqsNK3TehYFnmvyuLIMVLyAZ3i+4S96kXGBwsbIHhmJBElhVCQrHJ/3VN
	 Dnz6m7ICfvgSivHiuly6nKFO4n3hVl5FGe//iQORnABPhwALFJpsqczrz5ITV5VkFW
	 PE3ntSqP1M2bKiAbjRoplW1i31YmWPHMw2JEq++30eusg7yCBNAqYrUfUf+sU8Ehs+
	 n+7wxpY0PTzgNi4oosoJe8QjzNjRQ+GTXFlIkX79bcdbOY7tSqEAMxcJp+s50fYZEO
	 haM1SZ2V+hNdQ==
Date: Wed, 20 Mar 2024 20:47:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhishek Chauhan <quic_abchauha@quicinc.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Halaney
 <ahalaney@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel@quicinc.com
Subject: Re: [PATCH net-next v1] net: Rename mono_delivery_time to
 tstamp_type for scalibilty
Message-ID: <20240320204701.6012a58d@kernel.org>
In-Reply-To: <20240320211839.1214034-1-quic_abchauha@quicinc.com>
References: <20240320211839.1214034-1-quic_abchauha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 14:18:39 -0700 Abhishek Chauhan wrote:
> mono_delivery_time was added to check if skb->tstamp has delivery
> time in mono clock base (i.e. EDT) otherwise skb->tstamp has
> timestamp in ingress and delivery_time at egress.

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


