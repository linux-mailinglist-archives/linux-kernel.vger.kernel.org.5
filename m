Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6617822F9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjHUEwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjHUEwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:52:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AFD3A3;
        Sun, 20 Aug 2023 21:52:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CF602F4;
        Sun, 20 Aug 2023 21:53:15 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE6AA3F740;
        Sun, 20 Aug 2023 21:52:30 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 1/3] coresight: etm: Override TRCIDR3.CCITMIN on errata affected cpus
Date:   Mon, 21 Aug 2023 10:22:14 +0530
Message-Id: <20230821045216.641499-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821045216.641499-1-anshuman.khandual@arm.com>
References: <20230821045216.641499-1-anshuman.khandual@arm.com>
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

This work arounds errata 1490853 on Cortex-A76, and Neoverse-N1, errata
1491015 on Cortex-A77, errata 1502854 on Cortex-X1, and errata 1619801 on
Neoverse-V1, based affected cpus, where software read for TRCIDR3.CCITMIN
field in ETM gets an wrong value.

If software uses the value returned by the TRCIDR3.CCITMIN register field,
then it will limit the range which could be used for programming the ETM.
In reality, the ETM could be programmed with a much smaller value than what
is indicated by the TRCIDR3.CCITMIN field and still function correctly.

If software reads the TRCIDR3.CCITMIN register field, corresponding to the
instruction trace counting minimum threshold, observe the value 0x100 or a
minimum cycle count threshold of 256. The correct value should be 0x4 or a
minimum cycle count threshold of 4.

This work arounds the problem via storing 4 in drvdata->ccitmin on affected
systems where the TRCIDR3.CCITMIN has been 256, thus preserving cycle count
threshold granularity.

These errata information has been updated in arch/arm64/silicon-errata.rst,
but without their corresponding configs because these have been implemented
directly in the driver.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/arch/arm64/silicon-errata.rst   | 10 ++++++
 .../coresight/coresight-etm4x-core.c          | 36 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index bedd3a1d7b42..b08f33eda5f1 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -107,6 +107,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #1490853        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #1491015        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2051678        | ARM64_ERRATUM_2051678       |
@@ -125,6 +129,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A715     | #2645198        | ARM64_ERRATUM_2645198       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #1502854        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2119858        | ARM64_ERRATUM_2119858       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-X2       | #2224489        | ARM64_ERRATUM_2224489       |
@@ -133,6 +139,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #1490853        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
@@ -141,6 +149,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #1619801        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 7e307022303a..1308d89f58d1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1131,6 +1131,39 @@ static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
 	drvdata->trfcr = trfcr;
 }
 
+/*
+ * The following errata on applicable cpu ranges, affect the CCITMIN filed
+ * in TCRIDR3 register. Software read for the field returns 0x100 limiting
+ * the cycle threshold granularity, whereas the right value should have
+ * been 0x4, which is well supported in the hardware.
+ */
+static struct midr_range etm_wrong_ccitmin_cpus[] = {
+	/* Erratum #1490853 - Cortex-A76 */
+	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 4, 0),
+	/* Erratum #1490853 - Neoverse-N1 */
+	MIDR_RANGE(MIDR_NEOVERSE_N1, 0, 0, 4, 0),
+	/* Erratum #1491015 - Cortex-A77 */
+	MIDR_RANGE(MIDR_CORTEX_A77, 0, 0, 1, 0),
+	/* Erratum #1502854 - Cortex-X1 */
+	MIDR_REV(MIDR_CORTEX_X1, 0, 0),
+	/* Erratum #1619801 - Neoverse-V1 */
+	MIDR_REV(MIDR_NEOVERSE_V1, 0, 0),
+	{},
+};
+
+static bool etm4_core_reads_wrong_ccitmin(struct etmv4_drvdata *drvdata)
+{
+	/*
+	 * Erratum affected cpus will read 256 as the minimum
+	 * instruction trace cycle counting threshold whereas
+	 * the correct value should be 4 instead. Override the
+	 * recorded value for 'drvdata->ccitmin' to workaround
+	 * this problem.
+	 */
+	return is_midr_in_range_list(read_cpuid_id(), etm_wrong_ccitmin_cpus) &&
+	       (drvdata->ccitmin == 256);
+}
+
 static void etm4_init_arch_data(void *info)
 {
 	u32 etmidr0;
@@ -1195,6 +1228,9 @@ static void etm4_init_arch_data(void *info)
 	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
 	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
 	drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
+	if (etm4_core_reads_wrong_ccitmin(drvdata))
+		drvdata->ccitmin = 4;
+
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
 	drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
 	drvdata->config.s_ex_level = drvdata->s_ex_level;
-- 
2.25.1

