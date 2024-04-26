Return-Path: <linux-kernel+bounces-159902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94B8B35FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25151C21B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E7114534B;
	Fri, 26 Apr 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mnhqi9zW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787D144D3E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128603; cv=none; b=IGW0oSHIWQvN8pVERSMwDrX01U6xrghtKN/YGBeAMrMEEfWxrduwt7zJT8Z2kecW6+6xTQlpATUCkD7bsd8izrXEoy+ZDsvRQLzdIvy/YwYIKEd0hgE4WVHDGHQW9P7WlZcxi1ojdMQ4g/oM1q6ImPzP2VBTCmhqEFljriL6QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128603; c=relaxed/simple;
	bh=utF6bK/ynDvKtFTtpZCiM6gnQeq7mtq++CnFbpesggk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8i0iaFSY4jfY/ilUkd9XrLzw7x1qJXF1t6v0CeqvOEs3g6P9R7Ea0xOv5PseZeRBoCeuT5TGPFo6lfosqT8x0xzeQcO94TSmNleAsekLS4Zj3GTtbqQFI9r+Iqdc98iEgMUAKl/JDKZ7scMyi9yckr6uq7zl4N1cEb3STmxWW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mnhqi9zW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714128600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cGbSr+4fcHT2eAsfJezUbtC5iwN5BsiYgVJ4o5jDSLU=;
	b=Mnhqi9zW+3amQDPqTObmpwIF60z/hHhz0ab3XAjVgBZ5J6PhrIWpUKIakGuulOhFNap26O
	O4qPbOXIid01HAe3krdO1tnjLv7YWC/vtjCLMXScx0iWJuD+4DTrH5mkbL0eOlqOkQD2H5
	y+FQoBZq6hhjTsR5uQ11PR6yx2go3OI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-R0eUjCgiMuGLIXk9TF7xxg-1; Fri, 26 Apr 2024 06:49:59 -0400
X-MC-Unique: R0eUjCgiMuGLIXk9TF7xxg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78319f64126so265001885a.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128599; x=1714733399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGbSr+4fcHT2eAsfJezUbtC5iwN5BsiYgVJ4o5jDSLU=;
        b=fcqyRizxuYR2BauuMhKW5zp3lu0fdXfFpm1g92dYGaS71HWiGlUqWgy3sDPRdQ13cW
         eX8YvnujLtMQQho0LHNW1AdyEMBWLhJSjju1+50mBbmNiCfkmwFKTlwM48nw+vobccWu
         kiCIaAMVmdo97TNWv0YuTAgNPnocoKtMihrLFc5U3JYbUrRLFPZBZqvRjSQK1rtpBB9k
         //htqbEtdVB2C1UG5YzPSE/mfNzUWgElzu2PRymz8L/ZMpbDswgxGgJaM7TLjfyXcHBz
         sJlvoFg3O9lDFwgVAfTuE90/0zv4YJUs1QMb5eggpRMfDId4vT52L1lWTqAd3TzLYd0M
         gGVw==
X-Forwarded-Encrypted: i=1; AJvYcCVaAsNnoPQtSgY6zBDB4UByNdMMcPgI+71Je64mC3VQ8HusVMTW9vyIIoNI5l3J8VyWU26duqJl/W51SlB9tQPm5TmfJCt+kMLye5ap
X-Gm-Message-State: AOJu0YwRKh+IZWU/4cXDRoyQscL3FmxhZguivrqnRag1Sw8BkR/3kgPH
	1Cvl5R5mwWfj186RN5QjucbcuxfJnUH9Whn7Yg4Bd7YhvFcKFLbs65YyHuTbi9hTNLLzBB/sSU+
	fym0kjMSP6jOiiDOwz1l0YjXWWoc3R5TztTHEe+3Xw0ISc5ctLSBsNo8LJeSHhw==
X-Received: by 2002:a05:620a:992:b0:78e:e479:3ddb with SMTP id x18-20020a05620a099200b0078ee4793ddbmr2394287qkx.23.1714128598874;
        Fri, 26 Apr 2024 03:49:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHh18C4THl4Xonjz0GTh9Qrl3LA0jHHF1NCbVJUxnZ8bmimP/NV7dkk5fFTYl157a5HGhORJQ==
X-Received: by 2002:a05:620a:992:b0:78e:e479:3ddb with SMTP id x18-20020a05620a099200b0078ee4793ddbmr2394272qkx.23.1714128598452;
        Fri, 26 Apr 2024 03:49:58 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f4cc600a5cdf10de606b5e2.dip0.t-ipconnect.de. [2003:c9:3f4c:c600:a5cd:f10d:e606:b5e2])
        by smtp.gmail.com with ESMTPSA id vv26-20020a05620a563a00b007907b57aa1fsm3888019qkn.12.2024.04.26.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:49:58 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 2/6] KVM: arm64: unify trap setup code
Date: Fri, 26 Apr 2024 12:49:46 +0200
Message-ID: <20240426104950.7382-3-sebott@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426104950.7382-1-sebott@redhat.com>
References: <20240426104950.7382-1-sebott@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 functions to set up traps via HCR_EL2:
* kvm_init_sysreg() called via KVM_RUN (before the 1st run or when
  the pid changes)
* vcpu_reset_hcr() called via KVM_ARM_VCPU_INIT

To unify these 2 and to support traps that are dependent on the
ID register configuration, move vcpu_reset_hcr() to sys_regs.c
and call it via kvm_init_sysreg().

