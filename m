Return-Path: <linux-kernel+bounces-91084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E2087096B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62633B25B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC88A626C0;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATryanJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA696025B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=cxZ/zreNSknduZ7igk9C0BSnaXxTVi+kvBpflBoIMmgKljCGZ4ky8+plfM4wKZgTwvvX9XSSSWI/Cc6lNibkJzdm2GrtnDhqkC1BI1MfmwV2iLPHNA+U/pWaK4GfA2AeQ24Xxo5102QdG9AtD0vC+YHbvdVp3q40R9N0KdVGaf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=T/3X6veZz+sGmgDP8Q15OLLlrv9DMOr44wm5m9TkjeM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GXRfegij46iQPsB0xJwqhe2m6+iqARPGDUP7lGT39cEsKgt020ljS1ig5+Xuy6wAPNtOHlRvSTheg3rYQr7zGFyLi8VE6qys1KWOFRHnFL2sC5+YE4al1PLSqJ7iNbmYeaBrTq5jMWO5lKUSY+ReDkx2IHg8K8p/7zqaUuaNqc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATryanJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A051C43394;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576429;
	bh=T/3X6veZz+sGmgDP8Q15OLLlrv9DMOr44wm5m9TkjeM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ATryanJEpR8w0/e4fGxx04fafHwzfufxnkG4e+UIeedu26opiBwueB4q95yqEi1O9
	 DAN3+Q7Pw9JPUR2teOWhQP7v6eP9PXIcyg3/azCR6IuE4XJEZloKJ/0rKlJtGyOaEV
	 T3PbtwnlkVZhlC9R16urInrACZJD9y9mCY9T+qbPd6PVYdy0qM4DZA2xu7yppAckIG
	 p5ausljT2UDuYYeq6zbez0TNnkRHG77jsHfOApEi1SD5S1kaHj3j/GE8B2BXYWthMq
	 6bATvzTY05aoDL0C8b/z40TAAa0mUDLQZ7QxQRnKA+/Ndkli7PPEtAPJgFD452FOSW
	 P57xnsOT4vQNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9C91D88F87;
	Mon,  4 Mar 2024 18:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix blkofs_end correctly in
 f2fs_migrate_blocks()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642888.16816.6219443757049318154.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:28 +0000
References: <20240226013208.2389246-1-chao@kernel.org>
In-Reply-To: <20240226013208.2389246-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 26 Feb 2024 09:32:05 +0800 you wrote:
> In f2fs_migrate_blocks(), when traversing blocks in last section,
> blkofs_end should be (start_blk + blkcnt - 1) % blk_per_sec, fix it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: fix blkofs_end correctly in f2fs_migrate_blocks()
    https://git.kernel.org/jaegeuk/f2fs/c/8249aac1b05c
  - [f2fs-dev,2/4] f2fs: relocate f2fs_precache_extents() in f2fs_swap_activate()
    https://git.kernel.org/jaegeuk/f2fs/c/f1e7646a8cd4
  - [f2fs-dev,3/4] f2fs: clean up new_curseg()
    https://git.kernel.org/jaegeuk/f2fs/c/1081b5121b27
  - [f2fs-dev,4/4] f2fs: fix to reset fields for unloaded curseg
    https://git.kernel.org/jaegeuk/f2fs/c/42a80aacb76b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



