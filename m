Return-Path: <linux-kernel+bounces-49976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A9484726E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30684B24C1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147141468F8;
	Fri,  2 Feb 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ri/zD90H"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B2144633
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885868; cv=none; b=eHuDCVRVCHj/I/M95aIWsGL0z3PmHgDjEGwWFl7+ziw6P/acKccHwxeR9o/o/1AP6rfEMV6YfkWMhAkwLM8koCp7ysRbCX4sALJbyBrRueAROBBvWFW5r8WVsA7arXUKfhIzmQgIMJQ9TTucuKJxbbzYPetFz5iKVqRlXrrPdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885868; c=relaxed/simple;
	bh=6t6QZ+vd04h5o623Y/oPnVnpZd3kFggzTSvye04BZpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1+KDHi6MEr+2hfXDSdbrxxKQnSLygnzic0v+yKRkvcKM24Z+nGwA/WH8sVpP2y/O06vwsZyPqbO86xCMOsE7X/LOT4T3yVY3drhGG8wTfY3B7RR0bT2Ymwb7rQkmDYblSIkruvQo8fA5h0OvYHXdXXFDPs/gp44u/GtTgW0neE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ri/zD90H; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so173823166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706885864; x=1707490664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vOtWE9SIu2K2cSgBm4FTdm6Wcl9JpeipP+IOKAGQ9o=;
        b=ri/zD90HJMusX7XIYb4RiZyYHxelmpXSfNp2KlPxrqOvsVu+8RQyOaJxXzAULIJViP
         r5ZETdYrh1f40fpPSDGjM1KM8R4PRirQFwNfQf4hpxCarCZMXOfKeAE7ViE+dED5bcmQ
         /7e1Q5nYDvbTSLnSImo7Dh5Pn9OMmi8P9UpbN/IHTy7eSnhn5vAtp6jsDy6vfQFdca39
         LoURwkP7SgcJPeg5hgFNAXMuwF9C6vtLc102M7pbpBj5WYqpCcKtAY9s7O6aiyrj3nmh
         8M9IW2OFvTyjjUc9kXSPwPq4gLm5/FkYUA+Z2DB3amqAlKTclpl+cvKRAzVYyyghKwot
         TXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885864; x=1707490664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vOtWE9SIu2K2cSgBm4FTdm6Wcl9JpeipP+IOKAGQ9o=;
        b=URuFn3tWGBUgMVBjRSZju/48cK8jRg/OmmQWyxqNm4ZjIzVsLRYcFEM7MAIGXUss46
         6oWmNObsyhNqHv+E9JE36Bj2ocP3nFSsYB1r2hs5TYts32PVH785PKQKot/M9sPGIQZY
         lcQmZ0FJp/i/mDfClx+Apu1nGAz8yRud+TpedE3SJMNSmiQ6hCTsKdt+jI6ndmcSdTOb
         LtIrv7U8Y1GuTcQsrn6ZJWdTtmqxDAwvX5eKlk/JJibbdESn3r9aFZhd45TDoBkJVObn
         SXtZ4VNLfZXbfiWPu2p9sKm5Uaa+OrAns1kzyK01v53xdI3BbphLwMSLdAVk5uTKJZrf
         7CoA==
X-Gm-Message-State: AOJu0YzRz3/houk/aJ9cvt4RDU4NFm1i5xExuGNYHtgn7hcHXH7YkABJ
	ZK7UGl1a+c8FNWGknzEzLox+DKxoDbXOy0hyomwtSbpZaCgM60MoG08qQr7wmR4=
