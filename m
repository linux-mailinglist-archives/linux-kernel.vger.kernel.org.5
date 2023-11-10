Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194277E86B5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 00:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbjKJXzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 18:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjKJXzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 18:55:40 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C592010A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:37 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa86b8d66so36473597b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 15:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699660537; x=1700265337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=u/XXiWlF6BUUu8dl994zQCq6OKzTOSt5eqMjS/tu3eo=;
        b=G/lC/+RX78DBHsb3PTdqef+BdyZqGcyrzMjqafI1ntmtoqpZ9ky5fktBTabQTvoWfJ
         FVLM9ZYux7zP/zSdvMqMHmgrjFpm9eHSnUrLytDrWSKj3tKR/C5XR+QhmelLp+u5ZHLL
         GwWTs4GLENoLcflGOv8UFufBGPMSzvSYgyYVGyYf+GyPNTJONKrrxfReKCmQvH70XeQV
         oNLL8BAmaXFbL5JLWe6yEDi7PzSTnqQPkqQL/BMQt2waXesuLL4mmcH0fqdBVNWBV2nm
         Ih3oNu70w5PwRqiWL9TFCdCFcghwrVjU2dnOjsTpOYxK8mDbtyNNGSyrhn1CNsPlSini
         ueAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699660537; x=1700265337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/XXiWlF6BUUu8dl994zQCq6OKzTOSt5eqMjS/tu3eo=;
        b=bp4EG2OToyaxeOtbKnY12hWBhf5ZQCj5C6nLdMQz7jinWiDip1Ump1F0M1YpftGtTy
         4irFXlCmd7pgaVOfFcQkfwNUkxOZT0gjOmmhpgDTYjCwknAr286W+tcx+gqxuQ/jwK8Y
         NPDL1IhYVgWykaa0OMdMvT1C35uRauN9eZPsBx7pn3MDDMNp7lNMLaCVHPVRCVlmd5/M
         tbYepYT26uhCvAgVStCJzppCMSpjseMZkvVDBUjbK/06ODHebUufViFyl8NiY5UAcw2l
         nEFPKh3SR41i68liNe04yUecjFIRLXKNTAE7FlCdQT3j0w/a0YrVrJ1qYnsR0p7g/YW9
         Y50w==
X-Gm-Message-State: AOJu0YyjQQN0ZDMous9XN5JqDM202vw4q7bsACMH+dWhnG2SBi6AOb0n
        5hSHQtiG/gNsSgf4zdMTqj7wL7JE5L4=
X-Google-Smtp-Source: AGHT+IEdv5bxMYkF41KPqWKMHFEx13DMbsg/dC/mw7M/QWBaNkFG6vIFcI0rI1P+uyitAmJZvYcYDRIFfVg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4894:0:b0:5a8:170d:45a9 with SMTP id
 v142-20020a814894000000b005a8170d45a9mr21242ywa.8.1699660537085; Fri, 10 Nov
 2023 15:55:37 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 10 Nov 2023 15:55:21 -0800
In-Reply-To: <20231110235528.1561679-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110235528.1561679-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110235528.1561679-3-seanjc@google.com>
Subject: [PATCH 2/9] KVM: x86: Replace guts of "goverened" features with
 comprehensive cpu_caps
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the internals of the governed features framework with a more
comprehensive "guest CPU capabilities" implementation, i.e. with a guest
version of kvm_cpu_caps.  Keep the skeleton of governed features around
for now as vmx_adjust_sec_exec_control() relies on detecting governed
features to do the right thing for XSAVES, and switching all guest feature
queries to guest_cpu_cap_has() requires subtle and non-trivial changes,
i.e. is best done as a standalone change.

Tracking *all* guest capabilities that KVM cares will allow excising the
poorly named "governed features" framework, and effectively optimizes all
KVM queries of guest capabilities, i.e. doesn't require making a
subjective decision as to whether or not a feature is worth "governing",
and doesn't require adding the code to do so.

The cost of tracking all features is currently 92 bytes per vCPU on 64-bit
kernels: 100 bytes for cpu_caps versus 8 bytes for governed_features.
That cost is well worth paying even if the only benefit was eliminating
the "governed features" terminology.  And practically speaking, the real
cost is zero unless those 92 bytes pushes the size of vcpu_vmx or vcpu_svm
into a new order-N allocation, and if that happens there are better ways
to reduce the footprint of kvm_vcpu_arch, e.g. making the PMU and/or MTRR
state separate allocations.

Suggested-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 40 ++++++++++++++++++++-------------
 arch/x86/kvm/cpuid.c            |  4 +---
 arch/x86/kvm/cpuid.h            | 14 ++++++------
 arch/x86/kvm/reverse_cpuid.h    | 15 -------------
 4 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d7036982332e..1d43dd5fdea7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -722,6 +722,22 @@ struct kvm_queued_exception {
 	bool has_payload;
 };
 
