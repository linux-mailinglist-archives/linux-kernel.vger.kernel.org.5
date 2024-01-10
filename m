Return-Path: <linux-kernel+bounces-22456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F9F829DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C5C1C25F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155E44CB29;
	Wed, 10 Jan 2024 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qnBc33gk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146514C631
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2c2ca99cafd011eea2298b7352fd921d-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q0s1k9eEoemlcYdOq0E9vro+IfDLJ8Z+Cnoho1ngrrs=;
	b=qnBc33gkezpWmU/ZtR4Clr9s194GJpeUPEBj8Jky+GUbwmj5GcH4O9hN3zrEsMTaosXyALo7xYXB494ooy25YmpM0pOy77/BPavTw/NqrUv7l+PGZeJK7cLSiNwQ0bCoVv5TmXH9K/+LT9l2SEMZEB6f2TaYOSrlrSeZvEx4Nmo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b72ad591-29a7-4b27-9603-705d5a60d240,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:4e7f052f-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 2c2ca99cafd011eea2298b7352fd921d-20240110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 619818021; Wed, 10 Jan 2024 23:51:52 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 23:51:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 23:51:51 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Johnson Wang <johnson.wang@mediatek.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>, Singo Chang
	<singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>, Shawn Sung
	<shawn.sung@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 1/2] mailbox: mtk-cmdq: Change GCE hardware timeout to software timeout
Date: Wed, 10 Jan 2024 23:51:47 +0800
Message-ID: <20240110155148.6383-2-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240110155148.6383-1-jason-jh.lin@mediatek.com>
References: <20240110155148.6383-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

GCE axi_clock 156MHz, 1 tick cycle = 6.41ns.

The register CMDQ_INSTN_TIMEOUT_CYCLES is a GCE hardware configuration
for instruction timeout cycles. It's the cycles to issue instruction
timeout interrupt for wait and poll instructions.

This timeout setting is coarse-grain and has 100% uncertainty,
which means that if it is set to 16 cycles, the timeout will be reduced
from 16 * 2 = 32 cycles to 16 cycles.
If it is set to 64 cycles, the timeout will be reduced from 64 * 2 = 128
cycles to 64 cycles.

Current CMDQ_INSTN_TIMEOUT_CYCLES is set to 22, it means instruction
timeout is reduced from 2^22 * 2 * 6.41ns = 53.8ms to 26.9ms.

Since the max value of CMDQ_INSTN_TIMEOUT_CYCLES is 27, it means the max
instruction timeout is reduced from 2^27 * 2 * 6.41ns = 1720ms to 860ms.

It's not enough for the use case of ISP driver below:
GCE Thread A: wait for SOF and set event 1.
GCE Thread B: wait for event 1 and set event 2.
GCE Thread C: wait for event 2 and set event 3.
GCE Thread D: wait for event 3 and set event 4.
GCE Thread E: wait for event 4 and set EOF.
If all GCE Threads start at the same time, the latest GCE Thread E will
wait for event more than 2 seconds.

Therefore, we changed the hardware timeout to software timeout, making it
longer, more certain, and making it configurable by CMDQ client drivers.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c       | 172 +++++++++++++++++++++++
 include/linux/mailbox/mtk-cmdq-mailbox.h |   3 +
 2 files changed, 175 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index de862e9137d5..89567f837513 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -12,6 +12,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+#include <linux/sched/clock.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
