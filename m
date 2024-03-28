Return-Path: <linux-kernel+bounces-122926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 867A588FF96
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C351F266C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888AC80029;
	Thu, 28 Mar 2024 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEmLn1ns"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F07D411
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630263; cv=none; b=teY/SFDqXrSY4wSTwKv2LVGgSRzPRLkKLJ8ccQFmoSunwFEt5OepjplyXgHFvG/1VxrN6/oqCfsszeOB3sIIDZhSkFHsuB/T5tOuwE0ShkJXJli1YVHlAj/UtxDk+JPjOOsfyr4jG+3bvTk57iVqtfEIfXVS3yPRfuTPwjwjtkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630263; c=relaxed/simple;
	bh=rdN1pFeha0f9tKG4t+JjNFR432HjwkQ4D1LmY4k7tMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EGCLyqdMTimbqoxwOBnuts+ZdxUX3XrxubOujPMI3BMmqQS4bMVWWRoallgaA4iDm9nupNWuzHUTFcSXvZSrsOjry5Tp8yTo6d+5rQIS3qsNCY1YnxY1emZFWMf62vrskTH/pOGuJhgV1860jCktKKqMcCJSOrhj1FCML0sAsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NEmLn1ns; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4148c6132b4so11693555e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711630258; x=1712235058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxobAC0/bca3Of9tKqehzUHK1AlBIsmrq33t7pWCqwQ=;
        b=NEmLn1nsrxfHXQSWoH/gyrYhPKpSCykM89FAyVmTLRKmGybk/EcSNUnZLfnxb3ZYnL
         SEvgEx/E0IiODWG1l5fJV+dlTPLQydJB6Nr0yyaAFI5+qzt9bvZi4tCkJnD25tSEwqOA
         GADUeOiHr2RGo4XMQlQHVdaYCAOKf73T4ueZxf35T9FgsPySIFaO+UFsHZewDGY1pCi0
         SJ0N5r1+QxYwgqM5ZxYWGw2YFduee8w9G+AYCO+ggB3yqo7KYQJcwnOpE70IE0hIKkPC
         V0kSReeNmlS68e2uEuCrfPyiP07z4qIMLnKM7RrZVFi9YzCZdknjZN3zteMxcJ21Xs1s
         IqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630258; x=1712235058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxobAC0/bca3Of9tKqehzUHK1AlBIsmrq33t7pWCqwQ=;
        b=g4Si3l3dwVfRuyZ5d3CxNoA7q0HfkffQTdkVKNSwVRaQnwbzUsQMux0sihxy9dLlNW
         Lit9QAuzCih6CXKtY+4Y8sqW1aS/ZHce231B4jGrv9tO09/iPVBsyyT1dfuEgk7xhOpu
         7pR9p+BeEVm582JqgMRu1xYJlJd4DMkrFO1aIvBBKeRG5k56s11wG40rc1lMg41vPVsj
         o0ZX05YbhCUSyX55Lp02Sp/s1rr59z4Rg6xg6v9rAgq2aaT4bmk2Ep0PdbRiGY/YthOP
         DrzlsQdE5dEORLgD1ZUgsboHbPpNL4vY66Wq7tG0l5fFhxIHufa4+QL6+R5VLW0mtpJt
         EDBg==
X-Forwarded-Encrypted: i=1; AJvYcCXhVCQ2edh1omW+uK4+nqRPgtbTWxtbiTJdmcrx11HLKj3bvVJaYl3LLZ2a56VbCLMgHz3lppaA92DxW4WhE7s5KvxHxVpDAFcv3Pfh
X-Gm-Message-State: AOJu0YxFLH3g2ojyF2Z6G+CaVsvCWQO3JnoeLTQMWY4NeB6QQxaNEL29
	GxhxNs2bShH4aRZAIYKkNYjSjQULr+f2iIW95ty1dHMHMcypgdmJm+gg80X2n6k=
X-Google-Smtp-Source: AGHT+IG5L9BPtVxCb3WgLIfWQpYrth5CdCVN7VgA0GMTCu7jLYCVSgCGpYDqwpd3RaqFeq+q26Sgvg==
X-Received: by 2002:a05:600c:3d99:b0:415:475c:2cb7 with SMTP id bi25-20020a05600c3d9900b00415475c2cb7mr1227108wmb.3.1711630258233;
        Thu, 28 Mar 2024 05:50:58 -0700 (PDT)
