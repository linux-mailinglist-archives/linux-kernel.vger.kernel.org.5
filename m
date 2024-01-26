Return-Path: <linux-kernel+bounces-39503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AED83D224
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4F71C23342
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C30567D;
	Fri, 26 Jan 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q348R1if"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04DE17E9;
	Fri, 26 Jan 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233225; cv=none; b=QBeFL9urObh7uJCSWQdtbQhcJzshKNn1sz0qwRQ21sgwbq67+cukP1dmzPV0huNqJahf2NYD+ZQEeIKYWDavHb2DiaNlXY3kKKBPiMO0kkiSn1GiJdlgh+eCMdV2EAUVoW1dtbQ5JRzjNRciz4kLg/YY4DQvejLF6GogVoS4dxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233225; c=relaxed/simple;
	bh=wJvNS3eGItxJktKZUgWX28Xkf8EoVdyha55c9fq7F+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CPE+NXoI8uDiGaamqxOiINjPB8lcc0jQ/KL/XNBeiQu1Lyq1q4ipSfsZRgzyippNcPzkp8LoVfetH25yNXnceKsRQwP5CQMxF+LtyH/2R1li+IpTQGPi5/KUAbN+EPfChIzG1jMw/KM8SFrQyOn3vXawFtQ2QoJ01msoKeVSmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q348R1if; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CB89C433C7;
	Fri, 26 Jan 2024 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706233225;
	bh=wJvNS3eGItxJktKZUgWX28Xkf8EoVdyha55c9fq7F+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q348R1ifm/PCzl/JiXEY/zN3JcP7xRDVrJWCCvpQBId2+KYob9+4+hn/KnCHzne9k
	 jXjAsaOzU74yOEgrOl04r0lyek9JedVU/dRQvteRH0I+tpfQwQIc5Q7AymYXEVX9T0
	 GOz3LvUaLD36DDhvv0ToQSW9TAtP4DqaDhUCVJJK5PyaVPtlm8fz6vQf6cReqeAVh4
	 AYaaGrGJDi/9LFj+treWgltvY+y1bQqwLj0xBuMIabC8l+oLX2IEu1TzapOq7aRwNY
	 jC9xBe4ZKY+Kyo66PgHX69jsECMbRGPHr9ech0FK0esEt+G+kSEVDtaPIFC8nvj81p
	 g22q5ZewA78Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 225C6DFF767;
	Fri, 26 Jan 2024 01:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: set DMA coherent mask to get
 PPE working
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623322513.12449.11770533425186411622.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:40:25 +0000
References: <97e90925368b405f0974b9b15f1b7377c4a329ad.1706113251.git.daniel@makrotopia.org>
In-Reply-To: <97e90925368b405f0974b9b15f1b7377c4a329ad.1706113251.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jan 2024 16:22:09 +0000 you wrote:
> Set DMA coherent mask to 32-bit which makes PPE offloading engine start
> working on BPi-R4 which got 4 GiB of RAM.
> 
> Fixes: 2d75891ebc09 ("net: ethernet: mtk_eth_soc: support 36-bit DMA addressing on MT7988")
> Suggested-by: Elad Yifee <eladwf@users.github.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_eth_soc: set DMA coherent mask to get PPE working
    https://git.kernel.org/netdev/net/c/cae1f1c36661

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



