Return-Path: <linux-kernel+bounces-56920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2508E84D162
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0B5628B4B6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEBA84A20;
	Wed,  7 Feb 2024 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQdUkb2A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D080F8529D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331349; cv=none; b=cd4Ofj2aqgfSOlGqS3W2fRNEiAIa3gqJCnxT/pneZnlYb/1EUKVtdp/35EpVTpKEkiR8pfDNgWVxLg+O14pY7irl7Xav2Ub3Wzn0GdXqcQEp1A/12ZLtD1/MmqiJZgiHos3ddqwmLQnPgwF1iMtUNKV/a3gRZqS5Mwam8CJZQfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331349; c=relaxed/simple;
	bh=UeygM9npBEUq1MKQwn5tUh8m7ES9H0uWtUU1AqB2VWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5OmLJjlz2QV79JOUa7V9l/3Km9ENHj+ASSc1qnZqqQBXekuFvdB+6CuJ4wtN3FBIxvO8yfqTLGtwhzOx3hBH45189UjfGiuY/0EqYlSXd8J0xLtvuI6Xoh1P7qghNS5mBjhtD4kCgFOHUrpi86Ex23sSmN25GiHv6B17yO5wUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQdUkb2A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cuv9rvzEed+0pQINLR4eZlmzvTUXMYlIRXYRIOt5NJQ=;
	b=hQdUkb2A4TuKqF5vVQFX2zuhjv55gntocFpadqGy3TIiMSHaalZkGxi8LQ918t2HkJpGNS
	xSQJGFIvP0krvy3h7ycQC9lRC/xSGmgmNzo1i+CtvUyffrU7B5rfVXIHTOA9k2Z4HgFF3u
	sGlpOV5VX5B4HmR1QJr8WzDFoCw9TQc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-s5caMUuGOx6vwEyw6XmQ_A-1; Wed,
 07 Feb 2024 13:42:25 -0500
X-MC-Unique: s5caMUuGOx6vwEyw6XmQ_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A62D29AC012;
	Wed,  7 Feb 2024 18:42:25 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A15F140C9444;
	Wed,  7 Feb 2024 18:42:24 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 4/6] pci nvme async shutdown support
Date: Wed,  7 Feb 2024 13:40:58 -0500
Message-ID: <20240207184100.18066-5-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Alter nvme so that the pci nvme driver may shut down the hardware
asynchronously, providing a large benefit to shutdown time with large numbers
of nvme devices in some configurations.

The functionality of nvme_disable_ctrl is split in separate functions for
starting disabling the hardware and for waiting for the hardware to report
success. A wrapper is created which provides the same interface for the
other nvme types so they remain unchanged.

And new field is added to nvme-pci's nvme_dev to track the nvme shutdown
state so that the nvme async_shutdown_end call knows what if anything it
still needs to do.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/nvme/host/core.c | 26 +++++++++++++++-----
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 53 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..b24985a843a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2242,20 +2242,21 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	return ret;
 }
 
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+int nvme_disable_ctrl_send(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	int ret;
-
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	if (shutdown)
 		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 	else
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-	if (ret)
-		return ret;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+}
+EXPORT_SYMBOL_GPL(nvme_disable_ctrl_send);
 
+
+int nvme_disable_ctrl_wait(struct nvme_ctrl *ctrl, bool shutdown)
+{
 	if (shutdown) {
 		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
 				       NVME_CSTS_SHST_CMPLT,
@@ -2266,6 +2267,19 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
 			       (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2, "reset");
 }
+EXPORT_SYMBOL_GPL(nvme_disable_ctrl_wait);
+
+
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+{
+	int ret;
+
+	ret = nvme_disable_ctrl_send(ctrl, shutdown);
+	if (!ret)
+		ret = nvme_disable_ctrl_wait(ctrl, shutdown);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c80818240..5bdd862328d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -761,6 +761,8 @@ void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
+int nvme_disable_ctrl_send(struct nvme_ctrl *ctrl, bool shutdown);
+int nvme_disable_ctrl_wait(struct nvme_ctrl *ctrl, bool shutdown);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1d6357ec98a..c2a7b3d28a56 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -112,6 +112,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
+enum nvme_disable_state {
+	NVME_DISABLE_START = 0,
+	NVME_DISABLE_WAIT = 1,
+	NVME_DISABLE_DONE = 2,
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -159,6 +165,7 @@ struct nvme_dev {
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
+	enum nvme_disable_state disable_state;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2574,12 +2581,14 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
 	return (csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY);
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable_start(struct nvme_dev *dev, bool shutdown)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(&dev->ctrl);
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	bool dead;
 
+	dev->disable_state = NVME_DISABLE_START;
+
 	mutex_lock(&dev->shutdown_lock);
 	dead = nvme_pci_ctrl_is_dead(dev);
 	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_RESETTING) {
@@ -2597,7 +2606,20 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_delete_io_queues(dev);
-		nvme_disable_ctrl(&dev->ctrl, shutdown);
+		nvme_disable_ctrl_send(&dev->ctrl, shutdown);
+		dev->disable_state = NVME_DISABLE_WAIT;
+	}
+}
+
+static void nvme_dev_disable_end(struct nvme_dev *dev, bool shutdown)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (dev->disable_state == NVME_DISABLE_DONE)
+		return;
+
+	if (dev->disable_state == NVME_DISABLE_WAIT) {
+		nvme_disable_ctrl_wait(&dev->ctrl, shutdown);
 		nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
@@ -2623,6 +2645,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
+static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+{
+	nvme_dev_disable_start(dev, shutdown);
+	nvme_dev_disable_end(dev, shutdown);
+}
+
 static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 {
 	if (!nvme_wait_reset(&dev->ctrl))
@@ -3120,6 +3148,25 @@ static void nvme_shutdown(struct pci_dev *pdev)
 	nvme_disable_prepare_reset(dev, true);
 }
 
+static void nvme_shutdown_start(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+        if (!nvme_wait_reset(&dev->ctrl)) {
+		dev->disable_state = NVME_DISABLE_DONE;
+                return;
+	}
+        nvme_dev_disable_start(dev, true);
+}
+
+static void nvme_shutdown_end(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable_end(dev, true);
+}
+
+
 /*
  * The driver's remove may be called on a device in a partially initialized
  * state. This function must not have any dependencies on the device state in
@@ -3511,6 +3558,8 @@ static struct pci_driver nvme_driver = {
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
+	.async_shutdown_start 	= nvme_shutdown_start,
+	.async_shutdown_end 	= nvme_shutdown_end,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
-- 
2.43.0


