Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE04C7CC8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbjJQQ2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjJQQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:28:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D27A4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:28:37 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e855d7dacso5458225a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697560115; x=1698164915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wd8+uivnFNjs5ojARqpzKIhd4CLZvYGC8SduRH3wwns=;
        b=bUfr9nmESxTzTGZ8UMoBK/mG9jPPK+vK5rjhGu2VL271U27GYS1qXILScgKE4yxi7c
         xg3LNbPDTd+gimZOMjwQ7UOlPgFSUVd0ys3WZiVlRtuEev/xwp7JUJp9Ml/J8TpWJ9cs
         jP7KlWr9/7QuJC5Nrn4uD6clsxfO+kAort7yYsHklsnsK31Q1bZJcmT4mqw8U/HRSWiW
         MVUfBn95YH3N3kWpiHyBvZFGT3CU0CxhCXUzTbZAszZfEnmBAlutEJXVRUGVo0piKdLI
         ZlwY1QcmX5epxmCJbjE33i+XSxf755PqUS/YFq8dxmMoOsBjsVJZ/oFGG8CyWsECONSE
         jwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560115; x=1698164915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wd8+uivnFNjs5ojARqpzKIhd4CLZvYGC8SduRH3wwns=;
        b=F96DJsWL7OGlF3mPVaMuSCnboPvMNuB+M/2XRqWY/tVVFhd2JXdr74t6vyjPehD5Gu
         stX9flqk2eN09Ka3StO6lz+S2C7hA0OlSgfYQcbJZc6g6fmWmRwY0ddWrLHeimP9ncaf
         8yJCLXkeTBzYnj0U/QhrPsGsbMS0p/OpkdYKnG7ckIOY9mWb/Bn9r/5lcZCt1r7Zc1MZ
         JUf6xgEmOj7KS2VuyteLHtUTYMj95SqFyJ18IEpdHzJJHnCVKTvuI8aUoP2i+1PhboNS
         Vb04sU14omYas/bII0j6RemshEVqtVRq5LFoqwhuTt5PkmExtLZtnDd15DKBDwOZaOa9
         5HOw==
X-Gm-Message-State: AOJu0Yw/qg5qyJvq0fgUQxtT8kgSCsr5lXAK/McO52sez4lhIQioBwRJ
        f0ZLT2ohemCvYA92u8Hs0csjxqesxpRnyE41
X-Google-Smtp-Source: AGHT+IExRfgqF0ar4Uw/lTAoo37yoBstxFb3XX7ZSKhbmacQBwgsvAn76tNJe1OaOZAOL02C479skw==
X-Received: by 2002:a05:6402:26d4:b0:53e:37d1:a31f with SMTP id x20-20020a05640226d400b0053e37d1a31fmr2427959edd.28.1697560115437;
        Tue, 17 Oct 2023 09:28:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id b42-20020a509f2d000000b0053e43492ef1sm1515759edf.65.2023.10.17.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:28:35 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -tip v3 3/3] x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR
Date:   Tue, 17 Oct 2023 18:27:34 +0200
Message-ID: <20231017162811.200569-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017162811.200569-1-ubizjak@gmail.com>
References: <20231017162811.200569-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce x86_64 %rip-relative addressing to PER_CPU_VAR macro.
Instructions using %rip-relative address operand are one byte shorter
than their absolute address counterparts and are also compatible with
position independent executable (-fpie) build. The patch reduces
code size of a test kernel build by 150 bytes.

PER_CPU_VAR macro is intended to be applied to a symbol and should
not be used with register operands. Introduce new __percpu macro and
use it in cmpxchg{8,16}b_emu.S instead.

Also add a missing function comment to this_cpu_cmpxchg8b_emu.

No functional changes intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
--
v2: Introduce PER_CPU_ARG macro to conditionally enable
    segment registers in cmpxchg{8,16}b_emu.S for CONFIG_SMP.
v3: Introduce __percpu macro instead of PER_CPU_ARG (hpa).
---
 arch/x86/include/asm/percpu.h | 12 ++++++++----
 arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
 arch/x86/lib/cmpxchg8b_emu.S  | 30 +++++++++++++++++++++---------
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 54746903b8c3..02f1780f02f5 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -4,17 +4,21 @@
 
 #ifdef CONFIG_X86_64
 #define __percpu_seg		gs
+#define __percpu_rel		(%rip)
 #else
 #define __percpu_seg		fs
