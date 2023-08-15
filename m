Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752A777D44D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238591AbjHOUhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbjHOUhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:37:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372292120
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:37:10 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56357814339so6408266a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692131825; x=1692736625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WurYGAomMGc7n6x2R93MY9zuBdBMLR5/nrLIAa8YDOE=;
        b=4KaxEtxXC9zmUhFrvN7HA8/qKeGUs1SPVQI36b07Q1LDNK7P4q532bRLCy+mqb7tXs
         uROaA81G+aep0Ygo6VWB0UBLqVv08aPnPH5wGyw4Wxoi9ou9u1PFGpVk1YvP7C5+Vyaw
         lVTc+kXytk1HpVVdty4gVf2lJWoS34n3LR9lF5tQYajqxkI+tMitxoQN7LYYFy34t/0x
         x2es5YB+8u1v0Pf6ZrYEE5dTx1EUtIW+fmSPdoNPe9j973orII64rrcwSXeKC/iR6NWf
         Jq1SN9NN4+0n3xSlWESXGaSf5c66wWiVbCdm3ZWgs9qc9rRMPQIMb3ZEsFcIIGl4xdY8
         /ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692131825; x=1692736625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WurYGAomMGc7n6x2R93MY9zuBdBMLR5/nrLIAa8YDOE=;
        b=TsLphdEUys5kMJmZRF445eZc0o93cQsf2qGtMbCY0NQc0PndC80hrDejKglmAaeFnE
         vpj7dCW4wJmzVJi+p3C7GqO4+xqJ0d/hhmV/4/tiW6uVZX1/oJ/C1CtfKEQHTPL8rnpG
         H5suK0CkXJSAUBkwT3Q2bQYMi015LHDROFTgi/WZyApFAb+XR4wPN8rGTxMPXLaN+EYb
         y38cm/h7pzcJs6KDR3wCXS8ERme7fQLYNKsxHoXfISwUXBmqXF0WdKshL2GZzACzY+Wo
         7cOjcIyRZE72Yu3ONJmX8ttDBHsPwsHBjmpjRx+hjJnufVmM3WAV4rXcwpT8D8zeiZ6D
         dwmA==
X-Gm-Message-State: AOJu0Yz2tt1/wNpCrRw+Tt/5LFIFOPVKGyl//+ijn4/CsQTAGvDCXFqY
        3ZkSE4vKzfuDVc2tn3dbO0NHx8xVBCg=
X-Google-Smtp-Source: AGHT+IGI4znoa3NlI8jKoDjG6pqwDn8wbvMz9Bw9ZmIkAfptctbAguuErAFgvyCj5+BUAFZvtrlyf/liKPo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e744:b0:1b8:95fc:d18 with SMTP id
 p4-20020a170902e74400b001b895fc0d18mr5773125plf.8.1692131824868; Tue, 15 Aug
 2023 13:37:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 15 Aug 2023 13:36:43 -0700
In-Reply-To: <20230815203653.519297-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230815203653.519297-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815203653.519297-6-seanjc@google.com>
Subject: [PATCH v3 05/15] KVM: VMX: Rename XSAVES control to follow KVM's
 preferred "ENABLE_XYZ"
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the XSAVES secondary execution control to follow KVM's preferred
style so that XSAVES related logic can use common macros that depend on
KVM's preferred style.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h      | 2 +-
 arch/x86/kvm/vmx/capabilities.h | 2 +-
 arch/x86/kvm/vmx/hyperv.c       | 2 +-
 arch/x86/kvm/vmx/nested.c       | 6 +++---
 arch/x86/kvm/vmx/nested.h       | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 arch/x86/kvm/vmx/vmx.h          | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 0d02c4aafa6f..0e73616b82f3 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -71,7 +71,7 @@
 #define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
 #define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
 #define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
-#define SECONDARY_EXEC_XSAVES			VMCS_CONTROL_BIT(XSAVES)
+#define SECONDARY_EXEC_ENABLE_XSAVES		VMCS_CONTROL_BIT(XSAVES)
 #define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
 #define SECONDARY_EXEC_PT_USE_GPA		VMCS_CONTROL_BIT(PT_USE_GPA)
 #define SECONDARY_EXEC_TSC_SCALING              VMCS_CONTROL_BIT(TSC_SCALING)
diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index d0abee35d7ba..41a4533f9989 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -252,7 +252,7 @@ static inline bool cpu_has_vmx_pml(void)
 static inline bool cpu_has_vmx_xsaves(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
-		SECONDARY_EXEC_XSAVES;
+		SECONDARY_EXEC_ENABLE_XSAVES;
 }
 
 static inline bool cpu_has_vmx_waitpkg(void)
