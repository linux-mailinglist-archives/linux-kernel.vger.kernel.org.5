Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E129B7D0D16
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376845AbjJTK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376715AbjJTK27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:28:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEF5114;
        Fri, 20 Oct 2023 03:28:57 -0700 (PDT)
Date:   Fri, 20 Oct 2023 10:28:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697797735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RFHrA0nC1vueE8CtrHSfUQFbCQe9USd3Emg1LagU1lU=;
        b=F4RKXSo79c0qG+n0bR/rDCn+YFyDZlKsRsaFfovnaKGQS533pjYSCvbSZR/p+YQesWMzPi
        5fz3hAJEOcxNYMRCsLa//y4ZbIQFLUWtKJ1oF/6y2XFJdhJ4Pi+Gfy0hRlxQBGD3/dot08
        2xOmKa6aPlPdvolBRdBiiHZL+WtVIz018C8XbIVlValtwzqFnunMWE3rdtYWDS9GIPTU7s
        Ld0ymXylftCqNY0/qCI3ICzMZlCgXKkTEkNehxG+XqFMtR0FdWXTY9WEWhmddA/UoZodNx
        /UC6LXGKive9uycaNAI4hh4hElSklKH96lB/8jNUdTkr2Awsy+w0si3fWu1tlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697797735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RFHrA0nC1vueE8CtrHSfUQFbCQe9USd3Emg1LagU1lU=;
        b=EBR0GD43x6le+KsvK1EnVnPkT+ZneDugWPVL9I5ygDnY9Ytv2bMzTswPCZ7MXsDxmaqxwx
        TvRzxr5OvDVzZoDw==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Introduce %rip-relative addressing to
 PER_CPU_VAR()
Cc:     Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Brian Gerst <brgerst@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169779773451.3135.17158280311222053497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     59bec00ace28d565ae0a68b23063ef3b961d82d5
Gitweb:        https://git.kernel.org/tip/59bec00ace28d565ae0a68b23063ef3b961d82d5
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 17 Oct 2023 18:27:34 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 20 Oct 2023 12:19:51 +02:00

x86/percpu: Introduce %rip-relative addressing to PER_CPU_VAR()

Introduce x86_64 %rip-relative addressing to the PER_CPU_VAR() macro.
Instructions using %rip-relative address operand are one byte shorter
than their absolute address counterparts and are also compatible with
position independent executable (-fpie) builds. The patch reduces
code size of a test kernel build by 150 bytes.

The PER_CPU_VAR() macro is intended to be applied to a symbol and should
not be used with register operands. Introduce the new __percpu macro and
use it in cmpxchg{8,16}b_emu.S instead.

Also add a missing function comment to this_cpu_cmpxchg8b_emu().

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/percpu.h | 12 ++++++++----
 arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
 arch/x86/lib/cmpxchg8b_emu.S  | 30 +++++++++++++++++++++---------
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index ac3220a..bbcc1ca 100644
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
index 6962df3..4fb4489 100644
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
index 4980525..8632d7d 100644
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
 
