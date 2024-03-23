Return-Path: <linux-kernel+bounces-112468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D02887A37
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 20:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF361C20B5B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB35B208;
	Sat, 23 Mar 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZeF9VpMt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="awGa4Ts5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70615821A
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711223526; cv=none; b=lkrz4o/mJstKgRQgFqkQTPYlTyosCNYwHXNxsf5LjRtD53hl7ThSuzdfsiajP+G+9oQSyy4mC3N8XedegSjmi4K740J6Hgk0sBf1MqPAnc65uoHOkigm8HfvNrO36w1lxOMlfIYo6v0IfQ34Kz8EdAWM0p9S0RYMvYZWFuzwQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711223526; c=relaxed/simple;
	bh=RKOsCZo38YfmsU+e15mvOswudvIU7mBtoDV3lBK21Og=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=XI1BlgCTEg7C0AWL+pUaT1CPEsoWjV8M/P5+YY+IA9khgRRX3EvdBLKtBKjc7g+zVLC5V74US/hlKtFc2R5G9rwMH4xueTox4+cVqkuWUpzVZ0MyZAF+r95nTyGfogwr2dk5JW3t9tvB0aT2qdcW7XThCQT7E8Fq6isIup0YUd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZeF9VpMt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=awGa4Ts5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711223523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=buhOTiONly2BseH1ffB0I5On4Xk5raOUPTYKgYCrMrw=;
	b=ZeF9VpMtKPWpbi/Yvrww48vpZCGD2v6yDiHgwOKMAaCno18uO+uZ63siksLQUsgAvLcOAy
	RuVPRUyWYQQP7ZKGb7OTOgJfTWjT4TgKi9pNjrozjfX0n3NzTUHn0rE/oszaAkJwzRcTQT
	yt3SSMe7SIsWFpFtXAl4b6IxgtT4b6Y2gInjeskAVZIRHdrKdGYWXcOrxfd7pdorcAGqRV
	h7WcwvGBR3bDHCyy+OowGHQYWdIx0xcflUJPPpSKR8KlrxJHgodMk+xzofsixX5fx1ONoZ
	2FsBorvWr1+dBG+BYDxxooCMXqi5ZXBuLX5wNBUH1EmZlsQsKgNnpUcGvbNeNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711223523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=buhOTiONly2BseH1ffB0I5On4Xk5raOUPTYKgYCrMrw=;
	b=awGa4Ts5wqU6L06/J7Ec6XQY5Q4GGPd587MlNoWKqvRf7YuuA0DVWMPzvQyEKWHulYq01D
	yDtmf8UN+ogXPxCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.9-rc1
References: <171122346785.2772088.10596056144848184713.tglx@xen13>
Message-ID: <171122347111.2772088.14110191144631232859.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 23 Mar 2024 20:52:02 +0100 (CET)

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024=
-03-23

up to:  86c54c846e12: Merge tag 'timers-v6.9-rc1' of https://git.linaro.org/p=
eople/daniel.lezcano/linux into timers/core

A set of updates for clocksource and clockevent drivers:

  - A fix for the prescaler of the ARM global timer where the prescaler
    mask define only covered 4 bits while it is actully 8 bits wide. This
    restricted obviously the possible range of the prescaler adjustments.

  - A fix for the RISC-V timer which prevents a timer interrupt being
    raised while the timer is initialized.

  - A set of device tree updates to support new system on chips in various
    drivers.

  - Kernel-doc and other cleanups all over the place.

Thanks,

	tglx

------------------>
Daniel Lezcano (1):
      clocksource/drivers/imx: Fix -Wunused-but-set-variable warning

Geert Uytterhoeven (1):
      dt-bindings: timer: renesas,tmu: Document input capture interrupt

Lad Prabhakar (1):
      dt-bindings: timer: renesas: ostm: Document RZ/Five SoC

Ley Foon Tan (1):
      clocksource/drivers/timer-riscv: Clear timer interrupt on timer initial=
ization

Martin Blumenstingl (5):
      clocksource/drivers/arm_global_timer: Fix maximum prescaler value
      clocksource/drivers/arm_global_timer: Remove stray tab
      clocksource/drivers/arm_global_timer: Make gt_target_rate unsigned long
      clocksource/drivers/arm_global_timer: Guard against division by zero
      clocksource/drivers/arm_global_timer: Simplify prescaler register access

