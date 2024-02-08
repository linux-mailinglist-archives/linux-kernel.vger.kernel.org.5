Return-Path: <linux-kernel+bounces-58876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF6E84EDFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BE21C247FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187F50273;
	Thu,  8 Feb 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3AeeRlTx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8124350260;
	Thu,  8 Feb 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435802; cv=none; b=kl3fo+WaXeYHzGNeKhLMERj5S3oueCkdjT8q9u9ky2OBBiD8/xefa/EGbPUakWSk02ygppHkateAQgsRQlf8xBLRbk1w/eEdZ+BiYXw2F+wf1mJzhlw7VOcv3HUpPVCgunkyiSRX1oo6gqcQVG/QRyxyKJkbVfG58Y9h7Pm5KaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435802; c=relaxed/simple;
	bh=FcU1HQnbrNpwrhlaTcQWC4QviLii4+cZDQ0xzc526og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tU6O1MQa/fOWqXWqtRlb439XGP0agwkYDtPfpMkIZInR+EVcv3kzTh5RgNstq08OXcaUzTVvI1MCxEfdq/8qBmYN6V/jziA8HlUAo8SvBFB+3b0Pol89Hgb1h7TCJPcespWM0GKppt6WRkPPKJPZFFNOayHPv/X82Djm0zj/yFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3AeeRlTx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707435798;
	bh=FcU1HQnbrNpwrhlaTcQWC4QviLii4+cZDQ0xzc526og=;
	h=From:To:Cc:Subject:Date:From;
	b=3AeeRlTxjB1MsHqf+ncyU+hQkIsLvZBQb+eQFjhZsOjoAGwh5SUPvGWIIhUurLmrn
	 QTQytSSmbgGYbUxPCvDv5QWGqhuiCLwfxR9RW3fP98WkMr2YUNn1T+8C+5Xxv7dfQX
	 ElVanXnHl/SNiNxdFwBjhw0ITIL5EA2iJJOn01mX+DyWeue7fXaR1RR0KyabhBA3MJ
	 6/2TI2ZeHjHeuLxOhjh2/F+080rZChR+jG+GxM1n8GE2y5eV12L9qMvd0qcNKJqAC7
	 TGdzML65LPJsz4kc2kzISOMr6UhiU0AHWeXl5QH5asaESPU1DOhEmSz4C8ID2bvrxm
	 Rxn3mksv2Iz0Q==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 29EA3378103D;
	Thu,  8 Feb 2024 23:43:18 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] ASoC: SOF: amd: Fix locking in ACP IRQ handler
Date: Fri,  9 Feb 2024 01:43:14 +0200
Message-ID: <20240208234315.2182048-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A recent change in acp_irq_thread() was meant to address a potential race
condition while trying to acquire the hardware semaphore responsible for
the synchronization between firmware and host IPC interrupts.

This resulted in an improper use of the IPC spinlock, causing normal
kernel memory allocations (which may sleep) inside atomic contexts:

