Return-Path: <linux-kernel+bounces-50272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB35F8476B7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E791C22794
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603E514C598;
	Fri,  2 Feb 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VBIAlt/a"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88D168B9;
	Fri,  2 Feb 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896562; cv=none; b=tCXy8SHlV10Lqzz4Fh4LE30AqaxfILU8VrTYme6Ph7p4iABxmQ7ihgH6zc5df/+3DAFVzEQ1iU5DsIIP0MezbYO3nNmq/pibf03s2db0ysny/OOuPAxlV3of6vTFpusl7zUZmhED17cSR+z1g0LirlqJk1xoQLfMsoxSGhWt/QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896562; c=relaxed/simple;
	bh=xQo4AQIC5WwFf8Ub/CQgxJHP4s1Ke10LxeBuhX7e5oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osc4if+KSweYFqDtpkfmp2pf+r5r8kBQIP7io85nrWnAscGDb/FIkyXrh6nd7iqtJDyNUXKGHmUGwjx35HKYkz1TsMfqCM5JtIOOoU2llP9AzfSFR2+x0a5KXLh158lRIU2ZytiQluZxNW0PpxA1ACaRtKL2HBYMVp15oVSdm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VBIAlt/a; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 412HtjXG030389;
	Fri, 2 Feb 2024 11:55:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706896545;
	bh=kX+utj8gCPZ9NGrtLHOhFLW+FqXZX5d0Rk2tli01ct4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VBIAlt/acDngjaVp5Wy3OaPBuOs0hagxD8KdQOuN3DiAhIY64o42dVzv4rch93DEl
	 vHJLibmMZXyNKZvyrGgg4xemMhnWVfZouqJEMYo30KrwwICCbF/zQQIgM5j65yM763
	 rRf8vJvrij3AXofkCfz1mZYOve6yJ/MNM9BwHgVU=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 412HtjJC110348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 Feb 2024 11:55:45 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 Feb 2024 11:55:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 Feb 2024 11:55:45 -0600
Received: from localhost ([10.249.48.175])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 412Htj4V061002;
	Fri, 2 Feb 2024 11:55:45 -0600
From: Hari Nagalla <hnagalla@ti.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <p.zabel@pengutronix.de>, <martyn.welch@collabora.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v7 2/5] remoteproc: k3: Move out data structures common with M4 driver
Date: Fri, 2 Feb 2024 11:55:35 -0600
Message-ID: <20240202175538.1705-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240202175538.1705-1-hnagalla@ti.com>
References: <20240202175538.1705-1-hnagalla@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Martyn Welch <martyn.welch@collabora.com>

We will be adding the M4F driver which shares a lot of commonality
with the DSP driver. Common data structures are introduced here.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
Changes since v5:
 - Created a separate patch for data structures to ease review

Changes since v6:
 - Reworded 'split' to 'move' as the common data structures between
   DSP and M4 remote rpoc drivers are moved into common driver.

link to v6:
https://lore.kernel.org/all/20230913111644.29889-3-hnagalla@ti.com/

 drivers/remoteproc/ti_k3_common.h | 107 ++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 drivers/remoteproc/ti_k3_common.h

diff --git a/drivers/remoteproc/ti_k3_common.h b/drivers/remoteproc/ti_k3_common.h
new file mode 100644
index 000000000000..f1bab83dd0fc
--- /dev/null
+++ b/drivers/remoteproc/ti_k3_common.h
@@ -0,0 +1,107 @@
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
+ * @dev_addr: Device address of the memory region from remote processor view
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
+ * struct k3_rproc_mem_data - memory definitions for a remote processor
+ * @name: name for this memory entry
+ * @dev_addr: device address for the memory entry
+ */
+struct k3_rproc_mem_data {
+	const char *name;
+	const u32 dev_addr;
+};
+
+/**
+ * struct k3_rproc_dev_data - device data structure for a remote processor
+ * @mems: pointer to memory definitions for a remote processor
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
+	struct k3_rproc_mem *sram;
+	int num_sram;
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
+int k3_rproc_of_get_sram_memories(struct platform_device *pdev,
+			     struct k3_rproc *kproc);
+int k3_reserved_mem_init(struct k3_rproc *kproc);
+void k3_reserved_mem_exit(struct k3_rproc *kproc);
+struct ti_sci_proc *k3_rproc_of_get_tsp(struct device *dev,
+					const struct ti_sci_handle *sci);
+#endif /* REMOTEPROC_TI_K3_COMMON_H */
-- 
2.34.1


