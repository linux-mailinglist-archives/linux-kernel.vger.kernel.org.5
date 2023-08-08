Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9837747C2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjHHTTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbjHHTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:18:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D97FFF622
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7512143D;
        Tue,  8 Aug 2023 01:23:50 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 050733F7A6;
        Tue,  8 Aug 2023 01:23:03 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     yangyicong@huawei.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] arm_pmu: acpi: Add a representative platform device for TRBE
Date:   Tue,  8 Aug 2023 13:52:45 +0530
Message-Id: <20230808082247.383405-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808082247.383405-1-anshuman.khandual@arm.com>
References: <20230808082247.383405-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
 arch/arm64/include/asm/acpi.h |  3 +++
 drivers/perf/arm_pmu_acpi.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h  |  1 +
 3 files changed, 39 insertions(+)

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
index 72454bef2a70..845683ca7c64 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -164,6 +164,40 @@ static inline void arm_spe_acpi_register_device(void)
 }
 #endif /* CONFIG_ARM_SPE_PMU */
 
+#if IS_ENABLED(CONFIG_CORESIGHT_TRBE)
+static struct resource trbe_resources[] = {
+	{
+		/* irq */
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device trbe_dev = {
+	.name = ARMV8_TRBE_PDEV_NAME,
+	.id = -1,
+	.resource = trbe_resources,
+	.num_resources = ARRAY_SIZE(trbe_resources)
+};
+
+static u16 arm_trbe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
+{
+	return gicc->trbe_interrupt;
+}
+
+static void arm_trbe_acpi_register_device(void)
+{
+	int ret = arm_acpi_register_pmu_device(&trbe_dev, ACPI_MADT_GICC_TRBE,
+					       arm_trbe_parse_gsi);
+	if (ret)
+		pr_warn("ACPI: TRBE: Unable to register device\n");
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
@@ -399,6 +433,7 @@ static int arm_pmu_acpi_init(void)
 		return 0;
 
 	arm_spe_acpi_register_device();
+	arm_trbe_acpi_register_device();
 
 	return 0;
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index a0801f68762b..143fbc10ecfe 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
 #endif /* CONFIG_ARM_PMU */
 
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
+#define ARMV8_TRBE_PDEV_NAME "arm,trbe"
 
 #endif /* __ARM_PMU_H__ */
-- 
2.25.1

