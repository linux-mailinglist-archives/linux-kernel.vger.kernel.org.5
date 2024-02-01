Return-Path: <linux-kernel+bounces-47887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7EA845428
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28774B2B8E5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F814D9F9;
	Thu,  1 Feb 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zAOErTCa"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349174D9E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780125; cv=none; b=VwR/6kVW4FCljBG8KNeBfwp1/bkXhKysMN/n/bskLvJamVUVCrV1wg42LL2FC7I7R/5/eAJjcufaAau8iSw/7sBsH+illBtAv9WHfh2mGfYonkWZCnORgDk+zfiD3Hux37H7xfT1iz9v80+IRgqsH1N65vUbxxrJEElPnlGLWEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780125; c=relaxed/simple;
	bh=Jxy0XWbWb/nIGgYtjM7GzjVLRuuPBPaYqN1Klw6CfqM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uKG4b12WltpaxdkbDU/g2iSV2nZHdN4MOib6aKiEwKhJAeCbmie0zIJmJhSGdVBMJEAO1QC7QwQwwWP3H5R/j9zUxf2odLjizyIEl39xGBn5ALKxfeGkXB4Fs+BgThTQ5B5ApeLo8Dk43hfnbeQDMEp2RX4e+9XlSWH6fyj/U5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zAOErTCa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--howardyen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26eed12so1084193276.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 01:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706780123; x=1707384923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVCHyyuWn0Tx2DLVfJKCMBpt+teKIiAvPgxfHY9hPE0=;
        b=zAOErTCaK4UA1WjvWW3iCydhF8RX5iX4fFoh6Ad7ih+bTghTT2U3plBCcJpvc1ApcP
         vkR1KFgeabXkhPp6dnZGJhrL5ic3Q5u6ylXmW7yAh7vF7mzu2Z1AXUqG0wRSK+9wTWWH
         PGOa5iUcE5nqnq5LwuUfQo951jNIx0lVxjK1mB7BJXD0eH5kIvfBqtY5g4VVjQA5+7xu
         hftbe0Eds9y05kGudLdFrbj/kIPdtvCXmdWLCQkhjQRWEidJQlplB5Bslzlpzi1dC6bE
         P9znuJbxk4PD2JWpi6H2G9NcOXi9xckncwfumPAKGC2L6KN7uVeeeM8gGdjNukjA3Vjg
         v1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780123; x=1707384923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVCHyyuWn0Tx2DLVfJKCMBpt+teKIiAvPgxfHY9hPE0=;
        b=Py97AH3/KsLJkcDKIRSkJkckWIkoLP0RBBi5CxBsO0boWtXhg+oAscKhaMSY8AprXU
         gxV4wEmWc/tQsblSc7OOtDelB6zHiPVQrGSrXmD4Rtm9lYMliX422MzpGqg51tAhcSuL
         mrWddJvAXaUvjmBIBUQpdChi+Ip+LpftUPE644IGe9+Lj3pswjyuy5nw0ZbctRn4APWd
         wW+BRy1IuiT8V285zKRAOMzKgaHhpC22TO4obsOZW5PWwbWR7O84noSzbbdz3wN9WmWt
         dHbdBp0HLRmIHkc9MRRm2v+sCTFdkd5oaBYvyZIeQpADLLbecQHCxLMyd1gTrNPaLLxa
         ulhw==
X-Gm-Message-State: AOJu0Yw3H4LmxXudpRoDzasM5v5bl2Ci0d2qh46dF3li4pVwrpDeX0v8
	RPI8vHd/Kxq1M4cFwBw62uSTL+7l6EENnNItX7n7hklIirbt5qGA2JrEW7mO2hjNRUFayK8e0si
	1i6PIF2yKKz9USQ==
X-Google-Smtp-Source: AGHT+IGBIccH2+bx2/z4pW2hln1Ej5XqEjzys8cPg/yPdxOeiTjk6VBw47Rbp/BUJpIbfmDrx/U0eGdPHPBWCyQ=
X-Received: from howardyen2.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:16f7])
 (user=howardyen job=sendgmr) by 2002:a05:6902:920:b0:dc2:26f6:fbc8 with SMTP
 id bu32-20020a056902092000b00dc226f6fbc8mr140303ybb.7.1706780123180; Thu, 01
 Feb 2024 01:35:23 -0800 (PST)
