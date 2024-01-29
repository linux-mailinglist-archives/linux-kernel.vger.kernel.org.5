Return-Path: <linux-kernel+bounces-43471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62285841453
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B011C23FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC51158D76;
	Mon, 29 Jan 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzZPMHWt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B51157E68
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560171; cv=none; b=Jz8cGIIGAN6JTMYHhnnkUHyZZgKEHHAy4xXQ7YuZFQTT8npFIr/iZ0HKEBM7tFYUBJ/KPCXj4pXjqg1HA5NSCME3HIgce/8YOaMeIVqkkCV/00dQRWmN8+qVMmgk7FGZWc2BMfbfyCx5hYCKoy/jxBDFVyJUpESgxkBRwSJacYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560171; c=relaxed/simple;
	bh=1dJSQ6Tnp2+ouIN2nL7yz88hd0l7IGvrUD6ww83AGCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HsM9Yr61uQYSsDR7SohWnycQ6sZqxIYH9Eb1ch07KbcNXnW3KE3pxAJyCEEwG5RaY5whrw42vac2ak4CvlTQCQK424xXuATP0xsxEsUpeWKxb2pZrrxLLCoVln+//lUTOvqvf8TL/ntdwQ63VwhibmEmUj9lATSVr2ZF39JnMLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzZPMHWt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0754AC43390;
	Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560171;
	bh=1dJSQ6Tnp2+ouIN2nL7yz88hd0l7IGvrUD6ww83AGCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzZPMHWtTAC6aGCtBddBG+v34X5vJvNHnhA7bY/RxRJJIzS9PU7pB2ezeYYLCcRIZ
	 BOdJVqin1SshTRvYp/Mi0HLbKotzhnMudhBYEUEZnX2Iz1kfF3XNnUr3dGcf18kN2C
	 rQJKn9rQQibk7YBJjrLeZkE6O+Wi9fXdCQnY0AmZoOrLqyNgWhYDZw7miaLZ2VDROs
	 fU14NZA5S2UcSVeCIpbJJ/OIq+Bvyk745XBoEmVLLy8JU0R3QYuBZ9rWfpjTdYphj3
	 v4rxHKx4gnAk5eHUt1fBBzUOOgMgVq4hYncHFyVwdgyT28Wb6nnTGTyV0wHxi6Nos7
	 AQvgpnPsDvJlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E373EC561EE;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v5 1/6] f2fs: compress: fix to guarantee
 persisting compressed blocks by CP
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170656017092.16041.5056529810169892695.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240112194132.25637-1-chao@kernel.org>
In-Reply-To: <20240112194132.25637-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, daehojeong@google.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 13 Jan 2024 03:41:27 +0800 you wrote:
> If data block in compressed cluster is not persisted with metadata
> during checkpoint, after SPOR, the data may be corrupted, let's
> guarantee to write compressed page by checkpoint.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v5,1/6] f2fs: compress: fix to guarantee persisting compressed blocks by CP
    https://git.kernel.org/jaegeuk/f2fs/c/fe2b98bcae7e
  - [f2fs-dev,v5,2/6] f2fs: compress: fix to cover normal cluster write with cp_rwsem
    https://git.kernel.org/jaegeuk/f2fs/c/bd0dddafd4a5
  - [f2fs-dev,v5,3/6] f2fs: compress: fix to check unreleased compressed cluster
    https://git.kernel.org/jaegeuk/f2fs/c/787f217e7f04
  - [f2fs-dev,v5,4/6] f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode
    https://git.kernel.org/jaegeuk/f2fs/c/6d05c8d5997a
  - [f2fs-dev,v5,5/6] f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic
    https://git.kernel.org/jaegeuk/f2fs/c/ef62f2496f99
  - [f2fs-dev,v5,6/6] f2fs: introduce FAULT_BLKADDR_CONSISTENCE
    https://git.kernel.org/jaegeuk/f2fs/c/e2c2cb1a331f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



