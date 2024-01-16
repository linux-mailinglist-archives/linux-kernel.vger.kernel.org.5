Return-Path: <linux-kernel+bounces-27146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD7382EB34
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2914B1F2422B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695F3125B4;
	Tue, 16 Jan 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teJThpGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B561E125B7;
	Tue, 16 Jan 2024 09:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D0E3C433F1;
	Tue, 16 Jan 2024 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705395624;
	bh=53zGYMNuY6A9Eru6GhkOhn5Cr1dIJ1faHUaqKCzyNPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=teJThpGpwKmSmAZ3a7jv/FnjTVitb/G9qIZimHkXPdMZs3eNwSZHsuzBDMd5mHtdO
	 4PEOUieCh074GQOOW5LNKoVlULhCnfZdpIoUYqmfhnQk2zJMdrSOGuBnuUZ4rla5o7
	 SnoJeTTupXq+0p3sm2EyqsQLzDpLUXioY+msu7ixQPdm6JxQVhA8G1Q9GhIxCm/lNw
	 iAJaRyJxIvZFYrxOeYenbUA4cSjiiW7uvzxWTv4avVmNYQjQKwtOnXL77bT+SNj8L1
	 3+1PwYNpgJK4lsuNsSgbYXM9ON/yUgMX7/Ss7rVZuzoeQwejfK1l4NCpI10GYXLQPl
	 Ro/8IU8HgKdnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00593D8C96D;
	Tue, 16 Jan 2024 09:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: stmmac: ethtool: Fixed calltrace caused by unbalanced
 disable_irq_wake calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170539562399.29237.17991521216280406145.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 09:00:23 +0000
References: <20240112021249.24598-1-maqianga@uniontech.com>
In-Reply-To: <20240112021249.24598-1-maqianga@uniontech.com>
To: Qiang Ma <maqianga@uniontech.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 12 Jan 2024 10:12:49 +0800 you wrote:
> We found the following dmesg calltrace when testing the GMAC NIC notebook:
> 
> [9.448656] ------------[ cut here ]------------
> [9.448658] Unbalanced IRQ 43 wake disable
> [9.448673] WARNING: CPU: 3 PID: 1083 at kernel/irq/manage.c:688 irq_set_irq_wake+0xe0/0x128
> [9.448717] CPU: 3 PID: 1083 Comm: ethtool Tainted: G           O      4.19 #1
> [9.448773]         ...
> [9.448774] Call Trace:
> [9.448781] [<9000000000209b5c>] show_stack+0x34/0x140
> [9.448788] [<9000000000d52700>] dump_stack+0x98/0xd0
> [9.448794] [<9000000000228610>] __warn+0xa8/0x120
> [9.448797] [<9000000000d2fb60>] report_bug+0x98/0x130
> [9.448800] [<900000000020a418>] do_bp+0x248/0x2f0
> [9.448805] [<90000000002035f4>] handle_bp_int+0x4c/0x78
> [9.448808] [<900000000029ea40>] irq_set_irq_wake+0xe0/0x128
> [9.448813] [<9000000000a96a7c>] stmmac_set_wol+0x134/0x150
> [9.448819] [<9000000000be6ed0>] dev_ethtool+0x1368/0x2440
> [9.448824] [<9000000000c08350>] dev_ioctl+0x1f8/0x3e0
> [9.448827] [<9000000000bb2a34>] sock_ioctl+0x2a4/0x450
> [9.448832] [<900000000046f044>] do_vfs_ioctl+0xa4/0x738
> [9.448834] [<900000000046f778>] ksys_ioctl+0xa0/0xe8
> [9.448837] [<900000000046f7d8>] sys_ioctl+0x18/0x28
> [9.448840] [<9000000000211ab4>] syscall_common+0x20/0x34
> [9.448842] ---[ end trace 40c18d9aec863c3e ]---
> 
> [...]

Here is the summary with links:
  - net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_irq_wake calls
    https://git.kernel.org/netdev/net/c/a23aa0404218

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