Mubin Sayyed (1):
      dt-bindings: timer: Add support for cadence TTC PWM

Peng Fan (3):
      dt-bindings: timer: nxp,sysctr-timer: support i.MX95
      clocksource/drivers/imx-sysctr: Drop use global variables
      clocksource/drivers/imx-sysctr: Add i.MX95 support

Peter Griffin (1):
      dt-bindings: timer: exynos4210-mct: Add google,gs101-mct compatible

Randy Dunlap (3):
      clocksource/drivers/stm32: Fix all kernel-doc warnings
      clocksource/drivers/ti-32K: Fix misuse of "/**" comment
      clocksource: arm_global_timer: fix non-kernel-doc comment

Sergio Paracuellos (1):
      dt-bindings: timer: add Ralink SoCs system tick counter


 .../devicetree/bindings/timer/cdns,ttc.yaml        |  22 +++-
 .../bindings/timer/nxp,sysctr-timer.yaml           |   4 +-
 .../bindings/timer/ralink,cevt-systick.yaml        |  38 +++++++
 .../devicetree/bindings/timer/renesas,ostm.yaml    |   2 +-
 .../devicetree/bindings/timer/renesas,tmu.yaml     |  18 +++-
 .../bindings/timer/samsung,exynos4210-mct.yaml     |   2 +
 drivers/clocksource/arm_global_timer.c             |  35 +++---
 drivers/clocksource/timer-imx-gpt.c                |   3 +-
 drivers/clocksource/timer-imx-sysctr.c             | 117 +++++++++++++++----=
--
 drivers/clocksource/timer-riscv.c                  |   3 +
 drivers/clocksource/timer-stm32.c                  |   4 +-
 drivers/clocksource/timer-ti-32k.c                 |   2 +-
 12 files changed, 191 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/ralink,cevt-systi=
ck.yaml

diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Document=
ation/devicetree/bindings/timer/cdns,ttc.yaml
index dbba780c9b02..da342464d32e 100644
--- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
+++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
@@ -32,12 +32,23 @@ properties:
     description: |
       Bit width of the timer, necessary if not 16.
=20
+  "#pwm-cells":
+    const: 3
+
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
=20
+allOf:
+  - if:
+      not:
+        required:
+          - "#pwm-cells"
+    then:
+      required:
+        - interrupts
+
 additionalProperties: false
=20
 examples:
@@ -50,3 +61,12 @@ examples:
         clocks =3D <&cpu_clk 3>;
         timer-width =3D <32>;
     };
+
+  - |
+    pwm: pwm@f8002000 {
+        compatible =3D "cdns,ttc";
+        reg =3D <0xf8002000 0x1000>;
+        clocks =3D <&cpu_clk 3>;
+        timer-width =3D <32>;
+        #pwm-cells =3D <3>;
+    };
diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml b/=
Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
index 2b9653dafab8..891cca009528 100644
--- a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
@@ -18,7 +18,9 @@ description: |
=20
 properties:
   compatible:
-    const: nxp,sysctr-timer
+    enum:
+      - nxp,imx95-sysctr-timer
+      - nxp,sysctr-timer
=20
   reg:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml=
 b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