1707255557.133976 kernel: BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
1707255557.134068 kernel: in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 502, name: irq/66-AudioDSP
1707255557.134089 kernel: preempt_count: 1, expected: 0
1707255557.134105 kernel: RCU nest depth: 0, expected: 0
1707255557.134120 kernel: 1 lock held by irq/66-AudioDSP/502:
1707255557.134157 kernel:  #0: ffff96514137d848 (&sdev->ipc_lock){....}-{2:2}, at: acp_irq_thread+0x3a/0x130 [snd_sof_amd_acp]
1707255557.134205 kernel: irq event stamp: 36
1707255557.134258 kernel: hardirqs last  enabled at (35): [<ffffffff9b1059ac>] finish_task_switch.isra.0+0xbc/0x340
1707255557.134290 kernel: hardirqs last disabled at (36): [<ffffffff9be19313>] _raw_spin_lock_irq+0x53/0x60
1707255557.134338 kernel: softirqs last  enabled at (0): [<ffffffff9b0b1a62>] copy_process+0xb42/0x2a30
1707255557.134412 kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
1707255557.134446 kernel: CPU: 5 PID: 502 Comm: irq/66-AudioDSP Not tainted 6.8.0-rc3-next-20240206-audio-next #9
1707255557.134478 kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0105 11/07/2023
1707255557.134512 kernel: Call Trace:
1707255557.134544 kernel:  <TASK>
1707255557.134575 kernel:  dump_stack_lvl+0x5b/0x90
1707255557.134613 kernel:  __might_resched+0x16f/0x280
1707255557.134645 kernel:  __kmalloc+0x2f3/0x460
1707255557.134675 kernel:  ? sof_ipc3_rx_msg+0x70/0x130 [snd_sof]
1707255557.134718 kernel:  ? srso_return_thunk+0x5/0x5f
1707255557.134757 kernel:  sof_ipc3_rx_msg+0x70/0x130 [snd_sof]
1707255557.134793 kernel:  acp_sof_ipc_irq_thread+0x1e0/0x550 [snd_sof_amd_acp]
1707255557.134855 kernel:  acp_irq_thread+0xa3/0x130 [snd_sof_amd_acp]
1707255557.134904 kernel:  ? irq_thread+0xb5/0x1e0
1707255557.134947 kernel:  ? __pfx_irq_thread_fn+0x10/0x10
1707255557.134985 kernel:  irq_thread_fn+0x23/0x60
1707255557.135020 kernel:  ? irq_thread+0xb5/0x1e0
1707255557.135051 kernel:  irq_thread+0x10f/0x1e0
1707255557.135083 kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
1707255557.135114 kernel:  ? __pfx_irq_thread+0x10/0x10
1707255557.135136 kernel:  kthread+0xe3/0x110
1707255557.135161 kernel:  ? __pfx_kthread+0x10/0x10
1707255557.135176 kernel:  ret_from_fork+0x34/0x50
1707255557.134855 kernel:  acp_irq_thread+0xa3/0x130 [snd_sof_amd_acp]
1707255557.134904 kernel:  ? irq_thread+0xb5/0x1e0
1707255557.134947 kernel:  ? __pfx_irq_thread_fn+0x10/0x10
1707255557.134985 kernel:  irq_thread_fn+0x23/0x60
1707255557.135020 kernel:  ? irq_thread+0xb5/0x1e0
1707255557.135051 kernel:  irq_thread+0x10f/0x1e0
1707255557.135083 kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
1707255557.135114 kernel:  ? __pfx_irq_thread+0x10/0x10
1707255557.135136 kernel:  kthread+0xe3/0x110
1707255557.135161 kernel:  ? __pfx_kthread+0x10/0x10
1707255557.135176 kernel:  ret_from_fork+0x34/0x50
1707255557.135197 kernel:  ? __pfx_kthread+0x10/0x10
1707255557.135212 kernel:  ret_from_fork_asm+0x1a/0x30
1707255557.135227 kernel:  </TASK>

Moreover, there are attempts to lock a mutex from the same atomic
context:

