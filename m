Return-Path: <linux-kernel+bounces-103563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CF987C121
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26F61C20B28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9162A73529;
	Thu, 14 Mar 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2h/Tn7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC16873500;
	Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710433231; cv=none; b=m7uTbVjyVeFSvwjp9tl5ozHgQTE86hiEr3HOnB2RBEOv+WgCms8Bst7DNLTfufIXqkR5SaWGBRIYkQj2o4PTJlZRno1bcgf87yokkwYTILYEiwUprNuUJhmPCL2ooN+wh89cKMpDvAXecaHOF+BzT+MGYeS9+mXsiWnLopKVWdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710433231; c=relaxed/simple;
	bh=7+09w1oE97rDTiXYwrzXL4LqGid17J4YBQSF+zZK/30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G+25zk9D5cQ+e80HX9rVoPIIVsj5BNG/xXU8eLXugEX6ueifn++82wOtkciSqNjbpGxKuUiIliblvOp5nCSP/odlQU52eePbOqezcuI8t+RsssJ6Yb5uirXpJCzHVn1+qZ4XWmDHZYiLK96uDAvdZY18RQju0wMJxN9upttC7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2h/Tn7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 691D8C433C7;
	Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710433231;
	bh=7+09w1oE97rDTiXYwrzXL4LqGid17J4YBQSF+zZK/30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q2h/Tn7SJ1Z6TURl9ZfaYEeCvSR+2ZpQbTUHRgzIzNga9f8h2nfOqcGVKrI53z7iP
	 1ZrbkD1XirVCgitqPQNlCIpPPRFc78wiqhBKw9BTu0ux/l5f6NofvdBXhkkESHVtXu
	 c4A2nCRMxw59HtDxHNC64kbktzV4c3fvSq/upv2E8CvawZwiryVUbls0FakW/GZqLr
	 lcv3+afq/QQun/4s7hyVjlZrk+adq0zE3T/C452+nxzHVyVe0RQpPfIDhCbmaXAeJH
	 fY8tzQIWxMMExfNzoD07Y/peL59SgjRH3xhjaWXPLNBcXiHA78a6FmkJJjfy76kxPc
	 BfQPOoPiwNAFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 57438C595C3;
	Thu, 14 Mar 2024 16:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: mark inode dirty for
 FI_ATOMIC_COMMITTED flag
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171043323135.13516.13152557202790425298.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 16:20:31 +0000
References: <20240313112620.1061463-1-s_min.jeong@samsung.com>
In-Reply-To: <20240313112620.1061463-1-s_min.jeong@samsung.com>
To: Sunmin Jeong <s_min.jeong@samsung.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj1557.seo@samsung.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 13 Mar 2024 20:26:19 +0900 you wrote:
> In f2fs_update_inode, i_size of the atomic file isn't updated until
> FI_ATOMIC_COMMITTED flag is set. When committing atomic write right
> after the writeback of the inode, i_size of the raw inode will not be
> updated. It can cause the atomicity corruption due to a mismatch between
> old file size and new data.
> 
> To prevent the problem, let's mark inode dirty for FI_ATOMIC_COMMITTED
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: mark inode dirty for FI_ATOMIC_COMMITTED flag
    https://git.kernel.org/jaegeuk/f2fs/c/4bf78322346f
  - [f2fs-dev,2/2] f2fs: truncate page cache before clearing flags when aborting atomic write
    https://git.kernel.org/jaegeuk/f2fs/c/74b0ebcbdde4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



