Return-Path: <linux-kernel+bounces-51089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B02584865A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF741C209CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD775DF2A;
	Sat,  3 Feb 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfxyDZWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D68441744;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706964626; cv=none; b=kPxr1aH1WRSxnysiqa0qYhskVaizXZMubvcQry1t1CdkV2amlkTHdk4sIr74Z19FCOhPB7J1FSFJcSz8kqWqIPeIi5YuNSUryjY3Q2m1U6F+VzrQbEmr+lGLDkh/DK3z6kLmnc2b/YZaO+WoYjnjyaTLV/BWtKkGoMgDqu9ty8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706964626; c=relaxed/simple;
	bh=Yzm4nkb8Kf+C6fKBjMy+5A+MsweSAM1/vdVQOYBoCQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iyBlvReXyvtKUgwhDiFBwINEZK3YMhvxn+hKpv3z8YVblkqpoXh8lVAhrlEyxYNpyyulK2xdlZdjwNDNqHOeQp3u6g21e+dxH28qdoP6u8zuowjnf+mplN78E7GlGwbajUHlfQ/xOgMpFW0wAOFFEjQ/Zgf8fjox6RsNYlcxUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfxyDZWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 322D5C433B2;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706964626;
	bh=Yzm4nkb8Kf+C6fKBjMy+5A+MsweSAM1/vdVQOYBoCQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rfxyDZWzm9jTw6Cc7iP2Zet22pVZNzxB40ywgfnvt+1oi2Zk1a3Iiu6vPlxxIqodP
	 XJyUAacpTVzk0bb8+R18cWYYLLbwpW81gx7jSembAqztIME5++JPidCeNtdFdh9Vhs
	 amXmmHTQoP8gIU/gW2H9/M3rhOSei/6M+I37iUUcMMXzNDo9osmLpZrvJ2qMnG0Ihj
	 O717XhlUpRUwTje/P5DYntSZS5X1/J3BLCD+1mf17ezvHvfGluTMeT5Y3bkpV/7In6
	 HeJ8nLqEsZ4WjYCQXUQLtUCCtB25izdu6IAfvgUDPh2vb/9P8pPsb8+Qxmb0+1lHn+
	 1uAtfdcAD2E2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C72FDC99E8;
	Sat,  3 Feb 2024 12:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-pf: Fix a memleak otx2_sq_init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170696462604.20224.1934212959453811747.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 12:50:26 +0000
References: <20240201124714.3053525-1-alexious@zju.edu.cn>
In-Reply-To: <20240201124714.3053525-1-alexious@zju.edu.cn>
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jesse.brandeburg@intel.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  1 Feb 2024 20:47:13 +0800 you wrote:
> When qmem_alloc and pfvf->hw_ops->sq_aq_init fails, sq->sg should be
> freed to prevent memleak.
> 
> Fixes: c9c12d339d93 ("octeontx2-pf: Add support for PTP clock")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_common.c   | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Here is the summary with links:
  - octeontx2-pf: Fix a memleak otx2_sq_init
    https://git.kernel.org/netdev/net/c/b09b58e31b0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



