Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF880D0C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344407AbjLKQON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344309AbjLKQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:14:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE103B4;
        Mon, 11 Dec 2023 08:14:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0874E169C;
        Mon, 11 Dec 2023 08:15:04 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8BA3F3F738;
        Mon, 11 Dec 2023 08:14:13 -0800 (PST)
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
Subject: [PATCH v7 02/11] arm: perf/kvm: Use GENMASK for ARMV8_PMU_PMCR_N
Date:   Mon, 11 Dec 2023 16:13:14 +0000
Message-Id: <20231211161331.1277825-3-james.clark@arm.com>
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

This is so that FIELD_GET and FIELD_PREP can be used and that the fields
are in a consistent format to arm64/tools/sysreg

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/kvm/pmu-emul.c      | 8 +++-----
 arch/arm64/kvm/sys_regs.c      | 4 ++--
 drivers/perf/arm_pmuv3.c       | 4 ++--
 include/linux/perf/arm_pmuv3.h | 3 +--
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index fe99b3dab6ce..3d9467ff73bc 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -267,9 +267,8 @@ void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 {
-	u64 val = kvm_vcpu_read_pmcr(vcpu) >> ARMV8_PMU_PMCR_N_SHIFT;
+	u64 val = FIELD_GET(ARMV8_PMU_PMCR_N, kvm_vcpu_read_pmcr(vcpu));
 
-	val &= ARMV8_PMU_PMCR_N_MASK;
 	if (val == 0)
 		return BIT(ARMV8_PMU_CYCLE_IDX);
 	else
@@ -1136,8 +1135,7 @@ u8 kvm_arm_pmu_get_pmuver_limit(void)
  */
 u64 kvm_vcpu_read_pmcr(struct kvm_vcpu *vcpu)
 {
-	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0) &
-			~(ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
+	u64 pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
 
-	return pmcr | ((u64)vcpu->kvm->arch.pmcr_n << ARMV8_PMU_PMCR_N_SHIFT);
+	return u64_replace_bits(pmcr, vcpu->kvm->arch.pmcr_n, ARMV8_PMU_PMCR_N);
 }
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4735e1b37fb3..ff45d688bd7d 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -877,7 +877,7 @@ static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
 	u64 pmcr, val;
 
 	pmcr = kvm_vcpu_read_pmcr(vcpu);
-	val = (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
+	val = FIELD_GET(ARMV8_PMU_PMCR_N, pmcr);
 	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
 		kvm_inject_undefined(vcpu);
 		return false;
@@ -1143,7 +1143,7 @@ static int get_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 		    u64 val)
 {
-	u8 new_n = (val >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
+	u8 new_n = FIELD_GET(ARMV8_PMU_PMCR_N, val);
 	struct kvm *kvm = vcpu->kvm;
 
 	mutex_lock(&kvm->arch.config_lock);
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 9184a75435e2..e424de5dd44f 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -15,6 +15,7 @@
 #include <clocksource/arm_arch_timer.h>
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/clocksource.h>
 #include <linux/of.h>
 #include <linux/perf/arm_pmu.h>
@@ -1107,8 +1108,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	probe->present = true;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	cpu_pmu->num_events = (armv8pmu_pmcr_read() >> ARMV8_PMU_PMCR_N_SHIFT)
-		& ARMV8_PMU_PMCR_N_MASK;
+	cpu_pmu->num_events = FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
 
 	/* Add the CPU cycles counter */
 	cpu_pmu->num_events += 1;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 9c226adf938a..ed62bd75cec7 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -215,8 +215,7 @@
 #define ARMV8_PMU_PMCR_DP	(1 << 5) /* Disable CCNT if non-invasive debug*/
 #define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
 #define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
-#define ARMV8_PMU_PMCR_N_SHIFT	11  /* Number of counters supported */
-#define ARMV8_PMU_PMCR_N_MASK	0x1f
+#define ARMV8_PMU_PMCR_N	GENMASK(15, 11) /* Number of counters supported */
 #define ARMV8_PMU_PMCR_MASK	0xff    /* Mask for writable bits */
 
 /*
-- 
2.34.1

