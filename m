Return-Path: <linux-kernel+bounces-130202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7107F897556
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0E11C219EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8957914A0A2;
	Wed,  3 Apr 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HG1/nkdB"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7E617C98
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162182; cv=none; b=EtPBh5PI8DDkRCm+hH9wo1JtHilsvdaipxv9GRBHVUnUSH3vz3ITtIF5sgupcxprW8jum/ceIBGBlWZxHf0/QH7/w36gqZhikkbfS/FhcUML9sRdtntLH75MSUf9pvLBZMf17Ze9AzsphmbCl/T88VLlTJwhUsBrdm3mQ8SPq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162182; c=relaxed/simple;
	bh=eIMVrEm+QK91oqIVYF1q0QCM5zRl2Mem/2dY1fM91uE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=aCjtK2mnSk80kFkGVfID8zSox8M3CPUVCB8UHclztmJFFOPLbLsFl+wnsvZL88wP6q4D4xVfJ0oNcoOfWa1/2UFR3g1/juxPSbacxXBQ4YaYtBQJ36/OmAEw61bZxpt8iSCtGupqB1Tq7WssPHU4OMlNr4GIqFS1bH7oJMBateo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HG1/nkdB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 376E020E8CB7;
	Wed,  3 Apr 2024 09:36:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 376E020E8CB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712162181;
	bh=60vJn9WJC4I5TOsEnff/yYbpcF37VSFPGuuQFKy/8JQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HG1/nkdBpbKUV6ZI8sA/tDUaL+C7lgzhMfuUtKjssfVW1/Aj1F0qKQgO/kR0bAdFR
	 H+HKQvIJpsKmURLYJxsS8m8y73AVyM0y9jVaL5X01jw6TVLDr7ytsZMCweyPXJNUEA
	 9t7JjYrG0zVUSFbGUU64HsmIAYJ+fbH5csSB8Prg=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	mporter@kernel.crashing.org,
	alex.bou9@gmail.com
Subject: [PATCH] rapidio/tsi721: Convert from tasklet to BH workqueue
Date: Wed,  3 Apr 2024 16:36:17 +0000
Message-Id: <20240403163617.20710-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts drivers/rapidio/* from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/rapidio/devices/tsi721.h     |  2 +-
 drivers/rapidio/devices/tsi721_dma.c | 15 +++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.h b/drivers/rapidio/devices/tsi721.h
index 4f996ce62725..8fd8127d11d1 100644
--- a/drivers/rapidio/devices/tsi721.h
+++ b/drivers/rapidio/devices/tsi721.h
@@ -704,7 +704,7 @@ struct tsi721_bdma_chan {
 	struct tsi721_tx_desc	*active_tx;
 	struct list_head	queue;
 	struct list_head	free_list;
-	struct tasklet_struct	tasklet;
+	struct work_struct	work;
 	bool			active;
 };
 
diff --git a/drivers/rapidio/devices/tsi721_dma.c b/drivers/rapidio/devices/tsi721_dma.c
index f77f75172bdc..f71cbbacca12 100644
--- a/drivers/rapidio/devices/tsi721_dma.c
+++ b/drivers/rapidio/devices/tsi721_dma.c
@@ -278,7 +278,7 @@ void tsi721_bdma_handler(struct tsi721_bdma_chan *bdma_chan)
 	/* Disable BDMA channel interrupts */
 	iowrite32(0, bdma_chan->regs + TSI721_DMAC_INTE);
 	if (bdma_chan->active)
-		tasklet_hi_schedule(&bdma_chan->tasklet);
+		queue_work(system_bh_highpri_wq, &bdma_chan->work);
 }
 
 #ifdef CONFIG_PCI_MSI
@@ -296,7 +296,7 @@ static irqreturn_t tsi721_bdma_msix(int irq, void *ptr)
 	struct tsi721_bdma_chan *bdma_chan = ptr;
 
 	if (bdma_chan->active)
-		tasklet_hi_schedule(&bdma_chan->tasklet);
+		queue_work(system_bh_highpri_wq, &bdma_chan->work);
 	return IRQ_HANDLED;
 }
 #endif /* CONFIG_PCI_MSI */
@@ -568,9 +568,9 @@ static void tsi721_advance_work(struct tsi721_bdma_chan *bdma_chan,
 		  bdma_chan->id);
 }
 
-static void tsi721_dma_tasklet(unsigned long data)
+static void tsi721_dma_work(struct work_struct *t)
 {
-	struct tsi721_bdma_chan *bdma_chan = (struct tsi721_bdma_chan *)data;
+	struct tsi721_bdma_chan *bdma_chan = from_work(bdma_chan, t, work);
 	u32 dmac_int, dmac_sts;
 
 	dmac_int = ioread32(bdma_chan->regs + TSI721_DMAC_INT);
@@ -790,7 +790,7 @@ static void tsi721_free_chan_resources(struct dma_chan *dchan)
 	tsi721_bdma_interrupt_enable(bdma_chan, 0);
 	bdma_chan->active = false;
 	tsi721_sync_dma_irq(bdma_chan);
-	tasklet_kill(&bdma_chan->tasklet);
+	cancel_work_sync(&bdma_chan->work);
 	INIT_LIST_HEAD(&bdma_chan->free_list);
 	kfree(bdma_chan->tx_desc);
 	tsi721_bdma_ch_free(bdma_chan);
@@ -990,8 +990,7 @@ int tsi721_register_dma(struct tsi721_device *priv)
 		INIT_LIST_HEAD(&bdma_chan->queue);
 		INIT_LIST_HEAD(&bdma_chan->free_list);
 
-		tasklet_init(&bdma_chan->tasklet, tsi721_dma_tasklet,
-			     (unsigned long)bdma_chan);
+		INIT_WORK(&bdma_chan->work, tsi721_dma_work);
 		list_add_tail(&bdma_chan->dchan.device_node,
 			      &mport->dma.channels);
 		nr_channels++;
@@ -1033,7 +1032,7 @@ void tsi721_unregister_dma(struct tsi721_device *priv)
 			tsi721_bdma_interrupt_enable(bdma_chan, 0);
 			bdma_chan->active = false;
 			tsi721_sync_dma_irq(bdma_chan);
-			tasklet_kill(&bdma_chan->tasklet);
+			cancel_work_sync(&bdma_chan->work);
 			INIT_LIST_HEAD(&bdma_chan->free_list);
 			kfree(bdma_chan->tx_desc);
 			tsi721_bdma_ch_free(bdma_chan);
-- 
2.17.1


