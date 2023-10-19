Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734DD7CFBF6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbjJSOEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345996AbjJSOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:04:35 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0840193
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 07:04:31 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39JE4KY5031507;
        Thu, 19 Oct 2023 22:04:20 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 19 Oct 2023
 22:04:19 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <will@kernel.org>, <mark.rutland@arm.com>,
        <atishp@atishpatra.org>, <anup@brainfault.org>,
        <conor.dooley@microchip.com>, <evan@rivosinc.com>,
        <jszhang@kernel.org>, <ajones@ventanamicro.com>,
        <peterlin@andestech.com>, <rdunlap@infradead.org>,
        <heiko@sntech.de>, <samuel@sholland.org>, <guoren@kernel.org>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <uwu@icenowy.me>,
        <sunilvl@ventanamicro.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <tim609@andestech.com>, <dylan@andestech.com>,
        <locus84@andestech.com>, <dminus@andestech.com>
Subject: [RFC PATCH v2 07/10] perf: RISC-V: Move T-Head PMU to CPU feature alternative framework
Date:   Thu, 19 Oct 2023 22:01:19 +0800
Message-ID: <20231019140119.3659651-1-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39JE4KY5031507
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom PMU extension was developed to support perf event sampling
prior to the ratification of Sscofpmf. Instead of utilizing the standard
bits and CSR of Sscofpmf, a set of custom CSRs is added. So we may
consider it as a CPU feature rather than an erratum.

T-Head cores need to append "xtheadpmu" to the riscv,isa-extensions
for each cpu node in device tree, and enable CONFIG_THEAD_CUSTOM_PMU
for proper functioning as of this commit.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
---
Hi All,

This is in preparation for introducing other PMU alternative.
We follow Conor's suggestion [1] to use cpu feature alternative
framework rather than errta, if you want to stick with errata
alternative or have other issues, please let me know. Thanks.

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20230907021635.1002738-4-peterlin@andestech.com/#25503860

Changes v1 -> v2:
  - New patch
---
 arch/riscv/Kconfig.errata            | 13 -------------
 arch/riscv/errata/thead/errata.c     | 19 -------------------
 arch/riscv/include/asm/errata_list.h | 15 +--------------
 arch/riscv/include/asm/hwcap.h       |  1 +
 arch/riscv/kernel/cpufeature.c       |  1 +
 drivers/perf/Kconfig                 | 13 +++++++++++++
 drivers/perf/riscv_pmu_sbi.c         | 16 ++++++++++++++--
 7 files changed, 30 insertions(+), 48 deletions(-)

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 566bcefeab50..35dfb19d6a29 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -85,17 +85,4 @@ config ERRATA_THEAD_CMO
 
 	  If you don't know what to do here, say "Y".
 
-config ERRATA_THEAD_PMU
-	bool "Apply T-Head PMU errata"
-	depends on ERRATA_THEAD && RISCV_PMU_SBI
-	default y
-	help
-	  The T-Head C9xx cores implement a PMU overflow extension very
-	  similar to the core SSCOFPMF extension.
-
-	  This will apply the overflow errata to handle the non-standard
-	  behaviour via the regular SBI PMU driver and interface.
-
-	  If you don't know what to do here, say "Y".
-
 endmenu # "CPU errata selection"
diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
index 0554ed4bf087..5de5f7209132 100644
--- a/arch/riscv/errata/thead/errata.c
+++ b/arch/riscv/errata/thead/errata.c
@@ -53,22 +53,6 @@ static bool errata_probe_cmo(unsigned int stage,
 	return true;
 }
 
