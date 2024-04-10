Return-Path: <linux-kernel+bounces-138291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F71189EF55
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87EC11F21B26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4671581E9;
	Wed, 10 Apr 2024 09:58:21 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A961553BF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743101; cv=none; b=rtmeVrMKwGDmoR75SgkhPndkdGjKIQ6GChzW13zwqVk8QiLi3T+dvAj34uVKMPWI+gmrbpcfaYjAXZY63MC9Cxji9tucdLpocH5dAfrB/LjlFkcgqnBOPiViusa0MtLDo0n3eF/HnvbWaU+dc/1/em+jv8rl8eJ0XA8jsdMUOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743101; c=relaxed/simple;
	bh=J/EY6xsC2z3cTRH1kc8NpE3lPmh2P3JN75ltmFfqxuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+N3FzpznfLUrBYWxdg8Z8+f7mLnLsdDyN9Zav1uk24vxsYUYNSzEykXlEUFz67s83vhvEwRkN7zSJl7e77REgH7TTlw6u+yPOkVGAG7gQXslJZlJiy23trCj205spNRC1W5vAxymx+RIKaA9Rv/vIXqaArGl4uXGmajhRKI50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8Bxnru4YhZmMzAlAA--.5742S3;
	Wed, 10 Apr 2024 17:58:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhO0YhZmk1Z3AA--.44080S2;
	Wed, 10 Apr 2024 17:58:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: linux-kernel@vger.kernel.org
Cc: pbonzini@redhat.com,
	maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	loongarch@lists.linux.dev
Subject: [PATCH 1/1] LoongArch: KVM: Add PMU support
Date: Wed, 10 Apr 2024 17:58:12 +0800
Message-Id: <20240410095812.2943706-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhO0YhZmk1Z3AA--.44080S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

This patch adds KVM PMU support. We save/restore the host PMU CSR
values to kvm_context. guest entry saves the host PMU CSR and
guest exit restores the host PMU CSR when the host supports PMU

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 arch/loongarch/include/asm/kvm_csr.h   |   5 +
 arch/loongarch/include/asm/kvm_host.h  |  14 +++
 arch/loongarch/include/asm/kvm_vcpu.h  |   2 +
 arch/loongarch/include/asm/loongarch.h |   1 +
 arch/loongarch/kvm/exit.c              |   7 ++
 arch/loongarch/kvm/vcpu.c              | 140 ++++++++++++++++++++++++-
 6 files changed, 167 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/kvm_csr.h b/arch/loongarch/include/asm/kvm_csr.h
index 724ca8b7b401..dce556516c79 100644
--- a/arch/loongarch/include/asm/kvm_csr.h
+++ b/arch/loongarch/include/asm/kvm_csr.h
@@ -208,4 +208,9 @@ static __always_inline void kvm_change_sw_gcsr(struct loongarch_csrs *csr,
 	csr->csrs[gid] |= val & _mask;
 }
 
