Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0B176FE39
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjHDKOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHDKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:13:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D87C94C27
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:13:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 524F8113E;
        Fri,  4 Aug 2023 03:14:28 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.3.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5AF93F6C4;
        Fri,  4 Aug 2023 03:13:42 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev
Cc:     James Clark <james.clark@arm.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] arm64: KVM: Add support for exclude_guest and exclude_host for ETM
Date:   Fri,  4 Aug 2023 11:13:11 +0100
Message-Id: <20230804101317.460697-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804101317.460697-1-james.clark@arm.com>
References: <20230804101317.460697-1-james.clark@arm.com>
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

Add an interface for the Coresight driver to use to set the current
exclude settings for the current CPU. This will be used to configure
TRFCR_EL1.

The settings must be copied to the vCPU before each run in the same
way that PMU events are because the per-cpu struct isn't accessible in
protected mode.

This is only needed for nVHE, otherwise it works automatically with
TRFCR_EL{1,2}. Unfortunately it can't be gated on CONFIG_CORESIGHT
because Coresight can be built as a module. It can however be gated on
CONFIG_PERF_EVENTS because that is required by Coresight.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 10 ++++++-
 arch/arm64/kvm/Makefile           |  1 +
 arch/arm64/kvm/arm.c              |  1 +
 arch/arm64/kvm/etm.c              | 48 +++++++++++++++++++++++++++++++
 include/kvm/etm.h                 | 43 +++++++++++++++++++++++++++
 5 files changed, 102 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/etm.c
 create mode 100644 include/kvm/etm.h

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d7b1403a3fb2..f33262217c84 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -35,6 +35,7 @@
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 #include <kvm/arm_pmu.h>
+#include <kvm/etm.h>
 
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
 
@@ -500,7 +501,7 @@ struct kvm_vcpu_arch {
 	u8 cflags;
 
 	/* Input flags to the hypervisor code, potentially cleared after use */
-	u8 iflags;
+	u16 iflags;
 
 	/* State flags for kernel bookkeeping, unused by the hypervisor code */
 	u8 sflags;
@@ -541,6 +542,9 @@ struct kvm_vcpu_arch {
 		u64 pmscr_el1;
 		/* Self-hosted trace */
 		u64 trfcr_el1;
+		/* exclude_guest settings for nVHE */
+		struct kvm_etm_event etm_event;
+
 	} host_debug_state;
 
 	/* VGIC state */
@@ -713,6 +717,8 @@ struct kvm_vcpu_arch {
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 /* vcpu running in HYP context */
 #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
+/* Save TRFCR and apply exclude_guest rules */
+#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
@@ -1096,6 +1102,8 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u32 clr);
 bool kvm_set_pmuserenr(u64 val);
+void kvm_set_etm_events(struct perf_event_attr *attr);
+void kvm_clr_etm_events(void);
 #else
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index c0c050e53157..0faff57423c4 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -23,6 +23,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
+kvm-$(CONFIG_PERF_EVENTS) += etm.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b1a9d47fb2f3..7bd5975328a3 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -952,6 +952,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		kvm_vgic_flush_hwstate(vcpu);
 
 		kvm_pmu_update_vcpu_events(vcpu);
+		kvm_etm_update_vcpu_events(vcpu);
 
 		/*
 		 * Ensure we set mode to IN_GUEST_MODE after we disable
diff --git a/arch/arm64/kvm/etm.c b/arch/arm64/kvm/etm.c
new file mode 100644
index 000000000000..359c37745de2
--- /dev/null
+++ b/arch/arm64/kvm/etm.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/kvm_host.h>
+
+#include <kvm/etm.h>
+
+static DEFINE_PER_CPU(struct kvm_etm_event, kvm_etm_events);
+
+struct kvm_etm_event *kvm_get_etm_event(void)
+{
+	return this_cpu_ptr(&kvm_etm_events);
+}
+
+void kvm_etm_set_events(struct perf_event_attr *attr)
+{
+	struct kvm_etm_event *etm_event;
+
+	/*
+	 * Exclude guest option only requires extra work with nVHE.
+	 * Otherwise it works automatically with TRFCR_EL{1,2}
+	 */
+	if (has_vhe())
+		return;
+
+	etm_event = kvm_get_etm_event();
+
+	etm_event->exclude_guest = attr->exclude_guest;
+	etm_event->exclude_host = attr->exclude_host;
+	etm_event->exclude_kernel = attr->exclude_kernel;
+	etm_event->exclude_user = attr->exclude_user;
+}
+EXPORT_SYMBOL_GPL(kvm_etm_set_events);
+
+void kvm_etm_clr_events(void)
+{
+	struct kvm_etm_event *etm_event;
+
+	if (has_vhe())
+		return;
+
+	etm_event = kvm_get_etm_event();
+
+	etm_event->exclude_guest = false;
+	etm_event->exclude_host = false;
+	etm_event->exclude_kernel = false;
+	etm_event->exclude_user = false;
+}
+EXPORT_SYMBOL_GPL(kvm_etm_clr_events);
diff --git a/include/kvm/etm.h b/include/kvm/etm.h
new file mode 100644
index 000000000000..95c4809fa2b0
--- /dev/null
+++ b/include/kvm/etm.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __KVM_DEBUG_H
+#define __KVM_DEBUG_H
+
+struct perf_event_attr;
+struct kvm_vcpu;
+
+#if IS_ENABLED(CONFIG_KVM) && IS_ENABLED(CONFIG_PERF_EVENTS)
+
+struct kvm_etm_event {
+	bool exclude_host;
+	bool exclude_guest;
+	bool exclude_kernel;
+	bool exclude_user;
+};
+
+struct kvm_etm_event *kvm_get_etm_event(void);
+void kvm_etm_clr_events(void);
+void kvm_etm_set_events(struct perf_event_attr *attr);
+
+/*
+ * Updates the vcpu's view of the etm events for this cpu. Must be
+ * called before every vcpu run after disabling interrupts, to ensure
+ * that an interrupt cannot fire and update the structure.
+ */
+#define kvm_etm_update_vcpu_events(vcpu)						\
+	do {										\
+		if (!has_vhe() && vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))		\
+			vcpu->arch.host_debug_state.etm_event = *kvm_get_etm_event();	\
+	} while (0)
+
+#else
+
+struct kvm_etm_event {};
+
+static inline void kvm_etm_update_vcpu_events(struct kvm_vcpu *vcpu) {}
+static inline void kvm_etm_set_events(struct perf_event_attr *attr) {}
+static inline void kvm_etm_clr_events(void) {}
+
+#endif
+
+#endif
-- 
2.34.1

