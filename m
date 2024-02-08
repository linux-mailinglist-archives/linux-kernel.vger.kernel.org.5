Return-Path: <linux-kernel+bounces-58284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBAA84E40C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDAA628B22B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979297B3F7;
	Thu,  8 Feb 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXxxQA9n"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C23E7B3DB
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406096; cv=none; b=LQsIe+DDCfGrnsAGlousKVBKZfnE1EyfpENbmLP2FswqpBmIjZ8M+e1xeyy1VYLzow7dsD9PjAy+yHLrsXAsByPSc8EpZfldSUZGQRYeYGkg98NV927P/2LKXHrOZBC2LZu2eyfKOs9YnCi7OicMh/SC2HFcsQz0HNSuKdGZM9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406096; c=relaxed/simple;
	bh=+xzuVSPNcfqZpWPZWSPx0KpSUax/mWHJAZ2oIVWTTRQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NMz9fodzUp5fdzC9vE96OoazCSpEP99ZiAg7BBcPp15WceySZF7Fy3qPi+DjG9VMv0MlPQg7AYY9RTbgHXD89OchFqkZz8nbWJZLYm3rUg/3Nzw1GjzJy+w80ap2PLGQBW+F3hfHNdtd2AHpFn/DV6/cqBaO/jnsnJ+NaCwS8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXxxQA9n; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604829882fbso8998247b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707406094; x=1708010894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4lN8ZSpv/Qf9hEb4poLR5IQ8TShLqeRG5AmsS5NPlec=;
        b=zXxxQA9nFq3StXLBA3+q/cgigfeVWVvPA/kfysT5pnmjPFwsMYxS+iG4wQdvqCVYBr
         zFEo5MXWEN07lFaf0ikntQfnRtoykbMjfDsdAY1wHJgSB6AilOvPlTBBx5AAGSkS2Vez
         c/zARt6J93pKPvMLoawoHYF0RKYajYYflVDxiLHjZ7YOIbo4rcixSyldhASoZzyrnxXj
         LXNA+1X/cu++QveWLtoSYFJhVhT7ViBNSa/CXRmerNQ4AxR1egzFyGHgje76Z+21LWyV
         q8b8AL62XNTKEphdIkqayL6DU3rP87SwI4X4l8rxBtW6wcB/zB4hSeiyLkIF5wVo+MWL
         d8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707406094; x=1708010894;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lN8ZSpv/Qf9hEb4poLR5IQ8TShLqeRG5AmsS5NPlec=;
        b=Y5Sm4s5CSE+0z9r1NdK+0CW0I3R5UlCpypPu6smf5Lh1seGqeOHER2cSkTiJ6kxYQD
         G7Se/HhkQzOgoEioimBXfC03qGlf216rXxVLpXcsWPiZnzIblm0vcKrUPMMB5GfYb7ul
         StO7DZBg/jj+3kFUVqGvXniTbaeZmRJFNPKVNZNBIp61H44c59gWO4GmOL2bcC56zbWR
         PhDZHuyHsqiczPNHNB8cJ+laPWlysl+A8/BHWBrsWa+d/4d7HxhwpUZIqcdUAG0+9UT9
         kffP9EY7heTs1rGHpPAFze44OefdudtzJfEPdoqkvwZQCOT0177qXG3oOPGzKQsdDt62
         Az7A==
X-Gm-Message-State: AOJu0YxFbdhZrJZ60fKhfIk++P14OG9+pXBO98aHYgguczsFEPPsGrMZ
	b3JFd/hbagutACSdOe2GwvlyXY8anyfmIB8w38eP1EtvGiZ3XMPuhJlYpn4ILrT4yAZdfP7a56G
	uP0inxTkjij/b0A==
X-Google-Smtp-Source: AGHT+IHVUmyalJUCdZjLumECz5f9xJlVA1uZnP4NPy50JtvAQFP2+hD71xzoIMQJWXPH7V0bMrhOS//AsmQ0L38=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a05:6902:10c1:b0:dc2:2e5c:a21d with SMTP
 id w1-20020a05690210c100b00dc22e5ca21dmr750802ybu.6.1707406094054; Thu, 08
 Feb 2024 07:28:14 -0800 (PST)
Date: Thu,  8 Feb 2024 15:28:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208152808.3712149-1-howardyen@google.com>
Subject: [PATCH v3] dma-coherent: add support for multi coherent rmems per dev
From: Howard Yen <howardyen@google.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	rafael@kernel.org, broonie@kernel.org, james@equiv.tech, james.clark@arm.com, 
	masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for multiple coherent rmems per device. This patch replaces
original dma_mem with dma_mems list in device structure to store multiple
rmems.

These multiple rmems can be assigned to the device one by one by
of_reserved_mem_device_init_by_idx() with the memory-region
declaration in device tree as below and store the rmem to the dma_mems
list.

	device1@0 {
		...
		memory-region = <&reserved_mem0>, <&reserved_mem1>;
		...
	};

When driver tries to allocate memory from the rmems, looks for the first
available rmem and allocates the memory from this rmem.

Then if driver removed, of_reserved_mem_device_release() needs to be
invoked to release all the rmems assigned to the device.

Signed-off-by: Howard Yen <howardyen@google.com>
---
Changelog since v2:
(suggested by Andy Shevchenko <andriy.shevchenko@linux.intel.com>)
- Re-org the members of struct dma_coherent_mem to avoid additional
  pointer arithmetics and the holes inside the structure.
