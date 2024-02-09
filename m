Return-Path: <linux-kernel+bounces-60046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21A84FF14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165A71C2317F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEE210EE;
	Fri,  9 Feb 2024 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SG85QO6+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451453A7;
	Fri,  9 Feb 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514957; cv=none; b=Ir63tIv89nV1b6huoJ6DGm/8Kl1u+VgvgDz+z6WucSTH6CdH+6m3dOgKxTU7p+cxoQhUeL8vbNC+6DiUmwWFaHIVthk+P5qbZwUpfDmbUmKQenp86x4Y/9owEoTRJMQ9CVCn4W6Q10T7tqhnQOXmNs5qTcekTLB3ZfawVGdHiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514957; c=relaxed/simple;
	bh=xWTV0j+XWEhF7r66MSqxRlewNpsPiEoDX42SkQ3zba4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr9ItJ3UEhfP9bWcbrXkyOB5F0mcRZhTtF4HlwEKPjq07XLgq7tXCe1W2ciq9SvPtVfAOSp/nXu9So0yz7wWTFv6XWRLD4zu1hzQlSctbGZca+JDh0pzwjXu8HjqK7Wowz/c8qNeHy4COkx2njFjz8jaTFpJbuqTp2qnkFP64c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SG85QO6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8F9C433C7;
	Fri,  9 Feb 2024 21:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707514957;
	bh=xWTV0j+XWEhF7r66MSqxRlewNpsPiEoDX42SkQ3zba4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SG85QO6+LXTZreT+YvX0sJYKvV9V0NRyyAZuiLX7npRQc7gdM8cUlUNM2gMVsZ8G1
	 3Qz3RSr3pQRWb0+A6MqNI3LzEGeznlf7QtuMnNWzZQmddmz0osCMN4b9goz0Z0uRyr
	 AQI0Uia/YxuVT2Tmv7Qwv6/au7qB2KCNb+Zj1r6sOvFtj+4VnoT+a+5ETZkA51PwA8
	 qOaHCPLzlxrxYQ/gguNAh4t6UtwrcfZcWyWEkmOyXaCVGutL3Kp4m6RlJqm+tNk+Np
	 nTqEwU4S6s8GW+H4/DqkZISQsrZNM5szZoNJy8rp7pGbMdcmmHGl3tJMxy0XjQPJMf
	 4hnCgXp/r0drw==
Date: Fri, 9 Feb 2024 13:42:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Michal Simek
 <michal.simek@amd.com>, Paolo Abeni <pabeni@redhat.com>, Radhey Shyam
 Pandey <radhey.shyam.pandey@amd.com>, Rob Herring <robh@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>, Wei Fang
 <wei.fang@nxp.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: emaclite: Use
 devm_platform_get_and_ioremap_resource() in xemaclite_of_probe()
Message-ID: <20240209134235.0f14b93f@kernel.org>
In-Reply-To: <f87065d0-e398-4ffa-bfa4-9ff99d73f206@web.de>
References: <f87065d0-e398-4ffa-bfa4-9ff99d73f206@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Applied, thanks, but in the future please make sure that:

On Mon, 5 Feb 2024 14:55:23 +0100 Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 5 Feb 2024 14:44:20 +0100

You use git-send-email or otherwise get rid of these extra lines.
They appear to confuse the kernel.org patchwork reply bot.

> A wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6

trim hashes to 12 characters.

> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Thus reuse existing functionality instead of keeping duplicate source code.
> 
> This issue was detected by using the Coccinelle software.

