Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C15E7DAEA0
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjJ2Vh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjJ2Vdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:33:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A4DBC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:33:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698615209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZjYmZsp6PEIl75wFccILYtAuX8deMPF8nfIqV+skhKg=;
        b=n7G9m7nog66uoykEntEaC6hDNmirqYkG8MOechmbdYcYHbjsZs0xm+1FqF1ckBvp9N2Ivr
        Vhb42YXtIEXZfugxJLUTmb82cfoGWyGNMZwpp3KAjikONr90qdilNdI8NSpKB0yVS0dw90
        kt3CNNS9jzDyEfhxFwyURJRKqMeRniQa4xuI+xGpnSoCqDl0xw/s0TRbEqDh3qRuJ0gECW
        ugdkFfTSYNkSOoP3rlg8sw7BtyPaIzlXsItzWcc6zzjr/BBC794dU/qKN3Wmf2lYeGAWSx
        kh6+1oU9v6KUU7TPHRYnx/RKw2i0qM4IOWvSVX1aYv3Q4Uj+qu9jI250IhnY3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698615209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ZjYmZsp6PEIl75wFccILYtAuX8deMPF8nfIqV+skhKg=;
        b=Mm645zdaQgJJQgBwZMYcSDQ5zPlTn5MTBiLaXgnMjux+r5Ld9HASWZoE5DJ6vt9i1asuGY
        TMDCQGv5YgE77WDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for v6.7-rc1
References: <169861500709.181063.7816209662289132093.tglx@xen13>
Message-ID: <169861501181.181063.11456638002426777407.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 22:33:29 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2023=
-10-29-v2

up to:  f4febfdbb45a: Merge tag 'timers-v6.7-rc1' of https://git.linaro.org/p=
eople/daniel.lezcano/linux into timers/core

Update for time, timekeeping and timers:

 Core:

   - Avoid superfluous deactivation of the tick in the low resolution tick
     NOHZ interrupt handler as the deactivation is handled already in the
     idle loop and on interrupt exit.

   - Update stale comments in the tick NOHZ code and rename the tick
     handler functions to be self-explanatory.

   - Remove an unused function in the tick NOHZ code, which was forgotten
     when the last user went away.

   - Handle RTC alarms which exceed the maximum alarm time of the
     underlying RTC hardware gracefully.

     Setting RTC alarms which exceed the maximum alarm time of the RTC
     hardware failed so far and caused suspend operations to abort.

     Cure this by limiting the alarm to the maximum alarm time of the RTC
     hardware, which is provided by the driver. This causes early resume
     wakeups, but that's way better than not suspending at all.

 Drivers:

   - Add a proper clocksource/event driver for the ancient Cirrus Logic
     EP93xx SoC family, which is one of the last non device-tree holdouts
     in arch/arm.

   - The usual boring device tree bindings updates and small fixes and
     enhancements all over the place.

Thanks,

	tglx

------------------>
Biju Das (3):
      dt-bindings: timer: renesas,rz-mtu3: Fix overflow/underflow interrupt n=
ames
      dt-bindings: timer: renesas,rz-mtu3: Improve documentation
      dt-bindings: timer: renesas,rz-mtu3: Document RZ/{G2UL,Five} SoCs

Frederic Weisbecker (3):
      tick/nohz: Rename the tick handlers to more self-explanatory names
      tick/nohz: Update obsolete comments
      tick/nohz: Don't shutdown the lowres tick from itself

Guenter Roeck (2):
      rtc: Add API function to return alarm time bound by hardware limit
      alarmtimer: Use maximum alarm time for suspend

Ingo Molnar (1):
      tick/nohz: Update comments some more

Ivaylo Dimitrov (1):
      drivers/clocksource/timer-ti-dm: Don't call clk_get_rate() in stop func=
tion

Jacky Bai (1):
      clocksource/drivers/timer-imx-gpt: Fix potential memory leak

Nikita Shubin (2):
      dt-bindings: timers: Add Cirrus EP93xx
      clocksource: ep93xx: Add driver for Cirrus Logic EP93xx

Ronald Wahl (1):
      clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware

Sunil V L (1):
      clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu

Xueshi Hu (1):
      tick/nohz: Remove unused tick_nohz_idle_stop_tick_protected()

Yang Li (1):
      clocksource/drivers/sun5i: Remove surplus dev_err() when using platform=
_get_irq()


 .../bindings/timer/cirrus,ep9301-timer.yaml        |  49 +++++
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml |  67 ++++---
 drivers/clocksource/Kconfig                        |  11 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-atmel-tcb.c              |   1 +
 drivers/clocksource/timer-ep93xx.c                 | 190 ++++++++++++++++++
 drivers/clocksource/timer-imx-gpt.c                |  18 +-
 drivers/clocksource/timer-riscv.c                  |   4 +
 drivers/clocksource/timer-sun5i.c                  |   4 +-
 drivers/clocksource/timer-ti-dm.c                  |  36 +++-
 include/linux/rtc.h                                |  17 ++
 include/linux/tick.h                               |  10 -
 kernel/time/alarmtimer.c                           |  11 +
 kernel/time/tick-sched.c                           | 222 ++++++++++++-------=
--
 14 files changed, 484 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/cirrus,ep9301-tim=
er.yaml
 create mode 100644 drivers/clocksource/timer-ep93xx.c

diff --git a/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml=
 b/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml
