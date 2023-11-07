Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A31C7E49B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbjKGUU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbjKGUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:20:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6BB1706
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:20:27 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af53bde4so82825007b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699388427; x=1699993227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwz/DX5/0PSQdls3zWf864vgsuhHF2nqgARPPlW8Wak=;
        b=3Gcygnai67kT+WqcXgt+oLUEvz+kxgU/nq8W+5br6jDrCHgNCl2rEIVka1LTq/633i
         8k3jSY2D2QFP2RICc/MT+sfx/VlL6STXYxx/z00oKapA+lOGlObf/PwqXDZ0RT/GR/xP
         iijlp5/pLylLfkp7k52m/zOaS/rkFlo+8OZM/KgigLqCCBXTY7fR/m4E+wn24S2Sv9cw
         eoBNzEvSBiKPBeee8nYC5m8HIXo2TkTYkTL3Gg67FDBB+TOmJWxaIplIB0yJbHMKUYEo
         Cy2bTaPCtsmWrtwT2+Y8vtioDbnCOo7Oja5sdsjEg1lYOa9J8ZWNvN79/Xc3L5U8Hx4v
         tD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699388427; x=1699993227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwz/DX5/0PSQdls3zWf864vgsuhHF2nqgARPPlW8Wak=;
        b=MUh1etG3oqsdpEwO0SdOWnPK1CGT2cAZt6dLYPHNMB/IBZDIkWFIXFoGHmGwmr8hqX
         yNQRrPveTwa/aQ+54vR6q0UGYNTErb8WaBgwfplGAK1g6lqT0wtBQQbK9eVbRSPy7KUh
         CzVXRTDwZjlRx7aCGEBENN2MjkzhuuqjkAWxV49jo+0Ch2f2ReSdWMG+lMuenC5s9mTh
         fXfu92ifw1MudA2QYEZeJGmSImsnbPOR/nOH2J4otC6EDWEnGiG2p8/MZ1HcPEpJB+pP
         f81o+ggCMb4nHwbvc8VWwMFowiayZsrB0ZbNpSIilvzpctwe2p9CsJbcWOzCtpQ/nvq4
         bw9w==
X-Gm-Message-State: AOJu0YwObEddu495tlzHmKgaOz9bE47LlYida9t/Xdg7vDzORKQAPxD3
        8O/GO73UmXKHerDJKZIOFIee8z78up2zwA==
X-Google-Smtp-Source: AGHT+IE6r0sMd4kiFjw74n4jFrPY3A6ZLSngl/1kFEoTU04Ea3WGhGaUk1oh3I8bkSM8wWmAUocFK/sAzUMi/w==
X-Received: from aghulati-dev.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:18bb])
 (user=aghulati job=sendgmr) by 2002:a81:4ec2:0:b0:5a8:3f07:ddd6 with SMTP id
 c185-20020a814ec2000000b005a83f07ddd6mr284468ywb.6.1699388427125; Tue, 07 Nov
 2023 12:20:27 -0800 (PST)
Date:   Tue,  7 Nov 2023 20:19:55 +0000
In-Reply-To: <20231107202002.667900-1-aghulati@google.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107202002.667900-8-aghulati@google.com>
Subject: [RFC PATCH 07/14] KVM: SVM: Move shared SVM data structures into VAC
From:   Anish Ghulati <aghulati@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move svm_cpu_data into VAC.

TODO: Explain why this data should be shared between KVMs and should be
made global by moving it into VAC.

Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
Signed-off-by: Anish Ghulati <aghulati@google.com>
---
 arch/x86/kvm/svm/svm.c |  9 ++++++++-
 arch/x86/kvm/svm/svm.h | 16 +---------------
 arch/x86/kvm/svm/vac.c |  5 +++++
 arch/x86/kvm/svm/vac.h | 23 +++++++++++++++++++++++
 4 files changed, 37 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/kvm/svm/vac.h

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f0a5cc43c023..d53808d8ec37 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -234,7 +234,14 @@ static u8 rsm_ins_bytes[] = "\x0f\xaa";
 
 static unsigned long iopm_base;
 
-DEFINE_PER_CPU(struct svm_cpu_data, svm_data);
+struct kvm_ldttss_desc {
+	u16 limit0;
+	u16 base0;
+	unsigned base1:8, type:5, dpl:2, p:1;
+	unsigned limit1:4, zero0:3, g:1, base2:8;
+	u32 base3;
+	u32 zero1;
+} __attribute__((packed));
 
 /*
  * Only MSR_TSC_AUX is switched via the user return hook.  EFER is switched via
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 436632706848..7fc652b1b92d 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -24,6 +24,7 @@
 
 #include "cpuid.h"
 #include "kvm_cache_regs.h"
+#include "vac.h"
 
 #define __sme_page_pa(x) __sme_set(page_to_pfn(x) << PAGE_SHIFT)
 
@@ -291,21 +292,6 @@ struct vcpu_svm {
 	bool guest_gif;
 };
 
-struct svm_cpu_data {
-	u64 asid_generation;
-	u32 max_asid;
-	u32 next_asid;
-	u32 min_asid;
-
-	struct page *save_area;
-	unsigned long save_area_pa;
-
-	struct vmcb *current_vmcb;
-
-	/* index = sev_asid, value = vmcb pointer */
-	struct vmcb **sev_vmcbs;
-};
-
 DECLARE_PER_CPU(struct svm_cpu_data, svm_data);
 
 void recalc_intercepts(struct vcpu_svm *svm);
diff --git a/arch/x86/kvm/svm/vac.c b/arch/x86/kvm/svm/vac.c
index 4aabf16d2fc0..3e79279c6b34 100644
--- a/arch/x86/kvm/svm/vac.c
+++ b/arch/x86/kvm/svm/vac.c
@@ -1,2 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/percpu-defs.h>
+
+#include "vac.h"
+
+DEFINE_PER_CPU(struct svm_cpu_data, svm_data);
diff --git a/arch/x86/kvm/svm/vac.h b/arch/x86/kvm/svm/vac.h
new file mode 100644
index 000000000000..2d42e4472703
--- /dev/null
+++ b/arch/x86/kvm/svm/vac.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+#ifndef ARCH_X86_KVM_SVM_VAC_H
+#define ARCH_X86_KVM_SVM_VAC_H
+
+#include "../vac.h"
+
+struct svm_cpu_data {
+	u64 asid_generation;
+	u32 max_asid;
+	u32 next_asid;
+	u32 min_asid;
+
+	struct page *save_area;
+	unsigned long save_area_pa;
+
+	struct vmcb *current_vmcb;
+
+	/* index = sev_asid, value = vmcb pointer */
+	struct vmcb **sev_vmcbs;
+};
+
+#endif // ARCH_X86_KVM_SVM_VAC_H
-- 
2.42.0.869.gea05f2083d-goog

