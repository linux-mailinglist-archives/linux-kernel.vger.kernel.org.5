Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9E67C84E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjJMLtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbjJMLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:49:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38FB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb73cso21202765e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197737; x=1697802537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u5aSutwel/MgT4d0b/m8JPySgFiWzm1DTcixaYm8aY=;
        b=cOviUgp1w2HPQqipcSB3k2osTeIao3DjvOL5mLNwEcjP8+Y/mpQqAZ94sky3LxHQw5
         qPrwYZo90vrTQG3ZBH2nNyLMnkz1MiL/Vl2kDBedj4T/CiEe8J1kqtTCN106MSdds+XY
         FVMhdzowlS5ADKCtkGTslFM6QP5N///bpZYQTof8dRjb24WQ2Vg6OrDpj5hw2jiC1yuq
         A+BnQ/URJ97SwoixrqhnWrLMnVBNopgIu35RC6RtiNu8Q81JREebKoZkqRwT7HNEDchs
         1bEF525EhYnsdIk9vQNBUxgXkuOcQQTBaFR1/KguZQwrHC7hK7ny2NwcDU6+G9wTfFyq
         ARRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197737; x=1697802537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1u5aSutwel/MgT4d0b/m8JPySgFiWzm1DTcixaYm8aY=;
        b=KArgEoy2LG1o9vrvdQifrU4F22WDzSxbsCl5Sq80/YfsptFQCzvIzxUEAd3/ciE3S7
         +TF/JJj+Sn+OMtdFfN8S2Dv9O/0wNmy/yHfyxQcpBTtKAf2mo+ohlHMOnz9iWOP03Exy
         IPjCXmpDzCpcS1SA7eMhpSAxFIJ3E+QvVDPySBQ2B7HNhAWwDCVLXPpLp5zI8Dj0ITME
         2/CzGvxG7nzrlj0qYwolIPB0aeiU9c10vq8T1wCnAhHF6uwjIuP/L32aSv68bX/Sms8k
         mKQqPYX+ZT07x4wCSgdgDu/yGiOb6R7s9OrPgab0ZqmoA4F+tqxnWstOJWfRZ4hyq2VG
         RtVQ==
X-Gm-Message-State: AOJu0Yz3IW/pCUoq4WKUkNhKOGuY8o7IW/233mZewOE6OR/7yB5Dxlvu
        GHa4C63IT5OHmq3J9L+BjMfc8Q==
X-Google-Smtp-Source: AGHT+IG12/TzzYUF8ES/v+IgawK0jbc6qqDbce54ePN0r0P+LdVtayWVK1bSZ4MjBeH6r/2uvFrF0w==
X-Received: by 2002:a7b:c8c8:0:b0:402:cf9f:c02d with SMTP id f8-20020a7bc8c8000000b00402cf9fc02dmr22851158wml.8.1697197736665;
        Fri, 13 Oct 2023 04:48:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:48:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 04/15] firmware: qcom: add a dedicated TrustZone buffer allocator
Date:   Fri, 13 Oct 2023 13:48:32 +0200
Message-Id: <20231013114843.63205-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have several SCM calls that require passing buffers to the TrustZone
on top of the SMC core which allocates memory for calls that require
more than 4 arguments.

Currently every user does their own thing which leads to code
duplication. Many users call dma_alloc_coherent() for every call which
is terribly unperformant (speed- and size-wise).

Provide a set of library functions for creating and managing pool of
memory which is suitable for sharing with the TrustZone, that is:
page-aligned, contiguous and non-cachable as well as provides a way of
mapping of kernel virtual addresses to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/Kconfig            |  19 ++
 drivers/firmware/qcom/Makefile           |   1 +
 drivers/firmware/qcom/qcom_tzmem.c       | 302 +++++++++++++++++++++++
 drivers/firmware/qcom/qcom_tzmem.h       |  13 +
 include/linux/firmware/qcom/qcom_tzmem.h |  28 +++
 5 files changed, 363 insertions(+)
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 3f05d9854ddf..b80269a28224 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -9,6 +9,25 @@ menu "Qualcomm firmware drivers"
 config QCOM_SCM
 	tristate
 
+config QCOM_TZMEM
+	tristate
+
+choice
+	prompt "TrustZone interface memory allocator mode"
+	default QCOM_TZMEM_MODE_DEFAULT
+	help
+	  Selects the mode of the memory allocator providing memory buffers of
+	  suitable format for sharing with the TrustZone. If in doubt, select
+	  'Default'.
+
+config QCOM_TZMEM_MODE_DEFAULT
+	bool "Default"
+	help
+	  Use the default allocator mode. The memory is page-aligned, non-cachable
+	  and contiguous.
+
+endchoice
+
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
 	bool "Qualcomm download mode enabled by default"
 	depends on QCOM_SCM
diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
index c9f12ee8224a..0be40a1abc13 100644
--- a/drivers/firmware/qcom/Makefile
+++ b/drivers/firmware/qcom/Makefile
@@ -5,5 +5,6 @@
 
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
 qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_TZMEM)	+= qcom_tzmem.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
