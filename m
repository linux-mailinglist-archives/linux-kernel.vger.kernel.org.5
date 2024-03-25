Return-Path: <linux-kernel+bounces-117317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9082988AD48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C30B2326E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA07823DB;
	Mon, 25 Mar 2024 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHYyExmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1925C902;
	Mon, 25 Mar 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378806; cv=none; b=YDmoJtVa29CE44XfLOAOSOCo9fXxwC2fSarzsxoXb+jHtVSsXZliR8i8cGNnPvv46cXsx/wtpxtIC06Y9NKiQv7IXfOExefvB4hl6/h2K9zekCHW0Id4CCxpDsQiZTpnHAGwMpzTmmd/kNqfSRUFe+KU5doS4/2zSxgTxlM42i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378806; c=relaxed/simple;
	bh=BGYRiuPHjSs5NCjA0CIitGjed5eRr4jqUQxPMWq3BPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mTe+O6HQc5FlsVU88owdAri8vVS9quzY068XuPOLySYQKqBkZUK4UGyfeJMdn1cgZoSu9ZLx1wjXMW+lef53kUdUwj8rKCxg+ks5+OsD5vGjQLUjxl4GBeDkpz0kbkO9O55zGE/wLa7Mv2SudS9nNG8PXMkBwX3CAPjxgiwXz4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHYyExmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFD22C433A6;
	Mon, 25 Mar 2024 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711378805;
	bh=BGYRiuPHjSs5NCjA0CIitGjed5eRr4jqUQxPMWq3BPk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nHYyExmGNiOZhQziDbe7+xeeHOZWjVZxOHwWuV9FhOUQfF2OTi1E5//i67vI4nxro
	 CvHy2ZjP3wcPgllO8LG4JzLDpg92Bit5c1GtSz83kxclAEIGT/RUUfVZdoUz105btR
	 P+dZAcxK1hOiTGmCfi8kfxkpp356N3/9LntjWLyYZfQw5wSNIArYCFDwMWIHXMqket
	 OTRRGGHvu7tdcbFnJ819ls9EXZzWWFH2xVFfiKXT5q75RwdAPxNi3iAGe/Bycj5Igp
	 eLZwM5Q7YoyvOxEy++f+NPBKTltL2jLKvj2LmCEobhUxZ8Asluv7WrEQy7Z8cOX/x2
	 /FyqRiJtMCYyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA34ED98304;
	Mon, 25 Mar 2024 15:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mark racy access on sk->sk_rcvbuf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171137880582.31307.3532925417151317901.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 15:00:05 +0000
References: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
In-Reply-To: <tencent_5A50BC27A519EBD14E1B0A8685E89405850A@qq.com>
To: linke li <lilinke99@qq.com>
Cc: xujianhao01@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, willemb@google.com,
 wuyun.abel@bytedance.com, leitao@debian.org, alexander@mihalicyn.com,
 dhowells@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 21 Mar 2024 16:44:10 +0800 you wrote:
> sk->sk_rcvbuf in __sock_queue_rcv_skb() and __sk_receive_skb() can be
> changed by other threads. Mark this as benign using READ_ONCE().
> 
> This patch is aimed at reducing the number of benign races reported by
> KCSAN in order to focus future debugging effort on harmful races.
> 
> Signed-off-by: linke li <lilinke99@qq.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: mark racy access on sk->sk_rcvbuf
    https://git.kernel.org/netdev/net/c/c2deb2e971f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



