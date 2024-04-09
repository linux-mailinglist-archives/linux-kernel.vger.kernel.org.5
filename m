Return-Path: <linux-kernel+bounces-136841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F5289D8DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F91828832F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D45129A7B;
	Tue,  9 Apr 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="OG3cRUTt"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1512C7E8;
	Tue,  9 Apr 2024 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664389; cv=fail; b=kNqktrNpDYpxWv6qmvYJY8jBpKEm2EUYBo2RyHEjnLykRic+l8z6hi0NJLsdwypT51o387N8ikbA7iKrekVzTqjYz7FsXFJqDn3gx8hcZg4J+sjR5QXj95tYYgzGQxPajHSN6J8ZdloeHV0b9cTe/BR92D01j7Je+3mGJOn2+ZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664389; c=relaxed/simple;
	bh=q5fLQTRkmLlSWtdsIVtEnUUrdNlnm6sKndE6vvrMQp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ozrYgFheuRjA+7VZwEBtfsi9EG8+Hc6hzCAzoJnKuQ/NQk1US/rmqpBrKaWyDEkB51gc8HqiZFUIQ+b6MmWCwTqtsQS486PyBpTWMQEeZToL4Y7Cs0RX1qI40awS8CdKcau1fXtY2pNbUHb8ORbZhcxnAN0EtUeJYONwclUGIJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=OG3cRUTt; arc=fail smtp.client-ip=40.107.20.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMGqnjFoKvygYAl2l2rsMPX2FivU8MyCm/cveTqj0SycJ0tNFOw9a+F797utkDOz2yLy3Tn6uuZBUIh20CWJ4AUYTAn6WD5wdMeIUXTLqK3DHS/L76wYlAesWajzLi9C3yRNiRt3tJXlffyCUhpsrJFV10oK0m7ZRKAW8ltwFKzVH8g6j+kvpIthi74cmtZtQG1ZFpAvEgP92hwzCrRPLsROXJmx4INGCF1GkI0Krg3JbpQABO0rTo4+bPyEpeMF+3iMUA7RXfZJ8Kt9s7yAeVxKXTrc5ZPUmiSaNA3z0aPEPsLfSyRENjq/196QSQGg/7HmoFCAVhKsU7K1KUHG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/tEySYXQu4joJnJd8l8Dy0Y9QiTT4c/JR7NO7UTfV8=;
 b=Upnisrbl9ZF87DD5Qh9HiIujmXf4bq84hOx0gQuq00iK2NceAphHSrCxff3EuKAGlocwu4kNKdylHdRAF74pLR5LtJe53ClWIpAcHwi0gGdHHKEsNGTHSURHMifTlZw7qCD/uROD4Djb/yWjRVEEmcQpgK7O76R4tZdhAYOP7icDW9G883PVvcEg3i8SnIX67VJNdtqOxQZmWtYcoZZ1HXBwFwUh7vXB0rkhK/BByDMT4/3u2ITWG7NWXjYQyatCXtFRGalJ7VdTxrbpyNBJNpIUn7huoIPmUuXksX/koZ9INtAcmZRtgyCL0pzYJbXrVDsRBpwXMQoNaD/gos5UKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 185.67.228.71) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bachmann.info; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=bachmann.info; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/tEySYXQu4joJnJd8l8Dy0Y9QiTT4c/JR7NO7UTfV8=;
 b=OG3cRUTthpnMgal+hAuzkVO2R9iD5pmCmt0Yd/J5zauzhxsi1u/iNDGfOrx7DQhbNz2H/ZETCqTOWNQBIDxssDro1OC/7afxRVW1kQrMBloxhZiwp3ckZEdthyKTRoWREBAGGbqsPhe+UmSMB51vdmtI+9rQjsZ66nXWfeCaFyw=
Received: from AS9PR06CA0309.eurprd06.prod.outlook.com (2603:10a6:20b:45b::11)
 by AS4PR05MB9695.eurprd05.prod.outlook.com (2603:10a6:20b:4f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 12:06:23 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:20b:45b:cafe::59) by AS9PR06CA0309.outlook.office365.com
 (2603:10a6:20b:45b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 12:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 185.67.228.71) smtp.mailfrom=bachmann.info; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=bachmann.info;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 bachmann.info discourages use of 185.67.228.71 as permitted sender)
