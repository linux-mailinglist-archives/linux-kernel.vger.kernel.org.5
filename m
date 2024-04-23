Return-Path: <linux-kernel+bounces-155696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181988AF5B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FDAB27AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305F13E3F8;
	Tue, 23 Apr 2024 17:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3CPZkxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950A13DDD1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894029; cv=none; b=gnUzWPuAyL2UQBVCvMQdUu7fBi02qaO1Apt4QyuDEv7eA569hryw5UjzMrEm+lnMwggqIaGeaJ9+7vvkML6aG41xwHgLuPHGRNHBqxCODLSvmJkZNzhdP0LbB8VrqqRcHk0/1Syte+t+XMvNvDv0dFE62KWtV21kwEdiF6TF510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894029; c=relaxed/simple;
	bh=csQ305yttWc8121lQaZ0ps6dzuiXF2gemEPgqD1hBI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XpFLRxlggPl7q7bdBs1QAdsymEYPnX9C4wMdxaEpo6BG+u5InydmTyb9MZIOrJpPN+vQhidCnRPm0G+P4ubK7jTHC+SI+/yJYMxTmZ2geJljj6rntYFGPZS19PyL8c74uKeipdylTiUW8BWhqW27PuJpDTGxLsT46ItWk5k3rDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3CPZkxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E87F4C2BD10;
	Tue, 23 Apr 2024 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713894029;
	bh=csQ305yttWc8121lQaZ0ps6dzuiXF2gemEPgqD1hBI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J3CPZkxgvYJkxkdETIbuD2lpbvjVFjTyLxO05W0GW+On+ng5WB4dlD4AxZw17EX6q
	 NBAOY2sOOltomXyGX8JTIyWX28Ng/Bn6/KSYEz+S3ooNO5+ioMcl6637ipkubmOnwp
	 OLe+KYcTqcE5Bld7OdjufgFYyWZf9AG6jqYSuMn9YMZsjaachTWwrdEnNmwHXkLJEr
	 r1mLsggqOjEwdz9KlWYvNQo6a/WgZltM3N8wANhAgpALg+9YZbTwmSzQ9oQGMgl1aI
	 e0tiqo1Xx5XiUyErT9JXT6zMT1McBcT05KMgqJt8RuatJHGp1tPD0l7PzrT7eNWKUq
	 QwReLEte4nhHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2B81C4339F;
	Tue, 23 Apr 2024 17:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2 1/4] f2fs: convert f2fs_mpage_readpages() to
 use folio
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171389402878.11756.2734701646922544905.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 17:40:28 +0000
References: <20240422062417.2421616-1-chao@kernel.org>
In-Reply-To: <20240422062417.2421616-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 22 Apr 2024 14:24:14 +0800 you wrote:
> Convert f2fs_mpage_readpages() to use folio and related
> functionality.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - fix compile warning w/o CONFIG_F2FS_FS_COMPRESSION reported by lkp
>  fs/f2fs/data.c | 81 +++++++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 41 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2,1/4] f2fs: convert f2fs_mpage_readpages() to use folio
    (no matching commit)
  - [f2fs-dev,v2,2/4] f2fs: convert f2fs_read_single_page() to use folio
    (no matching commit)
  - [f2fs-dev,v2,3/4] f2fs: convert f2fs_read_inline_data() to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/96ea46f30b26
  - [f2fs-dev,v2,4/4] f2fs: convert f2fs__page tracepoint class to use folio
    https://git.kernel.org/jaegeuk/f2fs/c/92f750d847c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



