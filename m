Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3987F7D000B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346343AbjJSQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345349AbjJSQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:56:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C44912F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:56:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98C552F4;
        Thu, 19 Oct 2023 09:57:00 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.67.150])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 783373F5A1;
        Thu, 19 Oct 2023 09:56:16 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, maz@kernel.org, suzuki.poulose@arm.com
Cc:     broonie@kernel.org, James Clark <james.clark@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] arm64: KVM: Add interface to set guest value for TRFCR register
Date:   Thu, 19 Oct 2023 17:55:02 +0100
Message-Id: <20231019165510.1966367-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019165510.1966367-1-james.clark@arm.com>
References: <20231019165510.1966367-1-james.clark@arm.com>
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

Add an interface for the Coresight driver to use to set the value of the
TRFCR register for the guest. This register controls the exclude
settings for trace at different exception levels, and is used to honor
the exclude_host and exclude_guest parameters from the Perf session.
This will be used to later write TRFCR_EL1 on nVHE at guest switch. For
VHE, the host trace is controlled by TRFCR_EL2 and thus we can write to
the TRFCR_EL1 immediately. Because guest writes to the register are
trapped, the value will persist and can't be modified.

The settings must be copied to the vCPU before each run in the same
way that PMU events are, because the per-cpu struct isn't accessible in
protected mode.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/debug.c            | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0f0bf8e641bd..e1852102550d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1125,6 +1125,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u32 clr);
 bool kvm_set_pmuserenr(u64 val);
+void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
+void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu);
 #else
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
@@ -1132,6 +1134,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
 {
 	return false;
 }
+static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
 #endif
 
 void kvm_vcpu_load_sysregs_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0f717b6a9151..e4d846f2f665 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1015,6 +1015,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		kvm_vgic_flush_hwstate(vcpu);
 
 		kvm_pmu_update_vcpu_events(vcpu);
+		kvm_etm_update_vcpu_events(vcpu);
 
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 20cdd40b3c42..2ab41b954512 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -23,6 +23,12 @@
 
 static DEFINE_PER_CPU(u64, mdcr_el2);
 
+/*
+ * Per CPU value for TRFCR that should be applied to any guest vcpu that may
+ * run on that core in the future.
+ */
+static DEFINE_PER_CPU(u64, guest_trfcr);
+
 /**
  * save/restore_guest_debug_regs
  *
@@ -356,3 +362,23 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
+
+void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
+{
+	if (has_vhe())
+		write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
+	else
+		*this_cpu_ptr(&guest_trfcr) = trfcr_guest;
+}
+EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
+
+/*
+ * Updates the vcpu's view of the etm events for this cpu. Must be
+ * called before every vcpu run after disabling interrupts, to ensure
+ * that an interrupt cannot fire and update the structure.
+ */
+void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu)
+{
+	if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
+		ctxt_sys_reg(&vcpu->arch.ctxt, TRFCR_EL1) = *this_cpu_ptr(&guest_trfcr);
+}
-- 
2.34.1

