Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D337E7746
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbjKJCPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345899AbjKJCOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:14:54 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7108F47AD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:13:59 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5be154fe98bso867802a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699582439; x=1700187239; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vea+L5qfDMmA4c3KSY8Nr6t7qY/kdDKuIJUR/t/IBFw=;
        b=Zc2J2ZH1qpKtA1YEdrNCiRvIMuwRxfoHgTwcPWn6GdAniCPnEFXZYuT+lylNfxezPY
         9s3YSiPHhGcQ4ml89co19KcXHbeAgivCWDg0V42e+8ALaRoB4bLnhtO3tj6Do2wjisCH
         ekq0B5+KGYHTY46WxDg7Luh6YXjCt/EU9h0mevUGGggziJxy0WbUTjSqy/vxY87TBXJZ
         vPrSasPQ9RaaoaI9Hq8S8/O3s4OejvdReeCRY6+hiRaxQZvBZo/MtsG0Ba26zyrXyLCe
         mFqvAHS8OnZfmEfulbl7ETTQpfbd0FFLpkqqkr2IOLf8VstII/0L5+bO5xrXQF/k+V8G
         RQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699582439; x=1700187239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vea+L5qfDMmA4c3KSY8Nr6t7qY/kdDKuIJUR/t/IBFw=;
        b=GTgubo2Phdj5RKJpvbp5lXPqQcbXCV0PeszWsdVyrldRTOzzIIk6CZpk2XtTOgmD0m
         6hKaDBQaIl8VFjWy4+s9HuDcIf/ZN7DDxFZLA1Uo+YuCk3QR67XN7s81UFmGHqG092xS
         9xfQBnCWnako/tqGRilM/k4iardkhYMQ1icciNIW2wphKIxUnIikI4zKYtK56DVqdP2B
         klOO7fWivXS4IdWElMHMPqZL4OKM/fOAOy6ZnCk40YhKaRU8U8Bque0L2nF56/0hwTN4
         8OIPLS3ESs+96N3jsyaj2BsFAtDLpRxRg/3gzanaAtvk9CIvqvzGfRW8LWIeEgP2VbTm
         G3Mg==
X-Gm-Message-State: AOJu0Yx8GEd7rcBI813D77NYApnOGKNBEd9t6CzH62MOZNwXfYHy/gZp
        J9WjfYeqHBrbxPQlm+sgrrbXKSBrCbI=
X-Google-Smtp-Source: AGHT+IF3OotkCl6FE905DL9htCJEBRfunRVZHrs80Tufaz6gebQoWvA8TOLiX7DJdJKHSH61Ok0uqFxjCUQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:2291:b0:280:47ba:7685 with SMTP id
 kx17-20020a17090b229100b0028047ba7685mr339413pjb.0.1699582438954; Thu, 09 Nov
 2023 18:13:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Nov 2023 18:13:04 -0800
In-Reply-To: <20231110021306.1269082-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231110021306.1269082-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231110021306.1269082-25-seanjc@google.com>
Subject: [PATCH v8 24/26] KVM: selftests: Add a forced emulation variation of KVM_ASM_SAFE()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KVM_ASM_SAFE_FEP() to allow forcing emulation on an instruction that
might fault.  Note, KVM skips RIP past the FEP prefix before injecting an
exception, i.e. the fixup needs to be on the instruction itself.  Do not
check for FEP support, that is firmly the responsibility of whatever code
wants to use KVM_ASM_SAFE_FEP().

Sadly, chaining variadic arguments that contain commas doesn't work, thus
the unfortunate amount of copy+paste.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/x86_64/processor.h  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e5c383bd313b..e83b136ca15b 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -1153,16 +1153,19 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
  * r9  = exception vector (non-zero)
  * r10 = error code
  */
-#define KVM_ASM_SAFE(insn)					\
+#define __KVM_ASM_SAFE(insn, fep)				\
 	"mov $" __stringify(KVM_EXCEPTION_MAGIC) ", %%r9\n\t"	\
 	"lea 1f(%%rip), %%r10\n\t"				\
 	"lea 2f(%%rip), %%r11\n\t"				\
-	"1: " insn "\n\t"					\
+	fep "1: " insn "\n\t"					\
 	"xor %%r9, %%r9\n\t"					\
 	"2:\n\t"						\
 	"mov  %%r9b, %[vector]\n\t"				\
 	"mov  %%r10, %[error_code]\n\t"
 
+#define KVM_ASM_SAFE(insn) __KVM_ASM_SAFE(insn, "")
+#define KVM_ASM_SAFE_FEP(insn) __KVM_ASM_SAFE(insn, KVM_FEP)
+
 #define KVM_ASM_SAFE_OUTPUTS(v, ec)	[vector] "=qm"(v), [error_code] "=rm"(ec)
 #define KVM_ASM_SAFE_CLOBBERS	"r9", "r10", "r11"
 
@@ -1189,6 +1192,29 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector,
 	vector;								\
 })
 
+#define kvm_asm_safe_fep(insn, inputs...)				\
+({									\
+	uint64_t ign_error_code;					\
+	uint8_t vector;							\
+									\
+	asm volatile(KVM_ASM_SAFE(insn)					\
+		     : KVM_ASM_SAFE_OUTPUTS(vector, ign_error_code)	\
+		     : inputs						\
+		     : KVM_ASM_SAFE_CLOBBERS);				\
+	vector;								\
+})
+
+#define kvm_asm_safe_ec_fep(insn, error_code, inputs...)		\
+({									\
+	uint8_t vector;							\
+									\
+	asm volatile(KVM_ASM_SAFE_FEP(insn)				\
+		     : KVM_ASM_SAFE_OUTPUTS(vector, error_code)		\
+		     : inputs						\
+		     : KVM_ASM_SAFE_CLOBBERS);				\
+	vector;								\
+})
+
 static inline uint8_t rdmsr_safe(uint32_t msr, uint64_t *val)
 {
 	uint64_t error_code;
-- 
2.42.0.869.gea05f2083d-goog

