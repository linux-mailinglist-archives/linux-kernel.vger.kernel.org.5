Return-Path: <linux-kernel+bounces-34267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AD8376CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2722B256CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4C48CD3;
	Mon, 22 Jan 2024 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T05qkwEC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BA82136B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705964254; cv=none; b=TTBbhnLRx857/uNmYSUF6RI2yky4GcGwqaW9WoqFE0e8QK6CpXqhdw6dNXkFl/SegXn1WVKVgezecVePG+7sbsmvCkUPgV0OIXQWy4UFRV07mTJiZu0eyQSaz7orQ09eumwUz+vAefZV90BhkQnEmOmQqa88sCJdGMgJSsd7HAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705964254; c=relaxed/simple;
	bh=U1+KXcli4NL1ac1CPhNG+FdVI8hN+zTTVbZpOOz+6tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPZST8pGl+fXS9SZMtsD4CJfParcRDft8bTsbvgfqCcbzGJk2Zx3wWZxMCWpSEdW9ktjfbATiDPOcOWSk9PaD+bDN9lMD0t5OselkcOn7mJitFFS/M1BKrxrJB/8nzbTSCQ2gZQgFXSYFrcFeU60OObNpvjenNUSystTRrYCyXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T05qkwEC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso44839825e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705964249; x=1706569049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkT1f8/auJS4w5tPSadT4tBL2vbp3PChzChd9rePwv0=;
        b=T05qkwECDeJbqNuo9xfac+xmo7BjyxF2yPrguHGFXqLAxfUAANrQK1lGpbckCqodx4
         GbhxMI0Nk6jy5ai/7nISDDMelTVmelWdfewxX4kOAgW7bYmIXMwRQ8zu8wJqjBzD6w91
         LasK5jyxIzHyC+CkHQaiFUiBALPowBPNIdxx+AtrmUu/KWBiLiKgBiH2HljZ5TTVW6n4
         3+mEpWpnxdBATX6+eEYS799+MwUVQIPxfbHDj5O5cRWvH2bfa4F0peLEDSpeheHBznYV
         xG5qJDWm3EOWX8aHjSZNBI2FQZTTDcWXMQY+5Xz/053cz2Id7Nm3nbLzOFw3nFLYnhQf
         5MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705964249; x=1706569049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EkT1f8/auJS4w5tPSadT4tBL2vbp3PChzChd9rePwv0=;
        b=T6M/e+MmM8w5rfM9jZ0PkMaH6Lgbjh1Xz1oPRfH092tjC1+qzy+ckh+NlPxmYH4fVD
         qY6nMy+YJKARw+fpLyJpoi++Lvr4AHuUdmwQ7qRGe939Vewra+hGky2YY9uDOwzxqvlJ
         7nP6kEAfYwsXdi3sq4/NYG3k5zBA32FEWdTaEZp/vdQ+WrHy65TCyWJf/lfRVfxvQxJY
         mgV5nImgBoUMai3QfH1Fx3mLfTsx1QkmAWE0kRYI7t3yqV3AonUvZ4jurNcZn7CLstq3
         9tXlUlC4f9jSl9eHN+NbScmT126o34UpNaUJUKJzM/5SZUi904dOxx5EtCLX07zvA0b2
         icxw==
X-Gm-Message-State: AOJu0Yy6TUVYmtOO3ArcIlFfhzs7J8N1cDSt/rJm7Guh+21eed0KPu1K
	ZVIAw4HBEdo+m3d1RbuHG4ujdOD5tADQWdKYqOy8UsH3wqSQiZDuVLH7tlJdseE=
X-Google-Smtp-Source: AGHT+IHkc9S01pb4+H9jQwA2GpQSFpzYPum9UGXBQkktPuNZUGJVOV7WCzXUX8o5u0vmioR+ISGUrw==
X-Received: by 2002:a05:600c:5250:b0:40e:6930:4c99 with SMTP id fc16-20020a05600c525000b0040e69304c99mr1381965wmb.113.1705964248744;
        Mon, 22 Jan 2024 14:57:28 -0800 (PST)