@@ -64,6 +67,11 @@ struct cmdq_thread {
 	void __iomem		*base;
 	struct list_head	task_busy_list;
 	u32			priority;
+	u32			idx;
+	struct timer_list	timeout;
+	u32			timeout_ms;
+	struct work_struct	timeout_work;
+	u64			timer_mod;
 };
 
 struct cmdq_task {
@@ -83,6 +91,7 @@ struct cmdq {
 	struct cmdq_thread	*thread;
 	struct clk_bulk_data	clocks[CMDQ_GCE_NUM_MAX];
 	bool			suspended;
+	struct workqueue_struct	*timeout_wq;
 };
 
 struct gce_plat {
@@ -288,6 +297,158 @@ static void cmdq_thread_irq_handler(struct cmdq *cmdq,
 
 	if (list_empty(&thread->task_busy_list))
 		cmdq_thread_disable(cmdq, thread);
+
+	if (!task) {
+		cmdq_thread_disable(cmdq, thread);
+		pr_debug("empty task thread:%u", thread->idx);
+	} else {
+		mod_timer(&thread->timeout, jiffies +
+			  msecs_to_jiffies(thread->timeout_ms));
+		thread->timer_mod = sched_clock();
+		pr_debug("mod_timer pkt:0x%p timeout:%u thread:%u",
+			 task->pkt, thread->timeout_ms, thread->idx);
+	}
+}
+
+static bool cmdq_thread_timeout_exceed(struct cmdq_thread *thread)
+{
+	u64 duration;
+
+	/*
+	 * If the first execution time stamp is smaller than timeout value,
+	 * it is the last round of timeout. Skip it.
+	 */
+	duration = div_s64(sched_clock() - thread->timer_mod, 1000000);
+	if (duration < thread->timeout_ms) {
+		mod_timer(&thread->timeout, jiffies +
+			  msecs_to_jiffies(thread->timeout_ms - duration));
+		thread->timer_mod = sched_clock();
+		pr_debug("thread:%u mod time:%llu dur:%llu timeout not exceed",
+			 thread->idx, thread->timer_mod, duration);
+		return false;
+	}
+
+	return true;
+}
+
+static void cmdq_thread_handle_timeout_work(struct work_struct *work_item)
+{
+	struct cmdq_thread *thread = container_of(work_item,
+	struct cmdq_thread, timeout_work);
+	struct cmdq *cmdq = container_of(thread->chan->mbox, struct cmdq, mbox);
+	struct cmdq_task *task, *tmp, *timeout_task = NULL;
+	unsigned long flags;
+	dma_addr_t pa_curr;
+	struct list_head removes;
+
+	INIT_LIST_HEAD(&removes);
+
+	spin_lock_irqsave(&thread->chan->lock, flags);
+
+	if (list_empty(&thread->task_busy_list)) {
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+		return;
+	}
+
+	/* Check before suspending thread to prevent performance penalty. */
+	if (!cmdq_thread_timeout_exceed(thread)) {
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+		return;
+	}
+
+	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+
+	/*
+	 * Although IRQ is disabled, GCE continues to execute.
+	 * It may have pending IRQ before GCE thread is suspended,
+	 * so check this condition again.
+	 */
+	cmdq_thread_irq_handler(cmdq, thread);
+
+	if (list_empty(&thread->task_busy_list)) {
+		pr_err("thread:%u empty after irq handle in timeout", thread->idx);
+		goto unlock_free_done;
+	}
+
+	/* After IRQ, the first task may change. */
+	if (!cmdq_thread_timeout_exceed(thread)) {
+		cmdq_thread_resume(thread);
+		goto unlock_free_done;
+	}
+
+	pr_err("timeout for thread:0x%p idx:%u", thread->base, thread->idx);
+
+	pa_curr = readl(thread->base + CMDQ_THR_CURR_ADDR) << cmdq->pdata->shift;
+	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
+				 list_entry) {
+		u32 task_end_pa = task->pa_base + task->pkt->cmd_buf_size;
+
+		if (pa_curr >= task->pa_base && pa_curr < task_end_pa) {
+			timeout_task = task;
+			break;
+		}
+
+		pr_info("ending not curr in timeout pkt:0x%p curr_pa:%pa", task->pkt, &pa_curr);
+		cmdq_task_exec_done(task, 0);
+		kfree(task);
+	}
+
+	if (timeout_task) {
+		spin_unlock_irqrestore(&thread->chan->lock, flags);
+
+		cmdq_task_exec_done(timeout_task, -ETIMEDOUT);
+
+		spin_lock_irqsave(&thread->chan->lock, flags);
+
+		task = list_first_entry_or_null(&thread->task_busy_list,
+						struct cmdq_task, list_entry);
+		if (timeout_task == task) {
+			cmdq_task_exec_done(task, -ETIMEDOUT);
+			kfree(task);
+		} else {
+			pr_err("task list changed");
+		}
+	}
+
+	task = list_first_entry_or_null(&thread->task_busy_list,
+					struct cmdq_task, list_entry);
+	if (task) {
+		mod_timer(&thread->timeout, jiffies +
+			  msecs_to_jiffies(thread->timeout_ms));
+		thread->timer_mod = sched_clock();
+		cmdq_thread_reset(cmdq, thread);
+		cmdq_thread_resume(thread);
+	} else {
+		cmdq_thread_resume(thread);
+		cmdq_thread_disable(cmdq, thread);
+		pm_runtime_mark_last_busy(cmdq->mbox.dev);
+	}
+
+unlock_free_done:
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+
+	list_for_each_entry_safe(task, tmp, &removes, list_entry) {
+		list_del(&task->list_entry);
+		kfree(task);
+	}
+}
+
+static void cmdq_thread_handle_timeout(struct timer_list *t)
+{
+	struct cmdq_thread *thread = from_timer(thread, t, timeout);
+	struct cmdq *cmdq = container_of(thread->chan->mbox, struct cmdq, mbox);
+	unsigned long flags;
+	bool empty;
+
+	spin_lock_irqsave(&thread->chan->lock, flags);
+	empty = list_empty(&thread->task_busy_list);
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+
+	if (empty || work_pending(&thread->timeout_work))
+		return;
+
+	pr_debug("queue cmdq timeout thread:%u", thread->idx);
+	queue_work(cmdq->timeout_wq, &thread->timeout_work);
 }
 
 static irqreturn_t cmdq_irq_handler(int irq, void *dev)
@@ -426,6 +587,11 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 		writel(thread->priority, thread->base + CMDQ_THR_PRIORITY);
 		writel(CMDQ_THR_IRQ_EN, thread->base + CMDQ_THR_IRQ_ENABLE);
 		writel(CMDQ_THR_ENABLED, thread->base + CMDQ_THR_ENABLE_TASK);
+		if (thread->timeout_ms != CMDQ_NO_TIMEOUT) {
+			mod_timer(&thread->timeout, jiffies +
+				  msecs_to_jiffies(thread->timeout_ms));
+			thread->timer_mod = sched_clock();
+		}
 	} else {
 		WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
 		curr_pa = readl(thread->base + CMDQ_THR_CURR_ADDR) <<
@@ -657,10 +823,14 @@ static int cmdq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < cmdq->pdata->thread_nr; i++) {
+		cmdq->thread[i].idx = i;
 		cmdq->thread[i].base = cmdq->base + CMDQ_THR_BASE +
 				CMDQ_THR_SIZE * i;
+		cmdq->thread[i].timeout_ms = CMDQ_TIMEOUT_DEFAULT;
 		INIT_LIST_HEAD(&cmdq->thread[i].task_busy_list);
 		cmdq->mbox.chans[i].con_priv = (void *)&cmdq->thread[i];
+		timer_setup(&cmdq->thread[i].timeout, cmdq_thread_handle_timeout, 0);
+		INIT_WORK(&cmdq->thread[i].timeout_work, cmdq_thread_handle_timeout_work);
 	}
 
 	err = devm_mbox_controller_register(dev, &cmdq->mbox);
@@ -669,6 +839,8 @@ static int cmdq_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	cmdq->timeout_wq = create_singlethread_workqueue("cmdq_timeout_handler");
+
 	platform_set_drvdata(pdev, cmdq);
 
 	WARN_ON(clk_bulk_prepare(cmdq->pdata->gce_num, cmdq->clocks));
diff --git a/include/linux/mailbox/mtk-cmdq-mailbox.h b/include/linux/mailbox/mtk-cmdq-mailbox.h
index a8f0070c7aa9..4973b2ec37db 100644
--- a/include/linux/mailbox/mtk-cmdq-mailbox.h
+++ b/include/linux/mailbox/mtk-cmdq-mailbox.h
@@ -21,6 +21,9 @@
 #define CMDQ_WFE_WAIT			BIT(15)
 #define CMDQ_WFE_WAIT_VALUE		0x1
 
+#define CMDQ_TIMEOUT_DEFAULT		1000
+#define CMDQ_NO_TIMEOUT			0xffffffff
+
 /*
  * WFE arg_b
  * bit 0-11: wait value
-- 
2.18.0