new file mode 100644
index 000000000000..e463e11e259d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/cirrus,ep9301-timer.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/cirrus,ep9301-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cirrus Logic EP93xx timer
+
+maintainers:
+  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
+  - Nikita Shubin <nikita.shubin@maquefel.me>
+
+properties:
+  compatible:
+    oneOf:
+      - const: cirrus,ep9301-timer
+      - items:
+          - enum:
+              - cirrus,ep9302-timer
+              - cirrus,ep9307-timer
+              - cirrus,ep9312-timer
+              - cirrus,ep9315-timer
+          - const: cirrus,ep9301-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  resets:
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
+    timer@80810000 {
+      compatible =3D "cirrus,ep9301-timer";
+      reg =3D <0x80810000 0x100>;
+      interrupt-parent =3D <&vic1>;
+      interrupts =3D <19>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/D=
ocumentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index bffdab0b0185..3931054b42fb 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -11,8 +11,8 @@ maintainers:
=20
 description: |
   This hardware block consists of eight 16-bit timer channels and one
-  32- bit timer channel. It supports the following specifications:
-    - Pulse input/output: 28 lines max.
+  32-bit timer channel. It supports the following specifications:
+    - Pulse input/output: 28 lines max
     - Pulse input 3 lines
     - Count clock 11 clocks for each channel (14 clocks for MTU0, 12 clocks
       for MTU2, and 10 clocks for MTU5, four clocks for MTU1-MTU2 combination
@@ -23,11 +23,11 @@ description: |
         - Input capture function (noise filter setting available)
         - Counter-clearing operation
         - Simultaneous writing to multiple timer counters (TCNT)
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous clearing on compare match or input capture
-          (excluding MTU8).
+          (excluding MTU8)
         - Simultaneous input and output to registers in synchronization with
-          counter operations           (excluding MTU8).
+          counter operations (excluding MTU8)
         - Up to 12-phase PWM output in combination with synchronous operation
           (excluding MTU8)
     - [MTU0 MTU3, MTU4, MTU6, MTU7, and MTU8]
@@ -40,26 +40,26 @@ description: |
     - [MTU3, MTU4, MTU6, and MTU7]
         - Through interlocked operation of MTU3/4 and MTU6/7, the positive a=
nd
           negative signals in six phases (12 phases in total) can be output =
in
-          complementary PWM and reset-synchronized PWM operation.
+          complementary PWM and reset-synchronized PWM operation
         - In complementary PWM mode, values can be transferred from buffer
           registers to temporary registers at crests and troughs of the time=
r-
           counter values or when the buffer registers (TGRD registers in MTU4
-          and MTU7) are written to.
-        - Double-buffering selectable in complementary PWM mode.
+          and MTU7) are written to
+        - Double-buffering selectable in complementary PWM mode
     - [MTU3 and MTU4]
         - Through interlocking with MTU0, a mode for driving AC synchronous
           motors (brushless DC motors) by using complementary PWM output and
           reset-synchronized PWM output is settable and allows the selection
-          of two types of waveform output (chopping or level).
+          of two types of waveform output (chopping or level)
     - [MTU5]
-        - Capable of operation as a dead-time compensation counter.
+        - Capable of operation as a dead-time compensation counter
     - [MTU0/MTU5, MTU1, MTU2, and MTU8]
         - 32-bit phase counting mode specifiable by combining MTU1 and MTU2 =
and
-          through interlocked operation with MTU0/MTU5 and MTU8.
+          through interlocked operation with MTU0/MTU5 and MTU8
     - Interrupt-skipping function
         - In complementary PWM mode, interrupts on crests and troughs of cou=
nter
           values and triggers to start conversion by the A/D converter can be
-          skipped.
+          skipped
     - Interrupt sources: 43 sources.
     - Buffer operation:
         - Automatic transfer of register data (transfer from the buffer
@@ -68,9 +68,9 @@ description: |
         - A/D converter start triggers can be generated
         - A/D converter start request delaying function enables A/D converter
           to be started with any desired timing and to be synchronized with
-          PWM output.
+          PWM output
     - Low power consumption function
-        - The MTU3a can be placed in the module-stop state.
+        - The MTU3a can be placed in the module-stop state
=20
     There are two phase counting modes. 16-bit phase counting mode in which
     MTU1 and MTU2 operate independently, and cascade connection 32-bit phase
@@ -109,6 +109,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-mtu3  # RZ/{G2UL,Five}
           - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
           - renesas,r9a07g054-mtu3  # RZ/V2L
       - const: renesas,rz-mtu3
@@ -169,27 +170,27 @@ properties:
       - const: tgib0
       - const: tgic0
       - const: tgid0
-      - const: tgiv0
+      - const: tciv0
       - const: tgie0
       - const: tgif0
       - const: tgia1
       - const: tgib1
-      - const: tgiv1
-      - const: tgiu1
+      - const: tciv1
+      - const: tciu1
       - const: tgia2
       - const: tgib2
-      - const: tgiv2
-      - const: tgiu2
+      - const: tciv2
+      - const: tciu2
       - const: tgia3
       - const: tgib3
       - const: tgic3
       - const: tgid3
-      - const: tgiv3
+      - const: tciv3
       - const: tgia4
       - const: tgib4
       - const: tgic4
       - const: tgid4
-      - const: tgiv4
+      - const: tciv4
       - const: tgiu5
       - const: tgiv5
       - const: tgiw5
@@ -197,18 +198,18 @@ properties:
       - const: tgib6
       - const: tgic6
       - const: tgid6
-      - const: tgiv6
+      - const: tciv6
       - const: tgia7
       - const: tgib7
       - const: tgic7
       - const: tgid7
-      - const: tgiv7
+      - const: tciv7
       - const: tgia8
       - const: tgib8
       - const: tgic8
       - const: tgid8
-      - const: tgiv8
-      - const: tgiu8
+      - const: tciv8
+      - const: tciu8
=20
   clocks:
     maxItems: 1
@@ -285,16 +286,16 @@ examples:
                    <GIC_SPI 211 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 212 IRQ_TYPE_EDGE_RISING>,
                    <GIC_SPI 213 IRQ_TYPE_EDGE_RISING>;
-      interrupt-names =3D "tgia0", "tgib0", "tgic0", "tgid0", "tgiv0", "tgie=
0",
+      interrupt-names =3D "tgia0", "tgib0", "tgic0", "tgid0", "tciv0", "tgie=
0",
                         "tgif0",
-                        "tgia1", "tgib1", "tgiv1", "tgiu1",
-                        "tgia2", "tgib2", "tgiv2", "tgiu2",
-                        "tgia3", "tgib3", "tgic3", "tgid3", "tgiv3",
-                        "tgia4", "tgib4", "tgic4", "tgid4", "tgiv4",
+                        "tgia1", "tgib1", "tciv1", "tciu1",
+                        "tgia2", "tgib2", "tciv2", "tciu2",
+                        "tgia3", "tgib3", "tgic3", "tgid3", "tciv3",
+                        "tgia4", "tgib4", "tgic4", "tgid4", "tciv4",
                         "tgiu5", "tgiv5", "tgiw5",
-                        "tgia6", "tgib6", "tgic6", "tgid6", "tgiv6",
-                        "tgia7", "tgib7", "tgic7", "tgid7", "tgiv7",
-                        "tgia8", "tgib8", "tgic8", "tgid8", "tgiv8", "tgiu8";
+                        "tgia6", "tgib6", "tgic6", "tgid6", "tciv6",
+                        "tgia7", "tgib7", "tgic7", "tgid7", "tciv7",
+                        "tgia8", "tgib8", "tgic8", "tgid8", "tciv8", "tciu8";
       clocks =3D <&cpg CPG_MOD R9A07G044_MTU_X_MCK_MTU3>;
       power-domains =3D <&cpg>;
       resets =3D <&cpg R9A07G044_MTU_X_PRESET_MTU3>;
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 0ba0dc4ecf06..34faa0320ece 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -732,4 +732,15 @@ config GOLDFISH_TIMER
 	help
 	  Support for the timer/counter of goldfish-rtc
=20
+config EP93XX_TIMER
+	bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
+	depends on ARCH_EP93XX
+	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	select TIMER_OF
+	help
+	  Enables support for the Cirrus Logic timer block
+	  EP93XX.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 368c3461dab8..4bb856e4df55 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_MSC313E_TIMER)		+=3D timer-msc313e.o
 obj-$(CONFIG_GOLDFISH_TIMER)		+=3D timer-goldfish.o
 obj-$(CONFIG_GXP_TIMER)			+=3D timer-gxp.o
 obj-$(CONFIG_CLKSRC_LOONGSON1_PWM)	+=3D timer-loongson1-pwm.o
+obj-$(CONFIG_EP93XX_TIMER)		+=3D timer-ep93xx.o
diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/time=
r-atmel-tcb.c
index 27af17c99590..2a90c92a9182 100644
--- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -315,6 +315,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc *t=
c, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
diff --git a/drivers/clocksource/timer-ep93xx.c b/drivers/clocksource/timer-e=
p93xx.c
new file mode 100644
index 000000000000..bc0ca6e12334
--- /dev/null
+++ b/drivers/clocksource/timer-ep93xx.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cirrus Logic EP93xx timer driver.
+ * Copyright (C) 2021 Nikita Shubin <nikita.shubin@maquefel.me>
+ *
+ * Based on a rewrite of arch/arm/mach-ep93xx/timer.c:
+ */
+
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/sched_clock.h>
+
+#include <asm/mach/time.h>
+
+/*************************************************************************
+ * Timer handling for EP93xx
+ *************************************************************************
+ * The ep93xx has four internal timers.  Timers 1, 2 (both 16 bit) and
+ * 3 (32 bit) count down at 508 kHz, are self-reloading, and can generate
+ * an interrupt on underflow.  Timer 4 (40 bit) counts down at 983.04 kHz,
+ * is free-running, and can't generate interrupts.
+ *
+ * The 508 kHz timers are ideal for use for the timer interrupt, as the
+ * most common values of HZ divide 508 kHz nicely.  We pick the 32 bit
+ * timer (timer 3) to get as long sleep intervals as possible when using
+ * CONFIG_NO_HZ.
+ *
+ * The higher clock rate of timer 4 makes it a better choice than the
+ * other timers for use as clock source and for sched_clock(), providing
+ * a stable 40 bit time base.
+ *************************************************************************
+ */
+
+#define EP93XX_TIMER1_LOAD		0x00
+#define EP93XX_TIMER1_VALUE		0x04
+#define EP93XX_TIMER1_CONTROL		0x08
+#define EP93XX_TIMER123_CONTROL_ENABLE	BIT(7)
+#define EP93XX_TIMER123_CONTROL_MODE	BIT(6)
+#define EP93XX_TIMER123_CONTROL_CLKSEL	BIT(3)
+#define EP93XX_TIMER1_CLEAR		0x0c
+#define EP93XX_TIMER2_LOAD		0x20
+#define EP93XX_TIMER2_VALUE		0x24
+#define EP93XX_TIMER2_CONTROL		0x28
+#define EP93XX_TIMER2_CLEAR		0x2c
+/*
+ * This read-only register contains the low word of the time stamp debug tim=
er
+ * ( Timer4). When this register is read, the high byte of the Timer4 counte=
r is
+ * saved in the Timer4ValueHigh register.
+ */
+#define EP93XX_TIMER4_VALUE_LOW		0x60
+#define EP93XX_TIMER4_VALUE_HIGH	0x64
+#define EP93XX_TIMER4_VALUE_HIGH_ENABLE	BIT(8)
+#define EP93XX_TIMER3_LOAD		0x80
+#define EP93XX_TIMER3_VALUE		0x84
+#define EP93XX_TIMER3_CONTROL		0x88
+#define EP93XX_TIMER3_CLEAR		0x8c
+
+#define EP93XX_TIMER123_RATE		508469
+#define EP93XX_TIMER4_RATE		983040
+
+struct ep93xx_tcu {
+	void __iomem *base;
+};
+
+static struct ep93xx_tcu *ep93xx_tcu;
+
+static u64 ep93xx_clocksource_read(struct clocksource *c)
+{
+	struct ep93xx_tcu *tcu =3D ep93xx_tcu;
+
+	return lo_hi_readq(tcu->base + EP93XX_TIMER4_VALUE_LOW) & GENMASK_ULL(39, 0=
);
+}
+
+static u64 notrace ep93xx_read_sched_clock(void)
+{
+	return ep93xx_clocksource_read(NULL);
+}
+
+static int ep93xx_clkevt_set_next_event(unsigned long next,
+					struct clock_event_device *evt)
+{
+	struct ep93xx_tcu *tcu =3D ep93xx_tcu;
+	/* Default mode: periodic, off, 508 kHz */
+	u32 tmode =3D EP93XX_TIMER123_CONTROL_MODE |
+	EP93XX_TIMER123_CONTROL_CLKSEL;
+
+	/* Clear timer */
+	writel(tmode, tcu->base + EP93XX_TIMER3_CONTROL);
+
+	/* Set next event */
+	writel(next, tcu->base + EP93XX_TIMER3_LOAD);
+	writel(tmode | EP93XX_TIMER123_CONTROL_ENABLE,
+	       tcu->base + EP93XX_TIMER3_CONTROL);
+	return 0;
+}
+
+static int ep93xx_clkevt_shutdown(struct clock_event_device *evt)
+{
+	struct ep93xx_tcu *tcu =3D ep93xx_tcu;
+	/* Disable timer */
+	writel(0, tcu->base + EP93XX_TIMER3_CONTROL);
+
+	return 0;
+}
+
+static struct clock_event_device ep93xx_clockevent =3D {
+	.name			=3D "timer1",
+	.features		=3D CLOCK_EVT_FEAT_ONESHOT,
+	.set_state_shutdown	=3D ep93xx_clkevt_shutdown,
+	.set_state_oneshot	=3D ep93xx_clkevt_shutdown,
+	.tick_resume		=3D ep93xx_clkevt_shutdown,
+	.set_next_event		=3D ep93xx_clkevt_set_next_event,
+	.rating			=3D 300,
+};
+
+static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
+{
+	struct ep93xx_tcu *tcu =3D ep93xx_tcu;
+	struct clock_event_device *evt =3D dev_id;
+
+	/* Writing any value clears the timer interrupt */
+	writel(1, tcu->base + EP93XX_TIMER3_CLEAR);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int __init ep93xx_timer_of_init(struct device_node *np)
+{
+	int irq;
+	unsigned long flags =3D IRQF_TIMER | IRQF_IRQPOLL;
+	struct ep93xx_tcu *tcu;
+	int ret;
+
+	tcu =3D kzalloc(sizeof(*tcu), GFP_KERNEL);
+	if (!tcu)
+		return -ENOMEM;
+
+	tcu->base =3D of_iomap(np, 0);
+	if (!tcu->base) {
+		pr_err("Can't remap registers\n");
+		ret =3D -ENXIO;
+		goto out_free;
+	}
+
+	ep93xx_tcu =3D tcu;
+
+	irq =3D irq_of_parse_and_map(np, 0);
+	if (irq =3D=3D 0)
+		irq =3D -EINVAL;
+	if (irq < 0) {
+		pr_err("EP93XX Timer Can't parse IRQ %d", irq);
+		goto out_free;
+	}
+
+	/* Enable and register clocksource and sched_clock on timer 4 */
+	writel(EP93XX_TIMER4_VALUE_HIGH_ENABLE,
+	       tcu->base + EP93XX_TIMER4_VALUE_HIGH);
+	clocksource_mmio_init(NULL, "timer4",
+				EP93XX_TIMER4_RATE, 200, 40,
+				ep93xx_clocksource_read);
+	sched_clock_register(ep93xx_read_sched_clock, 40,
+			     EP93XX_TIMER4_RATE);
+
+	/* Set up clockevent on timer 3 */
+	if (request_irq(irq, ep93xx_timer_interrupt, flags, "ep93xx timer",
+		&ep93xx_clockevent))
+		pr_err("Failed to request irq %d (ep93xx timer)\n", irq);
+
+	clockevents_config_and_register(&ep93xx_clockevent,
+				EP93XX_TIMER123_RATE,
+				1,
+				UINT_MAX);
+
+	return 0;
+
+out_free:
+	kfree(tcu);
+	return ret;
+}
+TIMER_OF_DECLARE(ep93xx_timer, "cirrus,ep9301-timer", ep93xx_timer_of_init);
diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-=
imx-gpt.c
index 28ab4f1a7c71..6a878d227a13 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -434,12 +434,16 @@ static int __init mxc_timer_init_dt(struct device_node =
*np,  enum imx_gpt_type t
 		return -ENOMEM;
=20
 	imxtm->base =3D of_iomap(np, 0);
-	if (!imxtm->base)
-		return -ENXIO;
+	if (!imxtm->base) {
+		ret =3D -ENXIO;
+		goto err_kfree;
+	}
=20
 	imxtm->irq =3D irq_of_parse_and_map(np, 0);
-	if (imxtm->irq <=3D 0)
-		return -EINVAL;
+	if (imxtm->irq <=3D 0) {
+		ret =3D -EINVAL;
+		goto err_kfree;
+	}
=20
 	imxtm->clk_ipg =3D of_clk_get_by_name(np, "ipg");
=20
@@ -452,11 +456,15 @@ static int __init mxc_timer_init_dt(struct device_node =
*np,  enum imx_gpt_type t
=20
 	ret =3D _mxc_timer_init(imxtm);
 	if (ret)
-		return ret;
+		goto err_kfree;
=20
 	initialized =3D 1;
=20
 	return 0;
+
+err_kfree:
+	kfree(imxtm);
+	return ret;
 }
=20
 static int __init imx1_timer_init_dt(struct device_node *np)
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-ri=
scv.c
index da3071b387eb..50198657230e 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -212,6 +212,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_=
dt);
 #ifdef CONFIG_ACPI
 static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
 {
+	struct acpi_table_rhct *rhct =3D (struct acpi_table_rhct *)table;
+
+	riscv_timer_cannot_wake_cpu =3D rhct->flags & ACPI_RHCT_TIMER_CANNOT_WAKEUP=
_CPU;
+
 	return riscv_timer_init_common();
 }
=20
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-su=
n5i.c
index 69fee3540d37..0d229a9058da 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -256,10 +256,8 @@ static int sun5i_timer_probe(struct platform_device *pde=
v)
 	}
=20
 	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Can't get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
=20
 	clk =3D devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti=
-dm.c
index 09ab29cb7f64..5f60f6bd3386 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -140,6 +140,8 @@ struct dmtimer {
 	struct platform_device *pdev;
 	struct list_head node;
 	struct notifier_block nb;
+	struct notifier_block fclk_nb;
+	unsigned long fclk_rate;
 };
=20
 static u32 omap_reserved_systimers;
@@ -253,8 +255,7 @@ static inline void __omap_dm_timer_enable_posted(struct d=
mtimer *timer)
 	timer->posted =3D OMAP_TIMER_POSTED;
 }
