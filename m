Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BDB77446A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjHHSSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjHHSRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:17:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3F3D76AE;
        Tue,  8 Aug 2023 10:25:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3784jaln092038;
        Mon, 7 Aug 2023 23:45:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691469936;
        bh=jxfKY3dCyPj+NlXJ5DS272bbXfAIukox3ft5O+MEQmQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xqmf+GDexeQUCyVZiXwiL4Yt5hV3kiTVeUlvrYNyqT7iecj0lKCPwCwOWLsSAI6ey
         VjIcG927HRkPqA6bJAeEZfUWJYRgaPsUdKg7KJNBgMJFFumsW0tPCXx86fxBGb1aY5
         PgqPFd9bcnYjthZkBpWMMaYi4aHEkaUS6Vbsi8pE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3784jagw073775
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 23:45:36 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 23:45:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 23:45:36 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3784jagh074542;
        Mon, 7 Aug 2023 23:45:36 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 4/5] remoteproc: k3: Split out functions common with M4 driver
Date:   Mon, 7 Aug 2023 23:45:28 -0500
Message-ID: <20230808044529.25925-5-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808044529.25925-1-hnagalla@ti.com>
References: <20230808044529.25925-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

In the next commit we will be adding the M4F driver which shares a lot of
commonality with the DSP driver. Split this shared functionality out so
that it can be used by both drivers.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v2:
 - New patch (reordered refactored from v2)

Changes since v3:
 - Removed "ipc_only" element from k3_rproc structure
 - Refactored to bring 3 more common functions
 
Changes since v4:
 - None

 drivers/remoteproc/Makefile               |   2 +-
 drivers/remoteproc/ti_k3_common.c         | 513 +++++++++++++++++++
 drivers/remoteproc/ti_k3_common.h         | 103 ++++
 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 598 ++--------------------
 4 files changed, 646 insertions(+), 570 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_common.c
 create mode 100644 drivers/remoteproc/ti_k3_common.h

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 91314a9b43ce..55c552e27a45 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -36,6 +36,6 @@ obj-$(CONFIG_RCAR_REMOTEPROC)		+= rcar_rproc.o
 obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
 obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
-obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o
+obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
 obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
 obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