+#define __percpu_rel
 #endif
 
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_SMP
-#define PER_CPU_VAR(var)	%__percpu_seg:var
-#else /* ! SMP */
-#define PER_CPU_VAR(var)	var
-#endif	/* SMP */
+#define __percpu		%__percpu_seg:
+#else
+#define __percpu
+#endif
+
+#define PER_CPU_VAR(var)	__percpu(var)__percpu_rel
 
 #ifdef CONFIG_X86_64_SMP
 #define INIT_PER_CPU_VAR(var)  init_per_cpu__##var
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 6962df315793..4fb44894ad87 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -23,14 +23,14 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	cli
 
 	/* if (*ptr == old) */
-	cmpq	PER_CPU_VAR(0(%rsi)), %rax
+	cmpq	__percpu (%rsi), %rax
 	jne	.Lnot_same
-	cmpq	PER_CPU_VAR(8(%rsi)), %rdx
+	cmpq	__percpu 8(%rsi), %rdx
 	jne	.Lnot_same
 
 	/* *ptr = new */
-	movq	%rbx, PER_CPU_VAR(0(%rsi))
-	movq	%rcx, PER_CPU_VAR(8(%rsi))
+	movq	%rbx, __percpu (%rsi)
+	movq	%rcx, __percpu 8(%rsi)
 
 	/* set ZF in EFLAGS to indicate success */
 	orl	$X86_EFLAGS_ZF, (%rsp)
@@ -42,8 +42,8 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	/* *ptr != old */
 
 	/* old = *ptr */
-	movq	PER_CPU_VAR(0(%rsi)), %rax
-	movq	PER_CPU_VAR(8(%rsi)), %rdx
+	movq	__percpu (%rsi), %rax
+	movq	__percpu 8(%rsi), %rdx
 
 	/* clear ZF in EFLAGS to indicate failure */
 	andl	$(~X86_EFLAGS_ZF), (%rsp)
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 873e4ef23e49..1c96be769adc 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -24,12 +24,12 @@ SYM_FUNC_START(cmpxchg8b_emu)
 	pushfl
 	cli
 
-	cmpl	0(%esi), %eax
+	cmpl	(%esi), %eax
 	jne	.Lnot_same
 	cmpl	4(%esi), %edx
 	jne	.Lnot_same
 
-	movl	%ebx, 0(%esi)
+	movl	%ebx, (%esi)
 	movl	%ecx, 4(%esi)
 
 	orl	$X86_EFLAGS_ZF, (%esp)
@@ -38,7 +38,7 @@ SYM_FUNC_START(cmpxchg8b_emu)
 	RET
 
 .Lnot_same:
-	movl	0(%esi), %eax
+	movl	(%esi), %eax
 	movl	4(%esi), %edx
 
 	andl	$(~X86_EFLAGS_ZF), (%esp)
@@ -53,18 +53,30 @@ EXPORT_SYMBOL(cmpxchg8b_emu)
 
 #ifndef CONFIG_UML
 
+/*
+ * Emulate 'cmpxchg8b %fs:(%rsi)'
+ *
+ * Inputs:
+ * %esi : memory location to compare
+ * %eax : low 32 bits of old value
+ * %edx : high 32 bits of old value
+ * %ebx : low 32 bits of new value
+ * %ecx : high 32 bits of new value
+ *
+ * Notably this is not LOCK prefixed and is not safe against NMIs
+ */
 SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
 
 	pushfl
 	cli
 
-	cmpl	PER_CPU_VAR(0(%esi)), %eax
+	cmpl	__percpu (%esi), %eax
 	jne	.Lnot_same2
-	cmpl	PER_CPU_VAR(4(%esi)), %edx
+	cmpl	__percpu 4(%esi), %edx
 	jne	.Lnot_same2
 
-	movl	%ebx, PER_CPU_VAR(0(%esi))
-	movl	%ecx, PER_CPU_VAR(4(%esi))
+	movl	%ebx, __percpu (%esi)
+	movl	%ecx, __percpu 4(%esi)
 
 	orl	$X86_EFLAGS_ZF, (%esp)
 
@@ -72,8 +84,8 @@ SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
 	RET
 
 .Lnot_same2:
-	movl	PER_CPU_VAR(0(%esi)), %eax
-	movl	PER_CPU_VAR(4(%esi)), %edx
+	movl	__percpu (%esi), %eax
+	movl	__percpu 4(%esi), %edx
 
 	andl	$(~X86_EFLAGS_ZF), (%esp)
 
-- 
2.41.0