+/*
+ * Hardware-defined CPUID leafs that are either scattered by the kernel or are
+ * unknown to the kernel, but need to be directly used by KVM.  Note, these
+ * word values conflict with the kernel's "bug" caps, but KVM doesn't use those.
+ */
+enum kvm_only_cpuid_leafs {
+	CPUID_12_EAX	 = NCAPINTS,
+	CPUID_7_1_EDX,
+	CPUID_8000_0007_EDX,
+	CPUID_8000_0022_EAX,
+	NR_KVM_CPU_CAPS,
+
+	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
+};
+
+
 struct kvm_vcpu_arch {
 	/*
 	 * rip and regs accesses must go through
@@ -840,23 +856,15 @@ struct kvm_vcpu_arch {
 	struct kvm_hypervisor_cpuid kvm_cpuid;
 
 	/*
-	 * FIXME: Drop this macro and use KVM_NR_GOVERNED_FEATURES directly
-	 * when "struct kvm_vcpu_arch" is no longer defined in an
-	 * arch/x86/include/asm header.  The max is mostly arbitrary, i.e.
-	 * can be increased as necessary.
+	 * Track the effective guest capabilities, i.e. the features the vCPU
+	 * is allowed to use.  Typically, but not always, features can be used
+	 * by the guest if and only if both KVM and userspace want to expose
+	 * the feature to the guest.  A common exception is for virtualization
+	 * holes, i.e. when KVM can't prevent the guest from using a feature,
+	 * in which case the vCPU "has" the feature regardless of what KVM or
+	 * userspace desires.
 	 */
-#define KVM_MAX_NR_GOVERNED_FEATURES BITS_PER_LONG
-
-	/*
-	 * Track whether or not the guest is allowed to use features that are
-	 * governed by KVM, where "governed" means KVM needs to manage state
-	 * and/or explicitly enable the feature in hardware.  Typically, but
-	 * not always, governed features can be used by the guest if and only
-	 * if both KVM and userspace want to expose the feature to the guest.
-	 */
-	struct {
-		DECLARE_BITMAP(enabled, KVM_MAX_NR_GOVERNED_FEATURES);
-	} governed_features;
+	u32 cpu_caps[NR_KVM_CPU_CAPS];
 
 	u64 reserved_gpa_bits;
 	int maxphyaddr;
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4f464187b063..4bf3c2d4dc7c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -327,9 +327,7 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	struct kvm_cpuid_entry2 *best;
 	bool allow_gbpages;
 
-	BUILD_BUG_ON(KVM_NR_GOVERNED_FEATURES > KVM_MAX_NR_GOVERNED_FEATURES);
-	bitmap_zero(vcpu->arch.governed_features.enabled,
-		    KVM_MAX_NR_GOVERNED_FEATURES);
+	memset(vcpu->arch.cpu_caps, 0, sizeof(vcpu->arch.cpu_caps));
 
 	/*
 	 * If TDP is enabled, let the guest use GBPAGES if they're supported in
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 245416ffa34c..9f18c4395b71 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -255,12 +255,12 @@ static __always_inline bool kvm_is_governed_feature(unsigned int x86_feature)
 }
 
 static __always_inline void guest_cpu_cap_set(struct kvm_vcpu *vcpu,
-						     unsigned int x86_feature)
+					      unsigned int x86_feature)
 {
-	BUILD_BUG_ON(!kvm_is_governed_feature(x86_feature));
+	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	__set_bit(kvm_governed_feature_index(x86_feature),
-		  vcpu->arch.governed_features.enabled);
+	reverse_cpuid_check(x86_leaf);
+	vcpu->arch.cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
 }
 
 static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
@@ -273,10 +273,10 @@ static __always_inline void guest_cpu_cap_check_and_set(struct kvm_vcpu *vcpu,
 static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 					      unsigned int x86_feature)
 {
-	BUILD_BUG_ON(!kvm_is_governed_feature(x86_feature));
+	unsigned int x86_leaf = __feature_leaf(x86_feature);
 
-	return test_bit(kvm_governed_feature_index(x86_feature),
-			vcpu->arch.governed_features.enabled);
+	reverse_cpuid_check(x86_leaf);
+	return vcpu->arch.cpu_caps[x86_leaf] & __feature_bit(x86_feature);
 }
 
 #endif
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index b81650678375..4b658491e8f8 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -6,21 +6,6 @@
 #include <asm/cpufeature.h>
 #include <asm/cpufeatures.h>
 
-/*
- * Hardware-defined CPUID leafs that are either scattered by the kernel or are
- * unknown to the kernel, but need to be directly used by KVM.  Note, these
- * word values conflict with the kernel's "bug" caps, but KVM doesn't use those.
- */
-enum kvm_only_cpuid_leafs {
-	CPUID_12_EAX	 = NCAPINTS,
-	CPUID_7_1_EDX,
-	CPUID_8000_0007_EDX,
-	CPUID_8000_0022_EAX,
-	NR_KVM_CPU_CAPS,
-
-	NKVMCAPINTS = NR_KVM_CPU_CAPS - NCAPINTS,
-};
-
 /*
  * Define a KVM-only feature flag.
  *
-- 
2.42.0.869.gea05f2083d-goog

