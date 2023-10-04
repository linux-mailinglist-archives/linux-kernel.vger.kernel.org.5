Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DF7B7C66
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbjJDJjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242080AbjJDJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:39:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C0C1;
        Wed,  4 Oct 2023 02:39:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E46C433CA;
        Wed,  4 Oct 2023 09:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696412381;
        bh=4ajcit5MVNwNqk7UmDG2b6bY1LbxWQvlNoVe1fvg9IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ims8XDRoyUD3oeLcgnPFMWaBeaAneh2h40MOP+L/ZTO2BzRApBMifys9j2It9KKel
         ePb+CjdRmn5NybVP+PE+LdLA1XXngctaQv70C267sNNj38HBZBV6/v0V5H56EUNmor
         CuGkP0jSls0xfBxhsrtq+3Eg39vjacxIxiPE4tw1MkVA9UBZYiK3E7U9v+blCywtS/
         Ev/HWfP5AfOoxYTUgR0wskci9mSnfqxJtxEvO4RZ9dEtozDlWucf3129Fc8strtcKk
         Jb1dCDh/AcIIwLsDDXep9zBiCefa95e1mDIwM6/1h0qX0/0El+/Qi0+zt0XTNfusZl
         7J3M2joDAim6w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] pwm: add T-HEAD PWM driver
