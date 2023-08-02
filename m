Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB676D496
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjHBRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjHBRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:02:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 042F326B6;
        Wed,  2 Aug 2023 10:02:37 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 648B8238C439;
        Wed,  2 Aug 2023 10:02:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 648B8238C439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690995756;
        bh=XO9oulQ0EQp1qgakWLqR3menIofzrQrbYDEbp+h4DOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piTiHb8ALty5h7+ioVNi5N25qaB0YRy9FMBMt3TSJBTpSIoP05eAwvRg2SzCWve3b
         qzA5ksTQtmJ9Lx4UJwMctVG2/zi95FxA4DDBmPUDVRnHSkP095cd0FdjO004niO9vn
         ipxSHtL3CDn+u2x2ekScfsjdhhteX9MwPHMzQ7aE=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5.15 1/6] arm64: errata: Add workaround for TSB flush failures
Date:   Wed,  2 Aug 2023 17:02:22 +0000
Message-Id: <20230802170227.1590187-2-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
References: <20230802170227.1590187-1-eahariha@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit fa82d0b4b833790ac4572377fb777dcea24a9d69 upstream

Arm Neoverse-N2 (#2067961) and Cortex-A710 (#2054223) suffers
from errata, where a TSB (trace synchronization barrier)
fails to flush the trace data completely, when executed from
a trace prohibited region. In Linux we always execute it
after we have moved the PE to trace prohibited region. So,
we can apply the workaround every time a TSB is executed.

The work around is to issue two TSB consecutively.

NOTE: This errata is defined as LOCAL_CPU_ERRATUM, implying
that a late CPU could be blocked from booting if it is the
first CPU that requires the workaround. This is because we
do not allow setting a cpu_hwcaps after the SMP boot. The
other alternative is to use "this_cpu_has_cap()" instead
of the faster system wide check, which may be a bit of an
overhead, given we may have to do this in nvhe KVM host
before a guest entry.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20211019163153.3692640-4-suzuki.poulose@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arm64/silicon-errata.rst |  4 ++++
 arch/arm64/Kconfig                     | 33 ++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h       | 16 ++++++++++++-
 arch/arm64/kernel/cpu_errata.c         | 19 +++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 5 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 076861b0f5ac..1de575fc135b 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -104,6 +104,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -112,6 +114,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e5e35470647b..6dce6e56ee53 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -774,6 +774,39 @@ config ARM64_ERRATUM_2139208
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	bool
+
+config ARM64_ERRATUM_2054223
+	bool "Cortex-A710: 2054223: workaround TSB instruction failing to flush trace"
+	default y
+	select ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	help
+	  Enable workaround for ARM Cortex-A710 erratum 2054223
+
+	  Affected cores may fail to flush the trace data on a TSB instruction, when
+	  the PE is in trace prohibited state. This will cause losing a few bytes
+	  of the trace cached.
+
+	  Workaround is to issue two TSB consecutively on affected cores.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2067961
+	bool "Neoverse-N2: 2067961: workaround TSB instruction failing to flush trace"
+	default y
+	select ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	help
+	  Enable workaround for ARM Neoverse-N2 erratum 2067961
+
+	  Affected cores may fail to flush the trace data on a TSB instruction, when
+	  the PE is in trace prohibited state. This will cause losing a few bytes
+	  of the trace cached.
+
+	  Workaround is to issue two TSB consecutively on affected cores.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 451e11e5fd23..1c5a00598458 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -23,7 +23,7 @@
 #define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
 #define psb_csync()	asm volatile("hint #17" : : : "memory")
-#define tsb_csync()	asm volatile("hint #18" : : : "memory")
+#define __tsb_csync()	asm volatile("hint #18" : : : "memory")
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
 #ifdef CONFIG_ARM64_PSEUDO_NMI
@@ -46,6 +46,20 @@
 #define dma_rmb()	dmb(oshld)
 #define dma_wmb()	dmb(oshst)
 
+
+#define tsb_csync()								\
+	do {									\
+		/*								\
+		 * CPUs affected by Arm Erratum 2054223 or 2067961 needs	\
+		 * another TSB to ensure the trace is flushed. The barriers	\
+		 * don't have to be strictly back to back, as long as the	\
+		 * CPU is in trace prohibited state.				\
+		 */								\
+		if (cpus_have_final_cap(ARM64_WORKAROUND_TSB_FLUSH_FAILURE))	\
+			__tsb_csync();						\
+		__tsb_csync();							\
+	} while (0)
+
 /*
  * Generate a mask for array_index__nospec() that is ~0UL when 0 <= idx < sz
  * and 0 otherwise.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index d810d4b7b438..ab412b45732f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -375,6 +375,18 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 };
 #endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+static const struct midr_range tsb_flush_fail_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2067961
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2054223
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -606,6 +618,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
+	{
+		.desc = "ARM erratum 2067961 or 2054223",
+		.capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
+		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 32fe50a3a26c..36ab307c69d4 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -57,6 +57,7 @@ WORKAROUND_1542419
 WORKAROUND_1742098
 WORKAROUND_2457168
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+WORKAROUND_TSB_FLUSH_FAILURE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
-- 
2.25.1

