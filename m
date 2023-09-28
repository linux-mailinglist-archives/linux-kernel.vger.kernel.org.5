Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1B7B2381
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjI1RPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjI1RPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:15:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52A319E;
        Thu, 28 Sep 2023 10:15:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48512C433CA;
        Thu, 28 Sep 2023 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695921303;
        bh=olyEWQmGzq8JgN9soWmhAh/5NHdyqsbn7eAO552rmdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFLXSiYjK/AkNqiTZiJ31Rvfe6bRfXZkatvctuO5RUB5kORZp4wqP3UFGSFbVG3UP
         FIcXyrwzBB/GVYfhOAKRJs2X3hrmoCCeYqkiOJOirXqh8Qb1IIynGk37PEmwVtAVNH
         oz/sl76hWAnTmVBNjmYeeZv3WpBycdPPcX4aMQVpn7j65UeG1IPVbzllRidPbGR+Y8
         QnT5610SBdn6EnyUDTBHQ1KGrbTmlidNtJs0hn8FI1zlVd6s+cDGlnEYrkLHdkRm9t
         ix4L+B5v6bKvwRakNKaDeqJ5zehu7nKQekQa5KckLnn8VhEjZfOXsAxdCwAtmVKU0j
         Yjwx+fev4cwgw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, linux-riscv@lists.infradead.org
Subject: [PATCH 2/2] pwm: add T-HEAD PWM driver
Date:   Fri, 29 Sep 2023 01:02:54 +0800
Message-Id: <20230928170254.413-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230928170254.413-1-jszhang@kernel.org>
References: <20230928170254.413-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-HEAD SoCs such as the TH1520 contain a PWM controller used
among other things to control the LCD backlight, fan and so on.
Add driver for it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS             |   1 +
 drivers/pwm/Kconfig     |  11 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-thead.c | 289 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 302 insertions(+)
 create mode 100644 drivers/pwm/pwm-thead.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d55e40060c46..86cf0926dbfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18482,6 +18482,7 @@ L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	arch/riscv/boot/dts/thead/
 F:	drivers/usb/dwc3/dwc3-thead.c
+F:	drivers/pwm/pwm-thead.c
 
 RNBD BLOCK DRIVERS
 M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8ebcddf91f7b..428fa365a19a 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -637,6 +637,17 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
+config PWM_THEAD
+	tristate "T-HEAD PWM support"
+	depends on ARCH_THEAD || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Generic PWM framework driver for the PWFM controller found on THEAD
+	  SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-thead.
+
 config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c822389c2a24..4c317e6316e8 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
 obj-$(CONFIG_PWM_SUNPLUS)	+= pwm-sunplus.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
