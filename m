Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936277F056
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 07:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348148AbjHQFyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 01:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348135AbjHQFy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 01:54:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C92D3211E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 22:54:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68C881063;
        Wed, 16 Aug 2023 22:55:08 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 730643F762;
        Wed, 16 Aug 2023 22:54:21 -0700 (PDT)
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
Subject: [PATCH V5 1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
Date:   Thu, 17 Aug 2023 11:24:02 +0530
Message-Id: <20230817055405.249630-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230817055405.249630-1-anshuman.khandual@arm.com>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sanity checking all the GICC tables for same interrupt number, and ensuring
a homogeneous ACPI based machine, could be used for other platform devices
as well. Hence this refactors arm_spe_acpi_register_device() into a common
helper arm_acpi_register_pmu_device().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Co-developed-by: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu_acpi.c | 109 +++++++++++++++++++++++-------------
 1 file changed, 69 insertions(+), 40 deletions(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 90815ad762eb..8a44e9e3320b 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -69,6 +69,67 @@ static void arm_pmu_acpi_unregister_irq(int cpu)
 		acpi_unregister_gsi(gsi);
 }
 
+static int __maybe_unused
+arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
+			     u16 (*parse_gsi)(struct acpi_madt_generic_interrupt *))
+{
+	int cpu, this_hetid, hetid, irq, ret;
+	u16 this_gsi, gsi = 0;
+
+	/*
+	 * Ensure that platform device must have IORESOURCE_IRQ
+	 * resource to hold gsi interrupt.
+	 */
+	if (pdev->num_resources != 1)
+		return -ENXIO;
+
+	if (pdev->resource[0].flags != IORESOURCE_IRQ)
+		return -ENXIO;
+
+	/*
+	 * Sanity check all the GICC tables for the same interrupt
+	 * number. For now, only support homogeneous ACPI machines.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct acpi_madt_generic_interrupt *gicc;
+
+		gicc = acpi_cpu_get_madt_gicc(cpu);
+		if (gicc->header.length < len)
+			return gsi ? -ENXIO : 0;
+
+		this_gsi = parse_gsi(gicc);
+		this_hetid = find_acpi_cpu_topology_hetero_id(cpu);
+		if (!gsi) {
+			hetid = this_hetid;
+			gsi = this_gsi;
+		} else if (hetid != this_hetid || gsi != this_gsi) {
+			pr_warn("ACPI: %s: must be homogeneous\n", pdev->name);
+			return -ENXIO;
+		}
+	}
+	/*
+	 * This is a special case where no cpu on
+	 * the system has the interrupt and which
+	 * could not have been detected via above
+	 * homogeneous mismatch test.
+	 */
+	if (!this_gsi)
+		return 0;
+
+	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		pr_warn("ACPI: %s Unable to register interrupt: %d\n", pdev->name, gsi);
+		return -ENXIO;
+	}
+
+	pdev->resource[0].start = irq;
+	ret = platform_device_register(pdev);
+	if (ret)
+		acpi_unregister_gsi(gsi);
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
 static struct resource spe_resources[] = {
 	{
@@ -84,6 +145,11 @@ static struct platform_device spe_dev = {
 	.num_resources = ARRAY_SIZE(spe_resources)
 };
 
+static u16 arm_spe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
+{
+	return gicc->spe_interrupt;
+}
+
 /*
  * For lack of a better place, hook the normal PMU MADT walk
  * and create a SPE device if we detect a recent MADT with
@@ -91,47 +157,10 @@ static struct platform_device spe_dev = {
  */
 static void arm_spe_acpi_register_device(void)
 {
-	int cpu, hetid, irq, ret;
-	bool first = true;
-	u16 gsi = 0;
-
-	/*
-	 * Sanity check all the GICC tables for the same interrupt number.
-	 * For now, we only support homogeneous ACPI/SPE machines.
-	 */
-	for_each_possible_cpu(cpu) {
-		struct acpi_madt_generic_interrupt *gicc;
-
-		gicc = acpi_cpu_get_madt_gicc(cpu);
-		if (gicc->header.length < ACPI_MADT_GICC_SPE)
-			return;
-
-		if (first) {
-			gsi = gicc->spe_interrupt;
-			if (!gsi)
-				return;
-			hetid = find_acpi_cpu_topology_hetero_id(cpu);
-			first = false;
-		} else if ((gsi != gicc->spe_interrupt) ||
-			   (hetid != find_acpi_cpu_topology_hetero_id(cpu))) {
-			pr_warn("ACPI: SPE must be homogeneous\n");
-			return;
-		}
-	}
-
-	irq = acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE,
-				ACPI_ACTIVE_HIGH);
-	if (irq < 0) {
-		pr_warn("ACPI: SPE Unable to register interrupt: %d\n", gsi);
-		return;
-	}
-
-	spe_resources[0].start = irq;
-	ret = platform_device_register(&spe_dev);
-	if (ret < 0) {
+	int ret = arm_acpi_register_pmu_device(&spe_dev, ACPI_MADT_GICC_SPE,
+					       arm_spe_parse_gsi);
+	if (ret)
 		pr_warn("ACPI: SPE: Unable to register device\n");
-		acpi_unregister_gsi(gsi);
-	}
 }
 #else
 static inline void arm_spe_acpi_register_device(void)
-- 
2.25.1

