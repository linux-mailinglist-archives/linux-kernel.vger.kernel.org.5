Return-Path: <linux-kernel+bounces-54527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD784B051
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017DAB21F9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF82E3F0;
	Tue,  6 Feb 2024 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyRFyYzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7712A163;
	Tue,  6 Feb 2024 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209427; cv=none; b=V0sUHnIW0Ba5KVaEc5rrmRVbF8njVIYoMC8GO7zxi5JY/7ePfp+qOA5qsuHqAVUNA+AdixT5BsxitL+ingLzLI2QBLPuJh3/Yos3U+dKWoH0nHxCP2Mj799iDp0/b3A8R19Sdif+ZMaH4VcP7gN2Fnix4Z5E7nQEOCWdn26Fkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209427; c=relaxed/simple;
	bh=7xiid5J68OyyF0qfoll+I/r9+MiDNNL7SVHqSPhLgmc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ayl5cmSy8o9ypDC75B9qHjJ+6sXQgRr54YeGNKxgoj+o1Pf44q23dFDEwbrMbh2IzuFx5Z3/CyCNe+Rh+tlAQowjSDMj8SUyRTQmnVAvX/op1jf50N6VG9NvNnA5B2LmWJVmXQyRLkUtL39OTWKGDyUI81amdDngZoaG9JjBkRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyRFyYzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A93CC43390;
	Tue,  6 Feb 2024 08:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707209427;
	bh=7xiid5J68OyyF0qfoll+I/r9+MiDNNL7SVHqSPhLgmc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LyRFyYzufOr0FEED4OjOxvviMyBWDdzDW3a7HJzBjwT387QJulfgLwAfylNl51/JR
	 XNTGUEVI1UlNYklvMgD8qUfT0V2iRWly0fIZ/euis/TTrSSYuK6ALM84nZqfizF+nb
	 lqDiITSmQu0KDTA+qkebkgOIkrh+1xNsh8BzuKs6iXtQ1Lfj8oxsX/2jlsSbrfJzBO
	 EVwTzVhy4xGkL3ATI2NKCg1aBe/pfwpB0/WrkLKP9AuaJ0u3J2IYQ+t+UEPvNpMABM
	 Ey6XyL8YihpLJ9ISgPxaBVa/VXuh5sxl6sHj4wyKyebvLqez73cwnk7vZEXN7bmMqk
	 NCA+Fs05C9B/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2740D8C97E;
	Tue,  6 Feb 2024 08:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: Check the bearer type before calling
 tipc_udp_nl_bearer_add()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170720942692.5299.11209201912745876034.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 08:50:26 +0000
References: <20240131152310.4089541-1-syoshida@redhat.com>
In-Reply-To: <20240131152310.4089541-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+5142b87a9abc510e14fa@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  1 Feb 2024 00:23:09 +0900 you wrote:
> syzbot reported the following general protection fault [1]:
> 
> general protection fault, probably for non-canonical address 0xdffffc0000000010: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000080-0x0000000000000087]
> ...
> RIP: 0010:tipc_udp_is_known_peer+0x9c/0x250 net/tipc/udp_media.c:291
> ...
> Call Trace:
>  <TASK>
>  tipc_udp_nl_bearer_add+0x212/0x2f0 net/tipc/udp_media.c:646
>  tipc_nl_bearer_add+0x21e/0x360 net/tipc/bearer.c:1089
>  genl_family_rcv_msg_doit+0x1fc/0x2e0 net/netlink/genetlink.c:972
>  genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
>  genl_rcv_msg+0x561/0x800 net/netlink/genetlink.c:1067
>  netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
>  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0xd5/0x180 net/socket.c:745
>  ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
>  ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
>  __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()
    https://git.kernel.org/netdev/net/c/3871aa01e1a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



