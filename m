Return-Path: <linux-kernel+bounces-158824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0DC8B2569
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B0FB22794
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F7914D435;
	Thu, 25 Apr 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0j+ubtl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436414C5A4;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059630; cv=none; b=q55RzXgF3iORynwaMW1GkerGIQdMUl77K1tMuz4rWDQ+mObBGezrx9r6O13Qeif72ByRfM3lEXqLnO0CYQDgOde8DXYGKmnD8PFhGY9qxItRwb/AB6FWituSPp4XGbfa+5cBYfE91q77wmhQYrtltYwwjkL5/vZNAoeYHBS8Fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059630; c=relaxed/simple;
	bh=3ybUVqEEGzUyKinz8YKEBg22A3kfpANtEE8tiKHbjn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KdPSiX51wsUJtxcZgecslIUOXYwAgT51yIa7FS5e024z1zYAU/HnwMHNqdoj5++5BprYHcNSsfEtT+EXj5dWMrPA42vsWQ0ykcthAAsMOCq6ROkIbmj4YRmZXZZ3iyHdO6uMuWh4ZkK8n3n2dco09DN2QuVYF6ryCUQTrClOimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0j+ubtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 315F8C4AF09;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059630;
	bh=3ybUVqEEGzUyKinz8YKEBg22A3kfpANtEE8tiKHbjn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n0j+ubtls4hqHLXyurwGM9s1uJLxwJRNUrf2GU3qf7LfFLurLWCGR7g2JxziShxaD
	 3AAH4DSE0uKjZnjaW/QVHlihaVmMJ2QM4iEqnQ5q328kRG8DDK6EhBXAOukITjb3ND
	 OSPQllINlW7eFyiX9lBtjZsG8VTDN3+9N3SiZdiqWx6JrkgEG6Mh305p6GzAg6T6de
	 Q5ZrvqNh4f33fTLPmI6vGbmRa3wLfzHD2ad6Z3oMxSzu94jbgnmRs4andOTabHJaN+
	 vJ4OftBEc3vbrVFXytJ+nXRyDP/ZT7GkzVBXuDzs3e9mHhyrwwgOQlg4H3klcZ0NH0
	 bCItniUxVCYuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19B01CF21C3;
	Thu, 25 Apr 2024 15:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix the double free in rvu_npc_freemem()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171405963010.10966.4709994529923785893.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 15:40:30 +0000
References: <20240424022724.144587-1-suhui@nfschina.com>
In-Reply-To: <20240424022724.144587-1-suhui@nfschina.com>
To: Su Hui <suhui@nfschina.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, sumang@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 10:27:25 +0800 you wrote:
> Clang static checker(scan-build) warning：
> drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c:line 2184, column 2
> Attempt to free released memory.
> 
> npc_mcam_rsrcs_deinit() has released 'mcam->counters.bmap'. Deleted this
> redundant kfree() to fix this double free problem.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix the double free in rvu_npc_freemem()
    https://git.kernel.org/netdev/net/c/6e965eba43e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



