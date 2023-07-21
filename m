Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA375D595
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjGUUUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGUUUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:20:19 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB94493
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:40 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b8af49a5d2so20437515ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 13:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689970777; x=1690575577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7MVEPPMPG5BIE/ZORskfpxdkerEVsprNO1/ccabxK1U=;
        b=dsfCRhtXu+8WBW50E8oV+3uhZ2IRmNPTr+fYzCXaE7ye0usyPQ3FcgUx3z2bDgBp+b
         2JtfRRWLip6QDC4cSBq7Ef5ocutDHXkXkY6mDSEOjLvzRlaA2XjN+g38YAUYj932UeSm
         FH2O1fYjeHuQfQFMZ+X68cDDdQ0UDLkoOdRf/CzfI13WPYzklLaH5a295isOpx4XsjFI
         ACUsOr8ONPZJWnXokIUrjZxk++/XpQnD0doONOc5k8lzC3jKOYe3fnHmlqne9aCmE0mt
         ZCSzWJ2xDQKusbcs0tM4RFyc9d8iON18lHvW/YwToWhPC8ogAzcrqzslH4pNfPJ19Nnf
         /vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689970777; x=1690575577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MVEPPMPG5BIE/ZORskfpxdkerEVsprNO1/ccabxK1U=;
        b=Fg4WQhq4KLb9UMrqO+LDnfO26vwZM/barmO0XamyuLrWbbk2j+H7PNLlHEyt+iy4ny
         p6s6ewQd8cLzy+9SbZimIMBQDsFGu/sgJEoObSkRHjF0pJG+Nfva+VfPfgAUnZr67pwh
         MKQeo86zbaEG1e8VG/rLGywS8pSR+7w260gd18HJJbaUqW65WsBe2T8c0eU88NPSAXZb
         RtKwPUeGXhI+CSfuOXeLX9FnHmnFwcDghcEhFFJy8M2oEkP5Idp6n4tfg8aupkOgm1fX
         lXcDBdVS+YgUXs3fqny3ABQoIsnSbnPVdQO+y1PQGTL0OYVBZJWen81em7buVbdaEPVc
         0j4A==
X-Gm-Message-State: ABy/qLbKrhlOSlXQMku8AZe2ht7SYlDvSTU81ljvu56lJtx9hwiPy85g
        VoTsdejxKlRjjy9sqfiNkYhIKnzIjDs=
X-Google-Smtp-Source: APBJJlH7v1jWQJgdvmTHmNodVC5MgWoiQ35LLIzu27y8MUq20QZMDNCkMIZSTIPdq94UkFGXcfYhULYma4g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:22c9:b0:1b8:7f21:6d3 with SMTP id
 y9-20020a17090322c900b001b87f2106d3mr12669plg.6.1689970776409; Fri, 21 Jul
 2023 13:19:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 13:18:56 -0700
In-Reply-To: <20230721201859.2307736-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230721201859.2307736-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721201859.2307736-17-seanjc@google.com>
Subject: [PATCH v4 16/19] x86/virt: KVM: Move "disable SVM" helper into KVM SVM
From:   Sean Christopherson <seanjc@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>
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

Move cpu_svm_disable() into KVM proper now that all hardware
virtualization management is routed through KVM.  Remove the now-empty
virtext.h.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/virtext.h | 50 ----------------------------------
 arch/x86/kvm/svm/svm.c         | 29 +++++++++++++++++---
 2 files changed, 25 insertions(+), 54 deletions(-)
 delete mode 100644 arch/x86/include/asm/virtext.h

diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
deleted file mode 100644
index 632575e257d8..000000000000
--- a/arch/x86/include/asm/virtext.h
+++ /dev/null
@@ -1,50 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/* CPU virtualization extensions handling
- *
- * This should carry the code for handling CPU virtualization extensions
- * that needs to live in the kernel core.
- *
- * Author: Eduardo Habkost <ehabkost@redhat.com>
- *
- * Copyright (C) 2008, Red Hat Inc.
- *
- * Contains code from KVM, Copyright (C) 2006 Qumranet, Inc.
- */
-#ifndef _ASM_X86_VIRTEX_H
-#define _ASM_X86_VIRTEX_H
-
-#include <asm/processor.h>
-
-#include <asm/vmx.h>
-#include <asm/svm.h>
-#include <asm/tlbflush.h>
-
-/*
- * SVM functions:
- */
-/** Disable SVM on the current CPU
- */
-static inline void cpu_svm_disable(void)
-{
-	uint64_t efer;
-
-	wrmsrl(MSR_VM_HSAVE_PA, 0);
-	rdmsrl(MSR_EFER, efer);
-	if (efer & EFER_SVME) {
-		/*
-		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
-		 * aren't blocked, e.g. if a fatal error occurred between CLGI
-		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
-		 * context between reading EFER and executing STGI.  In that
-		 * case, GIF must already be set, otherwise the NMI would have
-		 * been blocked, so just eat the fault.
-		 */
-		asm_volatile_goto("1: stgi\n\t"
-				  _ASM_EXTABLE(1b, %l[fault])
-				  ::: "memory" : fault);
-fault:
-		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
-	}
-}
-
-#endif /* _ASM_X86_VIRTEX_H */
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9e449167e71b..47f9c7156609 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -42,8 +42,6 @@
 #include <asm/reboot.h>
 #include <asm/fpu/api.h>
 
-#include <asm/virtext.h>
-
 #include <trace/events/ipi.h>
 
 #include "trace.h"
@@ -582,9 +580,32 @@ void __svm_write_tsc_multiplier(u64 multiplier)
 	preempt_enable();
 }
 
+static inline void kvm_cpu_svm_disable(void)
+{
+	uint64_t efer;
+
+	wrmsrl(MSR_VM_HSAVE_PA, 0);
+	rdmsrl(MSR_EFER, efer);
+	if (efer & EFER_SVME) {
+		/*
+		 * Force GIF=1 prior to disabling SVM to ensure INIT and NMI
+		 * aren't blocked, e.g. if a fatal error occurred between CLGI
+		 * and STGI.  Note, STGI may #UD if SVM is disabled from NMI
+		 * context between reading EFER and executing STGI.  In that
+		 * case, GIF must already be set, otherwise the NMI would have
+		 * been blocked, so just eat the fault.
+		 */
+		asm_volatile_goto("1: stgi\n\t"
+				  _ASM_EXTABLE(1b, %l[fault])
+				  ::: "memory" : fault);
+fault:
+		wrmsrl(MSR_EFER, efer & ~EFER_SVME);
+	}
+}
+
 static void svm_emergency_disable(void)
 {
-	cpu_svm_disable();
+	kvm_cpu_svm_disable();
 }
 
 static void svm_hardware_disable(void)
@@ -593,7 +614,7 @@ static void svm_hardware_disable(void)
 	if (tsc_scaling)
 		__svm_write_tsc_multiplier(SVM_TSC_RATIO_DEFAULT);
 
-	cpu_svm_disable();
+	kvm_cpu_svm_disable();
 
 	amd_pmu_disable_virt();
 }
-- 
2.41.0.487.g6d72f3e995-goog

