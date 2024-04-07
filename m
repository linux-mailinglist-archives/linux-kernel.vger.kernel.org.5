Return-Path: <linux-kernel+bounces-134529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E6E89B294
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5EFA1F22303
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A0E3A1B7;
	Sun,  7 Apr 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeQ12fon"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E992B9C1;
	Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712501429; cv=none; b=c45UqLCNeOQgHRjV7T0P6vlhBmAr5s1dTvnvqcbpoJCs3m+HO3sHKWxEngdqUcuHpi/FmHMFR54YKvxuCNsi7Ex7WIVkGG8K1UyDSQOrainkJiOVzcLjEL9HRiVuKmB9UlsCMVz4Rg0n4adsAaW7OknOLu4OtZofDzpUIWlVGfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712501429; c=relaxed/simple;
	bh=aQk3Yyy9piVrWLEVR8PYN/n1VcxkAQ193EE0ww3XonA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/jIxshPWDO+BQMMYSgjs9gtLGbK5C8A/K//Yw2O7zwDFGCG2XnqydPxBloaAaNtPQj5FkW2DQpfRXWjkHbeg6GWLkuI8a0uov9Xe+OIxFNcVXRbPeUi2mLdHjZDie/173omdI31ApfeWp8veLfxcbKF6D6/0C5iK9jrXxzFo50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeQ12fon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B40F3C43390;
	Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712501428;
	bh=aQk3Yyy9piVrWLEVR8PYN/n1VcxkAQ193EE0ww3XonA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eeQ12fonFKYe6UWtEIP60I/s9ZrLwenF6+3lbDDgL8Y7RMIKh30dUzdb7xfMsUCYz
	 MCsTvmUicBzKWetawixIQmOp4vHx1y18j34Ong3ZNJYKZCoqsk+QJT9cE+GFWforSx
	 /VCSAP2u/iss61z/xwryXpPD4fJNkE7Ft4P3GM5pbgjvZGUuWmW+WQcFuY2VYzOvH4
	 UZokeupxBHrHwRE1vj+X4FUARXmKYKgkLOqm1R8o3Rv4SKxKLHzZESezJp8JWHOnub
	 dXd37blzYLQfZomiZv0gjkFKG9Qd6ww/Xj/ln22DG5fgJCGFwb7IGFOlzH85SOeGu+
	 Rp3XLe/N/tnug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3502D2D0E0;
	Sun,  7 Apr 2024 14:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net Patch] octeontx2-pf: Fix transmit scheduler resource leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171250142866.30136.5649896325817369535.git-patchwork-notify@kernel.org>
Date: Sun, 07 Apr 2024 14:50:28 +0000
References: <20240404112427.16805-1-hkelam@marvell.com>
In-Reply-To: <20240404112427.16805-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 sbhatta@marvell.com, gakula@marvell.com, sgoutham@marvell.com,
 naveenm@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 4 Apr 2024 16:54:27 +0530 you wrote:
> Inorder to support shaping and scheduling, Upon class creation
> Netdev driver allocates trasmit schedulers.
> 
> The previous patch which added support for Round robin scheduling has
> a bug due to which driver is not freeing transmit schedulers post
> class deletion.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix transmit scheduler resource leak
    https://git.kernel.org/netdev/net/c/bccb798e07f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



