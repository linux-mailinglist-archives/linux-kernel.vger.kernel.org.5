Return-Path: <linux-kernel+bounces-131382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFAB8986FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90082292F48
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E312D761;
	Thu,  4 Apr 2024 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY7HjqFv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606C1272A3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232818; cv=none; b=NOVJ5l+mSUKXRdAOIWlTPWrHbZXAjQgxc9OdiARiP5SB0Gp6iVsjy5bF4MpXFHn381jaPodMNN8x4qDl8qTkPfqGv8jX0ymdpeCmCGROViLmI3exDm3NccjE6wIUdCWAXx6UA4EjT1/POIfXlV9TSKMR2HGDK1Q1IEG5CBypfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232818; c=relaxed/simple;
	bh=1N3MxIzBu26cE5jNEkXTEaTTm5CSDrbNhhSaTNBwp9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYOvs2hELY/0qBOLalaKIPkJMaoO/RWEzy+/X7pE8rkJlCKSG/5sXNHCDNRo9OTYQONtkIlcM2VWN0dcITG4UwZXhtXjS70/nrelIKTXnI9eK/Fu4rUKfiG/3qwM4wJVfEOajffdlk4V9ewxXkRrBUEuzK8nw/HEkmI2wDq1cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY7HjqFv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712232814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S82eO0Z+sWLBuyBT2eQcuDl5jI3u7CRE2rz5Dw+T/tU=;
	b=WY7HjqFvJerHKrCoTe5JDzin7IFZTFLIW/lsUXUAalkQm8qPYSd929YuTsG0EFHeG5IrWF
	64y7BDpKeb9bDiDqF0+FaV1RH/fBADnwrI6Oy7Ltaw2QCAA/J5M/ZFDkfj2ZUX4e02e4lI
	dhN2GoygxUk19BVWx0axcbyznwLH50Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-5P9e3HFUMAeaTCZw6EvZyg-1; Thu, 04 Apr 2024 08:13:30 -0400
X-MC-Unique: 5P9e3HFUMAeaTCZw6EvZyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3A84101A521;
	Thu,  4 Apr 2024 12:13:29 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8DAC9200A386;
	Thu,  4 Apr 2024 12:13:29 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: michael.roth@amd.com,
	isaku.yamahata@intel.com
Subject: [PATCH v5 07/17] KVM: x86: add fields to struct kvm_arch for CoCo features
Date: Thu,  4 Apr 2024 08:13:17 -0400
Message-ID: <20240404121327.3107131-8-pbonzini@redhat.com>
In-Reply-To: <20240404121327.3107131-1-pbonzini@redhat.com>
References: <20240404121327.3107131-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Some VM types have characteristics in common; in fact, the only use
of VM types right now is kvm_arch_has_private_mem and it assumes that
_all_ nonzero VM types have private memory.

We will soon introduce a VM type for SEV and SEV-ES VMs, and at that
point we will have two special characteristics of confidential VMs
that depend on the VM type: not just if memory is private, but
also whether guest state is protected.  For the latter we have
kvm->arch.guest_state_protected, which is only set on a fully initialized
VM.

For VM types with protected guest state, we can actually fix a problem in
the SEV-ES implementation, where ioctls to set registers do not cause an
error even if the VM has been initialized and the guest state encrypted.
Make sure that when using VM types that will become an error.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240209183743.22030-7-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  7 ++-
 arch/x86/kvm/x86.c              | 93 ++++++++++++++++++++++++++-------
 2 files changed, 79 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 04c430eb25cf..3d56b5bb10e9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1279,12 +1279,14 @@ enum kvm_apicv_inhibit {
 };
 
 struct kvm_arch {
-	unsigned long vm_type;
 	unsigned long n_used_mmu_pages;
 	unsigned long n_requested_mmu_pages;
 	unsigned long n_max_mmu_pages;
 	unsigned int indirect_shadow_pages;
 	u8 mmu_valid_gen;
+	u8 vm_type;
+	bool has_private_mem;
+	bool has_protected_state;
 	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	struct list_head active_mmu_pages;
 	struct list_head zapped_obsolete_pages;
@@ -2153,8 +2155,9 @@ void kvm_mmu_new_pgd(struct kvm_vcpu *vcpu, gpa_t new_pgd);
 void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 		       int tdp_max_root_level, int tdp_huge_page_level);
 