=20
-static inline void __omap_dm_timer_stop(struct dmtimer *timer,
-					unsigned long rate)
+static inline void __omap_dm_timer_stop(struct dmtimer *timer)
 {
 	u32 l;
=20
@@ -269,7 +270,7 @@ static inline void __omap_dm_timer_stop(struct dmtimer *t=
imer,
 		 * Wait for functional clock period x 3.5 to make sure that
 		 * timer is stopped
 		 */
-		udelay(3500000 / rate + 1);
+		udelay(3500000 / timer->fclk_rate + 1);
 #endif
 	}
=20
@@ -348,6 +349,21 @@ static int omap_timer_context_notifier(struct notifier_b=
lock *nb,
 	return NOTIFY_OK;
 }
=20
+static int omap_timer_fclk_notifier(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct clk_notifier_data *clk_data =3D data;
+	struct dmtimer *timer =3D container_of(nb, struct dmtimer, fclk_nb);
+
+	switch (event) {
+	case POST_RATE_CHANGE:
+		timer->fclk_rate =3D clk_data->new_rate;
+		return NOTIFY_OK;
+	default:
+		return NOTIFY_DONE;
+	}
+}
+
 static int omap_dm_timer_reset(struct dmtimer *timer)
 {
 	u32 l, timeout =3D 100000;
@@ -754,7 +770,6 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cooki=
e)
 {
 	struct dmtimer *timer;
 	struct device *dev;
-	unsigned long rate =3D 0;
=20
 	timer =3D to_dmtimer(cookie);
 	if (unlikely(!timer))
@@ -762,10 +777,7 @@ static int omap_dm_timer_stop(struct omap_dm_timer *cook=
ie)
=20
 	dev =3D &timer->pdev->dev;
=20
-	if (!timer->omap1)
-		rate =3D clk_get_rate(timer->fclk);
-
-	__omap_dm_timer_stop(timer, rate);
+	__omap_dm_timer_stop(timer);
=20
 	pm_runtime_put_sync(dev);
=20
@@ -1124,6 +1136,14 @@ static int omap_dm_timer_probe(struct platform_device =
*pdev)
 		timer->fclk =3D devm_clk_get(dev, "fck");
 		if (IS_ERR(timer->fclk))
 			return PTR_ERR(timer->fclk);
+
+		timer->fclk_nb.notifier_call =3D omap_timer_fclk_notifier;
+		ret =3D devm_clk_notifier_register(dev, timer->fclk,
+						 &timer->fclk_nb);
+		if (ret)
+			return ret;
+
+		timer->fclk_rate =3D clk_get_rate(timer->fclk);
 	} else {
 		timer->fclk =3D ERR_PTR(-ENODEV);
 	}
diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 4c0bcbeb1f00..5f8e438a0312 100644
--- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -225,6 +225,23 @@ static inline bool is_leap_year(unsigned int year)
 	return (!(year % 4) && (year % 100)) || !(year % 400);
 }
