Return-Path: <linux-kernel+bounces-92654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A848723B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC11285ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F1B12AAC2;
	Tue,  5 Mar 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VVvlkgBI"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA18129A8D;
	Tue,  5 Mar 2024 16:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654754; cv=none; b=knaqyY7nesUVykcSsi67CDXT+XH8raEz/L4VImzze6YonJv1Ef16w2gmOTL1Hnu5kRFzJ1BKHcHOkqnijgRNsswnqtANqBNEd2nEQ0MY9QFUDL+aqE/uM8veEUKHE6BKrztvVDNu8QNKZKEIyIH9W8mOc0GwZMXgBQpeWUU4fts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654754; c=relaxed/simple;
	bh=yi+Qoq9jhI5EfV7BZEqPQjeGXw+XN7tk1f/9xhPqR08=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1qWwjYsYPRYDimVoK1424Zu/OWaTnxbAbe3ZRo/MpaCP8oSh+quUfXZ+oW22PgXhe1zjIGVSVi6qk1avOeX1Jlrnb3YLvINdzS1lALkq88QZe7fscCvSvojsasFsCRk2FMrzFz6lYnw4WgzWwOHd8OpGD24ofBkShtjhO+H0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VVvlkgBI; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 425G5Vgq001787;
	Tue, 5 Mar 2024 10:05:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709654731;
	bh=TN1lJOtZgl9pWC0KQdX8fI7Y8M+iQRPemeKajaXZ7HI=;
	h=From:To:CC:Subject:Date;
	b=VVvlkgBIyrJjQHq+Xpjivu1vI/8qrETV8uwXYVTsTIZ0pXn5a17TMHqehyzqu9Xs1
	 Y5ZiuZa55YQyoVhDf0WJU93UtLo0BpLQxAwesOq9K0WW3WhV0uwE461W9gPm20Y0sq
	 gfHaZ/Qg+uiUrwB6yyji6KdpewHKRKfkC4rPjZKU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 425G5V4l076804
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 Mar 2024 10:05:31 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Mar 2024 10:05:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Mar 2024 10:05:30 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 425G5UME124919;
	Tue, 5 Mar 2024 10:05:30 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <nas.chung@chipsnmedia.com>, <jackson.lee@chipsnmedia.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sebastian.fricke@collabora.com>,
        <nm@ti.com>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
        <j-luthra@ti.com>, <b-brnich@ti.com>, <detheridge@ti.com>,
        <p-mantena@ti.com>, <vijayp@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2] media: chips-media: wave5: Add hrtimer based polling support
Date: Tue, 5 Mar 2024 21:35:29 +0530
Message-ID: <20240305160529.4152865-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for starting a polling timer in case an interrupt is not
available. This helps to keep the VPU functional in SoCs such as AM62A,
where the hardware interrupt hookup may not be present due to an SoC errata
[1].

The timer is shared across all instances of encoders and decoders and is
started when the first instance of an encoder or decoder is opened and
stopped when the last instance is closed, thus avoiding per instance
polling and saving CPU bandwidth. As VPU driver manages this instance
related tracking and synchronization, the aforementioned shared timer
related polling logic is implemented within the VPU driver itself. This
scheme may also be useful in general too (even if irq is present) for
non-realtime multi-instance VPU use-cases (for e.g 32 instances of VPU
being run together) where system is running already under high interrupt
load and switching to polling may help mitigate this as the polling thread
is shared across all the VPU instances.

Hrtimer is chosen for polling here as it provides precise timing and
scheduling and the API seems better suited for periodic polling task such
as this.  As a general rule of thumb,

Worst case latency with hrtimer = Actual latency (achievable with irq)
                                  + Polling interval

NOTE (the meaning of terms used above is as follows):
- Latency: Time taken to process one frame
- Actual Latency : Time taken by hardware to process one frame and signal
  it to OS (i.e. if latency that was possible to achieve if irq line was
present)

