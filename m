Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9089977D459
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbjHOUiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbjHOUhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:37:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205271BFF
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:37:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-589ac93bc6eso76751067b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131826; x=1692736626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9kKru1xDygxSy2AxSK9xPxd/4keZZoge6XeY6EftrqI=;
        b=htfA+d+JXn13TTbcDzCya+D7HSIVA2axkaPqJBsVoewSSktqGFz525FTRsVq9P9NIo
         XssECs22HGRjHACcszmT4HDr0cCbMplg4AiK8vopMyWynPbngYBqFpLkOAZMwpXhMDbT
         5qonhCEnd6RlLg+5/Al88Ly3w/i5eBToHJm6xVbMPKRmuwaaxqaAS6vMb1zVynSaQEEa
         ZPnRNc59ffRkfezUBzJ8pHTC3SpeFBdZBI7ZO/S54Sa3/Io48gPUIT2bcxHEsqgvUhgM
         7RO9evsn9B2hiA4Bp2XmcgCbm7Lc0LkyvwEc73uEZuRD5ufrApC45FSOkKz9z1xkk021
         IIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131826; x=1692736626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kKru1xDygxSy2AxSK9xPxd/4keZZoge6XeY6EftrqI=;
        b=fBB809QHLFrZJ/3TYzxAXAc+yas99S24YMBsGjMSCKWYYpDBAeHXahoyZiZuy5ks+m
         jbKprmK4BPkmD5U3ETKcCR8SgpNqsypa2tmhXlnLFZlS4wQozhXI6yq5aWk1I3uB88GH
         Y2jQbfL9OzSyBakyYCapqssB0SCtfWPHAjlBr/6OR8i5vIfjsNQaQnZgwD1u0kVjoDJ5
         PtpQ3QgSDg5IP/gkMW7ZqbMyYhQbe/I3KhV7OXr0CbOhJxCKVbz3O/SwCKNP75uNzL+R
         nyQRhQy8ntmUkQDpRWtLU/SmjAF59J/ysVAVTX1ncHJWmo7F9oOmq597Re6g2zrJaGhE
         DNKw==
X-Gm-Message-State: AOJu0YzP9M3BDsm2kP6hkPVBuyXqjcM8i2hklhpVF7IDGQsIufTfG96h
        zuIxaVVAVFmqxDtt3GnVsqgd7c549JI=
X-Google-Smtp-Source: AGHT+IFLooXv8KeeyZ9LeWXYlkLL8LYlczka3he0qW1aJSthMS3lMIEznzkNNVvbvPVE9fC1vwtLS4MAfGY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4420:0:b0:584:41a6:6cd8 with SMTP id
 r32-20020a814420000000b0058441a66cd8mr195692ywa.8.1692131826593; Tue, 15 Aug
 2023 13:37:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Aug 2023 13:36:44 -0700
In-Reply-To: <20230815203653.519297-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230815203653.519297-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203653.519297-7-seanjc@google.com>
Subject: [PATCH v3 06/15] KVM: x86: Use KVM-governed feature framework to
 track "XSAVES enabled"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zeng Guang <guang.zeng@intel.com>,
        Yuan Yao <yuan.yao@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the governed feature framework to track if XSAVES is "enabled", i.e.
