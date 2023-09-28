Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB6F7B1721
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjI1JVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjI1JVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C8C193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:04 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3248e90f032so156270f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892862; x=1696497662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNsWyjWC2KILQ6F2y3+8u8Tzek7qyiCAnIFfqnam7kU=;
        b=zgRxP7rkh+9hH2pVaQ3+zo+yXjMhu//mQdL/h8JEc7x+qDdRL5Iw/sIlcMTXLF9Tu1
         6cSaS1DlfJPrP4d3CGcWQiuJxA91W9RQzuXtHfvnx5wOra4DwY6gzZGUAk+f3pOobyh6
         9rjYmyqt84X9e1b/gTKnFyEEyKVD5+yJRI8Kyz474vxVcbizenVzDZ/HteaO92V8qHmc
         cLOMnwl2TI2sy80roqYIU8I8DwMOKb4Km/uHArUAgiChfaSIsjRay6xiI4oHVFV71vXV
         pg4mpqkDhbrqc/yipibwKZxvkhXHrdkaK3JCu/+27rGXvA6/Iw25jj4piAYIdetYK1sQ
         DGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892862; x=1696497662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNsWyjWC2KILQ6F2y3+8u8Tzek7qyiCAnIFfqnam7kU=;
        b=UyNLEf0DfZu6Et8N7th9FN0Hq/Zoar2Yn0TOULh0+hL8eqyzHrP05XiQWKVuGvKMuo
         7VVj6DMeUrihNThehWNe6CipkoMw0kuZGoh47b+Lj249Z05cdOZo5a1lulNsEoMQ80Iy
         gDP6fo20WcYCp1DxpUOnbywFdbig/3Yo6fwN6VlD65I2WsBZLGhvqKacu0BiDj2uIO37
         SzPcqcDypJP9/9x7yuSIZan1j0hFUh0zHi+h69yy05tWg2TSun6OuAbOAHfNt6jR/J+z
         y4jTcyKHC++tELtp5Ra0FE5arfOP3aTAPvRPN11175Fz4fT2gAEniJMYPM4/38zEceU9
         DOfQ==
X-Gm-Message-State: AOJu0YyDycLxygFUl70evDEUyCFuC+jPlupD4v79nqzxImDNsOMuHzJm
        A8ixyEWCSdESMBeXtmjcd+/Ifw==
X-Google-Smtp-Source: AGHT+IGErik4GB0DX/LD8k7UI+HrXtS8QQ+fAL2DZtgakvSe42h30GC6IAtMfeKkSokNwJ0Mencl2A==
X-Received: by 2002:a5d:4f8e:0:b0:320:aea6:abb9 with SMTP id d14-20020a5d4f8e000000b00320aea6abb9mr645907wru.6.1695892862383;
        Thu, 28 Sep 2023 02:21:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 02/11] firmware: qcom: scm: add a dedicated SCM memory allocator
Date:   Thu, 28 Sep 2023 11:20:31 +0200
Message-Id: <20230928092040.9420-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
References: <20230928092040.9420-1-brgl@bgdev.pl>
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

We have several SCM calls that require passing buffers to the trustzone
on top of the SMC core which allocated memory for calls that require
more than 4 arguments.

Currently every user does their own thing which leads to code
duplication. Many users call dma_alloc_coherent() for every call which
is terribly unperformant (speed- and size-wise).

As all but one calls allocate memory just for the duration of the call,
we don't need a lot of memory. A single pool for that purpose is enough.
Let's create a genalloc pool dealing out chunks of coherent, page-aligned
memory suitable for SCM calls that also provides a function for mapping
virtual to physical addresses.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/Makefile         |   2 +-
 drivers/firmware/qcom/qcom_scm-mem.c   | 134 +++++++++++++++++++++++++
 drivers/firmware/qcom/qcom_scm.c       |   5 +
 drivers/firmware/qcom/qcom_scm.h       |   7 ++
 include/linux/firmware/qcom/qcom_scm.h |   7 ++
 5 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/qcom/qcom_scm-mem.c

diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
index c9f12ee8224a..b9b117f22e9f 100644
--- a/drivers/firmware/qcom/Makefile
+++ b/drivers/firmware/qcom/Makefile
@@ -4,6 +4,6 @@
 #
 
 obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
-qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o qcom_scm-mem.o
 obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
 obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qcom/qcom_scm-mem.c