new file mode 100644
index 000000000000..68ca59c5598e
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Memory allocator for buffers shared with the TrustZone.
+ *
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/firmware/qcom/qcom_tzmem.h>
+#include <linux/genalloc.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+#include <linux/radix-tree.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "qcom_tzmem.h"
+
+struct qcom_tzmem_pool {
+	void *vbase;
+	phys_addr_t pbase;
+	size_t size;
+	struct gen_pool *pool;
+	void *priv;
+};
+
+struct qcom_tzmem_chunk {
+	phys_addr_t paddr;
+	size_t size;
+	struct qcom_tzmem_pool *owner;
+};
+
+static struct device *qcom_tzmem_dev;
+static RADIX_TREE(qcom_tzmem_chunks, GFP_ATOMIC);
+static DEFINE_SPINLOCK(qcom_tzmem_chunks_lock);
+
+#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_DEFAULT)
+
+static int qcom_tzmem_init(void)
+{
+	return 0;
+}
+
+static int qcom_tzmem_init_pool(struct qcom_tzmem_pool *pool)
+{
+	return 0;
+}
+
+static void qcom_tzmem_cleanup_pool(struct qcom_tzmem_pool *pool)
+{
+
+}
+
+#endif /* CONFIG_QCOM_TZMEM_MODE_DEFAULT */
+
+/**
+ * qcom_tzmem_pool_new() - Create a new TZ memory pool.
+ * @size: Size of the new pool in bytes.
+ *
+ * Create a new pool of memory suitable for sharing with the TrustZone.
+ *
+ * Must not be used in atomic context.
+ *
+ * Returns:
+ * New memory pool address or ERR_PTR() on error.
+ */
+struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size)
+{
+	struct qcom_tzmem_pool *pool;
+	int ret = -ENOMEM;
+
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
+	size = PAGE_ALIGN(size);
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->size = size;
+
+	pool->vbase = dma_alloc_coherent(qcom_tzmem_dev, size, &pool->pbase,
+					 GFP_KERNEL);
+	if (!pool->vbase)
+		goto err_kfree_pool;
+
+	pool->pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!pool)
+		goto err_dma_free;
+
+	gen_pool_set_algo(pool->pool, gen_pool_best_fit, NULL);
+
+	ret = gen_pool_add_virt(pool->pool, (unsigned long)pool->vbase,
+				pool->pbase, size, -1);
+	if (ret)
+		goto err_destroy_genpool;
+
+	ret = qcom_tzmem_init_pool(pool);
+	if (ret)
+		goto err_destroy_genpool;
+
+	return pool;
+
+err_destroy_genpool:
+	gen_pool_destroy(pool->pool);
+err_dma_free:
+	dma_free_coherent(qcom_tzmem_dev, size, pool->vbase, pool->pbase);
+err_kfree_pool:
+	kfree(pool);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
+
+/**
+ * qcom_tzmem_pool_free() - Destroy a TZ memory pool and free all resources.
+ * @pool: Memory pool to free.
+ *
+ * Must not be called if any of the allocated chunks has not been freed.
+ * Must not be used in atomic context.
+ */
+void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool)
+{
+	struct qcom_tzmem_chunk *chunk;
+	struct radix_tree_iter iter;
+	bool non_empty = false;
+	void __rcu **slot;
+
+	if (!pool)
+		return;
+
+	qcom_tzmem_cleanup_pool(pool);
+
+	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
+		radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &iter, 0) {
+			chunk = radix_tree_deref_slot_protected(slot,
+						&qcom_tzmem_chunks_lock);
+
+			if (chunk->owner == pool)
+				non_empty = true;
+		}
+	}
+
+	WARN(non_empty, "Freeing TZ memory pool with memory still allocated");
+
+	gen_pool_destroy(pool->pool);
+	dma_free_coherent(qcom_tzmem_dev, pool->size, pool->vbase, pool->pbase);
+	kfree(pool);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_pool_free);
+
+static void devm_qcom_tzmem_pool_free(void *data)
+{
+	struct qcom_tzmem_pool *pool = data;
+
+	qcom_tzmem_pool_free(pool);
+}
+
+/**
+ * devm_qcom_tzmem_pool_new() - Managed variant of qcom_tzmem_pool_new().
+ * @dev: Device managing this resource.
+ * @size: Size of the pool in bytes.
+ *
+ * Must not be used in atomic context.
+ *
+ * Returns:
+ * Address of the managed pool or ERR_PTR() on failure.
+ */
+struct qcom_tzmem_pool *
+devm_qcom_tzmem_pool_new(struct device *dev, size_t size)
+{
+	struct qcom_tzmem_pool *pool;
+	int ret;
+
+	pool = qcom_tzmem_pool_new(size);
+	if (IS_ERR(pool))
+		return pool;
+
+	ret = devm_add_action_or_reset(dev, devm_qcom_tzmem_pool_free, pool);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pool;
+}
+
+/**
+ * qcom_tzmem_alloc() - Allocate a memory chunk suitable for sharing with TZ.
+ * @pool: TZ memory pool from which to allocate memory.
+ * @size: Number of bytes to allocate.
+ * @gfp: GFP flags.
+ *
+ * Can be used in any context.
+ *
+ * Returns:
+ * Address of the allocated buffer or NULL if no more memory can be allocated.
+ * The buffer must be released using qcom_tzmem_free().
+ */
+void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp)
+{
+	struct qcom_tzmem_chunk *chunk;
+	unsigned long vaddr;
+	int ret;
+
+	if (!size)
+		return NULL;
+
+	size = PAGE_ALIGN(size);
+
+	chunk = kzalloc(sizeof(*chunk), gfp);
+	if (!chunk)
+		return NULL;
+
+	vaddr = gen_pool_alloc(pool->pool, size);
+	if (!vaddr) {
+		kfree(chunk);
+		return NULL;
+	}
+
+	chunk->paddr = gen_pool_virt_to_phys(pool->pool, vaddr);
+	chunk->size = size;
+	chunk->owner = pool;
+
+	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
+		ret = radix_tree_insert(&qcom_tzmem_chunks, vaddr, chunk);
+		if (ret) {
+			gen_pool_free(pool->pool, vaddr, size);
+			kfree(chunk);
+			return NULL;
+		}
+	}
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_alloc);
+
+/**
+ * qcom_tzmem_free() - Release a buffer allocated from a TZ memory pool.
+ * @vaddr: Virtual address of the buffer.
+ *
+ * Can be used in any context.
+ */
+void qcom_tzmem_free(void *vaddr)
+{
+	struct qcom_tzmem_chunk *chunk;
+
+	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock)
+		chunk = radix_tree_delete_item(&qcom_tzmem_chunks,
+					       (unsigned long)vaddr, NULL);
+
+	if (!chunk) {
+		WARN(1, "Virtual address %p not owned by TZ memory allocator",
+		     vaddr);
+		return;
+	}
+
+	gen_pool_free(chunk->owner->pool, (unsigned long)vaddr, chunk->size);
+	kfree(chunk);
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_free);
+
+/**
+ * qcom_tzmem_to_phys() - Map the virtual address of a TZ buffer to physical.
+ * @vaddr: Virtual address of the buffer allocated from a TZ memory pool.
+ *
+ * Can be used in any context. The address must have been returned by a call
+ * to qcom_tzmem_alloc().
+ *
+ * Returns:
+ * Physical address of the buffer.
+ */
+phys_addr_t qcom_tzmem_to_phys(void *vaddr)
+{
+	struct qcom_tzmem_chunk *chunk;
+
+	guard(spinlock_irqsave)(&qcom_tzmem_chunks_lock);
+
+	chunk = radix_tree_lookup(&qcom_tzmem_chunks, (unsigned long)vaddr);
+	if (!chunk)
+		return 0;
+
+	return chunk->paddr;
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_to_phys);
+
+int qcom_tzmem_enable(struct device *dev)
+{
+	if (qcom_tzmem_dev)
+		return -EBUSY;
+
+	qcom_tzmem_dev = dev;
+
+	return qcom_tzmem_init();
+}
+EXPORT_SYMBOL_GPL(qcom_tzmem_enable);
+
+MODULE_DESCRIPTION("TrustZone memory allocator for Qualcomm firmware drivers");
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/qcom/qcom_tzmem.h b/drivers/firmware/qcom/qcom_tzmem.h
new file mode 100644
index 000000000000..f82f5dc5b7b1
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tzmem.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#ifndef __QCOM_TZMEM_PRIV_H
+#define __QCOM_TZMEM_PRIV_H
+
+struct device;
+
+int qcom_tzmem_enable(struct device *dev);
+
+#endif /* __QCOM_TZMEM_PRIV_H */
diff --git a/include/linux/firmware/qcom/qcom_tzmem.h b/include/linux/firmware/qcom/qcom_tzmem.h
new file mode 100644
index 000000000000..8e7fddab8cb4
--- /dev/null
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#ifndef __QCOM_TZMEM_H
+#define __QCOM_TZMEM_H
+
+#include <linux/cleanup.h>
+#include <linux/gfp.h>
+#include <linux/types.h>
+
+struct device;
+struct qcom_tzmem_pool;
+
+struct qcom_tzmem_pool *qcom_tzmem_pool_new(size_t size);
+void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool);
+struct qcom_tzmem_pool *
+devm_qcom_tzmem_pool_new(struct device *dev, size_t size);
+
+void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp);
+void qcom_tzmem_free(void *ptr);
+
+DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T));
+
+phys_addr_t qcom_tzmem_to_phys(void *ptr);
+
+#endif /* __QCOM_TZMEM */
-- 
2.39.2

