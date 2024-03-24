Return-Path: <linux-kernel+bounces-114918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BE888BF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C0A1C29D5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6123E27EE4C;
	Mon, 25 Mar 2024 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrNM+P6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BC179201;
	Sun, 24 Mar 2024 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323586; cv=none; b=ifAy8JDkFmc/IR0AjtZUT/LtoY2Wkq7T70UZ6LQ6cJ843ls0/adOvM9HTDesqq6itLWwT4jbp2LgGFo2NAc6AhKbrV+j+JpsEl+3HkYiUJJb5eWc3Z6rL9/CsdaDudt3Y3nllyVSSFY9tiaiT0m4gq8YUZ1gfmiMag59uyrCJjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323586; c=relaxed/simple;
	bh=cNTc0foQCXZmIToOgPyjkik9S7rJXFiU9PdOqTuNIxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9h+jYxlA1Ih3C/ZEM5eisRWprZyk89nV945/LYFqGGwSfJgYSSOPNHuhKLXfxtBd8yyrBlx0+04JjHodcuoR0yE6dPLtg1uBaNW/1yVStB25rjAf0iH0AHYnVcIw2zfOun20oH6aV9V+Pn7vF6YyqNNVGffstfBh2ZxMnZ4ECw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrNM+P6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD36C433C7;
	Sun, 24 Mar 2024 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323585;
	bh=cNTc0foQCXZmIToOgPyjkik9S7rJXFiU9PdOqTuNIxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrNM+P6lhUDy3vGUIulL9+KTlUb/me7j74BytuQsa5Pf82cIoaaluhdu/aaRZukNU
	 NUvclMF3Erq+45mEOOLhzo4x/ESGmuPASXYq0Sw0CeWZqyDyQD9vplRk1Wo18Kq2fn
	 Gz6/5wJY1t6tsxQPj8KW15C6wrW9tPmn/xWRETZiOhIDEX+77PEIjPU5vf4p+5RRhf
	 Y/V1g+vs1+VfDqjfTx/9rpYCgG6w3bFX8PlxVDMKdemeUbivtjSAA6PO38EcqpqGg5
	 WhYrkykWfLG6pTze28PgXCATW5K4MUZ6RH7SyUCh62iwOCRshFOjgPO8FqiZD7vo7f
	 0NHPagdZT3VJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shigeru Yoshida <syoshida@redhat.com>,
	syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 292/317] hsr: Fix uninit-value access in hsr_get_node()
Date: Sun, 24 Mar 2024 19:34:32 -0400
Message-ID: <20240324233458.1352854-293-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Shigeru Yoshida <syoshida@redhat.com>

[ Upstream commit ddbec99f58571301679addbc022256970ca3eac6 ]

KMSAN reported the following uninit-value access issue [1]:

=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
 hsr_get_node+0xa2e/0xa40 net/hsr/hsr_framereg.c:246
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0xe12/0x30e0 net/hsr/hsr_forward.c:615
 hsr_dev_xmit+0x1a1/0x270 net/hsr/hsr_device.c:223
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2787
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5033 Comm: syz-executor334 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================

If the packet type ID field in the Ethernet header is either ETH_P_PRP or
ETH_P_HSR, but it is not followed by an HSR tag, hsr_get_skb_sequence_nr()
reads an invalid value as a sequence number. This causes the above issue.

This patch fixes the issue by returning NULL if the Ethernet header is not
followed by an HSR tag.

Fixes: f266a683a480 ("net/hsr: Better frame dispatch")
Reported-and-tested-by: syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2ef3a8ce8e91b5a50098 [1]
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
Link: https://lore.kernel.org/r/20240312152719.724530-1-syoshida@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_framereg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 8c9a20e99f0f4..e0aeeeda3c876 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -237,6 +237,10 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
+		/* Check if skb contains hsr_ethhdr */
+		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+			return NULL;
+
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */
-- 
2.43.0


