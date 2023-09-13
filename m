Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE879E66C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbjIMLRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239855AbjIMLRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:17:15 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF01BFE;
        Wed, 13 Sep 2023 04:17:11 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38DBGtuT029340;
        Wed, 13 Sep 2023 06:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694603815;
        bh=mZc/pucVIrGpAbOktFn+7SixNRiMWM4VKCT2xFqhRb0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pRKgZQk40HrwyLwKVkpTvSxm7wlOS8D7H32Y+o5fN6EJIaGuNeTgkfXZgUgiiqr7T
         c6+srVw88PW3lXsB96yBQx7LlamrvLb/bZYGAPoKJeHkOghtWAlQTbyTVUhGE7kksi
         p5WpdWaebtlp4JWZvmy7Hwj/mR/nCeajE41nhSSs=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38DBGtDi077135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 06:16:55 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 06:16:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 06:16:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38DBGtmr074536;
        Wed, 13 Sep 2023 06:16:55 -0500
From:   Hari Nagalla <hnagalla@ti.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v6 2/4] remoteproc: k3: Split out data structures common with M4 driver
Date:   Wed, 13 Sep 2023 06:16:42 -0500
Message-ID: <20230913111644.29889-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230913111644.29889-1-hnagalla@ti.com>
References: <20230913111644.29889-1-hnagalla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

We will be adding the M4F driver which shares a lot of commonality
with the DSP driver. Common data structures are introduced here.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes in v6:
 - Created a separate patch for data structures to ease review

 drivers/remoteproc/ti_k3_common.h | 103 ++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_common.h

diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
new file mode 100644
index 000000000000..5e1f27741183
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
+int k3_rproc_request_mbox(struct rproc *rproc);
+int k3_rproc_prepare(struct rproc *rproc);
+int k3_rproc_unprepare(struct rproc *rproc);
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
+#endif /* REMOTEPROC_TI_K3_COMMON_H */
-- 
2.34.1