+obj-$(CONFIG_PWM_THEAD)		+= pwm-thead.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
diff --git a/drivers/pwm/pwm-thead.c b/drivers/pwm/pwm-thead.c
new file mode 100644
index 000000000000..8339f5617b6f
--- /dev/null
+++ b/drivers/pwm/pwm-thead.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD PWM driver
+ *
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+
+#define MAX_PWM_NUM	6
+
+#define LIGHT_PWM_CHN_BASE(n)		((n) * 0x20)
+#define LIGHT_PWM_CTRL(n)		(LIGHT_PWM_CHN_BASE(n) + 0x00)
+#define LIGHT_PWM_RPT(n)		(LIGHT_PWM_CHN_BASE(n) + 0x04)
+#define LIGHT_PWM_PER(n)		(LIGHT_PWM_CHN_BASE(n) + 0x08)
+#define LIGHT_PWM_FP(n)			(LIGHT_PWM_CHN_BASE(n) + 0x0c)
+#define LIGHT_PWM_STATUS(n)		(LIGHT_PWM_CHN_BASE(n) + 0x10)
+
+/* bit definition PWM_CTRL */
+#define PWM_START				BIT(0)
+#define PWM_SOFT_RST				BIT(1)
+#define PWM_CFG_UPDATE				BIT(2)
+#define PWM_INT_EN				BIT(3)
+#define PWM_ONE_SHOT_MODE			BIT(4)
+#define PWM_CONTINUOUS_MODE			BIT(5)
+#define PWM_EVT_RISING_TRIG_UNDER_ONE_SHOT	BIT(6)
+#define PWM_EVT_FALLING_TRIG_UNDER_ONE_SHOT	BIT(7)
+#define PWM_FPOUT				BIT(8)
+#define PWM_INFACTOUT				BIT(9)
+
+struct thead_pwm_chip {
+	struct clk *clk;
+	void __iomem *mmio_base;
+	struct pwm_chip chip;
+};
+
+#define to_thead_pwm_chip(chip)		container_of(chip, struct thead_pwm_chip, chip)
+
+static int thead_pwm_clk_prepare_enable(struct thead_pwm_chip *pc)
+{
+	return clk_prepare_enable(pc->clk);
+}
+
+static void thead_pwm_clk_disable_unprepare(struct thead_pwm_chip *pc)
+{
+	clk_disable_unprepare(pc->clk);
+}
+
+static int thead_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct thead_pwm_chip *pc = to_thead_pwm_chip(chip);
+	u32 value;
+	int ret;
+
+	ret = pm_runtime_get_sync(chip->dev);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to clock on the pwm device(%d)\n", ret);
+		return ret;
+	}
+
+	value = readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+	value |= PWM_START;
+	writel(value, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+
+	return 0;
+}
+
+static void thead_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct thead_pwm_chip *pc = to_thead_pwm_chip(chip);
+	u32 value;
+
+	value = readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+	value &= ~PWM_START;
+	writel(value, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+
+	pm_runtime_put_sync(chip->dev);
+}
+
+static int thead_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	struct thead_pwm_chip *pc = to_thead_pwm_chip(chip);
+	unsigned long rate = clk_get_rate(pc->clk);
+	unsigned long duty_cycle, period_cycle;
+	u32 pwm_cfg = PWM_INFACTOUT | PWM_FPOUT | PWM_CONTINUOUS_MODE | PWM_INT_EN;
+	int ret;
+
+	if (duty_ns > period_ns) {
+		dev_err(chip->dev, "invalid pwm configure\n");
+		return -EINVAL;
+	}
+
+	ret = pm_runtime_get_sync(chip->dev);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to clock on the pwm device(%d)\n", ret);
+		return ret;
+	}
+
+	writel(pwm_cfg, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+
+	period_cycle = period_ns * rate;
+	do_div(period_cycle, NSEC_PER_SEC);
+	writel(period_cycle, pc->mmio_base + LIGHT_PWM_PER(pwm->hwpwm));
+
+	duty_cycle = duty_ns * rate;
+	do_div(duty_cycle, NSEC_PER_SEC);
+	writel(duty_cycle, pc->mmio_base + LIGHT_PWM_FP(pwm->hwpwm));
+
+	pwm_cfg = readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+	pwm_cfg |= PWM_CFG_UPDATE;
+	writel(pwm_cfg, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+
+	pm_runtime_put_sync(chip->dev);
+
+	return 0;
+}
+
+static int thead_pwm_set_polarity(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  enum pwm_polarity polarity)
+{
+	struct thead_pwm_chip *pc = to_thead_pwm_chip(chip);
+	u32 value = readl(pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+	int ret;
+
+	ret = pm_runtime_get_sync(chip->dev);
+	if (ret < 0) {
+		dev_err(chip->dev, "failed to clock on the pwm device(%d)\n", ret);
+		return ret;
+	}
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		value |= PWM_FPOUT;
+	else
+		value &= ~PWM_FPOUT;
+
+	writel(value, pc->mmio_base + LIGHT_PWM_CTRL(pwm->hwpwm));
+
+	pm_runtime_put_sync(chip->dev);
+
+	return 0;
+}
+
+static int thead_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity)
+		thead_pwm_set_polarity(chip, pwm, state->polarity);
+
+	if (!state->enabled) {
+		if (enabled)
+			thead_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	err = thead_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!enabled)
+		return thead_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
+static const struct pwm_ops thead_pwm_ops = {
+	.apply = thead_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int __maybe_unused thead_pwm_runtime_suspend(struct device *dev)
+{
+	struct thead_pwm_chip *pc = dev_get_drvdata(dev);
+
+	thead_pwm_clk_disable_unprepare(pc);
+
+	return 0;
+}
+
+static int __maybe_unused thead_pwm_runtime_resume(struct device *dev)
+{
+	struct thead_pwm_chip *pc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = thead_pwm_clk_prepare_enable(pc);
+	if (ret) {
+		dev_err(dev, "failed to enable pwm clock(%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int thead_pwm_probe(struct platform_device *pdev)
+{
+	struct thead_pwm_chip *pc;
+	int ret;
+
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pc);
+
+	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->mmio_base))
+		return PTR_ERR(pc->mmio_base);
+
+	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pc->clk))
+		return PTR_ERR(pc->clk);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	ret = thead_pwm_clk_prepare_enable(pc);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable pwm clock(%d)\n", ret);
+		goto err_pm_disable;
+	}
+
+	pc->chip.ops = &thead_pwm_ops;
+	pc->chip.dev = &pdev->dev;
+	pc->chip.npwm = MAX_PWM_NUM;
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret)
+		goto err_clk_disable;
+
+	pm_runtime_put(&pdev->dev);
+
+	return 0;
+
+err_clk_disable:
+	thead_pwm_clk_disable_unprepare(pc);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
+}
+
+static void thead_pwm_remove(struct platform_device *pdev)
+{
+	struct thead_pwm_chip *pc = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	thead_pwm_clk_disable_unprepare(pc);
+	pwmchip_remove(&pc->chip);
+}
+
+static const struct of_device_id thead_pwm_dt_ids[] = {
+	{.compatible = "thead,th1520-pwm",},
+	{/* sentinel */}
+};
+
+static const struct dev_pm_ops thead_pwm_pm_ops = {
+	SET_RUNTIME_PM_OPS(thead_pwm_runtime_suspend, thead_pwm_runtime_resume, NULL)
+};
+
+static struct platform_driver thead_pwm_driver = {
+	.driver = {
+		.name = "thead-pwm",
+		.of_match_table = thead_pwm_dt_ids,
+		.pm = &thead_pwm_pm_ops,
+	},
+	.probe = thead_pwm_probe,
+	.remove_new = thead_pwm_remove,
+};
+module_platform_driver(thead_pwm_driver);
+
+MODULE_AUTHOR("wei.liu <lw312886@linux.alibaba.com>");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("T-HEAD pwm driver");
+MODULE_LICENSE("GPL v2");
-- 
2.40.1

