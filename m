Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F7D75BB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjGTXYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjGTXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:23:55 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F4C72111;
        Thu, 20 Jul 2023 16:23:53 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C5815236EBE8;
        Thu, 20 Jul 2023 16:23:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5815236EBE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1689895432;
        bh=lILWt7bDCpcb7A25rFrVQC7VmUomZ/X0dBfspgXvAeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dOK58m5lmqCLT0TkZ9n6k8PEWuoiLnDhOqwTzj4mwq5ovT3Auf9WHehgUEd69LJrb
         rSKAY0IyTvwSHDQOx+w8Z3x6K2r6IOV+TxAtK9LD8PfOw+VMFwxksNHbpWW0pLo4HH
         WXiiTRCGjo9d2Yp7q4HuKcBWo4kI8ya45hMnq0Kc=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com, catalin.marinas@arm.com,
        will@kernel.org, corbet@lwn.net, robin.murphy@arm.com,
        joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: [PATCH 5.15 1/4] arm64: errata: Add detection for TRBE overwrite in FILL mode
Date:   Thu, 20 Jul 2023 16:23:31 -0700
Message-Id: <1689895414-17425-2-git-send-email-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
References: <1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit b9d216fcef4298de76519e2baeed69ba482467bd upstream

Arm Neoverse-N2 and the Cortex-A710 cores are affected
by a CPU erratum where the TRBE will overwrite the trace buffer
in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
when it reaches the limit and wraps to the base to continue
writing upto 3 cache lines. This will overwrite any trace that
was written previously.

Add the Neoverse-N2 erratum(#2139208) and Cortex-A710 erratum
(#2119858) to the detection logic.

This will be used by the TRBE driver in later patches to work
around the issue. The detection has been kept with the core
arm64 errata framework list to make sure :
  - We don't duplicate the framework in TRBE driver
  - The errata detection is advertised like the rest
    of the CPU errata.

Note that the Kconfig entries are not fully active until the
TRBE driver implements the work around.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
cc: Leo Yan <leo.yan@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20211019163153.3692640-3-suzuki.poulose@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 41 ++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 26 ++++++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 4 files changed, 72 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 1cee230338a2..076861b0f5ac 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -102,12 +102,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2119858        | ARM64_ERRATUM_2119858       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9d3cbe786f8d..e5e35470647b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -733,6 +733,47 @@ config ARM64_ERRATUM_2457168
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	bool
+
+config ARM64_ERRATUM_2119858
+	bool "Cortex-A710: 2119858: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2119858.
+
+	  Affected Cortex-A710 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2139208
+	bool "Neoverse-N2: 2139208: workaround TRBE overwriting trace data in FILL mode"
+	default y
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	select ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2139208.
+
+	  Affected Neoverse-N2 cores could overwrite up to 3 cache lines of trace
+	  data at the base of the buffer (pointed to by TRBASER_EL1) in FILL mode in
+	  the event of a WRAP event.
+
+	  Work around the issue by always making sure we move the TRBPTR_EL1 by
+	  256 bytes before enabling the buffer and filling the first 256 bytes of
+	  the buffer with ETM ignore packets upon disabling.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ce59811616d8..d810d4b7b438 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -363,6 +363,18 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2139208
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2119858
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -564,6 +576,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
 	},
 #endif
+
 #ifdef CONFIG_ARM64_ERRATUM_2457168
 	{
 		.desc = "ARM erratum 2457168",
@@ -580,6 +593,19 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		CAP_MIDR_RANGE_LIST(broken_aarch32_aes),
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
+	{
+		/*
+		 * The erratum work around is handled within the TRBE
+		 * driver and can be applied per-cpu. So, we can allow
+		 * a late CPU to come online with this erratum.
+		 */
+		.desc = "ARM erratum 2119858 or 2139208",
+		.capability = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 6b1e70aee8cf..32fe50a3a26c 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -56,6 +56,7 @@ WORKAROUND_1508412
 WORKAROUND_1542419
 WORKAROUND_1742098
 WORKAROUND_2457168
+WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
-- 
2.25.1

