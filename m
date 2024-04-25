Return-Path: <linux-kernel+bounces-159362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF198B2DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6055BB22A25
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDA1DFF2;
	Thu, 25 Apr 2024 23:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mbjGI7qx"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93B156F3D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714088400; cv=none; b=G+LgP4YRsj4RIgqpR1u0O0V/qiRKix0MlktKYKf2FFkc2Zcw/JqdYyKF2J2/bK9+s9omcfw4iWka3GaAw+UCW8A+8rApqaHp14Ly1ayHTxOQ7miScc/yq2lOKMkAmaF6CKBtki5ciFgqLD2gJ7HAfb362Gds5F6dKKUC9ftHs/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714088400; c=relaxed/simple;
	bh=u0lb4oEcZFhRwqHLflAlZi4AVPo3Csa5cR5x94rnGgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jCZs6RC90rfYrSRYTCf0xKbTXqVABRRK+rpVN2j8Ymx4c7owaGODrJm9WMPNQiVSN5RR1gUnW14I9IAhD+aZ+gQS6POutv4b/ng9GOwyFgpIh/k6lqJyuNjL+6ChuXQtG7MUO54WvnmU08kpRHIYxjeo9rN8wzmXAvl5d/i+bFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mbjGI7qx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5cec8bc5c66so1355238a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714088398; x=1714693198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IUxUfKFq5lce0AjD/oJDwXVLlkKMz5g8I16agotNVL4=;
        b=mbjGI7qx6U/Uo5P/vMKiZ40FneSsARjUICbK0shH+eS000q5s+aGFv7V/GpoLIhDsY
         aLUZQdH8ki8UeIudqKoQzlULAz5l1O4KSnYyu1oO2W0b4elsC6tfDLFno2fHHiwsI2Pl
         abTB1gD1rm5LBNkfcfGQY1U8F/5eyoEb9eHNhlOf3twiRJwctuh3iwXxn/jmCABgk/K5
         c36rQJN7D8FnXqpuKiKf5qJ7WBcr+hsvGNHTPpUW2cvDZho/Ha8dtK4AKEo08jSACzis
         jijq4JcsIBLqG9e6NJnP5VcIDjaSXbj/z+urJ+beuheC2/7/HlYuNrKC9F0nb6K5uoCh
         J5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714088398; x=1714693198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUxUfKFq5lce0AjD/oJDwXVLlkKMz5g8I16agotNVL4=;
        b=SBFZeZz7ZoVKJBEV9a/AvRBpAUUlhL5iSqYENmfhI6zi23q7zjIw5ApzA/XUyIvqFZ
         f+fUJQTZE9jR82tiJvH1jgZsVc8wr3ghlT/9Gmcf0exMtPlQ09R3wt4EywTB8VYl5QWl
         sRFCWnvfmgNyuO6llypxoZfmIs5v6t37MmmAu/ukQf4XwCmHpC8XdTzQIZHXeJaU6G2X
         YknVKXfUU9Vca4/5xr4rtZIn2M1VjXRKLd/yq5OeeuS6CjtnNdysbV5G9mX1K7i3eGRe
         qioHqQDm45mytS2C78bykheZ+fGpUlOCye37/XGT3tVR0dzxjzHTo4ugWjb7CeM+tePT
         7BTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsmpC9cI+8KU7h/cw50t6+ZAgVXkf1qBn1Y6Kk5flV/l5oWkPx2dOoQBsB72LAGMJwP8tZNzqWAoLlN6AJuaVoFDSbx6+d6e1IIXOB
X-Gm-Message-State: AOJu0YzPM22J3BT2n8nhstuM3iPJcs/YIhXxHvWJHp/8S/8ju4yWDkOQ
	U1jUUuEY4umWGLbuWxuDUYUwAjVbbyk1N1SdlF0rkJgmNkOv5G21iNc1A7Fr7y5jZI4nMwSvSvk
	3nA==
X-Google-Smtp-Source: AGHT+IH+h5i/PU988dchPZRoVoVXuOPZqOT4+Rtk3PzisjubvPt97qk8f0RN68qdB9ceRIRH+7GBxqygKEs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:2c13:0:b0:5dc:af73:89e1 with SMTP id
 s19-20020a632c13000000b005dcaf7389e1mr3328pgs.10.1714088398066; Thu, 25 Apr
 2024 16:39:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 25 Apr 2024 16:39:49 -0700
In-Reply-To: <20240425233951.3344485-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425233951.3344485-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425233951.3344485-3-seanjc@google.com>
Subject: [PATCH 2/4] KVM: x86: Register emergency virt callback in common
 code, via kvm_x86_ops
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move the registration of KVM's "disable virtualization in an emergency"
callbacks into common KVM code, using a pointer in kvm_x86_ops to provide
each vendor's callback.