X-Google-Smtp-Source: AGHT+IGuwVUZNxdS2rdDNCTTA9Tcg7aHROJv7MsznuFHClHm6dZeXS3joEl1hI1O20hqiF1WiiGOMg==
X-Received: by 2002:a17:907:971a:b0:a37:1778:7d7f with SMTP id jg26-20020a170907971a00b00a3717787d7fmr1431931ejc.29.1706885864097;
        Fri, 02 Feb 2024 06:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9w+8lHq+Qp/NpEL5X8D4MnB2NetbNCo/2dNc8RwR8ncurIxGR7HMvuEDyaDygDhZSBBDjs//3/1tJiDL+IY4a2Rv1X09aoY6xaAwXw0lAb0BdWz0ePSbsfIVQSf8VcyBFaakm8vxcogv74pOxpdL32kgp+ujsJun3jQv0b3/x6+9cO2FwdDjQ7aNzUHqRBevUeBL5fSTAy4eAzbVv3BVtYN96W8z5q5t74KmmHF+Ngs67T9F0T+It4W4mOBGS4YtYpuSfV2wP91nHp8NZdsVZfmlUjgyi66B26rl/3DKYV938tBzNqIHr7BKaXJ0l1A1JuNeGDbnO8FCrYFGC1Hc8ly/Xm5Zuupe4ab5P8qz2lFoJB5271PuZhRqFy1+ip4OZNn2ZUwKjxaKuFi9S+vOuleU0U2OZy1o0iPP+4B/t8od0uk7YsjQB7nOnlUs6psKZuXbrJmJibpybpDbN62ZtO2Yf5vQbjMR2D5GWMnKtqArnJzRgzpigJX1Dty16mKLFf27i54cspR+VnJ3Kg4HLwwjuusIRV8WjfcCcTrF2Hdhu7pmv3VCEOQtQ8TugXQaHt8YisccLiU0R3SKqGpNnOMhlSMBLvmg0SYg2b+8mSiGIYFOUb0y3DJ5VEP/tj8ON8NSZ6o4PwgSi4cGWHCHWXGjbORQ25zL3szIK/htETV5oiazZ0vOuEzaMl/v96t6GmPkfUhPr0A==
Received: from gpeter-l.lan (host-92-21-139-67.as13285.net. [92.21.139.67])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090616c800b00a36c60180aesm957200ejd.60.2024.02.02.06.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 06:57:43 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
To: arnd@arndb.de,
	krzysztof.kozlowski@linaro.org,
	linux@roeck-us.net,
	wim@linux-watchdog.org,
	alim.akhtar@samsung.com,
	jaewon02.kim@samsung.com,
	semen.protsenko@linaro.org
Cc: kernel-team@android.com,
	peter.griffin@linaro.org,
	alexey.klimov@linaro.org,
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
Subject: [PATCH v3 1/2] soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs
Date: Fri,  2 Feb 2024 14:57:30 +0000
Message-ID: <20240202145731.4082033-2-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202145731.4082033-1-peter.griffin@linaro.org>
References: <20240202145731.4082033-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
security hardening reasons so that they are only write accessible in el3
via an SMC call.

As most Exynos drivers that need to write PMU registers currently obtain a
regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
is implemented in this driver using a custom regmap similar to syscon to
handle the SMC call. Platforms that don't secure PMU registers, get a mmio
regmap like before. As regmaps abstract out the underlying register access
changes to the leaf drivers are minimal.

A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
that currently use syscon_regmap_lookup_by_phandle(). This also handles
deferred probing.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes since v2
 - Add select REGMAP to Kconfig
 - Add constant for SET/CLEAR bits
 - Replace kerneldoc with one line comment
 - Fix kerneldoc for EXPORT_SYMBOL_GPL funcs
 - remove superflous extern keyword
 - dev_err_probe() on probe error
 - shorten regmcfg name
 - no compatibles inside probe, use match data
 - don't mix declarations with/without initializations
 - tensor_sec_reg_read() use mmio to avoid access restrictions
 - Collect up Reviewed-by
 - const for regmap_config structs
