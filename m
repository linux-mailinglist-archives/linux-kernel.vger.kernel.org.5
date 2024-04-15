Return-Path: <linux-kernel+bounces-144882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1A8A4C21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A466B23153
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA2481D8;
	Mon, 15 Apr 2024 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzzT6X7J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524B355792;
	Mon, 15 Apr 2024 10:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175511; cv=none; b=C/7jQZxnmRdkfKYsaL8kAk2WNiWCqlyHiEj+nVI7H1LU3riEzzSW98MlpSdMRVzeOnK57fFYK74h0PaT+f4EZ5F0IggLFUbh9NbxVoZ2TT+NL0Ikpj+yBaw24Dr89KSaJN2SBgYVkrfIJ/458OqJCqRb0E0rjU7Y5Hc6oZLDm90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175511; c=relaxed/simple;
	bh=5/4J8bSfy9tDWqVzype++7MbmF+TF6hs5nHe+Tj2oyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIVmSpw9lcz18+lopTYhMiNWVXy1dynVcn/s1hLYr3nKWjLVpVIdZnnwQq1kf5ZYDfQ9loBLe4xK8DZR1HFV5h2XQwZdHIapuGj7rpk2qf/pdh+fugQHuvtUeviVzRAfrdVBZVqmThxucu7BCg3puFYedKxcoEL1GG3HzaQHXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzzT6X7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24E2C113CC;
	Mon, 15 Apr 2024 10:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713175509;
	bh=5/4J8bSfy9tDWqVzype++7MbmF+TF6hs5nHe+Tj2oyU=;
	h=From:To:Cc:Subject:Date:From;
	b=AzzT6X7JuOOjZWwyVN9nwUez1Me8fOBJk+uHWrPMajJk4nXYMdmGnQc0hI7YinHS+
	 D2+CwaAZg7S2yEPpvKdC+P8AKG+FXeJbnQVOhLrWiVcTUKhq1dda7s7S9FK59ZezJN
	 Ur+6ZK10EX7vBjIF5jAePs5ClKBWu1ysDHgoN75DdrywsG/HQnjwk+7e201IKMIEFK
	 Y6xGkOoE9ygIyAw+mzX2PsQlScp+YSIc1f7QRMfCQTcdgkC1ph69zD9cUWFKA2zpnc
	 CzqwpWQaypzMtW9dLYLB6J7uHYOrO+wpvzDyIDIz4p6Pb3XZYv6sQ47AT2WtdbQoh4
	 JbeG7pwx2dOug==
From: Conor Dooley <conor@kernel.org>
To: linux-clk@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] clock, reset: microchip: move all mpfs reset code to the reset subsystem
Date: Mon, 15 Apr 2024 11:04:57 +0100
Message-ID: <20240415-democracy-risk-419b0250a432@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9847; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=GgZAlsj+oOjVUnBVrL3clUFFqWTKy0CtFb6VEIra3Pk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGkyv89mcsyZv9DZ5bm+5qtjBo7WV69E8+9g+LziyiV3o cKFSTLqHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIlPmMDIc3ufQvfXhQTvPC gff6U3JXzHN/6L2E6du7d8lr3QJ2NB5gZGhYtT+ocVFb/LbiST93unIkO18xOzPfU43Dwkq24IN DMTcA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Stephen and Philipp, while reviewing patches, said that all of the aux
device creation and the register read/write code could be moved to the
reset subsystem, leaving the clock driver with no implementations of
reset_* functions at all. Move them.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: Philipp Zabel <p.zabel@pengutronix.de>
CC: linux-riscv@lists.infradead.org
CC: linux-clk@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/clk/microchip/clk-mpfs.c | 92 +-----------------------------
 drivers/reset/reset-mpfs.c       | 97 ++++++++++++++++++++++++++++----
 include/soc/microchip/mpfs.h     | 10 ++--
 3 files changed, 94 insertions(+), 105 deletions(-)

diff --git a/drivers/clk/microchip/clk-mpfs.c b/drivers/clk/microchip/clk-mpfs.c
index 22eab91a6712..28ec0da88cb3 100644
--- a/drivers/clk/microchip/clk-mpfs.c
+++ b/drivers/clk/microchip/clk-mpfs.c
@@ -4,12 +4,10 @@
  *
  * Copyright (C) 2020-2022 Microchip Technology Inc. All rights reserved.
  */
-#include <linux/auxiliary_bus.h>
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
 