diff --git a/drivers/remoteproc/ti_k3_common.c b/drivers/remoteproc/ti_k3_common.c
new file mode 100644
index 000000000000..3dbf71296950
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_common.c
@@ -0,0 +1,513 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TI K3 Remote Processor(s) driver common code
+ *
+ * Refactored from ti_k3_dsp_remoteproc.c.
+ *
+ * ti_k3_dsp_remoteproc.c:
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#include <linux/io.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/omap-mailbox.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+#include "omap_remoteproc.h"
+#include "remoteproc_internal.h"
+#include "ti_sci_proc.h"
+#include "ti_k3_common.h"
+
+/*
+ * Kick the remote processor to notify about pending unprocessed messages.
+ * The vqid usage is not used and is inconsequential, as the kick is performed
+ * through a simulated GPIO (a bit in an IPC interrupt-triggering register),
+ * the remote processor is expected to process both its Tx and Rx virtqueues.
+ */
+void k3_rproc_kick(struct rproc *rproc, int vqid)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	mbox_msg_t msg = (mbox_msg_t)vqid;
+	int ret;
+
+	/* send the index of the triggered virtqueue in the mailbox payload */
+	ret = mbox_send_message(kproc->mbox, (void *)msg);
+	if (ret < 0)
+		dev_err(dev, "failed to send mailbox message, status = %d\n",
+			ret);
+}
+EXPORT_SYMBOL_GPL(k3_rproc_kick);
+
+/* Put the remote processor into reset */
+int k3_rproc_reset(struct k3_rproc *kproc)
+{
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = reset_control_assert(kproc->reset);
+	if (ret) {
+		dev_err(dev, "local-reset assert failed, ret = %d\n", ret);
+		return ret;
+	}
+
+	if (kproc->data->uses_lreset)
+		return ret;
+
+	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
+						    kproc->ti_sci_id);
+	if (ret) {
+		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
+		if (reset_control_deassert(kproc->reset))
+			dev_warn(dev, "local-reset deassert back failed\n");
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_reset);
+
+/* Release the remote processor from reset */
+int k3_rproc_release(struct k3_rproc *kproc)
+{
+	struct device *dev = kproc->dev;
+	int ret;
+
+	if (kproc->data->uses_lreset)
+		goto lreset;
+
+	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
+						    kproc->ti_sci_id);
+	if (ret) {
+		dev_err(dev, "module-reset deassert failed, ret = %d\n", ret);
+		return ret;
+	}
+
+lreset:
+	ret = reset_control_deassert(kproc->reset);
+	if (ret) {
+		dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
+		if (kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
+							  kproc->ti_sci_id))
+			dev_warn(dev, "module-reset assert back failed\n");
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_release);
+
+/*
+ * This function implements the .get_loaded_rsc_table() callback and is used
+ * to provide the resource table for a booted remote processor in IPC-only
+ * mode. The remote processor firmwares follow a design-by-contract approach
+ * and are expected to have the resource table at the base of the DDR region
+ * reserved for firmware usage. This provides flexibility for the remote
+ * processor to be booted by different bootloaders that may or may not have the
+ * ability to publish the resource table address and size through a DT
+ * property.
+ */
+struct resource_table *k3_get_loaded_rsc_table(struct rproc *rproc,
+					       size_t *rsc_table_sz)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+
+	if (!kproc->rmem[0].cpu_addr) {
+		dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * NOTE: The resource table size is currently hard-coded to a maximum
+	 * of 256 bytes. The most common resource table usage for K3 firmwares
+	 * is to only have the vdev resource entry and an optional trace entry.
+	 * The exact size could be computed based on resource table address, but
+	 * the hard-coded value suffices to support the IPC-only mode.
+	 */
+	*rsc_table_sz = 256;
+	return (struct resource_table *)kproc->rmem[0].cpu_addr;
+}
+EXPORT_SYMBOL_GPL(k3_get_loaded_rsc_table);
+
+/*
+ * Custom function to translate a remote processor device address (internal
+ * RAMs only) to a kernel virtual address.  The remote processors can access
+ * their RAMs at either an internal address visible only from a remote
+ * processor, or at the SoC-level bus address. Both these addresses need to be
+ * looked through for translation. The translated addresses can be used either
+ * by the remoteproc core for loading (when using kernel remoteproc loader), or
+ * by any rpmsg bus drivers.
+ */
+void *k3_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	void __iomem *va = NULL;
+	phys_addr_t bus_addr;
+	u32 dev_addr, offset;
+	size_t size;
+	int i;
+
+	if (len == 0)
+		return NULL;
+
+	for (i = 0; i < kproc->num_mems; i++) {
+		bus_addr = kproc->mem[i].bus_addr;
+		dev_addr = kproc->mem[i].dev_addr;
+		size = kproc->mem[i].size;
+
+		if (da < KEYSTONE_RPROC_LOCAL_ADDRESS_MASK) {
+			/* handle remote-view addresses */
+			if (da >= dev_addr &&
+			    ((da + len) <= (dev_addr + size))) {
+				offset = da - dev_addr;
+				va = kproc->mem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
+		} else {
+			/* handle SoC-view addresses */
+			if (da >= bus_addr &&
+			    (da + len) <= (bus_addr + size)) {
+				offset = da - bus_addr;
+				va = kproc->mem[i].cpu_addr + offset;
+				return (__force void *)va;
+			}
+		}
+	}
+
+	/* handle static DDR reserved memory regions */
+	for (i = 0; i < kproc->num_rmems; i++) {
+		dev_addr = kproc->rmem[i].dev_addr;
+		size = kproc->rmem[i].size;
+
+		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
+			offset = da - dev_addr;
+			va = kproc->rmem[i].cpu_addr + offset;
+			return (__force void *)va;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_da_to_va);
+
+int k3_rproc_of_get_memories(struct platform_device *pdev,
+			     struct k3_rproc *kproc)
+{
+	const struct k3_rproc_dev_data *data = kproc->data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int num_mems = 0;
+	int i;
+
+	num_mems = kproc->data->num_mems;
+	kproc->mem = devm_kcalloc(kproc->dev, num_mems,
+				  sizeof(*kproc->mem), GFP_KERNEL);
+	if (!kproc->mem)
+		return -ENOMEM;
+
+	for (i = 0; i < num_mems; i++) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						   data->mems[i].name);
+		if (!res) {
+			dev_err(dev, "found no memory resource for %s\n",
+				data->mems[i].name);
+			return -EINVAL;
+		}
+		if (!devm_request_mem_region(dev, res->start,
+					     resource_size(res),
+					     dev_name(dev))) {
+			dev_err(dev, "could not request %s region for resource\n",
+				data->mems[i].name);
+			return -EBUSY;
+		}
+
+		kproc->mem[i].cpu_addr = devm_ioremap_wc(dev, res->start,
+							 resource_size(res));
+		if (!kproc->mem[i].cpu_addr) {
+			dev_err(dev, "failed to map %s memory\n",
+				data->mems[i].name);
+			return -ENOMEM;
+		}
+		kproc->mem[i].bus_addr = res->start;
+		kproc->mem[i].dev_addr = data->mems[i].dev_addr;
+		kproc->mem[i].size = resource_size(res);
+
+		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %pK da 0x%x\n",
+			data->mems[i].name, &kproc->mem[i].bus_addr,
+			kproc->mem[i].size, kproc->mem[i].cpu_addr,
+			kproc->mem[i].dev_addr);
+	}
+	kproc->num_mems = num_mems;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_of_get_memories);
+
+int k3_reserved_mem_init(struct k3_rproc *kproc)
+{
+	struct device *dev = kproc->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	int num_rmems;
+	int ret, i;
+
+	num_rmems = of_property_count_elems_of_size(np, "memory-region",
+						    sizeof(phandle));
+	if (num_rmems <= 0) {
+		dev_err(dev, "device does not reserved memory regions, ret = %d\n",
+			num_rmems);
+		return -EINVAL;
+	}
+	if (num_rmems < 2) {
+		dev_err(dev, "device needs at least two memory regions to be defined, num = %d\n",
+			num_rmems);
+		return -EINVAL;
+	}
+
+	/* use reserved memory region 0 for vring DMA allocations */
+	ret = of_reserved_mem_device_init_by_idx(dev, np, 0);
+	if (ret) {
+		dev_err(dev, "device cannot initialize DMA pool, ret = %d\n",
+			ret);
+		return ret;
+	}
+
+	num_rmems--;
+	kproc->rmem = kcalloc(num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
+	if (!kproc->rmem) {
+		ret = -ENOMEM;
+		goto release_rmem;
+	}
+
+	/* use remaining reserved memory regions for static carveouts */
+	for (i = 0; i < num_rmems; i++) {
+		rmem_np = of_parse_phandle(np, "memory-region", i + 1);
+		if (!rmem_np) {
+			ret = -EINVAL;
+			goto unmap_rmem;
+		}
+
+		rmem = of_reserved_mem_lookup(rmem_np);
+		if (!rmem) {
+			of_node_put(rmem_np);
+			ret = -EINVAL;
+			goto unmap_rmem;
+		}
+		of_node_put(rmem_np);
+
+		kproc->rmem[i].bus_addr = rmem->base;
+		/* 64-bit address regions currently not supported */
+		kproc->rmem[i].dev_addr = (u32)rmem->base;
+		kproc->rmem[i].size = rmem->size;
+		kproc->rmem[i].cpu_addr = ioremap_wc(rmem->base, rmem->size);
+		if (!kproc->rmem[i].cpu_addr) {
+			dev_err(dev, "failed to map reserved memory#%d at %pa of size %pa\n",
+				i + 1, &rmem->base, &rmem->size);
+			ret = -ENOMEM;
+			goto unmap_rmem;
+		}
+
+		dev_dbg(dev, "reserved memory%d: bus addr %pa size 0x%zx va %pK da 0x%x\n",
+			i + 1, &kproc->rmem[i].bus_addr,
+			kproc->rmem[i].size, kproc->rmem[i].cpu_addr,
+			kproc->rmem[i].dev_addr);
+	}
+	kproc->num_rmems = num_rmems;
+
+	return 0;
+
+unmap_rmem:
+	for (i--; i >= 0; i--)
+		iounmap(kproc->rmem[i].cpu_addr);
+	kfree(kproc->rmem);
+release_rmem:
+	of_reserved_mem_device_release(kproc->dev);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_reserved_mem_init);
+
+void k3_reserved_mem_exit(struct k3_rproc *kproc)
+{
+	int i;
+
+	for (i = 0; i < kproc->num_rmems; i++)
+		iounmap(kproc->rmem[i].cpu_addr);
+	kfree(kproc->rmem);
+
+	of_reserved_mem_device_release(kproc->dev);
+}
+EXPORT_SYMBOL_GPL(k3_reserved_mem_exit);
+
+struct ti_sci_proc *k3_rproc_of_get_tsp(struct device *dev,
+					const struct ti_sci_handle *sci)
+{
+	struct ti_sci_proc *tsp;
+	u32 temp[2];
+	int ret;
+
+	ret = of_property_read_u32_array(dev->of_node, "ti,sci-proc-ids",
+					 temp, 2);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	tsp = kzalloc(sizeof(*tsp), GFP_KERNEL);
+	if (!tsp)
+		return ERR_PTR(-ENOMEM);
+
+	tsp->dev = dev;
+	tsp->sci = sci;
+	tsp->ops = &sci->ops.proc_ops;
+	tsp->proc_id = temp[0];
+	tsp->host_id = temp[1];
+
+	return tsp;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_of_get_tsp);
+
+/**
+ * k3_rproc_mbox_callback() - inbound mailbox message handler
+ * @client: mailbox client pointer used for requesting the mailbox channel
+ * @data: mailbox payload
+ *
+ * This handler is invoked by the K3 mailbox driver whenever a mailbox
+ * message is received. Usually, the mailbox payload simply contains
+ * the index of the virtqueue that is kicked by the remote processor,
+ * and we let remoteproc core handle it.
+ *
+ * In addition to virtqueue indices, we also have some out-of-band values
+ * that indicate different events. Those values are deliberately very
+ * large so they don't coincide with virtqueue indices.
+ */
+static void k3_rproc_mbox_callback(struct mbox_client *client, void *data)
+{
+	struct k3_rproc *kproc = container_of(client, struct k3_rproc,
+						  client);
+	struct device *dev = kproc->rproc->dev.parent;
+	const char *name = kproc->rproc->name;
+	u32 msg = omap_mbox_message(data);
+
+	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
+
+	switch (msg) {
+	case RP_MBOX_CRASH:
+		/*
+		 * remoteproc detected an exception, but error recovery is not
+		 * supported. So, just log this for now
+		 */
+		dev_err(dev, "K3 rproc %s crashed\n", name);
+		break;
+	case RP_MBOX_ECHO_REPLY:
+		dev_info(dev, "received echo reply from %s\n", name);
+		break;
+	default:
+		/* silently handle all other valid messages */
+		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
+			return;
+		if (msg > kproc->rproc->max_notifyid) {
+			dev_dbg(dev, "dropping unknown message 0x%x", msg);
+			return;
+		}
+		/* msg contains the index of the triggered vring */
+		if (rproc_vq_interrupt(kproc->rproc, msg) == IRQ_NONE)
+			dev_dbg(dev, "no message was found in vqid %d\n", msg);
+	}
+}
+
+int k3_rproc_request_mbox(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct mbox_client *client = &kproc->client;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	client->dev = dev;
+	client->tx_done = NULL;
+	client->rx_callback = k3_rproc_mbox_callback;
+	client->tx_block = false;
+	client->knows_txdone = false;
+
+	kproc->mbox = mbox_request_channel(client, 0);
+	if (IS_ERR(kproc->mbox)) {
+		ret = -EBUSY;
+		dev_err(dev, "mbox_request_channel failed: %ld\n",
+			PTR_ERR(kproc->mbox));
+		return ret;
+	}
+
+	/*
+	 * Ping the remote processor, this is only for sanity-sake for now;
+	 * there is no functional effect whatsoever.
+	 *
+	 * Note that the reply will _not_ arrive immediately: this message
+	 * will wait in the mailbox fifo until the remote processor is booted.
+	 */
+	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
+	if (ret < 0) {
+		dev_err(dev, "mbox_send_message failed: %d\n", ret);
+		mbox_free_channel(kproc->mbox);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_request_mbox);
+
+/*
+ * The DSP and MCU cores have a local reset that affects only the CPU, and a
+ * generic module reset that powers on the device and allows the internal
+ * memories to be accessed while the local reset is asserted. This function is
+ * used to release the global reset on remote cores to allow loading into the
+ * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
+ * firmware loading, and is followed by the .start() ops after loading to
+ * actually let the remote cores to run. This callback is invoked only in
+ * remoteproc mode.
+ */
+int k3_rproc_prepare(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
+						    kproc->ti_sci_id);
+	if (ret)
+		dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
+			ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_prepare);
+
+/*
+ * This function implements the .unprepare() ops and performs the complimentary
+ * operations to that of the .prepare() ops. The function is used to assert the
+ * global reset on applicable DSP, MCU cores. This completes the second portion of
+ * powering down the remote core. The cores themselves are only halted in the
+ * .stop() callback through the local reset, and the .unprepare() ops is invoked
+ * by the remoteproc core after the remoteproc is stopped to balance the global
+ * reset. This callback is invoked only in remoteproc mode.
+ */
+int k3_rproc_unprepare(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
+						    kproc->ti_sci_id);
+	if (ret)
+		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(k3_rproc_unprepare);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("TI K3 common Remoteproc support");
diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
new file mode 100644
index 000000000000..917a9c82b4cf
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_common.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * TI K3 Remote Processor(s) driver common code
+ *
+ * Refactored from ti_k3_dsp_remoteproc.c.
+ *
+ * ti_k3_dsp_remoteproc.c:
+ * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Suman Anna <s-anna@ti.com>
+ */
+
+#ifndef REMOTEPROC_TI_K3_COMMON_H
+#define REMOTEPROC_TI_K3_COMMON_H
+
+#define KEYSTONE_RPROC_LOCAL_ADDRESS_MASK	(SZ_16M - 1)
+
+/**
+ * struct k3_rproc_mem - internal memory structure
+ * @cpu_addr: MPU virtual address of the memory region
+ * @bus_addr: Bus address used to access the memory region
+ * @dev_addr: Device address of the memory region from DSP view
+ * @size: Size of the memory region
+ */
+struct k3_rproc_mem {
+	void __iomem *cpu_addr;
+	phys_addr_t bus_addr;
+	u32 dev_addr;
+	size_t size;
+};
+
+/**
+ * struct k3_rproc_mem_data - memory definitions for a DSP
+ * @name: name for this memory entry
+ * @dev_addr: device address for the memory entry
+ */
+struct k3_rproc_mem_data {
+	const char *name;
+	const u32 dev_addr;
+};
+
+/**
+ * struct k3_rproc_dev_data - device data structure for a DSP
+ * @mems: pointer to memory definitions for a DSP
+ * @num_mems: number of memory regions in @mems
+ * @boot_align_addr: boot vector address alignment granularity
+ * @uses_lreset: flag to denote the need for local reset management
+ */
+struct k3_rproc_dev_data {
+	const struct k3_rproc_mem_data *mems;
+	u32 num_mems;
+	u32 boot_align_addr;
+	bool uses_lreset;
+};
+
+/**
+ * struct k3_rproc - k3 remote processor driver structure
+ * @dev: cached device pointer
+ * @rproc: remoteproc device handle
+ * @mem: internal memory regions data
+ * @num_mems: number of internal memory regions
+ * @rmem: reserved memory regions data
+ * @num_rmems: number of reserved memory regions
+ * @reset: reset control handle
+ * @data: pointer to device data
+ * @tsp: TI-SCI processor control handle
+ * @ti_sci: TI-SCI handle
+ * @ti_sci_id: TI-SCI device identifier
+ * @mbox: mailbox channel handle
+ * @client: mailbox client to request the mailbox channel
+ */
+struct k3_rproc {
+	struct device *dev;
+	struct rproc *rproc;
+	struct k3_rproc_mem *mem;
+	int num_mems;
+	struct k3_rproc_mem *rmem;
+	int num_rmems;
+	struct reset_control *reset;
+	const struct k3_rproc_dev_data *data;
+	struct ti_sci_proc *tsp;
+	const struct ti_sci_handle *ti_sci;
+	u32 ti_sci_id;
+	struct mbox_chan *mbox;
+	struct mbox_client client;
+};
+
+void k3_rproc_kick(struct rproc *rproc, int vqid);
+int k3_rproc_reset(struct k3_rproc *kproc);
+int k3_rproc_release(struct k3_rproc *kproc);
+struct resource_table *k3_get_loaded_rsc_table(struct rproc *rproc,
+					       size_t *rsc_table_sz);
+void *k3_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len,
+			bool *is_iomem);
+int k3_rproc_of_get_memories(struct platform_device *pdev,
+			     struct k3_rproc *kproc);
+int k3_reserved_mem_init(struct k3_rproc *kproc);
+void k3_reserved_mem_exit(struct k3_rproc *kproc);
+struct ti_sci_proc *k3_rproc_of_get_tsp(struct device *dev,
+					const struct ti_sci_handle *sci);
+int k3_rproc_request_mbox(struct rproc *rproc);
+int k3_rproc_prepare(struct rproc *rproc);
+int k3_rproc_unprepare(struct rproc *rproc);
+#endif /* REMOTEPROC_TI_K3_COMMON_H */
diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index ef8415a7cd54..48f9b37a77eb 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -20,286 +20,8 @@
 #include "omap_remoteproc.h"
 #include "remoteproc_internal.h"
 #include "ti_sci_proc.h"