new file mode 100644
index 000000000000..59d97feddf4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/ralink,cevt-systick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: System tick counter present in Ralink family SoCs
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+properties:
+  compatible:
+    const: ralink,cevt-systick
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    systick@d00 {
+        compatible =3D "ralink,cevt-systick";
+        reg =3D <0xd00 0x10>;
+
+        interrupt-parent =3D <&cpuintc>;
+        interrupts =3D <7>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml b/Docu=
mentation/devicetree/bindings/timer/renesas,ostm.yaml
index 7207929e5cd6..8b06a681764e 100644
--- a/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,ostm.yaml
@@ -23,7 +23,7 @@ properties:
       - enum:
           - renesas,r7s72100-ostm  # RZ/A1H
           - renesas,r7s9210-ostm   # RZ/A2M
-          - renesas,r9a07g043-ostm # RZ/G2UL
+          - renesas,r9a07g043-ostm # RZ/G2UL and RZ/Five
           - renesas,r9a07g044-ostm # RZ/G2{L,LC}
           - renesas,r9a07g054-ostm # RZ/V2L
       - const: renesas,ostm        # Generic
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Docum=
entation/devicetree/bindings/timer/renesas,tmu.yaml
index a67e427a9e7e..84bbe15028a1 100644
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -46,7 +46,19 @@ properties:
=20
   interrupts:
     minItems: 2
-    maxItems: 3
+    items:
+      - description: Underflow interrupt, channel 0
+      - description: Underflow interrupt, channel 1
+      - description: Underflow interrupt, channel 2
+      - description: Input capture interrupt, channel 2
+
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: tuni0
+      - const: tuni1
+      - const: tuni2
+      - const: ticpi2
=20
   clocks:
     maxItems: 1
@@ -100,7 +112,9 @@ examples:
             reg =3D <0xffd80000 0x30>;
             interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
                          <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names =3D "tuni0", "tuni1", "tuni2", "ticpi2";
             clocks =3D <&mstp0_clks R8A7779_CLK_TMU0>;
             clock-names =3D "fck";
             power-domains =3D <&sysc R8A7779_PD_ALWAYS_ON>;
diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.y=
aml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 829bd2227f7c..774b7992a0ca 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - axis,artpec8-mct
+              - google,gs101-mct
               - samsung,exynos3250-mct
               - samsung,exynos5250-mct
               - samsung,exynos5260-mct
@@ -127,6 +128,7 @@ allOf:
           contains:
             enum:
               - axis,artpec8-mct
+              - google,gs101-mct
               - samsung,exynos5260-mct
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm=
_global_timer.c
index 44a61dc6f932..ab1c8c2b66b8 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -9,6 +9,7 @@
=20
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -31,10 +32,7 @@
 #define GT_CONTROL_COMP_ENABLE		BIT(1)	/* banked */
 #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
 #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
-#define GT_CONTROL_PRESCALER_SHIFT      8
-#define GT_CONTROL_PRESCALER_MAX        0xF
-#define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
-					 GT_CONTROL_PRESCALER_SHIFT)
+#define GT_CONTROL_PRESCALER_MASK	GENMASK(15, 8)
=20
 #define GT_INT_STATUS	0x0c
 #define GT_INT_STATUS_EVENT_FLAG	BIT(0)
@@ -52,7 +50,8 @@
  */
 static void __iomem *gt_base;
 static struct notifier_block gt_clk_rate_change_nb;
-static u32 gt_psv_new, gt_psv_bck, gt_target_rate;
+static u32 gt_psv_new, gt_psv_bck;
+static unsigned long gt_target_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
=20
@@ -88,7 +87,7 @@ static u64 gt_counter_read(void)
 	return _gt_counter_read();
 }
=20
-/**
+/*
  * To ensure that updates to comparator value register do not set the
  * Interrupt Status Register proceed as follows:
  * 1. Clear the Comp Enable bit in the Timer Control Register.
@@ -247,7 +246,7 @@ static void gt_write_presc(u32 psv)
=20
 	reg =3D readl(gt_base + GT_CONTROL);
 	reg &=3D ~GT_CONTROL_PRESCALER_MASK;
-	reg |=3D psv << GT_CONTROL_PRESCALER_SHIFT;
+	reg |=3D FIELD_PREP(GT_CONTROL_PRESCALER_MASK, psv);
 	writel(reg, gt_base + GT_CONTROL);
 }
=20
@@ -256,8 +255,7 @@ static u32 gt_read_presc(void)
 	u32 reg;
=20
 	reg =3D readl(gt_base + GT_CONTROL);
-	reg &=3D GT_CONTROL_PRESCALER_MASK;
-	return reg >> GT_CONTROL_PRESCALER_SHIFT;
+	return FIELD_GET(GT_CONTROL_PRESCALER_MASK, reg);
 }
=20
 static void __init gt_delay_timer_init(void)
@@ -272,9 +270,9 @@ static int __init gt_clocksource_init(void)
 	writel(0, gt_base + GT_COUNTER0);
 	writel(0, gt_base + GT_COUNTER1);
 	/* set prescaler and enable timer on all the cores */
