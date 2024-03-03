Return-Path: <linux-kernel+bounces-89781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB8886F5A1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C46ED28607B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEB367C75;
	Sun,  3 Mar 2024 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WsQZvAnF"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9A367A1F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478088; cv=none; b=UYAEgl7PpXVCTDXxUrZhAI1BGBA5C0D/ZYeF/nTy4xfGP6rLGHTTJHjYLmOOKGw0WgVF5I4dHnyJ9PA4XrNZ1v7KAdkH9ZgdjwSTpCRPAvIUbNv2j9Do/Vn/5zcwbdy4YzJ67TnqRYm9QzyD83FS4rjXSvlRuRnvnFs0i9+Ogyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478088; c=relaxed/simple;
	bh=pU6mrgroinLht95k8WFXE/0Con1+YBJRDYD5JMmOcyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hzamrc5kuT9vBS4vUcxglvCGVYMIWEaMcWC14Y8RYWZZzeZTFscQljY5s4qpjJw6urypv/63gmMCodWx1NY6cwXGE3q3ikJgI+WTd57VCHIbCBEnOFLteSopPJFZa4WutLtaRncQc00fdkoR9IW4/RdS6uG7W1WLIFdgbe+epMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WsQZvAnF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so154818966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478084; x=1710082884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omWEpNMS3+uKdLcCHx2ERnon/p7l0GHwPHHpg6EUlWU=;
        b=WsQZvAnFcMRG0nOIqAthU0T0YBPM6Uqbv0iPVTNohHauzqVE+ZV7Q+IXU/zv+d+47+
         H0/+uf7W9f0ldQHX67WdTr9joSEwOzdFu7XX0m4GBEZjE5puzn7ln2M3U/rjL9CSMwFu
         dYdJcI4S+2I0/F88mbE3AlDUIY/2Vrt31XQUJpDePcHPo4BfYcWYUtfcYAvYJob7Lt/7
         InvWI3l4zNoUe6OX59E+UwJX0VfZyyh4JhX5pnfXnPyIF5pkSQHGjU8nX29kDr7e97OJ
         L+AiVzUCe4f4BFZgRwY1AaDYfe2w+AGHpVDGk2QXMTrZet1ByiZnnID5vWkpPhR/rOcs
         Akwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478084; x=1710082884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omWEpNMS3+uKdLcCHx2ERnon/p7l0GHwPHHpg6EUlWU=;
        b=DTUWuTlFxfDYc87/R8ECRfEsSP4avtq4YaE1uMAjXr418FwYKt3Iqnc7Z+y36xCxk7
         jMmcbXALmffnyC4AUFTRSVKMYNk2HABK5STEGT25a/u7UzXOFSZuQ1jTpXB/M6ysF+KP
         JYz5drhkd76DgXuivGs32DLFWRZqL1A0gAZwV22j0Ba+kLLInLg+s1lhJTK7Pn9PIuxQ
         hNlOXRsWbiJi5UwG4PRKH8jL/OxKRUsbTtmtSZ6yFrJcAlOLW8LlJQ+nQJLGDK7MIH2h
         3e7VK42fBPDRvT0SYPpBrLyPRAWXdf75rCAtnhoUBVv2ctTh/B6a63glPIfEEEl31mgY
         QinQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsDOfdlJLeTBiohyfRzwQRjwrnukRro7Gkd7HxSJ1j4/Br151LZf+N8MoHrLcxNIpiSqGRZy8f2jXdH9r7UBEU8oE9qZ1TCp/HkQA4
X-Gm-Message-State: AOJu0YyOhEzPBVLq7DfuvROIXJ7l9mUX4fT/gTCWf93XdxiOXAVaEyGF
	DyF9pWzxA5HKLEpbGb/THbP2U46gGCny79E7Dum53wCI3qyBbzR798LZf1Qdw9w=
X-Google-Smtp-Source: AGHT+IG7l8tLBdAcqOUmTQ8q9YqmxGpIJwZrrQZWFJkG4+xAa/5uz2ONBIwi1xccuDSbdLPs6vzX7w==
X-Received: by 2002:a17:906:339a:b0:a44:ff95:3911 with SMTP id v26-20020a170906339a00b00a44ff953911mr1768068eja.66.1709478084274;
        Sun, 03 Mar 2024 07:01:24 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v8 01/12] firmware: qcom: add a dedicated TrustZone buffer allocator