Received: from gpeter-l.lan (host-92-18-76-30.as13285.net. [92.18.76.30])
        by smtp.gmail.com with ESMTPSA id fa26-20020a05600c519a00b0040e89ff10f5sm19776847wmb.1.2024.01.22.14.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 14:57:28 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	chanho61.park@samsung.com,
	semen.protsenko@linaro.org
Cc: kernel-team@android.com,
	peter.griffin@linaro.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	linux-fsd@tesla.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/9] soc: samsung: exynos-pmu: Add exynos_pmu_update/read/write APIs and SoC quirks
Date: Mon, 22 Jan 2024 22:57:03 +0000
Message-ID: <20240122225710.1952066-3-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122225710.1952066-1-peter.griffin@linaro.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer Exynos SoCs have atomic set/clear bit hardware for PMU registers as
these registers can be accessed by multiple masters. Some platforms also
protect the PMU registers for security hardening reasons so they can't be
written by normal world and are only write acessible in el3 via a SMC call.

Add support for both of these usecases using SoC specific quirks that are
determined from the DT compatible string.

Drivers which need to read and write PMU registers should now use these
new exynos_pmu_*() APIs instead of obtaining a regmap using
syscon_regmap_lookup_by_phandle()

Depending on the SoC specific quirks, the exynos_pmu_*() APIs will access
the PMU register in the appropriate way.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/soc/samsung/exynos-pmu.c       | 209 ++++++++++++++++++++++++-
 drivers/soc/samsung/exynos-pmu.h       |   4 +
 include/linux/soc/samsung/exynos-pmu.h |  28 ++++
 3 files changed, 234 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 250537d7cfd6..e9e933ede568 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -5,6 +5,7 @@
 //
 // Exynos - CPU PMU(Power Management Unit) support
 
+#include <linux/arm-smccc.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/mfd/core.h>
@@ -12,29 +13,204 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/regmap.h>
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
 #include "exynos-pmu.h"
 
+/**
+ * DOC: Quirk flags for different Exynos PMU IP-cores
+ *
+ * This driver supports multiple Exynos based SoCs, each of which might have a
+ * different set of registers and features supported.
+ *
+ * Quirk flags described below serve the purpose of telling the driver about
+ * mentioned SoC traits, and can be specified in driver data for each particular
+ * supported device.
+ *
+ * %QUIRK_HAS_ATOMIC_BITSETHW: PMU IP has special atomic bit set/clear HW
+ * to protect against PMU registers being accessed from multiple bus masters.
+ *
+ * %QUIRK_PMU_ALIVE_WRITE_SEC: PMU registers are *not* write accesible from
+ * normal world. This is found on some SoCs as a security hardening measure. PMU
+ * registers on these SoCs can only be written via a SMC call and registers are
+ * checked by EL3 firmware against an allowlist before the write can procede.
+ * Note: This quirk should only be set for platforms whose el3 firmware
+ * implements the TENSOR_SMC_PMU_SEC_REG interface below.
+ */
+
+#define QUIRK_HAS_ATOMIC_BITSETHW		BIT(0)
+#define QUIRK_PMU_ALIVE_WRITE_SEC		BIT(1)
+
+#define PMUALIVE_MASK GENMASK(14, 0)
+
 struct exynos_pmu_context {
 	struct device *dev;
 	const struct exynos_pmu_data *pmu_data;
+	struct regmap *pmureg;
+	void __iomem *pmu_base_addr;
+	phys_addr_t pmu_base_pa;
+	/* protect PMU reg atomic update operations */
+	spinlock_t update_lock;
 };
 
-void __iomem *pmu_base_addr;
 static struct exynos_pmu_context *pmu_context;
 
