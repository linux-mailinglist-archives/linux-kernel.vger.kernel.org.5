Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE33E7BFB01
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjJJMQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjJJMQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:16:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE8794
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 05:16:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696940189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMueRaEKS4wvwUzkM8DHW27KUkLQ0Zwz6tpOPP9EnGs=;
        b=DUvA8YCIjtkQojLwl0JM0iuKKMb21fS6JJyQzLZ5n47CuQ+gQe2GoOQTnwsPSPWAOfxFoG
        TdVEyWnxBtIHM+AB+WyDRtvePLkWkzTtJ8vWE4YPixiqloo+6CkOsnOL3B+qW8zNc4Fsxa
        42xyPGoRoXDSvXIU+FmhLswBG/2xUchDSI4cqWyZhwMVu6lPlQCBnD4zw0Odoom/Fxb/L2
        tBnoSQe2pw/+epZkL36f7zpCGsHTZ8B7wBA1Vx2p5/QLkFs5oQ6QWfHb3E+dpmMMypshOe
        +YoiBpWz01upR+0JPzaWg/5gdLly5xADretipI+rhM8fCnG61p/Uy6JPnUfMQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696940189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TMueRaEKS4wvwUzkM8DHW27KUkLQ0Zwz6tpOPP9EnGs=;
        b=JylfcAVo0lgYUqIoPf12IPRFotVG8lATbSqlbUB6RGmyggvIa98HdynRdNJ/0ZYVKnCLJK
        bbv92UMd8MOPWbDQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, maz@kernel.org
Subject: [GIT pull] irq/urgent for v6.6-rc6
Message-ID: <169694008423.592696.537997109199439608.tglx@xen13.lab.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Tue, 10 Oct 2023 14:16:29 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2023-=
10-10-v2

up to:  4dc5af1fee55: Merge tag 'irqchip-fixes-6.6-2' of git://git.kernel.org=
/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent


A set of updates for interrupt chip drivers:

  - Fix the fail of the Qualcomm PDC driver on v3.2 hardware which is
    caused by a control bit being moved to a different location

  - Update the SM8150 device tree PDC resource so the version register can
    be read

  - Make the Renesas RZG2L driver correct for interrupts which are outside
    of the LSB in the TSSR register by using the proper macro for
    calculating the mask

  - Document the Renesas RZ2GL device tree binding correctly and update
    them for a few devices which faul to boot otherwise

  - Use the proper accessor in the RZ2GL driver instead of blindly
    dereferencing an unchecked pointer

  - Make GICv3 handle the dma-non-coherent attribute correctly

  - Ensure that all interrupt controller nodes on RISCV are marked as
    initialized correctly

Maintainer changes:

  - Add a new entry for GIC interrupt controllers and assign Marc Zyngier
    as the maintainer

  - Remove Marc Zyngier from the core and driver maintainer entries as he
    is burried in work and short of time to handle that.

    Thanks to Marc for all the great work he has done in the past couple of
    years!


Note:

5873d380f4c0 ("irqchip/qcom-pdc: Add support for v3.2 HW") has a incorrect
SOB chain.

The real author is Neil. His patch was posted by Dmitry once and Neil
picked it up from the list and reposted it with the bogus SOB chain.

Not a big deal, but worth to mention. I wanted to fix that up, but then got
distracted and Marc piled more changes on top. So I decided to leave it as
is instead of rebasing world.

Let me know if you want the fixup and rebase nevertheless.

Thanks,

	tglx

------------------>
Anup Patel (1):
      irqchip/riscv-intc: Mark all INTC nodes as initialized

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Biju Das (1):
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Dmitry Baryshkov (1):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource

Geert Uytterhoeven (2):
      dt-bindings: interrupt-controller: renesas,irqc: Add r8a779f0 support
      irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()

Lad Prabhakar (2):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update descripti=
on for '#interrupt-cells' property
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2UL=
 SoC

Lorenzo Pieralisi (2):
      dt-bindings: interrupt-controller: arm,gic-v3: Add dma-noncoherent prop=
erty
      irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing

Marc Zyngier (3):
      irqchip/gic-v3-its: Split allocation from initialisation of its_node
      MAINTAINERS: Add myself as the ARM GIC maintainer
      MAINTAINERS: Remove myself from the general IRQ subsystem maintenance

