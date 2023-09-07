Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3887E79784F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjIGQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234303AbjIGQpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:45:53 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3763A19A8;
        Thu,  7 Sep 2023 09:45:19 -0700 (PDT)
Received: from [134.238.52.102] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qeHce-0052RE-DU; Thu, 07 Sep 2023 17:12:48 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qeHcd-000HUp-2W;
        Thu, 07 Sep 2023 17:12:47 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.dooks@codethink.co.uk, u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: [PATCH v9 1/6] pwm: dwc: split pci out of core driver
Date:   Thu,  7 Sep 2023 17:12:37 +0100
Message-Id: <20230907161242.67190-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
References: <20230907161242.67190-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving towards adding non-pci support for the driver, move the pci
parts out of the core into their own module. This is partly due to
the module_driver() code only being allowed once in a module and also
to avoid a number of #ifdef if we build a single file in a system
without pci support.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

---
v9:
 - change back to codethink email from sifive
v8:
 - add module namespace
 - remove compile-test for pci case, doesn't make sense
 - fix makefile, missed config symbol changes
v7:
 - re-order kconfig to make dwc core be selected by PCI driver
v6:
 - put DWC_PERIOD_NS back to avoid bisect issues
v4:
 - removed DWC_PERIOD_NS as not needed
---
 drivers/pwm/Kconfig        |  14 ++-
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-dwc-core.c | 176 +++++++++++++++++++++++++++++++++
 drivers/pwm/pwm-dwc.c      | 197 +------------------------------------
 drivers/pwm/pwm-dwc.h      |  60 +++++++++++
 5 files changed, 253 insertions(+), 195 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-core.c
 create mode 100644 drivers/pwm/pwm-dwc.h

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8ebcddf91f7b..507c8b8547a5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -186,9 +186,19 @@ config PWM_CROS_EC
 	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
 	  Controller.
 
+config PWM_DWC_CORE
+	tristate
+	depends on HAS_IOMEM
+	help
+	  PWM driver for Synopsys DWC PWM Controller.
+
+	  To compile this driver as a module, build the dependecies as
+	  modules, this will be called pwm-dwc-core.
+
 config PWM_DWC
-	tristate "DesignWare PWM Controller"
-	depends on PCI
+	tristate "DesignWare PWM Controller (PCI bus)"
+	depends on HAS_IOMEM && PCI
+	select PWM_DWC_CORE
 	help
 	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
 
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c822389c2a24..c5ec9e168ee7 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
 obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
 obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
 obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
+obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
 obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
 obj-$(CONFIG_PWM_EP93XX)	+= pwm-ep93xx.o
 obj-$(CONFIG_PWM_FSL_FTM)	+= pwm-fsl-ftm.o
diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
new file mode 100644
index 000000000000..b693cb7fa812
--- /dev/null
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver core
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ */
+
+#define DEFAULT_SYMBOL_NAMESPACE dwc_pwm
+
+#include <linux/bitops.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+
+#include "pwm-dwc.h"
+
+static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
+{
+	u32 reg;
+
+	reg = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm));
+
+	if (enabled)
+		reg |= DWC_TIM_CTRL_EN;
+	else
+		reg &= ~DWC_TIM_CTRL_EN;
+
+	dwc_pwm_writel(dwc, reg, DWC_TIM_CTRL(pwm));
+}
+
+static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
+				     struct pwm_device *pwm,
+				     const struct pwm_state *state)
+{
+	u64 tmp;
+	u32 ctrl;
+	u32 high;
+	u32 low;
+
+	/*
+	 * Calculate width of low and high period in terms of input clock
+	 * periods and check are the result within HW limits between 1 and
+	 * 2^32 periods.
+	 */
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	if (tmp < 1 || tmp > (1ULL << 32))
+		return -ERANGE;
+	low = tmp - 1;
+
+	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
+				    DWC_CLK_PERIOD_NS);
+	if (tmp < 1 || tmp > (1ULL << 32))
+		return -ERANGE;
+	high = tmp - 1;
+
+	/*
+	 * Specification says timer usage flow is to disable timer, then
+	 * program it followed by enable. It also says Load Count is loaded
+	 * into timer after it is enabled - either after a disable or
+	 * a reset. Based on measurements it happens also without disable
+	 * whenever Load Count is updated. But follow the specification.
+	 */
+	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+
+	/*
+	 * Write Load Count and Load Count 2 registers. Former defines the
+	 * width of low period and latter the width of high period in terms
+	 * multiple of input clock periods:
+	 * Width = ((Count + 1) * input clock period).
+	 */
+	dwc_pwm_writel(dwc, low, DWC_TIM_LD_CNT(pwm->hwpwm));
+	dwc_pwm_writel(dwc, high, DWC_TIM_LD_CNT2(pwm->hwpwm));
+
+	/*
+	 * Set user-defined mode, timer reloads from Load Count registers
+	 * when it counts down to 0.
+	 * Set PWM mode, it makes output to toggle and width of low and high
+	 * periods are set by Load Count registers.
+	 */
+	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
+	dwc_pwm_writel(dwc, ctrl, DWC_TIM_CTRL(pwm->hwpwm));
+
+	/*
+	 * Enable timer. Output starts from low period.
+	 */
+	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
+
+	return 0;
+}
+
+static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+
+	if (state->polarity != PWM_POLARITY_INVERSED)
+		return -EINVAL;
+
+	if (state->enabled) {
+		if (!pwm->state.enabled)
+			pm_runtime_get_sync(chip->dev);
+		return __dwc_pwm_configure_timer(dwc, pwm, state);
+	} else {
+		if (pwm->state.enabled) {
+			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
+			pm_runtime_put_sync(chip->dev);
+		}
+	}
+
+	return 0;
+}
+
+static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			     struct pwm_state *state)
+{
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	u64 duty, period;
+
+	pm_runtime_get_sync(chip->dev);
+
+	state->enabled = !!(dwc_pwm_readl(dwc,
+				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+
+	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	duty += 1;
+	duty *= DWC_CLK_PERIOD_NS;
+	state->duty_cycle = duty;
+
+	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
+	period += 1;
+	period *= DWC_CLK_PERIOD_NS;
+	period += duty;
+	state->period = period;
+
+	state->polarity = PWM_POLARITY_INVERSED;
+
+	pm_runtime_put_sync(chip->dev);
+
+	return 0;
+}
+
+static const struct pwm_ops dwc_pwm_ops = {
+	.apply = dwc_pwm_apply,
+	.get_state = dwc_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+{
+	struct dwc_pwm *dwc;
+
+	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
+	if (!dwc)
+		return NULL;
+
+	dwc->chip.dev = dev;
+	dwc->chip.ops = &dwc_pwm_ops;
+	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+
+	dev_set_drvdata(dev, dwc);
+	return dwc;
+}
+EXPORT_SYMBOL_GPL(dwc_pwm_alloc);
+
+MODULE_AUTHOR("Felipe Balbi (Intel)");
+MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@linux.intel.com>");
+MODULE_AUTHOR("Raymond Tan <raymond.tan@intel.com>");
+MODULE_DESCRIPTION("DesignWare PWM Controller");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 3bbb26c862c3..bd9cadb497d7 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DesignWare PWM Controller driver
+ * DesignWare PWM Controller driver (PCI part)
  *
  * Copyright (C) 2018-2020 Intel Corporation
  *
@@ -13,6 +13,8 @@
  *   periods are one or more input clock periods long.
  */
 
+#define DEFAULT_MOUDLE_NAMESPACE dwc_pwm
+
 #include <linux/bitops.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
@@ -21,198 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
 
-#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
-#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
-#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
-#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
-#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
-#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
-
-#define DWC_TIMERS_INT_STS	0xa0
-#define DWC_TIMERS_EOI		0xa4
-#define DWC_TIMERS_RAW_INT_STS	0xa8
-#define DWC_TIMERS_COMP_VERSION	0xac
-
-#define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
-
-/* Timer Control Register */
-#define DWC_TIM_CTRL_EN		BIT(0)
-#define DWC_TIM_CTRL_MODE	BIT(1)
-#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
-#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
-#define DWC_TIM_CTRL_INT_MASK	BIT(2)
-#define DWC_TIM_CTRL_PWM	BIT(3)
-
-struct dwc_pwm_ctx {
-	u32 cnt;
-	u32 cnt2;
-	u32 ctrl;
-};
-
-struct dwc_pwm {
-	struct pwm_chip chip;
-	void __iomem *base;
-	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
-};
-#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-
-static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
-{
-	return readl(dwc->base + offset);
-}
-
-static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
-{
-	writel(value, dwc->base + offset);
-}
-
-static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
-{
-	u32 reg;
-
-	reg = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm));
-
-	if (enabled)
-		reg |= DWC_TIM_CTRL_EN;
-	else
-		reg &= ~DWC_TIM_CTRL_EN;
-
-	dwc_pwm_writel(dwc, reg, DWC_TIM_CTRL(pwm));
-}
-
-static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
-				     struct pwm_device *pwm,
-				     const struct pwm_state *state)
-{
-	u64 tmp;
-	u32 ctrl;
-	u32 high;
-	u32 low;
-
-	/*
-	 * Calculate width of low and high period in terms of input clock
-	 * periods and check are the result within HW limits between 1 and
-	 * 2^32 periods.
-	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
-	if (tmp < 1 || tmp > (1ULL << 32))
-		return -ERANGE;
-	low = tmp - 1;
-
-	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
-	if (tmp < 1 || tmp > (1ULL << 32))
-		return -ERANGE;
-	high = tmp - 1;
-
-	/*
-	 * Specification says timer usage flow is to disable timer, then
-	 * program it followed by enable. It also says Load Count is loaded
-	 * into timer after it is enabled - either after a disable or
-	 * a reset. Based on measurements it happens also without disable
-	 * whenever Load Count is updated. But follow the specification.
-	 */
-	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
-
-	/*
-	 * Write Load Count and Load Count 2 registers. Former defines the
-	 * width of low period and latter the width of high period in terms
-	 * multiple of input clock periods:
-	 * Width = ((Count + 1) * input clock period).
-	 */
-	dwc_pwm_writel(dwc, low, DWC_TIM_LD_CNT(pwm->hwpwm));
-	dwc_pwm_writel(dwc, high, DWC_TIM_LD_CNT2(pwm->hwpwm));
-
-	/*
-	 * Set user-defined mode, timer reloads from Load Count registers
-	 * when it counts down to 0.
-	 * Set PWM mode, it makes output to toggle and width of low and high
-	 * periods are set by Load Count registers.
-	 */
-	ctrl = DWC_TIM_CTRL_MODE_USER | DWC_TIM_CTRL_PWM;
-	dwc_pwm_writel(dwc, ctrl, DWC_TIM_CTRL(pwm->hwpwm));
-
-	/*
-	 * Enable timer. Output starts from low period.
-	 */
-	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
-
-	return 0;
-}
-
-static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			 const struct pwm_state *state)
-{
-	struct dwc_pwm *dwc = to_dwc_pwm(chip);
-
-	if (state->polarity != PWM_POLARITY_INVERSED)
-		return -EINVAL;
-
-	if (state->enabled) {
-		if (!pwm->state.enabled)
-			pm_runtime_get_sync(chip->dev);
-		return __dwc_pwm_configure_timer(dwc, pwm, state);
-	} else {
-		if (pwm->state.enabled) {
-			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
-			pm_runtime_put_sync(chip->dev);
-		}
-	}
-
-	return 0;
-}
-
-static int dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-			     struct pwm_state *state)
-{
-	struct dwc_pwm *dwc = to_dwc_pwm(chip);
-	u64 duty, period;
-
-	pm_runtime_get_sync(chip->dev);
-
-	state->enabled = !!(dwc_pwm_readl(dwc,
-				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
-
-	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
-	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
-	state->duty_cycle = duty;
-
-	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
-	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
-	period += duty;
-	state->period = period;
-
-	state->polarity = PWM_POLARITY_INVERSED;
-
-	pm_runtime_put_sync(chip->dev);
-
-	return 0;
-}
-
-static const struct pwm_ops dwc_pwm_ops = {
-	.apply = dwc_pwm_apply,
-	.get_state = dwc_pwm_get_state,
-	.owner = THIS_MODULE,
-};
-
-static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
-{
-	struct dwc_pwm *dwc;
-
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return NULL;
-
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-
-	dev_set_drvdata(dev, dwc);
-	return dwc;
-}
+#include "pwm-dwc.h"
 
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
new file mode 100644
index 000000000000..56deab4e28ec
--- /dev/null
+++ b/drivers/pwm/pwm-dwc.h
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DesignWare PWM Controller driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation
+ *
+ * Author: Felipe Balbi (Intel)
+ * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
+ * Author: Raymond Tan <raymond.tan@intel.com>
+ */
+
+MODULE_IMPORT_NS(dwc_pwm);
+
+#define DWC_TIM_LD_CNT(n)	((n) * 0x14)
+#define DWC_TIM_LD_CNT2(n)	(((n) * 4) + 0xb0)
+#define DWC_TIM_CUR_VAL(n)	(((n) * 0x14) + 0x04)
+#define DWC_TIM_CTRL(n)		(((n) * 0x14) + 0x08)
+#define DWC_TIM_EOI(n)		(((n) * 0x14) + 0x0c)
+#define DWC_TIM_INT_STS(n)	(((n) * 0x14) + 0x10)
+
+#define DWC_TIMERS_INT_STS	0xa0
+#define DWC_TIMERS_EOI		0xa4
+#define DWC_TIMERS_RAW_INT_STS	0xa8
+#define DWC_TIMERS_COMP_VERSION	0xac
+
+#define DWC_TIMERS_TOTAL	8
+#define DWC_CLK_PERIOD_NS	10
+
+/* Timer Control Register */
+#define DWC_TIM_CTRL_EN		BIT(0)
+#define DWC_TIM_CTRL_MODE	BIT(1)
+#define DWC_TIM_CTRL_MODE_FREE	(0 << 1)
+#define DWC_TIM_CTRL_MODE_USER	(1 << 1)
+#define DWC_TIM_CTRL_INT_MASK	BIT(2)
+#define DWC_TIM_CTRL_PWM	BIT(3)
+
+struct dwc_pwm_ctx {
+	u32 cnt;
+	u32 cnt2;
+	u32 ctrl;
+};
+
+struct dwc_pwm {
+	struct pwm_chip chip;
+	void __iomem *base;
+	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
+};
+#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
+{
+	return readl(dwc->base + offset);
+}
+
+static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
+{
+	writel(value, dwc->base + offset);
+}
+
+extern struct dwc_pwm *dwc_pwm_alloc(struct device *dev);
-- 
2.40.1