Date: Sun,  3 Mar 2024 16:01:04 +0100
Message-Id: <20240303150115.133633-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We have several SCM calls that require passing buffers to the TrustZone
on top of the SMC core which allocates memory for calls that require
more than 4 arguments.

Currently every user does their own thing which leads to code
duplication. Many users call dma_alloc_coherent() for every call which
is terribly unperformant (speed- and size-wise).

Provide a set of library functions for creating and managing pools of
memory which is suitable for sharing with the TrustZone, that is:
page-aligned, contiguous and non-cachable as well as provides a way of
mapping of kernel virtual addresses to physical space.

Make the allocator ready for extending with additional modes of operation
which will allow us to support the SHM bridge safety mechanism once all
users convert.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                              |   8 +
 drivers/firmware/qcom/Kconfig            |  20 ++
 drivers/firmware/qcom/Makefile           |   1 +
 drivers/firmware/qcom/qcom_tzmem.c       | 392 +++++++++++++++++++++++
 drivers/firmware/qcom/qcom_tzmem.h       |  13 +
 include/linux/firmware/qcom/qcom_tzmem.h |  56 ++++
 6 files changed, 490 insertions(+)
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1794b8d7c76b..c1138c709365 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18327,6 +18327,14 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	drivers/firmware/qcom/qcom_qseecom.c
 
+QUALCOMM TRUST ZONE MEMORY ALLOCATOR
+M:	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/qcom/qcom_tzmem.c
+F:	drivers/firmware/qcom/qcom_tzmem.h
+F:	include/linux/firmware/qcom/qcom_tzmem.h
+
 QUALCOMM QSEECOM UEFISECAPP DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 3f05d9854ddf..3c495f8698e1 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -9,6 +9,26 @@ menu "Qualcomm firmware drivers"
 config QCOM_SCM
 	tristate
 
