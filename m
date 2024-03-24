Return-Path: <linux-kernel+bounces-114507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55997888AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86F4F1C290BD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B8157A5C;
	Sun, 24 Mar 2024 23:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5FB8nBI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DC1FB061;
	Sun, 24 Mar 2024 23:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322129; cv=none; b=XRtgnuqnt6/h1LqU46fZMJQ/1+nnPy2uqxeNeuug3bdm0TB3+F1YVMeLFnHVnAfC3ambpjfiwzy+kbhQGNGRgV6FykQSzCODW7l/rRrlHLzh7ODtjK2LhGSy/Fnhcy3qIu0H99BDQNRX6mpkbWo1kYTzAzEDd9HnbA10AbYzn7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322129; c=relaxed/simple;
	bh=qZZ0B7thLND9AEuPjl/d4QKT00pV/e/qqEebBteDWf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUKDAFD7aKS4vUYwhSJuy6QHJdsVq4SveoeiobTWUJzPbDI/6YN/EJuhk3SMo+ikWeMmUYnvDyNUpNOTZ51W0s2ZggMH860XXIrKna7ddD+rLacuBWqMuMjNlHeso7YYMY6EUagl9JItE+9znElAA58+rX2ZYtiGOjr84E0w8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5FB8nBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78466C43330;
	Sun, 24 Mar 2024 23:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322128;
	bh=qZZ0B7thLND9AEuPjl/d4QKT00pV/e/qqEebBteDWf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5FB8nBIOYJJN+uXW5PXeTfGPPOPa1SwicUM8Q0GMQaU51WE3/IfxqZO1X+i0DLc3
	 o0SDnTTcLdQFNVF3IDeJuxL/4k+W++VzHjEEJd8nSifEp6ddYJ4+eeikTRmWOd8gjq
	 2dRKTbOFSza/PEWf3I2t2XFTmQsbAo2FMVm3HZoeDUGThQ8fE9I13wQbRExfAZbh3h
	 38N5os/73jYkYHPxNo5dj3ClXBWBzf1lwglXQNVDcqdzP+d93bpe27CPgNfDUT1eob
	 NDsg/JTxUF7N0+BoxEfymePDmBZ2nQPYwx+vGWSwn4DkAJGagApUuIYwAFoMfINGjE
	 Sw8+9lB1RGlCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 204/451] Bluetooth: af_bluetooth: Fix deadlock
Date: Sun, 24 Mar 2024 19:08:00 -0400
Message-ID: <20240324231207.1351418-205-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit f7b94bdc1ec107c92262716b073b3e816d4784fb ]

Attemting to do sock_lock on .recvmsg may cause a deadlock as shown
bellow, so instead of using sock_sock this uses sk_receive_queue.lock
on bt_sock_ioctl to avoid the UAF:

INFO: task kworker/u9:1:121 blocked for more than 30 seconds.
      Not tainted 6.7.6-lemon #183
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __schedule+0x37d/0xa00
 schedule+0x32/0xe0
 __lock_sock+0x68/0xa0
 ? __pfx_autoremove_wake_function+0x10/0x10
 lock_sock_nested+0x43/0x50
 l2cap_sock_recv_cb+0x21/0xa0
 l2cap_recv_frame+0x55b/0x30a0
 ? psi_task_switch+0xeb/0x270
 ? finish_task_switch.isra.0+0x93/0x2a0
 hci_rx_work+0x33a/0x3f0
 process_one_work+0x13a/0x2f0
 worker_thread+0x2f0/0x410
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe0/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

Fixes: 2e07e8348ea4 ("Bluetooth: af_bluetooth: Fix Use-After-Free in bt_sock_recvmsg")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/af_bluetooth.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index f1b7510359e4b..3f9ff02baafe3 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -264,14 +264,11 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
-	lock_sock(sk);
-
 	skb = skb_recv_datagram(sk, flags, &err);
 	if (!skb) {
 		if (sk->sk_shutdown & RCV_SHUTDOWN)
 			err = 0;
 
-		release_sock(sk);
 		return err;
 	}
 
@@ -297,8 +294,6 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	release_sock(sk);
-
 	if (flags & MSG_TRUNC)
 		copied = skblen;
 
@@ -521,10 +516,11 @@ int bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 		if (sk->sk_state == BT_LISTEN)
 			return -EINVAL;
 
-		lock_sock(sk);
+		spin_lock(&sk->sk_receive_queue.lock);
 		skb = skb_peek(&sk->sk_receive_queue);
 		amount = skb ? skb->len : 0;
-		release_sock(sk);
+		spin_unlock(&sk->sk_receive_queue.lock);
+
 		err = put_user(amount, (int __user *)arg);
 		break;
 
-- 
2.43.0


