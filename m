Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4697F4595
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjKVMS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbjKVMSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:18:20 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F091;
        Wed, 22 Nov 2023 04:18:14 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 3AMCGhhl025188;
        Wed, 22 Nov 2023 20:16:43 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Wed, 22 Nov 2023
 20:16:39 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <sunilvl@ventanamicro.com>,
        <tglx@linutronix.de>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>,
        <inochiama@outlook.com>
Subject: [PATCH v4 08/13] perf: RISC-V: Introduce Andes PMU for perf event sampling
Date:   Wed, 22 Nov 2023 20:12:30 +0800
Message-ID: <20231122121235.827122-9-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122121235.827122-1-peterlin@andestech.com>
References: <20231122121235.827122-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3AMCGhhl025188
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Changes v2 -> v3:
  - Reordered list in riscv_isa_ext[]
  - Removed mvendorid check in pmu_sbi_setup_irqs()
Changes v3 -> v4:
  - No change
---
 arch/riscv/include/asm/hwcap.h |  1 +
 arch/riscv/kernel/cpufeature.c |  1 +
 drivers/perf/Kconfig           | 14 ++++++++++++++
 drivers/perf/riscv_pmu_sbi.c   | 30 +++++++++++++++++++++++++-----
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index c85ee34c78d9..cbfbc3505d2c 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,7 @@
 #define RISCV_ISA_EXT_SMSTATEEN		43
 #define RISCV_ISA_EXT_ZICOND		44
 #define RISCV_ISA_EXT_XTHEADPMU		45
+#define RISCV_ISA_EXT_XANDESPMU		46
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e606f588d366..42fda134c4a3 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -185,6 +185,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
 	__RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
 };
 
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
index 31ca79846399..1e0c709efbfc 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
+#include <linux/soc/andes/irq.h>
 
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
@@ -27,14 +28,26 @@
 #define THEAD_C9XX_CSR_SCOUNTEROF	0x5c5
 
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
@@ -72,6 +85,7 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
 static union sbi_pmu_ctr_info *pmu_ctr_list;
 static bool riscv_pmu_use_irq;
 static unsigned int riscv_pmu_irq_num;
+static unsigned int riscv_pmu_irq_mask;
 static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
@@ -705,7 +719,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		return IRQ_NONE;
 	}
 
@@ -719,7 +733,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	 * Overflow interrupt pending bit should only be cleared after stopping
 	 * all the counters to avoid any race condition.
 	 */
-	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 
 	/* No overflow bit is set */
 	if (!overflow)
@@ -791,7 +805,7 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (riscv_pmu_use_irq) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
-		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
@@ -823,8 +837,14 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU)) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
+	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
+		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMU;
+		riscv_pmu_use_irq = true;
 	}
 
+	riscv_pmu_irq_mask = BIT(riscv_pmu_irq_num % BITS_PER_LONG);
+
 	if (!riscv_pmu_use_irq)
 		return -EOPNOTSUPP;
 
-- 
2.34.1

