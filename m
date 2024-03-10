Return-Path: <linux-kernel+bounces-98365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C787792E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 00:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E56B21134
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 23:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF9C3D0A4;
	Sun, 10 Mar 2024 23:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z4icFbaY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KmwX/NZt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23393A8C1
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 23:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710113943; cv=none; b=AC0+fapqtYTNm7j5k3enBsY2g20H6s3has9K1f1Tp9xkV9m+2V65mP3ukiVuPBtOVoUujnsaScNoGxmo++PIM4ZjpCi5ofN0JQlQ6E43grFVgaPsP7aG8ZEld4XexIMSFfkBRU7Yb1gYZtbsgWvBeAo736+8y+qQawvVEiStrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710113943; c=relaxed/simple;
	bh=Z0xWeEDhc3LkvsmxNdbXtuzvOinTbvoqvNDdzczRhwc=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=hjZEgbd6RIAa5GhdGuszgTGfM4PYoU5zDtQgZNSS8T1gj4Wi5XMp32sQZhVAf63LGTcD4R5thwL0iwejdsDwbKMfwh5DxAA6kHVd8zZ9LrNpQTkf2t3kZz3h+apZgE1gwXuGtQ3GSqIPdnB9ab2BIT2PlRdQX5G+jbJ0c0QOroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z4icFbaY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KmwX/NZt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710113931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N95/in1YDdmnS5e31oilBGrpO7AfFYig3cVWBMRNexM=;
	b=Z4icFbaYTOguJAWxV7UkGtsmNe4kj3MouJsd09O/F+ZT495vV/KLPrzolnyFVkdoHEYZGG
	SrkKPCZnisJEH0qHA5NCSFhw1l7J6RwYwgJlNZ5KVz66KnQf+08Ou7eCxGVDf4GYKwb7TK
	N+6SX2nYwD/qkVhg2zKuVuU4iuT7IfxW/DkEg8Oo3chb6NHquivN6ahbruOW8HK/dq7UzA
	F11cFdauUWIYbyfSdlQiSMuyf+BSkBKdBlKHs5uwMi34chWJfJRRi5SsyWXB9+AnUwRB1D
	PUL0NSDr2+knjPsIn8rkmF8zqOM7lkWE1Z4gwndKfR4iTZlQEuWMixVElOJWzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710113931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N95/in1YDdmnS5e31oilBGrpO7AfFYig3cVWBMRNexM=;
	b=KmwX/NZtbuFbgkYuRZkNQwuH2Qtyrj3IhcseGqL8KmSJbMVqd+bcsntKKX3AN9AMhoqWuW
	MAyaPIV4bOl5b1AQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/core for v6.9-rc1
Message-ID: <171011361246.2468526.10740060923051583953.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 Mar 2024 00:38:50 +0100 (CET)

Linus,

please pull the latest irq/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2024-03=
-10

up to:  f7f56d59a392: irqchip/ts4800: Convert to platform_driver::remove_new(=
) callback

Updates for the interrupt subsystem:

 - Core:

   - Make affinity changes immediately effective for interrupt
     threads. This reduces the impact on isolated CPUs as it pulls over the
     thread right away instead of doing it after the next hardware
     interrupt arrived.

   - Cleanup and improvements for the interrupt chip simulator

   - Deduplication of the interrupt descriptor initialization code so the
     sparse and non-sparse mode share more code.

 - Drivers:

   - A set of conversions to platform_drivers::remove_new() which gets rid
     of the pointless return value.

   - A new driver for the Starfive JH8100 SoC

   - Support for Amlogic-T7 SoCs

   - Improvement for the interrupt handling and EOI management for the
     loongson interrupt controller.

   - The usual fixes and improvements all over the place.

Thanks,

	tglx

------------------>
Bartosz Golaszewski (4):
      bitmap: Define a cleanup function for bitmaps
      genirq/irq_sim: Remove unused field from struct irq_sim_irq_ctx
      genirq/irq_sim: Order headers alphabetically
      genirq/irq_sim: Shrink code by using <linux/cleanup.h> helpers

Bibo Mao (2):
      irqchip/loongson-eiointc: Skip handling if there is no pending interrupt
      irqchip/loongson-eiointc: Remove explicit interrupt affinity restore on=
 resume

Changhuang Liang (2):
      dt-bindings: interrupt-controller: Add starfive,jh8100-intc
      irqchip: Add StarFive external interrupt controller

Christophe JAILLET (1):
      irqchip/gic-v3-its: Remove usage of the deprecated ida_simple_xx() API

Crystal Wood (1):
      genirq: Wake interrupt threads immediately when changing affinity

Dawei Li (4):
      irqchip/gic-v3: Use readl_relaxed_poll_timeout_atomic()
      irqchip/gic(v3): Replace gic_irq() with irqd_to_hwirq()
      genirq: Remove unneeded forward declaration
      genirq: Deduplicate interrupt descriptor initialization

Erick Archer (2):
      irqchip/bcm-6345-l1: Prefer struct_size)_ over open coded arithmetic
      irqchip/irq-bcm7038-l1: Prefer struct_size over open coded arithmetic

Huqiang Qin (3):
      dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
      irqchip/meson-gpio: Add support for Amlogic-T7 SoCs
      arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs

Randy Dunlap (1):
      irqchip/vic: Fix a kernel-doc warning

Uwe Kleine-K=C3=B6nig (13):
      irqchip/imgpdc: Convert to platform_driver::remove_new() callback
      irqchip/imx-intmux: Convert to platform_driver::remove_new() callback
      irqchip/imx-irqsteer: Convert to platform_driver::remove_new() callback
      irqchip/keystone: Convert to platform_driver::remove_new() callback
      irqchip/ls-scfg-msi: Convert to platform_driver::remove_new() callback
      irqchip/madera: Convert to platform_driver::remove_new() callback
      irqchip/mvebu-pic: Convert to platform_driver::remove_new() callback
      irqchip/pruss-intc: Convert to platform_driver::remove_new() callback
      irqchip/renesas-intc-irqpin: Convert to platform_driver::remove_new() c=
allback
      irqchip/renesas-irqc: Convert to platform_driver::remove_new() callback
      irqchip/renesas-rza1: Convert to platform_driver::remove_new() callback
      irqchip/stm32-exti: Convert to platform_driver::remove_new() callback
      irqchip/ts4800: Convert to platform_driver::remove_new() callback


 .../amlogic,meson-gpio-intc.yaml                   |   1 +
 .../interrupt-controller/starfive,jh8100-intc.yaml |  61 ++++++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        |  10 +
 drivers/irqchip/Kconfig                            |  11 ++
 drivers/irqchip/Makefile                           |   1 +
 drivers/irqchip/irq-bcm6345-l1.c                   |   2 +-
 drivers/irqchip/irq-bcm7038-l1.c                   |   2 +-
 drivers/irqchip/irq-gic-v3-its.c                   |   4 +-
 drivers/irqchip/irq-gic-v3.c                       |  51 ++---
 drivers/irqchip/irq-gic.c                          |  27 ++-
 drivers/irqchip/irq-imgpdc.c                       |   7 +-
 drivers/irqchip/irq-imx-intmux.c                   |  14 +-
 drivers/irqchip/irq-imx-irqsteer.c                 |  14 +-
 drivers/irqchip/irq-keystone.c                     |   5 +-
 drivers/irqchip/irq-loongson-eiointc.c             |  22 +--
 drivers/irqchip/irq-ls-scfg-msi.c                  |  12 +-
 drivers/irqchip/irq-madera.c                       |   8 +-
 drivers/irqchip/irq-meson-gpio.c                   |   5 +
 drivers/irqchip/irq-mvebu-pic.c                    |  12 +-
 drivers/irqchip/irq-pruss-intc.c                   |  14 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  11 +-
 drivers/irqchip/irq-renesas-irqc.c                 |   9 +-
 drivers/irqchip/irq-renesas-rza1.c                 |   7 +-
 drivers/irqchip/irq-starfive-jh8100-intc.c         | 207 +++++++++++++++++++=
