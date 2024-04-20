Return-Path: <linux-kernel+bounces-152107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9897C8AB93E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1228176E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F881D28D;
	Sat, 20 Apr 2024 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGCX0zmZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0568205E20;
	Sat, 20 Apr 2024 03:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713584427; cv=none; b=n0T/QsAEjOuF0xFULUGh9OCB2J24h6mBTRY/twMtEx+rusGOu9f2nFTrnlEhgO3TR5/PfjPCuZQc0jhxJHLN0/EsewYm3ZcBuI1hdUEabZ/4HWpVlYBbiboLMljXfONVLQFKGhaGqXFEBWYRK8aFd8spYfAPEGDPYucy9XLfFHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713584427; c=relaxed/simple;
	bh=lDtOSzSqPPZ0dGZqkNge31vzyoqc90LYNfr3sVGBpcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IKs1YkxflFNSgoMvxNWW+AN53f7L/HwJF2a4awpzPEQFmqzx9yntmZq48imSkCEDz3W86hLTOSzGu8+o2WUSlPeWahCcrjJFTkq+HFQbkiEM6v4HXL7K1jyD+9C63LCJRwUiTx3pp38Pvo9dP6kF299vBTOp2yT/8IbP/2cql+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGCX0zmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FE9FC2BD11;
	Sat, 20 Apr 2024 03:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713584427;
	bh=lDtOSzSqPPZ0dGZqkNge31vzyoqc90LYNfr3sVGBpcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hGCX0zmZ7i2woZjbqSYZDISyu4iuARiIbWUKO8YHomBokXQfciqz4lPp+mA47/I7M
	 WXm5uGcH663RcB1rIN/UryIHG43Urh0SvYWo4S8y4lK1PbJj972Y86AmnT34a+lkqu
	 wVkQjW+09kVFd/M8arHKNopzqGZ6dYQEGM/tMWx804uc4Cs2mq2BvmQF6OtulFWVH4
	 h4kb9BBBcFbfPVqywrtmzVUKXXDhNPIvRaZ6d8MtKJta/wWjGeA6nFZ142SEJ8CUGX
	 Tggu5spGIHJzQxj4UlQHrjGbmBZ5MP1p03OXC068kK3xwRnd6YyrK8Rm/J43KSnTzW
	 ppqdR4oHXipOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7AD64C433E9;
	Sat, 20 Apr 2024 03:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bcmasp: fix memory leak when bringing down
 interface
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171358442749.25664.16758202671415844398.git-patchwork-notify@kernel.org>
Date: Sat, 20 Apr 2024 03:40:27 +0000
References: <20240418180541.2271719-1-justin.chen@broadcom.com>
In-Reply-To: <20240418180541.2271719-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, florian.fainelli@broadcom.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 11:05:41 -0700 you wrote:
> When bringing down the TX rings we flush the rings but forget to
> reclaimed the flushed packets. This leads to a memory leak since we
> do not free the dma mapped buffers. This also leads to tx control
> block corruption when bringing down the interface for power
> management.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bcmasp: fix memory leak when bringing down interface
    https://git.kernel.org/netdev/net/c/9f898fc2c31f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



