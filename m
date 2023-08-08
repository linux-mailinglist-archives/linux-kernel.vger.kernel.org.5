Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911C97746B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjHHS7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjHHS7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:59:03 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B79D7D7A2;
        Tue,  8 Aug 2023 10:23:15 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3784jbMs092042;
        Mon, 7 Aug 2023 23:45:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691469937;
        bh=CdAgpx1uSbSlDGQR/6X69qZUFNevGdISPMeHg4n5BnY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OLTepMq3W1wjvaFjPAcNsTzAN4qq1G/AKxtZE34jEr3nmbGIDtOdNdLqw80GwHRwl
         R0JM+H/fL6TEDbl0nXinhoJ6v78pazZNTpNXTpflvNPFeeO75QIz92wGJF2lKoRB8R
         5hKHzIRgswWPcj+KgqdaaEwQIrlJg735i6fhqhdY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3784jber051885
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Aug 2023 23:45:37 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Aug 2023 23:45:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Aug 2023 23:45:37 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3784jaTa074552;
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
Subject: [PATCH v5 5/5] remoteproc: k3-m4: Add a remoteproc driver for M4F subsystem
Date:   Mon, 7 Aug 2023 23:45:29 -0500
Message-ID: <20230808044529.25925-6-hnagalla@ti.com>
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

The AM62x and AM64x SoCs of the TI K3 family has a Cortex M4F core in
the MCU domain. This core is typically used for safety applications in a
stand alone mode. However, some application (non safety related) may
want to use the M4F core as a generic remote processor with IPC to the
host processor. The M4F core has internal IRAM and DRAM memories and are
exposed to the system bus for code and data loading.

A remote processor driver is added to support this subsystem, including
being able to load and boot the M4F core. Loading includes to M4F
internal memories and predefined external code/data memories. The
carve outs for external contiguous memory is defined in the M4F device
node and should match with the external memory declarations in the M4F
image binary. The M4F subsystem has two resets. One reset is for the
entire subsystem i.e including the internal memories and the other, a
local reset is only for the M4F processing core. When loading the image,
the driver first releases the subsystem reset, loads the firmware image
and then releases the local reset to let the M4F processing core run.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v1:
 - Addressed minor review comments (refactoring completed in separate
   patch)

Changes since v2:
 - Refactoring completed first, thus smaller change

Changes since v3:
 - Removed 'ipc_only' flag and made changes in probe() to enact right
   operations
 - Fixed spelling mistakes in commit message
 - Changed some 'dev_err' messages to 'dev_info'
 - Removed unnecessary checks rproc state

Changes since v4:
 - None

 drivers/remoteproc/Kconfig               |  13 +
 drivers/remoteproc/Makefile              |   1 +
 drivers/remoteproc/ti_k3_common.h        |   7 +-
 drivers/remoteproc/ti_k3_m4_remoteproc.c | 333 +++++++++++++++++++++++
 4 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/ti_k3_m4_remoteproc.c

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 48845dc8fa85..85c1a3a2b987 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -339,6 +339,19 @@ config TI_K3_DSP_REMOTEPROC
 	  It's safe to say N here if you're not interested in utilizing
 	  the DSP slave processors.
 
+config TI_K3_M4_REMOTEPROC
+	tristate "TI K3 M4 remoteproc support"
+	depends on ARCH_K3
+	select MAILBOX
+	select OMAP2PLUS_MBOX
+	help
+	  Say m here to support TI's M4 remote processor subsystems
+	  on various TI K3 family of SoCs through the remote processor
+	  framework.
+
+	  It's safe to say N here if you're not interested in utilizing
+	  a remote processor.
+
 config TI_K3_R5_REMOTEPROC
 	tristate "TI K3 R5 remoteproc support"
 	depends on ARCH_K3
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 55c552e27a45..e30908ca4bfc 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -37,5 +37,6 @@ obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
 obj-$(CONFIG_ST_SLIM_REMOTEPROC)	+= st_slim_rproc.o
 obj-$(CONFIG_STM32_RPROC)		+= stm32_rproc.o
 obj-$(CONFIG_TI_K3_DSP_REMOTEPROC)	+= ti_k3_dsp_remoteproc.o ti_k3_common.o