Received: from tux.Home ([2a02:c7c:7213:c700:e992:6869:474c:a63f])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c3ac300b00412a31d2e2asm2216700wms.32.2024.03.28.05.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:50:57 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: olivia@selenic.com,
	herbert@gondor.apana.org.au,
	sehi.kim@samsung.com,
	linux-samsung-soc@vger.kernel.org,
	peter.griffin@linaro.org
Cc: krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	alexey.klimov@linaro.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	saravanak@google.com,
	elder@linaro.org,
	tudor.ambarus@linaro.org,
	klimov.linux@gmail.com
Subject: [PATCH REVIEW] hwrng: add exynos Secure World RNG device driver
Date: Thu, 28 Mar 2024 12:50:56 +0000
Message-ID: <20240328125056.1054878-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Exynos TRNG device is controlled by firmware and shared between
non-secure world and secure world. Access to it is exposed via SMC
interface which is implemented here. The firmware code does
additional security checks, start-up test and some checks on resume.

This device is found, for instance, in Google Tensor GS101-family
of devices.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 drivers/char/hw_random/Kconfig           |  12 +
 drivers/char/hw_random/Makefile          |   1 +
 drivers/char/hw_random/exynos-swd-trng.c | 423 +++++++++++++++++++++++
 3 files changed, 436 insertions(+)
 create mode 100644 drivers/char/hw_random/exynos-swd-trng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 442c40efb200..bff7c3ec129a 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -479,6 +479,18 @@ config HW_RANDOM_EXYNOS
 
 	  If unsure, say Y.
 
+config HW_RANDOM_EXYNOS_SWD
+	tristate "Exynos SWD HW random number generator support"
+	default n
+	help
+	  This driver provides kernel-side support for accessing Samsung
+	  TRNG hardware located in secure world using smc calls.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called exynos-swd-trng.
+
+	  If unsure, say N.
+
 config HW_RANDOM_OPTEE
 	tristate "OP-TEE based Random Number Generator support"
 	depends on OPTEE
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 32549a1186dc..ce64929d461a 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_HW_RANDOM_N2RNG) += n2-rng.o
 n2-rng-y := n2-drv.o n2-asm.o
 obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
 obj-$(CONFIG_HW_RANDOM_EXYNOS) += exynos-trng.o
+obj-$(CONFIG_HW_RANDOM_EXYNOS_SWD) += exynos-swd-trng.o
 obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP3_ROM) += omap3-rom-rng.o
