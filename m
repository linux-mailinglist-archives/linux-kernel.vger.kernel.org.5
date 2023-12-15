Return-Path: <linux-kernel+bounces-784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C208145FB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C351E1F234B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A91C684;
	Fri, 15 Dec 2023 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVjcf02p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AB1A71C;
	Fri, 15 Dec 2023 10:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2577AC433C9;
	Fri, 15 Dec 2023 10:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702637424;
	bh=gos3Phm3LB4MOicLuSXStryachdArg/Id/Ku2MRLSmY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PVjcf02plSfFuguW/1OujenYqHq4KR6sO1p8lDrbs3D5vkm0fT6BJl5oidHgfSXFf
	 d5rJV/UUSY4gLKTXPrLxOIzFEl/sOgPu5aPuDYA5IwMweXGRl/sDltbiOWkMdIF9tS
	 YtXet1e93weu4nijohG75pp3ZKKxK411At17CqTFN2/GuxrNopzJNg290zAJlXXi33
	 RTXK/aETZfk2YHUQENBrirjNmbbwJ035GwrBcH/ee4H2xJASVFJRax66P7DhauhVFH
	 1Q0c0ybOC+BQ9aEX9vCWAsRzRW216vEpV+wMpRO+zb31P8krMmrZJMcKNIidEIH5xX
	 QPCd2vWMtLV6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10A4EC4314C;
	Fri, 15 Dec 2023 10:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Return error from sk_stream_wait_connect() if
 sk_wait_event() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170263742406.9428.15969365069894994554.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 10:50:24 +0000
References: <20231214050922.3480023-1-syoshida@redhat.com>
In-Reply-To: <20231214050922.3480023-1-syoshida@redhat.com>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Dec 2023 14:09:22 +0900 you wrote:
> The following NULL pointer dereference issue occurred:
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> <...>
> RIP: 0010:ccid_hc_tx_send_packet net/dccp/ccid.h:166 [inline]
> RIP: 0010:dccp_write_xmit+0x49/0x140 net/dccp/output.c:356
> <...>
> Call Trace:
>  <TASK>
>  dccp_sendmsg+0x642/0x7e0 net/dccp/proto.c:801
>  inet_sendmsg+0x63/0x90 net/ipv4/af_inet.c:846
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x83/0xe0 net/socket.c:745
>  ____sys_sendmsg+0x443/0x510 net/socket.c:2558
>  ___sys_sendmsg+0xe5/0x150 net/socket.c:2612
>  __sys_sendmsg+0xa6/0x120 net/socket.c:2641
>  __do_sys_sendmsg net/socket.c:2650 [inline]
>  __se_sys_sendmsg net/socket.c:2648 [inline]
>  __x64_sys_sendmsg+0x45/0x50 net/socket.c:2648
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x43/0x110 arch/x86/entry/common.c:82
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> [...]

Here is the summary with links:
  - [net] net: Return error from sk_stream_wait_connect() if sk_wait_event() fails
    https://git.kernel.org/netdev/net/c/cac23b7d7627

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