+#include "ti_k3_common.h"
 
-#define KEYSTONE_RPROC_LOCAL_ADDRESS_MASK	(SZ_16M - 1)
-
-/**
- * struct k3_dsp_mem - internal memory structure
- * @cpu_addr: MPU virtual address of the memory region
- * @bus_addr: Bus address used to access the memory region
- * @dev_addr: Device address of the memory region from DSP view
- * @size: Size of the memory region
- */
-struct k3_dsp_mem {
-	void __iomem *cpu_addr;
-	phys_addr_t bus_addr;
-	u32 dev_addr;
-	size_t size;
-};
-
-/**
- * struct k3_dsp_mem_data - memory definitions for a DSP
- * @name: name for this memory entry
- * @dev_addr: device address for the memory entry
- */
-struct k3_dsp_mem_data {
-	const char *name;
-	const u32 dev_addr;
-};
-
-/**
- * struct k3_dsp_dev_data - device data structure for a DSP
- * @mems: pointer to memory definitions for a DSP
- * @num_mems: number of memory regions in @mems
- * @boot_align_addr: boot vector address alignment granularity
- * @uses_lreset: flag to denote the need for local reset management
- */
-struct k3_dsp_dev_data {
-	const struct k3_dsp_mem_data *mems;
-	u32 num_mems;
-	u32 boot_align_addr;
-	bool uses_lreset;
-};
-
-/**
- * struct k3_dsp_rproc - k3 DSP remote processor driver structure
- * @dev: cached device pointer
- * @rproc: remoteproc device handle
- * @mem: internal memory regions data
- * @num_mems: number of internal memory regions
- * @rmem: reserved memory regions data
- * @num_rmems: number of reserved memory regions
- * @reset: reset control handle
- * @data: pointer to DSP-specific device data
- * @tsp: TI-SCI processor control handle
- * @ti_sci: TI-SCI handle
- * @ti_sci_id: TI-SCI device identifier
- * @mbox: mailbox channel handle
- * @client: mailbox client to request the mailbox channel
- */
-struct k3_dsp_rproc {
-	struct device *dev;
-	struct rproc *rproc;
-	struct k3_dsp_mem *mem;
-	int num_mems;
-	struct k3_dsp_mem *rmem;
-	int num_rmems;
-	struct reset_control *reset;
-	const struct k3_dsp_dev_data *data;
-	struct ti_sci_proc *tsp;
-	const struct ti_sci_handle *ti_sci;
-	u32 ti_sci_id;
-	struct mbox_chan *mbox;
-	struct mbox_client client;
-};
-
-/**
- * k3_dsp_rproc_mbox_callback() - inbound mailbox message handler
- * @client: mailbox client pointer used for requesting the mailbox channel
- * @data: mailbox payload
- *
- * This handler is invoked by the OMAP mailbox driver whenever a mailbox
- * message is received. Usually, the mailbox payload simply contains
- * the index of the virtqueue that is kicked by the remote processor,
- * and we let remoteproc core handle it.
- *
- * In addition to virtqueue indices, we also have some out-of-band values
- * that indicate different events. Those values are deliberately very
- * large so they don't coincide with virtqueue indices.
- */
-static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
-{
-	struct k3_dsp_rproc *kproc = container_of(client, struct k3_dsp_rproc,
-						  client);
-	struct device *dev = kproc->rproc->dev.parent;
-	const char *name = kproc->rproc->name;
-	u32 msg = omap_mbox_message(data);
-
-	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
-
-	switch (msg) {
-	case RP_MBOX_CRASH:
-		/*
-		 * remoteproc detected an exception, but error recovery is not
-		 * supported. So, just log this for now
-		 */
-		dev_err(dev, "K3 DSP rproc %s crashed\n", name);
-		break;
-	case RP_MBOX_ECHO_REPLY:
-		dev_info(dev, "received echo reply from %s\n", name);
-		break;
-	default:
-		/* silently handle all other valid messages */
-		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
-			return;
-		if (msg > kproc->rproc->max_notifyid) {
-			dev_dbg(dev, "dropping unknown message 0x%x", msg);
-			return;
-		}
-		/* msg contains the index of the triggered vring */
-		if (rproc_vq_interrupt(kproc->rproc, msg) == IRQ_NONE)
-			dev_dbg(dev, "no message was found in vqid %d\n", msg);
-	}
-}
-
-/*
- * Kick the remote processor to notify about pending unprocessed messages.
- * The vqid usage is not used and is inconsequential, as the kick is performed
- * through a simulated GPIO (a bit in an IPC interrupt-triggering register),
- * the remote processor is expected to process both its Tx and Rx virtqueues.
- */
-static void k3_dsp_rproc_kick(struct rproc *rproc, int vqid)
-{
-	struct k3_dsp_rproc *kproc = rproc->priv;
-	struct device *dev = rproc->dev.parent;
-	mbox_msg_t msg = (mbox_msg_t)vqid;
-	int ret;
-
-	/* send the index of the triggered virtqueue in the mailbox payload */
-	ret = mbox_send_message(kproc->mbox, (void *)msg);
-	if (ret < 0)
-		dev_err(dev, "failed to send mailbox message, status = %d\n",
-			ret);
-}
-
-/* Put the DSP processor into reset */
-static int k3_dsp_rproc_reset(struct k3_dsp_rproc *kproc)
-{
-	struct device *dev = kproc->dev;
-	int ret;
-
-	ret = reset_control_assert(kproc->reset);
-	if (ret) {
-		dev_err(dev, "local-reset assert failed, ret = %d\n", ret);
-		return ret;
-	}
-
-	if (kproc->data->uses_lreset)
-		return ret;
-
-	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
-						    kproc->ti_sci_id);
-	if (ret) {
-		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
-		if (reset_control_deassert(kproc->reset))
-			dev_warn(dev, "local-reset deassert back failed\n");
-	}
-
-	return ret;
-}
-
-/* Release the DSP processor from reset */
-static int k3_dsp_rproc_release(struct k3_dsp_rproc *kproc)
-{
-	struct device *dev = kproc->dev;
-	int ret;
-
-	if (kproc->data->uses_lreset)
-		goto lreset;
-
-	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
-						    kproc->ti_sci_id);
-	if (ret) {
-		dev_err(dev, "module-reset deassert failed, ret = %d\n", ret);
-		return ret;
-	}
-
-lreset:
-	ret = reset_control_deassert(kproc->reset);
-	if (ret) {
-		dev_err(dev, "local-reset deassert failed, ret = %d\n", ret);
-		if (kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
-							  kproc->ti_sci_id))
-			dev_warn(dev, "module-reset assert back failed\n");
-	}
-
-	return ret;
-}
-
-static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
-{
-	struct k3_dsp_rproc *kproc = rproc->priv;
-	struct mbox_client *client = &kproc->client;
-	struct device *dev = kproc->dev;
-	int ret;
-
-	client->dev = dev;
-	client->tx_done = NULL;
-	client->rx_callback = k3_dsp_rproc_mbox_callback;
-	client->tx_block = false;
-	client->knows_txdone = false;
-
-	kproc->mbox = mbox_request_channel(client, 0);
-	if (IS_ERR(kproc->mbox)) {
-		ret = -EBUSY;
-		dev_err(dev, "mbox_request_channel failed: %ld\n",
-			PTR_ERR(kproc->mbox));
-		return ret;
-	}
-
-	/*
-	 * Ping the remote processor, this is only for sanity-sake for now;
-	 * there is no functional effect whatsoever.
-	 *
-	 * Note that the reply will _not_ arrive immediately: this message
-	 * will wait in the mailbox fifo until the remote processor is booted.
-	 */
-	ret = mbox_send_message(kproc->mbox, (void *)RP_MBOX_ECHO_REQUEST);
-	if (ret < 0) {
-		dev_err(dev, "mbox_send_message failed: %d\n", ret);
-		mbox_free_channel(kproc->mbox);
-		return ret;
-	}
-
-	return 0;
-}
-/*
- * The C66x DSP cores have a local reset that affects only the CPU, and a
- * generic module reset that powers on the device and allows the DSP internal
- * memories to be accessed while the local reset is asserted. This function is
- * used to release the global reset on C66x DSPs to allow loading into the DSP
- * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
- * firmware loading, and is followed by the .start() ops after loading to
- * actually let the C66x DSP cores run. This callback is invoked only in
- * remoteproc mode.
- */
-static int k3_dsp_rproc_prepare(struct rproc *rproc)
-{
-	struct k3_dsp_rproc *kproc = rproc->priv;
-	struct device *dev = kproc->dev;
-	int ret;
-
-	ret = kproc->ti_sci->ops.dev_ops.get_device(kproc->ti_sci,
-						    kproc->ti_sci_id);
-	if (ret)
-		dev_err(dev, "module-reset deassert failed, cannot enable internal RAM loading, ret = %d\n",
-			ret);
-
-	return ret;
-}
-
-/*
- * This function implements the .unprepare() ops and performs the complimentary
- * operations to that of the .prepare() ops. The function is used to assert the
- * global reset on applicable C66x cores. This completes the second portion of
- * powering down the C66x DSP cores. The cores themselves are only halted in the
- * .stop() callback through the local reset, and the .unprepare() ops is invoked
- * by the remoteproc core after the remoteproc is stopped to balance the global
- * reset. This callback is invoked only in remoteproc mode.
- */
-static int k3_dsp_rproc_unprepare(struct rproc *rproc)
-{
-	struct k3_dsp_rproc *kproc = rproc->priv;
-	struct device *dev = kproc->dev;
-	int ret;
-
-	ret = kproc->ti_sci->ops.dev_ops.put_device(kproc->ti_sci,
-						    kproc->ti_sci_id);
-	if (ret)
-		dev_err(dev, "module-reset assert failed, ret = %d\n", ret);
-
-	return ret;
-}
 
 /*
  * Power up the DSP remote processor.
@@ -310,12 +32,12 @@ static int k3_dsp_rproc_unprepare(struct rproc *rproc)
  */
 static int k3_dsp_rproc_start(struct rproc *rproc)
 {
-	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct k3_rproc *kproc = rproc->priv;
 	struct device *dev = kproc->dev;
 	u32 boot_addr;
 	int ret;
 
-	ret = k3_dsp_rproc_request_mbox(rproc);
+	ret = k3_rproc_request_mbox(rproc);
 	if (ret)
 		return ret;
 
@@ -332,7 +54,7 @@ static int k3_dsp_rproc_start(struct rproc *rproc)
 	if (ret)
 		goto put_mbox;
 
-	ret = k3_dsp_rproc_release(kproc);
+	ret = k3_rproc_release(kproc);
 	if (ret)
 		goto put_mbox;
 
@@ -351,11 +73,11 @@ static int k3_dsp_rproc_start(struct rproc *rproc)
  */
 static int k3_dsp_rproc_stop(struct rproc *rproc)
 {
-	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct k3_rproc *kproc = rproc->priv;
 
 	mbox_free_channel(kproc->mbox);
 
-	k3_dsp_rproc_reset(kproc);
+	k3_rproc_reset(kproc);
 
 	return 0;
 }
@@ -370,11 +92,11 @@ static int k3_dsp_rproc_stop(struct rproc *rproc)
  */
 static int k3_dsp_rproc_attach(struct rproc *rproc)
 {
-	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct k3_rproc *kproc = rproc->priv;
 	struct device *dev = kproc->dev;
 	int ret;
 
-	ret = k3_dsp_rproc_request_mbox(rproc);
+	ret = k3_rproc_request_mbox(rproc);
 	if (ret)
 		return ret;
 
@@ -392,7 +114,7 @@ static int k3_dsp_rproc_attach(struct rproc *rproc)
  */
 static int k3_dsp_rproc_detach(struct rproc *rproc)
 {
-	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct k3_rproc *kproc = rproc->priv;
 	struct device *dev = kproc->dev;
 
 	mbox_free_channel(kproc->mbox);
@@ -400,282 +122,20 @@ static int k3_dsp_rproc_detach(struct rproc *rproc)
 	return 0;
 }
 
-/*
- * This function implements the .get_loaded_rsc_table() callback and is used
- * to provide the resource table for a booted DSP in IPC-only mode. The K3 DSP
- * firmwares follow a design-by-contract approach and are expected to have the
- * resource table at the base of the DDR region reserved for firmware usage.
- * This provides flexibility for the remote processor to be booted by different
- * bootloaders that may or may not have the ability to publish the resource table
- * address and size through a DT property. This callback is invoked only in
- * IPC-only mode.
- */
-static struct resource_table *k3_dsp_get_loaded_rsc_table(struct rproc *rproc,
-							  size_t *rsc_table_sz)
-{
-	struct k3_dsp_rproc *kproc = rproc->priv;
-	struct device *dev = kproc->dev;
-
-	if (!kproc->rmem[0].cpu_addr) {
-		dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
-		return ERR_PTR(-ENOMEM);
-	}
-
-	/*
-	 * NOTE: The resource table size is currently hard-coded to a maximum
-	 * of 256 bytes. The most common resource table usage for K3 firmwares
-	 * is to only have the vdev resource entry and an optional trace entry.
-	 * The exact size could be computed based on resource table address, but
-	 * the hard-coded value suffices to support the IPC-only mode.
-	 */
-	*rsc_table_sz = 256;
-	return (struct resource_table *)kproc->rmem[0].cpu_addr;
-}
-
-/*
- * Custom function to translate a DSP device address (internal RAMs only) to a
- * kernel virtual address.  The DSPs can access their RAMs at either an internal
- * address visible only from a DSP, or at the SoC-level bus address. Both these
- * addresses need to be looked through for translation. The translated addresses
- * can be used either by the remoteproc core for loading (when using kernel
- * remoteproc loader), or by any rpmsg bus drivers.
- */
-static void *k3_dsp_rproc_da_to_va(struct rproc *rproc, u64 da, size_t len, bool *is_iomem)
-{
-	struct k3_dsp_rproc *kproc = rproc->priv;
-	void __iomem *va = NULL;
-	phys_addr_t bus_addr;
-	u32 dev_addr, offset;
-	size_t size;
-	int i;
-
-	if (len == 0)
-		return NULL;
-
-	for (i = 0; i < kproc->num_mems; i++) {
-		bus_addr = kproc->mem[i].bus_addr;
-		dev_addr = kproc->mem[i].dev_addr;
-		size = kproc->mem[i].size;
-
-		if (da < KEYSTONE_RPROC_LOCAL_ADDRESS_MASK) {
-			/* handle DSP-view addresses */
-			if (da >= dev_addr &&
-			    ((da + len) <= (dev_addr + size))) {
-				offset = da - dev_addr;
-				va = kproc->mem[i].cpu_addr + offset;
-				return (__force void *)va;
-			}
-		} else {
-			/* handle SoC-view addresses */
-			if (da >= bus_addr &&
-			    (da + len) <= (bus_addr + size)) {
-				offset = da - bus_addr;
-				va = kproc->mem[i].cpu_addr + offset;
-				return (__force void *)va;
-			}
-		}
-	}
-
-	/* handle static DDR reserved memory regions */
-	for (i = 0; i < kproc->num_rmems; i++) {
-		dev_addr = kproc->rmem[i].dev_addr;
-		size = kproc->rmem[i].size;
-
-		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
-			offset = da - dev_addr;
-			va = kproc->rmem[i].cpu_addr + offset;
-			return (__force void *)va;
-		}
-	}
-
-	return NULL;
-}
 
 static const struct rproc_ops k3_dsp_rproc_ops = {
 	.start		= k3_dsp_rproc_start,
 	.stop		= k3_dsp_rproc_stop,
-	.kick		= k3_dsp_rproc_kick,
-	.da_to_va	= k3_dsp_rproc_da_to_va,
+	.kick		= k3_rproc_kick,
+	.da_to_va	= k3_rproc_da_to_va,
 };
 
-static int k3_dsp_rproc_of_get_memories(struct platform_device *pdev,
-					struct k3_dsp_rproc *kproc)
-{
-	const struct k3_dsp_dev_data *data = kproc->data;
-	struct device *dev = &pdev->dev;
-	struct resource *res;
-	int num_mems = 0;
-	int i;
-
-	num_mems = kproc->data->num_mems;
-	kproc->mem = devm_kcalloc(kproc->dev, num_mems,
-				  sizeof(*kproc->mem), GFP_KERNEL);
-	if (!kproc->mem)
-		return -ENOMEM;
-
-	for (i = 0; i < num_mems; i++) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   data->mems[i].name);
-		if (!res) {
-			dev_err(dev, "found no memory resource for %s\n",
-				data->mems[i].name);
-			return -EINVAL;
-		}
-		if (!devm_request_mem_region(dev, res->start,
-					     resource_size(res),
-					     dev_name(dev))) {
-			dev_err(dev, "could not request %s region for resource\n",
-				data->mems[i].name);
-			return -EBUSY;
-		}
-
-		kproc->mem[i].cpu_addr = devm_ioremap_wc(dev, res->start,
-							 resource_size(res));
-		if (!kproc->mem[i].cpu_addr) {
-			dev_err(dev, "failed to map %s memory\n",
-				data->mems[i].name);
-			return -ENOMEM;
-		}
-		kproc->mem[i].bus_addr = res->start;
-		kproc->mem[i].dev_addr = data->mems[i].dev_addr;
-		kproc->mem[i].size = resource_size(res);
-
-		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %pK da 0x%x\n",
-			data->mems[i].name, &kproc->mem[i].bus_addr,
-			kproc->mem[i].size, kproc->mem[i].cpu_addr,
-			kproc->mem[i].dev_addr);
-	}
-	kproc->num_mems = num_mems;
-
-	return 0;
-}
-
-static int k3_dsp_reserved_mem_init(struct k3_dsp_rproc *kproc)
-{
-	struct device *dev = kproc->dev;
-	struct device_node *np = dev->of_node;
-	struct device_node *rmem_np;
-	struct reserved_mem *rmem;
-	int num_rmems;
-	int ret, i;
-
-	num_rmems = of_property_count_elems_of_size(np, "memory-region",
-						    sizeof(phandle));
-	if (num_rmems <= 0) {
-		dev_err(dev, "device does not reserved memory regions, ret = %d\n",
-			num_rmems);
-		return -EINVAL;
-	}
-	if (num_rmems < 2) {
-		dev_err(dev, "device needs at least two memory regions to be defined, num = %d\n",
-			num_rmems);
-		return -EINVAL;
-	}
-
-	/* use reserved memory region 0 for vring DMA allocations */
-	ret = of_reserved_mem_device_init_by_idx(dev, np, 0);
-	if (ret) {
-		dev_err(dev, "device cannot initialize DMA pool, ret = %d\n",
-			ret);
-		return ret;
-	}
-
-	num_rmems--;
-	kproc->rmem = kcalloc(num_rmems, sizeof(*kproc->rmem), GFP_KERNEL);
-	if (!kproc->rmem) {
-		ret = -ENOMEM;
-		goto release_rmem;
-	}
-
-	/* use remaining reserved memory regions for static carveouts */
-	for (i = 0; i < num_rmems; i++) {
-		rmem_np = of_parse_phandle(np, "memory-region", i + 1);
-		if (!rmem_np) {
-			ret = -EINVAL;
-			goto unmap_rmem;
-		}
-
-		rmem = of_reserved_mem_lookup(rmem_np);
-		if (!rmem) {
-			of_node_put(rmem_np);
-			ret = -EINVAL;
-			goto unmap_rmem;
-		}
-		of_node_put(rmem_np);
-
-		kproc->rmem[i].bus_addr = rmem->base;
-		/* 64-bit address regions currently not supported */
-		kproc->rmem[i].dev_addr = (u32)rmem->base;
-		kproc->rmem[i].size = rmem->size;
-		kproc->rmem[i].cpu_addr = ioremap_wc(rmem->base, rmem->size);
-		if (!kproc->rmem[i].cpu_addr) {
-			dev_err(dev, "failed to map reserved memory#%d at %pa of size %pa\n",
-				i + 1, &rmem->base, &rmem->size);
-			ret = -ENOMEM;
-			goto unmap_rmem;
-		}
-
-		dev_dbg(dev, "reserved memory%d: bus addr %pa size 0x%zx va %pK da 0x%x\n",
-			i + 1, &kproc->rmem[i].bus_addr,
-			kproc->rmem[i].size, kproc->rmem[i].cpu_addr,
-			kproc->rmem[i].dev_addr);
-	}
-	kproc->num_rmems = num_rmems;
-
-	return 0;
-
-unmap_rmem:
-	for (i--; i >= 0; i--)
-		iounmap(kproc->rmem[i].cpu_addr);
-	kfree(kproc->rmem);
-release_rmem:
-	of_reserved_mem_device_release(kproc->dev);
-	return ret;
-}
-
-static void k3_dsp_reserved_mem_exit(struct k3_dsp_rproc *kproc)
-{
-	int i;
-
-	for (i = 0; i < kproc->num_rmems; i++)
-		iounmap(kproc->rmem[i].cpu_addr);
-	kfree(kproc->rmem);
-
-	of_reserved_mem_device_release(kproc->dev);
-}
-
-static
-struct ti_sci_proc *k3_dsp_rproc_of_get_tsp(struct device *dev,
-					    const struct ti_sci_handle *sci)
-{
-	struct ti_sci_proc *tsp;
-	u32 temp[2];
-	int ret;
-
-	ret = of_property_read_u32_array(dev->of_node, "ti,sci-proc-ids",
-					 temp, 2);
-	if (ret < 0)
-		return ERR_PTR(ret);
-
-	tsp = kzalloc(sizeof(*tsp), GFP_KERNEL);
-	if (!tsp)
-		return ERR_PTR(-ENOMEM);
-
-	tsp->dev = dev;
-	tsp->sci = sci;
-	tsp->ops = &sci->ops.proc_ops;
-	tsp->proc_id = temp[0];
-	tsp->host_id = temp[1];
-
-	return tsp;
-}
-
 static int k3_dsp_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	const struct k3_dsp_dev_data *data;
