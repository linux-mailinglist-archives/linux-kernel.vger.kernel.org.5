Return-Path: <linux-kernel+bounces-114454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9961888A91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABCF1C28D87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176972811D3;
	Sun, 24 Mar 2024 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWGaWWNw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648F2156667;
	Sun, 24 Mar 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321873; cv=none; b=XZk4CEc7/ok0l2D1caDvnp2H8+6/+6lQLY0DznqRQquE1oHM7E7afn8tG7hFDgWhkFuL1BdvJs1JR0P1nP8dOcBme0GNbcHD0kInbBJCmUqU4xpyUW4qB12jnCdjTRAZiSM2gPS5WilNocBKpOmmZzw1FrLHc7Q/lcfSOIxmRrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321873; c=relaxed/simple;
	bh=AqqaowdoPjgLyl6nrMyijMdPdDNem1whp46PAG5TrTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+7VXJ5SppgG/0s/e3AI1s+1IdubRD+hSBIH1k4O4Ty/bQqbzAPtXHcEr54n+Q9qCdIEm5dMVM+mIpQf14Q1gvB8O+JEbklfNbc8nu9v1GdDgkW31P+/Esnn96Bg50BLJTYAAJXjNqKkwBMgfF+FNV+3sukoTZdTy+VBKPqkanU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWGaWWNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142D0C433F1;
	Sun, 24 Mar 2024 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321872;
	bh=AqqaowdoPjgLyl6nrMyijMdPdDNem1whp46PAG5TrTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWGaWWNwBYpLl3nMbnOqQCIMnt7NHWj+Zjt7/wDXaCva3WkKPXzxxrmVYGLigoF0D
	 S6UU5l4S6Z9zcAMm1il9RVE7Cv5HgmgP6OZEIOBSBEQEiCcGW744BJagZyH0C/6sVU
	 bmFuElAXF8+Db0Tlv+yHJu2MnpXbd0ae1lMqjepGIVUJ6bmZWM+/oPxWGGchQXtgvD
	 edaV8/bHv/qDadJlF4xBwZfVlkHD2uN9iMt/MeAgdMoZRO3sW4fqQdRNUSEoIxvX4Q
	 Oif43m1yBfBL1LnEZrB9aXa2YVLDUcQ4hFeq04SY7itY7JAxPFnkKDxipnVcYqxpkd
	 MRikyNdH0YfDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 600/638] packet: annotate data-races around ignore_outgoing
Date: Sun, 24 Mar 2024 19:00:37 -0400
Message-ID: <20240324230116.1348576-601-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6ebfad33161afacb3e1e59ed1c2feefef70f9f97 ]

ignore_outgoing is read locklessly from dev_queue_xmit_nit()
and packet_getsockopt()

Add appropriate READ_ONCE()/WRITE_ONCE() annotations.

syzbot reported:

BUG: KCSAN: data-race in dev_queue_xmit_nit / packet_setsockopt

write to 0xffff888107804542 of 1 bytes by task 22618 on cpu 0:
 packet_setsockopt+0xd83/0xfd0 net/packet/af_packet.c:4003
 do_sock_setsockopt net/socket.c:2311 [inline]
 __sys_setsockopt+0x1d8/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0x66/0x80 net/socket.c:2340
 do_syscall_64+0xd3/0x1d0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

read to 0xffff888107804542 of 1 bytes by task 27 on cpu 1:
 dev_queue_xmit_nit+0x82/0x620 net/core/dev.c:2248
 xmit_one net/core/dev.c:3527 [inline]
 dev_hard_start_xmit+0xcc/0x3f0 net/core/dev.c:3547
 __dev_queue_xmit+0xf24/0x1dd0 net/core/dev.c:4335
 dev_queue_xmit include/linux/netdevice.h:3091 [inline]
 batadv_send_skb_packet+0x264/0x300 net/batman-adv/send.c:108
 batadv_send_broadcast_skb+0x24/0x30 net/batman-adv/send.c:127
 batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:392 [inline]
 batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x3f0/0x4b0 net/batman-adv/bat_iv_ogm.c:1700
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0x465/0x990 kernel/workqueue.c:3335
 worker_thread+0x526/0x730 kernel/workqueue.c:3416
 kthread+0x1d1/0x210 kernel/kthread.c:388
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

value changed: 0x00 -> 0x01

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 27 Comm: kworker/u8:1 Tainted: G        W          6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet

Fixes: fa788d986a3a ("packet: add sockopt to ignore outgoing packets")
Reported-by: syzbot+c669c1136495a2e7c31f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/CANn89i+Z7MfbkBLOv=p7KZ7=K1rKHO4P1OL5LYDCtBiyqsa9oQ@mail.gmail.com/T/#t
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c         | 2 +-
 net/packet/af_packet.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d72a4ff689ca7..8ac8b5c561030 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2290,7 +2290,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, struct net_device *dev)
 	rcu_read_lock();
 again:
 	list_for_each_entry_rcu(ptype, ptype_list, list) {
-		if (ptype->ignore_outgoing)
+		if (READ_ONCE(ptype->ignore_outgoing))
 			continue;
 
 		/* Never send packets back to the socket
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7adf48549a3b7..f017d7d33da39 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4004,7 +4004,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 		if (val < 0 || val > 1)
 			return -EINVAL;
 
-		po->prot_hook.ignore_outgoing = !!val;
+		WRITE_ONCE(po->prot_hook.ignore_outgoing, !!val);
 		return 0;
 	}
 	case PACKET_TX_HAS_OFF:
@@ -4135,7 +4135,7 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
 		       0);
 		break;
 	case PACKET_IGNORE_OUTGOING:
-		val = po->prot_hook.ignore_outgoing;
+		val = READ_ONCE(po->prot_hook.ignore_outgoing);
 		break;
 	case PACKET_ROLLOVER_STATS:
 		if (!po->rollover)
-- 
2.43.0