=20
+/**
+ * rtc_bound_alarmtime() - Return alarm time bound by rtc limit
+ * @rtc: Pointer to rtc device structure
+ * @requested: Requested alarm timeout
+ *
+ * Return: Alarm timeout bound by maximum alarm time supported by rtc.
+ */
+static inline ktime_t rtc_bound_alarmtime(struct rtc_device *rtc,
+					  ktime_t requested)
+{
+	if (rtc->alarm_offset_max &&
+	    rtc->alarm_offset_max * MSEC_PER_SEC < ktime_to_ms(requested))
+		return ms_to_ktime(rtc->alarm_offset_max * MSEC_PER_SEC);
+
+	return requested;
+}
+
 #define devm_rtc_register_device(device) \
 	__devm_rtc_register_device(THIS_MODULE, device)
=20
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..716d17f31c45 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -140,14 +140,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -170,8 +162,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t =
*delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
=20
 #ifdef CONFIG_NO_HZ_FULL
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 8d9f13d847f0..4657cb8e8b1f 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -290,6 +290,17 @@ static int alarmtimer_suspend(struct device *dev)
 	rtc_timer_cancel(rtc, &rtctimer);
 	rtc_read_time(rtc, &tm);
 	now =3D rtc_tm_to_ktime(tm);
+
+	/*
+	 * If the RTC alarm timer only supports a limited time offset, set the
+	 * alarm time to the maximum supported value.
+	 * The system may wake up earlier (possibly much earlier) than expected
+	 * when the alarmtimer runs. This is the best the kernel can do if
+	 * the alarmtimer exceeds the time that the rtc device can be programmed
+	 * for.
+	 */
+	min =3D rtc_bound_alarmtime(rtc, min);
+
 	now =3D ktime_add(now, min);
