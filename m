Return-Path: <linux-kernel+bounces-101280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD0387A4FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6971C21A74
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6058224E0;
	Wed, 13 Mar 2024 09:28:12 +0000 (UTC)
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43525224CF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710322092; cv=none; b=N2V4UQsk8f2OJlBlXoKNr5f/yRtvKRHY5wIJ0Iqu72ZIv1HiBSuSD0zmwRvIO6CXntW6uaSiSJ0zof3G8b+Hh3R6XhPi2+s7MJ3/gNtC+8t22YdvNgnIqTWbGyWUtJKBTcm1HMY4UrHOuDXRcOrWIPwz+l3i+oWxA9IUlf1UJIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710322092; c=relaxed/simple;
	bh=gNeZqbGr3flsGdl/kSPKy5i6Yu8y00Ei2ZYyz38s+QI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ph29zcvYl2F/khtPA8eERTX6MOSsFL5tGMKw5yROLa/m/ceNuUnkFWjvNXTwPLlbJokUxbkfhf+dv399BhtLCGaGzUoSIy98GsGOZoE6j0cvMwag8Y9MKOLkF19CFutRIx4kAUBBhLa2N4/ziXMFZFAG0I/eCgDmqy78OfxUcQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4TvlC70HL3z9xyNh
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:12:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 38C79140113
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:28:06 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.214.126])
	by APP1 (Coremail) with SMTP id LxC2BwC3rxiccfFlpH4_BA--.24260S2;
	Wed, 13 Mar 2024 10:28:05 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org (open list),
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	Will Deacon <will@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr@tesarici.cz>
Subject: [PATCH 1/1] swiotlb: add a KUnit test suite
Date: Wed, 13 Mar 2024 10:27:40 +0100
Message-Id: <20240313092740.192-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwC3rxiccfFlpH4_BA--.24260S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr1Uur1xWFWkXr1kJr4ruFg_yoW8Xr1DWo
	W3Ww17J34fJry7Gr95Aa90gFW3Zw4DtF45Jw4Fvr47Xw1UtrnFgr47Ka15Jrn8Kr18K3yx
	ZF98Za43Z3yIyr1xn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYy7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWU
	JVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyU
	JVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x0JU2fOwUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

Add unit tests to help avoid regressions in the SWIOTLB code.

These features are covered by the test suite:

* basic functionality (map, sync)
* alignment based on mapping size
* alignment based on min_align_mask
* explicit alignment with alloc_align_mask
* combination of alignment constraints

Select CONFIG_SWIOTLB rather than depend on it, because it allows to run
the test with UML (default KUnit target).

Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
---
 kernel/dma/Kconfig        |  13 ++
 kernel/dma/Makefile       |   1 +
 kernel/dma/swiotlb_test.c | 413 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 kernel/dma/swiotlb_test.c

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d62f5957f36b..44c62faa8d89 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -103,6 +103,19 @@ config SWIOTLB_DYNAMIC
 
 	  If unsure, say N.
 
+config SWIOTLB_KUNIT_TEST
+	tristate "Unit tests for software IO TLB" if !KUNIT_ALL_TESTS
+	select SWIOTLB
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build unit tests for software IO TLB.
+
+	  For more information on KUnit and unit tests in general, please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config DMA_BOUNCE_UNALIGNED_KMALLOC
 	bool
 	depends on SWIOTLB
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 21926e46ef4f..bfb130020219 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
+obj-$(CONFIG_SWIOTLB_KUNIT_TEST)	+= swiotlb_test.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_MMU)			+= remap.o
 obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
