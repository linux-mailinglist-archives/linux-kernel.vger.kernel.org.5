Return-Path: <linux-kernel+bounces-103219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5800E87BC84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898BD1C214DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4136F507;
	Thu, 14 Mar 2024 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkPyixCS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C641C63;
	Thu, 14 Mar 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710418229; cv=none; b=q5JqpAAk7Ul7z8xq7VohZ8aBfZ24mCzdvN6AXUCgO0nK0NgUDoQ89q1v2gSITC4sRHe0rLoYzL7cpOuDi/lyRdZ7el3hOTInTOCssbG0gmMJlkX7IT5caWXPJhz0zYpQ4yOVmxMFEzOritunNHQ4X0/D+d6DcWC4S7wykCb0OnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710418229; c=relaxed/simple;
	bh=xnyacxUsGH5RW5G5s6Q3bxHinA/BiKUTP9mCzN30/Uw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e4ovITKaEIrOirm56vp+RdZzBEw61uU6eBgLpFwjuBPUBVFk/jv2QmNiXGtDj6qAuTA2oD9PYD7kEXUn8T4Lb4Ow4gMJwwEhusuLr2NrK19S/pzf6TDEkzHjQTvQHoBlMX5OtU/Y4yBxhDvlIIgfH64G4pYaqZudDS3QDlLqCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkPyixCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B514AC433F1;
	Thu, 14 Mar 2024 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710418228;
	bh=xnyacxUsGH5RW5G5s6Q3bxHinA/BiKUTP9mCzN30/Uw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GkPyixCSzTjdMQir/6UYnTNVFtIB2XndGyPI6OInz7UpmOtR4chi33P/TW3AP7clh
	 BseKXGMwFA/pTdrD7Fc2MTnnoozfLr8UKD+QPDHbzQieezHjFvrKTehpyaudUod6lY
	 qZRimTnUvfUotYr+rLgj90waJizPhyL44uAeIz/wBD9PcTWQ2nHwh2uoORo14f+LNB
	 7q13a9FwxYIEgmC5Ea0OUXqOsFpa/eOuHyN34BJXiHGYG0zozDNC0lCevPN5IGlfyC
	 dUd0v0Q26GyIctnDmxvaiuouogm2kgu+MI1r0FIEqDMGc/uKBQNK6qLgCBsg4kF7Kj
	 n/2F/JG4kM0yw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A888D95055;
	Thu, 14 Mar 2024 12:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] hsr: Fix uninit-value access in hsr_get_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171041822862.15565.3799494375308403816.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 12:10:28 +0000
References: <20240312152719.724530-1-syoshida@redhat.com>
In-Reply-To: <20240312152719.724530-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 13 Mar 2024 00:27:19 +0900 you wrote:
> KMSAN reported the following uninit-value access issue [1]:
> 
> =====================================================
> BUG: KMSAN: uninit-value in hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
>  hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
>  fill_frame_info net/hsr/hsr_forward.c:577 [inline]
>  hsr_forward_skb+0xe12/0x30e0 net/hsr/hsr_forward.c:615
>  hsr_dev_xmit+0x1a1/0x270 net/hsr/hsr_device.c:223
>  __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4954 [inline]
>  xmit_one net/core/dev.c:3548 [inline]
>  dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
>  __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
>  dev_queue_xmit include/linux/netdevice.h:3134 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3087 [inline]
>  packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] hsr: Fix uninit-value access in hsr_get_node()
    https://git.kernel.org/netdev/net/c/ddbec99f5857

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



