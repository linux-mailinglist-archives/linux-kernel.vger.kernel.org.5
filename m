Return-Path: <linux-kernel+bounces-158805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC528B251F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BDC281D47
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712014BFAB;
	Thu, 25 Apr 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fypgInQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943EC14AD2E;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059034; cv=none; b=C05/mk+KhLk8KqwaKLdCVuZ1pW8rVf87ZVNVu22xtWbJ1Lfvt4XEq4yRDloJrIYOEIojaNsFdxHd3an70sref4aFAXX6FDunuGeCcaoaW/y0EMrzmU//XiZH7ouAV8iZ/vrrB0Kxkz5BM2V2SvDBxtyPL+SMUHO0L08DO5+KnlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059034; c=relaxed/simple;
	bh=c72zLocSIR3CxXrqJBjeWWnmB7baaCULJUGYE4ucAbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g/Wrx3TeHN7z/omxIMNczbmF/4WESjrcXcxrmYJZqZPjwV9DTeq8YYRuFt3Gd6TxDoMJKdQXockXGT2IV0Tiykv+TEmIva6DQRHR3AqwfVcWWhyq6UxUI1gry/H0JYmpkXWY5rir7HaDVSBVnemJnYzr/jrKE+jdr2m7Iw/70Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fypgInQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D065C4AF08;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059034;
	bh=c72zLocSIR3CxXrqJBjeWWnmB7baaCULJUGYE4ucAbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fypgInQVBcqty0KxIrsiX/GKCIsHgr+fuUZMKrJzrAU/m3t6SmuNMNuQFymOwAvWU
	 LMibSj3p3H4eYdUBhbimaegfVKffq5MaYAI7zfTYnOHhT6+A5PxrnEt300VeKKwYDk
	 Ycw4Df+gSV4rx0iM7jwtxVLunaWzfclMNMFyYdcB0mmh2B1IwOikYmHIlK8iKUn3Rl
	 jX0kNbM0CDPg0ey05biml++lwRjOIq82/PgtvFKd0UVfYedQNSTekpzlO0Jun5iAkx
	 uV3apFJ67zT/2bMhYiwpxKjijPTJUtkhxQQg8phEqvKPLiaowxvb5IFJQYTYBpReUi
	 kmlD/T1T9QopA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 33CD1CF21C4;
	Thu, 25 Apr 2024 15:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg-prueth: Fix signedness bug in
 prueth_init_rx_chns()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405903420.5824.17370077851663422898.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:30:34 +0000
References: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
In-Reply-To: <05282415-e7f4-42f3-99f8-32fde8f30936@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: rogerq@ti.com, danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 jan.kiszka@siemens.com, diogo.ivo@siemens.com, robh@kernel.org,
 grygorii.strashko@ti.com, vigneshr@ti.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 19:15:22 +0300 you wrote:
> The rx_chn->irq[] array is unsigned int but it should be signed for the
> error handling to work.  Also if k3_udma_glue_rx_get_irq() returns zero
> then we should return -ENXIO instead of success.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg-prueth: Fix signedness bug in prueth_init_rx_chns()
    https://git.kernel.org/netdev/net/c/4dcd0e83ea1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