Neil Armstrong (1):
      irqchip/qcom-pdc: Add support for v3.2 HW


 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  12 ++
 .../interrupt-controller/renesas,irqc.yaml         |   1 +
 .../interrupt-controller/renesas,rzg2l-irqc.yaml   | 230 ++++++++++++++++---=
--
 MAINTAINERS                                        |  14 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   2 +-
 drivers/irqchip/irq-gic-common.h                   |   4 +
 drivers/irqchip/irq-gic-v3-its.c                   | 170 +++++++++------
 drivers/irqchip/irq-gic-v3.c                       |  13 ++
 drivers/irqchip/irq-renesas-rzg2l.c                |   4 +-
 drivers/irqchip/irq-riscv-intc.c                   |  10 +-
 drivers/irqchip/irq-stm32-exti.c                   |   1 +
 drivers/irqchip/qcom-pdc.c                         |  69 +++++--
 12 files changed, 385 insertions(+), 145 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v=
3.yaml b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.ya=
ml
index 2bc38479a41e..0f4a062c9d6f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
@@ -106,6 +106,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 4096
=20
+  dma-noncoherent:
+    description:
+      Present if the GIC redistributors permit programming shareability
+      and cacheability attributes but are connected to a non-coherent
+      downstream interconnect.
+
   msi-controller:
     description:
       Only present if the Message Based Interrupt functionality is
@@ -193,6 +199,12 @@ patternProperties:
       compatible:
         const: arm,gic-v3-its
=20
+      dma-noncoherent:
+        description:
+          Present if the GIC ITS permits programming shareability and
+          cacheability attributes but is connected to a non-coherent
+          downstream interconnect.
+
       msi-controller: true
=20
       "#msi-cells":
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,i=
rqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irq=
c.yaml
index 95033cb514fb..b417341fc8ae 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -37,6 +37,7 @@ properties:
           - renesas,intc-ex-r8a77990    # R-Car E3
           - renesas,intc-ex-r8a77995    # R-Car D3
           - renesas,intc-ex-r8a779a0    # R-Car V3U
+          - renesas,intc-ex-r8a779f0    # R-Car S4-8
           - renesas,intc-ex-r8a779g0    # R-Car V4H
       - const: renesas,irqc
=20
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,r=
zg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renes=
as,rzg2l-irqc.yaml
index 33b90e975e33..2ef3081eaaf3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-ir=
qc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rzg2l-ir=
qc.yaml
@@ -19,20 +19,19 @@ description: |
     - NMI edge select (NMI is not treated as NMI exception and supports fall=
 edge and
       stand-up edge detection interrupts)
=20
-allOf:
-  - $ref: /schemas/interrupt-controller.yaml#
-
 properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043u-irqc   # RZ/G2UL
           - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
           - renesas,r9a07g054-irqc    # RZ/V2L
       - const: renesas,rzg2l-irqc
=20
   '#interrupt-cells':
-    description: The first cell should contain external interrupt number (IR=
Q0-7) and the
-                 second cell is used to specify the flag.
+    description: The first cell should contain a macro RZG2L_{NMI,IRQX} incl=
uded in the
+                 include/dt-bindings/interrupt-controller/irqc-rzg2l.h and t=
he second
+                 cell is used to specify the flag.
     const: 2
=20
   '#address-cells':
@@ -44,7 +43,96 @@ properties:
     maxItems: 1
=20
   interrupts:
-    maxItems: 41
+    minItems: 41
+    items:
+      - description: NMI interrupt
+      - description: IRQ0 interrupt
+      - description: IRQ1 interrupt
+      - description: IRQ2 interrupt
+      - description: IRQ3 interrupt
+      - description: IRQ4 interrupt
+      - description: IRQ5 interrupt
+      - description: IRQ6 interrupt
+      - description: IRQ7 interrupt
+      - description: GPIO interrupt, TINT0
+      - description: GPIO interrupt, TINT1
+      - description: GPIO interrupt, TINT2
+      - description: GPIO interrupt, TINT3
+      - description: GPIO interrupt, TINT4
+      - description: GPIO interrupt, TINT5
+      - description: GPIO interrupt, TINT6
+      - description: GPIO interrupt, TINT7
+      - description: GPIO interrupt, TINT8
+      - description: GPIO interrupt, TINT9
+      - description: GPIO interrupt, TINT10
+      - description: GPIO interrupt, TINT11
+      - description: GPIO interrupt, TINT12
+      - description: GPIO interrupt, TINT13
+      - description: GPIO interrupt, TINT14
+      - description: GPIO interrupt, TINT15
+      - description: GPIO interrupt, TINT16
+      - description: GPIO interrupt, TINT17
+      - description: GPIO interrupt, TINT18
+      - description: GPIO interrupt, TINT19
+      - description: GPIO interrupt, TINT20
+      - description: GPIO interrupt, TINT21
+      - description: GPIO interrupt, TINT22
+      - description: GPIO interrupt, TINT23
+      - description: GPIO interrupt, TINT24
+      - description: GPIO interrupt, TINT25
+      - description: GPIO interrupt, TINT26
+      - description: GPIO interrupt, TINT27
+      - description: GPIO interrupt, TINT28
+      - description: GPIO interrupt, TINT29
+      - description: GPIO interrupt, TINT30
+      - description: GPIO interrupt, TINT31
+      - description: Bus error interrupt
+
+  interrupt-names:
+    minItems: 41
+    items:
+      - const: nmi
+      - const: irq0
+      - const: irq1
+      - const: irq2
+      - const: irq3
+      - const: irq4
+      - const: irq5
+      - const: irq6
+      - const: irq7
+      - const: tint0
+      - const: tint1
+      - const: tint2
+      - const: tint3
+      - const: tint4
+      - const: tint5
+      - const: tint6
+      - const: tint7
+      - const: tint8
+      - const: tint9
+      - const: tint10
+      - const: tint11
+      - const: tint12
+      - const: tint13
+      - const: tint14
+      - const: tint15
+      - const: tint16
+      - const: tint17
+      - const: tint18
+      - const: tint19
+      - const: tint20
+      - const: tint21
+      - const: tint22
+      - const: tint23
+      - const: tint24
+      - const: tint25
+      - const: tint26
+      - const: tint27
+      - const: tint28
+      - const: tint29
+      - const: tint30
+      - const: tint31
+      - const: bus-err
=20
   clocks:
     maxItems: 2
@@ -72,6 +160,23 @@ required:
   - power-domains
   - resets
=20
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043u-irqc
+    then:
+      properties:
+        interrupts:
+          minItems: 42
+        interrupt-names:
+          minItems: 42
+      required:
+        - interrupt-names
+
 unevaluatedProperties: false
=20
 examples:
@@ -80,55 +185,66 @@ examples:
     #include <dt-bindings/clock/r9a07g044-cpg.h>
=20
     irqc: interrupt-controller@110a0000 {
-            compatible =3D "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
-            reg =3D <0x110a0000 0x10000>;
-            #interrupt-cells =3D <2>;
-            #address-cells =3D <0>;
-            interrupt-controller;
-            interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
-            clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
-                     <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
-            clock-names =3D "clk", "pclk";
-            power-domains =3D <&cpg>;
-            resets =3D <&cpg R9A07G044_IA55_RESETN>;
+        compatible =3D "renesas,r9a07g044-irqc", "renesas,rzg2l-irqc";
+        reg =3D <0x110a0000 0x10000>;
+        #interrupt-cells =3D <2>;
+        #address-cells =3D <0>;
+        interrupt-controller;
+        interrupts =3D <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 472 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 473 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 474 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 475 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names =3D "nmi",
+                          "irq0", "irq1", "irq2", "irq3",
+                          "irq4", "irq5", "irq6", "irq7",
+                          "tint0", "tint1", "tint2", "tint3",
+                          "tint4", "tint5", "tint6", "tint7",
+                          "tint8", "tint9", "tint10", "tint11",
+                          "tint12", "tint13", "tint14", "tint15",
+                          "tint16", "tint17", "tint18", "tint19",
+                          "tint20", "tint21", "tint22", "tint23",
+                          "tint24", "tint25", "tint26", "tint27",
+                          "tint28", "tint29", "tint30", "tint31";
+        clocks =3D <&cpg CPG_MOD R9A07G044_IA55_CLK>,
+                 <&cpg CPG_MOD R9A07G044_IA55_PCLK>;
+        clock-names =3D "clk", "pclk";
+        power-domains =3D <&cpg>;
+        resets =3D <&cpg R9A07G044_IA55_RESETN>;
     };
diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..f2bc21ae2562 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1585,6 +1585,17 @@ F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
=20
+ARM GENERIC INTERRUPT CONTROLLER DRIVERS
+M:	Marc Zyngier <maz@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/arm,gic*
+F:	arch/arm/include/asm/arch_gicv3.h
+F:	arch/arm64/include/asm/arch_gicv3.h
+F:	drivers/irqchip/irq-gic*.[ch]
+F:	include/linux/irqchip/arm-gic*.h
+F:	include/linux/irqchip/arm-vgic-info.h
+
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
@@ -11064,7 +11075,7 @@ F:	Documentation/devicetree/bindings/sound/irondevice=
,*
 F:	sound/soc/codecs/sma*
=20
 IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
-M:	Marc Zyngier <maz@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
@@ -11083,7 +11094,6 @@ F:	lib/group_cpus.c
=20
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	Marc Zyngier <maz@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/=
sm8150.dtsi
index a7c3020a5de4..06c53000bb74 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -3958,7 +3958,7 @@ dispcc: clock-controller@af00000 {
=20
 		pdc: interrupt-controller@b220000 {
 			compatible =3D "qcom,sm8150-pdc", "qcom,pdc";
-			reg =3D <0 0x0b220000 0 0x400>;
+			reg =3D <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges =3D <0 480 94>, <94 609 31>,
 					  <125 63 1>;
 			#interrupt-cells =3D <2>;
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-commo=
n.h
index 3db4592cda1c..f407cce9ecaa 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -29,4 +29,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *qu=
irks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
=20
+#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
+#define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
+#define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
+
 #endif /* _IRQ_GIC_COMMON_H */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index e0c2b10d154d..75a2dd550625 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -44,10 +44,6 @@
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 #define ITS_FLAGS_FORCE_NON_SHAREABLE		(1ULL << 3)
=20
-#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
-#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
-#define RDIST_FLAGS_FORCE_NON_SHAREABLE		(1 << 2)
-
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
 #define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
 #define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
@@ -4754,6 +4750,14 @@ static bool __maybe_unused its_enable_rk3588001(void *=
data)
 	return true;
 }
=20
+static bool its_set_non_coherent(void *data)
+{
+	struct its_node *its =3D data;
+
+	its->flags |=3D ITS_FLAGS_FORCE_NON_SHAREABLE;
+	return true;
+}
+
 static const struct gic_quirk its_quirks[] =3D {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -4808,6 +4812,11 @@ static const struct gic_quirk its_quirks[] =3D {
 		.init   =3D its_enable_rk3588001,
 	},
 #endif
+	{
+		.desc   =3D "ITS: non-coherent attribute",
+		.property =3D "dma-noncoherent",
+		.init   =3D its_set_non_coherent,
+	},
 	{
 	}
 };
@@ -4817,6 +4826,10 @@ static void its_enable_quirks(struct its_node *its)
 	u32 iidr =3D readl_relaxed(its->base + GITS_IIDR);
=20
 	gic_enable_quirks(iidr, its_quirks, its);
+
+	if (is_of_node(its->fwnode_handle))
+		gic_enable_of_quirks(to_of_node(its->fwnode_handle),
+				     its_quirks, its);
 }
=20
 static int its_save_disable(void)
@@ -4952,7 +4965,7 @@ static void __init __iomem *its_map_one(struct resource=
 *res, int *err)
 	return NULL;
 }