While at it rename kvm_init_sysreg() to kvm_setup_traps() to
better reflect what it's doing.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 37 -----------------------
 arch/arm64/include/asm/kvm_host.h    |  2 +-
 arch/arm64/kvm/arm.c                 |  3 +-
 arch/arm64/kvm/sys_regs.c            | 44 ++++++++++++++++++++++++++--
 4 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 975af30af31f..9e71fcbb033d 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -67,43 +67,6 @@ static __always_inline bool vcpu_el1_is_32bit(struct kvm_vcpu *vcpu)
 }
 #endif
 
-static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
-{
-	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
-	if (has_vhe() || has_hvhe())
-		vcpu->arch.hcr_el2 |= HCR_E2H;
-	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
-		/* route synchronous external abort exceptions to EL2 */
-		vcpu->arch.hcr_el2 |= HCR_TEA;
-		/* trap error record accesses */
-		vcpu->arch.hcr_el2 |= HCR_TERR;
-	}
-
-	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB)) {
-		vcpu->arch.hcr_el2 |= HCR_FWB;
-	} else {
-		/*
-		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
-		 * get set in SCTLR_EL1 such that we can detect when the guest
-		 * MMU gets turned on and do the necessary cache maintenance
-		 * then.
-		 */
-		vcpu->arch.hcr_el2 |= HCR_TVM;
-	}
-
-	if (cpus_have_final_cap(ARM64_HAS_EVT) &&
-	    !cpus_have_final_cap(ARM64_MISMATCHED_CACHE_TYPE))
-		vcpu->arch.hcr_el2 |= HCR_TID4;
-	else
-		vcpu->arch.hcr_el2 |= HCR_TID2;
-
-	if (vcpu_el1_is_32bit(vcpu))
-		vcpu->arch.hcr_el2 &= ~HCR_RW;
-
-	if (kvm_has_mte(vcpu->kvm))
-		vcpu->arch.hcr_el2 |= HCR_ATA;
-}
-
 static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
 {
 	return (unsigned long *)&vcpu->arch.hcr_el2;
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9e8a496fb284..696acba883c1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1115,7 +1115,7 @@ int __init populate_nv_trap_config(void);
 bool lock_all_vcpus(struct kvm *kvm);
 void unlock_all_vcpus(struct kvm *kvm);
 
-void kvm_init_sysreg(struct kvm_vcpu *);
+void kvm_setup_traps(struct kvm_vcpu *);
 
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c4a0a35e02c7..d6c27d8a8f2f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -683,7 +683,7 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	 * This needs to happen after NV has imposed its own restrictions on
 	 * the feature set
 	 */
-	kvm_init_sysreg(vcpu);
+	kvm_setup_traps(vcpu);
 
 	ret = kvm_timer_enable(vcpu);
 	if (ret)
@@ -1438,7 +1438,6 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 			icache_inval_all_pou();
 	}
 
-	vcpu_reset_hcr(vcpu);
 	vcpu->arch.cptr_el2 = kvm_get_reset_cptr_el2(vcpu);
 
 	/*
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 131f5b0ca2b9..ac366d0b614a 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -4020,11 +4020,43 @@ int kvm_vm_ioctl_get_reg_writable_masks(struct kvm *kvm, struct reg_mask_range *
 	return 0;
 }
 
-void kvm_init_sysreg(struct kvm_vcpu *vcpu)
+static void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
 
-	mutex_lock(&kvm->arch.config_lock);
+	vcpu->arch.hcr_el2 = HCR_GUEST_FLAGS;
+	if (has_vhe() || has_hvhe())
+		vcpu->arch.hcr_el2 |= HCR_E2H;
+	if (cpus_have_final_cap(ARM64_HAS_RAS_EXTN)) {
+		/* route synchronous external abort exceptions to EL2 */
+		vcpu->arch.hcr_el2 |= HCR_TEA;
+		/* trap error record accesses */
+		vcpu->arch.hcr_el2 |= HCR_TERR;
+	}
+
+	if (cpus_have_final_cap(ARM64_HAS_STAGE2_FWB)) {
+		vcpu->arch.hcr_el2 |= HCR_FWB;
+	} else {
+		/*
+		 * For non-FWB CPUs, we trap VM ops (HCR_EL2.TVM) until M+C
+		 * get set in SCTLR_EL1 such that we can detect when the guest
+		 * MMU gets turned on and do the necessary cache maintenance
+		 * then.
+		 */
+		vcpu->arch.hcr_el2 |= HCR_TVM;
+	}
+
+	if (cpus_have_final_cap(ARM64_HAS_EVT) &&
+	    !cpus_have_final_cap(ARM64_MISMATCHED_CACHE_TYPE))
+		vcpu->arch.hcr_el2 |= HCR_TID4;
+	else
+		vcpu->arch.hcr_el2 |= HCR_TID2;
+
+	if (vcpu_el1_is_32bit(vcpu))
+		vcpu->arch.hcr_el2 &= ~HCR_RW;
+
+	if (kvm_has_mte(vcpu->kvm))
+		vcpu->arch.hcr_el2 |= HCR_ATA;
 
 	/*
 	 * In the absence of FGT, we cannot independently trap TLBI
@@ -4033,6 +4065,14 @@ void kvm_init_sysreg(struct kvm_vcpu *vcpu)
 	 */
 	if (!kvm_has_feat(kvm, ID_AA64ISAR0_EL1, TLB, OS))
 		vcpu->arch.hcr_el2 |= HCR_TTLBOS;
+}
+
+void kvm_setup_traps(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+
+	mutex_lock(&kvm->arch.config_lock);
+	vcpu_reset_hcr(vcpu);
 
 	if (cpus_have_final_cap(ARM64_HAS_HCX)) {
 		vcpu->arch.hcrx_el2 = HCRX_GUEST_FLAGS;
-- 
2.42.0