+obj-$(CONFIG_TI_K3_M4_REMOTEPROC)	+= ti_k3_m4_remoteproc.o ti_k3_common.o
 obj-$(CONFIG_TI_K3_R5_REMOTEPROC)	+= ti_k3_r5_remoteproc.o
 obj-$(CONFIG_XLNX_R5_REMOTEPROC)	+= xlnx_r5_remoteproc.o
diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
index 917a9c82b4cf..5de014e1065f 100644
--- a/drivers/remoteproc/ti_k3_common.h
+++ b/drivers/remoteproc/ti_k3_common.h
@@ -2,11 +2,15 @@
 /*
  * TI K3 Remote Processor(s) driver common code
  *
- * Refactored from ti_k3_dsp_remoteproc.c.
+ * Refactored from ti_k3_dsp_remoteproc.c and ti_k3_m4_remoteproc.c.
  *
  * ti_k3_dsp_remoteproc.c:
  * Copyright (C) 2018-2022 Texas Instruments Incorporated - https://www.ti.com/
  *	Suman Anna <s-anna@ti.com>
+ *
+ * ti_k3_m4_remoteproc.c:
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
  */
 
 #ifndef REMOTEPROC_TI_K3_COMMON_H
@@ -82,6 +86,7 @@ struct k3_rproc {
 	u32 ti_sci_id;
 	struct mbox_chan *mbox;
 	struct mbox_client client;
+	bool ipc_only;
 };
 
 void k3_rproc_kick(struct rproc *rproc, int vqid);