-	struct k3_dsp_rproc *kproc;
+	const struct k3_rproc_dev_data *data;
+	struct k3_rproc *kproc;
 	struct rproc *rproc;
 	const char *fw_name;
 	bool p_state = false;
@@ -701,8 +161,8 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	rproc->has_iommu = false;
 	rproc->recovery_disabled = true;
 	if (data->uses_lreset) {
-		rproc->ops->prepare = k3_dsp_rproc_prepare;
-		rproc->ops->unprepare = k3_dsp_rproc_unprepare;
+		rproc->ops->prepare = k3_rproc_prepare;
+		rproc->ops->unprepare = k3_rproc_unprepare;
 	}
 	kproc = rproc->priv;
 	kproc->rproc = rproc;
@@ -733,7 +193,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		goto put_sci;
 	}
 
-	kproc->tsp = k3_dsp_rproc_of_get_tsp(dev, kproc->ti_sci);
+	kproc->tsp = k3_rproc_of_get_tsp(dev, kproc->ti_sci);
 	if (IS_ERR(kproc->tsp)) {
 		dev_err(dev, "failed to construct ti-sci proc control, ret = %d\n",
 			ret);
@@ -747,11 +207,11 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		goto free_tsp;
 	}
 
-	ret = k3_dsp_rproc_of_get_memories(pdev, kproc);
+	ret = k3_rproc_of_get_memories(pdev, kproc);
 	if (ret)
 		goto release_tsp;
 
