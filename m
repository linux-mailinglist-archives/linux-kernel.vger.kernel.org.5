Return-Path: <linux-kernel+bounces-5419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7DB818A85
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4398228525B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368D1CF89;
	Tue, 19 Dec 2023 14:54:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274E1C688;
	Tue, 19 Dec 2023 14:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 1604424E27A;
	Tue, 19 Dec 2023 22:54:05 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 22:54:04 +0800
Received: from localhost.localdomain (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Dec
 2023 22:54:04 +0800
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner
	<tglx@linutronix.de>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Walker Chen
	<walker.chen@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor@kernel.org>
Subject: [PATCH v8 2/3] clocksource: Add JH7110 timer driver
Date: Tue, 19 Dec 2023 22:54:01 +0800
Message-ID: <20231219145402.7879-3-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219145402.7879-1-xingyu.wu@starfivetech.com>
References: <20231219145402.7879-1-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable

Add timer driver for the StarFive JH7110 SoC and select it by
CONFIG_SOC_STARFIVE.

This timer has four free-running and independent 32-bit counters.
Each channel(counter) can trigger an interrupt when timeout even
CPU is sleeping. So this timer is used as global timer and register
clockevent for each CPU core after riscv-timer registration on the
StarFive JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 MAINTAINERS                        |   7 +
 arch/riscv/Kconfig.socs            |   1 +
 drivers/clocksource/Kconfig        |   9 +
 drivers/clocksource/Makefile       |   1 +
 drivers/clocksource/timer-jh7110.c | 360 +++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h         |   1 +
 6 files changed, 379 insertions(+)
 create mode 100644 drivers/clocksource/timer-jh7110.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9104430e148e..fe0e803606a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20617,6 +20617,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/starfive,jh7110-tdm.yaml
 F:	sound/soc/starfive/jh7110_tdm.c
=20
+STARFIVE JH7110 TIMER DRIVER
+M:	Samin Guo <samin.guo@starfivetech.com>
+M:	Xingyu Wu <xingyu.wu@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/timer/starfive,jh7110-timer.yaml
+F:	drivers/clocksource/timer-jh7110.c
+
 STARFIVE JH71X0 CLOCK DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 M:	Hal Feng <hal.feng@starfivetech.com>
diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index e08e91c49abe..e986590f40b0 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -35,6 +35,7 @@ config SOC_STARFIVE
 	select PINCTRL
 	select RESET_CONTROLLER
 	select ARM_AMBA
+	select STARFIVE_JH7110_TIMER
 	help
 	  This enables support for StarFive SoC platform hardware.
=20
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 34faa0320ece..3f273f07a258 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -641,6 +641,15 @@ config RISCV_TIMER
 	  is accessed via both the SBI and the rdcycle instruction.  This is
 	  required for all RISC-V systems.
=20
+config STARFIVE_JH7110_TIMER
+	bool "Timer for the STARFIVE JH7110 SoC" if COMPILE_TEST
+	select TIMER_OF
+	select CLKSRC_MMIO
+	help
+	  This enables the timer for StarFive JH7110 SoC. On RISC-V platform,
+	  the system has started RISCV_TIMER, but you can also use this timer
+	  which can provide four channels of higher rating on the JH7110 SoC.
+
 config CLINT_TIMER
 	bool "CLINT Timer for the RISC-V platform" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && RISCV
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 4bb856e4df55..8dc2f0ea2d0f 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -80,6 +80,7 @@ obj-$(CONFIG_INGENIC_TIMER)		+=3D ingenic-timer.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+=3D clksrc_st_lpc.o
 obj-$(CONFIG_X86_NUMACHIP)		+=3D numachip.o
 obj-$(CONFIG_RISCV_TIMER)		+=3D timer-riscv.o
+obj-$(CONFIG_STARFIVE_JH7110_TIMER)	+=3D timer-jh7110.o
 obj-$(CONFIG_CLINT_TIMER)		+=3D timer-clint.o
 obj-$(CONFIG_CSKY_MP_TIMER)		+=3D timer-mp-csky.o
 obj-$(CONFIG_GX6605S_TIMER)		+=3D timer-gx6605s.o
diff --git a/drivers/clocksource/timer-jh7110.c b/drivers/clocksource/tim=
er-jh7110.c
new file mode 100644
index 000000000000..bd93e71969c2
--- /dev/null
+++ b/drivers/clocksource/timer-jh7110.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Starfive JH7110 Timer driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * This timer has four free-running and independent 32-bit counters and =
runs in 24MHz
+ * clock on the StarFive JH7110 SoC. Each channel(counter) can trigger a=
n interrupt
+ * when timeout even CPU is sleeping. They support one-shot mode and con=
tinuous-run mode.
+ *
+ * Each channel is used as a global timer that serves each cpu core:
+ * JH7110 Timer Channel 0 -- CPU 0
+ * JH7110 Timer Channel 1 -- CPU 1
+ * JH7110 Timer Channel 2 -- CPU 2
+ * JH7110 Timer Channel 3 -- CPU 3
+ */
+
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+
+/* Bias: Ch0-0x0, Ch1-0x40, Ch2-0x80, and so on. */
+#define JH7110_TIMER_CH_LEN		0x40
+#define JH7110_TIMER_CH_BASE(x)		((x) * JH7110_TIMER_CH_LEN)
+#define JH7110_TIMER_CH_MAX		4
+
+#define JH7110_DELAY_US			0
+#define JH7110_TIMEOUT_US		10000
+#define JH7110_CLOCKEVENT_RATING	300
+#define JH7110_TIMER_MAX_TICKS		0xffffffff
+#define JH7110_TIMER_MIN_TICKS		0xf
+
+#define JH7110_TIMER_INT_STATUS		0x00 /*
+					      * RO[0:4]: Interrupt Status for channel0~4
+					      * Only valid on the JH7110_TIMER_CH_BASE(0)
+					      */
+#define JH7110_TIMER_CTL		0x04 /* RW[0]: 0-continuous run, 1-single run =
*/
+#define JH7110_TIMER_LOAD		0x08 /* RW: load value to counter */
+#define JH7110_TIMER_ENABLE		0x10 /* RW[0]: timer enable register */
+#define JH7110_TIMER_RELOAD		0x14 /* RW: write 1 or 0 both reload counte=
r */
+#define JH7110_TIMER_VALUE		0x18 /* RO: timer value register */
+#define JH7110_TIMER_INT_CLR		0x20 /* RW: timer interrupt clear register=
 */
+#define JH7110_TIMER_INT_MASK		0x24 /* RW[0]: timer interrupt mask regis=
ter */
+
+#define JH7110_TIMER_RELOAD_VALID	0
+#define JH7110_TIMER_INT_CLR_ENA	BIT(0)
+#define JH7110_TIMER_INT_CLR_AVA_MASK	BIT(1)
+
+#define JH7110_PERCPU_GET_CLKEVT	(&jh7110_timer_info.clkevt[smp_processo=
r_id()])
+
+struct jh7110_clkevt {
+	struct clk *clk;
+	struct reset_control *rst;
+	void __iomem *base;
+	u32 reload_val;
+	int irq;
+	char name[sizeof("jh7110-timer.chX")];
+};
+
+struct jh7110_timer_priv {
+	struct reset_control *prst;
+	struct device *dev;
+	struct jh7110_clkevt clkevt[JH7110_TIMER_CH_MAX];
+};
+
+/* 0:continuous-run mode, 1:single-run mode */
+enum jh7110_timer_mode {
+	JH7110_TIMER_MODE_CONTIN,
+	JH7110_TIMER_MODE_SINGLE,
+};
+
+/* Interrupt Mask, 0:Unmask, 1:Mask */
+enum jh7110_timer_int_mask {
+	JH7110_TIMER_INT_ENA,
+	JH7110_TIMER_INT_DIS,
+};
+
+enum jh7110_timer_enable {
+	JH7110_TIMER_DIS,
+	JH7110_TIMER_ENA,
+};
+
+static struct jh7110_timer_priv jh7110_timer_info;
+
+/*
+ * BIT(0): Read value represent channel int status.
+ * Write 1 to this bit to clear interrupt. Write 0 has no effects.
+ * BIT(1): "1" means that it is clearing interrupt. BIT(0) can not be wr=
itten.
+ */
+static int jh7110_timer_int_is_clearing(struct jh7110_clkevt *clkevt)
+{
+	u32 value;
+
+	/* Waiting interrupt can be cleared */
+	return readl_poll_timeout_atomic(clkevt->base + JH7110_TIMER_INT_CLR, v=
alue,
+					 !(value & JH7110_TIMER_INT_CLR_AVA_MASK),
+					 JH7110_DELAY_US, JH7110_TIMEOUT_US);
+}
+
+static int jh7110_timer_start(struct jh7110_clkevt *clkevt)
+{
+	int ret;
+
+	/* Disable and clear interrupt first */
+	writel(JH7110_TIMER_INT_DIS, clkevt->base + JH7110_TIMER_INT_MASK);
+	ret =3D jh7110_timer_int_is_clearing(clkevt);
+	if (ret)
+		return ret;
+
+	writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base + JH7110_TIMER_INT_CLR))=
;
+	writel(JH7110_TIMER_INT_ENA, clkevt->base + JH7110_TIMER_INT_MASK);
+	writel(JH7110_TIMER_ENA, clkevt->base + JH7110_TIMER_ENABLE);
+
+	return 0;
+}
+
+static int jh7110_timer_shutdown(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
+	int ret =3D 0;
+
+	writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
+	ret =3D jh7110_timer_int_is_clearing(clkevt);
+	if (!ret)
+		writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base + JH7110_TIMER_INT_CLR)=
);
+
+	return ret;
+}
+
+static void jh7110_timer_suspend(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
+
+	clkevt->reload_val =3D readl(clkevt->base + JH7110_TIMER_LOAD);
+	jh7110_timer_shutdown(evt);
+}
+
+static int jh7110_timer_tick_resume(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
+
+	writel(clkevt->reload_val, clkevt->base + JH7110_TIMER_LOAD);
+	writel(JH7110_TIMER_RELOAD_VALID, clkevt->base + JH7110_TIMER_RELOAD);
+	return jh7110_timer_start(clkevt);
+}
+
+static void jh7110_timer_resume(struct clock_event_device *evt)
+{
+	jh7110_timer_tick_resume(evt);
+}
+
+/* IRQ handler for the timer */
+static irqreturn_t jh7110_timer_interrupt(int irq, void *data)
+{
+	struct clock_event_device *evt =3D data;
+	struct jh7110_clkevt *clkevt =3D &jh7110_timer_info.clkevt[0];
+	u8 cpu_id =3D smp_processor_id();
+	u32 reg =3D readl(clkevt->base + JH7110_TIMER_INT_STATUS);
+
+	/* Check interrupt status and channel(cpu) ID */
+	if (!(reg & BIT(cpu_id)))
+		return IRQ_NONE;
+
+	clkevt =3D &jh7110_timer_info.clkevt[cpu_id];
+	writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base + JH7110_TIMER_INT_CLR))=
;
+
+	if (evt->event_handler)
+		evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int jh7110_timer_set_periodic(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_MODE_CONTIN, clkevt->base + JH7110_TIMER_CTL);
+	return 0;
+}
+
+static int jh7110_timer_set_oneshot(struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base + JH7110_TIMER_CTL);
+	return 0;
+}
+
+static int jh7110_timer_set_next_event(unsigned long next,
+				       struct clock_event_device *evt)
+{
+	struct jh7110_clkevt *clkevt =3D JH7110_PERCPU_GET_CLKEVT;
+
+	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base + JH7110_TIMER_CTL);
+	writel(next, clkevt->base + JH7110_TIMER_LOAD);
+
+	return jh7110_timer_start(clkevt);
+}
+
+static DEFINE_PER_CPU(struct clock_event_device, jh7110_clock_event) =3D=
 {
+	.features =3D CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
+	.rating =3D JH7110_CLOCKEVENT_RATING,
+	.set_state_shutdown =3D jh7110_timer_shutdown,
+	.set_state_periodic =3D jh7110_timer_set_periodic,
+	.set_state_oneshot =3D jh7110_timer_set_oneshot,
+	.set_state_oneshot_stopped =3D jh7110_timer_shutdown,
+	.tick_resume =3D jh7110_timer_tick_resume,
+	.set_next_event =3D jh7110_timer_set_next_event,
+	.suspend =3D jh7110_timer_suspend,
+	.resume =3D jh7110_timer_resume,
+};
+
+static int jh7110_timer_starting_cpu(unsigned int cpu)
+{
+	struct clock_event_device *evt =3D per_cpu_ptr(&jh7110_clock_event, cpu=
);
+	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
+	int ret;
+	u32 rate;
+
+	if (cpu >=3D JH7110_TIMER_CH_MAX)
+		return -ENOMEM;
+
+	ret =3D clk_prepare_enable(priv->clkevt[cpu].clk);
+	if (ret)
+		return ret;
+
+	ret =3D reset_control_deassert(priv->clkevt[cpu].rst);
+	if (ret)
+		return ret;
+
+	rate =3D clk_get_rate(priv->clkevt[cpu].clk);
+	evt->cpumask =3D cpumask_of(cpu);
+	evt->irq =3D priv->clkevt[cpu].irq;
+	evt->name =3D priv->clkevt[cpu].name;
+	clockevents_config_and_register(evt, rate, JH7110_TIMER_MIN_TICKS,
+					JH7110_TIMER_MAX_TICKS);
+
+	ret =3D devm_request_irq(priv->dev, evt->irq, jh7110_timer_interrupt,
+			       IRQF_TIMER | IRQF_IRQPOLL,
+			       evt->name, evt);
+	if (ret)
+		return ret;
+
+	ret =3D irq_set_affinity(evt->irq, cpumask_of(cpu));
+	if (ret)
+		return ret;
+
+	/* Use one-shot mode */
+	writel(JH7110_TIMER_MODE_SINGLE, (priv->clkevt[cpu].base + JH7110_TIMER=
_CTL));
+
+	return jh7110_timer_start(&priv->clkevt[cpu]);
+}
+
+static void jh7110_timer_release(void *data)
+{
+	struct jh7110_timer_priv *priv =3D data;
+	int i;
+
+	for (i =3D 0; i < JH7110_TIMER_CH_MAX; i++) {
+		/* Disable each channel of timer */
+		if (priv->clkevt[i].base)
+			writel(JH7110_TIMER_DIS, priv->clkevt[i].base + JH7110_TIMER_ENABLE);
+
+		/* Avoid no initialization in the loop of the probe */
+		if (!IS_ERR_OR_NULL(priv->clkevt[i].rst))
+			reset_control_assert(priv->clkevt[i].rst);
+
+		if (!IS_ERR_OR_NULL(priv->clkevt[i].clk))
+			clk_disable_unprepare(priv->clkevt[i].clk);
+	}
+
+	reset_control_assert(priv->prst);
+}
+
+static int jh7110_timer_probe(struct platform_device *pdev)
+{
+	struct jh7110_timer_priv *priv =3D &jh7110_timer_info;
+	struct jh7110_clkevt *clkevt;
+	struct clk *pclk;
+	void __iomem *base;
+	int ch;
+	int ret;
+	char name[sizeof("chX")];
+
+	base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(base),
+				     "failed to map registers\n");
+
+	priv->prst =3D devm_reset_control_get_exclusive(&pdev->dev, "apb");
+	if (IS_ERR(priv->prst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(priv->prst),
+				     "failed to get apb reset\n");
+
+	pclk =3D devm_clk_get_enabled(&pdev->dev, "apb");
+	if (IS_ERR(pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pclk),
+				     "failed to get & enable apb clock\n");
+
+	ret =3D reset_control_deassert(priv->prst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to deassert apb reset\n"=
);
+
+	ret =3D devm_add_action_or_reset(&pdev->dev, jh7110_timer_release, priv=
);
+	if (ret)
+		return ret;
+
+	priv->dev =3D &pdev->dev;
+	for (ch =3D 0; ch < JH7110_TIMER_CH_MAX; ch++) {
+		clkevt =3D &priv->clkevt[ch];
+		snprintf(name, sizeof(name), "ch%d", ch);
+
+		clkevt->base =3D base + JH7110_TIMER_CH_BASE(ch);
+		/* Ensure timer is disabled */
+		writel(JH7110_TIMER_DIS, clkevt->base + JH7110_TIMER_ENABLE);
+		if (!jh7110_timer_int_is_clearing(clkevt))
+			writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base + JH7110_TIMER_INT_CLR=
));
+
+		clkevt->rst =3D devm_reset_control_get_exclusive(&pdev->dev, name);
+		if (IS_ERR(clkevt->rst))
+			return PTR_ERR(clkevt->rst);
+
+		clkevt->clk =3D devm_clk_get(&pdev->dev, name);
+		if (IS_ERR(clkevt->clk))
+			return PTR_ERR(clkevt->clk);
+
+		clkevt->irq =3D platform_get_irq(pdev, ch);
+		if (clkevt->irq < 0)
+			return clkevt->irq;
+
+		snprintf(clkevt->name, sizeof(clkevt->name), "jh7110-timer.ch%d", ch);
+	}
+
+	return cpuhp_setup_state(CPUHP_AP_JH7110_TIMER_STARTING,
+				 "clockevents/jh7110/timer:starting",
+				 jh7110_timer_starting_cpu, NULL);
+}
+
+static const struct of_device_id jh7110_timer_match[] =3D {
+	{ .compatible =3D "starfive,jh7110-timer", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, jh7110_timer_match);
+
+static struct platform_driver jh7110_timer_driver =3D {
+	.probe =3D jh7110_timer_probe,
+	.driver =3D {
+		.name =3D "jh7110-timer",
+		.of_match_table =3D jh7110_timer_match,
+	},
+};
+module_platform_driver(jh7110_timer_driver);
+
+MODULE_AUTHOR("Xingyu Wu <xingyu.wu@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 timer driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index efc0c0b07efb..f28a3aaf93f9 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -187,6 +187,7 @@ enum cpuhp_state {
 	CPUHP_AP_CSKY_TIMER_STARTING,
 	CPUHP_AP_TI_GP_TIMER_STARTING,
 	CPUHP_AP_HYPERV_TIMER_STARTING,
+	CPUHP_AP_JH7110_TIMER_STARTING,
 	/* Must be the last timer callback */
 	CPUHP_AP_DUMMY_TIMER_STARTING,
 	CPUHP_AP_ARM_XEN_STARTING,
--=20
2.25.1