Date:   Wed,  4 Oct 2023 17:27:31 +0800
Message-Id: <20231004092731.1362-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231004092731.1362-1-jszhang@kernel.org>
References: <20231004092731.1362-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T-HEAD SoCs such as the TH1520 contain a PWM controller used
to control the LCD backlight, fan and so on. Add driver for it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 MAINTAINERS             |   1 +
 drivers/pwm/Kconfig     |  11 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-thead.c | 274 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 287 insertions(+)
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
index 000000000000..ba1e3a4f1027
--- /dev/null
+++ b/drivers/pwm/pwm-thead.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * T-HEAD PWM driver
+ *
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ *
+ * Limitations:
+ * - The THEAD_PWM_START bit is only effective when 0 -> 1, which is used to
+ *   start the channel, 1 -> 0 doesn't change anything. so 0 % duty cycle is
+ *   used to "disable" the channel.
+ * - The PWM_CFG_UPDATE atomically updates and only updates period and duty.
+ * - To update period and duty, PWM_CFG_UPDATE needs to go through 0 -> 1 step,
+ *   I.E if PWM_CFG_UPDATE is already 1, it's necessary to clear it to 0
+ *   beforehand.
+ * - Polarity can only be changed if never started before.
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
+#define THEAD_PWM_MAX_NUM		6
+#define THEAD_PWM_MAX_PERIOD		GENMASK(31, 0)
+#define THEAD_PWM_MAX_DUTY		GENMASK(31, 0)
+
+#define THEAD_PWM_CHN_BASE(n)		((n) * 0x20)
+#define THEAD_PWM_CTRL(n)		(THEAD_PWM_CHN_BASE(n) + 0x00)
+#define THEAD_PWM_RPT(n)		(THEAD_PWM_CHN_BASE(n) + 0x04)
+#define THEAD_PWM_PER(n)		(THEAD_PWM_CHN_BASE(n) + 0x08)
+#define THEAD_PWM_FP(n)			(THEAD_PWM_CHN_BASE(n) + 0x0c)
+#define THEAD_PWM_STATUS(n)		(THEAD_PWM_CHN_BASE(n) + 0x10)
+
+/* bit definition PWM_CTRL */
+#define THEAD_PWM_START			BIT(0)
+#define THEAD_PWM_SOFT_RST		BIT(1)
+#define THEAD_PWM_CFG_UPDATE		BIT(2)
+#define THEAD_PWM_INT_EN		BIT(3)
+#define THEAD_PWM_MODE_MASK		GENMASK(5, 4)
+#define THEAD_PWM_ONE_SHOT_MODE		FIELD_PREP(THEAD_PWM_MODE_MASK, 1)
+#define THEAD_PWM_CONTINUOUS_MODE	FIELD_PREP(THEAD_PWM_MODE_MASK, 2)
+#define THEAD_PWM_EVTRIG_MASK		GENMASK(7, 6)
+#define THEAD_PWM_FPOUT			BIT(8)
+#define THEAD_PWM_INFACTOUT		BIT(9)
+
+struct thead_pwm_chip {
+	struct pwm_chip chip;
+	void __iomem *mmio_base;
+	struct clk *clk;
+	bool ever_started;
+};
+
+static inline struct thead_pwm_chip *thead_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct thead_pwm_chip, chip);
+}
+
+static int thead_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct thead_pwm_chip *priv = thead_pwm_from_chip(chip);
+	u64 period_cycle, duty_cycle, rate;
+	u32 val;
+
+	/* if ever started, can't change the polarity */
+	if (priv->ever_started && state->polarity != pwm->state.polarity)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled) {
+			val = readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+			val &= ~THEAD_PWM_CFG_UPDATE;
+			writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+
+			writel(0, priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
+
+			val |= THEAD_PWM_CFG_UPDATE;
+			writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+		}
+		return 0;
+	}
+
+	if (!pwm->state.enabled)
+		pm_runtime_get_sync(chip->dev);
+
+	val = readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+	val &= ~THEAD_PWM_CFG_UPDATE;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		val &= ~THEAD_PWM_FPOUT;
+	else
+		val |= THEAD_PWM_FPOUT;
+
+	writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+
+	rate = clk_get_rate(priv->clk);
+	/*
+	 * The following calculations might overflow if clk is bigger
+	 * than 1 GHz. In practise it's 24MHz, so this limitation
+	 * is only theoretic.
+	 */
+	if (rate > (u64)NSEC_PER_SEC)
+		return -EINVAL;
+
+	period_cycle = mul_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC);
+	if (period_cycle > THEAD_PWM_MAX_PERIOD)
+		period_cycle = THEAD_PWM_MAX_PERIOD;
+	/*
+	 * With limitation above we have period_cycle <= THEAD_PWM_MAX_PERIOD,
+	 * so this cannot overflow.
+	 */
+	writel((u32)period_cycle, priv->mmio_base + THEAD_PWM_PER(pwm->hwpwm));
+
+	duty_cycle = mul_u64_u64_div_u64(rate, state->duty_cycle, NSEC_PER_SEC);
+	if (duty_cycle > THEAD_PWM_MAX_DUTY)
+		duty_cycle = THEAD_PWM_MAX_DUTY;
+	/*
+	 * With limitation above we have duty_cycle <= THEAD_PWM_MAX_PERIOD,
+	 * so this cannot overflow.
+	 */
+	writel((u32)duty_cycle, priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
+
+	val |= THEAD_PWM_CFG_UPDATE;
+	writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+
+	if (!pwm->state.enabled) {
+		val |= THEAD_PWM_START;
+		writel(val, priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+		priv->ever_started = true;
+	}
+
+	return 0;
+}
+
+static int thead_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct thead_pwm_chip *priv = thead_pwm_from_chip(chip);
+	u64 rate = clk_get_rate(priv->clk);
+	u32 val;
+
+	pm_runtime_get_sync(chip->dev);
+
+	val = readl(priv->mmio_base + THEAD_PWM_CTRL(pwm->hwpwm));
+	state->enabled = !!(val & THEAD_PWM_START);
+	if (val & THEAD_PWM_FPOUT)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	val = readl(priv->mmio_base + THEAD_PWM_PER(pwm->hwpwm));
+	/*
+	 * val 32 bits, multiply NSEC_PER_SEC, won't overflow.
+	 */
+	state->period = DIV64_U64_ROUND_UP((u64)val * NSEC_PER_SEC, rate);
+
+	val = readl(priv->mmio_base + THEAD_PWM_FP(pwm->hwpwm));
+	/*
+	 * val 32 bits, multiply NSEC_PER_SEC, won't overflow.
+	 */
+	state->duty_cycle = DIV64_U64_ROUND_UP((u64)val * NSEC_PER_SEC, rate);
+
+	pm_runtime_put_sync(chip->dev);
+
+	return 0;
+}
+
+static const struct pwm_ops thead_pwm_ops = {
+	.apply = thead_pwm_apply,
+	.get_state = thead_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int __maybe_unused thead_pwm_runtime_suspend(struct device *dev)
+{
+	struct thead_pwm_chip *priv = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static int __maybe_unused thead_pwm_runtime_resume(struct device *dev)
+{
+	struct thead_pwm_chip *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk);
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
+	u32 val = THEAD_PWM_INFACTOUT | THEAD_PWM_FPOUT | THEAD_PWM_CONTINUOUS_MODE;
+	struct thead_pwm_chip *priv;
+	int ret, i;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->mmio_base))
+		return PTR_ERR(priv->mmio_base);
+
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->chip.ops = &thead_pwm_ops;
+	priv->chip.dev = &pdev->dev;
+	priv->chip.npwm = THEAD_PWM_MAX_NUM;
+
+	/* set normal polarity and other proper bits for all channels */
+	for (i = 0; i < priv->chip.npwm; i++)
+		writel(val, priv->mmio_base + THEAD_PWM_CTRL(i));
+
+	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+static void thead_pwm_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+}
+
+static const struct of_device_id thead_pwm_dt_ids[] = {
+	{.compatible = "thead,th1520-pwm",},
+	{/* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, thead_pwm_dt_ids);
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
+MODULE_AUTHOR("Wei Liu <lw312886@linux.alibaba.com>");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_DESCRIPTION("T-HEAD pwm driver");
+MODULE_LICENSE("GPL v2");
-- 
2.40.1

