Return-Path: <linux-kernel+bounces-131534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E17B89892C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6838E1C22566
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000412880E;
	Thu,  4 Apr 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBa4gmCH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5D76023;
	Thu,  4 Apr 2024 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238627; cv=none; b=oIzvq9JfiE5G2lF1BkGHSgF7mbB2HJVjHIO47GnmLM5n0Bj72QCn4BDlA8aTQeUOL/2jp8YPQX5jNVSC2mVTHw0DKEWk1z6qbrO6nyu4KQ6Gor6/SBhi8qmLbrW4cKHEftrxQG771BHgpQPu2tFec6wov4k7O70PogbWOOf6trU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238627; c=relaxed/simple;
	bh=/e/3RELV3V5iO9Ru8peq8yOQty9/FY4WyCtQxbYjXRU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sklwnodVUNEDHJStgkYB2CfxOWWz4OPkxa1nrETwABgq8IjMayUt1s4Ca/JcbhwwPXrqS1JKKLlUPFYSp7JEX7glUWjPlWpu2maoUx9dHe1n+089la/mLBH+tRdv8PJfilMZDpFSY4frgBx8HPccjwwZktdLsi5kDeq+ASaptsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBa4gmCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D5DFC43390;
	Thu,  4 Apr 2024 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712238627;
	bh=/e/3RELV3V5iO9Ru8peq8yOQty9/FY4WyCtQxbYjXRU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pBa4gmCHOsXrCH9G4RFkX9/3TAAYu8nMsfNewPXJWKR+5k2Jl26o0OH1ukghUSbBL
	 By/NVCfEfLKMHbZN/xisPjHMBSt4/bP+F5sQb9jRUojy2RhQ/V99GXRhBU2n/ijKwK
	 9VlyjVCSAdQO1xOVXzOjo4qIDEliz22c7FcqONVH+Ar6RwL6VRh1wDHHY2rVZBqYeY
	 fIIw6S1sK8dlaIoEZLBgfoxw/vbAoOM+be6PRKEZt2KQ2ddBRdfDlnt+q+viXIUvTH
	 BidPs0WqeYuZRtr3D9cN/hMphBrJLYWQIyV6iDpki4JRmpKSj26OCDdH6PgBZwx9Pa
	 GfJCdTnVwauyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DB2FD84BA4;
	Thu,  4 Apr 2024 13:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethernet: mtk_eth_soc: Reuse value using READ_ONCE
 instead of re-rereading it
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171223862724.955.4736478868030987627.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 13:50:27 +0000
References: <tencent_C699E9540505523424F11A9BD3D21B86840A@qq.com>
In-Reply-To: <tencent_C699E9540505523424F11A9BD3D21B86840A@qq.com>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  3 Apr 2024 10:54:00 +0800 you wrote:
> In mtk_flow_entry_update_l2, the hwe->ib1 is read using READ_ONCE at the
> beginning of the function, checked, and then re-read from hwe->ib1,
> may void all guarantees of the checks. Reuse the value that was read by
> READ_ONCE to ensure the consistency of the ib1 throughout the function.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> 
> [...]

Here is the summary with links:
  - net: ethernet: mtk_eth_soc: Reuse value using READ_ONCE instead of re-rereading it
    https://git.kernel.org/netdev/net-next/c/04172043bd21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



