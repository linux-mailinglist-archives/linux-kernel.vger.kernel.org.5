Return-Path: <linux-kernel+bounces-20442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97058827F05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173801F24626
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84C8F60;
	Tue,  9 Jan 2024 07:05:15 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4BB645
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 07:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4T8MPV6XL9zbbd8;
	Tue,  9 Jan 2024 15:04:46 +0800 (CST)
Received: from kwepemm600020.china.huawei.com (unknown [7.193.23.147])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F1CE14041B;
	Tue,  9 Jan 2024 15:05:03 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 15:05:02 +0800
From: Peng Zhang <zhangpeng362@huawei.com>
To: <hch@lst.de>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<petr.tesarik1@huawei-partners.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>,
	<zhangpeng362@huawei.com>
Subject: [PATCH] swiotlb: add debugfs to track swiotlb transient pool usage
Date: Tue, 9 Jan 2024 15:04:56 +0800
Message-ID: <20240109070456.3999739-1-zhangpeng362@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600020.china.huawei.com (7.193.23.147)

From: ZhangPeng <zhangpeng362@huawei.com>

Introduce a new debugfs interface io_tlb_transient_nslabs. The device
driver can create a new swiotlb transient memory pool once default
memory pool is full. To export the swiotlb transient memory pool usage
via debugfs would help the user estimate the size of transient swiotlb
memory pool or analyze device driver memory leak issue.

Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
---
 include/linux/swiotlb.h |  3 +++
 kernel/dma/swiotlb.c    | 46 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ecde0312dd52..ea23097e351f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -120,6 +120,8 @@ struct io_tlb_pool {
  *		debugfs.
  * @used_hiwater: The high water mark for total_used.  Used only for reporting
  *		in debugfs.
+ * @transient_nslabs: The total number of slots in all transient pools that
+ *		are currently used across all areas.
  */
 struct io_tlb_mem {
 	struct io_tlb_pool defpool;
@@ -137,6 +139,7 @@ struct io_tlb_mem {
 #ifdef CONFIG_DEBUG_FS
 	atomic_long_t total_used;
 	atomic_long_t used_hiwater;
+	atomic_long_t transient_nslabs;
 #endif
 };
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b079a9a8e087..77974cea3e69 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -956,6 +956,28 @@ static void dec_used(struct io_tlb_mem *mem, unsigned int nslots)
 }
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+#ifdef CONFIG_DEBUG_FS
+static void inc_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
+{
+	atomic_long_add(nslots, &mem->transient_nslabs);
+}
+
+static void dec_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
+{
+	atomic_long_sub(nslots, &mem->transient_nslabs);
+}
+
+#else /* !CONFIG_DEBUG_FS */
+static void inc_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
+{
+}
+static void dec_transient_used(struct io_tlb_mem *mem, unsigned int nslots)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+#endif /* CONFIG_SWIOTLB_DYNAMIC */
+
 /**
  * swiotlb_search_pool_area() - search one memory area in one pool
  * @dev:	Device which maps the buffer.
@@ -1170,6 +1192,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	spin_lock_irqsave(&dev->dma_io_tlb_lock, flags);
 	list_add_rcu(&pool->node, &dev->dma_io_tlb_pools);
 	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
+	inc_transient_used(mem, pool->nslabs);
 
 found:
 	WRITE_ONCE(dev->dma_uses_io_tlb, true);
@@ -1415,6 +1438,7 @@ static bool swiotlb_del_transient(struct device *dev, phys_addr_t tlb_addr)
 
 	dec_used(dev->dma_io_tlb_mem, pool->nslabs);
 	swiotlb_del_pool(dev, pool);
+	dec_transient_used(dev->dma_io_tlb_mem, pool->nslabs);
 	return true;
 }
 
@@ -1557,6 +1581,23 @@ phys_addr_t default_swiotlb_limit(void)
 }
 
 #ifdef CONFIG_DEBUG_FS
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+static unsigned long mem_transient_used(struct io_tlb_mem *mem)
+{
+	return atomic_long_read(&mem->transient_nslabs);
+}
+
+static int io_tlb_transient_used_get(void *data, u64 *val)
+{
+	struct io_tlb_mem *mem = data;
+
+	*val = mem_transient_used(mem);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_io_tlb_transient_used, io_tlb_transient_used_get,
+			 NULL, "%llu\n");
+#endif /* CONFIG_SWIOTLB_DYNAMIC */
 
 static int io_tlb_used_get(void *data, u64 *val)
 {
@@ -1605,6 +1646,11 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem,
 			&fops_io_tlb_used);
 	debugfs_create_file("io_tlb_used_hiwater", 0600, mem->debugfs, mem,
 			&fops_io_tlb_hiwater);
+#ifdef CONFIG_SWIOTLB_DYNAMIC
+	atomic_long_set(&mem->transient_nslabs, 0);
+	debugfs_create_file("io_tlb_transient_nslabs", 0400, mem->debugfs,
+			    mem, &fops_io_tlb_transient_used);
+#endif
 }
 
 static int __init swiotlb_create_default_debugfs(void)
-- 
2.25.1