1707255557.136357 kernel: =============================
1707255557.136393 kernel: [ BUG: Invalid wait context ]
1707255557.136413 kernel: 6.8.0-rc3-next-20240206-audio-next #9 Tainted: G        W
1707255557.136432 kernel: -----------------------------
1707255557.136451 kernel: irq/66-AudioDSP/502 is trying to lock:
1707255557.136470 kernel: ffff965152f26af8 (&sb->s_type->i_mutex_key#2){+.+.}-{3:3}, at: start_creating.part.0+0x5f/0x180
1707255557.136490 kernel: other info that might help us debug this:
1707255557.137103 kernel: context-{4:4}
1707255557.137129 kernel: 1 lock held by irq/66-AudioDSP/502:
1707255557.137153 kernel:  #0: ffff96514137d848 (&sdev->ipc_lock){....}-{2:2}, at: acp_irq_thread+0x3a/0x130 [snd_sof_amd_acp]
1707255557.137172 kernel: stack backtrace:
1707255557.137194 kernel: CPU: 5 PID: 502 Comm: irq/66-AudioDSP Tainted: G        W          6.8.0-rc3-next-20240206-audio-next #9
1707255557.137217 kernel: Hardware name: Valve Galileo/Galileo, BIOS F7G0105 11/07/2023
1707255557.137239 kernel: Call Trace:
1707255557.137275 kernel:  <TASK>
1707255557.137294 kernel:  dump_stack_lvl+0x5b/0x90
1707255557.137313 kernel:  __lock_acquire+0x95c/0x2270
1707255557.137331 kernel:  lock_acquire+0xcb/0x2c0
1707255557.137354 kernel:  ? start_creating.part.0+0x5f/0x180
1707255557.137387 kernel:  down_write+0x3f/0xc0
1707255557.137410 kernel:  ? start_creating.part.0+0x5f/0x180
1707255557.137429 kernel:  start_creating.part.0+0x5f/0x180
1707255557.137457 kernel:  __debugfs_create_file+0x61/0x210
1707255557.137475 kernel:  snd_sof_debugfs_io_item+0x75/0xc0 [snd_sof]
1707255557.137494 kernel:  sof_ipc3_do_rx_work+0x7cf/0x9f0 [snd_sof]
1707255557.137513 kernel:  sof_ipc3_rx_msg+0xb3/0x130 [snd_sof]
1707255557.137532 kernel:  acp_sof_ipc_irq_thread+0x1e0/0x550 [snd_sof_amd_acp]
1707255557.137551 kernel:  acp_irq_thread+0xa3/0x130 [snd_sof_amd_acp]
1707255557.137574 kernel:  ? irq_thread+0xb5/0x1e0
1707255557.137593 kernel:  ? __pfx_irq_thread_fn+0x10/0x10
1707255557.137611 kernel:  irq_thread_fn+0x23/0x60
1707255557.137630 kernel:  ? irq_thread+0xb5/0x1e0
1707255557.137653 kernel:  irq_thread+0x10f/0x1e0
1707255557.137671 kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
1707255557.137690 kernel:  ? __pfx_irq_thread+0x10/0x10
1707255557.137708 kernel:  kthread+0xe3/0x110
1707255557.137734 kernel:  ? __pfx_kthread+0x10/0x10
1707255557.137763 kernel:  ret_from_fork+0x34/0x50
1707255557.137791 kernel:  ? __pfx_kthread+0x10/0x10
1707255557.137813 kernel:  ret_from_fork_asm+0x1a/0x30
1707255557.137831 kernel:  </TASK>

Fix the issues by reducing the lock scope in acp_irq_thread(), so that
it guards only the hardware semaphore acquiring attempt.  Additionally,
restore the initial locking in acp_sof_ipc_irq_thread() to synchronize
the handling of immediate replies from DSP core.

Fixes: 802134c8c2c8 ("ASoC: SOF: amd: Refactor spinlock_irq(&sdev->ipc_lock) sequence in irq_handler")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 sound/soc/sof/amd/acp-ipc.c |  2 ++
 sound/soc/sof/amd/acp.c     | 17 ++++++++---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/sof/amd/acp-ipc.c b/sound/soc/sof/amd/acp-ipc.c
index 2743f07a5e08..b44b1b1adb6e 100644
--- a/sound/soc/sof/amd/acp-ipc.c
+++ b/sound/soc/sof/amd/acp-ipc.c
@@ -188,11 +188,13 @@ irqreturn_t acp_sof_ipc_irq_thread(int irq, void *context)
 
 	dsp_ack = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_ack_write);
 	if (dsp_ack) {
+		spin_lock_irq(&sdev->ipc_lock);
 		/* handle immediate reply from DSP core */
 		acp_dsp_ipc_get_reply(sdev);
 		snd_sof_ipc_reply(sdev, 0);
 		/* set the done bit */
 		acp_dsp_ipc_dsp_done(sdev);
+		spin_unlock_irq(&sdev->ipc_lock);
 		ipc_irq = true;
 	}
 
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index c7f86b46c426..e69abeece61f 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -343,21 +343,20 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 	unsigned int count = ACP_HW_SEM_RETRY_COUNT;
 
 	spin_lock_irq(&sdev->ipc_lock);
-	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset)) {
-		/* Wait until acquired HW Semaphore lock or timeout */
-		count--;
-		if (!count) {
-			dev_err(sdev->dev, "%s: Failed to acquire HW lock\n", __func__);
-			spin_unlock_irq(&sdev->ipc_lock);
-			return IRQ_NONE;
-		}
+	/* Wait until acquired HW Semaphore lock or timeout */
+	while (snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset) && --count)
+		;
+	spin_unlock_irq(&sdev->ipc_lock);
+
+	if (!count) {
+		dev_err(sdev->dev, "%s: Failed to acquire HW lock\n", __func__);
+		return IRQ_NONE;
 	}
 
 	sof_ops(sdev)->irq_thread(irq, sdev);
 	/* Unlock or Release HW Semaphore */
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->hw_semaphore_offset, 0x0);
 
-	spin_unlock_irq(&sdev->ipc_lock);
 	return IRQ_HANDLED;
 };
 
-- 
2.43.0


