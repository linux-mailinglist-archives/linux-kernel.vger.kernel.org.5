Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101A77F717D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345366AbjKXKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjKXKbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:31:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B65A21B2;
        Fri, 24 Nov 2023 02:31:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF0B1424;
        Fri, 24 Nov 2023 02:32:33 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.5.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AAF083F7A6;
        Fri, 24 Nov 2023 02:31:45 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com,
        namhyung@gmail.com
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] arm64: perf: Include threshold control fields in PMEVTYPER mask
Date:   Fri, 24 Nov 2023 10:28:55 +0000
Message-Id: <20231124102857.1106453-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124102857.1106453-1-james.clark@arm.com>
References: <20231124102857.1106453-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
them in the mask. These aren't writable on 32 bit kernels as they are in
the high part of the register, so only include them for arm64.

It would be difficult to do this statically in the asm header files for
each platform without resulting in circular includes or #ifdefs inline
in the code. For that reason the ARMV8_PMU_EVTYPE_MASK definition has
been removed and the mask is constructed programmatically.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/perf/arm_pmuv3.c       | 9 ++++++++-
 include/linux/perf/arm_pmuv3.h | 3 ++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 6ca7be05229c..1d40d794f5e4 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -555,8 +555,15 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 static inline void armv8pmu_write_evtype(int idx, u32 val)
 {
 	u32 counter = ARMV8_IDX_TO_COUNTER(idx);
+	unsigned long mask = ARMV8_PMU_EVTYPE_EVENT |
+			     ARMV8_PMU_INCLUDE_EL2 |
+			     ARMV8_PMU_EXCLUDE_EL0 |
+			     ARMV8_PMU_EXCLUDE_EL1;
 
-	val &= ARMV8_PMU_EVTYPE_MASK;
+	if (IS_ENABLED(CONFIG_ARM64))
+		mask |= ARMV8_PMU_EVTYPE_TC | ARMV8_PMU_EVTYPE_TH;
+
+	val &= mask;
 	write_pmevtypern(counter, val);
 }
 
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 9c226adf938a..ddd1fec86739 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -228,7 +228,8 @@
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
+#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
 #define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
 
 /*
-- 
2.34.1