There is a trade-off between latency and CPU usage when deciding the value
for polling interval. With aggressive polling intervals (i.e. going with
even lesser values) the CPU usage increases although worst case latencies
get better. On the contrary, with greater polling intervals worst case
latencies will increase although the CPU usage will decrease.

The 5ms offered a good balance between the two as we were able to reach
close to actual latencies (as achievable with irq) without incurring too
much of CPU as seen in below experiments and thus 5ms is chosen as default
polling interval.

- 1x 640x480@25 Encoding using different hrtimer polling intervals [2]
- 4x 1080p30 Transcode (File->decode->encode->file) irq vs polling
  comparison [3]
- 1x 1080p Transcode (File->decode->encode->file) irq vs polling comparison
  [4]
- 1080p60 Streaming use-case irq vs polling comparison [5]
- 1x 1080p30 sanity decode and encode tests [6]

The polling interval can also be changed using vpu_poll_interval module
param in case user want to change it as per their use-case requirement
keeping in mind above trade-off.

Based on interrupt status, we use a worker thread to iterate over the
interrupt status for each instance and send completion event as being done
in irq thread function.

Move the core functionality of the irq thread function to a separate
function wave5_vpu_handle_irq so that it can be used by both the worker
thread when using polling mode and irq thread when using interrupt mode.

Protect the hrtimer access and instance list with device specific mutex
locks to avoid race conditions while different instances of encoder and
decoder are started together.

[1] https://www.ti.com/lit/pdf/spruj16
(Ref: Section 4.2.3.3 Resets, Interrupts, and Clocks)
[2] https://gist.github.com/devarsht/ee9664d3403d1212ef477a027b71896c
[3] https://gist.github.com/devarsht/3a58b4f201430dfc61697c7e224e74c2
[4] https://gist.github.com/devarsht/a6480f1f2cbdf8dd694d698309d81fb0
[5] https://gist.github.com/devarsht/44aaa4322454e85e01a8d65ac47c5edb
[6] https://gist.github.com/devarsht/2f956bcc6152dba728ce08cebdcebe1d

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Tested-by: Jackson Lee <jackson.lee@chipsnmedia.com>
---
V2:
- Update commit message as suggested in review to give more context
  on design being chosen and analysis that was done to decide on same
- Add Tested-By
- Remove extra return variable declaration from wave5_vpu_release_device

Range diff w.r.t v1 :
https://gist.github.com/devarsht/cd6bbb4ba90b0229be4718b7140ef924
---
 .../platform/chips-media/wave5/wave5-helper.c |  17 ++-
 .../chips-media/wave5/wave5-vpu-dec.c         |  13 +-
 .../chips-media/wave5/wave5-vpu-enc.c         |  13 +-
 .../platform/chips-media/wave5/wave5-vpu.c    | 117 ++++++++++++------
 .../platform/chips-media/wave5/wave5-vpuapi.h |   4 +
 5 files changed, 122 insertions(+), 42 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-helper.c b/drivers/media/platform/chips-media/wave5/wave5-helper.c
