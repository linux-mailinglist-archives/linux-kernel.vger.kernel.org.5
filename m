Return-Path: <linux-kernel+bounces-31129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08A3832963
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3084EB223ED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD2B4F1FB;
	Fri, 19 Jan 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWIQWMhh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD74C3D2;
	Fri, 19 Jan 2024 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705666227; cv=none; b=ubG25/DEmYQFwXhRZSBPazU+AVP9CzE83hfRB/9Y1V8H047jRL2o761yaVZpUsUI3x92z4KnKZUr9FfsI5cfzyPMY8ldE7EoaGb4F6i6bb//GbAI5zSJ8+qBYqE0f+/6qorjOkkovV7nKzSXka2pkIlEJzS8sbjQERavuLUx8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705666227; c=relaxed/simple;
	bh=tbhDZNX8Hu0WJoh+0t2czyv5HCop/pdxeoCqFNMqCwQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R8dEIW8raGYPDbah3MMBRgvjZEYcSlYh5GAPgtJHf6vRDNWY6/bFpPhGFc68cFngEkTO/IheXr0aGwtn2GsVG1Cl7JMwNc7gMjHRLiaxEqCq0DTu9YPaVhqNsKDOTD5kS8wZ/7gMGA7Jn/aaBEoCbyAAqK4VmBXbTeEtZGpkx2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWIQWMhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4800C43390;
	Fri, 19 Jan 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705666227;
	bh=tbhDZNX8Hu0WJoh+0t2czyv5HCop/pdxeoCqFNMqCwQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FWIQWMhh3Was0aFykIiOLzL663VX+xXSRyIyKRA93uUkTwbLktgFH1v38bw2ZTExs
	 DGnm74ONTTmnj25Oqw4FoFXZm6vi5FNrEWtL3jZ22xUA5ygnDAzzd9pwEEp1j98SaV
	 WU7UvpKb1XQVtLvak7sltm1est4s0p3UT/+SRU58YchAXiXiOL/LDqwyjOXlUcQFRr
	 BtTDBfCmI8wNRTZd8aRSNpe0c8BwsqT1VER8rFSTGngGvRYlxX/rkN0UmdNg155YM/
	 21D4gbvH1fnlAQ37ZhHe8LPT7RZS9tOJ9fxJ0iAO0x7UFn1c5oLrdcX0p2dzgchAU3
	 kAegBWMyMVg4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC8BFD8C96C;
	Fri, 19 Jan 2024 12:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/smc: fix illegal rmb_desc access in SMC-D
 connection dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170566622683.9014.7556475376411939888.git-patchwork-notify@kernel.org>
Date: Fri, 19 Jan 2024 12:10:26 +0000
References: <20240118043210.47618-1-guwen@linux.alibaba.com>
In-Reply-To: <20240118043210.47618-1-guwen@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, ubraun@linux.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Jan 2024 12:32:10 +0800 you wrote:
> A crash was found when dumping SMC-D connections. It can be reproduced
> by following steps:
> 
> - run nginx/wrk test:
>   smc_run nginx
>   smc_run wrk -t 16 -c 1000 -d <duration> -H 'Connection: Close' <URL>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/smc: fix illegal rmb_desc access in SMC-D connection dump
    https://git.kernel.org/netdev/net/c/dbc153fd3c14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