+
 #ifdef CONFIG_KVM_PRIVATE_MEM
-#define kvm_arch_has_private_mem(kvm) ((kvm)->arch.vm_type != KVM_X86_DEFAULT_VM)
+#define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #else
 #define kvm_arch_has_private_mem(kvm) false
 #endif
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3934e7682734..d4a8d896798f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5555,11 +5555,15 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
-static void kvm_vcpu_ioctl_x86_get_debugregs(struct kvm_vcpu *vcpu,
-					     struct kvm_debugregs *dbgregs)
+static int kvm_vcpu_ioctl_x86_get_debugregs(struct kvm_vcpu *vcpu,
+					    struct kvm_debugregs *dbgregs)
 {
 	unsigned int i;
 
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	memset(dbgregs, 0, sizeof(*dbgregs));
 
 	BUILD_BUG_ON(ARRAY_SIZE(vcpu->arch.db) != ARRAY_SIZE(dbgregs->db));
@@ -5568,6 +5572,7 @@ static void kvm_vcpu_ioctl_x86_get_debugregs(struct kvm_vcpu *vcpu,
 
 	dbgregs->dr6 = vcpu->arch.dr6;
 	dbgregs->dr7 = vcpu->arch.dr7;
+	return 0;
 }
 
 static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
@@ -5575,6 +5580,10 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 {
 	unsigned int i;
 
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	if (dbgregs->flags)
 		return -EINVAL;
 
@@ -5595,8 +5604,8 @@ static int kvm_vcpu_ioctl_x86_set_debugregs(struct kvm_vcpu *vcpu,
 }
 
 
-static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
-					  u8 *state, unsigned int size)
+static int kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
+					 u8 *state, unsigned int size)
 {
 	/*
 	 * Only copy state for features that are enabled for the guest.  The
@@ -5614,24 +5623,25 @@ static void kvm_vcpu_ioctl_x86_get_xsave2(struct kvm_vcpu *vcpu,
 			     XFEATURE_MASK_FPSSE;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
-		return;
+		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
 
 	fpu_copy_guest_fpstate_to_uabi(&vcpu->arch.guest_fpu, state, size,
 				       supported_xcr0, vcpu->arch.pkru);
+	return 0;
 }
 
-static void kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
-					 struct kvm_xsave *guest_xsave)
+static int kvm_vcpu_ioctl_x86_get_xsave(struct kvm_vcpu *vcpu,
+					struct kvm_xsave *guest_xsave)
 {
-	kvm_vcpu_ioctl_x86_get_xsave2(vcpu, (void *)guest_xsave->region,
-				      sizeof(guest_xsave->region));
+	return kvm_vcpu_ioctl_x86_get_xsave2(vcpu, (void *)guest_xsave->region,
+					     sizeof(guest_xsave->region));
 }
 
 static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					struct kvm_xsave *guest_xsave)
 {
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
-		return 0;
+		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
 
 	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
 					      guest_xsave->region,
@@ -5639,18 +5649,23 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 					      &vcpu->arch.pkru);
 }
 
-static void kvm_vcpu_ioctl_x86_get_xcrs(struct kvm_vcpu *vcpu,
-					struct kvm_xcrs *guest_xcrs)
+static int kvm_vcpu_ioctl_x86_get_xcrs(struct kvm_vcpu *vcpu,
+				       struct kvm_xcrs *guest_xcrs)
 {
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	if (!boot_cpu_has(X86_FEATURE_XSAVE)) {
 		guest_xcrs->nr_xcrs = 0;
-		return;
+		return 0;
 	}
 
 	guest_xcrs->nr_xcrs = 1;
 	guest_xcrs->flags = 0;
 	guest_xcrs->xcrs[0].xcr = XCR_XFEATURE_ENABLED_MASK;
 	guest_xcrs->xcrs[0].value = vcpu->arch.xcr0;
+	return 0;
 }
 
 static int kvm_vcpu_ioctl_x86_set_xcrs(struct kvm_vcpu *vcpu,
@@ -5658,6 +5673,10 @@ static int kvm_vcpu_ioctl_x86_set_xcrs(struct kvm_vcpu *vcpu,
 {
 	int i, r = 0;
 
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	if (!boot_cpu_has(X86_FEATURE_XSAVE))
 		return -EINVAL;
 
@@ -6040,7 +6059,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_GET_DEBUGREGS: {
 		struct kvm_debugregs dbgregs;
 
-		kvm_vcpu_ioctl_x86_get_debugregs(vcpu, &dbgregs);
+		r = kvm_vcpu_ioctl_x86_get_debugregs(vcpu, &dbgregs);
+		if (r < 0)
+			break;
 
 		r = -EFAULT;
 		if (copy_to_user(argp, &dbgregs,
@@ -6070,7 +6091,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!u.xsave)
 			break;
 
-		kvm_vcpu_ioctl_x86_get_xsave(vcpu, u.xsave);
+		r = kvm_vcpu_ioctl_x86_get_xsave(vcpu, u.xsave);
+		if (r < 0)
+			break;
 
 		r = -EFAULT;
 		if (copy_to_user(argp, u.xsave, sizeof(struct kvm_xsave)))
@@ -6099,7 +6122,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!u.xsave)
 			break;
 
-		kvm_vcpu_ioctl_x86_get_xsave2(vcpu, u.buffer, size);
+		r = kvm_vcpu_ioctl_x86_get_xsave2(vcpu, u.buffer, size);
+		if (r < 0)
+			break;
 
 		r = -EFAULT;
 		if (copy_to_user(argp, u.xsave, size))
@@ -6115,7 +6140,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!u.xcrs)
 			break;
 
-		kvm_vcpu_ioctl_x86_get_xcrs(vcpu, u.xcrs);
+		r = kvm_vcpu_ioctl_x86_get_xcrs(vcpu, u.xcrs);
+		if (r < 0)
+			break;
 
 		r = -EFAULT;
 		if (copy_to_user(argp, u.xcrs,
@@ -6259,6 +6286,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 #endif
 	case KVM_GET_SREGS2: {
+		r = -EINVAL;
+		if (vcpu->kvm->arch.has_protected_state &&
+		    vcpu->arch.guest_state_protected)
+			goto out;
+
 		u.sregs2 = kzalloc(sizeof(struct kvm_sregs2), GFP_KERNEL);
 		r = -ENOMEM;
 		if (!u.sregs2)
@@ -6271,6 +6303,11 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SET_SREGS2: {
+		r = -EINVAL;
+		if (vcpu->kvm->arch.has_protected_state &&
+		    vcpu->arch.guest_state_protected)
+			goto out;
+
 		u.sregs2 = memdup_user(argp, sizeof(struct kvm_sregs2));
 		if (IS_ERR(u.sregs2)) {
 			r = PTR_ERR(u.sregs2);
@@ -11478,6 +11515,10 @@ static void __get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 	__get_regs(vcpu, regs);
 	vcpu_put(vcpu);
@@ -11519,6 +11560,10 @@ static void __set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 	__set_regs(vcpu, regs);
 	vcpu_put(vcpu);
@@ -11591,6 +11636,10 @@ static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2)
 int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 	__get_sregs(vcpu, sregs);
 	vcpu_put(vcpu);
@@ -11858,6 +11907,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 {
 	int ret;
 
+	if (vcpu->kvm->arch.has_protected_state &&
+	    vcpu->arch.guest_state_protected)
+		return -EINVAL;
+
 	vcpu_load(vcpu);
 	ret = __set_sregs(vcpu, sregs);
 	vcpu_put(vcpu);
@@ -11975,7 +12028,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	struct fxregs_state *fxsave;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
-		return 0;
+		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
 
 	vcpu_load(vcpu);
 
@@ -11998,7 +12051,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	struct fxregs_state *fxsave;
 
 	if (fpstate_is_confidential(&vcpu->arch.guest_fpu))
-		return 0;
+		return vcpu->kvm->arch.has_protected_state ? -EINVAL : 0;
 
 	vcpu_load(vcpu);
 
@@ -12524,6 +12577,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		return -EINVAL;
 
 	kvm->arch.vm_type = type;
+	kvm->arch.has_private_mem =
+		(type == KVM_X86_SW_PROTECTED_VM);
 
 	ret = kvm_page_track_init(kvm);
 	if (ret)
-- 
2.43.0