@@ -361,93 +359,6 @@ static int mpfs_clk_register_periphs(struct device *dev, struct mpfs_periph_hw_c
 	return 0;
 }
 
-/*
- * Peripheral clock resets
- */
-
-#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
-
-u32 mpfs_reset_read(struct device *dev)
-{
-	struct mpfs_clock_data *clock_data = dev_get_drvdata(dev->parent);
-
-	return readl_relaxed(clock_data->base + REG_SUBBLK_RESET_CR);
-}
-EXPORT_SYMBOL_NS_GPL(mpfs_reset_read, MCHP_CLK_MPFS);
-
-void mpfs_reset_write(struct device *dev, u32 val)
-{
-	struct mpfs_clock_data *clock_data = dev_get_drvdata(dev->parent);
-
-	writel_relaxed(val, clock_data->base + REG_SUBBLK_RESET_CR);
-}
-EXPORT_SYMBOL_NS_GPL(mpfs_reset_write, MCHP_CLK_MPFS);
-
-static void mpfs_reset_unregister_adev(void *_adev)
-{
-	struct auxiliary_device *adev = _adev;
-
-	auxiliary_device_delete(adev);
-	auxiliary_device_uninit(adev);
-}
-
-static void mpfs_reset_adev_release(struct device *dev)
-{
-	struct auxiliary_device *adev = to_auxiliary_dev(dev);
-
-	kfree(adev);
-}
-
-static struct auxiliary_device *mpfs_reset_adev_alloc(struct mpfs_clock_data *clk_data)
-{
-	struct auxiliary_device *adev;
-	int ret;
-
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
-	if (!adev)
-		return ERR_PTR(-ENOMEM);
-
-	adev->name = "reset-mpfs";
-	adev->dev.parent = clk_data->dev;
-	adev->dev.release = mpfs_reset_adev_release;
-	adev->id = 666u;
-
-	ret = auxiliary_device_init(adev);
-	if (ret) {
-		kfree(adev);
-		return ERR_PTR(ret);
-	}
-
-	return adev;
-}
-
-static int mpfs_reset_controller_register(struct mpfs_clock_data *clk_data)
-{
-	struct auxiliary_device *adev;
-	int ret;
-
-	adev = mpfs_reset_adev_alloc(clk_data);
-	if (IS_ERR(adev))
-		return PTR_ERR(adev);
-
-	ret = auxiliary_device_add(adev);
-	if (ret) {
-		auxiliary_device_uninit(adev);
-		return ret;
-	}
-
-	return devm_add_action_or_reset(clk_data->dev, mpfs_reset_unregister_adev, adev);
-}
-
-#else /* !CONFIG_RESET_CONTROLLER */
-
-static int mpfs_reset_controller_register(struct mpfs_clock_data *clk_data)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_RESET_CONTROLLER */
-
 static int mpfs_clk_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -499,7 +410,7 @@ static int mpfs_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return mpfs_reset_controller_register(clk_data);
+	return mpfs_reset_controller_register(dev, clk_data->base + REG_SUBBLK_RESET_CR);
 }
 
 static const struct of_device_id mpfs_clk_of_match_table[] = {
@@ -532,3 +443,4 @@ MODULE_DESCRIPTION("Microchip PolarFire SoC Clock Driver");
 MODULE_AUTHOR("Padmarao Begari <padmarao.begari@microchip.com>");
 MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
 MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_IMPORT_NS(MCHP_CLK_MPFS);
diff --git a/drivers/reset/reset-mpfs.c b/drivers/reset/reset-mpfs.c
index 7f3fb2d472f4..74f0dff6de1a 100644
--- a/drivers/reset/reset-mpfs.c
+++ b/drivers/reset/reset-mpfs.c
@@ -8,9 +8,11 @@
  */
 #include <linux/auxiliary_bus.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/reset-controller.h>
 #include <dt-bindings/clock/microchip,mpfs-clock.h>
 #include <soc/microchip/mpfs.h>
@@ -28,20 +30,30 @@
 /* block concurrent access to the soft reset register */
 static DEFINE_SPINLOCK(mpfs_reset_lock);
 
+struct mpfs_reset {
+	void __iomem *base;
+	struct reset_controller_dev rcdev;
+};
+
+static inline struct mpfs_reset * to_mpfs_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct mpfs_reset, rcdev);
+}
+
 /*
  * Peripheral clock resets
  */
-
 static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
 	unsigned long flags;
 	u32 reg;
 
 	spin_lock_irqsave(&mpfs_reset_lock, flags);
 