Received: from webmail.bachmann.info (185.67.228.71) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 12:06:23 +0000
Received: from ATFKPCLXPAFO.bachmann.at (10.204.124.241) by
 atfkex03.bachmann.at (10.10.10.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:06:22 +0200
From: Pascal FONTAIN <Pascal.FONTAIN@bachmann.info>
To: <linux-kernel@vger.kernel.org>, Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Sumit Semwal
	<sumit.semwal@linaro.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: <afd@ti.com>, Pascal Fontain <pascal.fontain@bachmann.info>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>
Subject: [PATCH v3 2/2] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
Date: Tue, 9 Apr 2024 14:06:05 +0200
Message-ID: <20240409120605.4138472-3-Pascal.FONTAIN@bachmann.info>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
References: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: atfkex03.bachmann.at (10.10.10.31) To atfkex03.bachmann.at
 (10.10.10.31)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019C:EE_|AS4PR05MB9695:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b44e58-01d2-4b5d-087b-08dc588d7993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3gjCNCT+ykSwwkLfH8LW9024Sz9SHzWl5xGx0v3FGp+m75183bLlA5dkVX1Cu5IvLYaZ2UvarZ0WyQK2OTnE8yDBJWVOAhCe5olQvdjIRa5LYTcLKXLoJD3ZjUTg173G1MFWEFo2VXapw6698IOWIa8byKKUoU4anhyZqBrSZ0n9fUL0fAtVM6WTwHOTsOtdcOHohhL2jfins0PCJFMFnqN7ssqLb0vENQ7WZi0y51VVjUX9voqaoeS3BkIH4l4fff0UiyRHxz0cpuds95fUe/75xKxd5h42SGTcRfQG3xYhWO9HnlOj6BMXHg0+8BLzxwXBE9RXiQ58Ml2rDgziidy1FHVz0RSuvNBaBxWM/5bZLSQ+xS0dUU+sRblcmTymb1P51WP6N5UHyRzslq9E/Q3kFWEzHN8U9+HEBxu6LifJcYViCXFEwXaKaCqpQepCid2dt/imsOF9prsbMU4ci85vV1L23EwCbsDObrUDyrtXNPd57MGPpN/S6DVWTJAon3PoNIMt7vKq9S/7/rXLJDop9ebioDLDFxpN7ufWoUMoM3aKzSyXjYnfp0xC9DwJfHahA4BCj8ICauxDQj7fm0sEs1/oj6YZ5VuaO25GqyJdDENAvlDRVAr9RAhMhmPeOw1J7GLtWgftraaWy1zMkpoeiuckeBZoS+5BNoEio+k6HMsxMEPx18Mbl+QgkYgRGnwVpBBbGkoYJ6d3QpbrA==
X-Forefront-Antispam-Report:
	CIP:185.67.228.71;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.bachmann.info;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: bachmann.info
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:06:23.2298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b44e58-01d2-4b5d-087b-08dc588d7993
X-MS-Exchange-CrossTenant-Id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e3bace4d-d2e7-4d8f-afb8-152509ee3f1a;Ip=[185.67.228.71];Helo=[webmail.bachmann.info]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR05MB9695

From: Andrew Davis <afd@ti.com>

This new export type exposes to userspace the SRAM area as a DMA-BUF
Heap,
this allows for allocations of DMA-BUFs that can be consumed by various
DMA-BUF supporting devices.

Signed-off-by: Andrew Davis <afd@ti.com>
Tested-by: Pascal Fontain <pascal.fontain@bachmann.info>
---
 drivers/misc/Kconfig         |   7 +
 drivers/misc/Makefile        |   1 +
 drivers/misc/sram-dma-heap.c | 246 +++++++++++++++++++++++++++++++++++
 drivers/misc/sram.c          |   6 +
 drivers/misc/sram.h          |  16 +++
 5 files changed, 276 insertions(+)
 create mode 100644 drivers/misc/sram-dma-heap.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 9e4ad4d61f06..e6674e913168 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -448,6 +448,13 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config SRAM_DMA_HEAP
+	bool "Export on-chip SRAM pools using DMA-Heaps"
+	depends on DMABUF_HEAPS && SRAM
+	help
+	  This driver allows the export of on-chip SRAM marked as both pool
+	  and exportable to userspace using the DMA-Heaps interface.
+
 config DW_XDATA_PCIE
 	depends on PCI
 	tristate "Synopsys DesignWare xData PCIe driver"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index cdc6405584e3..63effdde5163 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
 obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
+obj-$(CONFIG_SRAM_DMA_HEAP)	+= sram-dma-heap.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
diff --git a/drivers/misc/sram-dma-heap.c b/drivers/misc/sram-dma-heap.c
new file mode 100644
index 000000000000..e5a0bafe8cb9
--- /dev/null
+++ b/drivers/misc/sram-dma-heap.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SRAM DMA-Heap userspace exporter
+ *
+ * Copyright (C) 2019-2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Andrew Davis <afd@ti.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/genalloc.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+
+#include "sram.h"
+
+struct sram_dma_heap {
+	struct dma_heap *heap;
+	struct gen_pool *pool;
+};
+
+struct sram_dma_heap_buffer {
+	struct gen_pool *pool;
+	struct list_head attachments;
+	struct mutex attachments_lock;
+	unsigned long len;
+	void *vaddr;
+	phys_addr_t paddr;
+};
+
+struct dma_heap_attachment {
+	struct device *dev;
+	struct sg_table *table;
+	struct list_head list;
+};
+
+static int dma_heap_attach(struct dma_buf *dmabuf,
+			   struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heap_attachment *a;
+	struct sg_table *table;
+
+	a = kzalloc(sizeof(*a), GFP_KERNEL);
+	if (!a)
+		return -ENOMEM;
+
+	table = kmalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		kfree(a);
+		return -ENOMEM;
+	}
+	if (sg_alloc_table(table, 1, GFP_KERNEL)) {
+		kfree(table);
+		kfree(a);
+		return -ENOMEM;
+	}
+	sg_set_page(table->sgl, pfn_to_page(PFN_DOWN(buffer->paddr)), buffer->len, 0);
+
+	a->table = table;
+	a->dev = attachment->dev;
+	INIT_LIST_HEAD(&a->list);
+
+	attachment->priv = a;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_add(&a->list, &buffer->attachments);
+	mutex_unlock(&buffer->attachments_lock);
+
+	return 0;
+}
+
+static void dma_heap_detatch(struct dma_buf *dmabuf,
+			     struct dma_buf_attachment *attachment)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	struct dma_heap_attachment *a = attachment->priv;
+
+	mutex_lock(&buffer->attachments_lock);
+	list_del(&a->list);
+	mutex_unlock(&buffer->attachments_lock);
+
+	sg_free_table(a->table);
+	kfree(a->table);
+	kfree(a);
+}
+
+static struct sg_table *dma_heap_map_dma_buf(struct dma_buf_attachment *attachment,
+					     enum dma_data_direction direction)
+{
+	struct dma_heap_attachment *a = attachment->priv;
+	struct sg_table *table = a->table;
+
+	/*
+	 * As this heap is backed by uncached SRAM memory we do not need to
+	 * perform any sync operations on the buffer before allowing device
+	 * domain access. For this reason we use SKIP_CPU_SYNC and also do
+	 * not use or provide begin/end_cpu_access() dma-buf functions.
+	 */
+	if (!dma_map_sg_attrs(attachment->dev, table->sgl, table->nents,
+			      direction, DMA_ATTR_SKIP_CPU_SYNC))
+		return ERR_PTR(-ENOMEM);
+
+	return table;
+}
+
+static void dma_heap_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				   struct sg_table *table,
+				   enum dma_data_direction direction)
+{
+	dma_unmap_sg_attrs(attachment->dev, table->sgl, table->nents,
+			   direction, DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void dma_heap_dma_buf_release(struct dma_buf *dmabuf)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
+	kfree(buffer);
+}
+
+static int dma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+	int ret;
+
+	/* SRAM mappings are not cached */
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+
+	ret = vm_iomap_memory(vma, buffer->paddr, buffer->len);
+	if (ret)
+		pr_err("Could not map buffer to userspace\n");
+
+	return ret;
+}
+
+static int dma_heap_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
+{
+	struct sram_dma_heap_buffer *buffer = dmabuf->priv;
+
+	iosys_map_set_vaddr(map, buffer->vaddr);
+
+	return 0;
+}
+
+static const struct dma_buf_ops sram_dma_heap_buf_ops = {
+	.attach = dma_heap_attach,
+	.detach = dma_heap_detatch,
+	.map_dma_buf = dma_heap_map_dma_buf,
+	.unmap_dma_buf = dma_heap_unmap_dma_buf,
+	.release = dma_heap_dma_buf_release,
+	.mmap = dma_heap_mmap,
+	.vmap = dma_heap_vmap,
+};
+
+static struct dma_buf *sram_dma_heap_allocate(struct dma_heap *heap,
+					      unsigned long len,
+					      unsigned long fd_flags,
+					      unsigned long heap_flags)
+{
+	struct sram_dma_heap *sram_dma_heap = dma_heap_get_drvdata(heap);
+	struct sram_dma_heap_buffer *buffer;
+
+	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
+	struct dma_buf *dmabuf;
+	int ret;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return ERR_PTR(-ENOMEM);
+	buffer->pool = sram_dma_heap->pool;
+	INIT_LIST_HEAD(&buffer->attachments);
+	mutex_init(&buffer->attachments_lock);
+	buffer->len = len;
+
+	buffer->vaddr = (void *)gen_pool_alloc(buffer->pool, buffer->len);
+	if (!buffer->vaddr) {
+		ret = -ENOMEM;
+		goto free_buffer;
+	}
+
+	buffer->paddr = gen_pool_virt_to_phys(buffer->pool, (unsigned long)buffer->vaddr);
+	if (buffer->paddr == -1) {
+		ret = -ENOMEM;
+		goto free_pool;
+	}
+
+	/* create the dmabuf */
+	exp_info.exp_name = dma_heap_get_name(heap);
+	exp_info.ops = &sram_dma_heap_buf_ops;
+	exp_info.size = buffer->len;
+	exp_info.flags = fd_flags;
+	exp_info.priv = buffer;
+	dmabuf = dma_buf_export(&exp_info);
+	if (IS_ERR(dmabuf)) {
+		ret = PTR_ERR(dmabuf);
+		goto free_pool;
+	}
+
+	return dmabuf;
+
+free_pool:
+	gen_pool_free(buffer->pool, (unsigned long)buffer->vaddr, buffer->len);
+free_buffer:
+	kfree(buffer);
+
+	return ERR_PTR(ret);
+}
+
+static struct dma_heap_ops sram_dma_heap_ops = {
+	.allocate = sram_dma_heap_allocate,
+};
+
+int sram_add_dma_heap(struct sram_dev *sram,
+		      struct sram_reserve *block,
+		      phys_addr_t start,
+		      struct sram_partition *part)
+{
+	struct sram_dma_heap *sram_dma_heap;
+	struct dma_heap_export_info exp_info;
+
+	dev_info(sram->dev, "Exporting SRAM Heap '%s'\n", block->label);
+
+	sram_dma_heap = kzalloc(sizeof(*sram_dma_heap), GFP_KERNEL);
+	if (!sram_dma_heap)
+		return -ENOMEM;
+	sram_dma_heap->pool = part->pool;
+
+	exp_info.name = kasprintf(GFP_KERNEL, "sram_%s", block->label);
+	exp_info.ops = &sram_dma_heap_ops;
+	exp_info.priv = sram_dma_heap;
+	sram_dma_heap->heap = dma_heap_add(&exp_info);
+	if (IS_ERR(sram_dma_heap->heap)) {
+		int ret = PTR_ERR(sram_dma_heap->heap);
+
+		kfree(sram_dma_heap);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 632f90d9bcea..643c77598beb 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -120,6 +120,12 @@ static int sram_add_partition(struct sram_dev *sram, struct sram_reserve *block,
 		ret = sram_add_pool(sram, block, start, part);
 		if (ret)
 			return ret;
+
+		if (block->export) {
+			ret = sram_add_dma_heap(sram, block, start, part);
+			if (ret)
+				return ret;
+		}
 	}
 	if (block->export) {
 		ret = sram_add_export(sram, block, start, part);
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
index 397205b8bf6f..062bdd25fa06 100644
--- a/drivers/misc/sram.h
+++ b/drivers/misc/sram.h
@@ -60,4 +60,20 @@ static inline int sram_add_protect_exec(struct sram_partition *part)
 	return -ENODEV;
 }
 #endif /* CONFIG_SRAM_EXEC */
+
+#ifdef CONFIG_SRAM_DMA_HEAP
+int sram_add_dma_heap(struct sram_dev *sram,
+		      struct sram_reserve *block,
+		      phys_addr_t start,
+		      struct sram_partition *part);
+#else
+static inline int sram_add_dma_heap(struct sram_dev *sram,
+				    struct sram_reserve *block,
+				    phys_addr_t start,
+				    struct sram_partition *part)
+{
+	return 0;
+}
+#endif /* CONFIG_SRAM_DMA_HEAP */
+
 #endif /* __SRAM_H */
-- 
2.39.2