-	writel(((CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) <<
-		GT_CONTROL_PRESCALER_SHIFT)
-	       | GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+	writel(FIELD_PREP(GT_CONTROL_PRESCALER_MASK,
+			  CONFIG_ARM_GT_INITIAL_PRESCALER_VAL - 1) |
+	       GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
=20
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	sched_clock_register(gt_sched_clock_read, 64, gt_target_rate);
@@ -290,18 +288,17 @@ static int gt_clk_rate_change_cb(struct notifier_block =
*nb,
 	switch (event) {
 	case PRE_RATE_CHANGE:
 	{
-		int psv;
-
-		psv =3D DIV_ROUND_CLOSEST(ndata->new_rate,
-					gt_target_rate);
+		unsigned long psv;
=20
-		if (abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
+		psv =3D DIV_ROUND_CLOSEST(ndata->new_rate, gt_target_rate);
+		if (!psv ||
+		    abs(gt_target_rate - (ndata->new_rate / psv)) > MAX_F_ERR)
 			return NOTIFY_BAD;
=20
 		psv--;
=20
 		/* prescaler within legal range? */
-		if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
+		if (!FIELD_FIT(GT_CONTROL_PRESCALER_MASK, psv))
 			return NOTIFY_BAD;
=20
 		/*
@@ -411,7 +408,7 @@ static int __init global_timer_of_register(struct device_=
node *np)
 	err =3D gt_clocksource_init();
 	if (err)
 		goto out_irq;
-=09
+
 	err =3D cpuhp_setup_state(CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 				"clockevents/arm/global_timer:starting",
 				gt_starting_cpu, gt_dying_cpu);
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index 6a878d227a13..489e69169ed4 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -258,9 +258,8 @@ static irqreturn_t mxc_timer_interrupt(int irq, void *dev=
_id)
 {
 	struct clock_event_device *ced =3D dev_id;
 	struct imx_timer *imxtm =3D to_imx_timer(ced);
-	uint32_t tstat;
=20
-	tstat =3D readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
+	readl_relaxed(imxtm->base + imxtm->gpt->reg_tstat);
=20
 	imxtm->gpt->gpt_irq_acknowledge(imxtm);
=20
diff --git a/drivers/clocksource/timer-imx-sysctr.c b/drivers/clocksource/tim=
er-imx-sysctr.c
index 5a7a951c4efc..44525813be1e 100644
--- a/drivers/clocksource/timer-imx-sysctr.c
+++ b/drivers/clocksource/timer-imx-sysctr.c
@@ -4,48 +4,62 @@
=20
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/slab.h>
=20
 #include "timer-of.h"
=20
 #define CMP_OFFSET	0x10000
+#define RD_OFFSET	0x20000
=20
 #define CNTCV_LO	0x8
 #define CNTCV_HI	0xc
 #define CMPCV_LO	(CMP_OFFSET + 0x20)
 #define CMPCV_HI	(CMP_OFFSET + 0x24)
 #define CMPCR		(CMP_OFFSET + 0x2c)
+#define CNTCV_LO_IMX95	(RD_OFFSET + 0x8)
+#define CNTCV_HI_IMX95	(RD_OFFSET + 0xc)
=20
 #define SYS_CTR_EN		0x1
 #define SYS_CTR_IRQ_MASK	0x2
=20
 #define SYS_CTR_CLK_DIV		0x3
=20
-static void __iomem *sys_ctr_base __ro_after_init;
-static u32 cmpcr __ro_after_init;
+struct sysctr_private {
+	u32 cmpcr;
+	u32 lo_off;
+	u32 hi_off;
+};
=20
-static void sysctr_timer_enable(bool enable)
+static void sysctr_timer_enable(struct clock_event_device *evt, bool enable)
 {
-	writel(enable ? cmpcr | SYS_CTR_EN : cmpcr, sys_ctr_base + CMPCR);
+	struct timer_of *to =3D to_timer_of(evt);
+	struct sysctr_private *priv =3D to->private_data;
+	void __iomem *base =3D timer_of_base(to);
+
+	writel(enable ? priv->cmpcr | SYS_CTR_EN : priv->cmpcr, base + CMPCR);
 }
=20
-static void sysctr_irq_acknowledge(void)
+static void sysctr_irq_acknowledge(struct clock_event_device *evt)
 {
 	/*
 	 * clear the enable bit(EN =3D0) will clear
 	 * the status bit(ISTAT =3D 0), then the interrupt
 	 * signal will be negated(acknowledged).
 	 */
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
 }
=20
-static inline u64 sysctr_read_counter(void)
+static inline u64 sysctr_read_counter(struct clock_event_device *evt)
 {
+	struct timer_of *to =3D to_timer_of(evt);
+	struct sysctr_private *priv =3D to->private_data;
+	void __iomem *base =3D timer_of_base(to);
 	u32 cnt_hi, tmp_hi, cnt_lo;
=20
 	do {
-		cnt_hi =3D readl_relaxed(sys_ctr_base + CNTCV_HI);
-		cnt_lo =3D readl_relaxed(sys_ctr_base + CNTCV_LO);
-		tmp_hi =3D readl_relaxed(sys_ctr_base + CNTCV_HI);
+		cnt_hi =3D readl_relaxed(base + priv->hi_off);
+		cnt_lo =3D readl_relaxed(base + priv->lo_off);
+		tmp_hi =3D readl_relaxed(base + priv->hi_off);
 	} while (tmp_hi !=3D cnt_hi);
=20
 	return  ((u64) cnt_hi << 32) | cnt_lo;
@@ -54,22 +68,24 @@ static inline u64 sysctr_read_counter(void)
 static int sysctr_set_next_event(unsigned long delta,
 				 struct clock_event_device *evt)
 {
+	struct timer_of *to =3D to_timer_of(evt);
+	void __iomem *base =3D timer_of_base(to);
 	u32 cmp_hi, cmp_lo;
 	u64 next;
=20
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
=20
-	next =3D sysctr_read_counter();
+	next =3D sysctr_read_counter(evt);
=20
 	next +=3D delta;
=20
 	cmp_hi =3D (next >> 32) & 0x00fffff;
 	cmp_lo =3D next & 0xffffffff;
=20
-	writel_relaxed(cmp_hi, sys_ctr_base + CMPCV_HI);
-	writel_relaxed(cmp_lo, sys_ctr_base + CMPCV_LO);
+	writel_relaxed(cmp_hi, base + CMPCV_HI);
+	writel_relaxed(cmp_lo, base + CMPCV_LO);
=20
-	sysctr_timer_enable(true);
+	sysctr_timer_enable(evt, true);
=20
 	return 0;
 }
@@ -81,7 +97,7 @@ static int sysctr_set_state_oneshot(struct clock_event_devi=
ce *evt)
=20
 static int sysctr_set_state_shutdown(struct clock_event_device *evt)
 {
-	sysctr_timer_enable(false);
+	sysctr_timer_enable(evt, false);
=20
 	return 0;
 }
@@ -90,7 +106,7 @@ static irqreturn_t sysctr_timer_interrupt(int irq, void *d=
ev_id)
 {
 	struct clock_event_device *evt =3D dev_id;
=20
-	sysctr_irq_acknowledge();
+	sysctr_irq_acknowledge(evt);
=20
 	evt->event_handler(evt);
=20
@@ -117,34 +133,75 @@ static struct timer_of to_sysctr =3D {
 	},
 };
=20
-static void __init sysctr_clockevent_init(void)
+static int __init __sysctr_timer_init(struct device_node *np)
 {
+	struct sysctr_private *priv;
+	void __iomem *base;
+	int ret;
+
+	priv =3D kzalloc(sizeof(struct sysctr_private), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret =3D timer_of_init(np, &to_sysctr);
+	if (ret) {
+		kfree(priv);
+		return ret;
+	}
+
+	if (!of_property_read_bool(np, "nxp,no-divider")) {
+		/* system counter clock is divided by 3 internally */
+		to_sysctr.of_clk.rate /=3D SYS_CTR_CLK_DIV;
+	}
+
 	to_sysctr.clkevt.cpumask =3D cpu_possible_mask;
+	to_sysctr.private_data =3D priv;
+
+	base =3D timer_of_base(&to_sysctr);
+	priv->cmpcr =3D readl(base + CMPCR) & ~SYS_CTR_EN;
+
+	return 0;
+}
+
+static int __init sysctr_timer_init(struct device_node *np)
+{
+	struct sysctr_private *priv;
+	int ret;
+
+	ret =3D __sysctr_timer_init(np);
+	if (ret)
+		return ret;
+
+	priv =3D to_sysctr.private_data;
+	priv->lo_off =3D CNTCV_LO;
+	priv->hi_off =3D CNTCV_HI;
=20
 	clockevents_config_and_register(&to_sysctr.clkevt,
 					timer_of_rate(&to_sysctr),
 					0xff, 0x7fffffff);
+
+	return 0;
 }
=20
-static int __init sysctr_timer_init(struct device_node *np)
+static int __init sysctr_timer_imx95_init(struct device_node *np)
 {
-	int ret =3D 0;
+	struct sysctr_private *priv;
+	int ret;
=20
-	ret =3D timer_of_init(np, &to_sysctr);
+	ret =3D __sysctr_timer_init(np);
 	if (ret)
 		return ret;
=20
-	if (!of_property_read_bool(np, "nxp,no-divider")) {
-		/* system counter clock is divided by 3 internally */
-		to_sysctr.of_clk.rate /=3D SYS_CTR_CLK_DIV;
-	}
-
-	sys_ctr_base =3D timer_of_base(&to_sysctr);
-	cmpcr =3D readl(sys_ctr_base + CMPCR);
-	cmpcr &=3D ~SYS_CTR_EN;
+	priv =3D to_sysctr.private_data;
+	priv->lo_off =3D CNTCV_LO_IMX95;
+	priv->hi_off =3D CNTCV_HI_IMX95;
=20
-	sysctr_clockevent_init();
+	clockevents_config_and_register(&to_sysctr.clkevt,
+					timer_of_rate(&to_sysctr),
+					0xff, 0x7fffffff);
=20
 	return 0;
 }
+
 TIMER_OF_DECLARE(sysctr_timer, "nxp,sysctr-timer", sysctr_timer_init);
+TIMER_OF_DECLARE(sysctr_timer_imx95, "nxp,imx95-sysctr-timer", sysctr_timer_=
imx95_init);
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-ri=
scv.c
index e66dcbd66566..79bb9a98baa7 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -108,6 +108,9 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
 {
 	struct clock_event_device *ce =3D per_cpu_ptr(&riscv_clock_event, cpu);
=20
+	/* Clear timer interrupt */
+	riscv_clock_event_stop();
+
 	ce->cpumask =3D cpumask_of(cpu);
 	ce->irq =3D riscv_clock_event_irq;
 	if (riscv_timer_cannot_wake_cpu)
diff --git a/drivers/clocksource/timer-stm32.c b/drivers/clocksource/timer-st=
m32.c
index c9a753f96ba1..0a4ea3288bfb 100644
--- a/drivers/clocksource/timer-stm32.c
+++ b/drivers/clocksource/timer-stm32.c
@@ -73,7 +73,7 @@ static void stm32_timer_of_bits_set(struct timer_of *to, in=
t bits)
  * Accessor helper to get the number of bits in the timer-of private
  * structure.
  *
- * Returns an integer corresponding to the number of bits.
+ * Returns: an integer corresponding to the number of bits.
  */
 static int stm32_timer_of_bits_get(struct timer_of *to)
 {
@@ -177,7 +177,7 @@ static irqreturn_t stm32_clock_event_handler(int irq, voi=
d *dev_id)
 }
=20
 /**
- * stm32_timer_width - Sort out the timer width (32/16)
+ * stm32_timer_set_width - Sort out the timer width (32/16)
  * @to: a pointer to a timer-of structure
  *
  * Write the 32-bit max value and read/return the result. If the timer
diff --git a/drivers/clocksource/timer-ti-32k.c b/drivers/clocksource/timer-t=
i-32k.c
index 59b0be482f32..a86529a70737 100644
--- a/drivers/clocksource/timer-ti-32k.c
+++ b/drivers/clocksource/timer-ti-32k.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * timer-ti-32k.c - OMAP2 32k Timer Support
  *
  * Copyright (C) 2009 Nokia Corporation


