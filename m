Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F0F80D0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344420AbjLKQQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344624AbjLKQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:15:17 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7D2AD56;
        Mon, 11 Dec 2023 08:14:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B79F16F3;
        Mon, 11 Dec 2023 08:15:41 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A91923F738;
        Mon, 11 Dec 2023 08:14:50 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com
Cc:     namhyung@gmail.com, James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v7 05/11] arm64: perf: Include threshold control fields in PMEVTYPER mask
Date:   Mon, 11 Dec 2023 16:13:17 +0000
Message-Id: <20231211161331.1277825-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211161331.1277825-1-james.clark@arm.com>
References: <20231211161331.1277825-1-james.clark@arm.com>
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
index fbdf3cab8e66..16ef8448afc0 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -554,8 +554,15 @@ static void armv8pmu_write_counter(struct perf_event *event, u64 value)
 static void armv8pmu_write_evtype(int idx, u32 val)
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
index daa63542242d..91957b3468e9 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -233,8 +233,9 @@
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
 #define ARMV8_PMU_EVTYPE_EVENT	GENMASK(15, 0)	/* Mask for EVENT bits */
+#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
+#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
 
 /*
  * Event filters for PMUv3
-- 
2.34.1