+/*
+ * Some SoCs are configured so that PMU_ALIVE registers can only be written
+ * from el3. As Linux needs to write some of these registers, the following
+ * SMC register read/write/read,write,modify interface is used.
+ *
+ * Note: This SMC interface is known to be implemented on gs101 and derivative
+ * SoCs.
+ */
+#define TENSOR_SMC_PMU_SEC_REG			(0x82000504)
+#define TENSOR_PMUREG_READ			0
+#define TENSOR_PMUREG_WRITE			1
+#define TENSOR_PMUREG_RMW			2
+
+int set_priv_reg(phys_addr_t reg, u32 val)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
+		      reg,
+		      TENSOR_PMUREG_WRITE,
+		      val, 0, 0, 0, 0, &res);
+
+	if (res.a0)
+		pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
+
+	return (int)res.a0;
+}
+
+int rmw_priv_reg(phys_addr_t reg, u32 mask, u32 val)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG,
+		      reg,
+		      TENSOR_PMUREG_RMW,
+		      mask, val, 0, 0, 0, &res);
+
+	if (res.a0)
+		pr_warn("%s(): SMC failed: %lu\n", __func__, res.a0);
+
+	return (int)res.a0;
+}
+
+/*
+ * For SoCs that have set/clear bit hardware (as indicated by
+ * QUIRK_HAS_ATOMIC_BITSETHW) this function can be used when
+ * the PMU register will be accessed by multiple masters.
+ *
+ * For example, to set bits 13:8 in PMU reg offset 0x3e80
+ * exynos_pmu_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
+ *
+ * To clear bits 13:8 in PMU offset 0x3e80
+ * exynos_pmu_set_bit_atomic(0x3e80, 0x0, 0x3f00);
+ */
+static inline void exynos_pmu_set_bit_atomic(unsigned int offset,
+					     u32 val, u32 mask)
+{
+	unsigned long flags;
+	unsigned int i;
+
+	spin_lock_irqsave(&pmu_context->update_lock, flags);
+	for (i = 0; i < 32; i++) {
+		if (mask & BIT(i)) {
+			if (val & BIT(i)) {
+				offset |= 0xc000;
+				pmu_raw_writel(i, offset);
+			} else {
+				offset |= 0x8000;
+				pmu_raw_writel(i, offset);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&pmu_context->update_lock, flags);
+}
+
+int exynos_pmu_update_bits(unsigned int offset, unsigned int mask,
+			   unsigned int val)
+{
+	if (pmu_context->pmu_data &&
+	    pmu_context->pmu_data->quirks & QUIRK_PMU_ALIVE_WRITE_SEC)
+		return rmw_priv_reg(pmu_context->pmu_base_pa + offset,
+				    mask, val);
+
+	return regmap_update_bits(pmu_context->pmureg, offset, mask, val);
+}
+EXPORT_SYMBOL(exynos_pmu_update_bits);
+
 void pmu_raw_writel(u32 val, u32 offset)
 {
-	writel_relaxed(val, pmu_base_addr + offset);
+	if (pmu_context->pmu_data &&
+	    pmu_context->pmu_data->quirks & QUIRK_PMU_ALIVE_WRITE_SEC)
+		return (void)set_priv_reg(pmu_context->pmu_base_pa + offset,
+					  val);
+
+	return writel_relaxed(val, pmu_context->pmu_base_addr + offset);
 }
 
 u32 pmu_raw_readl(u32 offset)
 {
-	return readl_relaxed(pmu_base_addr + offset);
+	return readl_relaxed(pmu_context->pmu_base_addr + offset);
+}
+
+int exynos_pmu_read(unsigned int offset, unsigned int *val)
+{
+	if (!pmu_context)
+		return -ENODEV;
+
+	/*
+	 * For platforms that protect PMU registers they
+	 * are still accessible to read from normal world
+	 */
+	return regmap_read(pmu_context->pmureg, offset, val);
+}
+EXPORT_SYMBOL(exynos_pmu_read);
+
+int exynos_pmu_write(unsigned int offset, unsigned int val)
+{
+	if (!pmu_context)
+		return -ENODEV;
+
+	if (pmu_context->pmu_data &&
+	    pmu_context->pmu_data->quirks & QUIRK_PMU_ALIVE_WRITE_SEC)
+		return set_priv_reg(pmu_context->pmu_base_pa + offset, val);
+
+	return regmap_write(pmu_context->pmureg, offset, val);
+}
+EXPORT_SYMBOL(exynos_pmu_write);
+
+int exynos_pmu_update(unsigned int offset, unsigned int mask, unsigned int val)
+{
+	int ret = 0;
+
+	if (!pmu_context)
+		return -ENODEV;
+
+	if (pmu_context->pmu_data &&
+	    pmu_context->pmu_data->quirks & QUIRK_HAS_ATOMIC_BITSETHW) {
+		/*
+		 * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
+		 * as the target registers can be accessed by multiple masters.
+		 */
+		if (offset > PMUALIVE_MASK)
+			return exynos_pmu_update_bits(offset, mask, val);
+
+		exynos_pmu_set_bit_atomic(offset, val, mask);
+
+	} else {
+		return exynos_pmu_update_bits(offset, mask, val);
+	}
+
+	return ret;
 }
+EXPORT_SYMBOL(exynos_pmu_update);
 
 void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 {
@@ -75,11 +251,18 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 #define exynos_pmu_data_arm_ptr(data)	NULL
 #endif
 
+static const struct exynos_pmu_data gs101_pmu_data = {
+	.quirks = QUIRK_HAS_ATOMIC_BITSETHW | QUIRK_PMU_ALIVE_WRITE_SEC,
+};
+
 /*
  * PMU platform driver and devicetree bindings.
  */
 static const struct of_device_id exynos_pmu_of_device_ids[] = {
 	{
+		.compatible = "google,gs101-pmu",
+		.data = &gs101_pmu_data,
+	}, {
 		.compatible = "samsung,exynos3250-pmu",
 		.data = exynos_pmu_data_arm_ptr(exynos3250_pmu_data),
 	}, {
@@ -125,18 +308,30 @@ EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
 
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
+	struct resource *res;
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pmu_base_addr))
-		return PTR_ERR(pmu_base_addr);
-
 	pmu_context = devm_kzalloc(&pdev->dev,
 			sizeof(struct exynos_pmu_context),
 			GFP_KERNEL);
 	if (!pmu_context)
 		return -ENOMEM;
+
+	pmu_context->pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pmu_context->pmu_base_addr))
+		return PTR_ERR(pmu_context->pmu_base_addr);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	pmu_context->pmu_base_pa = res->start;
+	pmu_context->pmureg = exynos_get_pmu_regmap();
+	if (IS_ERR(pmu_context->pmureg))
+		return PTR_ERR(pmu_context->pmureg);
+
+	spin_lock_init(&pmu_context->update_lock);
 	pmu_context->dev = dev;
 	pmu_context->pmu_data = of_device_get_match_data(dev);
 
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 1c652ffd79b4..570c6e4dc8c3 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -25,8 +25,12 @@ struct exynos_pmu_data {
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
 	void (*powerdown_conf_extra)(enum sys_powerdown);
+	u32 quirks;
 };
 
+int set_priv_reg(phys_addr_t reg, u32 val);
+int rmw_priv_reg(phys_addr_t reg, u32 mask, u32 val);
+
 extern void __iomem *pmu_base_addr;
 
 #ifdef CONFIG_EXYNOS_PMU_ARM_DRIVERS
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index a4f5516cc956..2c5ce21fb00b 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -21,11 +21,39 @@ enum sys_powerdown {
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 #ifdef CONFIG_EXYNOS_PMU
 extern struct regmap *exynos_get_pmu_regmap(void);
+extern int exynos_pmu_update_bits(unsigned int offset, unsigned int mask,
+				  unsigned int val);
+extern int exynos_pmu_update(unsigned int offset, unsigned int mask,
+			     unsigned int val);
+extern int exynos_pmu_write(unsigned int offset, unsigned int val);
+extern int exynos_pmu_read(unsigned int offset, unsigned int *val);
 #else
 static inline struct regmap *exynos_get_pmu_regmap(void)
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline int exynos_pmu_update_bits(unsigned int offset, unsigned int mask,
+					 unsigned int val);
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int exynos_pmu_update(unsigned int offset, unsigned int mask,
+				    unsigned int val);
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int exynos_pmu_write(unsigned int offset, unsigned int val)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline int exynos_pmu_read(unsigned int offset, unsigned int *val)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 #endif /* __LINUX_SOC_EXYNOS_PMU_H */
-- 
2.43.0.429.g432eaa2c6b-goog