++
 drivers/irqchip/irq-stm32-exti.c                   |   9 +-
 drivers/irqchip/irq-ts4800.c                       |  12 +-
 drivers/irqchip/irq-vic.c                          |   3 +-
 include/linux/bitmap.h                             |   3 +
 include/linux/irq.h                                |   2 +-
 include/linux/irqhandler.h                         |   2 +-
 kernel/irq/irq_sim.c                               |  28 ++-
 kernel/irq/irqdesc.c                               | 112 ++++++-----
 kernel/irq/manage.c                                | 109 +++++------
 34 files changed, 537 insertions(+), 266 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st=
arfive,jh8100-intc.yaml
 create mode 100644 drivers/irqchip/irq-starfive-jh8100-intc.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,m=
eson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/=
amlogic,meson-gpio-intc.yaml
index 3d06db98e978..a93744763787 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gp=
io-intc.yaml
@@ -36,6 +36,7 @@ properties:
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
               - amlogic,c3-gpio-intc
+              - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
=20
   reg:
diff --git a/Documentation/devicetree/bindings/interrupt-controller/starfive,=
jh8100-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/sta=
rfive,jh8100-intc.yaml
new file mode 100644
index 000000000000..ada5788602d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-=
intc.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/starfive,jh8100-intc=
yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive External Interrupt Controller
+
+description:
+  StarFive SoC JH8100 contain a external interrupt controller. It can be used
+  to handle high-level input interrupt signals. It also send the output
+  interrupt signal to RISC-V PLIC.
+
+maintainers:
+  - Changhuang Liang <changhuang.liang@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-intc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: APB clock for the interrupt controller
+    maxItems: 1
+
+  resets:
+    description: APB reset for the interrupt controller
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - interrupts
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@12260000 {
+      compatible =3D "starfive,jh8100-intc";
+      reg =3D <0x12260000 0x10000>;
+      clocks =3D <&syscrg_ne 76>;
+      resets =3D <&syscrg_ne 13>;
+      interrupts =3D <45>;
+      interrupt-controller;
+      #interrupt-cells =3D <1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..ef678f04c830 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20956,6 +20956,12 @@ F:	Documentation/devicetree/bindings/phy/starfive,jh=
7110-usb-phy.yaml
 F:	drivers/phy/starfive/phy-jh7110-pcie.c
 F:	drivers/phy/starfive/phy-jh7110-usb.c
=20
+STARFIVE JH8100 EXTERNAL INTERRUPT CONTROLLER DRIVER
+M:	Changhuang Liang <changhuang.liang@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/interrupt-controller/starfive,jh8100-in=
tc.yaml
+F:	drivers/irqchip/irq-starfive-jh8100-intc.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dt=
s/amlogic/amlogic-t7.dtsi
index a03c7667d2b6..2bfe2c431611 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -171,6 +171,16 @@ gpio: bank@4000 {
 				};
 			};
=20
+			gpio_intc: interrupt-controller@4080 {
+				compatible =3D "amlogic,t7-gpio-intc",
+					     "amlogic,meson-gpio-intc";
+				reg =3D <0x0 0x4080 0x0 0x20>;
+				interrupt-controller;
+				#interrupt-cells =3D <2>;
+				amlogic,channel-interrupts =3D
+					<10 11 12 13 14 15 16 17 18 19 20 21>;
+			};
+
 			uart_a: serial@78000 {
 				compatible =3D "amlogic,t7-uart", "amlogic,meson-s4-uart";
 				reg =3D <0x0 0x78000 0x0 0x18>;
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..72c07a12f5e1 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -546,6 +546,17 @@ config SIFIVE_PLIC
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
=20
+config STARFIVE_JH8100_INTC
+	bool "StarFive JH8100 External Interrupt Controller"
+	depends on ARCH_STARFIVE || COMPILE_TEST
+	default ARCH_STARFIVE
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  This enables support for the INTC chip found in StarFive JH8100
+	  SoC.
+
+	  If you don't know what to do here, say Y.
+
 config EXYNOS_IRQ_COMBINER
 	bool "Samsung Exynos IRQ combiner support" if COMPILE_TEST
 	depends on (ARCH_EXYNOS && ARM) || COMPILE_TEST
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..ec4a18380998 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_CSKY_MPINTC)		+=3D irq-csky-mpintc.o
 obj-$(CONFIG_CSKY_APB_INTC)		+=3D irq-csky-apb-intc.o
 obj-$(CONFIG_RISCV_INTC)		+=3D irq-riscv-intc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+=3D irq-sifive-plic.o
+obj-$(CONFIG_STARFIVE_JH8100_INTC)	+=3D irq-starfive-jh8100-intc.o
 obj-$(CONFIG_IMX_IRQSTEER)		+=3D irq-imx-irqsteer.o
 obj-$(CONFIG_IMX_INTMUX)		+=3D irq-imx-intmux.o
 obj-$(CONFIG_IMX_MU_MSI)		+=3D irq-imx-mu-msi.o
diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm6345-l=
1.c
index 9745a119d0e6..eb02d203c963 100644
--- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -242,7 +242,7 @@ static int __init bcm6345_l1_init_one(struct device_node =
*dn,
 	else if (intc->n_words !=3D n_words)
 		return -EINVAL;
=20
-	cpu =3D intc->cpus[idx] =3D kzalloc(sizeof(*cpu) + n_words * sizeof(u32),
+	cpu =3D intc->cpus[idx] =3D kzalloc(struct_size(cpu, enable_cache, n_words),
 					GFP_KERNEL);
 	if (!cpu)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l=
1.c
index 24ca1d656adc..36e71af054e9 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -249,7 +249,7 @@ static int __init bcm7038_l1_init_one(struct device_node =
*dn,
 		return -EINVAL;
 	}
=20
-	cpu =3D intc->cpus[idx] =3D kzalloc(sizeof(*cpu) + n_words * sizeof(u32),
+	cpu =3D intc->cpus[idx] =3D kzalloc(struct_size(cpu, mask_cache, n_words),
 					GFP_KERNEL);
 	if (!cpu)
 		return -ENOMEM;
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index d097001c1e3e..cd950f435cf0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4419,12 +4419,12 @@ static const struct irq_domain_ops its_sgi_domain_ops=
 =3D {
=20
 static int its_vpe_id_alloc(void)
 {
-	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
+	return ida_alloc_max(&its_vpeid_ida, ITS_MAX_VPEID - 1, GFP_KERNEL);
 }
=20
 static void its_vpe_id_free(u16 id)
 {
-	ida_simple_remove(&its_vpeid_ida, id);
+	ida_free(&its_vpeid_ida, id);
 }
=20
 static int its_vpe_init(struct its_vpe *vpe)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 98b0329b7154..20a75f0353cd 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -19,6 +19,7 @@
 #include <linux/percpu.h>
 #include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/iopoll.h>
=20
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-common.h>
@@ -180,11 +181,6 @@ static enum gic_intid_range get_intid_range(struct irq_d=
ata *d)
 	return __get_intid_range(d->hwirq);
 }
=20
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool gic_irq_in_rdist(struct irq_data *d)
 {
 	switch (get_intid_range(d)) {
@@ -251,17 +247,13 @@ static inline void __iomem *gic_dist_base(struct irq_da=
ta *d)
=20
 static void gic_do_wait_for_rwp(void __iomem *base, u32 bit)
 {
-	u32 count =3D 1000000;	/* 1s! */
+	u32 val;
+	int ret;
=20
-	while (readl_relaxed(base + GICD_CTLR) & bit) {
-		count--;
-		if (!count) {
-			pr_err_ratelimited("RWP timeout, gone fishing\n");
-			return;
-		}
-		cpu_relax();
-		udelay(1);
-	}
+	ret =3D readl_relaxed_poll_timeout_atomic(base + GICD_CTLR, val, !(val & bi=
t),
+						1, USEC_PER_SEC);
+	if (ret =3D=3D -ETIMEDOUT)
+		pr_err_ratelimited("RWP timeout, gone fishing\n");
 }
=20
 /* Wait for completion of a distributor change */
@@ -279,8 +271,8 @@ static void gic_redist_wait_for_rwp(void)
 static void gic_enable_redist(bool enable)
 {
 	void __iomem *rbase;
-	u32 count =3D 1000000;	/* 1s! */
 	u32 val;
+	int ret;
=20
 	if (gic_data.flags & FLAGS_WORKAROUND_GICR_WAKER_MSM8996)
 		return;
@@ -301,16 +293,13 @@ static void gic_enable_redist(bool enable)
 			return;	/* No PM support in this redistributor */
 	}
=20
-	while (--count) {
-		val =3D readl_relaxed(rbase + GICR_WAKER);
-		if (enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep))
-			break;
-		cpu_relax();
-		udelay(1);
-	}
-	if (!count)
+	ret =3D readl_relaxed_poll_timeout_atomic(rbase + GICR_WAKER, val,
+						enable ^ (bool)(val & GICR_WAKER_ChildrenAsleep),
+						1, USEC_PER_SEC);
+	if (ret =3D=3D -ETIMEDOUT) {
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
+	}
 }
=20
 /*
@@ -548,7 +537,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
 	 * A secondary irq_chip should be in charge of LPI request,
 	 * it should not be possible to get there
 	 */
-	if (WARN_ON(gic_irq(d) >=3D 8192))
+	if (WARN_ON(irqd_to_hwirq(d) >=3D 8192))
 		return -EINVAL;
=20
 	/* desc lock should already be held */
@@ -588,7 +577,7 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
 	 * A secondary irq_chip should be in charge of LPI request,
 	 * it should not be possible to get there
 	 */
-	if (WARN_ON(gic_irq(d) >=3D 8192))
+	if (WARN_ON(irqd_to_hwirq(d) >=3D 8192))
 		return;
=20
 	/* desc lock should already be held */
@@ -626,7 +615,7 @@ static bool gic_arm64_erratum_2941627_needed(struct irq_d=
ata *d)
=20
 static void gic_eoi_irq(struct irq_data *d)
 {
-	write_gicreg(gic_irq(d), ICC_EOIR1_EL1);
+	write_gicreg(irqd_to_hwirq(d), ICC_EOIR1_EL1);
 	isb();
=20
 	if (gic_arm64_erratum_2941627_needed(d)) {
@@ -646,19 +635,19 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 * No need to deactivate an LPI, or an interrupt that
 	 * is is getting forwarded to a vcpu.
 	 */
-	if (gic_irq(d) >=3D 8192 || irqd_is_forwarded_to_vcpu(d))
+	if (irqd_to_hwirq(d) >=3D 8192 || irqd_is_forwarded_to_vcpu(d))
 		return;
=20
 	if (!gic_arm64_erratum_2941627_needed(d))
-		gic_write_dir(gic_irq(d));
+		gic_write_dir(irqd_to_hwirq(d));
 	else
 		gic_poke_irq(d, GICD_ICACTIVER);
 }
=20
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	irq_hw_number_t irq =3D irqd_to_hwirq(d);
 	enum gic_intid_range range;
-	unsigned int irq =3D gic_irq(d);
 	void __iomem *base;
 	u32 offset, index;
 	int ret;
@@ -684,7 +673,7 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
 	ret =3D gic_configure_irq(index, type, base + offset, NULL);
 	if (ret && (range =3D=3D PPI_RANGE || range =3D=3D EPPI_RANGE)) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI INTID%d is secure or misconfigured\n", irq);
+		pr_warn("GIC: PPI INTID%ld is secure or misconfigured\n", irq);
 		ret =3D 0;
 	}
=20
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 412196a7dad5..98aa383e39db 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -162,11 +162,6 @@ static inline void __iomem *gic_cpu_base(struct irq_data=
 *d)
 	return gic_data_cpu_base(gic_data);
 }
=20
-static inline unsigned int gic_irq(struct irq_data *d)
-{
-	return d->hwirq;
-}
-
 static inline bool cascading_gic_irq(struct irq_data *d)
 {
 	void *data =3D irq_data_get_irq_handler_data(d);
@@ -183,14 +178,16 @@ static inline bool cascading_gic_irq(struct irq_data *d)
  */
 static void gic_poke_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask =3D 1 << (gic_irq(d) % 32);
-	writel_relaxed(mask, gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4);
+	u32 mask =3D 1 << (irqd_to_hwirq(d) % 32);
+
+	writel_relaxed(mask, gic_dist_base(d) + offset + (irqd_to_hwirq(d) / 32) * =
4);
 }
=20
 static int gic_peek_irq(struct irq_data *d, u32 offset)
 {
-	u32 mask =3D 1 << (gic_irq(d) % 32);
-	return !!(readl_relaxed(gic_dist_base(d) + offset + (gic_irq(d) / 32) * 4) =
& mask);
+	u32 mask =3D 1 << (irqd_to_hwirq(d) % 32);
+
+	return !!(readl_relaxed(gic_dist_base(d) + offset + (irqd_to_hwirq(d) / 32)=
 * 4) & mask);
 }
=20
 static void gic_mask_irq(struct irq_data *d)
@@ -220,7 +217,7 @@ static void gic_unmask_irq(struct irq_data *d)
=20
 static void gic_eoi_irq(struct irq_data *d)
 {
-	u32 hwirq =3D gic_irq(d);
+	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	if (hwirq < 16)
 		hwirq =3D this_cpu_read(sgi_intid);
@@ -230,7 +227,7 @@ static void gic_eoi_irq(struct irq_data *d)
=20
 static void gic_eoimode1_eoi_irq(struct irq_data *d)
 {
-	u32 hwirq =3D gic_irq(d);
+	irq_hw_number_t hwirq =3D irqd_to_hwirq(d);
=20
 	/* Do not deactivate an IRQ forwarded to a vcpu. */
 	if (irqd_is_forwarded_to_vcpu(d))
@@ -293,8 +290,8 @@ static int gic_irq_get_irqchip_state(struct irq_data *d,
=20
 static int gic_set_type(struct irq_data *d, unsigned int type)
 {
+	irq_hw_number_t gicirq =3D irqd_to_hwirq(d);
 	void __iomem *base =3D gic_dist_base(d);
-	unsigned int gicirq =3D gic_irq(d);
 	int ret;
=20
 	/* Interrupt configuration for SGIs can't be changed */
@@ -309,7 +306,7 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
 	ret =3D gic_configure_irq(gicirq, type, base + GIC_DIST_CONFIG, NULL);
 	if (ret && gicirq < 32) {
 		/* Misconfigured PPIs are usually not fatal */
-		pr_warn("GIC: PPI%d is secure or misconfigured\n", gicirq - 16);
+		pr_warn("GIC: PPI%ld is secure or misconfigured\n", gicirq - 16);
 		ret =3D 0;
 	}
=20
@@ -319,7 +316,7 @@ static int gic_set_type(struct irq_data *d, unsigned int =
type)
 static int gic_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu)
 {
 	/* Only interrupts on the primary GIC can be forwarded to a vcpu. */
-	if (cascading_gic_irq(d) || gic_irq(d) < 16)
+	if (cascading_gic_irq(d) || irqd_to_hwirq(d) < 16)
 		return -EINVAL;
=20
 	if (vcpu)
@@ -796,7 +793,7 @@ static void rmw_writeb(u8 bval, void __iomem *addr)
 static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_v=
al,
 			    bool force)
 {
-	void __iomem *reg =3D gic_dist_base(d) + GIC_DIST_TARGET + gic_irq(d);
+	void __iomem *reg =3D gic_dist_base(d) + GIC_DIST_TARGET + irqd_to_hwirq(d);
 	struct gic_chip_data *gic =3D irq_data_get_irq_chip_data(d);
 	unsigned int cpu;
=20
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index 5831be454673..b42ed68acfa6 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -461,12 +461,11 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	return ret;
 }
=20
-static int pdc_intc_remove(struct platform_device *pdev)
+static void pdc_intc_remove(struct platform_device *pdev)
 {
 	struct pdc_intc_priv *priv =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(priv->domain);
-	return 0;
 }
=20
 static const struct of_device_id pdc_intc_match[] =3D {
@@ -479,8 +478,8 @@ static struct platform_driver pdc_intc_driver =3D {
 		.name		=3D "pdc-intc",
 		.of_match_table	=3D pdc_intc_match,
 	},
-	.probe =3D pdc_intc_probe,
-	.remove =3D pdc_intc_remove,
+	.probe		=3D pdc_intc_probe,
+	.remove_new	=3D pdc_intc_remove,
 };
=20
 static int __init pdc_intc_init(void)
diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmu=
x.c
index aa041e4dfee0..656eab21285c 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -282,7 +282,7 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	return ret;
 }
=20
-static int imx_intmux_remove(struct platform_device *pdev)
+static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data =3D platform_get_drvdata(pdev);
 	int i;
@@ -298,8 +298,6 @@ static int imx_intmux_remove(struct platform_device *pdev)
 	}
=20
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
=20
 #ifdef CONFIG_PM
@@ -354,11 +352,11 @@ static const struct of_device_id imx_intmux_id[] =3D {
=20
 static struct platform_driver imx_intmux_driver =3D {
 	.driver =3D {
-		.name =3D "imx-intmux",
-		.of_match_table =3D imx_intmux_id,
-		.pm =3D &imx_intmux_pm_ops,
+		.name		=3D "imx-intmux",
+		.of_match_table	=3D imx_intmux_id,
+		.pm		=3D &imx_intmux_pm_ops,
 	},
-	.probe =3D imx_intmux_probe,
-	.remove =3D imx_intmux_remove,
+	.probe		=3D imx_intmux_probe,
+	.remove_new	=3D imx_intmux_remove,
 };
 builtin_platform_driver(imx_intmux_driver);
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irq=
steer.c
index bd9543314539..20cf7a9e9ece 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -231,7 +231,7 @@ static int imx_irqsteer_probe(struct platform_device *pde=
v)
 	return ret;
 }
=20
-static int imx_irqsteer_remove(struct platform_device *pdev)
+static void imx_irqsteer_remove(struct platform_device *pdev)
 {
 	struct irqsteer_data *irqsteer_data =3D platform_get_drvdata(pdev);
 	int i;
@@ -243,8 +243,6 @@ static int imx_irqsteer_remove(struct platform_device *pd=
ev)
 	irq_domain_remove(irqsteer_data->domain);
=20
 	clk_disable_unprepare(irqsteer_data->ipg_clk);
-
-	return 0;
 }
=20
 #ifdef CONFIG_PM
@@ -307,11 +305,11 @@ static const struct of_device_id imx_irqsteer_dt_ids[] =
=3D {
=20
 static struct platform_driver imx_irqsteer_driver =3D {
 	.driver =3D {
-		.name =3D "imx-irqsteer",
-		.of_match_table =3D imx_irqsteer_dt_ids,
-		.pm =3D &imx_irqsteer_pm_ops,
+		.name		=3D "imx-irqsteer",
+		.of_match_table	=3D imx_irqsteer_dt_ids,
+		.pm		=3D &imx_irqsteer_pm_ops,
 	},
-	.probe =3D imx_irqsteer_probe,
-	.remove =3D imx_irqsteer_remove,
+	.probe		=3D imx_irqsteer_probe,
+	.remove_new	=3D imx_irqsteer_remove,
 };
 builtin_platform_driver(imx_irqsteer_driver);
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index a36396db4b08..30f1979fa124 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -190,7 +190,7 @@ static int keystone_irq_probe(struct platform_device *pde=
v)
 	return 0;
 }
=20
-static int keystone_irq_remove(struct platform_device *pdev)
+static void keystone_irq_remove(struct platform_device *pdev)
 {
 	struct keystone_irq_device *kirq =3D platform_get_drvdata(pdev);
 	int hwirq;
@@ -201,7 +201,6 @@ static int keystone_irq_remove(struct platform_device *pd=
ev)
 		irq_dispose_mapping(irq_find_mapping(kirq->irqd, hwirq));
=20
 	irq_domain_remove(kirq->irqd);
-	return 0;
 }
=20
 static const struct of_device_id keystone_irq_dt_ids[] =3D {
@@ -212,7 +211,7 @@ MODULE_DEVICE_TABLE(of, keystone_irq_dt_ids);
=20
 static struct platform_driver keystone_irq_device_driver =3D {
 	.probe		=3D keystone_irq_probe,
-	.remove		=3D keystone_irq_remove,
+	.remove_new	=3D keystone_irq_remove,
 	.driver		=3D {
 		.name	=3D "keystone_irq",
 		.of_match_table	=3D of_match_ptr(keystone_irq_dt_ids),
diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index 1623cd779175..405f622a26ad 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -198,6 +198,12 @@ static void eiointc_irq_dispatch(struct irq_desc *desc)
=20
 	for (i =3D 0; i < eiointc_priv[0]->vec_count / VEC_COUNT_PER_REG; i++) {
 		pending =3D iocsr_read64(EIOINTC_REG_ISR + (i << 3));
+
+		/* Skip handling if pending bitmap is zero */
+		if (!pending)
+			continue;
+
+		/* Clear the IRQs */
 		iocsr_write64(pending, EIOINTC_REG_ISR + (i << 3));
 		while (pending) {
 			int bit =3D __ffs(pending);
@@ -304,23 +310,7 @@ static int eiointc_suspend(void)
=20
 static void eiointc_resume(void)
 {
-	int i, j;
-	struct irq_desc *desc;
-	struct irq_data *irq_data;
-
 	eiointc_router_init(0);
-
-	for (i =3D 0; i < nr_pics; i++) {
-		for (j =3D 0; j < eiointc_priv[0]->vec_count; j++) {
-			desc =3D irq_resolve_mapping(eiointc_priv[i]->eiointc_domain, j);
-			if (desc && desc->handle_irq && desc->handle_irq !=3D handle_bad_irq) {
-				raw_spin_lock(&desc->lock);
-				irq_data =3D irq_domain_get_irq_data(eiointc_priv[i]->eiointc_domain, ir=
q_desc_get_irq(desc));
-				eiointc_set_irq_affinity(irq_data, irq_data->common->affinity, 0);
-				raw_spin_unlock(&desc->lock);
-			}
-		}
-	}
 }
=20
 static struct syscore_ops eiointc_syscore_ops =3D {
diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-=
msi.c
index 15cf80b46322..1aef5c4d27c6 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -398,7 +398,7 @@ static int ls_scfg_msi_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int ls_scfg_msi_remove(struct platform_device *pdev)
+static void ls_scfg_msi_remove(struct platform_device *pdev)
 {
 	struct ls_scfg_msi *msi_data =3D platform_get_drvdata(pdev);
 	int i;
@@ -410,17 +410,15 @@ static int ls_scfg_msi_remove(struct platform_device *p=
dev)
 	irq_domain_remove(msi_data->parent);
=20
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
=20
 static struct platform_driver ls_scfg_msi_driver =3D {
 	.driver =3D {
-		.name =3D "ls-scfg-msi",
-		.of_match_table =3D ls_scfg_msi_id,
+		.name		=3D "ls-scfg-msi",
+		.of_match_table	=3D ls_scfg_msi_id,
 	},
-	.probe =3D ls_scfg_msi_probe,
-	.remove =3D ls_scfg_msi_remove,
+	.probe		=3D ls_scfg_msi_probe,
+	.remove_new	=3D ls_scfg_msi_remove,
 };
=20
 module_platform_driver(ls_scfg_msi_driver);
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
index 3eb1f8cdf674..acceb6e7fa95 100644
--- a/drivers/irqchip/irq-madera.c
+++ b/drivers/irqchip/irq-madera.c
@@ -222,7 +222,7 @@ static int madera_irq_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int madera_irq_remove(struct platform_device *pdev)
+static void madera_irq_remove(struct platform_device *pdev)
 {
 	struct madera *madera =3D dev_get_drvdata(pdev->dev.parent);
=20
@@ -232,13 +232,11 @@ static int madera_irq_remove(struct platform_device *pd=
ev)
 	 */
 	madera->irq_dev =3D NULL;
 	regmap_del_irq_chip(madera->irq, madera->irq_data);
-
-	return 0;
 }
=20
 static struct platform_driver madera_irq_driver =3D {
-	.probe	=3D &madera_irq_probe,
-	.remove =3D &madera_irq_remove,
+	.probe		=3D madera_irq_probe,
+	.remove_new	=3D madera_irq_remove,
 	.driver =3D {
 		.name	=3D "madera-irq",
 		.pm	=3D &madera_irq_pm_ops,
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index f88df39f4129..9a1791908598 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -154,6 +154,10 @@ static const struct meson_gpio_irq_params c3_params =3D {
 	INIT_MESON_S4_COMMON_DATA(55)
 };
=20
+static const struct meson_gpio_irq_params t7_params =3D {
+	INIT_MESON_S4_COMMON_DATA(157)
+};
+
 static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused =3D=
 {
 	{ .compatible =3D "amlogic,meson8-gpio-intc", .data =3D &meson8_params },
 	{ .compatible =3D "amlogic,meson8b-gpio-intc", .data =3D &meson8b_params },
@@ -165,6 +169,7 @@ static const struct of_device_id meson_irq_gpio_matches[]=
 __maybe_unused =3D {
 	{ .compatible =3D "amlogic,meson-a1-gpio-intc", .data =3D &a1_params },
 	{ .compatible =3D "amlogic,meson-s4-gpio-intc", .data =3D &s4_params },
 	{ .compatible =3D "amlogic,c3-gpio-intc", .data =3D &c3_params },
+	{ .compatible =3D "amlogic,t7-gpio-intc", .data =3D &t7_params },
 	{ }
 };
=20
diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index ef3d3646ccc2..d17d9c0e2880 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -167,14 +167,12 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int mvebu_pic_remove(struct platform_device *pdev)
+static void mvebu_pic_remove(struct platform_device *pdev)
 {
 	struct mvebu_pic *pic =3D platform_get_drvdata(pdev);
=20
 	on_each_cpu(mvebu_pic_disable_percpu_irq, pic, 1);
 	irq_domain_remove(pic->domain);
-
-	return 0;
 }
=20
 static const struct of_device_id mvebu_pic_of_match[] =3D {
@@ -184,11 +182,11 @@ static const struct of_device_id mvebu_pic_of_match[] =
=3D {
 MODULE_DEVICE_TABLE(of, mvebu_pic_of_match);
=20
 static struct platform_driver mvebu_pic_driver =3D {
-	.probe  =3D mvebu_pic_probe,
-	.remove =3D mvebu_pic_remove,
+	.probe		=3D mvebu_pic_probe,
+	.remove_new	=3D mvebu_pic_remove,
 	.driver =3D {
-		.name =3D "mvebu-pic",
-		.of_match_table =3D mvebu_pic_of_match,
+		.name		=3D "mvebu-pic",
+		.of_match_table	=3D mvebu_pic_of_match,
 	},
 };
 module_platform_driver(mvebu_pic_driver);
diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-int=
c.c
index 0f64ecb9b1f4..060eb000e9d3 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -599,7 +599,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 	return ret;
 }
=20
-static int pruss_intc_remove(struct platform_device *pdev)
+static void pruss_intc_remove(struct platform_device *pdev)
 {
 	struct pruss_intc *intc =3D platform_get_drvdata(pdev);
 	u8 max_system_events =3D intc->soc_config->num_system_events;
@@ -616,8 +616,6 @@ static int pruss_intc_remove(struct platform_device *pdev)
 		irq_dispose_mapping(irq_find_mapping(intc->domain, hwirq));
=20
 	irq_domain_remove(intc->domain);
-
-	return 0;
 }
=20
 static const struct pruss_intc_match_data pruss_intc_data =3D {
@@ -645,12 +643,12 @@ MODULE_DEVICE_TABLE(of, pruss_intc_of_match);
=20
 static struct platform_driver pruss_intc_driver =3D {
 	.driver =3D {
-		.name =3D "pruss-intc",
-		.of_match_table =3D pruss_intc_of_match,
-		.suppress_bind_attrs =3D true,
+		.name			=3D "pruss-intc",
+		.of_match_table		=3D pruss_intc_of_match,
+		.suppress_bind_attrs	=3D true,
 	},
-	.probe  =3D pruss_intc_probe,
-	.remove =3D pruss_intc_remove,
+	.probe		=3D pruss_intc_probe,
+	.remove_new	=3D pruss_intc_remove,
 };
 module_platform_driver(pruss_intc_driver);
=20
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-=
renesas-intc-irqpin.c
index fa19585f3dee..9ad37237ba95 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -561,14 +561,13 @@ static int intc_irqpin_probe(struct platform_device *pd=
ev)
 	return ret;
 }
=20
-static int intc_irqpin_remove(struct platform_device *pdev)
+static void intc_irqpin_remove(struct platform_device *pdev)
 {
 	struct intc_irqpin_priv *p =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(p->irq_domain);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
=20
 static int __maybe_unused intc_irqpin_suspend(struct device *dev)
@@ -585,11 +584,11 @@ static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpi=
n_suspend, NULL);
=20
 static struct platform_driver intc_irqpin_device_driver =3D {
 	.probe		=3D intc_irqpin_probe,
-	.remove		=3D intc_irqpin_remove,
+	.remove_new	=3D intc_irqpin_remove,
 	.driver		=3D {
-		.name	=3D "renesas_intc_irqpin",
-		.of_match_table =3D intc_irqpin_dt_ids,
-		.pm	=3D &intc_irqpin_pm_ops,
+		.name		=3D "renesas_intc_irqpin",
+		.of_match_table	=3D intc_irqpin_dt_ids,
+		.pm		=3D &intc_irqpin_pm_ops,
 	}
 };
=20
diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas=
-irqc.c
index 49b446b396f9..76026e0b8e20 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -218,14 +218,13 @@ static int irqc_probe(struct platform_device *pdev)
 	return ret;
 }
=20
-static int irqc_remove(struct platform_device *pdev)
+static void irqc_remove(struct platform_device *pdev)
 {
 	struct irqc_priv *p =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(p->irq_domain);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	return 0;
 }
=20
 static int __maybe_unused irqc_suspend(struct device *dev)
@@ -248,11 +247,11 @@ MODULE_DEVICE_TABLE(of, irqc_dt_ids);
=20
 static struct platform_driver irqc_device_driver =3D {
 	.probe		=3D irqc_probe,
-	.remove		=3D irqc_remove,
+	.remove_new	=3D irqc_remove,
 	.driver		=3D {
-		.name	=3D "renesas_irqc",
+		.name		=3D "renesas_irqc",
 		.of_match_table	=3D irqc_dt_ids,
-		.pm	=3D &irqc_pm_ops,
+		.pm		=3D &irqc_pm_ops,
 	}
 };
=20
diff --git a/drivers/irqchip/irq-renesas-rza1.c b/drivers/irqchip/irq-renesas=
-rza1.c
index e4c99c2e0373..f05afe82db4d 100644
--- a/drivers/irqchip/irq-renesas-rza1.c
+++ b/drivers/irqchip/irq-renesas-rza1.c
@@ -244,12 +244,11 @@ static int rza1_irqc_probe(struct platform_device *pdev)
 	return ret;
 }
=20
-static int rza1_irqc_remove(struct platform_device *pdev)
+static void rza1_irqc_remove(struct platform_device *pdev)
 {
 	struct rza1_irqc_priv *priv =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(priv->irq_domain);
-	return 0;
 }
=20
 static const struct of_device_id rza1_irqc_dt_ids[] =3D {
@@ -260,9 +259,9 @@ MODULE_DEVICE_TABLE(of, rza1_irqc_dt_ids);
=20
 static struct platform_driver rza1_irqc_device_driver =3D {
 	.probe		=3D rza1_irqc_probe,
-	.remove		=3D rza1_irqc_remove,
+	.remove_new	=3D rza1_irqc_remove,
 	.driver		=3D {
-		.name	=3D "renesas_rza1_irqc",
+		.name		=3D "renesas_rza1_irqc",
 		.of_match_table	=3D rza1_irqc_dt_ids,
 	}
 };
diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq=
-starfive-jh8100-intc.c
new file mode 100644
index 000000000000..0f5837176e53
--- /dev/null
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive JH8100 External Interrupt Controller driver
+ *
+ * Copyright (C) 2023 StarFive Technology Co., Ltd.
+ *
+ * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
+ */
+
+#define pr_fmt(fmt) "irq-starfive-jh8100: " fmt
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define STARFIVE_INTC_SRC0_CLEAR	0x10
+#define STARFIVE_INTC_SRC0_MASK		0x14
+#define STARFIVE_INTC_SRC0_INT		0x1c
+
+#define STARFIVE_INTC_SRC_IRQ_NUM	32
+
+struct starfive_irq_chip {
+	void __iomem		*base;
+	struct irq_domain	*domain;
+	raw_spinlock_t		lock;
+};
+
+static void starfive_intc_bit_set(struct starfive_irq_chip *irqc,
+				  u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value =3D ioread32(irqc->base + reg);
+	value |=3D bit_mask;
+	iowrite32(value, irqc->base + reg);
+}
+
+static void starfive_intc_bit_clear(struct starfive_irq_chip *irqc,
+				    u32 reg, u32 bit_mask)
+{
+	u32 value;
+
+	value =3D ioread32(irqc->base + reg);
+	value &=3D ~bit_mask;
+	iowrite32(value, irqc->base + reg);
+}
+
+static void starfive_intc_unmask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc =3D irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&irqc->lock);
+	starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock(&irqc->lock);
+}
+
+static void starfive_intc_mask(struct irq_data *d)
+{
+	struct starfive_irq_chip *irqc =3D irq_data_get_irq_chip_data(d);
+
+	raw_spin_lock(&irqc->lock);
+	starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq));
+	raw_spin_unlock(&irqc->lock);
+}
+
+static struct irq_chip intc_dev =3D {
+	.name		=3D "StarFive JH8100 INTC",
+	.irq_unmask	=3D starfive_intc_unmask,
+	.irq_mask	=3D starfive_intc_mask,
+};
+
+static int starfive_intc_map(struct irq_domain *d, unsigned int irq,
+			     irq_hw_number_t hwirq)
+{
+	irq_domain_set_info(d, irq, hwirq, &intc_dev, d->host_data,
+			    handle_level_irq, NULL, NULL);
+
+	return 0;
+}
+
+static const struct irq_domain_ops starfive_intc_domain_ops =3D {
+	.xlate	=3D irq_domain_xlate_onecell,
+	.map	=3D starfive_intc_map,
+};
+
+static void starfive_intc_irq_handler(struct irq_desc *desc)
+{
+	struct starfive_irq_chip *irqc =3D irq_data_get_irq_handler_data(&desc->irq=
_data);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	unsigned long value;
+	int hwirq;
+
+	chained_irq_enter(chip, desc);
+
+	value =3D ioread32(irqc->base + STARFIVE_INTC_SRC0_INT);
+	while (value) {
+		hwirq =3D ffs(value) - 1;
+
+		generic_handle_domain_irq(irqc->domain, hwirq);
+
+		starfive_intc_bit_set(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
+		starfive_intc_bit_clear(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq));
+
+		__clear_bit(hwirq, &value);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int __init starfive_intc_init(struct device_node *intc,
+				     struct device_node *parent)
+{
+	struct starfive_irq_chip *irqc;
+	struct reset_control *rst;
+	struct clk *clk;
+	int parent_irq;
+	int ret;
+
+	irqc =3D kzalloc(sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	irqc->base =3D of_iomap(intc, 0);
+	if (!irqc->base) {
+		pr_err("Unable to map registers\n");
+		ret =3D -ENXIO;
+		goto err_free;
+	}
+
+	rst =3D of_reset_control_get_exclusive(intc, NULL);
+	if (IS_ERR(rst)) {
+		pr_err("Unable to get reset control %pe\n", rst);
+		ret =3D PTR_ERR(rst);
+		goto err_unmap;
+	}
+
+	clk =3D of_clk_get(intc, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Unable to get clock %pe\n", clk);
+		ret =3D PTR_ERR(clk);
+		goto err_reset_put;
+	}
+
+	ret =3D reset_control_deassert(rst);
+	if (ret)
+		goto err_clk_put;
+
+	ret =3D clk_prepare_enable(clk);
+	if (ret)
+		goto err_reset_assert;
+
+	raw_spin_lock_init(&irqc->lock);
+
+	irqc->domain =3D irq_domain_add_linear(intc, STARFIVE_INTC_SRC_IRQ_NUM,
+					     &starfive_intc_domain_ops, irqc);
+	if (!irqc->domain) {
+		pr_err("Unable to create IRQ domain\n");
+		ret =3D -EINVAL;
+		goto err_clk_disable;
+	}
+
+	parent_irq =3D of_irq_get(intc, 0);
+	if (parent_irq < 0) {
+		pr_err("Failed to get main IRQ: %d\n", parent_irq);
+		ret =3D parent_irq;
+		goto err_remove_domain;
+	}
+
+	irq_set_chained_handler_and_data(parent_irq, starfive_intc_irq_handler,
+					 irqc);
+
+	pr_info("Interrupt controller register, nr_irqs %d\n",
+		STARFIVE_INTC_SRC_IRQ_NUM);
+
+	return 0;
+
+err_remove_domain:
+	irq_domain_remove(irqc->domain);
+err_clk_disable:
+	clk_disable_unprepare(clk);
+err_reset_assert:
+	reset_control_assert(rst);
+err_clk_put:
+	clk_put(clk);
+err_reset_put:
+	reset_control_put(rst);
+err_unmap:
+	iounmap(irqc->base);
+err_free:
+	kfree(irqc);
+	return ret;
+}
+
+IRQCHIP_PLATFORM_DRIVER_BEGIN(starfive_intc)
+IRQCHIP_MATCH("starfive,jh8100-intc", starfive_intc_init)
+IRQCHIP_PLATFORM_DRIVER_END(starfive_intc)
+
+MODULE_DESCRIPTION("StarFive JH8100 External Interrupt Controller");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Changhuang Liang <changhuang.liang@starfivetech.com>");
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index 971240e2e31b..26a5193d0ae4 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -898,10 +898,9 @@ static void stm32_exti_remove_irq(void *data)
 	irq_domain_remove(domain);
 }
=20
-static int stm32_exti_remove(struct platform_device *pdev)
+static void stm32_exti_remove(struct platform_device *pdev)
 {
 	stm32_exti_h_syscore_deinit();
-	return 0;
 }
=20
 static int stm32_exti_probe(struct platform_device *pdev)
@@ -991,10 +990,10 @@ MODULE_DEVICE_TABLE(of, stm32_exti_ids);
=20
 static struct platform_driver stm32_exti_driver =3D {
 	.probe		=3D stm32_exti_probe,
-	.remove		=3D stm32_exti_remove,
+	.remove_new	=3D stm32_exti_remove,
 	.driver		=3D {
-		.name	=3D "stm32_exti",
-		.of_match_table =3D stm32_exti_ids,
+		.name		=3D "stm32_exti",
+		.of_match_table	=3D stm32_exti_ids,
 	},
 };
=20
diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index b2d61d4f6fe6..57f610dab6b8 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -139,13 +139,11 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 	return 0;
 }
=20
-static int ts4800_ic_remove(struct platform_device *pdev)
+static void ts4800_ic_remove(struct platform_device *pdev)
 {
 	struct ts4800_irq_data *data =3D platform_get_drvdata(pdev);
=20
 	irq_domain_remove(data->domain);
-
-	return 0;
 }
=20
 static const struct of_device_id ts4800_ic_of_match[] =3D {
@@ -155,11 +153,11 @@ static const struct of_device_id ts4800_ic_of_match[] =
=3D {
 MODULE_DEVICE_TABLE(of, ts4800_ic_of_match);
=20
 static struct platform_driver ts4800_ic_driver =3D {
-	.probe  =3D ts4800_ic_probe,
-	.remove =3D ts4800_ic_remove,
+	.probe		=3D ts4800_ic_probe,
+	.remove_new	=3D ts4800_ic_remove,
 	.driver =3D {
-		.name =3D "ts4800-irqc",
-		.of_match_table =3D ts4800_ic_of_match,
+		.name		=3D "ts4800-irqc",
+		.of_match_table	=3D ts4800_ic_of_match,
 	},
 };
 module_platform_driver(ts4800_ic_driver);
diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 9e3d5561e04e..ea93e7236c4a 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -47,9 +47,8 @@
=20
 /**
  * struct vic_device - VIC PM device
- * @parent_irq: The parent IRQ number of the VIC if cascaded, or 0.
- * @irq: The IRQ number for the base of the VIC.
  * @base: The register base for the VIC.
+ * @irq: The IRQ number for the base of the VIC.
  * @valid_sources: A bitmask of valid interrupts
  * @resume_sources: A bitmask of interrupts for resume.
  * @resume_irqs: The IRQs enabled for resume.
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..df24c8fb1009 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
=20
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/find.h>
 #include <linux/limits.h>
@@ -127,6 +128,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_=
t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
=20
+DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
+
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
 				 unsigned int nbits, gfp_t flags);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 90081afa10ce..97baa937ab5b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -179,7 +179,7 @@ struct irq_common_data {
 struct irq_data {
 	u32			mask;
 	unsigned int		irq;
-	unsigned long		hwirq;
+	irq_hw_number_t		hwirq;
 	struct irq_common_data	*common;
 	struct irq_chip		*chip;
 	struct irq_domain	*domain;
diff --git a/include/linux/irqhandler.h b/include/linux/irqhandler.h
index c30f454a9518..72dd1eb3a0e7 100644
--- a/include/linux/irqhandler.h
+++ b/include/linux/irqhandler.h
@@ -8,7 +8,7 @@
  */
=20
 struct irq_desc;
-struct irq_data;
+
 typedef	void (*irq_flow_handler_t)(struct irq_desc *desc);
=20
 #endif
diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..38d6ae651ac7 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -4,10 +4,11 @@
  * Copyright (C) 2020 Bartosz Golaszewski <bgolaszewski@baylibre.com>
  */
=20
+#include <linux/cleanup.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_sim.h>
 #include <linux/irq_work.h>
-#include <linux/interrupt.h>
 #include <linux/slab.h>
=20
 struct irq_sim_work_ctx {
@@ -19,7 +20,6 @@ struct irq_sim_work_ctx {
 };
=20
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
 };
@@ -164,33 +164,27 @@ static const struct irq_domain_ops irq_sim_domain_ops =
=3D {
 struct irq_domain *irq_domain_create_sim(struct fwnode_handle *fwnode,
 					 unsigned int num_irqs)
 {
-	struct irq_sim_work_ctx *work_ctx;
+	struct irq_sim_work_ctx *work_ctx __free(kfree) =3D
+				kmalloc(sizeof(*work_ctx), GFP_KERNEL);
=20
-	work_ctx =3D kmalloc(sizeof(*work_ctx), GFP_KERNEL);
 	if (!work_ctx)
-		goto err_out;
+		return ERR_PTR(-ENOMEM);
=20
-	work_ctx->pending =3D bitmap_zalloc(num_irqs, GFP_KERNEL);
-	if (!work_ctx->pending)
-		goto err_free_work_ctx;
+	unsigned long *pending __free(bitmap) =3D bitmap_zalloc(num_irqs, GFP_KERNE=
L);
+	if (!pending)
+		return ERR_PTR(-ENOMEM);
=20
 	work_ctx->domain =3D irq_domain_create_linear(fwnode, num_irqs,
 						    &irq_sim_domain_ops,
 						    work_ctx);
 	if (!work_ctx->domain)
-		goto err_free_bitmap;
+		return ERR_PTR(-ENOMEM);
=20
 	work_ctx->irq_count =3D num_irqs;
 	work_ctx->work =3D IRQ_WORK_INIT_HARD(irq_sim_handle_irq);
+	work_ctx->pending =3D no_free_ptr(pending);
=20
-	return work_ctx->domain;
-
-err_free_bitmap:
-	bitmap_free(work_ctx->pending);
-err_free_work_ctx:
-	kfree(work_ctx);
-err_out:
-	return ERR_PTR(-ENOMEM);
+	return no_free_ptr(work_ctx)->domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_sim);
=20
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 371eb1711d34..4c6b32318ce3 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -92,11 +92,23 @@ static void desc_smp_init(struct irq_desc *desc, int node,
 #endif
 }
=20
+static void free_masks(struct irq_desc *desc)
+{
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+	free_cpumask_var(desc->pending_mask);
+#endif
+	free_cpumask_var(desc->irq_common_data.affinity);
+#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	free_cpumask_var(desc->irq_common_data.effective_affinity);
+#endif
+}
+
 #else
 static inline int
 alloc_masks(struct irq_desc *desc, int node) { return 0; }
 static inline void
 desc_smp_init(struct irq_desc *desc, int node, const struct cpumask *affinit=
y) { }
+static inline void free_masks(struct irq_desc *desc) { }
 #endif
=20
 static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int n=
ode,
@@ -165,6 +177,39 @@ static void delete_irq_desc(unsigned int irq)
 	mas_erase(&mas);
 }
=20
+#ifdef CONFIG_SPARSE_IRQ
+static const struct kobj_type irq_kobj_type;
+#endif
+
+static int init_desc(struct irq_desc *desc, int irq, int node,
+		     unsigned int flags,
+		     const struct cpumask *affinity,
+		     struct module *owner)
+{
+	desc->kstat_irqs =3D alloc_percpu(unsigned int);
+	if (!desc->kstat_irqs)
+		return -ENOMEM;
+
+	if (alloc_masks(desc, node)) {
+		free_percpu(desc->kstat_irqs);
+		return -ENOMEM;
+	}
+
+	raw_spin_lock_init(&desc->lock);
+	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
+	mutex_init(&desc->request_mutex);
+	init_waitqueue_head(&desc->wait_for_threads);
+	desc_set_defaults(irq, desc, node, affinity, owner);
+	irqd_set(&desc->irq_data, flags);
+	irq_resend_init(desc);
+#ifdef CONFIG_SPARSE_IRQ
+	kobject_init(&desc->kobj, &irq_kobj_type);
+	init_rcu_head(&desc->rcu);
+#endif
+
+	return 0;
+}
+
 #ifdef CONFIG_SPARSE_IRQ
=20
 static void irq_kobj_release(struct kobject *kobj);
@@ -384,21 +429,6 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
=20
-#ifdef CONFIG_SMP
-static void free_masks(struct irq_desc *desc)
-{
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-	free_cpumask_var(desc->pending_mask);
-#endif
-	free_cpumask_var(desc->irq_common_data.affinity);
-#ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
-	free_cpumask_var(desc->irq_common_data.effective_affinity);
-#endif
-}
-#else
-static inline void free_masks(struct irq_desc *desc) { }
-#endif
-
 void irq_lock_sparse(void)
 {
 	mutex_lock(&sparse_irq_lock);
@@ -414,36 +444,19 @@ static struct irq_desc *alloc_desc(int irq, int node, u=
nsigned int flags,
 				   struct module *owner)
 {
 	struct irq_desc *desc;
+	int ret;
=20
 	desc =3D kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
 	if (!desc)
 		return NULL;
-	/* allocate based on nr_cpu_ids */
-	desc->kstat_irqs =3D alloc_percpu(unsigned int);
-	if (!desc->kstat_irqs)
-		goto err_desc;
-
-	if (alloc_masks(desc, node))
-		goto err_kstat;
=20
-	raw_spin_lock_init(&desc->lock);
-	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
-	mutex_init(&desc->request_mutex);
-	init_rcu_head(&desc->rcu);
-	init_waitqueue_head(&desc->wait_for_threads);
-
-	desc_set_defaults(irq, desc, node, affinity, owner);
-	irqd_set(&desc->irq_data, flags);
-	kobject_init(&desc->kobj, &irq_kobj_type);
-	irq_resend_init(desc);
+	ret =3D init_desc(desc, irq, node, flags, affinity, owner);
+	if (unlikely(ret)) {
+		kfree(desc);
+		return NULL;
+	}
=20
 	return desc;
-
-err_kstat:
-	free_percpu(desc->kstat_irqs);
-err_desc:
-	kfree(desc);
-	return NULL;
 }
=20
 static void irq_kobj_release(struct kobject *kobj)
@@ -583,26 +596,29 @@ struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_i=
n_smp =3D {
 int __init early_irq_init(void)
 {
 	int count, i, node =3D first_online_node;
-	struct irq_desc *desc;
+	int ret;
=20
 	init_irq_default_affinity();
=20
 	printk(KERN_INFO "NR_IRQS: %d\n", NR_IRQS);
=20
-	desc =3D irq_desc;
 	count =3D ARRAY_SIZE(irq_desc);
=20
 	for (i =3D 0; i < count; i++) {
-		desc[i].kstat_irqs =3D alloc_percpu(unsigned int);
-		alloc_masks(&desc[i], node);
-		raw_spin_lock_init(&desc[i].lock);
-		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
-		mutex_init(&desc[i].request_mutex);
-		init_waitqueue_head(&desc[i].wait_for_threads);
-		desc_set_defaults(i, &desc[i], node, NULL, NULL);
-		irq_resend_init(&desc[i]);
+		ret =3D init_desc(irq_desc + i, i, node, 0, NULL, NULL);
+		if (unlikely(ret))
+			goto __free_desc_res;
 	}
+
 	return arch_early_irq_init();
+
+__free_desc_res:
+	while (--i >=3D 0) {
+		free_masks(irq_desc + i);
+		free_percpu(irq_desc[i].kstat_irqs);
+	}
+
+	return ret;
 }
=20
 struct irq_desc *irq_to_desc(unsigned int irq)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1782f90cd8c6..ad3eaf2ab959 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -192,10 +192,14 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 	struct irqaction *action;
=20
 	for_each_action_of_desc(desc, action) {
-		if (action->thread)
+		if (action->thread) {
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
-		if (action->secondary && action->secondary->thread)
+			wake_up_process(action->thread);
+		}
+		if (action->secondary && action->secondary->thread) {
 			set_bit(IRQTF_AFFINITY, &action->secondary->thread_flags);
+			wake_up_process(action->secondary->thread);
+		}
 	}
 }
=20
@@ -1049,10 +1053,57 @@ static irqreturn_t irq_forced_secondary_handler(int i=
rq, void *dev_id)
 	return IRQ_NONE;
 }
=20
-static int irq_wait_for_interrupt(struct irqaction *action)
+#ifdef CONFIG_SMP
+/*
+ * Check whether we need to change the affinity of the interrupt thread.
+ */
+static void irq_thread_check_affinity(struct irq_desc *desc, struct irqactio=
n *action)
+{
+	cpumask_var_t mask;
+	bool valid =3D false;
+
+	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
+		return;
+
+	__set_current_state(TASK_RUNNING);
+
+	/*
+	 * In case we are out of memory we set IRQTF_AFFINITY again and
+	 * try again next time
+	 */
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
+		set_bit(IRQTF_AFFINITY, &action->thread_flags);
+		return;
+	}
+
+	raw_spin_lock_irq(&desc->lock);
+	/*
+	 * This code is triggered unconditionally. Check the affinity
+	 * mask pointer. For CPU_MASK_OFFSTACK=3Dn this is optimized out.
+	 */
+	if (cpumask_available(desc->irq_common_data.affinity)) {
+		const struct cpumask *m;
+
+		m =3D irq_data_get_effective_affinity_mask(&desc->irq_data);
+		cpumask_copy(mask, m);
+		valid =3D true;
+	}
+	raw_spin_unlock_irq(&desc->lock);
+
+	if (valid)
+		set_cpus_allowed_ptr(current, mask);
+	free_cpumask_var(mask);
+}
+#else
+static inline void irq_thread_check_affinity(struct irq_desc *desc, struct i=
rqaction *action) { }
+#endif
+
+static int irq_wait_for_interrupt(struct irq_desc *desc,
+				  struct irqaction *action)
 {
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
+		irq_thread_check_affinity(desc, action);
=20
 		if (kthread_should_stop()) {
 			/* may need to run one last time */
@@ -1129,52 +1180,6 @@ static void irq_finalize_oneshot(struct irq_desc *desc,
 	chip_bus_sync_unlock(desc);
 }
=20
-#ifdef CONFIG_SMP
-/*
- * Check whether we need to change the affinity of the interrupt thread.
- */
-static void
-irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action)
-{
-	cpumask_var_t mask;
-	bool valid =3D true;
-
-	if (!test_and_clear_bit(IRQTF_AFFINITY, &action->thread_flags))
-		return;
-
-	/*
-	 * In case we are out of memory we set IRQTF_AFFINITY again and
-	 * try again next time
-	 */
-	if (!alloc_cpumask_var(&mask, GFP_KERNEL)) {
-		set_bit(IRQTF_AFFINITY, &action->thread_flags);
-		return;
-	}
-
-	raw_spin_lock_irq(&desc->lock);
-	/*
-	 * This code is triggered unconditionally. Check the affinity
-	 * mask pointer. For CPU_MASK_OFFSTACK=3Dn this is optimized out.
-	 */
-	if (cpumask_available(desc->irq_common_data.affinity)) {
-		const struct cpumask *m;
-
-		m =3D irq_data_get_effective_affinity_mask(&desc->irq_data);
-		cpumask_copy(mask, m);
-	} else {
-		valid =3D false;
-	}
-	raw_spin_unlock_irq(&desc->lock);
-
-	if (valid)
-		set_cpus_allowed_ptr(current, mask);
-	free_cpumask_var(mask);
-}
-#else
-static inline void
-irq_thread_check_affinity(struct irq_desc *desc, struct irqaction *action) {=
 }
-#endif
-
 /*
  * Interrupts which are not explicitly requested as threaded
  * interrupts rely on the implicit bh/preempt disable of the hard irq
@@ -1312,13 +1317,9 @@ static int irq_thread(void *data)
 	init_task_work(&on_exit_work, irq_thread_dtor);
 	task_work_add(current, &on_exit_work, TWA_NONE);
=20
-	irq_thread_check_affinity(desc, action);
-
-	while (!irq_wait_for_interrupt(action)) {
+	while (!irq_wait_for_interrupt(desc, action)) {
 		irqreturn_t action_ret;
=20
-		irq_thread_check_affinity(desc, action);
-
 		action_ret =3D handler_fn(desc, action);
 		if (action_ret =3D=3D IRQ_WAKE_THREAD)
 			irq_wake_secondary(desc, action);