Date: Thu,  1 Feb 2024 09:35:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201093515.849873-1-howardyen@google.com>
Subject: [PATCH] dma-coherent: add support for multi coherent rmems per dev
From: Howard Yen <howardyen@google.com>
To: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	petr.tesarik.ext@huawei.com, rafael@kernel.org, broonie@kernel.org, 
	james@equiv.tech, james.clark@arm.com, masahiroy@kernel.org
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Howard Yen <howardyen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for multiple coherent rmems per device. This patch addes
dma_mem_list to device structure to store multiple rmems.

These multiple rmems can be assigned to the device one by one by
of_reserved_mem_device_init_by_idx() with the memory-region
declaration in device tree as below and store the rmem to the dma_mem_list.

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
 include/linux/device.h |  1 +
 kernel/dma/coherent.c  | 66 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..c8682ee507cf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -751,6 +751,7 @@ struct device {
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
+	struct list_head	dma_mem_list;
 #endif
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index ff5683a57f77..f31befd2e6f8 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -18,6 +18,7 @@ struct dma_coherent_mem {
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
 	bool		use_dev_dma_pfn_offset;
+	struct list_head	node;
 };
 
 static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
@@ -61,6 +62,7 @@ static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
 	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
+	INIT_LIST_HEAD(&dma_mem->node);
 	spin_lock_init(&dma_mem->spinlock);
 
 	return dma_mem;
@@ -90,10 +92,13 @@ static int dma_assign_coherent_memory(struct device *dev,
 	if (!dev)
 		return -ENODEV;
 
-	if (dev->dma_mem)
-		return -EBUSY;
+	if (!dev->dma_mem) {
+		dev->dma_mem = mem;
+		INIT_LIST_HEAD(&dev->dma_mem_list);
+	}
+
+	list_add_tail(&mem->node, &dev->dma_mem_list);
 
-	dev->dma_mem = mem;
 	return 0;
 }
 
@@ -187,12 +192,17 @@ static void *__dma_alloc_from_coherent(struct device *dev,
 int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 		dma_addr_t *dma_handle, void **ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
 
 	if (!mem)
 		return 0;
 
-	*ret = __dma_alloc_from_coherent(dev, mem, size, dma_handle);
+	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
+		*ret = __dma_alloc_from_coherent(dev, mem_tmp, size, dma_handle);
+		if (*ret)
+			break;
+	}
+
 	return 1;
 }
 
@@ -226,9 +236,19 @@ static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
  */
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
+	int ret = 0;
 
-	return __dma_release_from_coherent(mem, order, vaddr);
+	if (!mem)
+		return ret;
+
+	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
+		ret = __dma_release_from_coherent(mem_tmp, order, vaddr);
+		if (ret == 1)
+			break;
+	}
+
+	return ret;
 }
 
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
@@ -271,9 +291,19 @@ static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 			   void *vaddr, size_t size, int *ret)
 {
-	struct dma_coherent_mem *mem = dev_get_coherent_memory(dev);
+	struct dma_coherent_mem *mem_tmp, *mem = dev_get_coherent_memory(dev);
+	int retval = 0;
 
-	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
+	if (!mem)
+		return retval;
+
+	list_for_each_entry(mem_tmp, &dev->dma_mem_list, node) {
+		retval = __dma_mmap_from_coherent(mem_tmp, vma, vaddr, size, ret);
+		if (retval == 1)
+			break;
+	}
+
+	return retval;
 }
 
 #ifdef CONFIG_DMA_GLOBAL_POOL
@@ -351,8 +381,22 @@ static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 static void rmem_dma_device_release(struct reserved_mem *rmem,
 				    struct device *dev)
 {
-	if (dev)
-		dev->dma_mem = NULL;
+	struct dma_coherent_mem *mem, *mem_tmp, *q;
+
+	if (dev) {
+		mem = dev_get_coherent_memory(dev);
+		if (rmem->priv != mem) {
+			list_for_each_entry_safe(mem_tmp, q, &dev->dma_mem_list, node) {
+				if (mem_tmp == rmem->priv) {
+					list_del_init(&mem_tmp->node);
+					break;
+				}
+			}
+		} else {
+			list_del_init(&mem->node);
+			dev->dma_mem = NULL;
+		}
+	}
 }
 
 static const struct reserved_mem_ops rmem_dma_ops = {
-- 
2.43.0.429.g432eaa2c6b-goog