-static bool errata_probe_pmu(unsigned int stage,
-			     unsigned long arch_id, unsigned long impid)
-{
-	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_PMU))
-		return false;
-
-	/* target-c9xx cores report arch_id and impid as 0 */
-	if (arch_id != 0 || impid != 0)
-		return false;
-
-	if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
-		return false;
-
-	return true;
-}
-
 static u32 thead_errata_probe(unsigned int stage,
 			      unsigned long archid, unsigned long impid)
 {
@@ -80,9 +64,6 @@ static u32 thead_errata_probe(unsigned int stage,
 	if (errata_probe_cmo(stage, archid, impid))
 		cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
 
-	if (errata_probe_pmu(stage, archid, impid))
-		cpu_req_errata |= BIT(ERRATA_THEAD_PMU);
-
 	return cpu_req_errata;
 }
 
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index c190393aa9db..1b5354a50d55 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -25,8 +25,7 @@
 #ifdef CONFIG_ERRATA_THEAD
 #define	ERRATA_THEAD_PBMT 0
 #define	ERRATA_THEAD_CMO 1
-#define	ERRATA_THEAD_PMU 2
-#define	ERRATA_THEAD_NUMBER 3
+#define	ERRATA_THEAD_NUMBER 2
 #endif
 
 #ifdef __ASSEMBLY__
@@ -147,18 +146,6 @@ asm volatile(ALTERNATIVE_2(						\
 	    "r"((unsigned long)(_start) + (_size))			\
 	: "a0")
 
-#define THEAD_C9XX_RV_IRQ_PMU			17
-#define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
-
-#define ALT_SBI_PMU_OVERFLOW(__ovl)					\
-asm volatile(ALTERNATIVE(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
-	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
-		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
-		CONFIG_ERRATA_THEAD_PMU)				\
-	: "=r" (__ovl) :						\
-	: "memory")
-
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7b58258f6c7..d3082391c901 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -58,6 +58,7 @@
 #define RISCV_ISA_EXT_ZICSR		40
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_XTHEADPMU		43
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1cfbba65d11a..4a3fb017026c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -181,6 +181,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(xtheadpmu, RISCV_ISA_EXT_XTHEADPMU),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2..c71b6f16bdfa 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -86,6 +86,19 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config THEAD_CUSTOM_PMU
+	bool "T-Head custom PMU support"
+	depends on RISCV_ALTERNATIVE && RISCV_PMU_SBI
+	default y
+	help
+	  The T-Head C9xx cores implement a PMU overflow extension very
+	  similar to the core SSCOFPMF extension.
+
+	  This will patch the overflow CSR and handle the non-standard
+	  behaviour via the regular SBI PMU driver and interface.
+
+	  If you don't know what to do here, say "Y".
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index f340db9ce1e2..790fc20fe094 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -20,10 +20,21 @@
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
 
-#include <asm/errata_list.h>
 #include <asm/sbi.h>
 #include <asm/hwcap.h>
 
+#define THEAD_C9XX_RV_IRQ_PMU		17
+#define THEAD_C9XX_CSR_SCOUNTEROF	0x5c5
+
+#define ALT_SBI_PMU_OVERFLOW(__ovl)					\
+asm volatile(ALTERNATIVE(						\
+	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
+		0, RISCV_ISA_EXT_XTHEADPMU,				\
+		CONFIG_THEAD_CUSTOM_PMU)				\
+	: "=r" (__ovl) :						\
+	: "memory")
+
 #define SYSCTL_NO_USER_ACCESS	0
 #define SYSCTL_USER_ACCESS	1
 #define SYSCTL_LEGACY		2
@@ -805,7 +816,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		riscv_pmu_irq_num = RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
-	} else if (IS_ENABLED(CONFIG_ERRATA_THEAD_PMU) &&
+	} else if (riscv_isa_extension_available(NULL, XTHEADPMU) &&
+		   IS_ENABLED(CONFIG_THEAD_CUSTOM_PMU) &&
 		   riscv_cached_mvendorid(0) == THEAD_VENDOR_ID &&
 		   riscv_cached_marchid(0) == 0 &&
 		   riscv_cached_mimpid(0) == 0) {
-- 
2.34.1

