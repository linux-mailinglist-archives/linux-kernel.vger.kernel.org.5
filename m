Return-Path: <linux-kernel+bounces-32729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0621D835F77
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E631F241BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEC83A8F9;
	Mon, 22 Jan 2024 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KUycAYxg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190D3A264
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705918930; cv=none; b=kM/nEgMpU4E855W6Ve7xi7o4Pb2UXJ7y8Vylrp99ked2UccsI4S2iBsG887S/iH7Kse1LFgwYkoLIPsdKdl01ONgTyB9eJXZ4vr3QKyrrt8O2Tz9JbUDkSCqWtwNq5LmAm9PBdBU37ys4z8QcGUKCwhwL96/1zHbU7RU/HcYckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705918930; c=relaxed/simple;
	bh=oWGMSc3y3OWX/jh/sRz7wRtg3/H2H+mqO9D2GMNDt0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lz/VZ9d/cuy4vU2pBQBqr5/5rxytez+Hve1OKMtUrYvKSb9SyVyM5MXIzeo/LxZ7sdHY2DXUYyrvIxTdR1aqOxj20wt2o0irsR5hMDhMSRiEd1TQacf5JfpMdPDTAuO799EYt8AgQc5uiMUFemXTJ6xHls//ktzq32yv5sYuhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KUycAYxg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3367a304091so3326763f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705918927; x=1706523727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbIUxd/yz1ViUeB7nIUKABDc0BsVCIo7ulTgPWHB1tk=;
        b=KUycAYxg+AambmVMdeXwbzIRVw6wsKv1V2ORe2BD4dGnI1eET5CUpQ9ma6ISf53wQ6
         WKLzM61bJ4DolkO27QgMx25bjv3RF/CFClwNXSWM3BT+0w5E+UA/b9uUbZw8wuhuyDAf
         Vv0qtfJ3jxgwkLse+nnoSy4pA886/VprZPE3Oa9ceDCtBoDtUzYacEWT+eDKm38nTgyM
         V+c4x4DbfpJ+kcJ0TerB9x0miXGTIGTkOZkQ5Sh7TlFry7Aqke4TJps8zkN001Q3tLxy
         K29TFqxfQt1kKv4wNZNekgRrPdxHfSOX+d9S22eY5PuycwfL7HQ8szX0QokB85cXWBSu
         DVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705918927; x=1706523727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbIUxd/yz1ViUeB7nIUKABDc0BsVCIo7ulTgPWHB1tk=;
        b=JwOYSirhTrSbjAtLxrCXUPtBitlw+9paadPt6S7nAMSfy9QfDiTSl3mQqBi2QP8PS+
         /TwFsOwGN1hOz1Gu6ZI83/5JYP/tfBGQJQedrdt++fl3GUV+MPTk7I9iTKuzxEyx5j/D
         NvbY0E/Lgc1GWXDC//a4t23AtPeEaqYKeYIErm/wd2LmLiEFgEFY9GbAxbS07tLwsYbn
         V4MK+2sa6reVmnYWnkJzesM9x6tdpAiVtG9w3Vy43bEaBVh7fvVxELe5ZmFIGMqFW3W7
         hEH9woNxXPI+ccvIziWeeJcYBnrpZIVAZeUkkMIj5A+iPJS/QINMLCTGHU4SglS03X7P
         f4mw==
X-Gm-Message-State: AOJu0Yz5ixAPKhObBLflJjFj5XtrHEAKsrOSSfX2nLXrg4f5ZqQn1K9A
	i8Gfjwj4/hEDDw/F3YyklWowzczGvlZD68o3NonA1Zjjki6PLmiL8Zwx1VWF/Bk=
X-Google-Smtp-Source: AGHT+IHMQWWXPC/b2SeUMHuMTjOZgxkyOadDgmrJMgWGBGJTFEJWErkQlVvB3LbiEQNq1jHh/9W+ig==
X-Received: by 2002:a5d:5228:0:b0:339:359c:526e with SMTP id i8-20020a5d5228000000b00339359c526emr628494wra.88.1705918926677;
        Mon, 22 Jan 2024 02:22:06 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id q7-20020adffec7000000b0033926505eafsm6377904wrs.32.2024.01.22.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:22:06 -0800 (PST)
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
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [RESEND PATCH v6 01/12] firmware: qcom: add a dedicated TrustZone buffer allocator
Date: Mon, 22 Jan 2024 11:21:46 +0100
Message-Id: <20240122102157.22761-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122102157.22761-1-brgl@bgdev.pl>
References: <20240122102157.22761-1-brgl@bgdev.pl>
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

Provide a set of library functions for creating and managing pool of
memory which is suitable for sharing with the TrustZone, that is:
page-aligned, contiguous and non-cachable as well as provides a way of
mapping of kernel virtual addresses to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS                              |   8 +
 drivers/firmware/qcom/Kconfig            |  19 ++
 drivers/firmware/qcom/Makefile           |   1 +
 drivers/firmware/qcom/qcom_tzmem.c       | 302 +++++++++++++++++++++++
 drivers/firmware/qcom/qcom_tzmem.h       |  13 +
 include/linux/firmware/qcom/qcom_tzmem.h |  28 +++
 6 files changed, 371 insertions(+)
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.c
 create mode 100644 drivers/firmware/qcom/qcom_tzmem.h
 create mode 100644 include/linux/firmware/qcom/qcom_tzmem.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ddc5e1049921..c6b2c01a7e28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18175,6 +18175,14 @@ L:	linux-arm-msm@vger.kernel.org
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
index 000000000000..44a062f2abd4
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
+	dma_addr_t pbase;
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
+				(phys_addr_t)pool->pbase, size, -1);
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
2.40.1


