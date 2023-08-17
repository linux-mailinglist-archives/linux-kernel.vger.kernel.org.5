Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6F77EE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 02:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347397AbjHQAbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 20:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347339AbjHQAaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 20:30:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372FE272E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:30:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589f7d66f22so39715957b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 17:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692232237; x=1692837037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4VcSjhn3Nc4h2EsQzkC75SuxdCiUDrl0Xn8hm1A88XU=;
        b=KW9M9MiLl25Qo5Kq3N022O3lepsKgTjSN4cmTARQnkFGLGUhfrDklSTm1k+n6nYtlg
         YQURbHZxO9F17Em9Cw30PL6K0PgPqgx5X7bOTzeDUESBa6wasiAPYjy6bm42LbpFu7aL
         8XqJteNB66qsY9ZF580P7URGkkmti+LuJUGslj31DZzmsa1Ub8CbsZnJpCSbojrgEkOT
         fT7J3awqGqc1Uk0KknKX5gcOig8gySOIDbRWWywRSwQOdw4WDBXsnhZB74WyWgridNtm
         71kyeigRU0bdecVn/wiI4S8MA0w5wygBLuM2DCf6oQZKfw9bf8Fe2G+NUe5FpWO8gGu3
         YU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692232237; x=1692837037;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VcSjhn3Nc4h2EsQzkC75SuxdCiUDrl0Xn8hm1A88XU=;
        b=C3B2AA/CB9qOogTFpbfPpy6MlYYebM5ZwXma1XRszNosR0iA6kCjzmYtxkb9twJdDE
         CWxaJwK1p63fx9fdnbGY+LpiPvz/2KqrubZEIy1jd72GL5IIIiiJ1IRQwHoqbEPVgq76
         ddUPMWPRzb1YDS5MEJALqbhNVU38IaIs9BA1dm4U4haxiqvvVdS7VxQvLBgPPleTMVDG
         X5Qb1Q22SipqywK4bNBFpuMuO0ZV4+7B6nurwgfUX1qa8IBzc2ouC9mplqvW8ID1Mopl
         ZIBlov0UBxlzsXXeYQsPfeKpaTn+X6LbmFMNSMhSahbbej2Kk6u0TzdcdZftWhDdaFbd
         6E5g==
X-Gm-Message-State: AOJu0YwGzpOX8yvlj1Nt7b1IbJMhW7B9qXyltFkSMswg9slfv0jDAgXo
        3qHNyNK3TDA5oCYCBlTM+UTFnsSsySkf
X-Google-Smtp-Source: AGHT+IGc4m2gb883pEb+0MsREcw1PRVk1IvDQNWqoxYg7BT0U+c9IQIAxXN9AyskHKCo0o2kdMT+LveO3Jmy
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a81:e302:0:b0:57a:e0b:f66 with SMTP id
 q2-20020a81e302000000b0057a0e0b0f66mr43446ywl.7.1692232237457; Wed, 16 Aug
 2023 17:30:37 -0700 (PDT)
Date:   Thu, 17 Aug 2023 00:30:22 +0000
In-Reply-To: <20230817003029.3073210-1-rananta@google.com>
Mime-Version: 1.0
References: <20230817003029.3073210-1-rananta@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230817003029.3073210-6-rananta@google.com>
Subject: [PATCH v5 05/12] KVM: arm64: PMU: Simplify extracting PMCR_EL0.N
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reiji Watanabe <reijiw@google.com>

Some code extracts PMCR_EL0.N using ARMV8_PMU_PMCR_N_SHIFT and
ARMV8_PMU_PMCR_N_MASK. Define ARMV8_PMU_PMCR_N (0x1f << 11),
and simplify those codes using FIELD_GET() and/or ARMV8_PMU_PMCR_N.
The following patches will also use these macros to extract PMCR_EL0.N.

No functional change intended.

Signed-off-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 arch/arm64/kvm/pmu-emul.c      | 3 +--
 arch/arm64/kvm/sys_regs.c      | 7 +++----
 drivers/perf/arm_pmuv3.c       | 3 +--
 include/linux/perf/arm_pmuv3.h | 2 +-
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index b87822024828a..f7b5fa16341ad 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -245,9 +245,8 @@ void kvm_pmu_vcpu_destroy(struct kvm_vcpu *vcpu)
 
 u64 kvm_pmu_valid_counter_mask(struct kvm_vcpu *vcpu)
 {
-	u64 val = __vcpu_sys_reg(vcpu, PMCR_EL0) >> ARMV8_PMU_PMCR_N_SHIFT;
+	u64 val = FIELD_GET(ARMV8_PMU_PMCR_N, __vcpu_sys_reg(vcpu, PMCR_EL0));
 
-	val &= ARMV8_PMU_PMCR_N_MASK;
 	if (val == 0)
 		return BIT(ARMV8_PMU_CYCLE_IDX);
 	else
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 39e9248c935e7..30108f09e088b 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -750,7 +750,7 @@ static u64 reset_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 		return 0;
 
 	/* Only preserve PMCR_EL0.N, and reset the rest to 0 */
-	pmcr = read_sysreg(pmcr_el0) & (ARMV8_PMU_PMCR_N_MASK << ARMV8_PMU_PMCR_N_SHIFT);
+	pmcr = read_sysreg(pmcr_el0) & ARMV8_PMU_PMCR_N;
 	if (!kvm_supports_32bit_el0())
 		pmcr |= ARMV8_PMU_PMCR_LC;
 
@@ -858,10 +858,9 @@ static bool access_pmceid(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
 
 static bool pmu_counter_idx_valid(struct kvm_vcpu *vcpu, u64 idx)
 {
-	u64 pmcr, val;
+	u64 val;
 
-	pmcr = __vcpu_sys_reg(vcpu, PMCR_EL0);
-	val = (pmcr >> ARMV8_PMU_PMCR_N_SHIFT) & ARMV8_PMU_PMCR_N_MASK;
+	val = FIELD_GET(ARMV8_PMU_PMCR_N, __vcpu_sys_reg(vcpu, PMCR_EL0));
 	if (idx >= val && idx != ARMV8_PMU_CYCLE_IDX) {
 		kvm_inject_undefined(vcpu);
 		return false;
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 08b3a1bf0ef62..7618b0adc0b8c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1128,8 +1128,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	probe->present = true;
 
 	/* Read the nb of CNTx counters supported from PMNC */
-	cpu_pmu->num_events = (armv8pmu_pmcr_read() >> ARMV8_PMU_PMCR_N_SHIFT)
-		& ARMV8_PMU_PMCR_N_MASK;
+	cpu_pmu->num_events = FIELD_GET(ARMV8_PMU_PMCR_N, armv8pmu_pmcr_read());
 
 	/* Add the CPU cycles counter */
 	cpu_pmu->num_events += 1;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index e3899bd77f5cc..ecbcf3f93560c 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -216,7 +216,7 @@
 #define ARMV8_PMU_PMCR_LC	(1 << 6) /* Overflow on 64 bit cycle counter */
 #define ARMV8_PMU_PMCR_LP	(1 << 7) /* Long event counter enable */
 #define ARMV8_PMU_PMCR_N_SHIFT	11  /* Number of counters supported */
-#define ARMV8_PMU_PMCR_N_MASK	0x1f
+#define	ARMV8_PMU_PMCR_N	(0x1f << ARMV8_PMU_PMCR_N_SHIFT)
 #define ARMV8_PMU_PMCR_MASK	0xff    /* Mask for writable bits */
 
 /*
-- 
2.41.0.694.ge786442a9b-goog