=20
 	/* Set alarm, if in the past reject suspend briefly to handle */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 87015e9deacc..be77b021e5d6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -4,7 +4,7 @@
  *  Copyright(C) 2005-2007, Red Hat, Inc., Ingo Molnar
  *  Copyright(C) 2006-2007  Timesys Corp., Thomas Gleixner
  *
- *  No idle tick implementation for low and high resolution timers
+ *  NOHZ implementation for low and high resolution timers
  *
  *  Started by: Thomas Gleixner and Ingo Molnar
  */
@@ -45,7 +45,7 @@ struct tick_sched *tick_get_tick_sched(int cpu)
=20
 #if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
- * The time, when the last jiffy update happened. Write access must hold
+ * The time when the last jiffy update happened. Write access must hold
  * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
  * consistent view of jiffies and last_jiffies_update.
  */
@@ -60,13 +60,13 @@ static void tick_do_update_jiffies64(ktime_t now)
 	ktime_t delta, nextp;
=20
 	/*
-	 * 64bit can do a quick check without holding jiffies lock and
+	 * 64-bit can do a quick check without holding the jiffies lock and
 	 * without looking at the sequence count. The smp_load_acquire()
 	 * pairs with the update done later in this function.
 	 *
-	 * 32bit cannot do that because the store of tick_next_period
-	 * consists of two 32bit stores and the first store could move it
-	 * to a random point in the future.
+	 * 32-bit cannot do that because the store of 'tick_next_period'
+	 * consists of two 32-bit stores, and the first store could be
+	 * moved by the CPU to a random point in the future.
 	 */
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
@@ -75,7 +75,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 		unsigned int seq;
=20
 		/*
-		 * Avoid contention on jiffies_lock and protect the quick
+		 * Avoid contention on 'jiffies_lock' and protect the quick
 		 * check with the sequence count.
 		 */
 		do {
@@ -90,7 +90,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 	/* Quick check failed, i.e. update is required. */
 	raw_spin_lock(&jiffies_lock);
 	/*
-	 * Reevaluate with the lock held. Another CPU might have done the
+	 * Re-evaluate with the lock held. Another CPU might have done the
 	 * update already.
 	 */
 	if (ktime_before(now, tick_next_period)) {
@@ -114,25 +114,23 @@ static void tick_do_update_jiffies64(ktime_t now)
 						   TICK_NSEC);
 	}
=20
-	/* Advance jiffies to complete the jiffies_seq protected job */
+	/* Advance jiffies to complete the 'jiffies_seq' protected job */
 	jiffies_64 +=3D ticks;
=20
-	/*
-	 * Keep the tick_next_period variable up to date.
-	 */
+	/* Keep the tick_next_period variable up to date */
 	nextp =3D ktime_add_ns(last_jiffies_update, TICK_NSEC);
=20
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		/*
 		 * Pairs with smp_load_acquire() in the lockless quick
-		 * check above and ensures that the update to jiffies_64 is
-		 * not reordered vs. the store to tick_next_period, neither
+		 * check above, and ensures that the update to 'jiffies_64' is
+		 * not reordered vs. the store to 'tick_next_period', neither
 		 * by the compiler nor by the CPU.
 		 */
 		smp_store_release(&tick_next_period, nextp);
 	} else {
 		/*
-		 * A plain store is good enough on 32bit as the quick check
+		 * A plain store is good enough on 32-bit, as the quick check
 		 * above is protected by the sequence count.
 		 */
 		tick_next_period =3D nextp;
@@ -140,7 +138,7 @@ static void tick_do_update_jiffies64(ktime_t now)
=20
 	/*
 	 * Release the sequence count. calc_global_load() below is not
-	 * protected by it, but jiffies_lock needs to be held to prevent
+	 * protected by it, but 'jiffies_lock' needs to be held to prevent
 	 * concurrent invocations.
 	 */
 	write_seqcount_end(&jiffies_seq);
@@ -160,7 +158,8 @@ static ktime_t tick_init_jiffy_update(void)
=20
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
-	/* Did we start the jiffies update yet ? */
+
+	/* Have we started the jiffies update yet ? */
 	if (last_jiffies_update =3D=3D 0) {
 		u32 rem;
=20
@@ -175,8 +174,10 @@ static ktime_t tick_init_jiffy_update(void)
 		last_jiffies_update =3D tick_next_period;
 	}
 	period =3D last_jiffies_update;
+
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
+
 	return period;
 }
=20
@@ -192,10 +193,10 @@ static void tick_sched_do_timer(struct tick_sched *ts, =
ktime_t now)
 	 * concurrency: This happens only when the CPU in charge went
 	 * into a long sleep. If two CPUs happen to assign themselves to
 	 * this duty, then the jiffies update is still serialized by
-	 * jiffies_lock.
+	 * 'jiffies_lock'.
 	 *
 	 * If nohz_full is enabled, this should not happen because the