+#define KVM_PMU_PLV_ENABLE	(CSR_PERFCTRL_PLV0 |		\
+					CSR_PERFCTRL_PLV1 |	\
+					CSR_PERFCTRL_PLV2 |	\
+					CSR_PERFCTRL_PLV3)
+
 #endif	/* __ASM_LOONGARCH_KVM_CSR_H__ */
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 2d62f7b0d377..0daa0bde7742 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -54,6 +54,9 @@ struct kvm_arch_memory_slot {
 struct kvm_context {
 	unsigned long vpid_cache;
 	struct kvm_vcpu *last_vcpu;
+	/* Save host pmu csr */
+	u64 perf_ctrl[4];
+	u64 perf_cntr[4];
 };
 
 struct kvm_world_switch {
@@ -99,6 +102,7 @@ enum emulation_result {
 #define KVM_LARCH_LASX		(0x1 << 2)
 #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
 #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
+#define KVM_LARCH_PERF		(0x1 << 5)
 
 struct kvm_vcpu_arch {
 	/*
@@ -195,6 +199,16 @@ static inline bool kvm_guest_has_lasx(struct kvm_vcpu_arch *arch)
 	return arch->cpucfg[2] & CPUCFG2_LASX;
 }
 
+static inline bool kvm_guest_has_pmu(struct kvm_vcpu_arch *arch)
+{
+	return arch->cpucfg[6] & CPUCFG6_PMP;
+}
+
+static inline int kvm_get_pmu_num(struct kvm_vcpu_arch *arch)
+{
+	return (arch->cpucfg[6] & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT;
+}
+
 /* Debug: dump vcpu state */
 int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu);
 
diff --git a/arch/loongarch/include/asm/kvm_vcpu.h b/arch/loongarch/include/asm/kvm_vcpu.h
index 0cb4fdb8a9b5..7212428022d1 100644
--- a/arch/loongarch/include/asm/kvm_vcpu.h
+++ b/arch/loongarch/include/asm/kvm_vcpu.h
@@ -75,6 +75,8 @@ static inline void kvm_save_lasx(struct loongarch_fpu *fpu) { }
 static inline void kvm_restore_lasx(struct loongarch_fpu *fpu) { }
 #endif
 
+int kvm_own_pmu(struct kvm_vcpu *vcpu);
+
 void kvm_init_timer(struct kvm_vcpu *vcpu, unsigned long hz);
 void kvm_reset_timer(struct kvm_vcpu *vcpu);
 void kvm_save_timer(struct kvm_vcpu *vcpu);
diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 46366e783c84..644380b6ebec 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -119,6 +119,7 @@
 #define  CPUCFG6_PMP			BIT(0)
 #define  CPUCFG6_PAMVER			GENMASK(3, 1)
 #define  CPUCFG6_PMNUM			GENMASK(7, 4)
+#define  CPUCFG6_PMNUM_SHIFT		4
 #define  CPUCFG6_PMBITS			GENMASK(13, 8)
 #define  CPUCFG6_UPM			BIT(14)
 
diff --git a/arch/loongarch/kvm/exit.c b/arch/loongarch/kvm/exit.c
index ed1d89d53e2e..ab17d9eb711f 100644
--- a/arch/loongarch/kvm/exit.c
+++ b/arch/loongarch/kvm/exit.c
@@ -83,6 +83,13 @@ static int kvm_handle_csr(struct kvm_vcpu *vcpu, larch_inst inst)
 	rj = inst.reg2csr_format.rj;
 	csrid = inst.reg2csr_format.csr;
 
+	if (LOONGARCH_CSR_PERFCTRL0 <= csrid && csrid <= LOONGARCH_CSR_PERFCNTR3) {
+		if(!kvm_own_pmu(vcpu)) {
+			vcpu->arch.pc -= 4;
+			return EMULATE_DONE;
+		}
+	}
+
 	/* Process CSR ops */
 	switch (rj) {
 	case 0: /* process csrrd */
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 3a8779065f73..6fb59b805807 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -333,6 +333,12 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
 	case LOONGARCH_CPUCFG5:
 		*v = GENMASK(31, 0);
 		return 0;
+	case LOONGARCH_CPUCFG6:
+		if (cpu_has_pmp)
+			*v = GENMASK(14, 0);
+		else
+			*v = 0;
+		return 0;
 	case LOONGARCH_CPUCFG16:
 		*v = GENMASK(16, 0);
 		return 0;
@@ -351,7 +357,7 @@ static int _kvm_get_cpucfg_mask(int id, u64 *v)
 
 static int kvm_check_cpucfg(int id, u64 val)
 {
-	int ret;
+	int ret, host;
 	u64 mask = 0;
 
 	ret = _kvm_get_cpucfg_mask(id, &mask);
@@ -377,6 +383,18 @@ static int kvm_check_cpucfg(int id, u64 val)
 			/* LASX architecturally implies LSX and FP but val does not satisfy that */
 			return -EINVAL;
 		return 0;
+	case LOONGARCH_CPUCFG6:
+		if (val & CPUCFG6_PMP) {
+			host = read_cpucfg(LOONGARCH_CPUCFG6);
+			if ((val & CPUCFG6_PMBITS) != (host & CPUCFG6_PMBITS))
+				/* Guest pmbits must be the same with host */
+				return -EINVAL;
+			if ((val & CPUCFG6_PMNUM) > (host & CPUCFG6_PMNUM))
+				return -EINVAL;
+			if ((val & CPUCFG6_UPM) && !(host & CPUCFG6_UPM))
+				return -EINVAL;
+		}
+		return 0;
 	default:
 		/*
 		 * Values for the other CPUCFG IDs are not being further validated
@@ -552,7 +570,8 @@ static int kvm_loongarch_cpucfg_has_attr(struct kvm_vcpu *vcpu,
 					 struct kvm_device_attr *attr)
 {
 	switch (attr->attr) {
-	case 2:
+	case LOONGARCH_CPUCFG2:
+	case LOONGARCH_CPUCFG6:
 		return 0;
 	default:
 		return -ENXIO;
@@ -844,6 +863,119 @@ void kvm_lose_fpu(struct kvm_vcpu *vcpu)
 	preempt_enable();
 }
 
+static inline void kvm_save_host_pmu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_context *context;
+
+	context = this_cpu_ptr(vcpu->kvm->arch.vmcs);
+	context->perf_ctrl[0] = read_csr_perfctrl0();
+	context->perf_cntr[0] = read_csr_perfcntr0();
+	context->perf_ctrl[1] = read_csr_perfctrl1();
+	context->perf_cntr[1] = read_csr_perfcntr1();
+	context->perf_ctrl[2] = read_csr_perfctrl2();
+	context->perf_cntr[2] = read_csr_perfcntr2();
+	context->perf_ctrl[3] = read_csr_perfctrl3();
+	context->perf_cntr[3] = read_csr_perfcntr3();
+}
+
+static inline void kvm_restore_host_pmu(struct kvm_vcpu *vcpu)
+{
+	struct kvm_context *context;
+
+	context = this_cpu_ptr(vcpu->kvm->arch.vmcs);
+	write_csr_perfctrl0(context->perf_ctrl[0]);
+	write_csr_perfcntr0(context->perf_cntr[0]);
+	write_csr_perfctrl1(context->perf_ctrl[1]);
+	write_csr_perfcntr1(context->perf_cntr[1]);
+	write_csr_perfctrl2(context->perf_ctrl[2]);
+	write_csr_perfcntr2(context->perf_cntr[2]);
+	write_csr_perfctrl3(context->perf_ctrl[3]);
+	write_csr_perfcntr3(context->perf_cntr[3]);
+}
+
+static inline void kvm_save_guest_pmu(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR0);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR1);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR2);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
+	kvm_save_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR3);
+	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL0, 0);
+	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL1, 0);
+	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL2, 0);
+	kvm_write_hw_gcsr(LOONGARCH_CSR_PERFCTRL3, 0);
+}
+
+static inline void kvm_restore_guest_pmu(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR0);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR1);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR2);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3);
+	kvm_restore_hw_gcsr(csr, LOONGARCH_CSR_PERFCNTR3);
+}
+
+static void _kvm_own_pmu(struct kvm_vcpu *vcpu)
+{
+	unsigned long val;
+
+	kvm_save_host_pmu(vcpu);
+	/* Set PM0-PM(num) to Guest */
+	val = read_csr_gcfg() & ~CSR_GCFG_GPERF;
+	val |= (kvm_get_pmu_num(&vcpu->arch) + 1) << CSR_GCFG_GPERF_SHIFT;
+	write_csr_gcfg(val);
+	kvm_restore_guest_pmu(vcpu);
+}
+
+int kvm_own_pmu(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_guest_has_pmu(&vcpu->arch))
+		return -EINVAL;
+
+	preempt_disable();
+	_kvm_own_pmu(vcpu);
+	vcpu->arch.aux_inuse |= KVM_LARCH_PERF;
+	preempt_enable();
+	return 0;
+}
+
+static void kvm_lose_pmu(struct kvm_vcpu *vcpu)
+{
+	struct loongarch_csrs *csr = vcpu->arch.csr;
+
+	if (!(vcpu->arch.aux_inuse & KVM_LARCH_PERF))
+		return;
+
+	kvm_save_guest_pmu(vcpu);
+	/* Disable pmu access from guest */
+	write_csr_gcfg(read_csr_gcfg() & ~CSR_GCFG_GPERF);
+	if (((kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL0) |
+		kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL1) |
+		kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL2) |
+		kvm_read_sw_gcsr(csr, LOONGARCH_CSR_PERFCTRL3))
+			& KVM_PMU_PLV_ENABLE) == 0)
+		vcpu->arch.aux_inuse &= ~KVM_LARCH_PERF;
+	kvm_restore_host_pmu(vcpu);
+}
+
+static void kvm_restore_pmu(struct kvm_vcpu *vcpu)
+{
+	if (!(vcpu->arch.aux_inuse & KVM_LARCH_PERF))
+		return;
+
+	_kvm_own_pmu(vcpu);
+}
+
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 {
 	int intr = (int)irq->irq;
@@ -982,6 +1114,9 @@ static int _kvm_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	/* Control guest page CCA attribute */
 	change_csr_gcfg(CSR_GCFG_MATC_MASK, CSR_GCFG_MATC_ROOT);
 
+	/* Restore hardware perf csr */
+	kvm_restore_pmu(vcpu);
+
 	/* Don't bother restoring registers multiple times unless necessary */
 	if (vcpu->arch.aux_inuse & KVM_LARCH_HWCSR_USABLE)
 		return 0;
@@ -1065,6 +1200,7 @@ static int _kvm_vcpu_put(struct kvm_vcpu *vcpu, int cpu)
 	struct loongarch_csrs *csr = vcpu->arch.csr;
 
 	kvm_lose_fpu(vcpu);
+	kvm_lose_pmu(vcpu);
 
 	/*
 	 * Update CSR state from hardware if software CSR state is stale,
-- 
2.39.3


