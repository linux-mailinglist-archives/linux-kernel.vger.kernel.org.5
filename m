Return-Path: <linux-kernel+bounces-129992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C808972F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E597B25C00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D37146A91;
	Wed,  3 Apr 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qz/spG0Y"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7282F28
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155568; cv=none; b=X/WmpL/Bwny0wfpsBCz4Y7QGGOUtqanbpMcby+IEqVQT4XjFsCgIC18y5xQ0kmumXkUwPavqaEQE68YGGga/OsHnqf7ohlCesQOeOJnAIwabaVdmKuR831K0DeLiot94+TO4hyPZpdca05Idg1S0vC5u1TP35MuxtpK331LA+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155568; c=relaxed/simple;
	bh=Bkma2vvA711QJ1sXoJYTefXt7jPIF2fcenRzzsPv9IM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=c0eCVKTlvCpRiPEYYJ6us8ltnOISUJUM71Vd45OxQ7Ea4xAfR52rCfmUEiBkeml/VDPy/m8SC6yMBNXgm/dw6eWf1lfXEkWTHFpgbdFDE3mruVlIgHHQeLMwpUM1RjMTpRYXrHWH/YlxzSqXkW3mDyAAmUf7aKOOCYVmn2wZdts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qz/spG0Y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2DBEC20E8CAD;
	Wed,  3 Apr 2024 07:46:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DBEC20E8CAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712155562;
	bh=38iNl+rF/lzeHjwDYB3g27MP/ka2YeWE/iAkcIBwE2k=;
	h=From:To:Cc:Subject:Date:From;
	b=qz/spG0Y7mc4FQiHZPt8gz2KAtJlbkw1nvdaXU29K9jwdMgNVWLFd+w1gTV3wqn4w
	 p+6XTjcZNAmCgy41B6HNS22piC4dE7QltsAUF76rPHFm0bUkdAeb7bAt7gA+rdrHmH
	 63ZCQ6/YxkdoSp8IzdlDO8vyLdEguhYTYUZPNBxA=
From: Allen Pais <apais@linux.microsoft.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	keescook@chromium.org,
	o-takashi@sakamocchi.jp,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH] firewire: Convert from tasklet to BH workqueue
Date: Wed,  3 Apr 2024 14:45:58 +0000
Message-Id: <20240403144558.13398-1-apais@linux.microsoft.com>
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

