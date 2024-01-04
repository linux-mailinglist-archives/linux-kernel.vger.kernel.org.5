Return-Path: <linux-kernel+bounces-16930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99882462B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF851F24391
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE025568;
	Thu,  4 Jan 2024 16:28:49 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2625562
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 962E11007;
	Thu,  4 Jan 2024 08:29:33 -0800 (PST)
Received: from e127643.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2026E3F5A1;
	Thu,  4 Jan 2024 08:28:38 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	broonie@kernel.org,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org
Cc: James Clark <james.clark@arm.com>,
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
	Miguel Luis <miguel.luis@oracle.com>,
	Jintack Lim <jintack.lim@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kalesh Singh <kaleshsingh@google.com>,
	Quentin Perret <qperret@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Fuad Tabba <tabba@google.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] arm64: KVM: Add interface to set guest value for TRFCR register
Date: Thu,  4 Jan 2024 16:27:05 +0000
Message-Id: <20240104162714.1062610-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104162714.1062610-1-james.clark@arm.com>
References: <20240104162714.1062610-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an interface for the Coresight driver to use to set the value of the
TRFCR register for the guest. This register controls the exclude
settings for trace at different exception levels, and is used to honor
the exclude_host and exclude_guest parameters from the Perf session.
This will be used to later write TRFCR_EL1 on nVHE at guest switch. For
VHE, the host trace is controlled by TRFCR_EL2 and thus we can write to
the TRFCR_EL1 immediately. Because guest writes to the register are
trapped, the value will persist and can't be modified.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kvm/debug.c            | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 4864a1fcdf89..ee6cba7ee6ee 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -471,6 +471,7 @@ struct kvm_host_global_state {
 		u32 events_host;
 		u32 events_guest;
 	} pmu_events;
+	u64 guest_trfcr_el1;
 } ____cacheline_aligned;
 extern struct kvm_host_global_state kvm_host_global_state[NR_CPUS];
 
@@ -1145,6 +1146,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u32 clr);
 bool kvm_set_pmuserenr(u64 val);
+void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
 #else
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
@@ -1152,6 +1154,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
 {
 	return false;
 }
+static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
 #endif
 
 void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index f86cbfae60f3..d69a0b9d9575 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -358,3 +358,27 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
+
+/*
+ * Interface for the Coresight driver to use to set the value of the TRFCR
+ * register for the guest. This register controls the exclude settings for trace
+ * at different exception levels, and is used to honor the exclude_host and
+ * exclude_guest parameters from the Perf session.
+ *
+ * This will be used to later write TRFCR_EL1 on nVHE at guest switch. For VHE,
+ * the host trace is controlled by TRFCR_EL2 and thus we can write to the
+ * TRFCR_EL1 immediately. Because guest writes to the register are trapped, the
+ * value will persist and can't be modified.
+ */
+void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
+{
+	if (!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
+						  ID_AA64DFR0_EL1_TraceFilt_SHIFT))
+		return;
+
+	if (has_vhe())
+		write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
+	else
+		kvm_host_global_state[smp_processor_id()].guest_trfcr_el1 = trfcr_guest;
+}
+EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
-- 
2.34.1


