Return-Path: <linux-kernel+bounces-101770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFE687AB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D13F1F215CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9F60EC3;
	Wed, 13 Mar 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCDgmWQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4960DEE;
	Wed, 13 Mar 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347597; cv=none; b=oas2oPI0y2P01r+qf8ZFNzZ2dX8sDri6cpyK1SudfDEnW6TTlPrTEWHWSLMB8QwjaoTYeRndwNltIiPkn3KArDFuAboDX076gFYJtqJvEinTyPfgok23vFHP07DtyMMH3dsY0JlGBAQrnkRgGXtRSiRpjnaJQXLPdMJtAX98zbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347597; c=relaxed/simple;
	bh=JTJ8+/X7qWcyCrJQPR3ZVY0eDNitmbK/WDO7L53OXkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPZbYjWi4PtX9xKKMDlrUvgxeYO8fgROb4P56aS0hu5GYc3OYD6Zj8LUyQnmwQAIYfYmvRcDeilQlD8BZq1xkbAdsWtwzaCS5G8I10QR0IM+XTTTG3iTMpq78pc6Kl1RhVEQMR+EEab2wa0xS2hbadtResbU+FjOJdXRSzcFpv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCDgmWQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37F4C433C7;
	Wed, 13 Mar 2024 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347596;
	bh=JTJ8+/X7qWcyCrJQPR3ZVY0eDNitmbK/WDO7L53OXkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCDgmWQ6+9yDaZjCOCNihfMjp+Q5niqT+GYHfWnA2ZT+FrSZmiiuGZhHxYbR08+kl
	 6f9IfhgTUEZBZbizR8CKUxREcOU585PnAvip2Z/rr1VM8YtLH615VK4lVG24nJraxI
	 3YwxUXvGZxXHc0jRAA1codORr+K3yHxKoAeUBj9shDOuzb9uk6R+K8+dSXXl/gSll4
	 uyhyfTz1wvWHjgmVGUXZQU4UzY14Zr49sXAn5nYYNBI+mQ2M0TRHscOjAr/rer73L6
	 9Zq0wmk5h9r7J+NBzcML8HT6s6htJ0JdWKdcoLyxouT4tH6VG6gJUw+qFJK7qQNQja
	 44Asyqg80iFpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 31/61] ice: fix uninitialized dplls mutex usage
Date: Wed, 13 Mar 2024 12:32:06 -0400
Message-ID: <20240313163236.613880-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 9224fc86f1776193650a33a275cac628952f80a9 ]

The pf->dplls.lock mutex is initialized too late, after its first use.
Move it to the top of ice_dpll_init.
Note that the "err_exit" error path destroys the mutex. And the mutex is
the last thing destroyed in ice_dpll_deinit.
This fixes the following warning with CONFIG_DEBUG_MUTEXES:

 ice 0000:10:00.0: The DDP package was successfully loaded: ICE OS Default Package version 1.3.36.0
 ice 0000:10:00.0: 252.048 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x16 link)
 ice 0000:10:00.0: PTP init successful
 ------------[ cut here ]------------
 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 0 PID: 410 at kernel/locking/mutex.c:587 __mutex_lock+0x773/0xd40
 Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ice(+) nvme nvme_c>
 CPU: 0 PID: 410 Comm: kworker/0:4 Not tainted 6.8.0-rc5+ #3
 Hardware name: HPE ProLiant DL110 Gen10 Plus/ProLiant DL110 Gen10 Plus, BIOS U56 10/19/2023
 Workqueue: events work_for_cpu_fn
 RIP: 0010:__mutex_lock+0x773/0xd40
 Code: c0 0f 84 1d f9 ff ff 44 8b 35 0d 9c 69 01 45 85 f6 0f 85 0d f9 ff ff 48 c7 c6 12 a2 a9 85 48 c7 c7 12 f1 a>
 RSP: 0018:ff7eb1a3417a7ae0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
 RDX: 0000000000000002 RSI: ffffffff85ac2bff RDI: 00000000ffffffff
 RBP: ff7eb1a3417a7b80 R08: 0000000000000000 R09: 00000000ffffbfff
 R10: ff7eb1a3417a7978 R11: ff32b80f7fd2e568 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ff32b7f02c50e0d8
 FS:  0000000000000000(0000) GS:ff32b80efe800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b5852cc000 CR3: 000000003c43a004 CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0x84/0x170
  ? __mutex_lock+0x773/0xd40
  ? report_bug+0x1c7/0x1d0
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x42/0x70
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __mutex_lock+0x773/0xd40
  ? rcu_is_watching+0x11/0x50
  ? __kmalloc_node_track_caller+0x346/0x490
  ? ice_dpll_lock_status_get+0x28/0x50 [ice]
  ? __pfx_ice_dpll_lock_status_get+0x10/0x10 [ice]
  ? ice_dpll_lock_status_get+0x28/0x50 [ice]
  ice_dpll_lock_status_get+0x28/0x50 [ice]
  dpll_device_get_one+0x14f/0x2e0
  dpll_device_event_send+0x7d/0x150
  dpll_device_register+0x124/0x180
  ice_dpll_init_dpll+0x7b/0xd0 [ice]
  ice_dpll_init+0x224/0xa40 [ice]
  ? _dev_info+0x70/0x90
  ice_load+0x468/0x690 [ice]
  ice_probe+0x75b/0xa10 [ice]
  ? _raw_spin_unlock_irqrestore+0x4f/0x80
  ? process_one_work+0x1a3/0x500
  local_pci_probe+0x47/0xa0
  work_for_cpu_fn+0x17/0x30
  process_one_work+0x20d/0x500
  worker_thread+0x1df/0x3e0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x103/0x140
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x31/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>
 irq event stamp: 125197
 hardirqs last  enabled at (125197): [<ffffffff8416409d>] finish_task_switch.isra.0+0x12d/0x3d0
 hardirqs last disabled at (125196): [<ffffffff85134044>] __schedule+0xea4/0x19f0
 softirqs last  enabled at (105334): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
 softirqs last disabled at (105332): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
 ---[ end trace 0000000000000000 ]---

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 2b657d43c769d..68b894bb68fe7 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2146,6 +2146,7 @@ void ice_dpll_init(struct ice_pf *pf)
 	struct ice_dplls *d = &pf->dplls;
 	int err = 0;
 
+	mutex_init(&d->lock);
 	err = ice_dpll_init_info(pf, cgu);
 	if (err)
 		goto err_exit;
@@ -2158,7 +2159,6 @@ void ice_dpll_init(struct ice_pf *pf)
 	err = ice_dpll_init_pins(pf, cgu);
 	if (err)
 		goto deinit_pps;
-	mutex_init(&d->lock);
 	if (cgu) {
 		err = ice_dpll_init_worker(pf);
 		if (err)
-- 
2.43.0


