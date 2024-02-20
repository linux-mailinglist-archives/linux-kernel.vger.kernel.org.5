Return-Path: <linux-kernel+bounces-72787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D0685B8A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50E5284815
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE7657B9;
	Tue, 20 Feb 2024 10:10:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EBA657AC
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423856; cv=none; b=ZMXbR25BJ2HRiw+eSBFF80GVDqcok5bdOgTAgkGDNepOVHAQtOST54OAB8IZbRNwRHLnOS0GcJqMZJBCMsSHlGaPxbaWYXVCVIhAItaQVJQpuKKFM/ne2QqQG3U645NdH8L4OQhACcFW5wTuwza61Gt7IHI07DLPaqsGsBBuCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423856; c=relaxed/simple;
	bh=5KaC48hmMsOyRy4OyHf+gKTzdlX10/82H5k3TMarcvk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C+mVdEX4xyeI2lk0pZIRfxLhNfYfU2AnFyWrWKl34jtLHOLVSOTyLwzw9Hd/xuwK3lQMzmnz9QnkaZhx2ndxoGVMEPLhQFqUU8+a9H4oDNEBS9L/xgdUA3ny9NYcLPAUFoBonsI/WVcwxmOya892Sxq6lFXpNTXmQymRAEWSY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BA691007;
	Tue, 20 Feb 2024 02:11:33 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C55D33F762;
	Tue, 20 Feb 2024 02:10:48 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org
Cc: James Clark <james.clark@arm.com>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Helge Deller <deller@gmx.de>,
	Andrew Walbran <qwandor@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/7] arm64: KVM: Add interface to set guest value for TRFCR register
Date: Tue, 20 Feb 2024 10:09:15 +0000
Message-Id: <20240220100924.2761706-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220100924.2761706-1-james.clark@arm.com>
References: <20240220100924.2761706-1-james.clark@arm.com>
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

Instead of adding a load of infrastructure to share the host's per-cpu
offsets with the hypervisor, just define the new storage as a NR_CPUS
array.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  3 +++
 arch/arm64/kernel/image-vars.h    |  1 +
 arch/arm64/kvm/debug.c            | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 85b5477bd1b4..56b7f7eca195 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -509,6 +509,7 @@ struct kvm_host_psci_config {
 	bool psci_0_1_cpu_off_implemented;
 	bool psci_0_1_migrate_implemented;
 };
+extern u64 ____cacheline_aligned kvm_guest_trfcr[NR_CPUS];
 
 extern struct kvm_host_psci_config kvm_nvhe_sym(kvm_host_psci_config);
 #define kvm_host_psci_config CHOOSE_NVHE_SYM(kvm_host_psci_config)
@@ -1174,6 +1175,7 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu);
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr);
 void kvm_clr_pmu_events(u32 clr);
 bool kvm_set_pmuserenr(u64 val);
+void kvm_etm_set_guest_trfcr(u64 trfcr_guest);
 #else
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
@@ -1181,6 +1183,7 @@ static inline bool kvm_set_pmuserenr(u64 val)
 {
 	return false;
 }
+static inline void kvm_etm_set_guest_trfcr(u64 trfcr_guest) {}
 #endif
 
 void kvm_vcpu_load_vhe(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 5e4dc72ab1bd..a451e4f10804 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -59,6 +59,7 @@ KVM_NVHE_ALIAS(alt_cb_patch_nops);
 
 /* Global kernel state accessed by nVHE hyp code. */
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
+KVM_NVHE_ALIAS(kvm_guest_trfcr);
 
 /* Kernel symbols used to call panic() from nVHE hyp code (via ERET). */
 KVM_NVHE_ALIAS(nvhe_hyp_panic_handler);
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 49a13e72ddd2..c8d936ce6e2b 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -22,6 +22,7 @@
 				DBG_MDSCR_MDE)
 
 static DEFINE_PER_CPU(u64, mdcr_el2);
+u64 ____cacheline_aligned kvm_guest_trfcr[NR_CPUS];
 
 /*
  * save/restore_guest_debug_regs
@@ -359,3 +360,28 @@ void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
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
+ * value will persist and can't be modified. For pKVM, kvm_guest_trfcr can't
+ * be read by the hypervisor, so don't bother writing it.
+ */
+void kvm_etm_set_guest_trfcr(u64 trfcr_guest)
+{
+	if (WARN_ON_ONCE(!cpuid_feature_extract_unsigned_field(read_sysreg(id_aa64dfr0_el1),
+							       ID_AA64DFR0_EL1_TraceFilt_SHIFT)))
+		return;
+
+	if (has_vhe())
+		write_sysreg_s(trfcr_guest, SYS_TRFCR_EL12);
+	else if (!is_protected_kvm_enabled())
+		kvm_guest_trfcr[smp_processor_id()] = trfcr_guest;
+}
+EXPORT_SYMBOL_GPL(kvm_etm_set_guest_trfcr);
-- 
2.34.1


