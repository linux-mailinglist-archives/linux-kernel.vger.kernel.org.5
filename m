Return-Path: <linux-kernel+bounces-79435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D62862239
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6241C22C58
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C408D125B7;
	Sat, 24 Feb 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3FNWpNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC53DF60;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740630; cv=none; b=KfD5VS01UIdfo772JpsYIEOzsDsoB+EMh2vlPJcrmo4t/XAUB4mt+7CHU3QagOykfl8o6rljsCi41iup2wDVWWcKApXFwGiiYiVyZincQB6fHZbT/r/zrCTJ5sUS+pQbHYiozMXDOxrTGMjKZ/Asb7WnzqZHQMfuUXJRbnWkkBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740630; c=relaxed/simple;
	bh=e77GtYEPxxvfVtkM1NVQt52Lm19idRQhnyPDhiQsnnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nckmCaquNU8VjZdZwXuWHEkVserGqNfmy/nWLN4rd//tHnkz4wFHynKIXzmTVfgQI8LjjFnWVyfGjJs+3JZSIXbXEUb46G7S6B5+Nh7QfmXYSV6qdi5aFEzHtJKcsMR3Mcoc0QGdBv+DumiNa9tRr/dgKGIYJGwEsy5bk/H20nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3FNWpNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BAC5C43390;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708740629;
	bh=e77GtYEPxxvfVtkM1NVQt52Lm19idRQhnyPDhiQsnnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g3FNWpNV68TN9j78N4t2DRVZPojFmvGfWExKLiB3OhgRnUtc6/m0F1IubxSVWB7g/
	 CvH5j4zAj3KQzS0nyBomJvjxlOmyMpwAi+Hs5trtbN83YAlmm2us+Jufxo04kV5MRc
	 dYncc0gxQlN2ZwGbe2DXx/4eGjIw7OL1/U5oTGSW3QEHU7tnf+KiTFFmFZzUic2+OY
	 THfR/pH3HlMPduHclsF5yCoKMBCLK8QgBX4au84k8nSYzmKoA3YWYsbqfaQkJ+YQnE
	 OAEQ3oi5YC2vFWA8lf3UE4UUEFW8BVD7s8vk70xoYegZ1m7XXk+xXcsvzBJXH7xgcj
	 tjJm8Dkn0ipjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6AF99D84BBB;
	Sat, 24 Feb 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ethtool: avoid rebuilds on UTS_RELEASE change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170874062943.5601.303733296768979294.git-patchwork-notify@kernel.org>
Date: Sat, 24 Feb 2024 02:10:29 +0000
References: <20240220194244.2056384-1-jannh@google.com>
In-Reply-To: <20240220194244.2056384-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Feb 2024 20:42:44 +0100 you wrote:
> Currently, when you switch between branches or something like that and
> rebuild, net/ethtool/ioctl.c has to be built again because it depends
> on UTS_RELEASE.
> 
> By instead referencing a string variable stored in another object file,
> this can be avoided.
> 
> [...]

Here is the summary with links:
  - net: ethtool: avoid rebuilds on UTS_RELEASE change
    https://git.kernel.org/netdev/net-next/c/d2efeb52c344

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