---
 drivers/soc/samsung/Kconfig            |   1 +
 drivers/soc/samsung/exynos-pmu.c       | 233 ++++++++++++++++++++++++-
 drivers/soc/samsung/exynos-pmu.h       |   1 +
 include/linux/soc/samsung/exynos-pmu.h |  11 +-
 4 files changed, 241 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
index 27ec99af77e3..1a5dfdc978dc 100644
--- a/drivers/soc/samsung/Kconfig
+++ b/drivers/soc/samsung/Kconfig
@@ -42,6 +42,7 @@ config EXYNOS_PMU
 	depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
 	select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
 	select MFD_CORE
+	select REGMAP_MMIO
 
 # There is no need to enable these drivers for ARMv8
 config EXYNOS_PMU_ARM_DRIVERS
diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index 250537d7cfd6..adf3549370d6 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -5,6 +5,7 @@
 //
 // Exynos - CPU PMU(Power Management Unit) support
 
+#include <linux/arm-smccc.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/mfd/core.h>
@@ -12,19 +13,130 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/regmap.h>
 
 #include <linux/soc/samsung/exynos-regs-pmu.h>
 #include <linux/soc/samsung/exynos-pmu.h>
 
 #include "exynos-pmu.h"
 
+#define PMUALIVE_MASK GENMASK(14, 0)
+#define SET_BITS	0xc000
+#define CLEAR_BITS	0x8000
+
+#define TENSOR_SMC_PMU_SEC_REG		0x82000504
+#define TENSOR_PMUREG_READ		0
+#define TENSOR_PMUREG_WRITE		1
+#define TENSOR_PMUREG_RMW		2
+
 struct exynos_pmu_context {
 	struct device *dev;
 	const struct exynos_pmu_data *pmu_data;
+	struct regmap *pmureg;
 };
 
 void __iomem *pmu_base_addr;
 static struct exynos_pmu_context *pmu_context;