There is no reason to force vendor code to do the registration, and the
callback should be installed when kvm_x86_ops themselves are ready, i.e.
when it's possible for .hardware_enabled() to be invoked.  E.g. TDX needs
to do VMXON during module initialization, so registering the callback as
part of early setup means one less thing to mess up.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 +++
 arch/x86/kvm/svm/svm.c          | 5 +----
 arch/x86/kvm/vmx/main.c         | 2 ++
 arch/x86/kvm/vmx/vmx.c          | 6 +-----
 arch/x86/kvm/vmx/x86_ops.h      | 1 +
 arch/x86/kvm/x86.c              | 5 +++++
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1d13e3cd1dc5..d64a51da150c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -36,6 +36,7 @@
 #include <asm/kvm_page_track.h>
 #include <asm/kvm_vcpu_regs.h>
 #include <asm/hyperv-tlfs.h>
+#include <asm/reboot.h>
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
 
@@ -1606,6 +1607,8 @@ struct kvm_x86_ops {
 
 	int (*hardware_enable)(void);
 	void (*hardware_disable)(void);
+	cpu_emergency_virt_cb *emergency_disable;
+
 	void (*hardware_unsetup)(void);
 	bool (*has_emulated_msr)(struct kvm *kvm, u32 index);
 	void (*vcpu_after_set_cpuid)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 0f3b59da0d4a..3b54243d0c22 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4919,6 +4919,7 @@ static void *svm_alloc_apic_backing_page(struct kvm_vcpu *vcpu)
 static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
 
+	.emergency_disable = svm_emergency_disable,
 	.check_processor_compatibility = svm_check_processor_compat,
 
 	.hardware_unsetup = svm_hardware_unsetup,
@@ -5352,8 +5353,6 @@ static struct kvm_x86_init_ops svm_init_ops __initdata = {
 static void __svm_exit(void)
 {
 	kvm_x86_vendor_exit();
-
-	cpu_emergency_unregister_virt_callback(svm_emergency_disable);
 }
 
 static int __init svm_init(void)
@@ -5369,8 +5368,6 @@ static int __init svm_init(void)
 	if (r)
 		return r;
 
-	cpu_emergency_register_virt_callback(svm_emergency_disable);
-
 	/*
 	 * Common KVM initialization _must_ come last, after this, /dev/kvm is
 	 * exposed to userspace!
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 7c546ad3e4c9..3f423afc263b 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -24,6 +24,8 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.hardware_enable = vmx_hardware_enable,
 	.hardware_disable = vmx_hardware_disable,
+	.emergency_disable = vmx_emergency_disable,
+
 	.has_emulated_msr = vmx_has_emulated_msr,
 
 	.vm_size = sizeof(struct kvm_vmx),
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f10b5f8f364b..19bc62b60fac 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -753,7 +753,7 @@ static int kvm_cpu_vmxoff(void)
 	return -EIO;
 }
 
-static void vmx_emergency_disable(void)
+void vmx_emergency_disable(void)
 {
 	int cpu = raw_smp_processor_id();
 	struct loaded_vmcs *v;
@@ -8562,8 +8562,6 @@ static void __vmx_exit(void)
 {
 	allow_smaller_maxphyaddr = false;
 
-	cpu_emergency_unregister_virt_callback(vmx_emergency_disable);
-
 	vmx_cleanup_l1d_flush();
 }
 
@@ -8610,8 +8608,6 @@ static int __init vmx_init(void)
 		pi_init_cpu(cpu);
 	}
 
-	cpu_emergency_register_virt_callback(vmx_emergency_disable);
-
 	vmx_check_vmcs12_offsets();
 
 	/*
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 502704596c83..afddfe3747dd 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -15,6 +15,7 @@ void vmx_hardware_unsetup(void);
 int vmx_check_processor_compat(void);
 int vmx_hardware_enable(void);
 void vmx_hardware_disable(void);
+void vmx_emergency_disable(void);
 int vmx_vm_init(struct kvm *kvm);
 void vmx_vm_destroy(struct kvm *kvm);
 int vmx_vcpu_precreate(struct kvm *kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e9ef1fa4b90b..12e88aa2cca2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9797,6 +9797,8 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 
 	kvm_ops_update(ops);
 
+	cpu_emergency_register_virt_callback(kvm_x86_ops.emergency_disable);
+
 	for_each_online_cpu(cpu) {
 		smp_call_function_single(cpu, kvm_x86_check_cpu_compat, &r, 1);
 		if (r < 0)
@@ -9847,6 +9849,7 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	return 0;
 
 out_unwind_ops:
+	cpu_emergency_unregister_virt_callback(kvm_x86_ops.emergency_disable);
 	kvm_x86_ops.hardware_enable = NULL;
 	static_call(kvm_x86_hardware_unsetup)();
 out_mmu_exit:
@@ -9887,6 +9890,8 @@ void kvm_x86_vendor_exit(void)
 	static_key_deferred_flush(&kvm_xen_enabled);
 	WARN_ON(static_branch_unlikely(&kvm_xen_enabled.key));
 #endif
+	cpu_emergency_unregister_virt_callback(kvm_x86_ops.emergency_disable);
+
 	mutex_lock(&vendor_module_lock);
 	kvm_x86_ops.hardware_enable = NULL;
 	mutex_unlock(&vendor_module_lock);
-- 
2.44.0.769.g3c40516874-goog


