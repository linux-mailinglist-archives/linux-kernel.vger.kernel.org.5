Return-Path: <linux-kernel+bounces-123078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37148901D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69268B21AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB391304AB;
	Thu, 28 Mar 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeIzeJPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4612D209;
	Thu, 28 Mar 2024 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636313; cv=none; b=u9TkTQTKadAKw5YUhM3/ZuZELFGTh+e+Fz5LL9cR3wjDZy4WSrYhCTFP+PLl3mXpBqD41peDy87heqz0b4K3SKHZii6AV8C9cMNwhCosxeq+QzMR2C53nOAGB3GN6xOY8w8feKyBw3Y6jDhetrEbSsZK2SRqoU5jrFNBVPgDjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636313; c=relaxed/simple;
	bh=63E3lJn+RbWzhvFRPe7NeWgxZ0tEg6xP/LcfJ4ruTtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YQWBsT1aUuYNNiZN6nfJ44ii5iCVrELo6R18lYFSyBEs0dvvy33MYGrlUxc7YPUlCqYwQx1IJ8Li558jXre3qbiTgvEKcINfjSHYmNjkaQFrD2pUZNrAJIqqXwXr3eem+VEz5dTHRCgUYzs+BkF2KkVq4bIQ9/QS3B7FMcgcp8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeIzeJPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B14C433C7;
	Thu, 28 Mar 2024 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636313;
	bh=63E3lJn+RbWzhvFRPe7NeWgxZ0tEg6xP/LcfJ4ruTtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IeIzeJPLkhJmIX8tfvNCyH/kz7dBZEaGv2AH5mRvXEHTKzjG/bGvkl1wrQQSGhHhR
	 WAlroVk1KIkwQ+Q3j546UO8T09Xwgq/PY6cz6Ni1I+dxI3+5Qm72UOXucjukpc5yFH
	 i41C1dQwmNLmjnPVXyDRWAY/cNcBJqm7V4Vmdqq8VtznuVDuRQKbNognTdbcoHH/dr
	 DBEQCkj5UgVY9xr9OQxUF6szyNPMOywEknh4MEaqD+Su+pv3NDwx9F2ZS6Og5GR9aB
	 analtJheeLW2+JVcuCKBt3GTI318iexloMXaM3CNcDQ9ZU4TbZBVBkGMfOCL0WXWSJ
	 WJRJmX9ZP13/Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	"mfreemon@cloudflare.com" <mfreemon@cloudflare.com>,
	Yan Zhai <yan@cloudflare.com>,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 5/9] ipv4: tcp_output: avoid warning about NET_ADD_STATS
Date: Thu, 28 Mar 2024 15:30:43 +0100
Message-Id: <20240328143051.1069575-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328143051.1069575-1-arnd@kernel.org>
References: <20240328143051.1069575-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Clang warns about a range check in percpu_add_op() being impossible
to hit for an u8 variable:

net/ipv4/tcp_output.c:188:3: error: result of comparison of constant -1 with expression of type 'u8' (aka 'unsigned char') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
                NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/net/ip.h:291:41: note: expanded from macro 'NET_ADD_STATS'
 #define NET_ADD_STATS(net, field, adnd) SNMP_ADD_STATS((net)->mib.net_statistics, field, adnd)
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/net/snmp.h:143:4: note: expanded from macro 'SNMP_ADD_STATS'
                        this_cpu_add(mib->mibs[field], addend)
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/percpu-defs.h:509:33: note: expanded from macro 'this_cpu_add'
 #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
<scratch space>:187:1: note: expanded from here
this_cpu_add_8
^
arch/x86/include/asm/percpu.h:326:35: note: expanded from macro 'this_cpu_add_8'
 #define this_cpu_add_8(pcp, val)                percpu_add_op(8, volatile, (pcp), val)
                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/include/asm/percpu.h:127:31: note: expanded from macro 'percpu_add_op'
                              ((val) == 1 || (val) == -1)) ?            \
                                             ~~~~~ ^  ~~

Avoid this warning with a cast to a signed 'int'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/ipv4/tcp_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..dbe54fceee08 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -183,7 +183,7 @@ static inline void tcp_event_ack_sent(struct sock *sk, u32 rcv_nxt)
 
 	if (unlikely(tp->compressed_ack)) {
 		NET_ADD_STATS(sock_net(sk), LINUX_MIB_TCPACKCOMPRESSED,
-			      tp->compressed_ack);
+			      (int)tp->compressed_ack);
 		tp->compressed_ack = 0;
 		if (hrtimer_try_to_cancel(&tp->compressed_ack_timer) == 1)
 			__sock_put(sk);
-- 
2.39.2