index 8433ecab230c..0b1b5a11e15b 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-helper.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-helper.c
@@ -52,11 +52,12 @@ int wave5_vpu_release_device(struct file *filp,
 			     char *name)
 {
 	struct vpu_instance *inst = wave5_to_vpu_inst(filp->private_data);
+	struct vpu_device *dev = inst->dev;
+	int ret;
 
 	v4l2_m2m_ctx_release(inst->v4l2_fh.m2m_ctx);
 	if (inst->state != VPU_INST_STATE_NONE) {
 		u32 fail_res;
-		int ret;
 
 		ret = close_func(inst, &fail_res);
 		if (fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
@@ -71,8 +72,20 @@ int wave5_vpu_release_device(struct file *filp,
 	}
 
 	wave5_cleanup_instance(inst);
+	if (dev->irq < 0) {
+		ret = mutex_lock_interruptible(&dev->dev_lock);
+		if (ret)
+			return ret;
 
-	return 0;
+		if (list_empty(&dev->instances)) {
+			dev_dbg(dev->dev, "Disabling the hrtimer\n");
+			hrtimer_cancel(&dev->hrtimer);
+		}
+
+		mutex_unlock(&dev->dev_lock);
+	}
+
+	return ret;
 }
 
 int wave5_vpu_queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq,
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index ef227af72348..c8624c681fa6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1810,7 +1810,6 @@ static int wave5_vpu_open_dec(struct file *filp)
 	v4l2_fh_add(&inst->v4l2_fh);
 
 	INIT_LIST_HEAD(&inst->list);
-	list_add_tail(&inst->list, &dev->instances);
 
 	inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_dec_dev;
 	inst->v4l2_fh.m2m_ctx =
@@ -1867,6 +1866,18 @@ static int wave5_vpu_open_dec(struct file *filp)
 
 	wave5_vdi_allocate_sram(inst->dev);
 
+	ret = mutex_lock_interruptible(&dev->dev_lock);
+	if (ret)
+		goto cleanup_inst;
+
+	if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) && list_empty(&dev->instances))
+		hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval * NSEC_PER_MSEC),
+			      HRTIMER_MODE_REL_PINNED);
+
+	list_add_tail(&inst->list, &dev->instances);
+
+	mutex_unlock(&dev->dev_lock);
+
 	return 0;
 
 cleanup_inst:
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
index f29cfa3af94a..9e88424761b6 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
@@ -1554,7 +1554,6 @@ static int wave5_vpu_open_enc(struct file *filp)
 	v4l2_fh_add(&inst->v4l2_fh);
 
 	INIT_LIST_HEAD(&inst->list);
-	list_add_tail(&inst->list, &dev->instances);
 
 	inst->v4l2_m2m_dev = inst->dev->v4l2_m2m_enc_dev;
 	inst->v4l2_fh.m2m_ctx =
@@ -1729,6 +1728,18 @@ static int wave5_vpu_open_enc(struct file *filp)
 
 	wave5_vdi_allocate_sram(inst->dev);
 
+	ret = mutex_lock_interruptible(&dev->dev_lock);
+	if (ret)
+		goto cleanup_inst;
+
+	if (dev->irq < 0 && !hrtimer_active(&dev->hrtimer) && list_empty(&dev->instances))
+		hrtimer_start(&dev->hrtimer, ns_to_ktime(dev->vpu_poll_interval * NSEC_PER_MSEC),
+			      HRTIMER_MODE_REL_PINNED);
+
+	list_add_tail(&inst->list, &dev->instances);
+
+	mutex_unlock(&dev->dev_lock);
+
 	return 0;
 
 cleanup_inst:
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 0d90b5820bef..257c5e226129 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -26,6 +26,9 @@ struct wave5_match_data {
 	const char *fw_name;
 };
 
+static int vpu_poll_interval = 5;
+module_param(vpu_poll_interval, int, 0644);
+
 int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
 {
 	int ret;
@@ -40,7 +43,7 @@ int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int timeout)
 	return 0;
 }
 
-static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
+static void wave5_vpu_handle_irq(void *dev_id)
 {
 	u32 seq_done;
 	u32 cmd_done;
@@ -48,42 +51,67 @@ static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
 	struct vpu_instance *inst;
 	struct vpu_device *dev = dev_id;
 
-	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
-		irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
-		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
-		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
-
-		list_for_each_entry(inst, &dev->instances, list) {
-			seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
-			cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
-
-			if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
-			    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
-				if (seq_done & BIT(inst->id)) {
-					seq_done &= ~BIT(inst->id);
-					wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
-								 seq_done);
-					complete(&inst->irq_done);
-				}
+	irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
+	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
+	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
+
+	list_for_each_entry(inst, &dev->instances, list) {
+		seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
+		cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
+
+		if (irq_reason & BIT(INT_WAVE5_INIT_SEQ) ||
+		    irq_reason & BIT(INT_WAVE5_ENC_SET_PARAM)) {
+			if (seq_done & BIT(inst->id)) {
+				seq_done &= ~BIT(inst->id);
+				wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO,
+							 seq_done);
+				complete(&inst->irq_done);
 			}
+		}
 
-			if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
-			    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
-				if (cmd_done & BIT(inst->id)) {
-					cmd_done &= ~BIT(inst->id);
-					wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
-								 cmd_done);
-					inst->ops->finish_process(inst);
-				}
+		if (irq_reason & BIT(INT_WAVE5_DEC_PIC) ||
+		    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
+			if (cmd_done & BIT(inst->id)) {
+				cmd_done &= ~BIT(inst->id);
+				wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST,
+							 cmd_done);
+				inst->ops->finish_process(inst);
 			}