diff --git a/arch/x86/kvm/vmx/hyperv.c b/arch/x86/kvm/vmx/hyperv.c
index 79450e1ed7cf..313b8bb5b8a7 100644
--- a/arch/x86/kvm/vmx/hyperv.c
+++ b/arch/x86/kvm/vmx/hyperv.c
@@ -78,7 +78,7 @@
 	 SECONDARY_EXEC_DESC |						\
 	 SECONDARY_EXEC_ENABLE_RDTSCP |					\
 	 SECONDARY_EXEC_ENABLE_INVPCID |				\
-	 SECONDARY_EXEC_XSAVES |					\
+	 SECONDARY_EXEC_ENABLE_XSAVES |					\
 	 SECONDARY_EXEC_RDSEED_EXITING |				\
 	 SECONDARY_EXEC_RDRAND_EXITING |				\
 	 SECONDARY_EXEC_TSC_SCALING |					\
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 516391cc0d64..22e08d30baef 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2307,7 +2307,7 @@ static void prepare_vmcs02_early(struct vcpu_vmx *vmx, struct loaded_vmcs *vmcs0
 				  SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE |
 				  SECONDARY_EXEC_ENABLE_INVPCID |
 				  SECONDARY_EXEC_ENABLE_RDTSCP |
-				  SECONDARY_EXEC_XSAVES |
+				  SECONDARY_EXEC_ENABLE_XSAVES |
 				  SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE |
 				  SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |
 				  SECONDARY_EXEC_APIC_REGISTER_VIRT |
@@ -6331,7 +6331,7 @@ static bool nested_vmx_l1_wants_exit(struct kvm_vcpu *vcpu,
 		 * If if it were, XSS would have to be checked against
 		 * the XSS exit bitmap in vmcs12.
 		 */
-		return nested_cpu_has2(vmcs12, SECONDARY_EXEC_XSAVES);
+		return nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENABLE_XSAVES);
 	case EXIT_REASON_UMWAIT:
 	case EXIT_REASON_TPAUSE:
 		return nested_cpu_has2(vmcs12,
@@ -6874,7 +6874,7 @@ static void nested_vmx_setup_secondary_ctls(u32 ept_caps,
 		SECONDARY_EXEC_ENABLE_INVPCID |
 		SECONDARY_EXEC_ENABLE_VMFUNC |
 		SECONDARY_EXEC_RDSEED_EXITING |
-		SECONDARY_EXEC_XSAVES |
+		SECONDARY_EXEC_ENABLE_XSAVES |
 		SECONDARY_EXEC_TSC_SCALING |
 		SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
 
diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
index 96952263b029..b4b9d51438c6 100644
--- a/arch/x86/kvm/vmx/nested.h
+++ b/arch/x86/kvm/vmx/nested.h
@@ -168,7 +168,7 @@ static inline int nested_cpu_has_ept(struct vmcs12 *vmcs12)
 
 static inline bool nested_cpu_has_xsaves(struct vmcs12 *vmcs12)
 {
-	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_XSAVES);
+	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENABLE_XSAVES);
 }
 
 static inline bool nested_cpu_has_pml(struct vmcs12 *vmcs12)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 78f292b7e2c5..22975cc949b7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4614,7 +4614,7 @@ static u32 vmx_secondary_exec_control(struct vcpu_vmx *vmx)
 
 	if (cpu_has_vmx_xsaves())
 		vmx_adjust_secondary_exec_control(vmx, &exec_control,
-						  SECONDARY_EXEC_XSAVES,
+						  SECONDARY_EXEC_ENABLE_XSAVES,
 						  vcpu->arch.xsaves_enabled, false);
 
 	/*
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 32384ba38499..cde902b44d97 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -562,7 +562,7 @@ static inline u8 vmx_get_rvi(void)
 	 SECONDARY_EXEC_APIC_REGISTER_VIRT |				\
 	 SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY |				\
 	 SECONDARY_EXEC_SHADOW_VMCS |					\
-	 SECONDARY_EXEC_XSAVES |					\
+	 SECONDARY_EXEC_ENABLE_XSAVES |					\
 	 SECONDARY_EXEC_RDSEED_EXITING |				\
 	 SECONDARY_EXEC_RDRAND_EXITING |				\
 	 SECONDARY_EXEC_ENABLE_PML |					\
-- 
2.41.0.694.ge786442a9b-goog

