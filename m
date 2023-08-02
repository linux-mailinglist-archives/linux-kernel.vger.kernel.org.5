Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5C876D49A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjHBRCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjHBRCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:02:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85EDD1727;
        Wed,  2 Aug 2023 10:02:38 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id E3157238C43E;
        Wed,  2 Aug 2023 10:02:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E3157238C43E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690995758;
        bh=0oozv8nbM3C2NjhiKwObiXre0+plEuSLzZE6G8s0CO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnAt0xCcJly6cq++7SRBNzYDLjocktuaT7iloTzkId2e/H6mH2b42HEtMavQdoZvc
         3bhp8/1M5Bvf0cKLrjzMaHvreR1h39ouHkLUIkG7z+0IDDXrQh58vnYGxwnKCOO8Iz
         6b00IEm1vjyox/ldTVAdWEZ94+qif/pMLAHLOVQw=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morse <james.morse@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT
        (AARCH64 ARCHITECTURE)),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5.15 2/6] arm64: errata: Add detection for TRBE write to out-of-range
Date:   Wed,  2 Aug 2023 17:02:23 +0000
Message-Id: <20230802170227.1590187-3-eahariha@linux.microsoft.com>
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

commit 8d81b2a38ddfc4b03662d2359765648c8b4cc73c upstream

Arm Neoverse-N2 and Cortex-A710 cores are affected by an erratum where
the trbe, under some circumstances, might write upto 64bytes to an
address after the Limit as programmed by the TRBLIMITR_EL1.LIMIT.
This might -
  - Corrupt a page in the ring buffer, which may corrupt trace from a
    previous session, consumed by userspace.
  - Hit the guard page at the end of the vmalloc area and raise a fault.

To keep the handling simpler, we always leave the last page from the
range, which TRBE is allowed to write. This can be achieved by ensuring
that we always have more than a PAGE worth space in the range, while
calculating the LIMIT for TRBE. And then the LIMIT pointer can be
adjusted to leave the PAGE (TRBLIMITR.LIMIT -= PAGE_SIZE), out of the
TRBE range while enabling it. This makes sure that the TRBE will only
write to an area within its allowed limit (i.e, [head-head+size]) and
we do not have to handle address faults within the driver.

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20211019163153.3692640-5-suzuki.poulose@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arm64/silicon-errata.rst |  4 +++
 arch/arm64/Kconfig                     | 41 ++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c         | 20 +++++++++++++
 arch/arm64/tools/cpucaps               |  1 +
 4 files changed, 66 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index 1de575fc135b..f64354f8a79f 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -106,6 +106,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2054223        | ARM64_ERRATUM_2054223       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
@@ -116,6 +118,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6dce6e56ee53..5ab4b0520eab 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -807,6 +807,47 @@ config ARM64_ERRATUM_2067961
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	bool
+
+config ARM64_ERRATUM_2253138
+	bool "Neoverse-N2: 2253138: workaround TRBE writing to address out-of-range"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	default y
+	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	help
+	  This option adds the workaround for ARM Neoverse-N2 erratum 2253138.
+
+	  Affected Neoverse-N2 cores might write to an out-of-range address, not reserved
+	  for TRBE. Under some conditions, the TRBE might generate a write to the next
+	  virtually addressed page following the last page of the TRBE address space
+	  (i.e., the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
+
+	  Work around this in the driver by always making sure that there is a
+	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
+
+	  If unsure, say Y.
+
+config ARM64_ERRATUM_2224489
+	bool "Cortex-A710: 2224489: workaround TRBE writing to address out-of-range"
+	depends on COMPILE_TEST # Until the CoreSight TRBE driver changes are in
+	depends on CORESIGHT_TRBE
+	default y
+	select ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	help
+	  This option adds the workaround for ARM Cortex-A710 erratum 2224489.
+
+	  Affected Cortex-A710 cores might write to an out-of-range address, not reserved
+	  for TRBE. Under some conditions, the TRBE might generate a write to the next
+	  virtually addressed page following the last page of the TRBE address space
+	  (i.e., the TRBLIMITR_EL1.LIMIT), instead of wrapping around to the base.
+
+	  Work around this in the driver by always making sure that there is a
+	  page beyond the TRBLIMITR_EL1.LIMIT, within the space allowed for the TRBE.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ab412b45732f..bf69a20bc27f 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -387,6 +387,18 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
 };
 #endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+static struct midr_range trbe_write_out_of_range_cpus[] = {
+#ifdef CONFIG_ARM64_ERRATUM_2253138
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2224489
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+#endif
+	{},
+};
+#endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -625,6 +637,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_WORKAROUND_TSB_FLUSH_FAILURE,
 		ERRATA_MIDR_RANGE_LIST(tsb_flush_fail_cpus),
 	},
+#endif
+#ifdef CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
+	{
+		.desc = "ARM erratum 2253138 or 2224489",
+		.capability = ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 36ab307c69d4..fcaeec5a5125 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -58,6 +58,7 @@ WORKAROUND_1742098
 WORKAROUND_2457168
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
+WORKAROUND_TRBE_WRITE_OUT_OF_RANGE
 WORKAROUND_CAVIUM_23154
 WORKAROUND_CAVIUM_27456
 WORKAROUND_CAVIUM_30115
-- 
2.25.1

