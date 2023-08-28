Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5DE78B860
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjH1T2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjH1T1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:27:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B950131
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fee87dd251so33584415e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693250829; x=1693855629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1CxvFy6DjQ2QqPARFppzzJEHGmRIN9sA1kFw52YtqA=;
        b=dSl0E+ca6ei+p+BhvXukag03UwmW73FD3fXR3l4q6mrKsLoSjQr/AjmGqhJwOOrnwz
         6DneWKK5bwzG7lNo/lmmsPSph84oRJbOPCDWwNaQUKeBgeedw7CedxQwNxOaCB9Saoiq
         rSlCo0LMzDY/dOTbGmZrZo5tQjWO2dPKBg3GrQfJpibul1NqLTVHrzjz+opNfYpODqHf
         cpaDtSkACON9MIFiWANyztDVK/Ztz30A5EP0R2s+Q1I6FVq0XLhMjF/8du7AbxBHVKJh
         OyR5tLgwGWpBO8lqhMAqZPcPP+B9Ix+67Sm51SjGTMVb9HfXWHyz7BSDK3vg8YhgQ+fQ
         A0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693250829; x=1693855629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1CxvFy6DjQ2QqPARFppzzJEHGmRIN9sA1kFw52YtqA=;
        b=EKE9x2N5YeimMWRmviuVZSQfR7FgP4ll07zIkGt0z2ohA6HveEyc0rolOZ6wWDHL8A
         8Y5u9Ij5BUDIHqfozMTSz+hP0CaH1yfLzb8OmZREii3m7Vo+vy2BaXvlUxZ1xhUEsqib
         AEHJPKb5J+oggT6aO8Iyg0SMuTg+NdULXLW6eMFualxm6Rbnz+RLAjf2G94EkDkMJLZ2
         IBVX58h3ySJ/avRK3FJTa4PN+wwRMgTWeMqqQXe2fkO4jk7q7U+ZuSYHy+8XKLY8+rPv
         R0cPNJB2hlWKK8ZLYdtWCQ/oFsYTABMAP8MLFIEdY2QMSkBSHntEnnFOz7/0iIlEM20G
         SitA==
X-Gm-Message-State: AOJu0YzagSYqDJOIVp41xnu2sKZKoQwU5+ojNu9eWcgGZb5pA1MLLcpX
        7mpRymp0JAs7K3HmnUGvonpUCQ==
X-Google-Smtp-Source: AGHT+IG16plrLwVWNVWNBmzzaYPUetvSFyD0SYBWHQ0Uei/kQgG98t5cUvWtgeVCvbBRPGeUe+jycw==
X-Received: by 2002:a5d:62cd:0:b0:319:785a:fce0 with SMTP id o13-20020a5d62cd000000b00319785afce0mr20142048wrv.26.1693250829565;
        Mon, 28 Aug 2023 12:27:09 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8bd:7f16:d368:115f])
        by smtp.gmail.com with ESMTPSA id i20-20020a5d5234000000b003141f96ed36sm11435319wra.0.2023.08.28.12.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 12:27:09 -0700 (PDT)
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 06/11] firmware: qcom-shm-bridge: new driver
Date:   Mon, 28 Aug 2023 21:25:02 +0200
Message-Id: <20230828192507.117334-7-bartosz.golaszewski@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module is a platform driver that also exposes an interface for
kernel users to allocate blocks of memory shared with the trustzone.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/Kconfig                 |   8 +
 drivers/firmware/Makefile                |   1 +
 drivers/firmware/qcom-shm-bridge.c       | 452 +++++++++++++++++++++++
 include/linux/firmware/qcom/shm-bridge.h |  32 ++
 4 files changed, 493 insertions(+)
 create mode 100644 drivers/firmware/qcom-shm-bridge.c
 create mode 100644 include/linux/firmware/qcom/shm-bridge.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..39f35ba18779 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -226,6 +226,14 @@ config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 
 	  Say Y here to enable "download mode" by default.
 
