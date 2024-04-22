Return-Path: <linux-kernel+bounces-154242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7E78AD9D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 740F21C212AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E06159209;
	Mon, 22 Apr 2024 23:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXeHw7Dn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA6A1591ED;
	Mon, 22 Apr 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830093; cv=none; b=K20ePfU3z4mHSlidg+7xj/23j1rdpiBtoFAdbrwujzt29UBw4UglRhJLnPfDYCjl3+SZowsZjm1c0i7l8yjyhMvw3JhFdpyEXg5xGO2H/yNMyx1KTGqAL27vxSkHoDBL+quUtNDUHkOtLWzoSBVxuQxt1IqLzor5e8GCZ9C30tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830093; c=relaxed/simple;
	bh=tYvNNEbb6+cfkfdbJ91DjfKB+ny9/OmOrztmcSftBkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEGZcX32XOFzPh9LIMhh5CF9fECQbCSzyvRI585Tx8O84U87VNs6KIHSGsfL3qFcG5q6V1P4FD94g6D2oblCaiPf9qIpfKR22BWq+E9P/0OB4Mp1xYBrvsRuJ50lPSJHpQn/kD9DD8VU1kTJtyhSXLvLPJS90579EFNiVOjSJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXeHw7Dn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D05C32782;
	Mon, 22 Apr 2024 23:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830093;
	bh=tYvNNEbb6+cfkfdbJ91DjfKB+ny9/OmOrztmcSftBkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXeHw7DnPA1VzgFa3PP8Pan1heyI8XqY8hV8H18PiFAJtov1/N2p1uNdjVGtdyHVx
	 9qgSRgYL4Jdpq8iHpZytPZKbIkWT4Tc+RBaypOd6SKqGtCdWiPbiUmuNZ+dVDbRA88
	 nNvzdBk91AQ29+6Cbx9j6o6NmKgxo14J2hn7wGjZQZTXrPUllB6DsD1Oo4pCtLUkzc
	 mMd/6KEKRig0YU86NhOSpmo/N+EA50zpE5o/NwcQX5D3ojVUgNjyVMLi8S/DIFl2ua
	 Hj5LO+Q8zhlKm5awnKfLAyE/SM4v24tEtIgPLuUXta0JXjL6EGQLictX3VaeVu4uqH
	 2uqWOmEapq8HQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 25/43] nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
Date: Mon, 22 Apr 2024 19:14:11 -0400
Message-ID: <20240422231521.1592991-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7a87441c9651ba37842f4809224aca13a554a26f ]

syzbot reported unsafe calls to copy_from_sockptr() [1]

Use copy_safe_from_sockptr() instead.

[1]

BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
 BUG: KASAN: slab-out-of-bounds in nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
Read of size 4 at addr ffff88801caa1ec3 by task syz-executor459/5078

CPU: 0 PID: 5078 Comm: syz-executor459 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  print_address_description mm/kasan/report.c:377 [inline]
  print_report+0x169/0x550 mm/kasan/report.c:488
  kasan_report+0x143/0x180 mm/kasan/report.c:601
  copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
  copy_from_sockptr include/linux/sockptr.h:55 [inline]
  nfc_llcp_setsockopt+0x6c2/0x850 net/nfc/llcp_sock.c:255
  do_sock_setsockopt+0x3b1/0x720 net/socket.c:2311
  __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
  __do_sys_setsockopt net/socket.c:2343 [inline]
  __se_sys_setsockopt net/socket.c:2340 [inline]
  __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfd/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7fac07fd89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff660eb788 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f7fac07fd89
RDX: 0000000000000000 RSI: 0000000000000118 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020000a80 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240408082845.3957374-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/nfc/llcp_sock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 819157bbb5a2c..d5344563e525c 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -252,10 +252,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > LLCP_MAX_RW) {
 			err = -EINVAL;
@@ -274,10 +274,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
-			err = -EFAULT;
+		err = copy_safe_from_sockptr(&opt, sizeof(opt),
+					     optval, optlen);
+		if (err)
 			break;
-		}
 
 		if (opt > LLCP_MAX_MIUX) {
 			err = -EINVAL;
-- 
2.43.0


