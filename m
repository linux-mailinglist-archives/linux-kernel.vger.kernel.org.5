Return-Path: <linux-kernel+bounces-153706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8C68AD1E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB95D1C20AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0FF153814;
	Mon, 22 Apr 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkgG4Htf"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6410A20
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803382; cv=none; b=rZ9ihwvkUK9lKaI/+FNim+4QC8BI0vl2pkOWJgk4+Cs/nQesSDAJ/eveN7iMSlJmIcnMtQrIbz30NBn6SHT1hJekhMVwPBW2UIG0UF6G0bOG5168/adANJVE4yC+ajZpXi+3L9k1lyiTrtOhXIbExGLAEgngGHy2LOqes4I267Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803382; c=relaxed/simple;
	bh=P9aG6NC23QsaUIy270PeCkJiPULoV/ZeUHoxbdAoj/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hYSR1VaKHUw2h5M7FyIbExyCp2oiPzBd7LD5CT6LtMc4KNaE51PMrr91uhvSsPHtQBpViKZ1IEhOtMxt6+VTu+Ys7MYVQMmv7T6TGlIVtgU4FduBG+xK1fqAPTG6gkxdAWRUf9MNbqebfCVctGehFd+1PboOPD8l8/UudWDw5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkgG4Htf; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713803376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J8Qoghwco/VQmgqsF+4q/QYcXZav68r5906wc06JM0A=;
	b=kkgG4HtfgR6UWSdWZpTEms0r0sHOCM2mSxG2sAUBmafgI+d8QY/yGkRTMTTmywWLl57XZF
	b5Rs47VzO+kqhnnLeYuB6P5qyD1GZzhAGGrlgle1KdI6rqJBrVEi81XUFRABFzHTyB06V0
	NumqB0GWISyZ/rDN47M1IHKa7gtM190=
From: Sean Anderson <sean.anderson@linux.dev>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: Add quirk for broken MSIs
Date: Mon, 22 Apr 2024 12:28:23 -0400
Message-Id: <20240422162822.3539156-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
support, all commands time out resulting in the following message:

nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled

These timeouts cause the boot to take an excessively-long time (over 20
minutes) while the initial command queue is flushed.

Address this by adding a quirk for drives with buggy MSIs. The lspci
output for this device (recorded on a system with MSI-X support) is:

02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
	Subsystem: Sandisk Corp Device 5008
	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 3
	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
	Capabilities: [c0] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [1b8] Latency Tolerance Reporting
	Capabilities: [300] Secondary PCI Express
	Capabilities: [900] L1 PM Substates
	Kernel driver in use: nvme
	Kernel modules: nvme

Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 14 +++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7b87763e2f8a..738719085e05 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -162,6 +162,11 @@ enum nvme_quirks {
 	 * Disables simple suspend/resume path.
 	 */
 	NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND	= (1 << 20),
+
+	/*
+	 * MSI (but not MSI-X) interrupts are broken and never fire.
+	 */
+	NVME_QUIRK_BROKEN_MSI			= (1 << 21),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..d1f0fa2e7c96 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2218,6 +2218,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 		.priv		= dev,
 	};
 	unsigned int irq_queues, poll_queues;
+	unsigned int flags = PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one I/O queue
@@ -2241,8 +2242,10 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	irq_queues = 1;
 	if (!(dev->ctrl.quirks & NVME_QUIRK_SINGLE_VECTOR))
 		irq_queues += (nr_io_queues - poll_queues);
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
-			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	if (dev->ctrl.quirks & NVME_QUIRK_BROKEN_MSI)
+		flags &= ~PCI_IRQ_MSI;
+	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues, flags,
+					      &affd);
 }
 
 static unsigned int nvme_max_io_queues(struct nvme_dev *dev)
@@ -2471,6 +2474,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	unsigned int flags = PCI_IRQ_ALL_TYPES;
 
 	if (pci_enable_device_mem(pdev))
 		return result;
@@ -2487,7 +2491,9 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
 	 * adjust this later.
 	 */
-	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (dev->ctrl.quirks & NVME_QUIRK_BROKEN_MSI)
+		flags &= ~PCI_IRQ_MSI;
+	result = pci_alloc_irq_vectors(pdev, 1, 1, flags);
 	if (result < 0)
 		goto disable;
 
@@ -3381,6 +3387,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
+		.driver_data = NVME_QUIRK_BROKEN_MSI },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-- 
2.35.1.1320.gc452695387.dirty


