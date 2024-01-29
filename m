Return-Path: <linux-kernel+bounces-43474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF72D841456
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD61EB25839
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA85515A4B8;
	Mon, 29 Jan 2024 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXGk+NEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CF1157E97
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560171; cv=none; b=AQ8RbqrfYZE69t6SqJiRXeeBJSXIpLgcC9VICNO791J2WTHV00tQ/SZPBT83WCU6onLQUbET8RiXyayD3DSVoxBM1gIiKjINhm/K4ltCu+slLtqvZdEzJPLR4qtvk9OOhRDp+JZ5Dtw5M82vkAOwbNcz6tdy3LNRk+WDloFxQSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560171; c=relaxed/simple;
	bh=yWmpbnXM/oVWfqPBS4YrTlyIBoP8/TRPGn3ZwYhxOQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fyo2dp3hmOgfGICAAqXG+u9IBvDGArUOobpm41xchsccm3YAUXUgwmDTi1DoJjqFOMuOkaicnCiNPXGrw8FFgHbEzUoty3s39gww1oe0Rc0vnHjn3EoeMPJSHkABeFVBG9J7lDS0sPQEQOSxVM07bl7DS2Z7SRyCmmFREJnV8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXGk+NEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16A46C433B1;
	Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560171;
	bh=yWmpbnXM/oVWfqPBS4YrTlyIBoP8/TRPGn3ZwYhxOQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QXGk+NEBDLXPiY4qf66OfTVVGYuQzrMxeMuuu8+Bg/UIKUU7tAzB715eOg9JK3xMt
	 jso/LpSE9BCEO+kekNrlOWslp2pxpLNEVp1pyxaPyh/A87wXUxM0YjtMB5Aji20RcD
	 LxYfmEwJ6bVbgqOIAn0YYtUJOj6T2evLoVOIZa4h+u0pM+hNTBJ8yqR9JdvoHifovl
	 uXCfEbgTKOza5FsWkTUpAb+zTYcf/aYjPA5lED2aE9TORcfp3n8k2RNO4VuhuOSRp0
	 MdMZcjpUpKgkg94prIHeC0baRkqkUYoU9jsysMuwt/IEd/SXPOb8QLAvYqpoXoiyPo
	 chtdtPr6s6WQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAE81C595D2;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to wait completion of last bio
 in zone correctly
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170656017095.16041.709559809690249792.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240129112740.1908649-1-chao@kernel.org>
In-Reply-To: <20240129112740.1908649-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 29 Jan 2024 19:27:40 +0800 you wrote:
> It needs to check last zone_pending_bio and wait IO completion before
> traverse next fio in io->io_list, otherwise, bio in next zone may be
> submitted before all IO completion in current zone.
> 
> Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
> Cc: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: zone: fix to wait completion of last bio in zone correctly
    https://git.kernel.org/jaegeuk/f2fs/c/cd3ac0d15df7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



