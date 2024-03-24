Return-Path: <linux-kernel+bounces-116117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF76889963
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C098D1C30946
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8CF3ABE83;
	Mon, 25 Mar 2024 03:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDOjHOEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C76280213;
	Sun, 24 Mar 2024 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323640; cv=none; b=CrqQfp4LUc5WLJL44RTVYDNGFYBZ1ppOU/4lT/LNSE9u1vGsyk8PaDcbU2OztnQRda3GNrF1+5lcRNodjHqScEfTA69/uGNO9qr48y2Nbs9qpSmDUeoc0G17HAJW0OhTV2Gu0/L5tPWUf1WKvg5UOvEVj/GbBjaDTkUMxYtdWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323640; c=relaxed/simple;
	bh=ttS7QcQyTQtqfNwAtJPI+G3AAOWCTfZVzehAOR8AHHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0uPpbgDIKD9Ol9TvtWJ41dS7lGbQ7O1e3CNJIZKEen2IdAZmUqhHqFf5s4ILHxqGzJWXhtv3hATl54gP26HB02ULA7lho5mC3o/+uO7XYC9scSLmUlAbXBdlk6iLkun9jkbPJyDzt3kiRoFdL2pjdWeu0+fH8qX3CKgwXrt3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDOjHOEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C29C41679;
	Sun, 24 Mar 2024 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323640;
	bh=ttS7QcQyTQtqfNwAtJPI+G3AAOWCTfZVzehAOR8AHHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDOjHOEfu0XbdBG82cdzg9/k15rs0iGeRGOc0Xu4y0nTXBKsIcupovYDYoOJSp55z
	 3gCux69kxZNh5n05gZJNXVkq+DQwkpZ40BXOqQWinJKzU5MgvjrHuX/Otl98L6x6cM
	 m4qcjyTAYJnpTAzBG5vQarL9dy2sIdaLM3Yx/V7PE+oVhdNqq+qAUtI1H4AYet2T88
	 N+TRbCCEzVweSb/2DZo9VH4HZ9w8rrX0utKHBRIuEQBcAdwlbwMJsFe3+p/Cp6OQ7c
	 gDimOk7IPMaikmsCd8lmjAOC+jtk6aUObKMVU51K+UW6pjWd3pmn8xgYc07Y0gXkBp
	 AZsSiCtaLeugw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 012/238] RDMA/mlx5: Fix fortify source warning while accessing Eth segment
