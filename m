Return-Path: <linux-kernel+bounces-113974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04788887A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD701F262EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257D156676;
	Sun, 24 Mar 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQURhXbq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003901F23CB;
	Sun, 24 Mar 2024 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321099; cv=none; b=QV9TLCMCEOtGnPYMHpj/FYpOKZ3rQ6r70IK4QrK/DvZUyqwg4bvTpDZlVHXQKzHgysXB8iH6b1TjXlJhyTRTiJn+0WSeIXW+6wd8RbGWgAw4YaaSO+P09z1zO041551b8Pi0YSpACVf5xU6duus9K5C7QCBQeqPXgaV7kTVe9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321099; c=relaxed/simple;
	bh=lHXQ2K8+8QPy1rd/IpDoX2dRit57EmurvmqurFZMb7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpOgS+kRF7IFNu2Y+YYr5VlT5uBbFpOuoHhzyHYzjLXekNeJWTAFUut/tfOqLHt8jtpE8/SFOkgrOPEvm1rjAsMB7Ko1nWkquwzz87ioJjnsctWeSMSSYnKIoyvYu9WxubREf7BSKcl90//3kNzgy99MoAMzg1Xj6nFd4MCbN/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQURhXbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BF6C43390;
	Sun, 24 Mar 2024 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321097;
	bh=lHXQ2K8+8QPy1rd/IpDoX2dRit57EmurvmqurFZMb7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQURhXbqiHL950laaFMWjBSh7Dj6A7sDyckd9irL1wS6l6D3ime2dTq03Ieo4QkxG
	 yO5Vws6HPUxYorijoXIYNmGII2KccYMQnopVwV4LrCN4YoIDIveTehKdeeOBvFoEiF
	 JTWySMrrMiHm1iyiy1+/2jX21gH/4fg4Px3BV6TbGyGJQMYwDq5ipKCtcexGgljUwo
	 94/QHTRPE+h93qp3fJve0mTBJ1+LwWYdk2rfGqW8nplipuuBZmxPmUHa/c+zCzbs9b
	 G39RyTnlZZK/Zv5TRxQ70RjeJXU0lu72QaL+I5V0+TYe0NmSIfS+Uz1RnHHbfMxprl
	 Ln1hau0FnMi5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 660/713] tcp: Fix refcnt handling in __inet_hash_connect().
Date: Sun, 24 Mar 2024 18:46:26 -0400
Message-ID: <20240324224720.1345309-661-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 04d9d1fc428ac9f581d55118d67e0cb546701feb ]

syzbot reported a warning in sk_nulls_del_node_init_rcu().

The commit 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc
failure after check_estalblished().") tried to fix an issue that an
unconnected socket occupies an ehash entry when bhash2 allocation fails.

In such a case, we need to revert changes done by check_established(),
which does not hold refcnt when inserting socket into ehash.

So, to revert the change, we need to __sk_nulls_add_node_rcu() instead
of sk_nulls_add_node_rcu().

Otherwise, sock_put() will cause refcnt underflow and leak the socket.

[0]:
WARNING: CPU: 0 PID: 23948 at include/net/sock.h:799 sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Modules linked in:
CPU: 0 PID: 23948 Comm: syz-executor.2 Not tainted 6.8.0-rc6-syzkaller-00159-gc055fc00c07b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:sk_nulls_del_node_init_rcu+0x166/0x1a0 include/net/sock.h:799
Code: e8 7f 71 c6 f7 83 fb 02 7c 25 e8 35 6d c6 f7 4d 85 f6 0f 95 c0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc e8 1b 6d c6 f7 90 <0f> 0b 90 eb b2 e8 10 6d c6 f7 4c 89 e7 be 04 00 00 00 e8 63 e7 d2
RSP: 0018:ffffc900032d7848 EFLAGS: 00010246
RAX: ffffffff89cd0035 RBX: 0000000000000001 RCX: 0000000000040000
RDX: ffffc90004de1000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 1ffff1100439ac26 R08: ffffffff89ccffe3 R09: 1ffff1100439ac28
R10: dffffc0000000000 R11: ffffed100439ac29 R12: ffff888021cd6140
R13: dffffc0000000000 R14: ffff88802a9bf5c0 R15: ffff888021cd6130
FS:  00007f3b823f16c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3b823f0ff8 CR3: 000000004674a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __inet_hash_connect+0x140f/0x20b0 net/ipv4/inet_hashtables.c:1139
 dccp_v6_connect+0xcb9/0x1480 net/dccp/ipv6.c:956
 __inet_stream_connect+0x262/0xf30 net/ipv4/af_inet.c:678
 inet_stream_connect+0x65/0xa0 net/ipv4/af_inet.c:749
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2072
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f3b8167dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b823f10c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f3b817abf80 RCX: 00007f3b8167dda9
RDX: 000000000000001c RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f3b823f1120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 000000000000000b R14: 00007f3b817abf80 R15: 00007ffd3beb57b8
 </TASK>

Reported-by: syzbot+12c506c1aae251e70449@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=12c506c1aae251e70449
Fixes: 66b60b0c8c4a ("dccp/tcp: Unhash sk from ehash for tb2 alloc failure after check_estalblished().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240308201623.65448-1-kuniyu@amazon.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/inet_hashtables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 9456bf9e2705b..7967ff7e02f79 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -1137,7 +1137,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 		sock_prot_inuse_add(net, sk->sk_prot, -1);
 
 		spin_lock(lock);
-		sk_nulls_del_node_init_rcu(sk);
+		__sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 
 		sk->sk_hash = 0;
-- 
2.43.0