+static struct platform_driver exynos_pmu_driver;
+
+/*
+ * Tensor SoCs are configured so that PMU_ALIVE registers can only be written
+ * from EL3, but are still read accessible. As Linux needs to write some of
+ * these registers, the following functions are provided and exposed via
+ * regmap.
+ *
+ * Note: This SMC interface is known to be implemented on gs101 and derivative
+ * SoCs.
+ */
+
+/* Write to a protected PMU register. */
+static int tensor_sec_reg_write(void *base, unsigned int reg, unsigned int val)
+{
+	struct arm_smccc_res res;
+	unsigned long pmu_base = (unsigned long)base;
+
+	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
+		      TENSOR_PMUREG_WRITE, val, 0, 0, 0, 0, &res);
+
+	/* returns -EINVAL if access isn't allowed or 0 */
+	if (res.a0)
+		pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
+
+	return (int)res.a0;
+}
+
+/* Read/Modify/Write a protected PMU register. */
+static int tensor_sec_reg_rmw(void *base, unsigned int reg,
+			      unsigned int mask, unsigned int val)
+{
+	struct arm_smccc_res res;
+	unsigned long pmu_base = (unsigned long)base;
+
+	arm_smccc_smc(TENSOR_SMC_PMU_SEC_REG, pmu_base + reg,
+		      TENSOR_PMUREG_RMW, mask, val, 0, 0, 0, &res);
+
+	/* returns -EINVAL if access isn't allowed or 0*/
+	if (res.a0)
+		pr_warn("%s(): SMC failed: %d\n", __func__, (int)res.a0);
+
+	return (int)res.a0;
+}
+
+/*
+ * Read a protected PMU register. All PMU registers can be read by Linux.
+ * Note: The SMC read register is not used, as only registers that can be
+ * written are readable via SMC.
+ */
+static int tensor_sec_reg_read(void *base, unsigned int reg, unsigned int *val)
+{
+	*val = pmu_raw_readl(reg);
+	return 0;
+}
+
+/*
+ * For SoCs that have set/clear bit hardware this function can be used when
+ * the PMU register will be accessed by multiple masters.
+ *
+ * For example, to set bits 13:8 in PMU reg offset 0x3e80
+ * tensor_set_bit_atomic(0x3e80, 0x3f00, 0x3f00);
+ *
+ * To clear bits 13:8 in PMU offset 0x3e80
+ * tensor_set_bit_atomic(0x3e80, 0x0, 0x3f00);
+ */
+static inline int tensor_set_bit_atomic(void *ctx, unsigned int offset,
+					u32 val, u32 mask)
+{
+	int ret;
+	unsigned int i;
+
+	for (i = 0; i < 32; i++) {
+		if (mask & BIT(i)) {
+			if (val & BIT(i))
+				offset |= SET_BITS;
+			else
+				offset |= CLEAR_BITS;
+
+			ret = tensor_sec_reg_write(ctx, offset, i);
+			if (ret)
+				goto out;
+		}
+	}
+out:
+	return ret;
+}
+
+static int tensor_sec_update_bits(void *ctx, unsigned int reg,
+				  unsigned int mask, unsigned int val)
+{
+	/*
+	 * Use atomic operations for PMU_ALIVE registers (offset 0~0x3FFF)
+	 * as the target registers can be accessed by multiple masters.
+	 */
+	if (reg > PMUALIVE_MASK)
+		return tensor_sec_reg_rmw(ctx, reg, mask, val);
+
+	return tensor_set_bit_atomic(ctx, reg, val, mask);
+}
 
 void pmu_raw_writel(u32 val, u32 offset)
 {
@@ -75,11 +187,41 @@ void exynos_sys_powerdown_conf(enum sys_powerdown mode)
 #define exynos_pmu_data_arm_ptr(data)	NULL
 #endif
 
+static const struct regmap_config regmap_smccfg = {
+	.name = "pmu_regs",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.use_single_read = true,
+	.use_single_write = true,
+	.reg_read = tensor_sec_reg_read,
+	.reg_write = tensor_sec_reg_write,
+	.reg_update_bits = tensor_sec_update_bits,
+};
+
+static const struct regmap_config regmap_mmiocfg = {
+	.name = "pmu_regs",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+	.use_single_read = true,
+	.use_single_write = true,
+};
+
+static const struct exynos_pmu_data gs101_pmu_data = {
+	.pmu_secure = true
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
@@ -113,19 +255,73 @@ static const struct mfd_cell exynos_pmu_devs[] = {
 	{ .name = "exynos-clkout", },
 };
 
+/**
+ * exynos_get_pmu_regmap() - Obtain pmureg regmap
+ *
+ * Find the pmureg regmap previously configured in probe() and return regmap
+ * pointer.
+ *
+ * Return: A pointer to regmap if found or ERR_PTR error value.
+ */
 struct regmap *exynos_get_pmu_regmap(void)
 {
 	struct device_node *np = of_find_matching_node(NULL,
 						      exynos_pmu_of_device_ids);
 	if (np)
-		return syscon_node_to_regmap(np);
+		return exynos_get_pmu_regmap_by_phandle(np, NULL);
 	return ERR_PTR(-ENODEV);
 }
 EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap);
 
+/**
+ * exynos_get_pmu_regmap_by_phandle() - Obtain pmureg regmap via phandle
+ * @np: Pointer to device's Device Tree node
+ * @property: Device Tree property name which references the pmu
+ *
+ * Find the pmureg regmap previously configured in probe() and return regmap
+ * pointer.
+ *
+ * Return: A pointer to regmap if found or ERR_PTR error value.
+ */
+struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
+						const char *property)
+{
+	struct device *dev;
+	struct exynos_pmu_context *ctx;
+	struct device_node *pmu_np;
+
+	if (property)
+		pmu_np = of_parse_phandle(np, property, 0);
+	else
+		pmu_np = np;
+
+	if (!pmu_np)
+		return ERR_PTR(-ENODEV);
+
+	/*
+	 * Determine if exynos-pmu device has probed and therefore regmap
+	 * has been created and can be returned to the caller. Otherwise we
+	 * return -EPROBE_DEFER.
+	 */
+	dev = driver_find_device_by_of_node(&exynos_pmu_driver.driver,
+					    (void *)pmu_np);
+
+	of_node_put(pmu_np);
+	if (!dev)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	ctx = dev_get_drvdata(dev);
+
+	return ctx->pmureg;
+}
+EXPORT_SYMBOL_GPL(exynos_get_pmu_regmap_by_phandle);
+
 static int exynos_pmu_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct regmap_config pmu_regmcfg;