This patch converts drivers/firewire/* from tasklet to BH workqueue.

Based on the work done by Tejun Heo <tj@kernel.org>
Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v1

Changes are tested by: @recallmenot
(https://github.com/allenpais/for-6.9-bh-conversions/issues/1)

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/firewire/ohci.c | 54 ++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 7bc71f4be64a..0c8e73e894e8 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -93,7 +93,7 @@ struct ar_context {
 	void *pointer;
 	unsigned int last_buffer_index;
 	u32 regs;
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 };
 
 struct context;
@@ -150,7 +150,7 @@ struct context {
 
 	descriptor_callback_t callback;
 
-	struct tasklet_struct tasklet;
+	struct work_struct work;
 };
 
 #define IT_HEADER_SY(v)          ((v) <<  0)
@@ -968,9 +968,9 @@ static void ar_recycle_buffers(struct ar_context *ctx, unsigned int end_buffer)
 	}
 }
 
-static void ar_context_tasklet(unsigned long data)
+static void ar_context_work(struct work_struct *w)
 {
-	struct ar_context *ctx = (struct ar_context *)data;
+	struct ar_context *ctx = from_work(ctx, w, work);
 	unsigned int end_buffer_index, end_buffer_offset;
 	void *p, *end;
 
@@ -1025,7 +1025,7 @@ static int ar_context_init(struct ar_context *ctx, struct fw_ohci *ohci,
 
 	ctx->regs        = regs;
 	ctx->ohci        = ohci;
-	tasklet_init(&ctx->tasklet, ar_context_tasklet, (unsigned long)ctx);
+	INIT_WORK(&ctx->work, ar_context_work);
 
 	for (i = 0; i < AR_BUFFERS; i++) {
 		ctx->pages[i] = dma_alloc_pages(dev, PAGE_SIZE, &dma_addr,
@@ -1093,9 +1093,9 @@ static struct descriptor *find_branch_descriptor(struct descriptor *d, int z)
 		return d + z - 1;
 }
 
-static void context_tasklet(unsigned long data)
+static void context_work(struct work_struct *w)
 {
-	struct context *ctx = (struct context *) data;
+	struct context *ctx = from_work(ctx, w, work);
 	struct descriptor *d, *last;
 	u32 address;
 	int z;
@@ -1188,7 +1188,7 @@ static int context_init(struct context *ctx, struct fw_ohci *ohci,
 	ctx->buffer_tail = list_entry(ctx->buffer_list.next,
 			struct descriptor_buffer, list);
 
-	tasklet_init(&ctx->tasklet, context_tasklet, (unsigned long)ctx);
+	INIT_WORK(&ctx->work, context_work);
 	ctx->callback = callback;
 
 	/*
@@ -1460,13 +1460,12 @@ static int at_context_queue_packet(struct context *ctx,
 
 static void at_context_flush(struct context *ctx)
 {
-	tasklet_disable(&ctx->tasklet);
+	disable_work_sync(&ctx->work);
 
 	ctx->flushing = true;
-	context_tasklet((unsigned long)ctx);
 	ctx->flushing = false;
 
-	tasklet_enable(&ctx->tasklet);
+	enable_and_queue_work(system_bh_wq, &ctx->work);
 }
 
 static int handle_at_packet(struct context *context,
@@ -2136,16 +2135,16 @@ static irqreturn_t irq_handler(int irq, void *data)
 		queue_work(selfid_workqueue, &ohci->bus_reset_work);
 
 	if (event & OHCI1394_RQPkt)
-		tasklet_schedule(&ohci->ar_request_ctx.tasklet);
+		queue_work(system_bh_wq, &ohci->ar_request_ctx.work);
 
 	if (event & OHCI1394_RSPkt)
-		tasklet_schedule(&ohci->ar_response_ctx.tasklet);
+		queue_work(system_bh_wq, &ohci->ar_response_ctx.work);
 
 	if (event & OHCI1394_reqTxComplete)
-		tasklet_schedule(&ohci->at_request_ctx.tasklet);
+		queue_work(system_bh_wq, &ohci->at_request_ctx.work);
 
 	if (event & OHCI1394_respTxComplete)
-		tasklet_schedule(&ohci->at_response_ctx.tasklet);
+		queue_work(system_bh_wq, &ohci->at_response_ctx.work);
 
 	if (event & OHCI1394_isochRx) {
 		iso_event = reg_read(ohci, OHCI1394_IsoRecvIntEventClear);
@@ -2153,8 +2152,8 @@ static irqreturn_t irq_handler(int irq, void *data)
 
 		while (iso_event) {
 			i = ffs(iso_event) - 1;
-			tasklet_schedule(
-				&ohci->ir_context_list[i].context.tasklet);
+			queue_work(system_bh_wq,
+				&ohci->ir_context_list[i].context.work);
 			iso_event &= ~(1 << i);
 		}
 	}
@@ -2165,8 +2164,8 @@ static irqreturn_t irq_handler(int irq, void *data)
 
 		while (iso_event) {
 			i = ffs(iso_event) - 1;
-			tasklet_schedule(
-				&ohci->it_context_list[i].context.tasklet);
+			queue_work(system_bh_wq,
+				&ohci->it_context_list[i].context.work);
 			iso_event &= ~(1 << i);
 		}
 	}
@@ -2431,7 +2430,7 @@ static int ohci_enable(struct fw_card *card,
 	 * They shouldn't do that in this initial case where the link
 	 * isn't enabled.  This means we have to use the same
 	 * workaround here, setting the bus header to 0 and then write
-	 * the right values in the bus reset tasklet.
+	 * the right values in the bus reset work.
 	 */
 
 	if (config_rom) {
@@ -2521,7 +2520,7 @@ static int ohci_set_config_rom(struct fw_card *card,
 	 * during the atomic update, even on litte endian
 	 * architectures.  The workaround we use is to put a 0 in the
 	 * header quadlet; 0 is endian agnostic and means that the
-	 * config rom isn't ready yet.  In the bus reset tasklet we
+	 * config rom isn't ready yet.  In the bus reset work we
 	 * then set up the real values for the two registers.
 	 *
 	 * We use ohci->lock to avoid racing with the code that sets
@@ -2570,7 +2569,7 @@ static int ohci_set_config_rom(struct fw_card *card,
 	/*
 	 * Now initiate a bus reset to have the changes take
 	 * effect. We clean up the old config rom memory and DMA
-	 * mappings in the bus reset tasklet, since the OHCI
+	 * mappings in the bus reset work, since the OHCI
 	 * controller could need to access it before the bus reset
 	 * takes effect.
 	 */
@@ -2601,7 +2600,7 @@ static int ohci_cancel_packet(struct fw_card *card, struct fw_packet *packet)
 	struct driver_data *driver_data = packet->driver_data;
 	int ret = -ENOENT;
 
-	tasklet_disable_in_atomic(&ctx->tasklet);
+	disable_work_sync(&ctx->work);
 
 	if (packet->ack != 0)
 		goto out;
@@ -2620,7 +2619,7 @@ static int ohci_cancel_packet(struct fw_card *card, struct fw_packet *packet)
 	packet->callback(packet, &ohci->card, packet->ack);
 	ret = 0;
  out:
-	tasklet_enable(&ctx->tasklet);
+	enable_and_queue_work(system_bh_wq, &ctx->work);
 
 	return ret;
 }
@@ -3153,7 +3152,7 @@ static int ohci_stop_iso(struct fw_iso_context *base)
 	}
 	flush_writes(ohci);
 	context_stop(&ctx->context);
-	tasklet_kill(&ctx->context.tasklet);
+	cancel_work_sync(&ctx->context.work);
 
 	return 0;
 }
@@ -3525,10 +3524,9 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 	struct iso_context *ctx = container_of(base, struct iso_context, base);
 	int ret = 0;
 
-	tasklet_disable_in_atomic(&ctx->context.tasklet);
+	disable_work_sync(&ctx->context.work);
 
 	if (!test_and_set_bit_lock(0, &ctx->flushing_completions)) {
-		context_tasklet((unsigned long)&ctx->context);
 
 		switch (base->type) {
 		case FW_ISO_CONTEXT_TRANSMIT:
@@ -3548,7 +3546,7 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 		smp_mb__after_atomic();
 	}
 
-	tasklet_enable(&ctx->context.tasklet);
+	enable_and_queue_work(system_bh_wq, &ctx->context.work);
 
 	return ret;
 }
-- 
2.17.1