-	 * tick_do_timer_cpu never relinquishes.
+	 * 'tick_do_timer_cpu' CPU never relinquishes.
 	 */
 	if (unlikely(tick_do_timer_cpu =3D=3D TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
@@ -205,12 +206,12 @@ static void tick_sched_do_timer(struct tick_sched *ts, =
ktime_t now)
 	}
 #endif
=20
-	/* Check, if the jiffies need an update */
+	/* Check if jiffies need an update */
 	if (tick_do_timer_cpu =3D=3D cpu)
 		tick_do_update_jiffies64(now);
=20
 	/*
-	 * If jiffies update stalled for too long (timekeeper in stop_machine()
+	 * If the jiffies update stalled for too long (timekeeper in stop_machine()
 	 * or VMEXIT'ed for several msecs), force an update.
 	 */
 	if (ts->last_tick_jiffies !=3D jiffies) {
@@ -234,10 +235,10 @@ static void tick_sched_handle(struct tick_sched *ts, st=
ruct pt_regs *regs)
 	/*
 	 * When we are idle and the tick is stopped, we have to touch
 	 * the watchdog as we might not schedule for a really long
-	 * time. This happens on complete idle SMP systems while
+	 * time. This happens on completely idle SMP systems while
 	 * waiting on the login prompt. We also increment the "start of
 	 * idle" jiffy stamp so the idle accounting adjustment we do
-	 * when we go busy again does not account too much ticks.
+	 * when we go busy again does not account too many ticks.
 	 */
 	if (ts->tick_stopped) {
 		touch_softlockup_watchdog_sched();
@@ -362,7 +363,7 @@ static void tick_nohz_kick_task(struct task_struct *tsk)
=20
 	/*
 	 * If the task is not running, run_posix_cpu_timers()
-	 * has nothing to elapse, IPI can then be spared.
+	 * has nothing to elapse, and an IPI can then be optimized out.
 	 *
 	 * activate_task()                      STORE p->tick_dep_mask
 	 *   STORE p->on_rq
@@ -425,7 +426,7 @@ static void tick_nohz_dep_set_all(atomic_t *dep,
=20
 /*
  * Set a global tick dependency. Used by perf events that rely on freq and
- * by unstable clock.
+ * unstable clocks.
  */
 void tick_nohz_dep_set(enum tick_dep_bits bit)
 {
@@ -439,7 +440,7 @@ void tick_nohz_dep_clear(enum tick_dep_bits bit)
=20
 /*
  * Set per-CPU tick dependency. Used by scheduler and perf events in order to
- * manage events throttling.
+ * manage event-throttling.
  */
 void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bit)
 {
@@ -455,7 +456,7 @@ void tick_nohz_dep_set_cpu(int cpu, enum tick_dep_bits bi=
t)
 		if (cpu =3D=3D smp_processor_id()) {
 			tick_nohz_full_kick();
 		} else {
-			/* Remote irq work not NMI-safe */
+			/* Remote IRQ work not NMI-safe */
 			if (!WARN_ON_ONCE(in_nmi()))
 				tick_nohz_full_kick_cpu(cpu);
 		}
@@ -473,7 +474,7 @@ void tick_nohz_dep_clear_cpu(int cpu, enum tick_dep_bits =
bit)
 EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cpu);
=20
 /*
- * Set a per-task tick dependency. RCU need this. Also posix CPU timers
+ * Set a per-task tick dependency. RCU needs this. Also posix CPU timers
  * in order to elapse per task timers.
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
@@ -546,7 +547,7 @@ void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 bool tick_nohz_cpu_hotpluggable(unsigned int cpu)
 {
 	/*
-	 * The tick_do_timer_cpu CPU handles housekeeping duty (unbound
+	 * The 'tick_do_timer_cpu' CPU handles housekeeping duty (unbound
 	 * timers, workqueues, timekeeping, ...) on behalf of full dynticks
 	 * CPUs. It must remain online when nohz full is enabled.
 	 */
@@ -568,12 +569,12 @@ void __init tick_nohz_init(void)
 		return;
=20
 	/*
-	 * Full dynticks uses irq work to drive the tick rescheduling on safe
-	 * locking contexts. But then we need irq work to raise its own
-	 * interrupts to avoid circular dependency on the tick
+	 * Full dynticks uses IRQ work to drive the tick rescheduling on safe
+	 * locking contexts. But then we need IRQ work to raise its own
+	 * interrupts to avoid circular dependency on the tick.
 	 */
 	if (!arch_irq_work_has_interrupt()) {
-		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support irq w=
ork self-IPIs\n");
+		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support IRQ w=
ork self-IPIs\n");
 		cpumask_clear(tick_nohz_full_mask);
 		tick_nohz_full_running =3D false;
 		return;
@@ -643,7 +644,7 @@ bool tick_nohz_tick_stopped_cpu(int cpu)
  * In case the sched_tick was stopped on this CPU, we have to check if jiffi=
es
  * must be updated. Otherwise an interrupt handler could use a stale jiffy
  * value. We do this unconditionally on any CPU, as we don't know whether the
- * CPU, which has the update task assigned is in a long sleep.
+ * CPU, which has the update task assigned, is in a long sleep.
  */
 static void tick_nohz_update_jiffies(ktime_t now)
 {
@@ -726,7 +727,7 @@ static u64 get_cpu_sleep_time_us(struct tick_sched *ts, k=
time_t *sleeptime,
  * counters if NULL.
  *
  * Return the cumulative idle time (since boot) for a given
- * CPU, in microseconds. Note this is partially broken due to
+ * CPU, in microseconds. Note that this is partially broken due to
  * the counter of iowait tasks that can be remotely updated without
  * any synchronization. Therefore it is possible to observe backward
  * values within two consecutive reads.
@@ -787,7 +788,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktim=
e_t now)
 	}
=20
 	/*
-	 * Reset to make sure next tick stop doesn't get fooled by past
+	 * Reset to make sure the next tick stop doesn't get fooled by past
 	 * cached clock deadline.
 	 */
 	ts->next_tick =3D 0;
@@ -816,11 +817,11 @@ static ktime_t tick_nohz_next_event(struct tick_sched *=
ts, int cpu)
 	/*
 	 * Keep the periodic tick, when RCU, architecture or irq_work
 	 * requests it.
-	 * Aside of that check whether the local timer softirq is
-	 * pending. If so its a bad idea to call get_next_timer_interrupt()
+	 * Aside of that, check whether the local timer softirq is
+	 * pending. If so, its a bad idea to call get_next_timer_interrupt(),
 	 * because there is an already expired timer, so it will request
 	 * immediate expiry, which rearms the hardware timer with a
-	 * minimal delta which brings us back to this place
+	 * minimal delta, which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
 	if (rcu_needs_cpu() || arch_needs_cpu() ||
@@ -861,7 +862,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts=
, int cpu)
=20
 	/*
 	 * If this CPU is the one which had the do_timer() duty last, we limit
-	 * the sleep time to the timekeeping max_deferment value.
+	 * the sleep time to the timekeeping 'max_deferment' value.
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta =3D timekeeping_max_deferment();
@@ -895,8 +896,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, in=
t cpu)
 	 * If this CPU is the one which updates jiffies, then give up
 	 * the assignment and let it be taken by the CPU which runs
 	 * the tick timer next, which might be this CPU as well. If we
-	 * don't drop this here the jiffies might be stale and
-	 * do_timer() never invoked. Keep track of the fact that it
+	 * don't drop this here, the jiffies might be stale and
+	 * do_timer() never gets invoked. Keep track of the fact that it
 	 * was the one which had the do_timer() duty last.
 	 */
 	if (cpu =3D=3D tick_do_timer_cpu) {
@@ -906,7 +907,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, in=
t cpu)
 		ts->do_timer_last =3D 0;
 	}
=20
-	/* Skip reprogram of event if its not changed */
+	/* Skip reprogram of event if it's not changed */
 	if (ts->tick_stopped && (expires =3D=3D ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
 		if (tick =3D=3D KTIME_MAX || ts->next_tick =3D=3D hrtimer_get_expires(&ts-=
>sched_timer))
@@ -919,11 +920,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, =
int cpu)
 	}
=20
 	/*
-	 * nohz_stop_sched_tick can be called several times before
-	 * the nohz_restart_sched_tick is called. This happens when
+	 * nohz_stop_sched_tick() can be called several times before
+	 * nohz_restart_sched_tick() is called. This happens when
 	 * interrupts arrive which do not cause a reschedule. In the
 	 * first call we save the current tick time, so we can restart
-	 * the scheduler tick in nohz_restart_sched_tick.
+	 * the scheduler tick in nohz_restart_sched_tick().
 	 */
 	if (!ts->tick_stopped) {
 		calc_load_nohz_start();
@@ -985,9 +986,8 @@ static void tick_nohz_restart_sched_tick(struct tick_sche=
d *ts, ktime_t now)
=20
 	calc_load_nohz_stop();
 	touch_softlockup_watchdog_sched();
-	/*
-	 * Cancel the scheduled timer and restore the tick
-	 */
+
+	/* Cancel the scheduled timer and restore the tick: */
 	ts->tick_stopped  =3D 0;
 	tick_nohz_restart(ts, now);
 }
@@ -1019,11 +1019,11 @@ static void tick_nohz_full_update_tick(struct tick_sc=
hed *ts)
 /*
  * A pending softirq outside an IRQ (or softirq disabled section) context
  * should be waiting for ksoftirqd to handle it. Therefore we shouldn't
- * reach here due to the need_resched() early check in can_stop_idle_tick().
+ * reach this code due to the need_resched() early check in can_stop_idle_ti=
ck().
  *
  * However if we are between CPUHP_AP_SMPBOOT_THREADS and CPU_TEARDOWN_CPU o=
n the
  * cpu_down() process, softirqs can still be raised while ksoftirqd is parke=
d,
- * triggering the below since wakep_softirqd() is ignored.
+ * triggering the code below, since wakep_softirqd() is ignored.
  *
  */
 static bool report_idle_softirq(void)
@@ -1044,7 +1044,7 @@ static bool report_idle_softirq(void)
 	if (ratelimit >=3D 10)
 		return false;
=20
-	/* On RT, softirqs handling may be waiting on some lock */
+	/* On RT, softirq handling may be waiting on some lock */
 	if (local_bh_blocked())
 		return false;
=20
@@ -1061,8 +1061,8 @@ static bool can_stop_idle_tick(int cpu, struct tick_sch=
ed *ts)
 	 * If this CPU is offline and it is the one which updates
 	 * jiffies, then give up the assignment and let it be taken by
 	 * the CPU which runs the tick timer next. If we don't drop
-	 * this here the jiffies might be stale and do_timer() never
-	 * invoked.
+	 * this here, the jiffies might be stale and do_timer() never
+	 * gets invoked.
 	 */
 	if (unlikely(!cpu_online(cpu))) {
 		if (cpu =3D=3D tick_do_timer_cpu)
@@ -1175,12 +1175,23 @@ void tick_nohz_idle_enter(void)
 }
=20
 /**
- * tick_nohz_irq_exit - update next tick event from interrupt exit
+ * tick_nohz_irq_exit - Notify the tick about IRQ exit
+ *
+ * A timer may have been added/modified/deleted either by the current IRQ,
+ * or by another place using this IRQ as a notification. This IRQ may have
+ * also updated the RCU callback list. These events may require a
+ * re-evaluation of the next tick. Depending on the context:
+ *
+ * 1) If the CPU is idle and no resched is pending, just proceed with idle
+ *    time accounting. The next tick will be re-evaluated on the next idle
+ *    loop iteration.
+ *
+ * 2) If the CPU is nohz_full:
  *
- * When an interrupt fires while we are idle and it doesn't cause
- * a reschedule, it may still add, modify or delete a timer, enqueue
- * an RCU callback, etc...
- * So we need to re-calculate and reprogram the next tick event.
+ *    2.1) If there is any tick dependency, restart the tick if stopped.
+ *
+ *    2.2) If there is no tick dependency, (re-)evaluate the next tick and
+ *         stop/update it accordingly.
  */
 void tick_nohz_irq_exit(void)
 {
@@ -1208,7 +1219,7 @@ bool tick_nohz_idle_got_tick(void)
=20
 /**
  * tick_nohz_get_next_hrtimer - return the next expiration time for the hrti=
mer
- * or the tick, whatever that expires first. Note that, if the tick has been
+ * or the tick, whichever expires first. Note that, if the tick has been
  * stopped, it returns the next hrtimer.
  *
  * Called from power state control code with interrupts disabled
@@ -1252,7 +1263,7 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 		return *delta_next;
=20
 	/*
-	 * If the next highres timer to expire is earlier than next_event, the
+	 * If the next highres timer to expire is earlier than 'next_event', the
 	 * idle governor needs to know that.
 	 */
 	next_event =3D min_t(u64, next_event,
@@ -1296,9 +1307,9 @@ static void tick_nohz_account_idle_time(struct tick_sch=
ed *ts,
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
-	 * We stopped the tick in idle. Update process times would miss the
-	 * time we slept as update_process_times does only a 1 tick
-	 * accounting. Enforce that this is accounted to idle !
+	 * We stopped the tick in idle. update_process_times() would miss the
+	 * time we slept, as it does only a 1 tick accounting.
+	 * Enforce that this is accounted to idle !
 	 */
 	ticks =3D jiffies - ts->idle_jiffies;
 	/*
@@ -1330,11 +1341,20 @@ static void tick_nohz_idle_update_tick(struct tick_sc=
hed *ts, ktime_t now)
 }
=20
 /**
- * tick_nohz_idle_exit - restart the idle tick from the idle task
+ * tick_nohz_idle_exit - Update the tick upon idle task exit
+ *
+ * When the idle task exits, update the tick depending on the
+ * following situations:
+ *
+ * 1) If the CPU is not in nohz_full mode (most cases), then
+ *    restart the tick.
+ *
+ * 2) If the CPU is in nohz_full mode (corner case):
+ *   2.1) If the tick can be kept stopped (no tick dependencies)
+ *        then re-evaluate the next tick and try to keep it stopped
+ *        as long as possible.
+ *   2.2) If the tick has dependencies, restart the tick.
  *
- * Restart the idle tick when the CPU is woken up from idle
- * This also exit the RCU extended quiescent state. The CPU
- * can use RCU again after this function is called.
  */
 void tick_nohz_idle_exit(void)
 {
@@ -1364,9 +1384,15 @@ void tick_nohz_idle_exit(void)
 }
=20
 /*
- * The nohz low res interrupt handler
+ * In low-resolution mode, the tick handler must be implemented directly
+ * at the clockevent level. hrtimer can't be used instead, because its
+ * infrastructure actually relies on the tick itself as a backend in
+ * low-resolution mode (see hrtimer_run_queues()).
+ *
+ * This low-resolution handler still makes use of some hrtimer APIs meanwhile
+ * for convenience with expiration calculation and forwarding.
  */
-static void tick_nohz_handler(struct clock_event_device *dev)
+static void tick_nohz_lowres_handler(struct clock_event_device *dev)
 {
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
 	struct pt_regs *regs =3D get_irq_regs();
@@ -1377,18 +1403,16 @@ static void tick_nohz_handler(struct clock_event_devi=
ce *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
=20
-	if (unlikely(ts->tick_stopped)) {
-		/*
-		 * The clockevent device is not reprogrammed, so change the
-		 * clock event device to ONESHOT_STOPPED to avoid spurious
-		 * interrupts on devices which might not be truly one shot.
-		 */
-		tick_program_event(KTIME_MAX, 1);
-		return;
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
+	if (likely(!ts->tick_stopped)) {
+		hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
+		tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 	}
=20
-	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
-	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
 }
=20
 static inline void tick_nohz_activate(struct tick_sched *ts, int mode)
@@ -1402,7 +1426,7 @@ static inline void tick_nohz_activate(struct tick_sched=
 *ts, int mode)
 }
=20
 /**
- * tick_nohz_switch_to_nohz - switch to nohz mode
+ * tick_nohz_switch_to_nohz - switch to NOHZ mode
  */
 static void tick_nohz_switch_to_nohz(void)
 {
@@ -1412,12 +1436,12 @@ static void tick_nohz_switch_to_nohz(void)
 	if (!tick_nohz_enabled)
 		return;
=20
-	if (tick_switch_to_oneshot(tick_nohz_handler))
+	if (tick_switch_to_oneshot(tick_nohz_lowres_handler))
 		return;
=20
 	/*
-	 * Recycle the hrtimer in ts, so we can share the
-	 * hrtimer_forward with the highres code.
+	 * Recycle the hrtimer in 'ts', so we can share the
+	 * hrtimer_forward_now() function with the highres code.
 	 */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
 	/* Get the next period */
@@ -1440,7 +1464,7 @@ static inline void tick_nohz_irq_enter(void)
 	if (ts->idle_active)
 		tick_nohz_stop_idle(ts, now);
 	/*
-	 * If all CPUs are idle. We may need to update a stale jiffies value.
+	 * If all CPUs are idle we may need to update a stale jiffies value.
 	 * Note nohz_full is a special case: a timekeeper is guaranteed to stay
 	 * alive but it might be busy looping with interrupts disabled in some
 	 * rare case (typically stop machine). So we must make sure we have a
@@ -1459,7 +1483,7 @@ static inline void tick_nohz_activate(struct tick_sched=
 *ts, int mode) { }
 #endif /* CONFIG_NO_HZ_COMMON */
=20
 /*
- * Called from irq_enter to notify about the possible interruption of idle()
+ * Called from irq_enter() to notify about the possible interruption of idle=
()
  */
 void tick_irq_enter(void)
 {
@@ -1475,7 +1499,7 @@ void tick_irq_enter(void)
  * We rearm the timer until we get disabled by the idle code.
  * Called with interrupts disabled.
  */
-static enum hrtimer_restart tick_sched_timer(struct hrtimer *timer)
+static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 {
 	struct tick_sched *ts =3D
 		container_of(timer, struct tick_sched, sched_timer);
@@ -1485,15 +1509,19 @@ static enum hrtimer_restart tick_sched_timer(struct h=
rtimer *timer)
 	tick_sched_do_timer(ts, now);
=20
 	/*
-	 * Do not call, when we are not in irq context and have
-	 * no valid regs pointer
+	 * Do not call when we are not in IRQ context and have
+	 * no valid 'regs' pointer
 	 */
 	if (regs)
 		tick_sched_handle(ts, regs);
 	else
 		ts->next_tick =3D 0;
=20
-	/* No need to reprogram if we are in idle or full dynticks mode */
+	/*
+	 * In dynticks mode, tick reprogram is deferred:
+	 * - to the idle task if in dynticks-idle
+	 * - to IRQ exit if in full-dynticks.
+	 */
 	if (unlikely(ts->tick_stopped))
 		return HRTIMER_NORESTART;
=20
@@ -1520,16 +1548,14 @@ void tick_setup_sched_timer(void)
 	struct tick_sched *ts =3D this_cpu_ptr(&tick_cpu_sched);
 	ktime_t now =3D ktime_get();
=20
-	/*
-	 * Emulate tick processing via per-CPU hrtimers:
-	 */
+	/* Emulate tick processing via per-CPU hrtimers: */
 	hrtimer_init(&ts->sched_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
-	ts->sched_timer.function =3D tick_sched_timer;
+	ts->sched_timer.function =3D tick_nohz_highres_handler;
=20
 	/* Get the next period (per-CPU) */
 	hrtimer_set_expires(&ts->sched_timer, tick_init_jiffy_update());
=20
-	/* Offset the tick to avert jiffies_lock contention. */
+	/* Offset the tick to avert 'jiffies_lock' contention. */
 	if (sched_skew_tick) {
 		u64 offset =3D TICK_NSEC >> 1;
 		do_div(offset, num_possible_cpus());
@@ -1579,10 +1605,10 @@ void tick_oneshot_notify(void)
 }
=20
 /*
- * Check, if a change happened, which makes oneshot possible.
+ * Check if a change happened, which makes oneshot possible.
  *
- * Called cyclic from the hrtimer softirq (driven by the timer
- * softirq) allow_nohz signals, that we can switch into low-res nohz
+ * Called cyclically from the hrtimer softirq (driven by the timer
+ * softirq). 'allow_nohz' signals that we can switch into low-res NOHZ
  * mode, because high resolution timers are disabled (either compile
  * or runtime). Called with interrupts disabled.
  */

