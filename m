Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FBB766BA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjG1L2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjG1L17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:27:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D2652D5B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:27:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 182BED75;
        Fri, 28 Jul 2023 04:28:41 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68B1F3F6C4;
        Fri, 28 Jul 2023 04:27:55 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm_pmu: acpi: Add a representative platform device for TRBE
Date:   Fri, 28 Jul 2023 16:57:31 +0530
Message-Id: <20230728112733.359620-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728112733.359620-1-anshuman.khandual@arm.com>
References: <20230728112733.359620-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI TRBE does not have a HID for identification which could create and add
a platform device into the platform bus. Also without a platform device, it
cannot be probed and bound to a platform driver.

This creates a dummy platform device for TRBE after ascertaining that ACPI
provides required interrupts uniformly across all cpus on the system. This
device gets created inside drivers/perf/arm_pmu_acpi.c to accommodate TRBE
being built as a module.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/acpi.h |  3 ++
 drivers/perf/arm_pmu_acpi.c   | 63 +++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h  |  1 +
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f..4d537d56eb84 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -42,6 +42,9 @@
 #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
 	spe_interrupt) + sizeof(u16))
 
+#define ACPI_MADT_GICC_TRBE  (offsetof(struct acpi_madt_generic_interrupt, \
+	trbe_interrupt) + sizeof(u16))
+
 /* Basic configuration for ACPI */
 #ifdef	CONFIG_ACPI
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 90815ad762eb..dd3df6729808 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -139,6 +139,68 @@ static inline void arm_spe_acpi_register_device(void)
 }
 #endif /* CONFIG_ARM_SPE_PMU */
 
+#ifdef CONFIG_CORESIGHT_TRBE
+static struct resource trbe_acpi_resources[] = {
+	{
+		/* irq */
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device trbe_acpi_dev = {
+	.name = ARMV8_TRBE_PDEV_NAME,
+	.id = -1,
+	.resource = trbe_acpi_resources,
+	.num_resources = ARRAY_SIZE(trbe_acpi_resources)
+};
+
+static void arm_trbe_acpi_register_device(void)
+{
+	int cpu, hetid, irq, ret;
+	bool first = true;
+	u16 gsi = 0;
+
+	for_each_possible_cpu(cpu) {
+		struct acpi_madt_generic_interrupt *gicc;
+
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		if (gicc->header.length < ACPI_MADT_GICC_TRBE)
+			return;
+
+		if (first) {
+			gsi = gicc->trbe_interrupt;
+			if (!gsi)
+				return;
+
+			hetid = find_acpi_cpu_topology_hetero_id(cpu);
+			first = false;
+		} else if ((gsi != gicc->trbe_interrupt) ||
+			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
+			pr_warn("ACPI: TRBE must be homogeneous\n");
+			return;
+		}
+	}
+
+	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		pr_warn("ACPI: TRBE Unable to register interrupt: %d\n", gsi);
+		return;
+	}
+	trbe_acpi_resources[0].start = irq;
+
+	ret = platform_device_register(&trbe_acpi_dev);
+	if (ret < 0) {
+		pr_warn("ACPI: TRBE: Unable to register device\n");
+		acpi_unregister_gsi(gsi);
+	}
+}
+#else
+static inline void arm_trbe_acpi_register_device(void)
+{
+
+}
+#endif /* CONFIG_CORESIGHT_TRBE */
+
 static int arm_pmu_acpi_parse_irqs(void)
 {
 	int irq, cpu, irq_cpu, err;
@@ -374,6 +436,7 @@ static int arm_pmu_acpi_init(void)
 		return 0;
 
 	arm_spe_acpi_register_device();
+	arm_trbe_acpi_register_device();
 
 	return 0;
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index a0801f68762b..7ec26d21303d 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
 #endif /* CONFIG_ARM_PMU */
 
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
+#define ARMV8_TRBE_PDEV_NAME "arm-trbe-acpi"
 
 #endif /* __ARM_PMU_H__ */
-- 
2.25.1