- Use consistent naming of return value.
- Re-write the dev checking statement to be more clear.

 drivers/base/core.c    |  3 ++
 include/linux/device.h |  5 +--
 kernel/dma/coherent.c  | 92 +++++++++++++++++++++++++++---------------
 3 files changed, 64 insertions(+), 36 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..d9af38d7b870 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3108,6 +3108,9 @@ void device_initialize(struct device *dev)
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
 	dev->dma_coherent = dma_default_coherent;
+#endif
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	INIT_LIST_HEAD(&dev->dma_mems);
 #endif
 	swiotlb_dev_init(dev);
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..5fa15e5adbdc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -648,7 +648,7 @@ struct device_physical_location {
  * @dma_parms:	A low level driver may set these to teach IOMMU code about
  * 		segment limitations.
  * @dma_pools:	Dma pools (if dma'ble device).
- * @dma_mem:	Internal for coherent mem override.
+ * @dma_mems:	Internal for coherent mems.
  * @cma_area:	Contiguous memory area for dma allocations
  * @dma_io_tlb_mem: Software IO TLB allocator.  Not for driver use.
  * @dma_io_tlb_pools:	List of transient swiotlb memory pools.
@@ -749,8 +749,7 @@ struct device {
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
 #ifdef CONFIG_DMA_DECLARE_COHERENT
-	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
-					     override */
+	struct list_head	dma_mems; /* Internal for coherent mems */
 #endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..f6748a3a5eb1 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -11,22 +11,16 @@
 #include <linux/dma-map-ops.h>
 
 struct dma_coherent_mem {
-	void		*virt_base;
-	dma_addr_t	device_base;
-	unsigned long	pfn_base;
-	int		size;
-	unsigned long	*bitmap;
-	spinlock_t	spinlock;
-	bool		use_dev_dma_pfn_offset;
+	struct list_head	node;
+	void			*virt_base;
+	dma_addr_t		device_base;
+	unsigned long		pfn_base;
+	int			size;
+	spinlock_t		spinlock;
+	unsigned long		*bitmap;
+	bool			use_dev_dma_pfn_offset;
 };
 
-static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
-{
-	if (dev && dev->dma_mem)
-		return dev->dma_mem;
-	return NULL;
-}
-
 static inline dma_addr_t dma_get_device_base(struct device *dev,
 					     struct dma_coherent_mem * mem)
 {
@@ -61,6 +55,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
 	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
+	INIT_LIST_HEAD(&dma_mem->node);
 	spin_lock_init(&dma_mem->spinlock);
 
 	return dma_mem;
@@ -90,10 +85,8 @@ static int dma_assign_coherent_memory(struct device *dev,
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->dma_mem)
-		return -EBUSY;
+	list_add_tail(&mem->node, &dev->dma_mems);
 
-	dev->dma_mem = mem;
 	return 0;
 }
 
@@ -118,23 +111,28 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size)
 {
 	struct dma_coherent_mem *mem;
-	int ret;
+	int retval;
 
 	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-	ret = dma_assign_coherent_memory(dev, mem);
-	if (ret)
+	retval = dma_assign_coherent_memory(dev, mem);
+	if (retval)
 		_dma_release_coherent_memory(mem);
-	return ret;
+	return retval;
 }
 
 void dma_release_coherent_memory(struct device *dev)
 {
-	if (dev) {
-		_dma_release_coherent_memory(dev->dma_mem);
-		dev->dma_mem = NULL;
+	struct dma_coherent_mem *mem_tmp, *q;
+
+	if (!dev)
+		return;
+
+	list_for_each_entry_safe(mem_tmp, q, &dev->dma_mems, node) {
+		list_del_init(&mem_tmp->node);
+		_dma_release_coherent_memory(mem_tmp);
 	}
 }
 
@@ -187,12 +185,17 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		dma_addr_t *dma_handle, void **ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp;
 
-	if (!mem)
+	if (list_empty(&dev->dma_mems))
 		return 0;
 
-	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
+	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
+		*ret = __dma_alloc_from_coherent(dev, mem_tmp, size, dma_handle);
+		if (*ret)
+			break;
+	}
+
 	return 1;
 }
 
@@ -226,9 +229,16 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
  */
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp;
+	int retval = 0;
+
+	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
+		retval = __dma_release_from_coherent(mem_tmp, order, vaddr);
+		if (retval == 1)
+			break;
+	}
 
-	return __dma_release_from_coherent(mem, order, vaddr);
+	return retval;
 }
 
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
@@ -271,9 +281,16 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			   void *vaddr, size_t size, int *ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp;
+	int retval = 0;
 
-	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
+	list_for_each_entry(mem_tmp, &dev->dma_mems, node) {
+		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
+		if (retval == 1)
+			break;
+	}
+
+	return retval;
 }
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
@@ -351,8 +368,17 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	if (dev)
-		dev->dma_mem = NULL;
+	struct dma_coherent_mem *mem_tmp, *q;
+
+	if (!dev)
+		return;
+
+	list_for_each_entry_safe(mem_tmp, q, &dev->dma_mems, node) {
+		if (mem_tmp == rmem->priv) {
+			list_del_init(&mem_tmp->node);
+			break;
+		}
+	}
 }
 
 static const struct reserved_mem_ops rmem_dma_ops = {
-- 
2.43.0.594.gd9cf4e227d-goog


