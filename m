Return-Path: <linux-kernel+bounces-26054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E2C82DA8D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB1B1F22724
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2B17595;
	Mon, 15 Jan 2024 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/EZjsy9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FDF17577;
	Mon, 15 Jan 2024 13:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F5AC433F1;
	Mon, 15 Jan 2024 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705326656;
	bh=BPKbcav8hKWyYniO8mP6S8bRiXKYHLnZvQiLfUnWJCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/EZjsy9OEGxpKnOuSUsPbLrTxrXFT+yOVg5M9WUaBOZw/s8FNAWV7u5iIDQdlhNn
	 2Q6JiJ6YSLClAKQChialuCcfOhLwdp7oszZU1qO5+hAjSqdSElJSpMO32eBQ8JISPU
	 uFQb000fKROVzqr1DqlVmVfSe+7U6P8LI+9vRZ/h1kcX7KGt5HslG2X4xUzzkS1j6Q
	 fgO7W9vRPruy9LMBtFh6rY+xvpgqOrOfAdy4H6HjsbpLdIf55zchy7IPMujDsfoQjr
	 PNbM+3IE+jnay2p/EyHp7fJ8Xle1sdWulkG3ZwFeT0JrNwzjyOtYOEMbg0caKIwJ8Y
	 hlqv1zcSRFCtw==
Date: Mon, 15 Jan 2024 13:50:51 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Eric Dumazet <eric.dumazet@gmail.com>,
	syzbot <syzkaller@googlegroups.com>, stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: Re: [PATCH net] nbd: always initialize struct msghdr completely
Message-ID: <20240115135051.GA432001@kernel.org>
References: <20240112132657.647112-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112132657.647112-1-edumazet@google.com>

On Fri, Jan 12, 2024 at 01:26:57PM +0000, Eric Dumazet wrote:
> syzbot complains that msg->msg_get_inq value can be uninitialized [1]
> 
> struct msghdr got many new fields recently, we should always make
> sure their values is zero by default.
> 
> [1]
>  BUG: KMSAN: uninit-value in tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
>   tcp_recvmsg+0x686/0xac0 net/ipv4/tcp.c:2571
>   inet_recvmsg+0x131/0x580 net/ipv4/af_inet.c:879
>   sock_recvmsg_nosec net/socket.c:1044 [inline]
>   sock_recvmsg+0x12b/0x1e0 net/socket.c:1066
>   __sock_xmit+0x236/0x5c0 drivers/block/nbd.c:538
>   nbd_read_reply drivers/block/nbd.c:732 [inline]
>   recv_work+0x262/0x3100 drivers/block/nbd.c:863
>   process_one_work kernel/workqueue.c:2627 [inline]
>   process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
>   worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
>   kthread+0x3ed/0x540 kernel/kthread.c:388
>   ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
> 
> Local variable msg created at:
>   __sock_xmit+0x4c/0x5c0 drivers/block/nbd.c:513
>   nbd_read_reply drivers/block/nbd.c:732 [inline]
>   recv_work+0x262/0x3100 drivers/block/nbd.c:863
> 
> CPU: 1 PID: 7465 Comm: kworker/u5:1 Not tainted 6.7.0-rc7-syzkaller-00041-gf016f7547aee #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Workqueue: nbd5-recv recv_work
> 
> Fixes: f94fd25cb0aa ("tcp: pass back data left in socket after receive")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

..


