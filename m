Return-Path: <linux-kernel+bounces-102035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DBD87ADC9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA71282146
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C41509B8;
	Wed, 13 Mar 2024 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIMaSn75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF515099B;
	Wed, 13 Mar 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348415; cv=none; b=YzpTjxh6aUMiYaFHXEWL1kEOrkHAT7yVycXENfb+RHTxYBg69BIC0dyXPxyVuQ6pA0qZazNNq6W+JSy56NLJ2KxnfnqKgXzyyX0dh36MCU84Jm9TBXNcTwjDIXzxrQ0rsqFr8OTxX+iqpt5LDnupCpMR+fhCIEyOK8ZaKYWu1xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348415; c=relaxed/simple;
	bh=ikYP7GgT1Knk2KrrqCDL8WCKM7IMr/UR89wnWQF8slA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZmNp3sVZeArA7d+dCqlqvU9oDStx2jeiGpnqSFPvygfxZQDvpFc8iTuwZnwRMBBp081vC1mGh0kCG5lDbAYKS1XnOWOlZ8hgiSck9AbNCzGnIcQdJz04/9dOVDK7W1HYVej2oHySK7ockl06Ja3dGze2VvW67WPhrixfYPML3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIMaSn75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974B1C433C7;
	Wed, 13 Mar 2024 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348415;
	bh=ikYP7GgT1Knk2KrrqCDL8WCKM7IMr/UR89wnWQF8slA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIMaSn75o885/+TsPULMGzC3DIKcRA0zyGh4pqBa+yVVsQfCftdl5Pu0nkUoT0jmR
	 3oDODNELKyibhfFs0JlJFqLJx9bUIUSPZHkQFK/7gJl5CPBBnCjONso1IKjFejDdaT
	 ye9qblH7e5t1hANZpJ1hhymjCUiFDh0y31x8EeEHCcn6sw9pFCaVJGiP73/ZZcZ5Yr
	 IdGVgFxXjxreHiF/rmQEAAJHjlgmwPehy3ef4IKePQ9ZfXY8NpBSvNPs9Qa6pjlanL
	 7sKUUwXdA5qqkUyeTlP6+w0rPzI1T1yTTT8McwZBcuRP4JRIQN4JIB07AXcOsbsE41
	 e+7q1TKZT39VA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 11/73] geneve: make sure to pull inner header in geneve_rx()
Date: Wed, 13 Mar 2024 12:45:38 -0400
Message-ID: <20240313164640.616049-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 1ca1ba465e55b9460e4e75dec9fff31e708fec74 ]

syzbot triggered a bug in geneve_rx() [1]

Issue is similar to the one I fixed in commit 8d975c15c0cd
("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")

We have to save skb->network_header in a temporary variable
in order to be able to recompute the network_header pointer
after a pskb_inet_may_pull() call.

pskb_inet_may_pull() makes sure the needed headers are in skb->head.

[1]
BUG: KMSAN: uninit-value in IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
 BUG: KMSAN: uninit-value in geneve_rx drivers/net/geneve.c:279 [inline]
 BUG: KMSAN: uninit-value in geneve_udp_encap_recv+0x36f9/0x3c10 drivers/net/geneve.c:391
  IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
  geneve_rx drivers/net/geneve.c:279 [inline]
  geneve_udp_encap_recv+0x36f9/0x3c10 drivers/net/geneve.c:391
  udp_queue_rcv_one_skb+0x1d39/0x1f20 net/ipv4/udp.c:2108
  udp_queue_rcv_skb+0x6ae/0x6e0 net/ipv4/udp.c:2186
  udp_unicast_rcv_skb+0x184/0x4b0 net/ipv4/udp.c:2346
  __udp4_lib_rcv+0x1c6b/0x3010 net/ipv4/udp.c:2422
  udp_rcv+0x7d/0xa0 net/ipv4/udp.c:2604
  ip_protocol_deliver_rcu+0x264/0x1300 net/ipv4/ip_input.c:205
  ip_local_deliver_finish+0x2b8/0x440 net/ipv4/ip_input.c:233
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip_local_deliver+0x21f/0x490 net/ipv4/ip_input.c:254
  dst_input include/net/dst.h:461 [inline]
  ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip_rcv+0x46f/0x760 net/ipv4/ip_input.c:569
  __netif_receive_skb_one_core net/core/dev.c:5534 [inline]
  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5648
  process_backlog+0x480/0x8b0 net/core/dev.c:5976
  __napi_poll+0xe3/0x980 net/core/dev.c:6576
  napi_poll net/core/dev.c:6645 [inline]
  net_rx_action+0x8b8/0x1870 net/core/dev.c:6778
  __do_softirq+0x1b7/0x7c5 kernel/softirq.c:553
  do_softirq+0x9a/0xf0 kernel/softirq.c:454
  __local_bh_enable_ip+0x9b/0xa0 kernel/softirq.c:381
  local_bh_enable include/linux/bottom_half.h:33 [inline]
  rcu_read_unlock_bh include/linux/rcupdate.h:820 [inline]
  __dev_queue_xmit+0x2768/0x51c0 net/core/dev.c:4378
  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
  packet_snd net/packet/af_packet.c:3081 [inline]
  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  __sys_sendto+0x735/0xa10 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:3819 [inline]
  slab_alloc_node mm/slub.c:3860 [inline]
  kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
  alloc_skb include/linux/skbuff.h:1296 [inline]
  alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6394
  sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
  packet_alloc_skb net/packet/af_packet.c:2930 [inline]
  packet_snd net/packet/af_packet.c:3024 [inline]
  packet_sendmsg+0x70c2/0x9f10 net/packet/af_packet.c:3113
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg net/socket.c:745 [inline]
  __sys_sendto+0x735/0xa10 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: 2d07dc79fe04 ("geneve: add initial netdev driver for GENEVE tunnels")
Reported-and-tested-by: syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/geneve.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 081939cb420b0..2bb9820c66641 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -218,7 +218,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -262,9 +262,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 		goto drop;
 	}
 
-	oiph = skb_network_header(skb);
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_reset_network_header(skb);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(geneve->dev, rx_length_errors);
+		DEV_STATS_INC(geneve->dev, rx_errors);
+		goto drop;
+	}
+
+	/* Get the outer header. */
+	oiph = skb->head + nh;
+
 	if (geneve_get_sk_family(gs) == AF_INET)
 		err = IP_ECN_decapsulate(oiph, skb);
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.43.0


