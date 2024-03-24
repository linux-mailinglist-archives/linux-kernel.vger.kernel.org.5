Return-Path: <linux-kernel+bounces-113778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08376888E81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98131F32267
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82741F6172;
	Sun, 24 Mar 2024 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMBpdPpX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A71D8DDB;
	Sun, 24 Mar 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320790; cv=none; b=nsMi4PBFT78awTlEgBgUHbP+mC/vxMxc99yYveu53mjFdqerNV8NOnssCUrV/+V99Y46HzdLoKx0e+xtNB25qSThwajGHKR6gSl9xTj0m3KsZiAXwBx2t1sREhD9yoX2WLh7VDZwY+/LuHZMiZr8Qcb6enNAL1xQw9SzWP7Si74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320790; c=relaxed/simple;
	bh=ZcHPGh/+6JRCBw+dWU/yC1PN20jUS9Kcv6f7ag8lQs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD/PnBeFWw30U825X9ritdA0bZ7ye/q1+Mw8YeYxOdegwxr44EMbb2O9lt8swKO2mVPPFKca6AFJCv1CAgnrl5W+KmpoQ/9BxSOM73HglN2CU66oKgxbcVedZWh3FZdu4wGQCfFM0bNwEa3Ez9+T01tpxfq831igqb5d5pVPtSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMBpdPpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9A5C433F1;
	Sun, 24 Mar 2024 22:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320789;
	bh=ZcHPGh/+6JRCBw+dWU/yC1PN20jUS9Kcv6f7ag8lQs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pMBpdPpXbgvR82UTKZTexT4gI7WuA2+bvAmW/qIlSAhJGBQxF5X0csVWxrIJYo9Vc
	 XhytScioX0SkEJ8tFTrKsPSKsssjrc7ODF17GbA9gaSFDAuzfC0OQbec5nXpYXfeef
	 9eSbAUFPg6ECqyLfYv/YtHtOsCsrMs6uc2JNj2R5GVlId1HuiZhc1nTv3wfwxLlIBi
	 M3cwrQq7taNZdOfcFMv4SLzQ6gcjToq7gP2T3ZLMIscY/p0cX+sXWq60IIl7ziAXp2
	 bR/i6S6LPRYpQnMKmDb5VWHY8xrCWORZ+3jD0UUv0hNaO8mN+TNPrd5V6zW0MYGYrC
	 JTRhhR91xaYaQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 352/713] Bluetooth: btrtl: fix out of bounds memory access
Date: Sun, 24 Mar 2024 18:41:18 -0400
Message-ID: <20240324224720.1345309-353-sashal@kernel.org>
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

From: Andrey Skvortsov <andrej.skvortzov@gmail.com>

[ Upstream commit de4e88ec58c4202efd1f02eebb4939bbf6945358 ]

The problem is detected by KASAN.
btrtl driver uses private hci data to store 'struct btrealtek_data'.
If btrtl driver is used with btusb, then memory for private hci data
is allocated in btusb. But no private data is allocated after hci_dev,
when btrtl is used with hci_h5.

This commit adds memory allocation for hci_h5 case.

 ==================================================================
 BUG: KASAN: slab-out-of-bounds in btrtl_initialize+0x6cc/0x958 [btrtl]
 Write of size 8 at addr ffff00000f5a5748 by task kworker/u9:0/76

 Hardware name: Pine64 PinePhone (1.2) (DT)
 Workqueue: hci0 hci_power_on [bluetooth]
 Call trace:
  dump_backtrace+0x9c/0x128
  show_stack+0x20/0x38
  dump_stack_lvl+0x48/0x60
  print_report+0xf8/0x5d8
  kasan_report+0x90/0xd0
  __asan_store8+0x9c/0xc0
  	 [btrtl]
  h5_btrtl_setup+0xd0/0x2f8 [hci_uart]
  h5_setup+0x50/0x80 [hci_uart]
  hci_uart_setup+0xd4/0x260 [hci_uart]
  hci_dev_open_sync+0x1cc/0xf68 [bluetooth]
  hci_dev_do_open+0x34/0x90 [bluetooth]
  hci_power_on+0xc4/0x3c8 [bluetooth]
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Allocated by task 53:
  kasan_save_stack+0x3c/0x68
  kasan_save_track+0x20/0x40
  kasan_save_alloc_info+0x68/0x78
  __kasan_kmalloc+0xd4/0xd8
  __kmalloc+0x1b4/0x3b0
  hci_alloc_dev_priv+0x28/0xa58 [bluetooth]
  hci_uart_register_device+0x118/0x4f8 [hci_uart]
  h5_serdev_probe+0xf4/0x178 [hci_uart]
  serdev_drv_probe+0x54/0xa0
  really_probe+0x254/0x588
  __driver_probe_device+0xc4/0x210
  driver_probe_device+0x64/0x160
  __driver_attach_async_helper+0x88/0x158
  async_run_entry_fn+0xd0/0x388
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Last potentially related work creation:
  kasan_save_stack+0x3c/0x68
  __kasan_record_aux_stack+0xb0/0x150
  kasan_record_aux_stack_noalloc+0x14/0x20
  __queue_work+0x33c/0x960
  queue_work_on+0x98/0xc0
  hci_recv_frame+0xc8/0x1e8 [bluetooth]
  h5_complete_rx_pkt+0x2c8/0x800 [hci_uart]
  h5_rx_payload+0x98/0xb8 [hci_uart]
  h5_recv+0x158/0x3d8 [hci_uart]
  hci_uart_receive_buf+0xa0/0xe8 [hci_uart]
  ttyport_receive_buf+0xac/0x178
  flush_to_ldisc+0x130/0x2c8
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20

 Second to last potentially related work creation:
  kasan_save_stack+0x3c/0x68
  __kasan_record_aux_stack+0xb0/0x150
  kasan_record_aux_stack_noalloc+0x14/0x20
  __queue_work+0x788/0x960
  queue_work_on+0x98/0xc0
  __hci_cmd_sync_sk+0x23c/0x7a0 [bluetooth]
  __hci_cmd_sync+0x24/0x38 [bluetooth]
  btrtl_initialize+0x760/0x958 [btrtl]
  h5_btrtl_setup+0xd0/0x2f8 [hci_uart]
  h5_setup+0x50/0x80 [hci_uart]
  hci_uart_setup+0xd4/0x260 [hci_uart]
  hci_dev_open_sync+0x1cc/0xf68 [bluetooth]
  hci_dev_do_open+0x34/0x90 [bluetooth]
  hci_power_on+0xc4/0x3c8 [bluetooth]
  process_one_work+0x328/0x6f0
  worker_thread+0x410/0x778
  kthread+0x168/0x178
  ret_from_fork+0x10/0x20
 ==================================================================

Fixes: 5b355944b190 ("Bluetooth: btrtl: Add btrealtek data struct")
Fixes: 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_h5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index b66136348bd64..c0436881a533c 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -1072,6 +1072,7 @@ static struct h5_vnd rtl_vnd = {
 	.suspend	= h5_btrtl_suspend,
 	.resume		= h5_btrtl_resume,
 	.acpi_gpio_map	= acpi_btrtl_gpios,
+	.sizeof_priv    = sizeof(struct btrealtek_data),
 };
 
 static const struct h5_device_data h5_data_rtl8822cs = {
-- 
2.43.0