+	struct regmap *regmap;
+	struct resource *res;
 	int ret;
 
 	pmu_base_addr = devm_platform_ioremap_resource(pdev, 0);
@@ -133,13 +329,42 @@ static int exynos_pmu_probe(struct platform_device *pdev)
 		return PTR_ERR(pmu_base_addr);
 
 	pmu_context = devm_kzalloc(&pdev->dev,
-			sizeof(struct exynos_pmu_context),
-			GFP_KERNEL);
+				   sizeof(struct exynos_pmu_context),
+				   GFP_KERNEL);
 	if (!pmu_context)
 		return -ENOMEM;
-	pmu_context->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
 	pmu_context->pmu_data = of_device_get_match_data(dev);
 
+	/* For SoCs that secure PMU register writes use custom regmap */
+	if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_secure) {
+		pmu_regmcfg = regmap_smccfg;
+		pmu_regmcfg.max_register = resource_size(res) -
+					   pmu_regmcfg.reg_stride;
+		/* Need physical address for SMC call */
+		regmap = devm_regmap_init(dev, NULL,
+					  (void *)(uintptr_t)res->start,
+					  &pmu_regmcfg);
+	} else {
+		/* all other SoCs use a MMIO regmap */
+		pmu_regmcfg = regmap_mmiocfg;
+		pmu_regmcfg.max_register = resource_size(res) -
+					   pmu_regmcfg.reg_stride;
+		regmap = devm_regmap_init_mmio(dev, pmu_base_addr,
+					       &pmu_regmcfg);
+	}
+
+	if (IS_ERR(regmap))
+		dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+			      "regmap init failed\n");
+
+	pmu_context->pmureg = regmap;
+	pmu_context->dev = dev;
+
 	if (pmu_context->pmu_data && pmu_context->pmu_data->pmu_init)
 		pmu_context->pmu_data->pmu_init();
 
diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index 1c652ffd79b4..0a49a2c9a08e 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -21,6 +21,7 @@ struct exynos_pmu_conf {
 struct exynos_pmu_data {
 	const struct exynos_pmu_conf *pmu_config;
 	const struct exynos_pmu_conf *pmu_config_extra;
+	bool pmu_secure;
 
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
diff --git a/include/linux/soc/samsung/exynos-pmu.h b/include/linux/soc/samsung/exynos-pmu.h
index a4f5516cc956..406ed73614fd 100644
--- a/include/linux/soc/samsung/exynos-pmu.h
+++ b/include/linux/soc/samsung/exynos-pmu.h
@@ -20,12 +20,21 @@ enum sys_powerdown {
 
 extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
 #ifdef CONFIG_EXYNOS_PMU
-extern struct regmap *exynos_get_pmu_regmap(void);
+struct regmap *exynos_get_pmu_regmap(void);
+
+struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
+						const char *property);
 #else
 static inline struct regmap *exynos_get_pmu_regmap(void)
 {
 	return ERR_PTR(-ENODEV);
 }
+
+static inline struct regmap *exynos_get_pmu_regmap_by_phandle(struct device_node *np,
+							      const char *property)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
 #endif /* __LINUX_SOC_EXYNOS_PMU_H */
-- 
2.43.0.594.gd9cf4e227d-goog


