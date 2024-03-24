Return-Path: <linux-kernel+bounces-115561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE67C889C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBCC1C2F0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03E2ACB2E;
	Mon, 25 Mar 2024 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft/71UfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF6B1F1ADF;
	Sun, 24 Mar 2024 22:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321086; cv=none; b=LBBwRuNTEZaIvaYhQKjGFib4Su9GPXwWCZTAfB/JsVtZPNBQ55dI9DkG0AA47JT0hy3QOxvtbcEay+wChsRoiwY0CfiAsrEuq0+qlFrjuvdFQjAo4FoHGGCkUJQTLRCp/xBbARU0O9EJXiBu9yy+RvSGjW6WiSwjiY9Khvj0cpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321086; c=relaxed/simple;
	bh=NLXg1mMIeDthRs3gevp71oajPJK8l3xOG32jfOjQjjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBowotfJGJBv7JQk+hVXtqdnZWkHUolANuCIuQSLcoBu5erQU5Wywbce4D5CKV1OK3Znhft3kyGnlChu0/tvEaXWUz9IfYfYE8xeCg4+61QLvdpUzyP0vJ/kv8NXpCNpWV1RAqN0fwYtrCak505+bP4q8zdAUvN9TEVdQ6fkrzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft/71UfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA5C433A6;
	Sun, 24 Mar 2024 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321086;
	bh=NLXg1mMIeDthRs3gevp71oajPJK8l3xOG32jfOjQjjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ft/71UfMzMTBvs/EJtBRdqZcmDiywp6Z02ci3uSTpPhRy7ju0BmU28Wc3K6q9lATk
	 4yXH13jI4knZnOdwfFTggcrY7sycbk6hK+tGtuPu7Da9RjO5Po9bYXk1PIOhcvUBBh
	 +r1ZBGS3MhzD9uQ+QTpoix08mpkmtS++db0AkUv7rD8Hb8kxEHh7vzGgcc91DOhC89
	 qyw/937CBlJUFXIp4Qd1zGKSWWUgLIX9YeWlQqWIO8gjFPEvR8NLag+sAD9hpdVN+t
	 YXuMtULo9S6nzLKGTKo+Mg4Io5rCHoW6xp5X/sA922t8ftufYeT1d9lw9NK7hCYKCz
	 rbsUamNX443Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+a340daa06412d6028918@syzkaller.appspotmail.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 650/713] net/sched: taprio: proper TCA_TAPRIO_TC_ENTRY_INDEX check
Date: Sun, 24 Mar 2024 18:46:16 -0400
Message-ID: <20240324224720.1345309-651-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 343041b59b7810f9cdca371f445dd43b35c740b1 ]

taprio_parse_tc_entry() is not correctly checking
TCA_TAPRIO_TC_ENTRY_INDEX attribute:

	int tc; // Signed value

	tc = nla_get_u32(tb[TCA_TAPRIO_TC_ENTRY_INDEX]);
	if (tc >= TC_QOPT_MAX_QUEUE) {
		NL_SET_ERR_MSG_MOD(extack, "TC entry index out of range");
		return -ERANGE;
	}

syzbot reported that it could fed arbitary negative values:

UBSAN: shift-out-of-bounds in net/sched/sch_taprio.c:1722:18
shift exponent -2147418108 is negative
CPU: 0 PID: 5066 Comm: syz-executor367 Not tainted 6.8.0-rc7-syzkaller-00136-gc8a5c731fd12 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
  ubsan_epilogue lib/ubsan.c:217 [inline]
  __ubsan_handle_shift_out_of_bounds+0x3c7/0x420 lib/ubsan.c:386
  taprio_parse_tc_entry net/sched/sch_taprio.c:1722 [inline]
  taprio_parse_tc_entries net/sched/sch_taprio.c:1768 [inline]
  taprio_change+0xb87/0x57d0 net/sched/sch_taprio.c:1877
  taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2134
  qdisc_create+0x9d4/0x1190 net/sched/sch_api.c:1355
  tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1776
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6617
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
  ___sys_sendmsg net/socket.c:2638 [inline]
  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f1b2dea3759
Code: 48 83 c4 28 c3 e8 d7 19 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd4de452f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1b2def0390 RCX: 00007f1b2dea3759
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000555500000000 R09: 0000555500000000
R10: 0000555500000000 R11: 0000000000000246 R12: 00007ffd4de45340
R13: 00007ffd4de45310 R14: 0000000000000001 R15: 00007ffd4de45340

Fixes: a54fc09e4cba ("net/sched: taprio: allow user input of per-tc max SDU")
Reported-and-tested-by: syzbot+a340daa06412d6028918@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c9..ad99409c6325e 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1008,7 +1008,8 @@ static const struct nla_policy entry_policy[TCA_TAPRIO_SCHED_ENTRY_MAX + 1] = {
 };
 
 static const struct nla_policy taprio_tc_policy[TCA_TAPRIO_TC_ENTRY_MAX + 1] = {
-	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = { .type = NLA_U32 },
+	[TCA_TAPRIO_TC_ENTRY_INDEX]	   = NLA_POLICY_MAX(NLA_U32,
+							    TC_QOPT_MAX_QUEUE),
 	[TCA_TAPRIO_TC_ENTRY_MAX_SDU]	   = { .type = NLA_U32 },
 	[TCA_TAPRIO_TC_ENTRY_FP]	   = NLA_POLICY_RANGE(NLA_U32,
 							      TC_FP_EXPRESS,
-- 
2.43.0