new file mode 100644
index 000000000000..eafecbe23770
--- /dev/null
+++ b/drivers/firmware/qcom/qcom_scm-mem.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/genalloc.h>
+#include <linux/gfp.h>
+#include <linux/moduleparam.h>
+#include <linux/radix-tree.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "qcom_scm.h"
+
+static size_t qcom_scm_mem_pool_size = SZ_2M;
+module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
+		   ulong, 0400);
+
+struct {
+	struct device *dev;
+	void *vbase;
+	phys_addr_t pbase;
+	size_t size;
+	struct gen_pool *pool;
+	struct radix_tree_root chunks;
+	spinlock_t lock;
+} qcom_scm_mem;
+
+struct qcom_scm_mem_chunk {
+	phys_addr_t paddr;
+	size_t size;
+};
+
+void *qcom_scm_mem_alloc(size_t size, gfp_t gfp)
+{
+	struct qcom_scm_mem_chunk *chunk;
+	unsigned long vaddr;
+	int ret;
+
+	if (!size)
+		return ZERO_SIZE_PTR;
+
+	size = roundup(size, 1 << PAGE_SHIFT);
+
+	chunk = kzalloc(sizeof(*chunk), gfp);
+	if (!chunk)
+		return NULL;
+
+	vaddr = gen_pool_alloc(qcom_scm_mem.pool, size);
+	if (!vaddr) {
+		kfree(chunk);
+		return NULL;
+	}
+
+	chunk->paddr = gen_pool_virt_to_phys(qcom_scm_mem.pool,
+					     (unsigned long)vaddr);
+	chunk->size = size;
+
+	scoped_guard(spinlock_irqsave, &qcom_scm_mem.lock) {
+		ret = radix_tree_insert(&qcom_scm_mem.chunks, vaddr, chunk);
+		if (ret) {
+			gen_pool_free(qcom_scm_mem.pool, (unsigned long)vaddr,
+				      chunk->size);
+			kfree(chunk);
+			return NULL;
+		}
+	}
+
+	return (void *)vaddr;
+}
+EXPORT_SYMBOL_GPL(qcom_scm_mem_alloc);
+
+void qcom_scm_mem_free(void *vaddr)
+{
+	struct qcom_scm_mem_chunk *chunk;
+
+	if (!vaddr)
+		return;
+
+	scoped_guard(spinlock_irqsave, &qcom_scm_mem.lock)
+		chunk = radix_tree_delete_item(&qcom_scm_mem.chunks,
+					       (unsigned long)vaddr, NULL);
+
+	if (!chunk) {
+		WARN(1, "Virtual address %p not allocated for SCM", vaddr);
+		return;
+	}
+
+	gen_pool_free(qcom_scm_mem.pool, (unsigned long)vaddr, chunk->size);
+	kfree(chunk);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_mem_free);
+
+phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
+{
+	struct qcom_scm_mem_chunk *chunk;
+
+	guard(spinlock_irqsave)(&qcom_scm_mem.lock);
+
+	chunk = radix_tree_lookup(&qcom_scm_mem.chunks, (unsigned long)vaddr);
+	if (!chunk)
+		return 0;
+
+	return chunk->paddr;
+}
+
+int qcom_scm_mem_enable(struct device *dev)
+{
+	INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
+	spin_lock_init(&qcom_scm_mem.lock);
+	qcom_scm_mem.dev = dev;
+	qcom_scm_mem.size = qcom_scm_mem_pool_size;
+
+	qcom_scm_mem.vbase = dmam_alloc_coherent(dev, qcom_scm_mem.size,
+						 &qcom_scm_mem.pbase,
+						 GFP_KERNEL);
+	if (!qcom_scm_mem.vbase)
+		return -ENOMEM;
+
+	qcom_scm_mem.pool = devm_gen_pool_create(dev, PAGE_SHIFT, -1,
+						 "qcom-scm-mem");
+	if (!qcom_scm_mem.pool)
+		return -ENOMEM;
+
+	gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
+
+	return gen_pool_add_virt(qcom_scm_mem.pool,
+				 (unsigned long)qcom_scm_mem.vbase,
+				 qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
+}
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index c2c7fafef34b..258aa0782754 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1880,6 +1880,11 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (of_property_read_bool(pdev->dev.of_node, "qcom,sdi-enabled"))
 		qcom_scm_disable_sdi();
 
+	ret = qcom_scm_mem_enable(scm->dev);
+	if (ret)
+		return dev_err_probe(scm->dev, ret,
+				     "Failed to enable SCM memory\n");
+
 	/*
 	 * Initialize the QSEECOM interface.
 	 *
diff --git a/drivers/firmware/qcom/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
index 7b68fa820495..8c97e3906afa 100644
--- a/drivers/firmware/qcom/qcom_scm.h
+++ b/drivers/firmware/qcom/qcom_scm.h
@@ -4,6 +4,10 @@
 #ifndef __QCOM_SCM_INT_H
 #define __QCOM_SCM_INT_H
 
+#include <linux/types.h>
+
+struct device;
+
 enum qcom_scm_convention {
 	SMC_CONVENTION_UNKNOWN,
 	SMC_CONVENTION_LEGACY,
@@ -165,4 +169,7 @@ static inline int qcom_scm_remap_error(int err)
 	return -EINVAL;
 }
 
+int qcom_scm_mem_enable(struct device *dev);
+phys_addr_t qcom_scm_mem_to_phys(void *vaddr);
+
 #endif
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index ccaf28846054..291ef8fd21b0 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -5,7 +5,9 @@
 #ifndef __QCOM_SCM_H
 #define __QCOM_SCM_H
 
+#include <linux/cleanup.h>
 #include <linux/err.h>
+#include <linux/gfp.h>
 #include <linux/types.h>
 #include <linux/cpumask.h>
 
@@ -61,6 +63,11 @@ enum qcom_scm_ice_cipher {
 
 bool qcom_scm_is_available(void);
 
+void *qcom_scm_mem_alloc(size_t size, gfp_t gfp);
+void qcom_scm_mem_free(void *vaddr);
+
+DEFINE_FREE(qcom_scm_mem, void *, if (_T) qcom_scm_mem_free(_T));
+
 int qcom_scm_set_cold_boot_addr(void *entry);
 int qcom_scm_set_warm_boot_addr(void *entry);
 void qcom_scm_cpu_power_down(u32 flags);
-- 
2.39.2