diff --git a/kernel/dma/swiotlb_test.c b/kernel/dma/swiotlb_test.c
new file mode 100644
index 000000000000..46e4d8055ef5
--- /dev/null
+++ b/kernel/dma/swiotlb_test.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ */
+
+#include <kunit/test.h>
+#include <kunit/device.h>
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/kdev_t.h>
+#include <linux/swiotlb.h>
+
+/* Alignment check repeat count. */
+#define NUM_CHECK_ALIGNED	5
+
+/* Offset of mapped data inside the allocated buffer. */
+#define MAP_OFF	128
+
+#define PASS	0x600d600d
+#define FAIL	0xbad00bad
+
+static struct {
+	unsigned char pad1[MAP_OFF];
+	unsigned long value;
+	unsigned char pad2[PAGE_SIZE];
+} test_data __page_aligned_bss;
+
+/**************************************************************
+ * Various helper functions.
+ */
+
+static int swiotlb_suite_init(struct kunit_suite *suite)
+{
+	if (is_swiotlb_allocated())
+		return 0;
+
+	return swiotlb_init_late(swiotlb_size_or_default(), GFP_KERNEL, NULL);
+}
+
+static int swiotlb_drv_probe(struct device *dev)
+{
+	dev->dma_parms = devm_kzalloc(dev, sizeof(*dev->dma_parms),
+				      GFP_KERNEL);
+	if (!dev->dma_parms)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int swiotlb_test_init(struct kunit *test)
+{
+	struct device_driver *driver;
+
+	driver = kunit_driver_create(test, "swiotlb_driver");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, driver);
+	driver->probe = swiotlb_drv_probe;
+
+	test->priv = driver;
+	return 0;
+}
+
+/**
+ * test_device() - get a dummy device for testing
+ * @test:  KUnit test instance.
+ *
+ * Allocate a device suitable for SWIOTLB.
+ */
+static struct device *test_device(struct kunit *test)
+{
+	struct device_driver *driver = test->priv;
+	struct device *dev;
+	u64 mask;
+
+	dev = kunit_device_register_with_driver(test, "swiotlb", driver);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	mask = DMA_BIT_MASK(64);
+	KUNIT_ASSERT_EQ(test, dma_coerce_mask_and_coherent(dev, mask), 0);
+
+	return dev;
+}
+
+/**
+ * check_aligned() - check that bounce buffers are aligned
+ * @test:   KUnit test instance.
+ * @dev:    Device.
+ * @buf:    Pointer to the original buffer.
+ * @size:   Size of the original buffer.
+ * @align:  Allocation alignment (in bytes).
+ * @check_bits:
+ *          Number of low bits checked in the swiotlb address.
+ * @preserve_bits:
+ *          Number of low bits preserved from the original address.
+ *
+ * Mapping is repeated a few times, and a small buffer is allocated after
+ * each attempt. This should cover the case when the first free slot merely
+ * happens to be suitably aligned.
+ */
+static void check_aligned(struct kunit *test, struct device *dev,
+			  void *buf, size_t size, unsigned long align,
+			  int check_bits, int preserve_bits)
+{
+	dma_addr_t tlb_addr[NUM_CHECK_ALIGNED];
+	dma_addr_t pad_addr[NUM_CHECK_ALIGNED];
+	u64 check_mask, check_val;
+	phys_addr_t phys_addr;
+	char *orig, *tlb;
+	int i;
+
+	orig = (char *)buf;
+	phys_addr = virt_to_phys(buf);
+	check_mask = DMA_BIT_MASK(check_bits);
+	check_val = phys_addr & DMA_BIT_MASK(preserve_bits);
+
+	for (i = 0; i < NUM_CHECK_ALIGNED; ++i) {
+		tlb_addr[i] =
+			swiotlb_tbl_map_single(dev, phys_addr, size, size,
+					       align - 1, DMA_TO_DEVICE, 0);
+		KUNIT_ASSERT_NE(test, tlb_addr[i], DMA_MAPPING_ERROR);
+		KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr[i]));
+		KUNIT_EXPECT_EQ(test, tlb_addr[i] & check_mask, check_val);
+
+		/* Check sync in both directions. */
+		tlb = phys_to_virt(tlb_addr[i]);
+		KUNIT_EXPECT_EQ(test, *orig, *tlb);
+		*orig ^= 0xff;
+		swiotlb_sync_single_for_device(dev, tlb_addr[i], sizeof(*orig),
+					       DMA_TO_DEVICE);
+		KUNIT_EXPECT_EQ(test, *orig, *tlb);
+		*tlb ^= 0xff;
+		swiotlb_sync_single_for_cpu(dev, tlb_addr[i], sizeof(*orig),
+					    DMA_FROM_DEVICE);
+		KUNIT_EXPECT_EQ(test, *orig, *tlb);
+
+		pad_addr[i] = swiotlb_map(dev, phys_addr, sizeof(long),
+					  DMA_TO_DEVICE, 0);
+		KUNIT_ASSERT_NE(test, pad_addr[i], DMA_MAPPING_ERROR);
+	}
+
+	for (i = 0; i < NUM_CHECK_ALIGNED; ++i) {
+		swiotlb_tbl_unmap_single(dev, pad_addr[i], sizeof(long),
+					 DMA_FROM_DEVICE, 0);
+		swiotlb_tbl_unmap_single(dev, tlb_addr[i], size,
+					 DMA_FROM_DEVICE, 0);
+	}
+}
+
+/**************************************************************
+ * Map a DMA buffer.
+ *
+ * Test that a DMA buffer can be mapped and synced.
+ */
+
+static void swiotlb_test_map(struct kunit *test)
+{
+	struct device *dev = test_device(test);
+	phys_addr_t phys_addr;
+	dma_addr_t tlb_addr;
+	unsigned long *tlb;
+
+	phys_addr = virt_to_phys(&test_data.value);
+	test_data.value = PASS;
+	tlb_addr = swiotlb_map(dev, phys_addr, sizeof(unsigned long),
+			       DMA_TO_DEVICE, 0);
+	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
+	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
+	tlb = phys_to_virt(tlb_addr);
+
+	/* Bounce buffer is initialized to original buffer. */
+	KUNIT_EXPECT_EQ(test, *tlb, PASS);
+
+	/* Bounce buffer is updated on sync to device. */
+	test_data.value = PASS + 1;
+	swiotlb_sync_single_for_device(dev, tlb_addr, sizeof(unsigned long),
+				       DMA_TO_DEVICE);
+	KUNIT_EXPECT_EQ(test, *tlb, PASS + 1);
+
+	/* Original buffer is updated on sync from device. */
+	*tlb = PASS + 2;
+	swiotlb_sync_single_for_cpu(dev, tlb_addr, sizeof(unsigned long),
+				    DMA_FROM_DEVICE);
+	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 2);
+
+	/* Original buffer is also updated on unmap. */
+	*tlb = PASS + 3;
+	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned long),
+				 DMA_FROM_DEVICE, 0);
+	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 3);
+}
+
+/**************************************************************
+ * Map DMA buffer as bi-directional.
+ *
+ * Test that buffer is synced with DMA_BIDIRECTIONAL.
+ */
+
+static void swiotlb_test_bidirectional(struct kunit *test)
+{
+	struct device *dev = test_device(test);
+	phys_addr_t phys_addr;
+	dma_addr_t tlb_addr;
+	unsigned long *tlb;
+
+	test_data.value = PASS;
+	phys_addr = virt_to_phys(&test_data.value);
+	tlb_addr = swiotlb_map(dev, phys_addr, sizeof(unsigned long),
+			       DMA_BIDIRECTIONAL, 0);
+	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
+	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
+	tlb = phys_to_virt(tlb_addr);
+
+	/* Bounce buffer is initialized to original buffer. */
+	KUNIT_EXPECT_EQ(test, *tlb, PASS);
+
+	/* Original buffer is updated on unmap. */
+	*tlb = PASS + 1;
+	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned long),
+				 DMA_BIDIRECTIONAL, 0);
+	KUNIT_EXPECT_EQ(test, test_data.value, PASS + 1);
+}
+
+/**************************************************************
+ * Skip sync on unmap.
+ *
+ * Test that sync does not happen with DMA_ATTR_SKIP_CPU_SYNC.
+ * On swiotlb_map(), this flag skips only sync for non-coherent
+ * DMA; the bounce buffer itself is always synced to the
+ * original buffer.
+ */
+
+static void swiotlb_test_skip_sync(struct kunit *test)
+{
+	struct device *dev = test_device(test);
+	phys_addr_t phys_addr;
+	dma_addr_t tlb_addr;
+	unsigned long *tlb;
+
+	test_data.value = PASS;
+	phys_addr = virt_to_phys(&test_data.value);
+	tlb_addr = swiotlb_map(dev, phys_addr, sizeof(unsigned long),
+			       DMA_TO_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	KUNIT_ASSERT_NE(test, tlb_addr, DMA_MAPPING_ERROR);
+	KUNIT_EXPECT_TRUE(test, is_swiotlb_buffer(dev, tlb_addr));
+	tlb = phys_to_virt(tlb_addr);
+
+	/* Bounce buffer is initialized to original buffer anyway. */
+	KUNIT_EXPECT_EQ(test, *tlb, PASS);
+
+	/* Original buffer is not updated on unmap. */
+	*tlb = FAIL;
+	swiotlb_tbl_unmap_single(dev, tlb_addr, sizeof(unsigned long),
+				 DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
+	KUNIT_EXPECT_EQ(test, test_data.value, PASS);
+}
+
+/**************************************************************
+ * Historical page alignment.
+ *
+ * Test that mappings of at least PAGE_SIZE get a page-aligned
+ * DMA address.
+ */
+
+static void swiotlb_test_page_align(struct kunit *test)
+{
+	struct device *dev = test_device(test);
+
+	/* Bounce buffer is page-aligned. */
+	check_aligned(test, dev, &test_data, sizeof(test_data), 1,
+		      PAGE_SHIFT, 0);
+
+	/* Even if the original buffer is not page-aligned. */
+	check_aligned(test, dev, &test_data.value, PAGE_SIZE, 1,
+		      PAGE_SHIFT, 0);
+}
+
+/**************************************************************
+ * Device physical address alignment.
+ *
+ * Test that physical address low bits are preserved.
+ */
+
+static void check_min_align(struct kunit *test, int bits)
+{
+	u64 min_align_mask = DMA_BIT_MASK(bits);
+	struct device *dev = test_device(test);
+	unsigned long vaddr;
+	void *ptr;
+
+	KUNIT_ASSERT_EQ(test, dma_set_min_align_mask(dev, min_align_mask), 0);
+
+	vaddr = devm_get_free_pages(dev, GFP_KERNEL,
+				    bits > PAGE_SHIFT ? bits - PAGE_SHIFT : 0);
+	KUNIT_ASSERT_NE(test, vaddr, 0);
+
+	/* Check low bits */
+	ptr = (void *)vaddr + MAP_OFF;
+	check_aligned(test, dev, ptr, sizeof(long), 1, bits, bits);
+
+	/* Check high bits */
+	ptr = (void *)vaddr + (1UL << bits) - MAP_OFF - sizeof(long);
+	check_aligned(test, dev, ptr, sizeof(long), 1, bits, bits);
+
+	kunit_device_unregister(test, dev);
+}
+
+static void swiotlb_test_min_align(struct kunit *test)
+{
+	check_min_align(test, 12);
+	check_min_align(test, PAGE_SHIFT);
+	check_min_align(test, 16);
+}
+
+/**************************************************************
+ * Explicit allocation alignment.
+ *
+ * Test that the bounce buffer is aligned to an explicit value
+ * regardless of allocation size.
+ */
+
+static void check_alloc_align(struct kunit *test, int bits)
+{
+	struct device *dev = test_device(test);
+	void *base, *ptr;
+	size_t size;
+
+	size = 1UL << bits;
+	base = devm_kmalloc(dev, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base);
+
+	/* Check low bits */
+	ptr = base + MAP_OFF;
+	check_aligned(test, dev, ptr, sizeof(long), size, bits, 0);
+
+	/* Check high bits */
+	ptr = base + size - MAP_OFF - sizeof(long);
+	check_aligned(test, dev, ptr, sizeof(long), size, bits, 0);
+
+	kunit_device_unregister(test, dev);
+}
+
+static void swiotlb_test_alloc_align(struct kunit *test)
+{
+	check_alloc_align(test, 12);
+	check_alloc_align(test, 14);
+}
+
+/**************************************************************
+ * Both allocation and device physical address alignment.
+ *
+ * Test that the bounce buffer is aligned to an explicit value
+ * regardless of allocation size and it also preserves physical
+ * address low bits.
+ */
+
+static void check_both_align(struct kunit *test, int min_align_bits,
+			     int alloc_align_bits)
+{
+	u64 min_align_mask = DMA_BIT_MASK(min_align_bits);
+	struct device *dev = test_device(test);
+	void *base, *ptr;
+	size_t size;
+
+	KUNIT_ASSERT_EQ(test, dma_set_min_align_mask(dev, min_align_mask), 0);
+
+	size = 1UL << max(min_align_bits, alloc_align_bits);
+	base = devm_kmalloc(dev, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base);
+
+	/* Check low bits */
+	ptr = base + MAP_OFF;
+	check_aligned(test, dev, ptr, sizeof(long), size,
+		      min_align_bits, min_align_bits);
+
+	/* Check high bits */
+	ptr = base + size - MAP_OFF - sizeof(long);
+	check_aligned(test, dev, ptr, sizeof(long), size,
+		      min_align_bits, min_align_bits);
+
+	kunit_device_unregister(test, dev);
+}
+
+static void swiotlb_test_both_align(struct kunit *test)
+{
+	check_both_align(test, 12, 12);
+	check_both_align(test, 12, 16);
+	check_both_align(test, 14, 16);
+}
+
+/**************************************************************
+ * Test suite metadata.
+ */
+
+static struct kunit_case swiotlb_test_cases[] = {
+	KUNIT_CASE(swiotlb_test_map),
+	KUNIT_CASE(swiotlb_test_bidirectional),
+	KUNIT_CASE(swiotlb_test_skip_sync),
+	KUNIT_CASE(swiotlb_test_page_align),
+	KUNIT_CASE(swiotlb_test_min_align),
+	KUNIT_CASE(swiotlb_test_alloc_align),
+	KUNIT_CASE(swiotlb_test_both_align),
+	{}
+};
+
+static struct kunit_suite swiotlb_test_suite = {
+	.name = "swiotlb",
+	.suite_init = swiotlb_suite_init,
+	.init = swiotlb_test_init,
+	.test_cases = swiotlb_test_cases,
+};
+
+kunit_test_suites(&swiotlb_test_suite);
-- 
2.34.1


