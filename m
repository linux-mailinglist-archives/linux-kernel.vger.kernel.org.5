Return-Path: <linux-kernel+bounces-101947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89187ACF8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F401F24195
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C71369A1;
	Wed, 13 Mar 2024 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/I4UEBz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24398136671;
	Wed, 13 Mar 2024 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348155; cv=none; b=WXR6V9/kD5W5dbqrcikK3MNrylLjYQlPc9K9SwL+Q3FyTu6Bovb+VEHTq7Vh903b4C1TD/3+7jXpyVFKe33ZJIO8b0wQAWeaPA/HAD1npw9ilXt/sbCsfrvoo9MFTksocq49hP9NINUgG0nFKg7MJ/83cUJcvzgcILHWjCpEDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348155; c=relaxed/simple;
	bh=4Tmnb5SPgyP3HB7S9PBks/WqTz6e9grTcyBGu1v9p6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7qCT3Sz8sX1iydO2JX/S0WAuu3Rp9yDrufFrTNBn8H8hlitaqQxc7d+8dW8RIHeJWhuPc6JvLiIJoJLMoDuF2yodewl7RNnwNATFScpZMztSNyo3cobnAzbCtcsy4QVPXnvTdvDJ3DkKmRPDafYL8UYg5CbNOkasINpBSTHeys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/I4UEBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C4DC433B1;
	Wed, 13 Mar 2024 16:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348155;
	bh=4Tmnb5SPgyP3HB7S9PBks/WqTz6e9grTcyBGu1v9p6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/I4UEBzdT5ldf1H2vGbAcxNt0P+o5OoWfAWKik0YG/0J3cHpWJ00Rl9T9IVqmsMv
	 pYA/zqNSIUHHF1B/v2Utkke5OeJqswDyvTc/x/XfGZvY/0ufFd+JRrYJgBF/3hY30Z
	 f/I6IQvgoxVU1XrM91EUgxEPFJd1eV7FU8jO/pVXSnaHTqm4HvXPA6FhQKURcuOUAv
	 hxRybKw+ciStX6CV1W+caqjS6HEpApprY6yZ6mUFxq7SKkyJWZlcur27wL/wnBqyB4
	 8U+6QK7I9CVrB3XbUxYtB1pR6STd96qGArBTIkO11evg0uo4GhT7jYB131/nPCj8Yc
	 ByavWldR/8iuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot+6a1423ff3f97159aae64@syzkaller.appspotmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 07/76] geneve: make sure to pull inner header in geneve_rx()
Date: Wed, 13 Mar 2024 12:41:14 -0400
Message-ID: <20240313164223.615640-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
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
index 605332f36d9df..9569b5cc595ec 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -219,7 +219,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 	struct genevehdr *gnvh = geneve_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
 	unsigned int len;
-	int err = 0;
+	int nh, err = 0;
 	void *oiph;
 
 	if (ip_tunnel_collect_metadata() || gs->collect_md) {
@@ -263,9 +263,23 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
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