-	ret = k3_dsp_reserved_mem_init(kproc);
+	ret = k3_reserved_mem_init(kproc);
 	if (ret) {
 		dev_err(dev, "reserved memory init failed, ret = %d\n", ret);
 		goto release_tsp;
@@ -776,7 +236,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		rproc->ops->stop = NULL;
 		rproc->ops->attach = k3_dsp_rproc_attach;
 		rproc->ops->detach = k3_dsp_rproc_detach;
-		rproc->ops->get_loaded_rsc_table = k3_dsp_get_loaded_rsc_table;
+		rproc->ops->get_loaded_rsc_table = k3_get_loaded_rsc_table;
 	} else {
 		dev_info(dev, "configured DSP for remoteproc mode\n");
 		/*
@@ -792,7 +252,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 				goto release_mem;
 			} else if (ret == 0) {
 				dev_warn(dev, "local reset is deasserted for device\n");
-				k3_dsp_rproc_reset(kproc);
+				k3_rproc_reset(kproc);
 			}
 		}
 	}
@@ -809,7 +269,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	return 0;
 
 release_mem:
-	k3_dsp_reserved_mem_exit(kproc);
+	k3_reserved_mem_exit(kproc);
 release_tsp:
 	ret1 = ti_sci_proc_release(kproc->tsp);
 	if (ret1)
@@ -827,7 +287,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 
 static int k3_dsp_rproc_remove(struct platform_device *pdev)
 {
-	struct k3_dsp_rproc *kproc = platform_get_drvdata(pdev);
+	struct k3_rproc *kproc = platform_get_drvdata(pdev);
 	struct rproc *rproc = kproc->rproc;
 	struct device *dev = &pdev->dev;
 	int ret;
@@ -852,43 +312,43 @@ static int k3_dsp_rproc_remove(struct platform_device *pdev)
 	if (ret)
 		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret);
 
-	k3_dsp_reserved_mem_exit(kproc);
+	k3_reserved_mem_exit(kproc);
 	rproc_free(kproc->rproc);
 
 	return 0;
 }
 
-static const struct k3_dsp_mem_data c66_mems[] = {
+static const struct k3_rproc_mem_data c66_mems[] = {
 	{ .name = "l2sram", .dev_addr = 0x800000 },
 	{ .name = "l1pram", .dev_addr = 0xe00000 },
 	{ .name = "l1dram", .dev_addr = 0xf00000 },
 };
 
 /* C71x cores only have a L1P Cache, there are no L1P SRAMs */
-static const struct k3_dsp_mem_data c71_mems[] = {
+static const struct k3_rproc_mem_data c71_mems[] = {
 	{ .name = "l2sram", .dev_addr = 0x800000 },
 	{ .name = "l1dram", .dev_addr = 0xe00000 },
 };
 
-static const struct k3_dsp_mem_data c7xv_mems[] = {
+static const struct k3_rproc_mem_data c7xv_mems[] = {
 	{ .name = "l2sram", .dev_addr = 0x800000 },
 };
 
-static const struct k3_dsp_dev_data c66_data = {
+static const struct k3_rproc_dev_data c66_data = {
 	.mems = c66_mems,
 	.num_mems = ARRAY_SIZE(c66_mems),
 	.boot_align_addr = SZ_1K,
 	.uses_lreset = true,
 };
 
-static const struct k3_dsp_dev_data c71_data = {
+static const struct k3_rproc_dev_data c71_data = {
 	.mems = c71_mems,
 	.num_mems = ARRAY_SIZE(c71_mems),
 	.boot_align_addr = SZ_2M,
 	.uses_lreset = false,
 };
 
-static const struct k3_dsp_dev_data c7xv_data = {
+static const struct k3_rproc_dev_data c7xv_data = {
 	.mems = c7xv_mems,
 	.num_mems = ARRAY_SIZE(c7xv_mems),
 	.boot_align_addr = SZ_2M,
-- 
2.34.1

