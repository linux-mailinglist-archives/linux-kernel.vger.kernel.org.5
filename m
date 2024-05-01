Return-Path: <linux-kernel+bounces-164866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6B8B842F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEA8B21D36
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C711CBD;
	Wed,  1 May 2024 02:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8QUIDFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEBEAF1;
	Wed,  1 May 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529430; cv=none; b=AHOdgyU0cHCKSuxfBoHk5Je25eElREVSLQe1dOUPWIv0foWP8JeB6wJUsC0Y9PdaaGUSLYPrvckU+Oz/qyNaEWD0zxh8fmZ7/GXdD0IUBm2CtCSqKyG1EYB2w5SllDDnrgnCme95G72d46TTRTSrbXUjRhNJgYKPBnAojtCSRGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529430; c=relaxed/simple;
	bh=d5Ly5JcruZX8uh7wnlyCoDFFtXTCh2J0+FlPRg8u98k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=laSft9RN+71TvXWL6Mj/guFdtvdgSd3dv9hq2eY2mySYadrkL+SxiwZisQxWqDXPnoMrBmY/8FUHuOTnpbr0OQsNi03YBWtAxFz2jitV2swnV8EjhsEyKbm7fk9jy8ncqxQ1zC5fCOXVmgRdRsPTQMD5jrR3ACRUwRJzdjVUzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8QUIDFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F52C4AF19;
	Wed,  1 May 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529430;
	bh=d5Ly5JcruZX8uh7wnlyCoDFFtXTCh2J0+FlPRg8u98k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8QUIDFpN4ES+LwmZvuqh5nBKVzoSHmPoPIMIwJsS1IsRQBerpRmB5S14a9Mji2kb
	 jc2rA6YydyhyFulSzSbEJmg2T0HfSJL8L9sXUC90nQmwqj5Cwtxu61GZOS8jjxmPQ4
	 LTf+X15+6uhSF2V6+h9rnR7nST4B2pvX/h6EwLK96wT6fBMbiEgOKKgtJIJuAYy8Xh
	 A6iOs0ljUFz1l0QHGQPalJ7vw5/pSyiJ3bNrK94e6rzxQZHYpBbyPIZjEN8KJVwmk7
	 Ov9S+udbg4dblM8RNZ5yDLDepOJCn21AGoHKOjSoVH3ntyooFKFiHlW7yP/t7dUU11
	 TCrTfVZg5Knbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF2A2C43616;
	Wed,  1 May 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mptcp: ensure snd_nxt is properly initialized on
 connect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171452942984.31721.7901556762643554206.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 02:10:29 +0000
References: <20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-v1-1-59ceac0a7dcb@kernel.org>
In-Reply-To: <20240429-upstream-net-20240429-mptcp-snd_nxt-init-connect-v1-1-59ceac0a7dcb@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dcaratti@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, cpaasch@apple.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Apr 2024 20:00:31 +0200 you wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> 
> Christoph reported a splat hinting at a corrupted snd_una:
> 
>   WARNING: CPU: 1 PID: 38 at net/mptcp/protocol.c:1005 __mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
>   Modules linked in:
>   CPU: 1 PID: 38 Comm: kworker/1:1 Not tainted 6.9.0-rc1-gbbeac67456c9 #59
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2.el7 04/01/2014
>   Workqueue: events mptcp_worker
>   RIP: 0010:__mptcp_clean_una+0x4b3/0x620 net/mptcp/protocol.c:1005
>   Code: be 06 01 00 00 bf 06 01 00 00 e8 a8 12 e7 fe e9 00 fe ff ff e8
>   	8e 1a e7 fe 0f b7 ab 3e 02 00 00 e9 d3 fd ff ff e8 7d 1a e7 fe
>   	<0f> 0b 4c 8b bb e0 05 00 00 e9 74 fc ff ff e8 6a 1a e7 fe 0f 0b e9
>   RSP: 0018:ffffc9000013fd48 EFLAGS: 00010293
>   RAX: 0000000000000000 RBX: ffff8881029bd280 RCX: ffffffff82382fe4
>   RDX: ffff8881003cbd00 RSI: ffffffff823833c3 RDI: 0000000000000001
>   RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
>   R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888138ba8000
>   R13: 0000000000000106 R14: ffff8881029bd908 R15: ffff888126560000
>   FS:  0000000000000000(0000) GS:ffff88813bd00000(0000) knlGS:0000000000000000
>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f604a5dae38 CR3: 0000000101dac002 CR4: 0000000000170ef0
>   Call Trace:
>    <TASK>
>    __mptcp_clean_una_wakeup net/mptcp/protocol.c:1055 [inline]
>    mptcp_clean_una_wakeup net/mptcp/protocol.c:1062 [inline]
>    __mptcp_retrans+0x7f/0x7e0 net/mptcp/protocol.c:2615
>    mptcp_worker+0x434/0x740 net/mptcp/protocol.c:2767
>    process_one_work+0x1e0/0x560 kernel/workqueue.c:3254
>    process_scheduled_works kernel/workqueue.c:3335 [inline]
>    worker_thread+0x3c7/0x640 kernel/workqueue.c:3416
>    kthread+0x121/0x170 kernel/kthread.c:388
>    ret_from_fork+0x44/0x50 arch/x86/kernel/process.c:147
>    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [net] mptcp: ensure snd_nxt is properly initialized on connect
    https://git.kernel.org/netdev/net/c/fb7a0d334894

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