Date: Sun, 24 Mar 2024 19:36:40 -0400
Message-ID: <20240324234027.1354210-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 4d5e86a56615cc387d21c629f9af8fb0e958d350 ]

 ------------[ cut here ]------------
 memcpy: detected field-spanning write (size 56) of single field "eseg->inline_hdr.start" at /var/lib/dkms/mlnx-ofed-kernel/5.8/build/drivers/infiniband/hw/mlx5/wr.c:131 (size 2)
 WARNING: CPU: 0 PID: 293779 at /var/lib/dkms/mlnx-ofed-kernel/5.8/build/drivers/infiniband/hw/mlx5/wr.c:131 mlx5_ib_post_send+0x191b/0x1a60 [mlx5_ib]
 Modules linked in: 8021q garp mrp stp llc rdma_ucm(OE) rdma_cm(OE) iw_cm(OE) ib_ipoib(OE) ib_cm(OE) ib_umad(OE) mlx5_ib(OE) ib_uverbs(OE) ib_core(OE) mlx5_core(OE) pci_hyperv_intf mlxdevm(OE) mlx_compat(OE) tls mlxfw(OE) psample nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables libcrc32c nfnetlink mst_pciconf(OE) knem(OE) vfio_pci vfio_pci_core vfio_iommu_type1 vfio iommufd irqbypass cuse nfsv3 nfs fscache netfs xfrm_user xfrm_algo ipmi_devintf ipmi_msghandler binfmt_misc crct10dif_pclmul crc32_pclmul polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 snd_pcsp aesni_intel crypto_simd cryptd snd_pcm snd_timer joydev snd soundcore input_leds serio_raw evbug nfsd auth_rpcgss nfs_acl lockd grace sch_fq_codel sunrpc drm efi_pstore ip_tables x_tables autofs4 psmouse virtio_net net_failover failover floppy
  [last unloaded: mlx_compat(OE)]
 CPU: 0 PID: 293779 Comm: ssh Tainted: G           OE      6.2.0-32-generic #32~22.04.1-Ubuntu
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:mlx5_ib_post_send+0x191b/0x1a60 [mlx5_ib]
 Code: 0c 01 00 a8 01 75 25 48 8b 75 a0 b9 02 00 00 00 48 c7 c2 10 5b fd c0 48 c7 c7 80 5b fd c0 c6 05 57 0c 03 00 01 e8 95 4d 93 da <0f> 0b 44 8b 4d b0 4c 8b 45 c8 48 8b 4d c0 e9 49 fb ff ff 41 0f b7
 RSP: 0018:ffffb5b48478b570 EFLAGS: 00010046
 RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffffb5b48478b628 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffffb5b48478b5e8
 R13: ffff963a3c609b5e R14: ffff9639c3fbd800 R15: ffffb5b480475a80
 FS:  00007fc03b444c80(0000) GS:ffff963a3dc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000556f46bdf000 CR3: 0000000006ac6003 CR4: 00000000003706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  ? show_regs+0x72/0x90
  ? mlx5_ib_post_send+0x191b/0x1a60 [mlx5_ib]
  ? __warn+0x8d/0x160
  ? mlx5_ib_post_send+0x191b/0x1a60 [mlx5_ib]
  ? report_bug+0x1bb/0x1d0
  ? handle_bug+0x46/0x90
  ? exc_invalid_op+0x19/0x80
  ? asm_exc_invalid_op+0x1b/0x20
  ? mlx5_ib_post_send+0x191b/0x1a60 [mlx5_ib]
  mlx5_ib_post_send_nodrain+0xb/0x20 [mlx5_ib]
  ipoib_send+0x2ec/0x770 [ib_ipoib]
  ipoib_start_xmit+0x5a0/0x770 [ib_ipoib]
  dev_hard_start_xmit+0x8e/0x1e0
  ? validate_xmit_skb_list+0x4d/0x80
  sch_direct_xmit+0x116/0x3a0
  __dev_xmit_skb+0x1fd/0x580
  __dev_queue_xmit+0x284/0x6b0
  ? _raw_spin_unlock_irq+0xe/0x50
  ? __flush_work.isra.0+0x20d/0x370
  ? push_pseudo_header+0x17/0x40 [ib_ipoib]
  neigh_connected_output+0xcd/0x110
  ip_finish_output2+0x179/0x480
  ? __smp_call_single_queue+0x61/0xa0
  __ip_finish_output+0xc3/0x190
  ip_finish_output+0x2e/0xf0
  ip_output+0x78/0x110
  ? __pfx_ip_finish_output+0x10/0x10
  ip_local_out+0x64/0x70
  __ip_queue_xmit+0x18a/0x460
  ip_queue_xmit+0x15/0x30
  __tcp_transmit_skb+0x914/0x9c0
  tcp_write_xmit+0x334/0x8d0
  tcp_push_one+0x3c/0x60
  tcp_sendmsg_locked+0x2e1/0xac0
  tcp_sendmsg+0x2d/0x50
  inet_sendmsg+0x43/0x90
  sock_sendmsg+0x68/0x80
  sock_write_iter+0x93/0x100
  vfs_write+0x326/0x3c0
  ksys_write+0xbd/0xf0
  ? do_syscall_64+0x69/0x90
  __x64_sys_write+0x19/0x30
  do_syscall_64+0x59/0x90
  ? do_user_addr_fault+0x1d0/0x640
  ? exit_to_user_mode_prepare+0x3b/0xd0
  ? irqentry_exit_to_user_mode+0x9/0x20
  ? irqentry_exit+0x43/0x50
  ? exc_page_fault+0x92/0x1b0
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7fc03ad14a37
 Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
 RSP: 002b:00007ffdf8697fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
 RAX: ffffffffffffffda RBX: 0000000000008024 RCX: 00007fc03ad14a37
 RDX: 0000000000008024 RSI: 0000556f46bd8270 RDI: 0000000000000003
 RBP: 0000556f46bb1800 R08: 0000000000007fe3 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
 R13: 0000556f46bc66b0 R14: 000000000000000a R15: 0000556f46bb2f50
  </TASK>
 ---[ end trace 0000000000000000 ]---

Link: https://lore.kernel.org/r/8228ad34bd1a25047586270f7b1fb4ddcd046282.1706433934.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/wr.c | 2 +-
 include/linux/mlx5/qp.h         | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index d6038fb6c50c6..19fd440a6ce38 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -128,7 +128,7 @@ static void set_eth_seg(const struct ib_send_wr *wr, struct mlx5_ib_qp *qp,
 		 */
 		copysz = min_t(u64, *cur_edge - (void *)eseg->inline_hdr.start,
 			       left);
-		memcpy(eseg->inline_hdr.start, pdata, copysz);
+		memcpy(eseg->inline_hdr.data, pdata, copysz);
 		stride = ALIGN(sizeof(struct mlx5_wqe_eth_seg) -
 			       sizeof(eseg->inline_hdr.start) + copysz, 16);
 		*size += stride / 16;
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index d75ef8aa8fac0..28d44061d6700 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -261,7 +261,10 @@ struct mlx5_wqe_eth_seg {
 	union {
 		struct {
 			__be16 sz;
-			u8     start[2];
+			union {
+				u8     start[2];
+				DECLARE_FLEX_ARRAY(u8, data);
+			};
 		} inline_hdr;
 		struct {
 			__be16 type;
-- 
2.43.0


