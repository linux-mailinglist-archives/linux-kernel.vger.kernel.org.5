Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96687CAB62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjJPOZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjJPOZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:25:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763E83;
        Mon, 16 Oct 2023 07:25:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB961C433C7;
        Mon, 16 Oct 2023 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466321;
        bh=sEAtPHGVqN9YumoNYv3VDPGXpoeUzGnAcM59GdaEyU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZOWjCnLzCyB47rbsFe7ukqPm6Z4M9nB1KSajLdYz1IcEXED+AEteqm67EkOBmSKP
         SeR8PMCwuhwXnRmV16hDwc3UhGPd/i7zT8Cwsw3rIVvez/5w28m6ONP/HiPTIfexdt
         xK+Rfof/C6escm2Lcy3OXu1wHWe4YWNCs8Aju7Cs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 006/191] arm_pmu: acpi: Add a representative platform device for TRBE
Date:   Mon, 16 Oct 2023 10:39:51 +0200
Message-ID: <20231016084015.550509169@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anshuman Khandual <anshuman.khandual@arm.com>

[ Upstream commit 1aa3d0274a4aac338ee45a3dfc3b17c944bcc2bc ]

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
Link: https://lore.kernel.org/r/20230817055405.249630-3-anshuman.khandual@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: 4785aa802853 ("cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/acpi.h |  3 +++
 drivers/perf/arm_pmu_acpi.c   | 35 +++++++++++++++++++++++++++++++++++
 include/linux/perf/arm_pmu.h  |  1 +
 3 files changed, 39 insertions(+)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index bd68e1b7f29f3..4d537d56eb847 100644
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
index 90815ad762ebc..8baeeb369118e 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -139,6 +139,40 @@ static inline void arm_spe_acpi_register_device(void)
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
@@ -374,6 +408,7 @@ static int arm_pmu_acpi_init(void)
 		return 0;
 
 	arm_spe_acpi_register_device();
+	arm_trbe_acpi_register_device();
 
 	return 0;
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index a0801f68762bf..143fbc10ecfe0 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -187,5 +187,6 @@ void armpmu_free_irq(int irq, int cpu);
 #endif /* CONFIG_ARM_PMU */
 
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
+#define ARMV8_TRBE_PDEV_NAME "arm,trbe"
 
 #endif /* __ARM_PMU_H__ */
-- 
2.40.1



