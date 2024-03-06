Return-Path: <linux-kernel+bounces-93245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F83872CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71541F27511
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABBD52E;
	Wed,  6 Mar 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yac4jilF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF733E1;
	Wed,  6 Mar 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692828; cv=none; b=uCvETp9Y2Cp2V9K81kspxK1q2ngMEqftfLf4tbt4Bb6SQGZSDYotkqTWWVdH0FYJQNllkkwYKlp/u0Jv2JYRUCuLeZzB2KgEvKTrErcKZv9ZS4uXeoHjb/kMNWVGkcu50lfadF/L/4e23BUsHUWkL3rdL4BxXEq27/L0lNBLvSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692828; c=relaxed/simple;
	bh=92MMhScQvKOwOUfJH1Ov+8drxHUcuft8FoCCp1FHCiw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Hw4sjQddyb89tP7tyZavaupfUD/C97MNXbwlfCZLiobmhQPYjh/5zTQLRsy1i+nm7+VAaiD0aK0/yYNlI+Xf0cmU303FUVRjgP5MvxA1y1kf6SE4/EfCapA30uyI/giXt1iQphUWQUe55wg24ssJeS4d89lL9VJ155pKPjnQlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yac4jilF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76717C433F1;
	Wed,  6 Mar 2024 02:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709692827;
	bh=92MMhScQvKOwOUfJH1Ov+8drxHUcuft8FoCCp1FHCiw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yac4jilFkH2PA/YeuVTeEytqn+8dNOQICLHhE+w5YHBOO7uwyNwcnzeG+aaWlj4XQ
	 opIX0w1Hky7Lwpw+Iqv6P4NgH970uO/b8dBfLsjojey/TF28I3rVaYNckHaj+c19jG
	 f1o+DAMiIGW1SwFSgmpp8GPBlwAVyFXwPFQXogjRIRBfaHtHMGwBkHcIppQj09XYOG
	 SiegF4eYlBi/0tfpGHX+gwbC8whXXyDdXf7f6n80hjU9uLBQ1TvE99dpRylgD8n6G/
	 /XqK47ErbP/qKTNpGKNp1N+mIrgN/dkX9wF5fqSucvGHAEQzT2bdJk2nXgDh24lMut
	 quyhX0XMzerHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56011D9A4BB;
	Wed,  6 Mar 2024 02:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: tuntap: Leverage core stats allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170969282734.7828.2270916559369376396.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 02:40:27 +0000
References: <20240304183810.1474883-1-leitao@debian.org>
In-Reply-To: <20240304183810.1474883-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, horms@kernel.org,
 dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 Mar 2024 10:38:07 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: tuntap: Leverage core stats allocator
    https://git.kernel.org/netdev/net-next/c/46f480ec1458
  - [net-next,2/2] net: tap: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/4166204d7ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



