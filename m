Return-Path: <linux-kernel+bounces-153678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BA58AD18E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF7B285097
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F415359C;
	Mon, 22 Apr 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NrXsINZv"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31E153518;
	Mon, 22 Apr 2024 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802075; cv=none; b=IZHuqRGjUoXBf1yxfYjb+IZawuz8+dg46KCXiM6iHQVpxGpSNw3hlPOnE/RA+QlbFYQSiHia5a1xwERuGyvTZ4o6ZMHnDQDeDeGoYDRG8sk1ZhxyTR2SVK8Esvc5htiBmucTpZtNP3N3NGYfRo9x3x0bYyxViM2Tt4JH2jgzHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802075; c=relaxed/simple;
	bh=GHP5qFOVi9OdunDmU9hHl5GT+pNnjmD0qBVy27oIzKs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AE/Hl2Ce0VZKD50kotkq7trCjXP4o5QSwtCFs2ugurvvrdbw8HFrDJfEGta7c1DXvvob748PpQBdwB1MUo9I8DKSfwxMhST8KmnfYXrVNX4eZmC+1P6s4NZEYVDg9sXyR2OHUQYuflT3DZWzl8bHHuXpB2K3d/mPY6RhZKQ+avk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NrXsINZv; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713802075; x=1745338075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5rHPQ0T8ovxHKMQp6vZ3glM9uXNrftYyNUbpbLB5M2U=;
  b=NrXsINZvbBn6dD9xTzUQmeXq29KkTsBC1WeZzPfn9DuzvmBvpzCEiTVi
   2nisaFf0ZbswBa5gXnSzNK+e7j52Xfw4pzc6s11EpQuGyebJaZXI7crYD
   LoYNpZgPJNgmzjX750JbMnYgpH7Ai3Qb6zA7Q3KZQ10eKpDU1jwsYQ8O7
   w=;
X-IronPort-AV: E=Sophos;i="6.07,220,1708387200"; 
   d="scan'208";a="289816897"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:07:48 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:7986]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.166:2525] with esmtp (Farcaster)
 id db9bb64e-fa1a-4548-93b1-e2425e64f032; Mon, 22 Apr 2024 16:07:47 +0000 (UTC)
X-Farcaster-Flow-ID: db9bb64e-fa1a-4548-93b1-e2425e64f032
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 16:07:40 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 16:07:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipvlan_queue_xmit (2)
Date: Mon, 22 Apr 2024 09:07:28 -0700
Message-ID: <20240422160728.82185-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0000000000003420e806165998ae@google.com>
References: <0000000000003420e806165998ae@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: syzbot <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>
Date: Thu, 18 Apr 2024 00:05:21 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f2e367d6ad3b Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=144a8d4a180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
> dashboard link: https://syzkaller.appspot.com/bug?extid=42a0dc856239de4de60e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149caa54180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10bb8e22180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/0dabc03369d1/disk-f2e367d6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/240ca250d398/vmlinux-f2e367d6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cc38bcdb48c9/bzImage-f2e367d6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
> BUG: KMSAN: uninit-value in ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
> BUG: KMSAN: uninit-value in ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
>  ipvlan_process_outbound drivers/net/ipvlan/ipvlan_core.c:524 [inline]
>  ipvlan_xmit_mode_l3 drivers/net/ipvlan/ipvlan_core.c:602 [inline]
>  ipvlan_queue_xmit+0xf44/0x16b0 drivers/net/ipvlan/ipvlan_core.c:668
>  ipvlan_start_xmit+0x5c/0x1a0 drivers/net/ipvlan/ipvlan_main.c:222
>  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
>  xmit_one net/core/dev.c:3547 [inline]
>  dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
>  __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slub.c:3819 [inline]
>  slab_alloc_node mm/slub.c:3860 [inline]
>  __do_kmalloc_node mm/slub.c:3980 [inline]
>  __kmalloc_node_track_caller+0x705/0x1000 mm/slub.c:4001
>  kmalloc_reserve+0x249/0x4a0 net/core/skbuff.c:582
>  __alloc_skb+0x352/0x790 net/core/skbuff.c:651
>  skb_segment+0x20aa/0x7080 net/core/skbuff.c:4647
>  udp6_ufo_fragment+0xcab/0x1150 net/ipv6/udp_offload.c:109
>  ipv6_gso_segment+0x14be/0x2ca0 net/ipv6/ip6_offload.c:152
>  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
>  nsh_gso_segment+0x6f4/0xf70 net/nsh/nsh.c:108
>  skb_mac_gso_segment+0x3e8/0x760 net/core/gso.c:53
>  __skb_gso_segment+0x4b0/0x730 net/core/gso.c:124
>  skb_gso_segment include/net/gso.h:83 [inline]
>  validate_xmit_skb+0x107f/0x1930 net/core/dev.c:3628
>  __dev_queue_xmit+0x1f28/0x51c0 net/core/dev.c:4343
>  dev_queue_xmit include/linux/netdevice.h:3171 [inline]
>  packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
>  packet_snd net/packet/af_packet.c:3081 [inline]
>  packet_sendmsg+0x8aef/0x9f10 net/packet/af_packet.c:3113
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg net/socket.c:745 [inline]
>  __sys_sendto+0x735/0xa10 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> 
> CPU: 1 PID: 5101 Comm: syz-executor421 Not tainted 6.8.0-rc5-syzkaller-00297-gf2e367d6ad3b #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> =====================================================
[...]
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f2e367d6ad3bdc527c2b14e759c2f010d6b2b7a1

diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index f4a38bd6a7e0..1344653916c4 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -77,13 +77,15 @@ EXPORT_SYMBOL_GPL(nsh_pop);
 static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 				       netdev_features_t features)
 {
+	unsigned int tnl_hlen, mac_len, nsh_len;
 	struct sk_buff *segs = ERR_PTR(-EINVAL);
 	u16 mac_offset = skb->mac_header;
-	unsigned int nsh_len, mac_len;
-	__be16 proto;
+	__be16 tnl_proto, proto;
 
 	skb_reset_network_header(skb);
 
+	tnl_proto = skb->protocol;
+	tnl_hlen = skb->network_header - skb->mac_header;
 	mac_len = skb->mac_len;
 
 	if (unlikely(!pskb_may_pull(skb, NSH_BASE_HDR_LEN)))
@@ -113,11 +115,11 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 	}
 
 	for (skb = segs; skb; skb = skb->next) {
-		skb->protocol = htons(ETH_P_NSH);
-		__skb_push(skb, nsh_len);
-		skb->mac_header = mac_offset;
-		skb->network_header = skb->mac_header + mac_len;
+		__skb_push(skb, nsh_len + tnl_hlen);
+		skb_reset_mac_header(skb);
+		skb->network_header = skb->mac_header + tnl_hlen;
 		skb->mac_len = mac_len;
+		skb->protocol = tnl_proto;
 	}
 
 out:

