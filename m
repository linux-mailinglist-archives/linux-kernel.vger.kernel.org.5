Return-Path: <linux-kernel+bounces-154809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBB88AE14F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9892B2871FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81ED75D8E4;
	Tue, 23 Apr 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI4iRclq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AB58AC4;
	Tue, 23 Apr 2024 09:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865829; cv=none; b=XYp7AVCyzQ8ph9OtOECtAtjeFsI8zRYUNZzq7cV0OcVpeJy3PZ5BdfUPd4VMIB0GIHVG4B5LQNbIApG9EfXucNIjVPnqAbxxdb5nrXOkX4KXVtEC9bfPNpI62sE7Xmu+rinG/oIith1M3cdlkZDw2O833YjAg3ipNq1XZJHLKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865829; c=relaxed/simple;
	bh=kPWD0Aln6Li7YtPDXUBgfs7urIIZrnqALICTlXvMWEY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QXcS8zILDEt9HRI6qfOQftcKZ1zcCrrcyrO9rf6ZEClFCIe6aNidK7eV0XJvtSUWkMr/YVYNtzagyeCrQTF0zm6BM4CdrCWFOSRNrZ1Yl/LfumqA5suJuJgebvKQpSYyq9+WrbVeNaypaPj9roHiOqOsztaW3R0+xQAPpTnmoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI4iRclq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51B05C116B1;
	Tue, 23 Apr 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713865829;
	bh=kPWD0Aln6Li7YtPDXUBgfs7urIIZrnqALICTlXvMWEY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qI4iRclq70VaMrxduvgh6xBsSe/Khvq4gnBb7d6wERn26zEoUvvizy7yc+yUdCn68
	 WHCensD1SkESZBpjzry6rhNMRVq7Fow2FBlcpVgmAMQ8KDf95kts5jKXGA26zWxMe3
	 G/p1BUN35hmfH7xfEzRDDRYzLrGoaZ7lIL7CN+E2frP7x1/8x+qsO3QVPdNl8cReWK
	 wkc+H+GvaQt+aOp60XimyV0a9kLQOGJpnueY8l7qhwzZ85157Gh1KXYgk0LihNt/E4
	 ACJsYiFlcz8qPhzmCoLzIJdtE9SaPzvdkDUWfyWBE5lLMMl0MWwLMzZSXDSD5grisY
	 hHV4jecPpv8xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48650C595D1;
	Tue, 23 Apr 2024 09:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ax25: Fix netdev refcount issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171386582929.14749.16152644239780177329.git-patchwork-notify@kernel.org>
Date: Tue, 23 Apr 2024 09:50:29 +0000
References: <20240419020456.29826-1-duoming@zju.edu.cn>
In-Reply-To: <20240419020456.29826-1-duoming@zju.edu.cn>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jreuter@yaina.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 19 Apr 2024 10:04:56 +0800 you wrote:
> The dev_tracker is added to ax25_cb in ax25_bind(). When the
> ax25 device is detaching, the dev_tracker of ax25_cb should be
> deallocated in ax25_kill_by_device() instead of the dev_tracker
> of ax25_dev. The log reported by ref_tracker is shown below:
> 
> [   80.884935] ref_tracker: reference already released.
> [   80.885150] ref_tracker: allocated in:
> [   80.885349]  ax25_dev_device_up+0x105/0x540
> [   80.885730]  ax25_device_event+0xa4/0x420
> [   80.885730]  notifier_call_chain+0xc9/0x1e0
> [   80.885730]  __dev_notify_flags+0x138/0x280
> [   80.885730]  dev_change_flags+0xd7/0x180
> [   80.885730]  dev_ifsioc+0x6a9/0xa30
> [   80.885730]  dev_ioctl+0x4d8/0xd90
> [   80.885730]  sock_do_ioctl+0x1c2/0x2d0
> [   80.885730]  sock_ioctl+0x38b/0x4f0
> [   80.885730]  __se_sys_ioctl+0xad/0xf0
> [   80.885730]  do_syscall_64+0xc4/0x1b0
> [   80.885730]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> [   80.885730] ref_tracker: freed in:
> [   80.885730]  ax25_device_event+0x272/0x420
> [   80.885730]  notifier_call_chain+0xc9/0x1e0
> [   80.885730]  dev_close_many+0x272/0x370
> [   80.885730]  unregister_netdevice_many_notify+0x3b5/0x1180
> [   80.885730]  unregister_netdev+0xcf/0x120
> [   80.885730]  sixpack_close+0x11f/0x1b0
> [   80.885730]  tty_ldisc_kill+0xcb/0x190
> [   80.885730]  tty_ldisc_hangup+0x338/0x3d0
> [   80.885730]  __tty_hangup+0x504/0x740
> [   80.885730]  tty_release+0x46e/0xd80
> [   80.885730]  __fput+0x37f/0x770
> [   80.885730]  __x64_sys_close+0x7b/0xb0
> [   80.885730]  do_syscall_64+0xc4/0x1b0
> [   80.885730]  entry_SYSCALL_64_after_hwframe+0x67/0x6f
> [   80.893739] ------------[ cut here ]------------
> [   80.894030] WARNING: CPU: 2 PID: 140 at lib/ref_tracker.c:255 ref_tracker_free+0x47b/0x6b0
> [   80.894297] Modules linked in:
> [   80.894929] CPU: 2 PID: 140 Comm: ax25_conn_rel_6 Not tainted 6.9.0-rc4-g8cd26fd90c1a #11
> [   80.895190] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qem4
> [   80.895514] RIP: 0010:ref_tracker_free+0x47b/0x6b0
> [   80.895808] Code: 83 c5 18 4c 89 eb 48 c1 eb 03 8a 04 13 84 c0 0f 85 df 01 00 00 41 83 7d 00 00 75 4b 4c 89 ff 9
> [   80.896171] RSP: 0018:ffff888009edf8c0 EFLAGS: 00000286
> [   80.896339] RAX: 1ffff1100141ac00 RBX: 1ffff1100149463b RCX: dffffc0000000000
> [   80.896502] RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffff88800a0d6518
> [   80.896925] RBP: ffff888009edf9b0 R08: ffff88806d3288d3 R09: 1ffff1100da6511a
> [   80.897212] R10: dffffc0000000000 R11: ffffed100da6511b R12: ffff88800a4a31d4
> [   80.897859] R13: ffff88800a4a31d8 R14: dffffc0000000000 R15: ffff88800a0d6518
> [   80.898279] FS:  00007fd88b7fe700(0000) GS:ffff88806d300000(0000) knlGS:0000000000000000
> [   80.899436] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   80.900181] CR2: 00007fd88c001d48 CR3: 000000000993e000 CR4: 00000000000006f0
> ...
> [   80.935774] ref_tracker: sp%d@000000000bb9df3d has 1/1 users at
> [   80.935774]      ax25_bind+0x424/0x4e0
> [   80.935774]      __sys_bind+0x1d9/0x270
> [   80.935774]      __x64_sys_bind+0x75/0x80
> [   80.935774]      do_syscall_64+0xc4/0x1b0
> [   80.935774]      entry_SYSCALL_64_after_hwframe+0x67/0x6f
> 
> [...]

Here is the summary with links:
  - [net] ax25: Fix netdev refcount issue
    https://git.kernel.org/netdev/net/c/467324bcfe1a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