+config QCOM_SHM_BRIDGE
+	bool "Qualcomm SHM bridge driver"
+	depends on QCOM_SCM
+	help
+	  Say yes here to enable support for Qualcomm TEE Shared Memory Bridge.
+	  This module exposes interfaces that allow kernel users to allocate
+	  blocks of memory shared with the trustzone.
+
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 28fcddcd688f..ba1590cf959c 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_SHM_BRIDGE)	+= qcom-shm-bridge.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
diff --git a/drivers/firmware/qcom-shm-bridge.c b/drivers/firmware/qcom-shm-bridge.c
new file mode 100644
index 000000000000..db76c5c5061d
--- /dev/null
+++ b/drivers/firmware/qcom-shm-bridge.c
@@ -0,0 +1,452 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Linaro Limited
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/device/bus.h>
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/firmware/qcom/shm-bridge.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/radix-tree.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
+
+DEFINE_FREE(qcom_shm_bridge_pool, struct qcom_shm_bridge_pool *,
+	    if (_T) qcom_shm_bridge_pool_unref(_T))
+
+/*
+ * Size of the global fall-back pool can be adjusted using this param. Use 4M
+ * as a sane default.
+ */
+static unsigned int qcom_shm_bridge_default_pool_size = SZ_4M;
+module_param_named(default_pool_size, qcom_shm_bridge_default_pool_size,
+		   uint, 0644);
+
+struct qcom_shm_bridge_pool {
+	struct device *dev;
+	void *vaddr;
+	phys_addr_t paddr;
+	size_t size;
+	uint64_t handle;
+	struct gen_pool *genpool;
+	struct list_head chunks;
+	spinlock_t lock;
+	struct kref refcount;
+};
+
+struct qcom_shm_bridge_chunk {
+	void *vaddr;
+	size_t size;
+	struct qcom_shm_bridge_pool *parent;
+	struct list_head siblings;
+};
+
+/* This is the global fall-back pool, used if user doesn't supply their own. */
+static struct qcom_shm_bridge_pool *qcom_shm_bridge_default_pool;
+
+static RADIX_TREE(qcom_shm_bridge_chunks, GFP_ATOMIC);
+static DEFINE_SPINLOCK(qcom_shm_bridge_chunks_lock);
+
+static void qcom_shm_bridge_pool_release(struct kref *kref)
+{
+	struct qcom_shm_bridge_pool *pool =
+		container_of(kref, struct qcom_shm_bridge_pool, refcount);
+
+	if (pool->handle)
+		qcom_scm_delete_shm_bridge(pool->dev, pool->handle);
+
+	if (pool->genpool)
+		gen_pool_destroy(pool->genpool);
+
+	if (pool->paddr)
+		dma_unmap_single(pool->dev, pool->paddr, pool->size,
+				 DMA_TO_DEVICE);
+
+	if (pool->vaddr)
+		free_pages((unsigned long)pool->vaddr, get_order(pool->size));
+
+	put_device(pool->dev);
+	kfree(pool);
+}
+
+static int qcom_shm_bridge_create(struct qcom_shm_bridge_pool *pool)
+{
+	uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_vmids,
+		 ns_perms, handle;
+	int ret;
+
+	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
+	ns_vmids = QCOM_SCM_VMID_HLOS;
+	pfn_and_ns_perm = (u64)pool->paddr | ns_perms;
+	ipfn_and_s_perm = (u64)pool->paddr | ns_perms;
+	size_and_flags = pool->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	ret = qcom_scm_create_shm_bridge(pool->dev, pfn_and_ns_perm,
+					 ipfn_and_s_perm, size_and_flags,
+					 ns_vmids, &handle);
+	if (!ret)
+		pool->handle = handle;
+
+	return ret;
+}
+
+static struct qcom_shm_bridge_pool *
+qcom_shm_bridge_pool_new_for_dev(struct device *dev, size_t size)
+{
+	struct qcom_shm_bridge_pool *pool __free(qcom_shm_bridge_pool) = NULL;
+	int ret;
+
+	if (!qcom_scm_shm_bridge_available())
+		return ERR_PTR(-ENODEV);
+
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->dev = get_device(dev);
+	pool->size = size;
+	INIT_LIST_HEAD(&pool->chunks);
+	spin_lock_init(&pool->lock);
+	kref_init(&pool->refcount);
+
+	pool->vaddr = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA,
+					       get_order(pool->size));
+	if (!pool->vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	pool->paddr = dma_map_single(pool->dev, pool->vaddr, pool->size,
+				     DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, pool->paddr))
+		return ERR_PTR(-ENOMEM);
+
+	pool->genpool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!pool->genpool)
+		return ERR_PTR(-ENOMEM);
+
+	gen_pool_set_algo(pool->genpool, gen_pool_best_fit, NULL);
+
+	ret = gen_pool_add_virt(pool->genpool, (unsigned long)pool->vaddr,
+				pool->paddr, pool->size, -1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = qcom_shm_bridge_create(pool);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return no_free_ptr(pool);
+}
+
+/**
+ * qcom_shm_bridge_pool_new - Create a new SHM Bridge memory pool.
+ *
+ * @size: Size of the pool.
+ *
+ * Creates a new Shared Memory Bridge pool from which users can allocate memory
+ * chunks. Must be called from process context.
+ *
+ * Return:
+ * Pointer to the newly created SHM Bridge pool with reference count set to 1
+ * or ERR_PTR().
+ */
+struct qcom_shm_bridge_pool *qcom_shm_bridge_pool_new(size_t size)
+{
+	struct device *dev;
+
+	dev = bus_find_device_by_name(&platform_bus_type, NULL,
+				      "qcom-shm-bridge");
+	if (!dev)
+		return ERR_PTR(-ENODEV);
+
+	return qcom_shm_bridge_pool_new_for_dev(dev, size);
+}
+EXPORT_SYMBOL_GPL(qcom_shm_bridge_pool_new);
+
+/**
+ * qcom_shm_bridge_pool_ref - Increate the refcount of an SHM Bridge pool.
+ *
+ * @pool: SHM Bridge pool of which the reference count to increase.
+ *
+ * Return:
+ * Pointer to the same pool object.
+ */
+struct qcom_shm_bridge_pool *
+qcom_shm_bridge_pool_ref(struct qcom_shm_bridge_pool *pool)
+{
+	kref_get(&pool->refcount);
+
+	return pool;
+}
+EXPORT_SYMBOL_GPL(qcom_shm_bridge_pool_ref);
+
+/**
+ * qcom_shm_bridge_pool_unref - Decrease the refcount of an SHM Bridge pool.
+ *
+ * @pool: SHM Bridge pool of which the reference count to decrease.
+ *
+ * Once the reference count reaches 0, the pool is released.
+ */
+void qcom_shm_bridge_pool_unref(struct qcom_shm_bridge_pool *pool)
+{
+	kref_put(&pool->refcount, qcom_shm_bridge_pool_release);
+}
+EXPORT_SYMBOL_GPL(qcom_shm_bridge_pool_unref);
+
+static void devm_qcom_shm_bridge_pool_unref(void *data)
+{
+	struct qcom_shm_bridge_pool *pool = data;
+
+	qcom_shm_bridge_pool_unref(pool);
+}
+
+/**
+ * devm_qcom_shm_bridge_pool_new - Managed variant of qcom_shm_bridge_pool_new.
+ *
+ * @dev: Device for which to map memory and which will manage this pool.
+ * @size: Size of the pool.
+ *
+ * Return:
+ * Pointer to the newly created SHM Bridge pool with reference count set to 1
+ * or ERR_PTR().
+ */
+struct qcom_shm_bridge_pool *
+devm_qcom_shm_bridge_pool_new(struct device *dev, size_t size)
+{
+	struct qcom_shm_bridge_pool *pool;
+	int ret;
+
+	pool = qcom_shm_bridge_pool_new(size);
+	if (IS_ERR(pool))
+		return pool;
+
+	ret = devm_add_action_or_reset(dev, devm_qcom_shm_bridge_pool_unref,
+				       pool);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pool;
+}
+EXPORT_SYMBOL_GPL(devm_qcom_shm_bridge_pool_new);
+
+/**
+ * qcom_shm_bridge_alloc - Allocate a chunk of memory from an SHM Bridge pool.
+ *
+ * @pool: Pool to allocate memory from. May be NULL.
+ * @size: Number of bytes to allocate.
+ * @gfp: Allocation flags.
+ *
+ * If pool is NULL then the global fall-back pool is used.
+ *
+ * Return:
+ * Virtual address of the allocated memory or ERR_PTR(). Must be freed using
+ * qcom_shm_bridge_free().
+ */
+void *qcom_shm_bridge_alloc(struct qcom_shm_bridge_pool *pool,
+			    size_t size, gfp_t gfp)
+{
+	struct qcom_shm_bridge_chunk *chunk __free(kfree) = NULL;
+	unsigned long vaddr;
+	int ret;
+
+	if (!pool) {
+		pool = READ_ONCE(qcom_shm_bridge_default_pool);
+		if (!pool)
+			return ERR_PTR(-ENODEV);
+	}
+
+	if (!size || size > pool->size)
+		return ERR_PTR(-EINVAL);
+
+	size = roundup(size, 1 << PAGE_SHIFT);
+
+	chunk = kzalloc(sizeof(*chunk), gfp);
+	if (!chunk)
+		return ERR_PTR(-ENOMEM);
+
+	guard(spinlock_irqsave)(&pool->lock);
+
+	vaddr = gen_pool_alloc(pool->genpool, size);
+	if (!vaddr)
+		return ERR_PTR(-ENOMEM);
+
+	chunk->vaddr = (void *)vaddr;
+	chunk->size = size;
+	chunk->parent = pool;
+	list_add_tail(&chunk->siblings, &pool->chunks);
+	qcom_shm_bridge_pool_ref(pool);
+
+	guard(spinlock_irqsave)(&qcom_shm_bridge_chunks_lock);
+
+	ret = radix_tree_insert(&qcom_shm_bridge_chunks, vaddr, chunk);
+	if (ret) {
+		gen_pool_free(pool->genpool, vaddr, chunk->size);
+		return ERR_PTR(ret);
+	}
+
+	return no_free_ptr(chunk)->vaddr;
+}
+EXPORT_SYMBOL_GPL(qcom_shm_bridge_alloc);
+
+/**
+ * qcom_shm_bridge_free - Free SHM Bridge memory allocated from the pool.
+ *
+ * @vaddr: Virtual address of the allocated memory to free.
+ */
+void qcom_shm_bridge_free(void *vaddr)
+{
+	struct qcom_shm_bridge_chunk *chunk;
+	struct qcom_shm_bridge_pool *pool;
+
+	scoped_guard(spinlock_irqsave, &qcom_shm_bridge_chunks_lock)
+		chunk = radix_tree_delete_item(&qcom_shm_bridge_chunks,
+					       (unsigned long)vaddr, NULL);
+	if (!chunk)
+		goto out_warn;
+
+	pool = chunk->parent;
+
+	guard(spinlock_irqsave)(&pool->lock);
+
+	list_for_each_entry(chunk, &pool->chunks, siblings) {
+		if (vaddr != chunk->vaddr)
+			continue;
+
+		gen_pool_free(pool->genpool, (unsigned long)chunk->vaddr,
+			      chunk->size);
+		list_del(&chunk->siblings);
+		qcom_shm_bridge_pool_unref(pool);
+		kfree(chunk);
+		return;
+	}
+
+out_warn:
+	WARN(1, "Virtual address %p not allocated for SHM bridge", vaddr);
+}
+EXPORT_SYMBOL_GPL(qcom_shm_bridge_free);
+
+/**
+ * devm_qcom_shm_bridge_alloc - Managed variant of qcom_shm_bridge_alloc.
+ *
+ * @dev: Managing device.
+ * @pool: Pool to allocate memory from.
+ * @size: Number of bytes to allocate.
+ * @gfp: Allocation flags.
+ *
+ * Return:
+ * Virtual address of the allocated memory or ERR_PTR().
+ */
+void *devm_qcom_shm_bridge_alloc(struct device *dev,
+				 struct qcom_shm_bridge_pool *pool,
+				 size_t size, gfp_t gfp)
+{
+	void *vaddr;
+	int ret;
+
+	vaddr = qcom_shm_bridge_alloc(pool, size, gfp);
+	if (IS_ERR(vaddr))
+		return vaddr;
+
+	ret = devm_add_action_or_reset(dev, qcom_shm_bridge_free, vaddr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return vaddr;
+}
+EXPORT_SYMBOL_GPL(devm_qcom_shm_bridge_alloc);
+
+/**
+ * qcom_shm_bridge_to_phys_addr - Translate address from virtual to physical.
+ *
+ * @vaddr: Virtual address to translate.
+ *
+ * Return:
+ * Physical address corresponding to 'vaddr'.
+ */
+phys_addr_t qcom_shm_bridge_to_phys_addr(void *vaddr)
+{
+	struct qcom_shm_bridge_chunk *chunk;
+	struct qcom_shm_bridge_pool *pool;
+
+	guard(spinlock_irqsave)(&qcom_shm_bridge_chunks_lock);
+
+	chunk = radix_tree_lookup(&qcom_shm_bridge_chunks,
+				  (unsigned long)vaddr);
+	if (!chunk)
+		return 0;
+
+	pool = chunk->parent;
+
+	guard(spinlock_irqsave)(&pool->lock);
+
+	return gen_pool_virt_to_phys(pool->genpool, (unsigned long)vaddr);
+}
+EXPORT_SYMBOL_GPL(qcom_shm_bridge_to_phys_addr);
+
+static int qcom_shm_bridge_probe(struct platform_device *pdev)
+{
+	struct qcom_shm_bridge_pool *default_pool;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	/*
+	 * We need to wait for the SCM device to be created and bound to the
+	 * SCM driver.
+	 */
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	ret = qcom_scm_enable_shm_bridge();
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable the SHM bridge\n");
+
+	default_pool = qcom_shm_bridge_pool_new_for_dev(
+				dev, qcom_shm_bridge_default_pool_size);
+	if (IS_ERR(default_pool))
+		return dev_err_probe(dev, PTR_ERR(default_pool),
+				     "Failed to create the default SHM Bridge pool\n");
+
+	WRITE_ONCE(qcom_shm_bridge_default_pool, default_pool);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_shm_bridge_of_match[] = {
+	{ .compatible = "qcom,shm-bridge", },
+	{ }
+};
+
+static struct platform_driver qcom_shm_bridge_driver = {
+	.driver = {
+		.name = "qcom-shm-bridge",
+		.of_match_table = qcom_shm_bridge_of_match,
+		/*
+		 * Once enabled, the SHM Bridge feature cannot be disabled so
+		 * there's no reason to ever unbind the driver.
+		 */
+		.suppress_bind_attrs = true,
+	},
+	.probe = qcom_shm_bridge_probe,
+};
+
+static int __init qcom_shm_bridge_init(void)
+{
+	return platform_driver_register(&qcom_shm_bridge_driver);
+}
+subsys_initcall(qcom_shm_bridge_init);
diff --git a/include/linux/firmware/qcom/shm-bridge.h b/include/linux/firmware/qcom/shm-bridge.h
new file mode 100644
index 000000000000..df066a2f6d91
--- /dev/null
+++ b/include/linux/firmware/qcom/shm-bridge.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Linaro Limited
+ */
+
+#ifndef _LINUX_QCOM_SHM_BRIDGE
+#define _LINUX_QCOM_SHM_BRIDGE
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/gfp.h>
+#include <linux/types.h>
+
+struct qcom_shm_bridge_pool;
+
+struct qcom_shm_bridge_pool *qcom_shm_bridge_pool_new(size_t size);
+struct qcom_shm_bridge_pool *
+qcom_shm_bridge_pool_ref(struct qcom_shm_bridge_pool *pool);
+void qcom_shm_bridge_pool_unref(struct qcom_shm_bridge_pool *pool);
+struct qcom_shm_bridge_pool *
+devm_qcom_shm_bridge_pool_new(struct device *dev, size_t size);
+
+void *qcom_shm_bridge_alloc(struct qcom_shm_bridge_pool *pool,
+			    size_t size, gfp_t gfp);
+void qcom_shm_bridge_free(void *vaddr);
+void *devm_qcom_shm_bridge_alloc(struct device *dev,
+				 struct qcom_shm_bridge_pool *pool,
+				 size_t size, gfp_t gfp);
+
+phys_addr_t qcom_shm_bridge_to_phys_addr(void *vaddr);
+
+#endif /* _LINUX_QCOM_SHM_BRIDGE */
-- 
2.39.2