-
-			wave5_vpu_clear_interrupt(inst, irq_reason);
 		}
+
+		wave5_vpu_clear_interrupt(inst, irq_reason);
 	}
+}
+
+static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
+{
+	struct vpu_device *dev = dev_id;
+
+	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
+		wave5_vpu_handle_irq(dev);
 
 	return IRQ_HANDLED;
 }
 
+static void wave5_vpu_irq_work_fn(struct kthread_work *work)
+{
+	struct vpu_device *dev = container_of(work, struct vpu_device, work);
+
+	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS))
+		wave5_vpu_handle_irq(dev);
+}
+
+static enum hrtimer_restart wave5_vpu_timer_callback(struct hrtimer *timer)
+{
+	struct vpu_device *dev =
+			container_of(timer, struct vpu_device, hrtimer);
+
+	kthread_queue_work(dev->worker, &dev->work);
+	hrtimer_forward_now(timer, ns_to_ktime(vpu_poll_interval * NSEC_PER_MSEC));
+
+	return HRTIMER_RESTART;
+}
+
 static int wave5_vpu_load_firmware(struct device *dev, const char *fw_name,
 				   u32 *revision)
 {
@@ -209,16 +237,24 @@ static int wave5_vpu_probe(struct platform_device *pdev)
 
 	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
-		ret = -ENXIO;
-		goto err_enc_unreg;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
-					wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
-	if (ret) {
-		dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
-		goto err_enc_unreg;
+		dev_err(&pdev->dev, "failed to get irq resource, falling back to polling\n");
+		hrtimer_init(&dev->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
+		dev->hrtimer.function = &wave5_vpu_timer_callback;
+		dev->worker = kthread_create_worker(0, "vpu_irq_thread");
+		if (IS_ERR(dev->worker)) {
+			dev_err(&pdev->dev, "failed to create vpu irq worker\n");
+			ret = PTR_ERR(dev->worker);
+			goto err_vdi_release;
+		}
+		dev->vpu_poll_interval = vpu_poll_interval;
+		kthread_init_work(&dev->work, wave5_vpu_irq_work_fn);
+	} else {
+		ret = devm_request_threaded_irq(&pdev->dev, dev->irq, NULL,
+						wave5_vpu_irq_thread, IRQF_ONESHOT, "vpu_irq", dev);
+		if (ret) {
+			dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
+			goto err_enc_unreg;
+		}
 	}
 
 	ret = wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name, &fw_revision);
@@ -254,6 +290,11 @@ static int wave5_vpu_remove(struct platform_device *pdev)
 {
 	struct vpu_device *dev = dev_get_drvdata(&pdev->dev);
 
+	if (dev->irq < 0) {
+		kthread_destroy_worker(dev->worker);
+		hrtimer_cancel(&dev->hrtimer);
+	}
+
 	mutex_destroy(&dev->dev_lock);
 	mutex_destroy(&dev->hw_lock);
 	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
index 352f6e904e50..edc50450ddb8 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.h
@@ -756,6 +756,10 @@ struct vpu_device {
 	u32 product_code;
 	struct ida inst_ida;
 	struct clk_bulk_data *clks;
+	struct hrtimer hrtimer;
+	struct kthread_work work;
+	struct kthread_worker *worker;
+	int vpu_poll_interval;
 	int num_clks;
 };
 
-- 
2.39.1


