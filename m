Return-Path: <linux-kernel+bounces-74617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAB85D6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0831A1C22E90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3690482EF;
	Wed, 21 Feb 2024 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WECPEr6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0097245BF6;
	Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515029; cv=none; b=Tw/GI/n6nQKSQWIjwS358lGV+A4BhvgKA+qEcQchcXH0tV0HUMxhLqtxv4DL1Wyiifxv/hmON4YjFJy8jlbCm7bbFY257wuZAyvXPV2loNDnrpqix8d/kVFwWrTJ0k6xJcMwUvLdqlqWlIOmXkbH3FAoOf/MJMiGpVtr+X5gKDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515029; c=relaxed/simple;
	bh=NXLdR4ilkWyi8GGiRkVZRerJtLtvKOB417YMjaje/lw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NeMrXiHuRF7p2I5nPS1zcMuahIbt4Pse7LPwjRhOUZIdHj86frkXhIzK5NJ0kVLCMm7QMqqn+rinZgXsLHNwwEmvLCJ5SXpD6R/srlThYGIIHkcfio2eH8kdv/sry+FOE1hKfT02BlMS1cWnOHKw62/TGgEVsR6BsFP2jw1ObiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WECPEr6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 97389C43390;
	Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708515028;
	bh=NXLdR4ilkWyi8GGiRkVZRerJtLtvKOB417YMjaje/lw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WECPEr6xmk8e3fW6fgYulnKF8EGcthpd/Svw/zKx0n6KysVD+nb5F0ho+ZDbnGwCf
	 LjIUOVtzDYGJqV3TW4lc6Q2W9TtG/1z0oiBVvtucdORKgrL5nLSj8AQ6+dW/7ieUag
	 I5wln7c4ItFD5ZLj1cMgZrhAlmOH20ovS4f0dyMHCoZ/P60PlMGfVWsbw06/Uo029g
	 mwgE0Qr1Km6hXzMkG25DKutIcCP4fs2zyMVMYWn4ecIbXdf/sR690yMAwq2GpV/tGm
	 eQrd5aK17Ppnb8DTLYQuMEMeNfBibpeYjj5E13+5QAqEpAD+hf6IP9kjCGpPBn33hT
	 hBgQvsUCrI2aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84AABD990D9;
	Wed, 21 Feb 2024 11:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] Use KMEM_CACHE instead of kmem_cache_create
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851502854.15341.13218974486686671017.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:30:28 +0000
References: <20240220073646.102033-1-chentao@kylinos.cn>
In-Reply-To: <20240220073646.102033-1-chentao@kylinos.cn>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 20 Feb 2024 15:36:41 +0800 you wrote:
> As Jiri Pirko suggests,
> I'm using a patchset to cleanup the same issues in the 'net' module.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
> 
> Some cache names are changed to be the same as struct names.
> This change is recorded in the changelog for easy reference.
> It's harmless cause it's used in /proc/slabinfo to identify this cache.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] net: kcm: Simplify the allocation of slab caches
    https://git.kernel.org/netdev/net-next/c/5073d64e99df
  - [net-next,v2,2/5] ip6mr: Simplify the allocation of slab caches in ip6_mr_init
    https://git.kernel.org/netdev/net-next/c/11a548f252c4
  - [net-next,v2,3/5] ipmr: Simplify the allocation of slab caches
    https://git.kernel.org/netdev/net-next/c/eec70af2b41c
  - [net-next,v2,4/5] ipv4: Simplify the allocation of slab caches in ip_rt_init
    https://git.kernel.org/netdev/net-next/c/7eb2bc2481a1
  - [net-next,v2,5/5] ipv6: Simplify the allocation of slab caches
    https://git.kernel.org/netdev/net-next/c/072f88ca5ca4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



