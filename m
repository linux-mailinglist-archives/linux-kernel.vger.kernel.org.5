Return-Path: <linux-kernel+bounces-45295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A60842E36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775D91F27167
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1140762D6;
	Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MB/YiCOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD56E2A5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647826; cv=none; b=Gd6hPw2jnaWX67Dt1YJ4Cr8++LZvnzmRAGo/D88hpbESaqTUlrfphyXiR3wIJluh2fDwX4HZnRyhRXMbJq4W4a/uZ8nz+9EKRixy8QEaMILMLMsgXagGEtD+/Z+yPbxBcKZaiW/xIWnPftxf5NZqmSYtmtrrQ//QS5TzNLRJUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647826; c=relaxed/simple;
	bh=64/LeL2k+UjUg6/nAXzx8iXURymnJck5XBIH+3IRkjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mHXYsWVfD68p6Rxb+8s/4URNdA1AvoZIJmbKXVDntVPlMrwE1hwRu0nIR7GPtqFwowXJOdlVjNXfE0u7XcGcOPRds8LEjVZyqhzfjxyeRQS/83jUYpp4hPeOlg/qxfwkvx2NMgNxBO6SnO8dE80VrXYCbxZRSnh/Hg9D4gSjPSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MB/YiCOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E00E3C433A6;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647825;
	bh=64/LeL2k+UjUg6/nAXzx8iXURymnJck5XBIH+3IRkjI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MB/YiCOC4uyvx7BN4uXBMWnHtueM4znJQAfrvH420X9tCNDFC9/DItWHkTABswouF
	 HcYzZvyqIU2pyNeRRGgqWNcg2VryZWNOf9wmMf7iFDvKvhsioFr1hXdYx0yEsoH7OQ
	 /PIeWVzSql8aCBDCxXvemmDe7RE+SP0swmQWDAE5mZ9LlFJqon2JfKXmPJglvNF4p+
	 cqBq0r6dWWDozt+iEIQ7Le5iUBgTyBbP+rc0wXiuXiC4bdRdfUjjGJa6Hpb/Z5K3vk
	 GRvQKE2Vu4a79ZptWdGl7VgfSn815tUgBnz9rVd8txazYZbIb3W3PRd/u7lpMQVAYO
	 YMhcfIQOkCebA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C51A2C395F3;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: compress: fix to cover
 f2fs_disable_compressed_file() w/ i_sem
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170664782580.32692.7563939117930612868.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 20:50:25 +0000
References: <20240122022313.3054810-1-chao@kernel.org>
In-Reply-To: <20240122022313.3054810-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 22 Jan 2024 10:23:13 +0800 you wrote:
> - f2fs_disable_compressed_file
>   - check inode_has_data
> 					- f2fs_file_mmap
> 					- mkwrite
> 					 - f2fs_get_block_locked
> 					 : update metadata in compressed
> 					   inode's disk layout
>   - fi->i_flags &= ~F2FS_COMPR_FL
>   - clear_inode_flag(inode, FI_COMPRESSED_FILE);
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: compress: fix to cover f2fs_disable_compressed_file() w/ i_sem
    https://git.kernel.org/jaegeuk/f2fs/c/9f100ecdedc3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



