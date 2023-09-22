Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBEC7AAE80
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjIVJoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjIVJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:44:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D2CE;
        Fri, 22 Sep 2023 02:44:00 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695375839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdaSzg2HylZVoxLdcrNA6goIyqAM9SSlosMciSb6/Ms=;
        b=LGSJFX6Zrk1mM8jaq/HlxfPOgMA5Lnk9PcU7t8SpptFjqbmx9YYIFqXnI57+F5yZyddWLb
        msqwmaKpaVHmpTRZfKEwJBacyYrME/N7XB3ywLZY0SrwDHgS8C9SiBoSCQIUdA9GZPOMnV
        edcuUCcJXsc0Pmup0zCVTiG/M2Jevse55aTSSuryILD8m+SqRr0hf8firf8nATOTpz3d34
        KqfA7FHYKE9ygWwMeYOAOfeF4ksg7FFUxnMxoZcMKsse7+yLQiWhkZN8YXvHn1nwFXSg01
        QNlItQ7HSYj5+YWj7caU7z/6wahBDbv/meMLYVwQMqxw2A+en+3tqeVP4CZuHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695375839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdaSzg2HylZVoxLdcrNA6goIyqAM9SSlosMciSb6/Ms=;
        b=nK/OoKjpdDzbbZAu5PNMVu91V5nbypBN2uzBzzZHOGPysbbSh5w4PoZ22YuhZdCwloJ0G2
        SHKlK7H4PmH2Q6Aw==
From:   "tip-bot2 for Paolo Bonzini" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Clear SVM feature if disabled by BIOS
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921114940.957141-1-pbonzini@redhat.com>
References: <20230921114940.957141-1-pbonzini@redhat.com>
MIME-Version: 1.0
Message-ID: <169537583818.27769.18320521458994415527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7deda2ce5b33edc6d689e429e3fe75382468b030
Gitweb:        https://git.kernel.org/tip/7deda2ce5b33edc6d689e429e3fe75382468b030
Author:        Paolo Bonzini <pbonzini@redhat.com>
AuthorDate:    Thu, 21 Sep 2023 07:49:40 -04:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 22 Sep 2023 10:55:26 +02:00

x86/cpu: Clear SVM feature if disabled by BIOS

When SVM is disabled by BIOS, one cannot use KVM but the
SVM feature is still shown in the output of /proc/cpuinfo.
On Intel machines, VMX is cleared by init_ia32_feat_ctl(),
so do the same on AMD and Hygon processors.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230921114940.957141-1-pbonzini@redhat.com
---
 arch/x86/include/asm/msr-index.h |  6 +++++-
 arch/x86/include/asm/svm.h       |  6 ------
 arch/x86/kernel/cpu/amd.c        | 10 ++++++++++
 arch/x86/kernel/cpu/hygon.c      | 10 ++++++++++
 arch/x86/kvm/svm/svm.c           |  8 --------
 5 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d11135..6a6b0f7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1112,12 +1112,16 @@
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
 #define MSR_IA32_VMX_MISC_VMWRITE_SHADOW_RO_FIELDS (1ULL << 29)
 #define MSR_IA32_VMX_MISC_PREEMPTION_TIMER_SCALE   0x1F
-/* AMD-V MSRs */
 
+/* AMD-V MSRs */
 #define MSR_VM_CR                       0xc0010114
 #define MSR_VM_IGNNE                    0xc0010115
 #define MSR_VM_HSAVE_PA                 0xc0010117
 
+#define SVM_VM_CR_VALID_MASK		0x001fULL
+#define SVM_VM_CR_SVM_LOCK_MASK		0x0008ULL
+#define SVM_VM_CR_SVM_DIS_MASK		0x0010ULL
+
 /* Hardware Feedback Interface */
 #define MSR_IA32_HW_FEEDBACK_PTR        0x17d0
 #define MSR_IA32_HW_FEEDBACK_CONFIG     0x17d1
diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
index 19bf955..fb8366a 100644
--- a/arch/x86/include/asm/svm.h
+++ b/arch/x86/include/asm/svm.h
@@ -229,10 +229,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_IOIO_SIZE_MASK (7 << SVM_IOIO_SIZE_SHIFT)
 #define SVM_IOIO_ASIZE_MASK (7 << SVM_IOIO_ASIZE_SHIFT)
 
-#define SVM_VM_CR_VALID_MASK	0x001fULL
-#define SVM_VM_CR_SVM_LOCK_MASK 0x0008ULL
-#define SVM_VM_CR_SVM_DIS_MASK  0x0010ULL
-
 #define SVM_NESTED_CTL_NP_ENABLE	BIT(0)
 #define SVM_NESTED_CTL_SEV_ENABLE	BIT(1)
 #define SVM_NESTED_CTL_SEV_ES_ENABLE	BIT(2)
@@ -571,8 +567,6 @@ struct vmcb {
 
 #define SVM_CPUID_FUNC 0x8000000a
 
-#define SVM_VM_CR_SVM_DISABLE 4
-
 #define SVM_SELECTOR_S_SHIFT 4
 #define SVM_SELECTOR_DPL_SHIFT 5
 #define SVM_SELECTOR_P_SHIFT 7
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dd8379d..1011ce2 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1031,6 +1031,8 @@ static void zenbleed_check(struct cpuinfo_x86 *c)
 
 static void init_amd(struct cpuinfo_x86 *c)
 {
+	u64 vm_cr;
+
 	early_init_amd(c);
 
 	/*
@@ -1082,6 +1084,14 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	init_amd_cacheinfo(c);
 
+	if (cpu_has(c, X86_FEATURE_SVM)) {
+		rdmsrl(MSR_VM_CR, vm_cr);
+		if (vm_cr & SVM_VM_CR_SVM_DIS_MASK) {
+			pr_notice_once("SVM disabled (by BIOS) in MSR_VM_CR\n");
+			clear_cpu_cap(c, X86_FEATURE_SVM);
+		}
+	}
+
 	if (!cpu_has(c, X86_FEATURE_LFENCE_RDTSC) && cpu_has(c, X86_FEATURE_XMM2)) {
 		/*
 		 * Use LFENCE for execution serialization.  On families which
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index defdc59..16f3463 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -290,6 +290,8 @@ static void early_init_hygon(struct cpuinfo_x86 *c)
 
 static void init_hygon(struct cpuinfo_x86 *c)
 {
+	u64 vm_cr;
+
 	early_init_hygon(c);
 
 	/*
@@ -320,6 +322,14 @@ static void init_hygon(struct cpuinfo_x86 *c)
 
 	init_hygon_cacheinfo(c);
 
+	if (cpu_has(c, X86_FEATURE_SVM)) {
+		rdmsrl(MSR_VM_CR, vm_cr);
+		if (vm_cr & SVM_VM_CR_SVM_DIS_MASK) {
+			pr_notice_once("SVM disabled (by BIOS) in MSR_VM_CR\n");
+			clear_cpu_cap(c, X86_FEATURE_SVM);
+		}
+	}
+
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
 		/*
 		 * Use LFENCE for execution serialization.  On families which
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f283eb4..7b91efb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -531,8 +531,6 @@ static bool __kvm_is_svm_supported(void)
 	int cpu = smp_processor_id();
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 
-	u64 vm_cr;
-
 	if (c->x86_vendor != X86_VENDOR_AMD &&
 	    c->x86_vendor != X86_VENDOR_HYGON) {
 		pr_err("CPU %d isn't AMD or Hygon\n", cpu);
@@ -549,12 +547,6 @@ static bool __kvm_is_svm_supported(void)
 		return false;
 	}
 
-	rdmsrl(MSR_VM_CR, vm_cr);
-	if (vm_cr & (1 << SVM_VM_CR_SVM_DISABLE)) {
-		pr_err("SVM disabled (by BIOS) in MSR_VM_CR on CPU %d\n", cpu);
-		return false;
-	}
-
 	return true;
 }
 