=20
-static int its_init_domain(struct fwnode_handle *handle, struct its_node *it=
s)
+static int its_init_domain(struct its_node *its)
 {
 	struct irq_domain *inner_domain;
 	struct msi_domain_info *info;
@@ -4966,7 +4979,7 @@ static int its_init_domain(struct fwnode_handle *handle=
, struct its_node *its)
=20
 	inner_domain =3D irq_domain_create_hierarchy(its_parent,
 						   its->msi_domain_flags, 0,
-						   handle, &its_domain_ops,
+						   its->fwnode_handle, &its_domain_ops,
 						   info);
 	if (!inner_domain) {
 		kfree(info);
@@ -5017,8 +5030,7 @@ static int its_init_vpe_domain(void)
 	return 0;
 }
=20
-static int __init its_compute_its_list_map(struct resource *res,
-					   void __iomem *its_base)
+static int __init its_compute_its_list_map(struct its_node *its)
 {
 	int its_number;
 	u32 ctlr;
@@ -5032,15 +5044,15 @@ static int __init its_compute_its_list_map(struct res=
ource *res,
 	its_number =3D find_first_zero_bit(&its_list_map, GICv4_ITS_LIST_MAX);
 	if (its_number >=3D GICv4_ITS_LIST_MAX) {
 		pr_err("ITS@%pa: No ITSList entry available!\n",
-		       &res->start);
+		       &its->phys_base);
 		return -EINVAL;
 	}
=20
-	ctlr =3D readl_relaxed(its_base + GITS_CTLR);
+	ctlr =3D readl_relaxed(its->base + GITS_CTLR);
 	ctlr &=3D ~GITS_CTLR_ITS_NUMBER;
 	ctlr |=3D its_number << GITS_CTLR_ITS_NUMBER_SHIFT;
-	writel_relaxed(ctlr, its_base + GITS_CTLR);
-	ctlr =3D readl_relaxed(its_base + GITS_CTLR);
+	writel_relaxed(ctlr, its->base + GITS_CTLR);
+	ctlr =3D readl_relaxed(its->base + GITS_CTLR);
 	if ((ctlr & GITS_CTLR_ITS_NUMBER) !=3D (its_number << GITS_CTLR_ITS_NUMBER_=
SHIFT)) {
 		its_number =3D ctlr & GITS_CTLR_ITS_NUMBER;
 		its_number >>=3D GITS_CTLR_ITS_NUMBER_SHIFT;
@@ -5048,75 +5060,50 @@ static int __init its_compute_its_list_map(struct res=
ource *res,
=20
 	if (test_and_set_bit(its_number, &its_list_map)) {
 		pr_err("ITS@%pa: Duplicate ITSList entry %d\n",
-		       &res->start, its_number);
+		       &its->phys_base, its_number);
 		return -EINVAL;
 	}
=20
 	return its_number;
 }
=20
-static int __init its_probe_one(struct resource *res,
-				struct fwnode_handle *handle, int numa_node)
+static int __init its_probe_one(struct its_node *its)
 {
-	struct its_node *its;
-	void __iomem *its_base;
-	u64 baser, tmp, typer;
+	u64 baser, tmp;
 	struct page *page;
 	u32 ctlr;
 	int err;
=20
-	its_base =3D its_map_one(res, &err);
-	if (!its_base)
-		return err;
-
-	pr_info("ITS %pR\n", res);
-
-	its =3D kzalloc(sizeof(*its), GFP_KERNEL);
-	if (!its) {
-		err =3D -ENOMEM;
-		goto out_unmap;
-	}
-
-	raw_spin_lock_init(&its->lock);
-	mutex_init(&its->dev_alloc_lock);
-	INIT_LIST_HEAD(&its->entry);
-	INIT_LIST_HEAD(&its->its_device_list);
-	typer =3D gic_read_typer(its_base + GITS_TYPER);
-	its->typer =3D typer;
-	its->base =3D its_base;
-	its->phys_base =3D res->start;
 	if (is_v4(its)) {
-		if (!(typer & GITS_TYPER_VMOVP)) {
-			err =3D its_compute_its_list_map(res, its_base);
+		if (!(its->typer & GITS_TYPER_VMOVP)) {
+			err =3D its_compute_its_list_map(its);
 			if (err < 0)
-				goto out_free_its;
+				goto out;
=20
 			its->list_nr =3D err;
=20
 			pr_info("ITS@%pa: Using ITS number %d\n",
-				&res->start, err);
+				&its->phys_base, err);
 		} else {
-			pr_info("ITS@%pa: Single VMOVP capable\n", &res->start);
+			pr_info("ITS@%pa: Single VMOVP capable\n", &its->phys_base);
 		}
=20
 		if (is_v4_1(its)) {
-			u32 svpet =3D FIELD_GET(GITS_TYPER_SVPET, typer);
+			u32 svpet =3D FIELD_GET(GITS_TYPER_SVPET, its->typer);
=20
-			its->sgir_base =3D ioremap(res->start + SZ_128K, SZ_64K);
+			its->sgir_base =3D ioremap(its->phys_base + SZ_128K, SZ_64K);
 			if (!its->sgir_base) {
 				err =3D -ENOMEM;
-				goto out_free_its;
+				goto out;
 			}
=20
-			its->mpidr =3D readl_relaxed(its_base + GITS_MPIDR);
+			its->mpidr =3D readl_relaxed(its->base + GITS_MPIDR);
=20
 			pr_info("ITS@%pa: Using GICv4.1 mode %08x %08x\n",
-				&res->start, its->mpidr, svpet);
+				&its->phys_base, its->mpidr, svpet);
 		}
 	}
=20
-	its->numa_node =3D numa_node;
-
 	page =3D alloc_pages_node(its->numa_node, GFP_KERNEL | __GFP_ZERO,
 				get_order(ITS_CMD_QUEUE_SZ));
 	if (!page) {
@@ -5125,12 +5112,9 @@ static int __init its_probe_one(struct resource *res,
 	}
 	its->cmd_base =3D (void *)page_address(page);
 	its->cmd_write =3D its->cmd_base;
-	its->fwnode_handle =3D handle;
 	its->get_msi_base =3D its_irq_get_msi_base;
 	its->msi_domain_flags =3D IRQ_DOMAIN_FLAG_ISOLATED_MSI;
=20
-	its_enable_quirks(its);
-
 	err =3D its_alloc_tables(its);
 	if (err)
 		goto out_free_cmd;
@@ -5174,7 +5158,7 @@ static int __init its_probe_one(struct resource *res,
 		ctlr |=3D GITS_CTLR_ImDe;
 	writel_relaxed(ctlr, its->base + GITS_CTLR);
=20
-	err =3D its_init_domain(handle, its);
+	err =3D its_init_domain(its);
 	if (err)
 		goto out_free_tables;
=20
@@ -5191,11 +5175,8 @@ static int __init its_probe_one(struct resource *res,
 out_unmap_sgir:
 	if (its->sgir_base)
 		iounmap(its->sgir_base);
-out_free_its:
-	kfree(its);
-out_unmap:
-	iounmap(its_base);
-	pr_err("ITS@%pa: failed probing (%d)\n", &res->start, err);
+out:
+	pr_err("ITS@%pa: failed probing (%d)\n", &its->phys_base, err);
 	return err;
 }
=20
@@ -5356,10 +5337,53 @@ static const struct of_device_id its_device_id[] =3D {
 	{},
 };
=20
+static struct its_node __init *its_node_init(struct resource *res,
+					     struct fwnode_handle *handle, int numa_node)
+{
+	void __iomem *its_base;
+	struct its_node *its;
+	int err;
+
+	its_base =3D its_map_one(res, &err);
+	if (!its_base)
+		return NULL;
+
+	pr_info("ITS %pR\n", res);
+
+	its =3D kzalloc(sizeof(*its), GFP_KERNEL);
+	if (!its)
+		goto out_unmap;
+
+	raw_spin_lock_init(&its->lock);
+	mutex_init(&its->dev_alloc_lock);
+	INIT_LIST_HEAD(&its->entry);
+	INIT_LIST_HEAD(&its->its_device_list);
+
+	its->typer =3D gic_read_typer(its_base + GITS_TYPER);
+	its->base =3D its_base;
+	its->phys_base =3D res->start;
+
+	its->numa_node =3D numa_node;
+	its->fwnode_handle =3D handle;
+
+	return its;
+
+out_unmap:
+	iounmap(its_base);
+	return NULL;
+}
+
+static void its_node_destroy(struct its_node *its)
+{
+	iounmap(its->base);
+	kfree(its);
+}
+
 static int __init its_of_probe(struct device_node *node)
 {
 	struct device_node *np;
 	struct resource res;
+	int err;
=20
 	/*
 	 * Make sure *all* the ITS are reset before we probe any, as
@@ -5369,8 +5393,6 @@ static int __init its_of_probe(struct device_node *node)
 	 */
 	for (np =3D of_find_matching_node(node, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
-		int err;
-
 		if (!of_device_is_available(np) ||
 		    !of_property_read_bool(np, "msi-controller") ||
 		    of_address_to_resource(np, 0, &res))
@@ -5383,6 +5405,8 @@ static int __init its_of_probe(struct device_node *node)
=20
 	for (np =3D of_find_matching_node(node, its_device_id); np;
 	     np =3D of_find_matching_node(np, its_device_id)) {
+		struct its_node *its;
+
 		if (!of_device_is_available(np))
 			continue;
 		if (!of_property_read_bool(np, "msi-controller")) {
@@ -5396,7 +5420,17 @@ static int __init its_of_probe(struct device_node *nod=
e)
 			continue;
 		}
=20
-		its_probe_one(&res, &np->fwnode, of_node_to_nid(np));
+
+		its =3D its_node_init(&res, &np->fwnode, of_node_to_nid(np));
+		if (!its)
+			return -ENOMEM;
+
+		its_enable_quirks(its);
+		err =3D its_probe_one(its);
+		if (err)  {
+			its_node_destroy(its);
+			return err;
+		}
 	}
 	return 0;
 }
@@ -5508,6 +5542,7 @@ static int __init gic_acpi_parse_madt_its(union acpi_su=
btable_headers *header,
 {
 	struct acpi_madt_generic_translator *its_entry;
 	struct fwnode_handle *dom_handle;
+	struct its_node *its;
 	struct resource res;
 	int err;
=20
@@ -5532,11 +5567,18 @@ static int __init gic_acpi_parse_madt_its(union acpi_=
subtable_headers *header,
 		goto dom_err;
 	}
=20
-	err =3D its_probe_one(&res, dom_handle,
-			acpi_get_its_numa_node(its_entry->translation_id));
+	its =3D its_node_init(&res, dom_handle,
+			    acpi_get_its_numa_node(its_entry->translation_id));
+	if (!its) {
+		err =3D -ENOMEM;
+		goto node_err;
+	}
+
+	err =3D its_probe_one(its);
 	if (!err)
 		return 0;
=20
+node_err:
 	iort_deregister_domain_token(its_entry->translation_id);
 dom_err:
 	irq_domain_free_fwnode(dom_handle);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eedfa8e9f077..f59ac9586b7b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1857,6 +1857,14 @@ static bool gic_enable_quirk_arm64_2941627(void *data)
 	return true;
 }
=20
+static bool rd_set_non_coherent(void *data)
+{
+	struct gic_chip_data *d =3D data;
+
+	d->rdists.flags |=3D RDIST_FLAGS_FORCE_NON_SHAREABLE;
+	return true;
+}
+
 static const struct gic_quirk gic_quirks[] =3D {
 	{
 		.desc	=3D "GICv3: Qualcomm MSM8996 broken firmware",
@@ -1923,6 +1931,11 @@ static const struct gic_quirk gic_quirks[] =3D {
 		.mask	=3D 0xff0f0fff,
 		.init	=3D gic_enable_quirk_arm64_2941627,
 	},
+	{
+		.desc   =3D "GICv3: non-coherent attribute",
+		.property =3D "dma-noncoherent",
+		.init   =3D rd_set_non_coherent,
+	},
 	{
 	}
 };
diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 4bbfa2b0a4df..96f4e322ed6b 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -118,7 +118,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
=20
 		raw_spin_lock(&priv->lock);
 		reg =3D readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &=3D ~(TSSEL_MASK << tssr_offset);
+		reg &=3D ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -130,8 +130,8 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq =3D irqd_to_hwirq(d);
=20
 	if (hw_irq >=3D IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		unsigned long tint =3D (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv =3D irq_data_to_priv(d);
-		unsigned long tint =3D (uintptr_t)d->chip_data;
 		u32 offset =3D hw_irq - IRQC_TINT_START;
 		u32 tssr_offset =3D TSSR_OFFSET(offset);
 		u8 tssr_index =3D TSSR_INDEX(offset);
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-int=
c.c
index 4adeee1bc391..e8d01b14ccdd 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_node *no=
de,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as PLIC, IMSIC and APLIC
+		 * direct-mode) so we should mark an INTC node as initialized
+		 * if we are not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
=20
 	return riscv_intc_init_common(of_node_to_fwnode(node));
 }
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-ext=
i.c
index d8ba5fba7450..971240e2e31b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -460,6 +460,7 @@ static const struct irq_domain_ops irq_exti_domain_ops =
=3D {
 	.map	=3D irq_map_generic_chip,
 	.alloc  =3D stm32_exti_alloc,
 	.free	=3D stm32_exti_free,
+	.xlate	=3D irq_domain_xlate_twocell,
 };
=20
 static void stm32_irq_ack(struct irq_data *d)
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index a32c0d28d038..74b2f124116e 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -22,9 +22,20 @@
=20
 #define PDC_MAX_GPIO_IRQS	256
=20
+/* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
=20
+/* Valid only on HW version >=3D 3.2 */
+#define IRQ_i_CFG_IRQ_ENABLE	3
+
+#define IRQ_i_CFG_TYPE_MASK	GENMASK(2, 0)
+
+#define PDC_VERSION_REG		0x1000
+
+/* Notable PDC versions */
+#define PDC_VERSION_3_2		0x30200
+
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
@@ -37,6 +48,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
=20
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -48,20 +60,32 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
=20
-static void pdc_enable_intr(struct irq_data *d, bool on)
+static void __pdc_enable_intr(int pin_out, bool on)
 {
-	int pin_out =3D d->hwirq;
 	unsigned long enable;
-	unsigned long flags;
-	u32 index, mask;
=20
-	index =3D pin_out / 32;
-	mask =3D pin_out % 32;
+	if (pdc_version < PDC_VERSION_3_2) {
+		u32 index, mask;
+
+		index =3D pin_out / 32;
+		mask =3D pin_out % 32;
+
+		enable =3D pdc_reg_read(IRQ_ENABLE_BANK, index);
+		__assign_bit(mask, &enable, on);
+		pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	} else {
+		enable =3D pdc_reg_read(IRQ_i_CFG, pin_out);
+		__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
+		pdc_reg_write(IRQ_i_CFG, pin_out, enable);
+	}
+}
+
+static void pdc_enable_intr(struct irq_data *d, bool on)
+{
+	unsigned long flags;
=20
 	raw_spin_lock_irqsave(&pdc_lock, flags);
-	enable =3D pdc_reg_read(IRQ_ENABLE_BANK, index);
-	__assign_bit(mask, &enable, on);
-	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	__pdc_enable_intr(d->hwirq, on);
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
=20
@@ -142,6 +166,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsi=
gned int type)
 	}
=20
 	old_pdc_type =3D pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |=3D (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
=20
 	ret =3D irq_chip_set_type_parent(d, type);
@@ -246,7 +271,6 @@ static const struct irq_domain_ops qcom_pdc_ops =3D {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
=20
 	n =3D of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <=3D 0 || n % 3)
@@ -276,29 +300,38 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 		if (ret)
 			return ret;
=20
-		for (i =3D 0; i < pdc_region[n].cnt; i++) {
-			reg_index =3D (i + pdc_region[n].pin_base) >> 5;
-			irq_index =3D (i + pdc_region[n].pin_base) & 0x1f;
-			val =3D pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
-			val &=3D ~BIT(irq_index);
-			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
-		}
+		for (i =3D 0; i < pdc_region[n].cnt; i++)
+			__pdc_enable_intr(i + pdc_region[n].pin_base, 0);
 	}
=20
 	return 0;
 }
=20
+#define QCOM_PDC_SIZE 0x30000
+
 static int qcom_pdc_init(struct device_node *node, struct device_node *paren=
t)
 {
 	struct irq_domain *parent_domain, *pdc_domain;
+	resource_size_t res_size;
+	struct resource res;
 	int ret;
=20
-	pdc_base =3D of_iomap(node, 0);
+	/* compat with old sm8150 DT which had very small region for PDC */
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+
+	res_size =3D max_t(resource_size_t, resource_size(&res), QCOM_PDC_SIZE);
+	if (res_size > resource_size(&res))
+		pr_warn("%pOF: invalid reg size, please fix DT\n", node);
+
+	pdc_base =3D ioremap(res.start, res_size);
 	if (!pdc_base) {
 		pr_err("%pOF: unable to map PDC registers\n", node);
 		return -ENXIO;
 	}
=20
+	pdc_version =3D pdc_reg_read(PDC_VERSION_REG, 0);
+
 	parent_domain =3D irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to find PDC's parent domain\n", node);