-	reg = mpfs_reset_read(rcdev->dev);
+	reg = readl(rst->base);
 	reg |= BIT(id);
-	mpfs_reset_write(rcdev->dev, reg);
+	writel(reg, rst->base);
 
 	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
 
@@ -50,14 +62,15 @@ static int mpfs_assert(struct reset_controller_dev *rcdev, unsigned long id)
 
 static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
 	unsigned long flags;
 	u32 reg;
 
 	spin_lock_irqsave(&mpfs_reset_lock, flags);
 
-	reg = mpfs_reset_read(rcdev->dev);
+	reg = readl(rst->base);
 	reg &= ~BIT(id);
-	mpfs_reset_write(rcdev->dev, reg);
+	writel(reg, rst->base);
 
 	spin_unlock_irqrestore(&mpfs_reset_lock, flags);
 
@@ -66,7 +79,8 @@ static int mpfs_deassert(struct reset_controller_dev *rcdev, unsigned long id)
 
 static int mpfs_status(struct reset_controller_dev *rcdev, unsigned long id)
 {
-	u32 reg = mpfs_reset_read(rcdev->dev);
+	struct mpfs_reset *rst = to_mpfs_reset(rcdev);
+	u32 reg = readl(rst->base);
 
 	/*
 	 * It is safe to return here as MPFS_NUM_RESETS makes sure the sign bit
@@ -121,11 +135,15 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 {
 	struct device *dev = &adev->dev;
 	struct reset_controller_dev *rcdev;
+	struct mpfs_reset *rst;
 
-	rcdev = devm_kzalloc(dev, sizeof(*rcdev), GFP_KERNEL);
-	if (!rcdev)
-		return -ENOMEM;
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;;
 
+	rst->base = (void __iomem *)adev->dev.platform_data;
+
+	rcdev = &rst->rcdev;
 	rcdev->dev = dev;
 	rcdev->dev->parent = dev->parent;
 	rcdev->ops = &mpfs_reset_ops;
@@ -137,9 +155,68 @@ static int mpfs_reset_probe(struct auxiliary_device *adev,
 	return devm_reset_controller_register(dev, rcdev);
 }
 
+static void mpfs_reset_unregister_adev(void *_adev)
+{
+	struct auxiliary_device *adev = _adev;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static void mpfs_reset_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	kfree(adev);
+}
+
+static struct auxiliary_device *mpfs_reset_adev_alloc(struct device *clk_dev)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return ERR_PTR(-ENOMEM);
+
+	adev->name = "reset-mpfs";
+	adev->dev.parent = clk_dev;
+	adev->dev.release = mpfs_reset_adev_release;
+	adev->id = 666u;
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		kfree(adev);
+		return ERR_PTR(ret);
+	}
+
+	return adev;
+}
+
+int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = mpfs_reset_adev_alloc(clk_dev);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	adev->dev.platform_data = (__force void *)base;
+
+	return devm_add_action_or_reset(clk_dev, mpfs_reset_unregister_adev, adev);
+}
+EXPORT_SYMBOL_NS_GPL(mpfs_reset_controller_register, MCHP_CLK_MPFS);
+
 static const struct auxiliary_device_id mpfs_reset_ids[] = {
 	{
-		.name = "clk_mpfs.reset-mpfs",
+		.name = "reset_mpfs.reset-mpfs",
 	},
 	{ }
 };
diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
index 09722f83b0ca..e82d70c3a2cf 100644
--- a/include/soc/microchip/mpfs.h
+++ b/include/soc/microchip/mpfs.h
@@ -43,11 +43,11 @@ struct mtd_info *mpfs_sys_controller_get_flash(struct mpfs_sys_controller *mpfs_
 #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
 
 #if IS_ENABLED(CONFIG_MCHP_CLK_MPFS)
-
-u32 mpfs_reset_read(struct device *dev);
-
-void mpfs_reset_write(struct device *dev, u32 val);
-
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
+int mpfs_reset_controller_register(struct device *clk_dev, void __iomem *base);
+#else
+int static inline mpfs_reset_controller_register(struct device *clk_dev, void* __iomem base) { return 0;}
+#endif /* if IS_ENABLED(CONFIG_RESET_CONTROLLER) */
 #endif /* if IS_ENABLED(CONFIG_MCHP_CLK_MPFS) */
 
 #endif /* __SOC_MPFS_H__ */
-- 
2.43.0


