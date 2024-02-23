Return-Path: <linux-kernel+bounces-77701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFFA860938
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEB9285F5E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2312B1118D;
	Fri, 23 Feb 2024 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ct3hL/ZD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F984D51B;
	Fri, 23 Feb 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657827; cv=none; b=m5lSgkBP1SM/FP2VHlNrTQxOYQBg02h6px0TCJkK5plCe1z9NQSmicbzRn0Na69jdFVgi+BlEnzLJ/BdJ6ZTiwlHRzZCvzA0Md14o0MmUsQ09UReDkgIpUc8fMyziua2hDeRqT71fnzCvfC0AOHBVrNh82VDPl93O90ALKnDKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657827; c=relaxed/simple;
	bh=QjtME8ur+GdL+mJ9frZENuhVBCUAgZEPZM8y+OwSiuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P8w2kLf4ENofmwr28605npDriabd1hmMcbZUha3pkHXwNrAyRjYdNwfAjlKMXP7+3sVaxaAkIftPCf18AG3SXTPN2xN12s/r0d7QeXJoiKeo+c/EvboO2w62rgJRz3hmQcrIaaBPhKIA1AAgTFa+npR5beHEm03ICg2ZCwskxww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ct3hL/ZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F05EAC43399;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657827;
	bh=QjtME8ur+GdL+mJ9frZENuhVBCUAgZEPZM8y+OwSiuU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ct3hL/ZD44jwmkGGw0wbhOy6A6u0KOOpBL0C9s74CHx5/HzGCUdqPvD+EucByHUMu
	 SR/ri0zU48ht+isvH/3q5wC2Ih8j2Qvt15BEXeXdRAXX4MjndMVNWlmXASgxAwv4+a
	 mtmAraH6tN2LuJE/wG8Eq0zRhv3aGEZqzfQpmRVA9hJYBBL8Tn1fSTaoSVE20IDcnu
	 SLcslBWR98/GWyzYTRL2/QHxNJinAzw0jHwUt2VFZi7yfpfDtNeBqyzI0Gz1BAvwHD
	 0npSxL6Xvr9881Gw4ODiZgSTwGxKcU6t/zrr8JxPv0pyULFpFg4NLhhTcCGkMZrIrb
	 roIXgHWgkM1Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD2D9D84BB8;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6/sit: Do not allocate stats in the driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865782690.16544.8099691796729643337.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:10:26 +0000
References: <20240221161732.3026127-1-leitao@debian.org>
In-Reply-To: <20240221161732.3026127-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Feb 2024 08:17:32 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6/sit: Do not allocate stats in the driver
    https://git.kernel.org/netdev/net-next/c/3e7a0dccf070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



