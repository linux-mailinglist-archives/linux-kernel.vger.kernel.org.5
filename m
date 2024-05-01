Return-Path: <linux-kernel+bounces-164867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F58B8434
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE991F2353E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09718C1A;
	Wed,  1 May 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCu/jQ5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D547714A81;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529433; cv=none; b=CJ6Orq9DzcoE+eaXhsn2+r5joh0YmBhcdYon47SYcBIt2Ovi++e0vav8o5LBSbc4zDZwbxO82sd+bvFx0KtboNc4N87zNH0Rcgt5d7UOEIakymeqcYSn0bhsmJRk954TnLW47R0ghL5j2bYy5/CbJ8ihqkef1XDf8idfPsxDQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529433; c=relaxed/simple;
	bh=JkkG2HQgyj4Dng0B7QaD5x4I2y9yo+brfwfoHgYEHBg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NWHuvVCLgBCvs/umqrzBDH/w5t4zFuV4sANkUXQMDTwyDwkj7RUAs11BvM7rFJ7pGJ1+Xqo3Ai/ZPpboKcLWARbO9O1Mm/lGCJYSL5NvTcs6t2IPJ0ta6yA0r0iRrMenJGpuMOb8tIlWZ9JV25OIgmq0oKFXkYhSO2QBf2smo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCu/jQ5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 750AAC4AF1C;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529432;
	bh=JkkG2HQgyj4Dng0B7QaD5x4I2y9yo+brfwfoHgYEHBg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dCu/jQ5NmyxGTDmC2ZTkGBZtLaT9mcTx5KYZoaH1G8PDXalD4JTYU39ryzSsqjIhW
	 xHF55rwWQnvGJe3b1cOrkDB0FnGDJ7dJu1XpRgga0I95uQC923YMDwXbMAd5dDjljO
	 U7xSgwJ91+GFb+7pJ5+CsXIHoLX5CONLMqg5d/anjuaCpciI8cs7teBEoJQpE9x2XQ
	 rQ+GgsE/IvTrRbW8dphtCKWA9gBuUOYwZpB327uHAJQ6xjvKwF8+BwrQLKTm9gCOAY
	 lXUk4+WSuJf7XHUihS7jSQIXH2LzlPNDWhKYwWC7fVAW9lvTr8Q7fGAm9Mv6jcc26H
	 lvHi/6WYP1GMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66935C43616;
	Wed,  1 May 2024 02:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] netpoll: Fix race condition in netpoll_owner_active
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452943241.31721.5323172862996753044.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 02:10:32 +0000
References: <20240429100437.3487432-1-leitao@debian.org>
In-Reply-To: <20240429100437.3487432-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, leit@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 03:04:33 -0700 you wrote:
> KCSAN detected a race condition in netpoll:
> 
> 	BUG: KCSAN: data-race in net_rx_action / netpoll_send_skb
> 	write (marked) to 0xffff8881164168b0 of 4 bytes by interrupt on cpu 10:
> 	net_rx_action (./include/linux/netpoll.h:90 net/core/dev.c:6712 net/core/dev.c:6822)
> <snip>
> 	read to 0xffff8881164168b0 of 4 bytes by task 1 on cpu 2:
> 	netpoll_send_skb (net/core/netpoll.c:319 net/core/netpoll.c:345 net/core/netpoll.c:393)
> 	netpoll_send_udp (net/core/netpoll.c:?)
> <snip>
> 	value changed: 0x0000000a -> 0xffffffff
> 
> [...]

Here is the summary with links:
  - [net-next] netpoll: Fix race condition in netpoll_owner_active
    https://git.kernel.org/netdev/net-next/c/c2e6a872bde9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



