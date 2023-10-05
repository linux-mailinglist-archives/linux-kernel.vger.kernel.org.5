Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2537BA049
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjJEOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjJEOeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:34:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B16F10E3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 20:12:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a20c7295bbso4924287b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 20:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696475574; x=1697080374; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E/T9c37vepstKW16fAmDAxhGteSfIVLSC7A/HxeObQw=;
        b=0pQSFhhIbBwIdpcK8z3fUnKsZMPlZHMIBY6NHQ2oD83dr2Mh7l4jUuX9sVPDCR8QOD
         RVKV20Krajz34PhIJMwHntFqAUOwvFZeSNS+kryS/4135eY2kp916Smy5jBRuGwBBtEz
         LAKkgDRkYi2dNfUjmLEmt0u2ov4kGDHC9Nrezv9AszWWWJOawQMakrnyCcqBL5Y21ZWp
         AKNLz0mgUsvf9AdOXwXTPINvv7oqCU++aRZC2IhNmRTubgegcY9A8ERiGkaKAZgMvrJK
         TugyjUv2KZ3e9DVOC6QKGoWPLOjwYwWttI8dzOCDx0qDU0JQUcHUgGtoHH56C9ymH/rP
         mYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696475574; x=1697080374;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E/T9c37vepstKW16fAmDAxhGteSfIVLSC7A/HxeObQw=;
        b=JTSOUNk1/t4SUT3rPh6OduqtJ42NrOviKP9+vpsXn1FDIlz/qC02AYKR2Llh3pUpOR
         cgnmNAe0cmZEtv7dcCiD0/Y1N8PTyzTUL1HlnctrP+LPLMA+FpkA2gub86k8P7AwpdxY
         iJjoKqLP6+jg0Tsey1zsYUE9v32o2aRHswcUw+B/CuBwVJdRkGgsLtaU0B4v0OPT76JB
         2z0A1O73AFPne6ilNIXgZzes1VpyInPKV935SO0gf8GhZCVUz6nyvn0WzXVl1UVldKOM
         Yn0Oxg3YTtLUSy0kjRUG8PXD2Uqw5C0kRjQkLrIY4Ukfd9eqbVMrJqrJd8ILrVINp6fy
         zKiA==
X-Gm-Message-State: AOJu0YwmKBCNV++XLqqfIfK8zX6KVHUveB+sMCpUslBhvMjdMF8CiMLc
        urwCfEqCyKz93qZgkHCAeSstxAix6hOTBQ==
X-Google-Smtp-Source: AGHT+IFe5vbxLTpRMPLnfd5y+T8mWZMnBcPpWTe5wUOS2R50BFudKqBzGW3yIPCLLlcBhhovZ+l16v0FXR6W7Q==
X-Received: from loggerhead.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:29a])
 (user=jmattson job=sendgmr) by 2002:a81:9a4c:0:b0:59e:8f97:27ed with SMTP id
 r73-20020a819a4c000000b0059e8f9727edmr2254ywg.1.1696475574494; Wed, 04 Oct
 2023 20:12:54 -0700 (PDT)
Date:   Wed,  4 Oct 2023 20:12:37 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231005031237.1652871-1-jmattson@google.com>
Subject: [PATCH v2] x86: KVM: Add feature flag for CPUID.80000021H:EAX[bit 1]
From:   Jim Mattson <jmattson@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define an X86_FEATURE_* flag for CPUID.80000021H:EAX.[bit 1], and
advertise the feature to userspace via KVM_GET_SUPPORTED_CPUID.

Per AMD's "Processor Programming Reference (PPR) for AMD Family 19h
Model 61h, Revision B1 Processors (56713-B1-PUB)," this CPUID bit
indicates that a WRMSR to MSR_FS_BASE, MSR_GS_BASE, or
MSR_KERNEL_GS_BASE is non-serializing. This is a change in previously
architected behavior.

Effectively, this CPUID bit is a "defeature" bit, or a reverse
polarity feature bit. When this CPUID bit is clear, the feature
(serialization on WRMSR to any of these three MSRs) is available. When
this CPUID bit is set, the feature is not available.

KVM_GET_SUPPORTED_CPUID must pass this bit through from the underlying
hardware, if it is set. Leaving the bit clear claims that WRMSR to
these three MSRs will be serializing in a guest running under
KVM. That isn't true. Though KVM could emulate the feature by
intercepting writes to the specified MSRs, it does not do so
today. The guest is allowed direct read/write access to these MSRs
without interception, so the innate hardware behavior is preserved
under KVM.

Signed-off-by: Jim Mattson <jmattson@google.com>
---

v1 -> v2: Added justification for this change to the commit message,
          tweaked the macro name and comment in cpufeatures.h for
	  improved clarity.

 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kvm/cpuid.c               | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 58cb9495e40f..4af140cf5719 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -443,6 +443,7 @@
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
+#define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* "" WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Clears Base */
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0544e30b4946..93241b33e36f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -761,7 +761,8 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
-		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */
+		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
+		F(WRMSR_XX_BASE_NS)
 	);
 
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
-- 
2.42.0.582.g8ccd20d70d-goog