if XSAVES can be used by the guest.  Add a comment in the SVM code to
explain the very unintuitive logic of deliberately NOT checking if XSAVES
is enumerated in the guest CPUID model.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h  |  1 -
 arch/x86/kvm/governed_features.h |  1 +
 arch/x86/kvm/svm/svm.c           | 17 ++++++++++++---
 arch/x86/kvm/vmx/vmx.c           | 36 ++++++++++++++++----------------
 arch/x86/kvm/x86.c               |  4 ++--
 5 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 60d430b4650f..9f57aa33798b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -746,7 +746,6 @@ struct kvm_vcpu_arch {
 	u64 smi_count;
 	bool at_instruction_boundary;
 	bool tpr_access_reporting;
-	bool xsaves_enabled;
 	bool xfd_no_write_intercept;
 	u64 ia32_xss;
 	u64 microcode_version;
diff --git a/arch/x86/kvm/governed_features.h b/arch/x86/kvm/governed_features.h
index b29c15d5e038..b896a64e4ac3 100644
--- a/arch/x86/kvm/governed_features.h
+++ b/arch/x86/kvm/governed_features.h
@@ -6,6 +6,7 @@ BUILD_BUG()
 #define KVM_GOVERNED_X86_FEATURE(x) KVM_GOVERNED_FEATURE(X86_FEATURE_##x)
 
 KVM_GOVERNED_X86_FEATURE(GBPAGES)
+KVM_GOVERNED_X86_FEATURE(XSAVES)
 
 #undef KVM_GOVERNED_X86_FEATURE
 #undef KVM_GOVERNED_FEATURE
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 6aaa3c7b4578..d67f6e23dcd2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4273,9 +4273,20 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_cpuid_entry2 *best;
 
-	vcpu->arch.xsaves_enabled = guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-				    boot_cpu_has(X86_FEATURE_XSAVE) &&
-				    boot_cpu_has(X86_FEATURE_XSAVES);
+	/*
+	 * SVM doesn't provide a way to disable just XSAVES in the guest, KVM
+	 * can only disable all variants of by disallowing CR4.OSXSAVE from
+	 * being set.  As a result, if the host has XSAVE and XSAVES, and the
+	 * guest has XSAVE enabled, the guest can execute XSAVES without
+	 * faulting.  Treat XSAVES as enabled in this case regardless of
+	 * whether it's advertised to the guest so that KVM context switches
+	 * XSS on VM-Enter/VM-Exit.  Failure to do so would effectively give
+	 * the guest read/write access to the host's XSS.
+	 */
+	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
+	    boot_cpu_has(X86_FEATURE_XSAVES) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
+		kvm_governed_feature_set(vcpu, X86_FEATURE_XSAVES);
 
 	/* Update nrips enabled cache */
 	svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 22975cc949b7..6314ca32a5cf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4543,16 +4543,19 @@ vmx_adjust_secondary_exec_control(struct vcpu_vmx *vmx, u32 *exec_control,
  * based on a single guest CPUID bit, with a dedicated feature bit.  This also
  * verifies that the control is actually supported by KVM and hardware.
  */
-#define vmx_adjust_sec_exec_control(vmx, exec_control, name, feat_name, ctrl_name, exiting) \
-({									 \
-	bool __enabled;							 \
-									 \
-	if (cpu_has_vmx_##name()) {					 \
-		__enabled = guest_cpuid_has(&(vmx)->vcpu,		 \
-					    X86_FEATURE_##feat_name);	 \
-		vmx_adjust_secondary_exec_control(vmx, exec_control,	 \
-			SECONDARY_EXEC_##ctrl_name, __enabled, exiting); \
-	}								 \
+#define vmx_adjust_sec_exec_control(vmx, exec_control, name, feat_name, ctrl_name, exiting)	\
+({												\
+	struct kvm_vcpu *__vcpu = &(vmx)->vcpu;							\
+	bool __enabled;										\
+												\
+	if (cpu_has_vmx_##name()) {								\
+		if (kvm_is_governed_feature(X86_FEATURE_##feat_name))				\
+			__enabled = guest_can_use(__vcpu, X86_FEATURE_##feat_name);		\
+		else										\
+			__enabled = guest_cpuid_has(__vcpu, X86_FEATURE_##feat_name);		\
+		vmx_adjust_secondary_exec_control(vmx, exec_control, SECONDARY_EXEC_##ctrl_name,\
+						  __enabled, exiting);				\
+	}											\
 })
 
 /* More macro magic for ENABLE_/opt-in versus _EXITING/opt-out controls. */
@@ -4612,10 +4615,7 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 	if (!enable_pml || !atomic_read(&vcpu->kvm->nr_memslots_dirty_logging))
 		exec_control &= ~SECONDARY_EXEC_ENABLE_PML;
 
-	if (cpu_has_vmx_xsaves())
-		vmx_adjust_secondary_exec_control(vmx, &exec_control,
-						  SECONDARY_EXEC_ENABLE_XSAVES,
-						  vcpu->arch.xsaves_enabled, false);
+	vmx_adjust_sec_exec_feature(vmx, &exec_control, xsaves, XSAVES);
 
 	/*
 	 * RDPID is also gated by ENABLE_RDTSCP, turn on the control if either
@@ -4634,6 +4634,7 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 						  SECONDARY_EXEC_ENABLE_RDTSCP,
 						  rdpid_or_rdtscp_enabled, false);
 	}
+
 	vmx_adjust_sec_exec_feature(vmx, &exec_control, invpcid, INVPCID);
 
 	vmx_adjust_sec_exec_exiting(vmx, &exec_control, rdrand, RDRAND);
@@ -7745,10 +7746,9 @@ static void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * to the guest.  XSAVES depends on CR4.OSXSAVE, and CR4.OSXSAVE can be
 	 * set if and only if XSAVE is supported.
 	 */
-	vcpu->arch.xsaves_enabled = kvm_cpu_cap_has(X86_FEATURE_XSAVES) &&
-				    boot_cpu_has(X86_FEATURE_XSAVE) &&
-				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
-				    guest_cpuid_has(vcpu, X86_FEATURE_XSAVES);
+	if (boot_cpu_has(X86_FEATURE_XSAVE) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
+		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);
 
 	vmx_setup_uret_msrs(vmx);
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index eba35d43e3fe..34945c7dba38 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1016,7 +1016,7 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.xcr0 != host_xcr0)
 			xsetbv(XCR_XFEATURE_ENABLED_MASK, vcpu->arch.xcr0);
 
-		if (vcpu->arch.xsaves_enabled &&
+		if (guest_can_use(vcpu, X86_FEATURE_XSAVES) &&
 		    vcpu->arch.ia32_xss != host_xss)
 			wrmsrl(MSR_IA32_XSS, vcpu->arch.ia32_xss);
 	}
@@ -1047,7 +1047,7 @@ void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
 		if (vcpu->arch.xcr0 != host_xcr0)
 			xsetbv(XCR_XFEATURE_ENABLED_MASK, host_xcr0);
 
-		if (vcpu->arch.xsaves_enabled &&
+		if (guest_can_use(vcpu, X86_FEATURE_XSAVES) &&
 		    vcpu->arch.ia32_xss != host_xss)
 			wrmsrl(MSR_IA32_XSS, host_xss);
 	}
-- 
2.41.0.694.ge786442a9b-goog

