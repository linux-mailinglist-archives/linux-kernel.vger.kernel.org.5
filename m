Return-Path: <linux-kernel+bounces-99516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF78A87897E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6927F282217
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B355677A;
	Mon, 11 Mar 2024 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umIEwck1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB83BEAE7;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189030; cv=none; b=P1EZf8ZH5iBkXu5hfPeMgJniOUW5cBYLhjZ84wxvmNIxShXJvxdzuFboesGFI9+TiVzwVo/I0/6o2XCIIPiM/vih2/nR5kZx0riB3XkRSOSKdFj96J2ubkoh/tAPNV/C95weRxizsWOTSdP6m5SrMWDUmpyK6JvC7Um5tUJYMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189030; c=relaxed/simple;
	bh=SxyxkMIY/oCMY73rFgud0ZVLMYIPPk7U1ri3ZPOF3C4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=slS9fQTTmA0uJNcwxGJSPXSTPZRfzuDGE3JQbO1gP8Dd+xPQbLBh2Ds686xWvtuluzRvd8uG2LfYmu4cCi9+J1zg/ecnTkCbzybRPDoIvwHQphQQEDykzelT4zznMMGQdT1/E5Mv+E47Ub9LLOW9nYwMGvaufn7QOflXH6QxJNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umIEwck1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84009C43394;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189030;
	bh=SxyxkMIY/oCMY73rFgud0ZVLMYIPPk7U1ri3ZPOF3C4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=umIEwck1yAUY37zdmJzln3BPwQq7fmG/WYsV2ybZ3v89b5vveiHrjASiaa5SF6ASt
	 9nph721w6Inv9vsVKG3uOLXjMGwWUuryqfPOTX4t0EDm2WZz5FK+ZOVsURMABEe7Tc
	 LURY6CTm422sELORUd0kM3XeCj3KEVeA/CqCNFNwICCxpXcmTut4ufdgHspAgchbuU
	 ltkBEzU0RG2hBTChhB3dCcDSRA64zt3gcxtHwCX1Q2Cg3IXmfzWWM0YspNI1lgV5Sx
	 wigH88McOYClKCJSpuuS/x7GUrdIoNi/fjbctGFNL6BaTTktkiv1VsJL5QAu0Hq/rf
	 +EWPqxZZ3XptA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C8CDD95055;
	Mon, 11 Mar 2024 20:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: page_pool: factor out page_pool recycle
 check
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171018903044.23953.7319316878916850808.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 20:30:30 +0000
References: <20240308204500.1112858-1-almasrymina@google.com>
In-Reply-To: <20240308204500.1112858-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linyunsheng@huawei.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 12:44:58 -0800 you wrote:
> The check is duplicated in 2 places, factor it out into a common helper.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  net/core/page_pool.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next,v1] net: page_pool: factor out page_pool recycle check
    https://git.kernel.org/netdev/net-next/c/46f40172b681

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