diff --git a/drivers/char/hw_random/exynos-swd-trng.c b/drivers/char/hw_random/exynos-swd-trng.c
new file mode 100644
index 000000000000..29def8e6d0b7
--- /dev/null
+++ b/drivers/char/hw_random/exynos-swd-trng.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * exynos-swd-trng.c - Random Number Generator driver for the exynos TRNG
+ * located in secure world
+ * Copyright (C) Linaro Ltd 2024 Alexey Klimov <alexey.klimov@linaro.org>
+ *
+ * Based on downstream driver:
+ * Copyright (C) 2018 Samsung Electronics
+ * Sehee Kim <sehi.kim@samsung.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/delay.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+
+/* DTRNG smc */
+#define SMC_CMD_RANDOM			(0x82001012)
+
+/* DTRNG smc commands */
+#define HWRNG_INIT			(0x0)
+#define HWRNG_EXIT			(0x1)
+#define HWRNG_GET_DATA			(0x2)
+#define HWRNG_RESUME			(0x3)
+
+#define HWRNG_RET_OK			0
+#define HWRNG_RET_INVALID_ERROR		1
+#define HWRNG_RET_RETRY_ERROR		2
+#define HWRNG_RET_INVALID_FLAG_ERROR	3
+#define HWRNG_RET_TEST_ERROR		4
+#define HWRNG_RET_START_UP_TEST_DONE	5
+#define HWRNG_RET_TEST_KAT_ERROR	0xC
+
+#define EXYRNG_START_UP_SIZE		(4096 + 1)
+#define EXYRNG_RETRY_MAX_COUNT		1000000
+#define EXYRNG_START_UP_TEST_MAX_RETRY	2
+
+#define DRVNAME	"exynos_swd_trng"
+
+enum state {
+	INACTIVE = 0,
+	ACTIVE,
+};
+
+struct exyswd_rng {
+	struct hwrng rng;
+	enum state state;
+	struct device *dev;
+	/* to track and protect state of the device */
+	struct mutex lock;
+};
+
+static int __exynos_cm_smc(u64 *arg0, u64 *arg1,
+			   u64 *arg2, u64 *arg3)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(*arg0, *arg1, *arg2, *arg3, 0, 0, 0, 0, &res);
+
+	*arg0 = res.a0;
+	*arg1 = res.a1;
+	*arg2 = res.a2;
+	*arg3 = res.a3;
+
+	return *arg0;
+}
+
+static int exynos_cm_cmd(int cmd)
+{
+	u64 reg0, reg1, reg2, reg3;
+
+	reg0 = SMC_CMD_RANDOM;
+	reg1 = cmd;
+	reg3 = reg2 = 0;
+
+	return __exynos_cm_smc(&reg0, &reg1, &reg2, &reg3);
+}
+
+static int exynos_cm_get_data(u64 *arg0, u64 *arg1,
+			      u64 *arg2, u64 *arg3)
+{
+	*arg0 = SMC_CMD_RANDOM;
+	*arg1 = HWRNG_GET_DATA;
+	*arg3 = 0;
+
+	return __exynos_cm_smc(arg0, arg1, arg2, arg3);
+}
+
+static int exynos_swd_get_data(u64 *arg0, u64 *arg1, u64 *arg2, u64 *arg3,
+			       struct exyswd_rng *exyswd_rng)
+{
+	u32 retry_cnt = 0;
+	int ret;
+
+	while (retry_cnt++ < EXYRNG_RETRY_MAX_COUNT) {
+		ret = exynos_cm_get_data(arg0, arg1, arg2, arg3);
+
+		if (ret == HWRNG_RET_OK)
+			return 0;
+
+		if (ret == HWRNG_RET_RETRY_ERROR) {
+			usleep_range(50, 100);
+			continue;
+		}
+
+		if (ret == HWRNG_RET_TEST_ERROR) {
+			dev_dbg(exyswd_rng->dev, "error while testing\n");
+			return -EAGAIN;
+		}
+
+		return -EFAULT;
+	}
+
+	ret = -EFAULT;
+	dev_warn(exyswd_rng->dev, "retry counter is reached\n");
+	return ret;
+}
+
+static int exynos_swd_init(void)
+{
+	u32 retry_cnt = 0;
+	int ret;
+
+	do {
+		ret = exynos_cm_cmd(HWRNG_INIT);
+		if (ret == HWRNG_RET_RETRY_ERROR) {
+			if (retry_cnt++ > EXYRNG_RETRY_MAX_COUNT)
+				break;
+
+			usleep_range(50, 100);
+		}
+	} while (ret == HWRNG_RET_RETRY_ERROR);
+
+	return ret;
+}
+
+static void exynos_swd_exit(void)
+{
+	u32 retry_cnt = 0;
+
+	while (retry_cnt++ < EXYRNG_RETRY_MAX_COUNT) {
+		if (!exynos_cm_cmd(HWRNG_EXIT))
+			break;
+		usleep_range(50, 100);
+	}
+}
+
+static int exynos_swd_startup_test(struct exyswd_rng *exyswd_rng)
+{
+	u64 reg0, reg1, reg2, reg3;
+	int start_up_size = EXYRNG_START_UP_SIZE;
+	u32 retry_cnt = 0;
+	int ret;
+
+	ret = exynos_swd_init();
+	if (ret != HWRNG_RET_OK) {
+		if (ret == HWRNG_RET_TEST_ERROR) {
+			ret = -EAGAIN;
+			goto out;
+		} else
+			return -EFAULT;
+	}
+
+	while (start_up_size > 0) {
+		/* For start-up test the 3-rd argument has to be set to 1 */
+		reg2 = 1;
+		ret = exynos_cm_get_data(&reg0, &reg1, &reg2, &reg3);
+		if (ret == HWRNG_RET_RETRY_ERROR) {
+			if (retry_cnt++ > EXYRNG_RETRY_MAX_COUNT) {
+				dev_warn(exyswd_rng->dev,
+					 "exceeded retry in start-up test\n");
+				break;
+			}
+			usleep_range(50, 100);
+			continue;
+		}
+
+		if (ret == HWRNG_RET_TEST_ERROR ||
+		    ret == HWRNG_RET_TEST_KAT_ERROR) {
+			dev_err(exyswd_rng->dev,
+				"malfunction of TRNG(HW) is detected\n");
+			return -EFAULT;
+		}
+
+		if (ret == HWRNG_RET_START_UP_TEST_DONE) {
+			dev_dbg(exyswd_rng->dev,
+				"start-up test is already done\n");
+			ret = 0;
+			break;
+		}
+
+		if (ret != HWRNG_RET_OK) {
+			dev_dbg(exyswd_rng->dev, "failed to get random data\n");
+			return -EFAULT;
+		}
+
+		start_up_size -= 32;
+		retry_cnt = 0;
+	}
+
+out:
+	exynos_swd_exit();
+	return ret;
+}
+
+static int exynos_swd_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct exyswd_rng *exyswd_rng =
+				container_of(rng, struct exyswd_rng, rng);
+	u64 reg0, reg1, reg2, reg3;
+	u32 *read_buf = data;
+	u32 read_size = max;
+	u32 retry_cnt;
+	int ret = HWRNG_RET_OK;
+
+	mutex_lock(&exyswd_rng->lock);
+	ret = exynos_swd_init();
+	if (ret != HWRNG_RET_OK) {
+		if (ret == HWRNG_RET_TEST_ERROR) {
+			ret = -EAGAIN;
+			goto out_locked;
+		} else {
+			mutex_unlock(&exyswd_rng->lock);
+			return -EFAULT;
+		}
+	}
+
+	exyswd_rng->state = ACTIVE;
+	mutex_unlock(&exyswd_rng->lock);
+
+	retry_cnt = 0;
+	while (read_size >= 8) {
+		reg2 = 0;
+		ret = exynos_swd_get_data(&reg0, &reg1, &reg2, &reg3, exyswd_rng);
+		if (ret)
+			goto out;
+
+		*(u32 *)(read_buf++) = (u32)reg2;
+		*(u32 *)(read_buf++) = (u32)reg3;
+
+		read_size -= 8;
+		retry_cnt = 0;
+	}
+
+	/*
+	 * rng_buf_size is 32 bytes or cache line usually, it is unlikely
+	 * we will have remaining bytes to read here.
+	 */
+	if (unlikely(read_size > 0)) {
+		reg2 = 0;
+		ret = exynos_swd_get_data(&reg0, &reg1, &reg2, &reg3, exyswd_rng);
+		if (ret)
+			goto out;
+		if (read_size >= 4) {
+			*(u32 *)(read_buf++) = (u32)reg2;
+			read_size -= 4;
+		}
+
+		if (read_size) {
+			memcpy(read_buf, &reg3, read_size);
+			read_size = 0;
+		}
+	}
+
+	ret = max;
+out:
+	mutex_lock(&exyswd_rng->lock);
+out_locked:
+	exynos_swd_exit();
+	exyswd_rng->state = INACTIVE;
+	mutex_unlock(&exyswd_rng->lock);
+
+	return ret;
+}
+
+static int exyswd_rng_probe(struct platform_device *pdev)
+{
+	struct exyswd_rng *exyswd_rng;
+	int ret;
+
+	exyswd_rng = devm_kzalloc(&pdev->dev, sizeof(*exyswd_rng), GFP_KERNEL);
+	if (!exyswd_rng)
+		return -ENOMEM;
+
+	exyswd_rng->rng.name = DRVNAME;
+	exyswd_rng->rng.read = exynos_swd_read;
+	exyswd_rng->rng.quality = 500;
+	exyswd_rng->dev = &pdev->dev;
+	exyswd_rng->state = INACTIVE;
+	mutex_init(&exyswd_rng->lock);
+
+	/*
+	 * Do the startup test first. If it works we've got the device
+	 * and can finish probe().
+	 */
+	ret = exynos_swd_startup_test(exyswd_rng);
+	if (ret) {
+		dev_dbg(&pdev->dev, "start-up test failed\n");
+		return -ENODEV;
+	}
+
+	ret = devm_hwrng_register(&pdev->dev, &exyswd_rng->rng);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register hwrng\n");
+
+	platform_set_drvdata(pdev, exyswd_rng);
+	dev_set_drvdata(&pdev->dev, exyswd_rng);
+
+	dev_info(&pdev->dev, "hwrng registered\n");
+
+	return 0;
+}
+
+static int exyswd_rng_remove(struct platform_device *pdev)
+{
+	struct exyswd_rng *exyswd_rng = platform_get_drvdata(pdev);
+
+	devm_hwrng_unregister(&pdev->dev, &exyswd_rng->rng);
+
+	mutex_lock(&exyswd_rng->lock);
+	if (exyswd_rng->state == ACTIVE) {
+		exynos_swd_exit();
+		exyswd_rng->state = INACTIVE;
+	}
+	mutex_unlock(&exyswd_rng->lock);
+
+	return 0;
+}
+
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
+static int exyswd_rng_suspend(struct device *dev)
+{
+	struct exyswd_rng *exyswd_rng = dev_get_drvdata(dev);
+	int ret = 0;
+
+	mutex_lock(&exyswd_rng->lock);
+	if (exyswd_rng->state) {
+		ret = exynos_cm_cmd(HWRNG_EXIT);
+		if (ret != HWRNG_RET_OK)
+			dev_warn(dev,
+				 "failed to enter suspend, error %d\n", ret);
+	}
+	mutex_unlock(&exyswd_rng->lock);
+
+	return ret;
+}
+
+static int exyswd_rng_resume(struct device *dev)
+{
+	struct exyswd_rng *exyswd_rng = dev_get_drvdata(dev);
+	int ret;
+
+	mutex_lock(&exyswd_rng->lock);
+	ret = exynos_cm_cmd(HWRNG_RESUME);
+	if (ret != HWRNG_RET_OK)
+		dev_warn(dev, "failed to resume, error %d\n", ret);
+	if (exyswd_rng->state) {
+		ret = exynos_cm_cmd(HWRNG_INIT);
+		if (ret != HWRNG_RET_OK)
+			dev_warn(dev,
+				 "failed to init hwrng on resume, error %d\n",
+				 ret);
+	}
+	mutex_unlock(&exyswd_rng->lock);
+
+	return ret;
+}
+#endif
+
+static UNIVERSAL_DEV_PM_OPS(exyswd_rng_pm_ops, exyswd_rng_suspend,
+			    exyswd_rng_resume, NULL);
+
+static struct platform_driver exyswd_rng_driver = {
+	.probe		= exyswd_rng_probe,
+	.remove		= exyswd_rng_remove,
+	.driver		= {
+		.name	= DRVNAME,
+		.owner	= THIS_MODULE,
+		.pm     = &exyswd_rng_pm_ops,
+	},
+};
+
+static struct platform_device *exyswd_rng_pdev;
+
+static int __init exyswd_rng_init(void)
+{
+	int ret;
+
+	exyswd_rng_pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
+	if (IS_ERR(exyswd_rng_pdev))
+		pr_err(DRVNAME ": could not register device: %ld\n",
+		       PTR_ERR(exyswd_rng_pdev));
+
+	ret = platform_driver_register(&exyswd_rng_driver);
+	if (ret) {
+		platform_device_unregister(exyswd_rng_pdev);
+		return ret;
+	}
+
+	pr_info("ExyRNG driver, (c) 2014 Samsung Electronics\n");
+
+	return 0;
+}
+
+static void __exit exyswd_rng_exit(void)
+{
+	platform_driver_unregister(&exyswd_rng_driver);
+	platform_device_unregister(exyswd_rng_pdev);
+}
+
+module_init(exyswd_rng_init);
+module_exit(exyswd_rng_exit);
+
+MODULE_DESCRIPTION("Exynos SWD H/W Random Number Generator driver");
+MODULE_AUTHOR("Alexey Klimov <alexey.klimov@linaro.org>");
+MODULE_AUTHOR("Sehee Kim <sehi.kim@samsung.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0