diff --git a/drivers/remoteproc/ti_k3_m4_remoteproc.c b/drivers/remoteproc/ti_k3_m4_remoteproc.c
new file mode 100644
index 000000000000..010b3a2fc1fa
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_m4_remoteproc.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * TI K3 Cortex-M4 Remote Processor(s) driver
+ *
+ * Copyright (C) 2021 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
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
+ * Power up the M4F remote processor.
+ *
+ * This function will be invoked only after the firmware for this rproc
+ * was loaded, parsed successfully, and all of its resource requirements
+ * were met. This callback is invoked only in remoteproc mode.
+ */
+static int k3_m4_rproc_start(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	u32 boot_addr;
+	int ret;
+
+	ret = k3_rproc_request_mbox(rproc);
+	if (ret)
+		return ret;
+
+	boot_addr = rproc->bootaddr;
+	ret = k3_rproc_release(kproc);
+	if (ret)
+		goto put_mbox;
+
+	return 0;
+
+put_mbox:
+	mbox_free_channel(kproc->mbox);
+	return ret;
+}
+
+/*
+ * Stop the M4 remote processor.
+ *
+ * This function puts the M4 processor into reset, and finishes processing
+ * of any pending messages. This callback is invoked only in remoteproc mode.
+ */
+static int k3_m4_rproc_stop(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+
+	mbox_free_channel(kproc->mbox);
+
+	k3_rproc_reset(kproc);
+
+	return 0;
+}
+
+/*
+ * Attach to a running M4 remote processor (IPC-only mode)
+ *
+ * This rproc attach callback only needs to request the mailbox, the remote
+ * processor is already booted, so there is no need to issue any TI-SCI
+ * commands to boot the M4 core. This callback is used only in IPC-only mode.
+ */
+static int k3_m4_rproc_attach(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = k3_rproc_request_mbox(rproc);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "M4 initialized in IPC-only mode\n");
+	return 0;
+}
+
+/*
+ * Detach from a running M4 remote processor (IPC-only mode)
+ *
+ * This rproc detach callback performs the opposite operation to attach callback
+ * and only needs to release the mailbox, the M4 core is not stopped and will
+ * be left to continue to run its booted firmware. This callback is invoked only in
+ * IPC-only mode.
+ */
+static int k3_m4_rproc_detach(struct rproc *rproc)
+{
+	struct k3_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+
+	mbox_free_channel(kproc->mbox);
+	dev_info(dev, "M4 deinitialized in IPC-only mode\n");
+	return 0;
+}
+
+static const struct rproc_ops k3_m4_rproc_ops = {
+	.start		= k3_m4_rproc_start,
+	.stop		= k3_m4_rproc_stop,
+	.attach		= k3_m4_rproc_attach,
+	.detach		= k3_m4_rproc_detach,
+	.kick		= k3_rproc_kick,
+	.da_to_va	= k3_rproc_da_to_va,
+	.get_loaded_rsc_table = k3_get_loaded_rsc_table,
+};
+
+static int k3_m4_rproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct k3_rproc_dev_data *data;
+	struct k3_rproc *kproc;
+	struct rproc *rproc;
+	const char *fw_name;
+	bool r_state = false;
+	bool p_state = false;
+	int ret = 0;
+	int ret1;
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	ret = rproc_of_parse_firmware(dev, 0, &fw_name);
+	if (ret) {
+		dev_err(dev, "failed to parse firmware-name property, ret = %d\n",
+			ret);
+		return ret;
+	}
+
+	rproc = rproc_alloc(dev, dev_name(dev), &k3_m4_rproc_ops, fw_name,
+			    sizeof(*kproc));
+	if (!rproc)
+		return -ENOMEM;
+
+	rproc->has_iommu = false;
+	rproc->recovery_disabled = true;
+	if (data->uses_lreset) {
+		rproc->ops->prepare = k3_rproc_prepare;
+		rproc->ops->unprepare = k3_rproc_unprepare;
+	}
+	kproc = rproc->priv;
+	kproc->rproc = rproc;
+	kproc->dev = dev;
+	kproc->data = data;
+
+	kproc->ti_sci = ti_sci_get_by_phandle(np, "ti,sci");
+	if (IS_ERR(kproc->ti_sci)) {
+		ret = PTR_ERR(kproc->ti_sci);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "failed to get ti-sci handle, ret = %d\n",
+				ret);
+		}
+		kproc->ti_sci = NULL;
+		goto free_rproc;
+	}
+
+	ret = of_property_read_u32(np, "ti,sci-dev-id", &kproc->ti_sci_id);
+	if (ret) {
+		dev_err(dev, "missing 'ti,sci-dev-id' property\n");
+		goto put_sci;
+	}
+
+	kproc->reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(kproc->reset)) {
+		ret = PTR_ERR(kproc->reset);
+		dev_err(dev, "failed to get reset, status = %d\n", ret);
+		goto put_sci;
+	}
+
+	kproc->tsp = k3_rproc_of_get_tsp(dev, kproc->ti_sci);
+	if (IS_ERR(kproc->tsp)) {
+		dev_err(dev, "failed to construct ti-sci proc control, ret = %d\n",
+			ret);
+		ret = PTR_ERR(kproc->tsp);
+		goto put_sci;
+	}
+
+	ret = ti_sci_proc_request(kproc->tsp);
+	if (ret < 0) {
+		dev_err(dev, "ti_sci_proc_request failed, ret = %d\n", ret);
+		goto free_tsp;
+	}
+
+	ret = k3_rproc_of_get_memories(pdev, kproc);
+	if (ret)
+		goto release_tsp;
+
+	ret = k3_reserved_mem_init(kproc);
+	if (ret) {
+		dev_err(dev, "reserved memory init failed, ret = %d\n", ret);
+		goto release_tsp;
+	}
+
+	ret = kproc->ti_sci->ops.dev_ops.is_on(kproc->ti_sci, kproc->ti_sci_id,
+					       &r_state, &p_state);
+	if (ret) {
+		dev_err(dev, "failed to get initial state, mode cannot be determined, ret = %d\n",
+			ret);
+		goto release_mem;
+	}
+
+	/* configure devices for either remoteproc or IPC-only mode */
+	if (p_state) {
+		dev_info(dev, "configured M4 for IPC-only mode\n");
+		rproc->state = RPROC_DETACHED;
+		/* override rproc ops with only required IPC-only mode ops */
+		rproc->ops->prepare = NULL;
+		rproc->ops->unprepare = NULL;
+		rproc->ops->start = NULL;
+		rproc->ops->stop = NULL;
+		rproc->ops->attach = k3_m4_rproc_attach;
+		rproc->ops->detach = k3_m4_rproc_detach;
+		rproc->ops->get_loaded_rsc_table = k3_get_loaded_rsc_table;
+	} else {
+		dev_info(dev, "configured M4 for remoteproc mode\n");
+		/*
+		 * ensure the M4 local reset is asserted to ensure the core
+		 * doesn't execute bogus code in .prepare() when the module
+		 * reset is released.
+		 */
+		if (data->uses_lreset) {
+			ret = reset_control_status(kproc->reset);
+			if (ret < 0) {
+				dev_err(dev, "failed to get reset status, status = %d\n",
+					ret);
+				goto release_mem;
+			} else if (ret == 0) {
+				dev_warn(dev, "local reset is deasserted for device\n");
+				k3_rproc_reset(kproc);
+			}
+		}
+	}
+
+	ret = rproc_add(rproc);
+	if (ret) {
+		dev_err(dev, "failed to add register device with remoteproc core, status = %d\n",
+			ret);
+		goto release_mem;
+	}
+
+	platform_set_drvdata(pdev, kproc);
+
+	return 0;
+
+release_mem:
+	k3_reserved_mem_exit(kproc);
+release_tsp:
+	ret1 = ti_sci_proc_release(kproc->tsp);
+	if (ret1)
+		dev_err(dev, "failed to release proc, ret = %d\n", ret1);
+free_tsp:
+	kfree(kproc->tsp);
+put_sci:
+	ret1 = ti_sci_put_handle(kproc->ti_sci);
+	if (ret1)
+		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret1);
+free_rproc:
+	rproc_free(rproc);
+	return ret;
+}
+
+static int k3_m4_rproc_remove(struct platform_device *pdev)
+{
+	struct k3_rproc *kproc = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	rproc_del(kproc->rproc);
+
+	ret = ti_sci_proc_release(kproc->tsp);
+	if (ret)
+		dev_err(dev, "failed to release proc, ret = %d\n", ret);
+
+	kfree(kproc->tsp);
+
+	ret = ti_sci_put_handle(kproc->ti_sci);
+	if (ret)
+		dev_err(dev, "failed to put ti_sci handle, ret = %d\n", ret);
+
+	k3_reserved_mem_exit(kproc);
+	rproc_free(kproc->rproc);
+
+	return 0;
+}
+
+static const struct k3_rproc_mem_data am64_m4_mems[] = {
+	{ .name = "iram", .dev_addr = 0x0 },
+	{ .name = "dram", .dev_addr = 0x30000 },
+};
+
+static const struct k3_rproc_dev_data am64_m4_data = {
+	.mems = am64_m4_mems,
+	.num_mems = ARRAY_SIZE(am64_m4_mems),
+	.boot_align_addr = SZ_1K,
+	.uses_lreset = true,
+};
+
+static const struct of_device_id k3_m4_of_match[] = {
+	{ .compatible = "ti,am64-m4fss", .data = &am64_m4_data, },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, k3_m4_of_match);
+
+static struct platform_driver k3_m4_rproc_driver = {
+	.probe	= k3_m4_rproc_probe,
+	.remove	= k3_m4_rproc_remove,
+	.driver	= {
+		.name = "k3-m4-rproc",
+		.of_match_table = k3_m4_of_match,
+	},
+};
+
+module_platform_driver(k3_m4_rproc_driver);
+
+MODULE_AUTHOR("Hari Nagalla <hnagalla@ti.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("TI K3 M4 Remoteproc driver");
-- 
2.34.1

