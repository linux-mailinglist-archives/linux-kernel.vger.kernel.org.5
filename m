Return-Path: <linux-kernel+bounces-45684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD7D843413
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6752877A8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECB5F9FA;
	Wed, 31 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6iY/pv9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52FE545;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668827; cv=none; b=UBgdt7mxlWMloboedqBbFQTPkHhEzRh3F/3GvQl3I6JuGcNqH2XlqirTh94NPFpKADKk9GA4st8L5nBvuA2atIyenCdmmvFKllMzK9uZ+i/r/WaEZFy3TT9JOLendNRrPvD/c/ivdFehlQ1VRj8NNuhAiil1MIWfiQLZtXP+Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668827; c=relaxed/simple;
	bh=ri+xtdqHDdAedu6sRg/n0UlatJBbNJKunWM840Atne4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kW2M7u1l7SYNPaPvfT6/8M6cFZCQGP9b+PTY1Sfr+uS5yhuTjwt0b1H1jy3XwzWoCRtlUfIX9cYBGJ7sUudUvNeHQuywHrM6Y306cDA3EGkfRVq0qaDHbKRdxFBR/BwGhyNq0x4Fa3i31GLVgCzSeu/wtNh0Yovi+PPSJM40/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6iY/pv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E99AC43390;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668826;
	bh=ri+xtdqHDdAedu6sRg/n0UlatJBbNJKunWM840Atne4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g6iY/pv9E9iheFF3QaNJfoym3PlztBxYNWx1crzr5v6vk32yc9KKET2axhPJYpWOP
	 4h4MYp0FlTHtGsgmkpTbxIYRnoVY+5gJ7kr9gdJoxke1MJdqlw1Roy5ev4ZWCriV3N
	 P3+okxs7wbEmjbXIalOYHwCjkp3UER+pkll1gkfAsdSW2a0hgxjghlW7nyOzFQjhc2
	 s/jHOmVaJqFOGdhlTFmxkhsJYHzmMKAZa8/p56Kke1VETRj7C0si6tUNniarNnVrUD
	 W5p7mQaN96um2NhapXfN0Ki/9RABZuYylgPaOOExfgwMYmGA2NTX5qZN5h8mX6Lu+u
	 BK4UsBS5WJT6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62EC6E3237E;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] bridge: mcast: fix disabled snooping after long uptime
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666882640.24091.16393026544437992064.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 02:40:26 +0000
References: <20240127175033.9640-1-linus.luessing@c0d3.blue>
In-Reply-To: <20240127175033.9640-1-linus.luessing@c0d3.blue>
To: =?utf-8?q?Linus_L=C3=BCssing_=3Clinus=2Eluessing=40c0d3=2Eblue=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
 roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 27 Jan 2024 18:50:32 +0100 you wrote:
> The original idea of the delay_time check was to not apply multicast
> snooping too early when an MLD querier appears. And to instead wait at
> least for MLD reports to arrive before switching from flooding to group
> based, MLD snooped forwarding, to avoid temporary packet loss.
> 
> However in a batman-adv mesh network it was noticed that after 248 days of
> uptime 32bit MIPS based devices would start to signal that they had
> stopped applying multicast snooping due to missing queriers - even though
> they were the elected querier and still sending MLD queries themselves.
> 
> [...]

Here is the summary with links:
  - [net,v2] bridge: mcast: fix disabled snooping after long uptime
    https://git.kernel.org/netdev/net/c/f5c3eb4b7251

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



