Return-Path: <linux-kernel+bounces-14527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EEF821E50
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E411C22397
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9D14F86;
	Tue,  2 Jan 2024 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXbvuShq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAD14F76
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2808AC433C7;
	Tue,  2 Jan 2024 15:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704208022;
	bh=ngDURZBrEZ6nJ6PufU0TBhtE8mc4FbnsCbyVBq3BT6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXbvuShqZhDJsRcKp/SJ1c21pa875vVyuzNFjzDuV+HncxvShQ0x7h2TP3EBUbL8J
	 XP09rSCbAXzE7JR2VTHdavFjL2zboylGd4qRnIUPSBjg38l/uokXnuIpRwhHG0A/Dk
	 CWakqv+GgFXI+rpcZOsjyjKI5+NUgf/vr6kiVp7nREvLmWT691VTXiKHpdDM02VuiA
	 AVGEYdYa2vSjrRQRKPpGarhMQ/MaQV5emRbyvS2eSKMr8zae6DtiGMVCdVbCwX2qIj
	 WZ9BmmNLKYDQy2aadlDYW+LVoWrV5hQeqrYGoLBIXg///wHQOBuh8o+tTnEltb3AIP
	 kKptNmqOAVXUw==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 2/6] accel/habanalabs/gaudi2: add interrupt affinity for user interrupts
Date: Tue,  2 Jan 2024 17:06:50 +0200
Message-Id: <20240102150654.522555-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102150654.522555-1-ogabbay@kernel.org>
References: <20240102150654.522555-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dani Liberman <dliberman@habana.ai>

User interrupts are MSIx interrupts coming from Gaudi2, that have
specific range of IDs and are assigned to the sole use of the user
process that opened the Gaudi2 device (reminder: there can be only
a single user process running on Gaudi2 at any given time).

The interrupts are allocated and managed by the driver and therefore,
the user expects the driver to initialize them properly, which also
includes setting the affinity to the related CPU cores of the
device's NUMA node to get maximum performance.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c     | 30 ++++++++++++++++++++
 drivers/accel/habanalabs/common/habanalabs.h |  5 ++++
 drivers/accel/habanalabs/gaudi2/gaudi2.c     |  5 ++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index e81ccafddfb3..514459396818 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2807,3 +2807,33 @@ void hl_enable_err_info_capture(struct hl_error_info *captured_err_info)
 	atomic_set(&captured_err_info->cs_timeout.write_enable, 1);
 	captured_err_info->undef_opcode.write_enable = true;
 }
+
+void hl_init_cpu_for_irq(struct hl_device *hdev)
+{
+	struct cpumask *available_mask = &hdev->irq_affinity_mask;
+	int numa_node = hdev->pdev->dev.numa_node, i;
+	static struct cpumask cpu_mask;
+
+	if (numa_node < 0)
+		return;
+
+	if (!cpumask_and(&cpu_mask, cpumask_of_node(numa_node), cpu_online_mask)) {
+		dev_err(hdev->dev, "No available affinities in current numa node\n");
+		return;
+	}
+
+	/* Remove HT siblings */
+	for_each_cpu(i, &cpu_mask)
+		cpumask_set_cpu(cpumask_first(topology_sibling_cpumask(i)), available_mask);
+}
+
+void hl_set_irq_affinity(struct hl_device *hdev, int irq)
+{
+	if (cpumask_empty(&hdev->irq_affinity_mask)) {
+		dev_dbg(hdev->dev, "affinity mask is empty\n");
+		return;
+	}
+
+	if (irq_set_affinity_hint(irq, &hdev->irq_affinity_mask))
+		dev_err(hdev->dev, "Failed setting irq %d affinity\n", irq);
+}
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 2a900c9941fe..b1a7b229e161 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -3257,6 +3257,7 @@ struct hl_reset_info {
  * @clk_throttling: holds information about current/previous clock throttling events
  * @captured_err_info: holds information about errors.
  * @reset_info: holds current device reset information.
+ * @irq_affinity_mask: mask of available CPU cores for user and decoder interrupt handling.
  * @stream_master_qid_arr: pointer to array with QIDs of master streams.
  * @fw_inner_major_ver: the major of current loaded preboot inner version.
  * @fw_inner_minor_ver: the minor of current loaded preboot inner version.
@@ -3446,6 +3447,8 @@ struct hl_device {
 
 	struct hl_reset_info		reset_info;
 
+	cpumask_t			irq_affinity_mask;
+
 	u32				*stream_master_qid_arr;
 	u32				fw_inner_major_ver;
 	u32				fw_inner_minor_ver;
@@ -4032,6 +4035,8 @@ void hl_handle_critical_hw_err(struct hl_device *hdev, u16 event_id, u64 *event_
 void hl_handle_fw_err(struct hl_device *hdev, struct hl_info_fw_err_info *info);
 void hl_capture_engine_err(struct hl_device *hdev, u16 engine_id, u16 error_count);
 void hl_enable_err_info_capture(struct hl_error_info *captured_err_info);
+void hl_init_cpu_for_irq(struct hl_device *hdev);
+void hl_set_irq_affinity(struct hl_device *hdev, int irq);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index e0e5615ef9b0..fd01525b1ea2 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -4254,6 +4254,8 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 	if (gaudi2->hw_cap_initialized & HW_CAP_MSIX)
 		return 0;
 
+	hl_init_cpu_for_irq(hdev);
+
 	rc = pci_alloc_irq_vectors(hdev->pdev, GAUDI2_MSIX_ENTRIES, GAUDI2_MSIX_ENTRIES,
 					PCI_IRQ_MSIX);
 	if (rc < 0) {
@@ -4307,6 +4309,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 			i++, j++, user_irq_init_cnt++) {
 
 		irq = pci_irq_vector(hdev->pdev, i);
+		hl_set_irq_affinity(hdev, irq);
 		rc = request_irq(irq, hl_irq_user_interrupt_handler, 0, gaudi2_irq_name(i),
 				&hdev->user_interrupt[j]);
 		if (rc) {
@@ -4333,6 +4336,7 @@ static int gaudi2_enable_msix(struct hl_device *hdev)
 			i < GAUDI2_IRQ_NUM_USER_FIRST + user_irq_init_cnt ; i++, j++) {
 
 		irq = pci_irq_vector(hdev->pdev, i);
+		irq_set_affinity_hint(irq, NULL);
 		free_irq(irq, &hdev->user_interrupt[j]);
 	}
 	irq = pci_irq_vector(hdev->pdev, GAUDI2_IRQ_NUM_UNEXPECTED_ERROR);
@@ -4413,6 +4417,7 @@ static void gaudi2_disable_msix(struct hl_device *hdev)
 			k < hdev->asic_prop.user_interrupt_count ; i++, j++, k++) {
 
 		irq = pci_irq_vector(hdev->pdev, i);
+		irq_set_affinity_hint(irq, NULL);
 		free_irq(irq, &hdev->user_interrupt[j]);
 	}
 
-- 
2.34.1


