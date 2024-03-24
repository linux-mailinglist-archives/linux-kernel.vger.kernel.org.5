Return-Path: <linux-kernel+bounces-115094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E41A888D12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4321F29B56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D52F8BD3;
	Mon, 25 Mar 2024 01:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ncw8ioaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E789181313;
	Sun, 24 Mar 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324076; cv=none; b=HEsEzu00AknwzQ0/DUBLyQHvzCIFbi/PB/hKqyhjaeREKi72bjD4KuU1A3kG/ehaLB0C0oNxsm5fvu4bRU8cOkEjsOr5Z2k1sxX4dUG/g475kseTfY3mG/kPY4g3yjUxLsdSct0032MY9D2gPnvDa3lIDjF4ICpYlHKcdMdHhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324076; c=relaxed/simple;
	bh=J1y2+vEL98RFUtzoFZEVFDdMACtwuD7o7HO3pfGGSxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrKuwUHxjrDsjII8EZ/CkIrQSKGAVgG4EviUMNu4mK5vcJSLdVmnEhXbA38sBUsU7yf5z5XiL1N+rWPyE7KioH1vIrAJFbntHCTwsgm32WuGccUp/DWyA6HlchBcObyJ47PtrxItqrNqMQFD9sMHW8DjrUXnu/zyYrezZSmK6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ncw8ioaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560AEC43390;
	Sun, 24 Mar 2024 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324075;
	bh=J1y2+vEL98RFUtzoFZEVFDdMACtwuD7o7HO3pfGGSxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ncw8ioaJH89onJTGA4fdvQsKDg41aiFXUZQUn2+Hysf4aFaa/R1XxReQ8M2jMnlbz
	 QT8v3JE5QnGw05YcUVmqFhJqXT+Ua6znPqtHRKot5CibAbvH84wYu9E7sRkW6tVWJG
	 lWINjAW3GvxhZDCaoCW7rnhwic7uB0wuUkknfnBvS7YlhVVaIgMpE3jl5jR9grDHlp
	 fMG8aYKkZBXCdgwCh4id18Wnurr7n8d2h0aBmKrJTxeQYnPJPKw1RKYgk1cEz7H5BK
	 2bKw8c5ayIGYh9Tjv6CePAg4p2NaH73VIYOFlV+/Tj+a1UNx0GQqFrx5SaMeSzfgon
	 iJ/nCWhHrYwcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/183] net: ip_tunnel: make sure to pull inner header in ip_tunnel_rcv()
Date: Sun, 24 Mar 2024 19:44:48 -0400
Message-ID: <20240324234638.1355609-76-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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

[ Upstream commit b0ec2abf98267f14d032102551581c833b0659d3 ]

Apply the same fix than ones found in :

8d975c15c0cd ("ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()")
1ca1ba465e55 ("geneve: make sure to pull inner header in geneve_rx()")

We have to save skb->network_header in a temporary variable
in order to be able to recompute the network_header pointer
after a pskb_inet_may_pull() call.

pskb_inet_may_pull() makes sure the needed headers are in skb->head.

syzbot reported:
BUG: KMSAN: uninit-value in __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
 BUG: KMSAN: uninit-value in INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
 BUG: KMSAN: uninit-value in IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
 BUG: KMSAN: uninit-value in ip_tunnel_rcv+0xed9/0x2ed0 net/ipv4/ip_tunnel.c:409
  __INET_ECN_decapsulate include/net/inet_ecn.h:253 [inline]
  INET_ECN_decapsulate include/net/inet_ecn.h:275 [inline]
  IP_ECN_decapsulate include/net/inet_ecn.h:302 [inline]
  ip_tunnel_rcv+0xed9/0x2ed0 net/ipv4/ip_tunnel.c:409
  __ipgre_rcv+0x9bc/0xbc0 net/ipv4/ip_gre.c:389
  ipgre_rcv net/ipv4/ip_gre.c:411 [inline]
  gre_rcv+0x423/0x19f0 net/ipv4/ip_gre.c:447
  gre_rcv+0x2a4/0x390 net/ipv4/gre_demux.c:163
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
  netif_receive_skb_internal net/core/dev.c:5734 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5793
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1556
  tun_get_user+0x53b9/0x66e0 drivers/net/tun.c:2009
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2055
  call_write_iter include/linux/fs.h:2087 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb6b/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
  __alloc_pages+0x9a6/0xe00 mm/page_alloc.c:4590
  alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
  alloc_pages+0x1be/0x1e0 mm/mempolicy.c:2204
  skb_page_frag_refill+0x2bf/0x7c0 net/core/sock.c:2909
  tun_build_skb drivers/net/tun.c:1686 [inline]
  tun_get_user+0xe0a/0x66e0 drivers/net/tun.c:1826
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2055
  call_write_iter include/linux/fs.h:2087 [inline]
  new_sync_write fs/read_write.c:497 [inline]
  vfs_write+0xb6b/0x1520 fs/read_write.c:590
  ksys_write+0x20f/0x4c0 fs/read_write.c:643
  __do_sys_write fs/read_write.c:655 [inline]
  __se_sys_write fs/read_write.c:652 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:652
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_tunnel.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index ba1decf81fe32..906c37c7f80d5 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -365,7 +365,7 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 {
 	struct pcpu_sw_netstats *tstats;
 	const struct iphdr *iph = ip_hdr(skb);
-	int err;
+	int nh, err;
 
 #ifdef CONFIG_NET_IPGRE_BROADCAST
 	if (ipv4_is_multicast(iph->daddr)) {
@@ -391,8 +391,21 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
 	}
 
+	/* Save offset of outer header relative to skb->head,
+	 * because we are going to reset the network header to the inner header
+	 * and might change skb->head.
+	 */
+	nh = skb_network_header(skb) - skb->head;
+
 	skb_set_network_header(skb, (tunnel->dev->type == ARPHRD_ETHER) ? ETH_HLEN : 0);
 
+	if (!pskb_inet_may_pull(skb)) {
+		DEV_STATS_INC(tunnel->dev, rx_length_errors);
+		DEV_STATS_INC(tunnel->dev, rx_errors);
+		goto drop;
+	}
+	iph = (struct iphdr *)(skb->head + nh);
+
 	err = IP_ECN_decapsulate(iph, skb);
 	if (unlikely(err)) {
 		if (log_ecn_error)
-- 
2.43.0


