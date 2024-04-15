Return-Path: <linux-kernel+bounces-144810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4D8A4B08
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E181F22832
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77683BBEF;
	Mon, 15 Apr 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGXPW42b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360DE3BBD2;
	Mon, 15 Apr 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171629; cv=none; b=AyeMgMhNlvHamw8q5ja/6cl34vdt642i5twDLG1Fl/Z+/ykK/xWylIgrMz/wy42gdMSwCFisqwTeM2V6RIeEWQsEu7E7GKKGhG0p097JNdubD2Tv/SLrPCPEl5PhlgZZG68bb306b+zXWauVbJhiyTIPHkPenMqgQKr93/IoLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171629; c=relaxed/simple;
	bh=51eJVjVHOvcMhDWzqZVuBGODmgMp3WO/cfV3E6FX+uI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YtK8sBI5ScXrx6zt5IYDfqoyy+h1ePdfBS4xOHjGZbwTjViII5heUMvmXgZmIdvm7vDbDHzssNh22sP4H1xIHV0rxEQb4dSQUUif29kjfjNSRzk2jFq7zIPblqVMnYXDU27+HF0/5ZtY/lBIeXJbU8FgvjNwCYeic4kJQGNZIVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGXPW42b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD205C2BD11;
	Mon, 15 Apr 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713171628;
	bh=51eJVjVHOvcMhDWzqZVuBGODmgMp3WO/cfV3E6FX+uI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fGXPW42b5Y9aLnmE6aSb6DwO8N1aTIQ2uMpEuDb+oV+De8NhY1fgHcwg+JLQ/qYZZ
	 rHhfnBIaUH73wI3mTdO8oggNrTNeuBrD6abLv2bK7mEKnpM0Kk1OdxIn1G9A2j8bdv
	 qCaUjl6dkpIjwqbDO3D28wnSHuijg4QJYWbAydLzwlUwXbt41Rp36ZJCZ95TE1h21t
	 BhX1o0KmR01xRZE3Zr1sQhH5Ni8BNGuI3VBrtxE/VjB8A2Z7L3OHmJM+74kETTQqlP
	 uiw61cZeQxNXKk8SpH0LmuUBCIiG5KPoXj0NgFab5YBSKVmgoBInjdubDoSoFbSW45
	 evo0U/E/gFUzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA0B4C54BB0;
	Mon, 15 Apr 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] drop_monitor: replace spin_lock by raw_spin_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317162869.5468.9057871796625862999.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:00:28 +0000
References: <20240411141347.15224-1-wander@redhat.com>
In-Reply-To: <20240411141347.15224-1-wander@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: nhorman@tuxdriver.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, chuhu@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Apr 2024 11:13:46 -0300 you wrote:
> trace_drop_common() is called with preemption disabled, and it acquires
> a spin_lock. This is problematic for RT kernels because spin_locks are
> sleeping locks in this configuration, which causes the following splat:
> 
> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 449, name: rcuc/47
> preempt_count: 1, expected: 0
> RCU nest depth: 2, expected: 2
> 5 locks held by rcuc/47/449:
>  #0: ff1100086ec30a60 ((softirq_ctrl.lock)){+.+.}-{2:2}, at: __local_bh_disable_ip+0x105/0x210
>  #1: ffffffffb394a280 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0xbf/0x130
>  #2: ffffffffb394a280 (rcu_read_lock){....}-{1:2}, at: __local_bh_disable_ip+0x11c/0x210
>  #3: ffffffffb394a160 (rcu_callback){....}-{0:0}, at: rcu_do_batch+0x360/0xc70
>  #4: ff1100086ee07520 (&data->lock){+.+.}-{2:2}, at: trace_drop_common.constprop.0+0xb5/0x290
> irq event stamp: 139909
> hardirqs last  enabled at (139908): [<ffffffffb1df2b33>] _raw_spin_unlock_irqrestore+0x63/0x80
> hardirqs last disabled at (139909): [<ffffffffb19bd03d>] trace_drop_common.constprop.0+0x26d/0x290
> softirqs last  enabled at (139892): [<ffffffffb07a1083>] __local_bh_enable_ip+0x103/0x170
> softirqs last disabled at (139898): [<ffffffffb0909b33>] rcu_cpu_kthread+0x93/0x1f0
> Preemption disabled at:
> [<ffffffffb1de786b>] rt_mutex_slowunlock+0xab/0x2e0
> CPU: 47 PID: 449 Comm: rcuc/47 Not tainted 6.9.0-rc2-rt1+ #7
> Hardware name: Dell Inc. PowerEdge R650/0Y2G81, BIOS 1.6.5 04/15/2022
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x8c/0xd0
>  dump_stack+0x14/0x20
>  __might_resched+0x21e/0x2f0
>  rt_spin_lock+0x5e/0x130
>  ? trace_drop_common.constprop.0+0xb5/0x290
>  ? skb_queue_purge_reason.part.0+0x1bf/0x230
>  trace_drop_common.constprop.0+0xb5/0x290
>  ? preempt_count_sub+0x1c/0xd0
>  ? _raw_spin_unlock_irqrestore+0x4a/0x80
>  ? __pfx_trace_drop_common.constprop.0+0x10/0x10
>  ? rt_mutex_slowunlock+0x26a/0x2e0
>  ? skb_queue_purge_reason.part.0+0x1bf/0x230
>  ? __pfx_rt_mutex_slowunlock+0x10/0x10
>  ? skb_queue_purge_reason.part.0+0x1bf/0x230
>  trace_kfree_skb_hit+0x15/0x20
>  trace_kfree_skb+0xe9/0x150
>  kfree_skb_reason+0x7b/0x110
>  skb_queue_purge_reason.part.0+0x1bf/0x230
>  ? __pfx_skb_queue_purge_reason.part.0+0x10/0x10
>  ? mark_lock.part.0+0x8a/0x520
> ...
> 
> [...]

Here is the summary with links:
  - drop_monitor: replace spin_lock by raw_spin_lock
    https://git.kernel.org/netdev/net-next/c/f1e197a665c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