+config QCOM_TZMEM
+	tristate
+	select GENERIC_ALLOCATOR
+
+choice
+	prompt "TrustZone interface memory allocator mode"
+	default QCOM_TZMEM_MODE_GENERIC
+	help
+	  Selects the mode of the memory allocator providing memory buffers of
+	  suitable format for sharing with the TrustZone. If in doubt, select
+	  'Generic'.
+
+config QCOM_TZMEM_MODE_GENERIC
+	bool "Generic"
+	help
+	  Use the generic allocator mode. The memory is page-aligned, non-cachable
+	  and physically contiguous.
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
index 000000000000..23f364afa6ca
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -0,0 +1,392 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Memory allocator for buffers shared with the TrustZone.
+ *
+ * Copyright (C) 2023-2024 Linaro Ltd.
+ */
+
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/firmware/qcom/qcom_tzmem.h>
+#include <linux/genalloc.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/mm.h>
+#include <linux/radix-tree.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "qcom_tzmem.h"
+
+struct qcom_tzmem_area {
+	struct list_head list;
+	void *vaddr;
+	dma_addr_t paddr;
+	size_t size;
+	void *priv;
+};
+
+struct qcom_tzmem_pool {
+	struct gen_pool *genpool;
+	struct list_head areas;
+	enum qcom_tzmem_policy policy;
+	size_t increment;
+	size_t max_size;
+	spinlock_t lock;
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
+#if IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_GENERIC)
+
+static int qcom_tzmem_init(void)
+{
+	return 0;
+}
+
+static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+{
+	return 0;
+}
+
+static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
+{
+
+}
+
+#endif /* CONFIG_QCOM_TZMEM_MODE_GENERIC */
+
+static int qcom_tzmem_pool_add_memory(struct qcom_tzmem_pool *pool,
+				      size_t size, gfp_t gfp)
+{
+	int ret;
+
+	struct qcom_tzmem_area *area __free(kfree) = kzalloc(sizeof(*area),
+							     gfp);
+	if (!area)
+		return -ENOMEM;
+
+	area->size = PAGE_ALIGN(size);
+
+	area->vaddr = dma_alloc_coherent(qcom_tzmem_dev, area->size,
+					 &area->paddr, gfp);
+	if (!area->vaddr)
+		return -ENOMEM;
+
+	ret = qcom_tzmem_init_area(area);
+	if (ret) {
+		dma_free_coherent(qcom_tzmem_dev, area->size,
+				  area->vaddr, area->paddr);
+		return ret;
+	}
+
+	ret = gen_pool_add_virt(pool->genpool, (unsigned long)area->vaddr,
+				(phys_addr_t)area->paddr, size, -1);
+	if (ret) {
+		dma_free_coherent(qcom_tzmem_dev, area->size,
+				  area->vaddr, area->paddr);
+		return ret;
+	}
+
+	list_add_tail(&area->list, &pool->areas);
+	area = NULL;
+
+	return 0;
+}
+
+/**
+ * qcom_tzmem_pool_new() - Create a new TZ memory pool.
+ * @config: Pool configuration.
+ *
+ * Create a new pool of memory suitable for sharing with the TrustZone.
+ *
+ * Must not be used in atomic context.
+ *
+ * Return: New memory pool address or ERR_PTR() on error.
+ */
+struct qcom_tzmem_pool *
+qcom_tzmem_pool_new(const struct qcom_tzmem_pool_config *config)
+{
+	int ret = -ENOMEM;
+
+	might_sleep();
+
+	switch (config->policy) {
+	case QCOM_TZMEM_POLICY_STATIC:
+		if (!config->initial_size)
+			return ERR_PTR(-EINVAL);
+		break;
+	case QCOM_TZMEM_POLICY_MULTIPLIER:
+		if (!config->increment)
+			return ERR_PTR(-EINVAL);
+		break;
+	case QCOM_TZMEM_POLICY_ON_DEMAND:
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	struct qcom_tzmem_pool *pool __free(kfree) = kzalloc(sizeof(*pool),
+							     GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	pool->genpool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!pool->genpool)
+		return ERR_PTR(-ENOMEM);
+
+	gen_pool_set_algo(pool->genpool, gen_pool_best_fit, NULL);
+
+	pool->policy = config->policy;
+	pool->increment = config->increment;
+	pool->max_size = config->max_size;
+	INIT_LIST_HEAD(&pool->areas);
+	spin_lock_init(&pool->lock);
+
+	if (config->initial_size) {
+		ret = qcom_tzmem_pool_add_memory(pool, config->initial_size,
+						 GFP_KERNEL);
+		if (ret) {
+			gen_pool_destroy(pool->genpool);
+			return ERR_PTR(ret);
+		}
+	}
+
+	return no_free_ptr(pool);
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
+	struct qcom_tzmem_area *area, *next;
+	struct qcom_tzmem_chunk *chunk;
+	struct radix_tree_iter iter;
+	bool non_empty = false;
+	void __rcu **slot;
+
+	might_sleep();
+
+	if (!pool)
+		return;
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
+	list_for_each_entry_safe(area, next, &pool->areas, list) {
+		list_del(&area->list);
+		qcom_tzmem_cleanup_area(area);
+		dma_free_coherent(qcom_tzmem_dev, area->size,
+				  area->vaddr, area->paddr);
+		kfree(area);
+	}
+
+	gen_pool_destroy(pool->genpool);
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
+ * @config: Pool configuration.
+ *
+ * Must not be used in atomic context.
+ *
+ * Return: Address of the managed pool or ERR_PTR() on failure.
+ */
+struct qcom_tzmem_pool *
+devm_qcom_tzmem_pool_new(struct device *dev,
+			 const struct qcom_tzmem_pool_config *config)
+{
+	struct qcom_tzmem_pool *pool;
+	int ret;
+
+	pool = qcom_tzmem_pool_new(config);
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
+static bool qcom_tzmem_try_grow_pool(struct qcom_tzmem_pool *pool,
+				     size_t requested, gfp_t gfp)
+{
+	size_t current_size = gen_pool_size(pool->genpool);
+
+	lockdep_assert_held(&pool->lock);
+
+	if (pool->max_size && (current_size + requested) > pool->max_size)
+		return false;
+
+	switch (pool->policy) {
+	case QCOM_TZMEM_POLICY_STATIC:
+		return false;
+	case QCOM_TZMEM_POLICY_MULTIPLIER:
+		requested = current_size * pool->increment;
+	case QCOM_TZMEM_POLICY_ON_DEMAND:
+		break;
+	}
+
+	return !qcom_tzmem_pool_add_memory(pool, requested, gfp);
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
+ * Return:
+ * Address of the allocated buffer or NULL if no more memory can be allocated.
+ * The buffer must be released using qcom_tzmem_free().
+ */
+void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp)
+{
+	unsigned long vaddr;
+	int ret;
+
+	if (!size)
+		return NULL;
+
+	size = PAGE_ALIGN(size);
+
+	struct qcom_tzmem_chunk *chunk __free(kfree) = kzalloc(sizeof(*chunk),
+							       gfp);
+	if (!chunk)
+		return NULL;
+
+	guard(spinlock_irqsave)(&pool->lock);
+
+again:
+	vaddr = gen_pool_alloc(pool->genpool, size);
+	if (!vaddr) {
+		if (qcom_tzmem_try_grow_pool(pool, size, gfp))
+			goto again;
+
+		return NULL;
+	}
+
+	chunk->paddr = gen_pool_virt_to_phys(pool->genpool, vaddr);
+	chunk->size = size;
+	chunk->owner = pool;
+
+	scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
+		ret = radix_tree_insert(&qcom_tzmem_chunks, vaddr, chunk);
+		if (ret) {
+			gen_pool_free(pool->genpool, vaddr, size);
+			return NULL;
+		}
+
+		chunk = NULL;
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
+	scoped_guard(spinlock_irqsave, &chunk->owner->lock)
+		gen_pool_free(chunk->owner->genpool, (unsigned long)vaddr,
+			      chunk->size);
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
+ * Returns: Physical address of the buffer.
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
index 000000000000..8fa8a3eb940e
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_tzmem.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023-2024 Linaro Ltd.
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
index 000000000000..b83b63a0c049
--- /dev/null
+++ b/include/linux/firmware/qcom/qcom_tzmem.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023-2024 Linaro Ltd.
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
+/**
+ * enum qcom_tzmem_policy - Policy for pool growth.
+ */
+enum qcom_tzmem_policy {
+	/**< Static pool, never grow above initial size. */
+	QCOM_TZMEM_POLICY_STATIC = 1,
+	/**< When out of memory, add increment * current size of memory. */
+	QCOM_TZMEM_POLICY_MULTIPLIER,
+	/**< When out of memory add as much as is needed until max_size. */
+	QCOM_TZMEM_POLICY_ON_DEMAND,
+};
+
+/**
+ * struct qcom_tzmem_pool_config - TZ memory pool configuration.
+ * @initial_size: Number of bytes to allocate for the pool during its creation.
+ * @policy: Pool size growth policy.
+ * @increment: Used with policies that allow pool growth.
+ * @max_size: Size above which the pool will never grow.
+ */
+struct qcom_tzmem_pool_config {
+	size_t initial_size;
+	enum qcom_tzmem_policy policy;
+	size_t increment;
+	size_t max_size;
+};
+
+struct qcom_tzmem_pool *
+qcom_tzmem_pool_new(const struct qcom_tzmem_pool_config *config);
+void qcom_tzmem_pool_free(struct qcom_tzmem_pool *pool);
+struct qcom_tzmem_pool *
+devm_qcom_tzmem_pool_new(struct device *dev,
+			 const struct qcom_tzmem_pool_config *config);
+
+void *qcom_tzmem_alloc(struct qcom_tzmem_pool *pool, size_t size, gfp_t gfp);
+void qcom_tzmem_free(void *ptr);
+
+DEFINE_FREE(qcom_tzmem, void *, if (_T) qcom_tzmem_free(_T))
+
+phys_addr_t qcom_tzmem_to_phys(void *ptr);
+
+#endif /* __QCOM_TZMEM */
-- 
2.40.1


