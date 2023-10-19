Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2AB7CFBFB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345972AbjJSOFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345970AbjJSOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:05:18 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A5130
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:05:13 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39JE50qp032111;
        Thu, 19 Oct 2023 22:05:00 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 19 Oct 2023
 22:04:57 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <will@kernel.org>, <mark.rutland@arm.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <conor.dooley@microchip.com>, <ajones@ventanamicro.com>,
        <heiko@sntech.de>, <jszhang@kernel.org>, <peterlin@andestech.com>,
        <evan@rivosinc.com>, <sunilvl@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <prabhakar.mahadev-lad.rj@bp.renesas.com>, <tim609@andestech.com>,
        <dylan@andestech.com>, <locus84@andestech.com>,
        <dminus@andestech.com>, "Leo Yu-Chi Liang" <ycliang@andestech.com>
Subject: [RFC PATCH v2 08/10] perf: RISC-V: Introduce Andes PMU for perf event sampling
Date:   Thu, 19 Oct 2023 22:01:56 +0800
Message-ID: <20231019140156.3660000-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39JE50qp032111
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Andes PMU extension provides the same mechanism as Sscofpmf,
allowing us to reuse the SBI PMU driver to support event sampling
and mode filtering.

To make use of this custom PMU extension, "xandespmu" needs
to be appended to the riscv,isa-extensions for each cpu node
in device-tree, and enable CONFIG_ANDES_CUSTOM_PMU.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Co-developed-by: Locus Wei-Han Chen <locus84@andestech.com>
Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
---
Changes v1 -> v2:
  - New patch
---
 arch/riscv/include/asm/hwcap.h |  1 +
 arch/riscv/kernel/cpufeature.c |  1 +
 drivers/perf/Kconfig           | 14 ++++++++++++++
 drivers/perf/riscv_pmu_sbi.c   | 35 +++++++++++++++++++++++++++++-----
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index d3082391c901..eecfe95d5050 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -59,6 +59,7 @@
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_XTHEADPMU		43
+#define RISCV_ISA_EXT_XANDESPMU		44
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 4a3fb017026c..a8e71c6dfb3e 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
 	__RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index c71b6f16bdfa..c1a490829d15 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -86,6 +86,20 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config ANDES_CUSTOM_PMU
+	bool "Andes custom PMU support"
+	depends on RISCV_ALTERNATIVE && RISCV_PMU_SBI
+	default y
+	help
+	  The Andes cores implement a PMU overflow extension very
+	  similar to the core SSCOFPMF extension.
+
+	  This will patch the overflow/pending CSR and handle the
+	  non-standard behaviour via the regular SBI PMU driver and
+	  interface.
+
+	  If you don't know what to do here, say "Y".
+
 config THEAD_CUSTOM_PMU
 	bool "T-Head custom PMU support"
 	depends on RISCV_ALTERNATIVE && RISCV_PMU_SBI
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 790fc20fe094..e0de1a5fa0ba 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/irq-riscv-intc.h>
 #include <linux/of_irq.h>
 #include <linux/of.h>
 #include <linux/cpu_pm.h>
@@ -26,15 +27,31 @@
 #define THEAD_C9XX_RV_IRQ_PMU		17
 #define THEAD_C9XX_CSR_SCOUNTEROF	0x5c5
 
+#define ANDES_RV_IRQ_PMU		18
+#define ANDES_CSR_SCOUNTEROF		0x9d4
+#define ANDES_CSR_SLIP			0x9c5
+
 #define ALT_SBI_PMU_OVERFLOW(__ovl)					\
-asm volatile(ALTERNATIVE(						\
+asm volatile(ALTERNATIVE_2(						\
 	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
 	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
 		0, RISCV_ISA_EXT_XTHEADPMU,				\
-		CONFIG_THEAD_CUSTOM_PMU)				\
+		CONFIG_THEAD_CUSTOM_PMU,				\
+	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
+		0, RISCV_ISA_EXT_XANDESPMU,		\
+		CONFIG_ANDES_CUSTOM_PMU)				\
 	: "=r" (__ovl) :						\
 	: "memory")
 
+#define ALT_SBI_PMU_OVF_CLEAR_PENDING(__irq_mask)			\
+asm volatile(ALTERNATIVE(						\
+	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
+	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
+		0, RISCV_ISA_EXT_XANDESPMU,				\
+		CONFIG_ANDES_CUSTOM_PMU)				\
+	: : "r"(__irq_mask)						\
+	: "memory")
+
 #define SYSCTL_NO_USER_ACCESS	0
 #define SYSCTL_USER_ACCESS	1
 #define SYSCTL_LEGACY		2
@@ -72,6 +89,7 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
 static union sbi_pmu_ctr_info *pmu_ctr_list;
 static bool riscv_pmu_use_irq;
 static unsigned int riscv_pmu_irq_num;
+static unsigned int riscv_pmu_irq_mask;
 static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
@@ -702,7 +720,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		return IRQ_NONE;
 	}
 
@@ -716,7 +734,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	 * Overflow interrupt pending bit should only be cleared after stopping
 	 * all the counters to avoid any race condition.
 	 */
-	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 
 	/* No overflow bit is set */
 	if (!overflow)
@@ -788,7 +806,7 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (riscv_pmu_use_irq) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
-		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
@@ -823,8 +841,15 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
+	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU) &&
+		   riscv_cached_mvendorid(0) == ANDES_VENDOR_ID) {
+		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMU;
+		riscv_pmu_use_irq = true;
 	}
 
+	riscv_pmu_irq_mask = BIT(riscv_pmu_irq_num % BITS_PER_LONG);
+
 	if (!riscv_pmu_use_irq)
 		return -EOPNOTSUPP;
 
-- 
2.34.1

