Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394017C7229
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379324AbjJLQMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbjJLQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:12:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD18CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b275afb6abso489816866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127168; x=1697731968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQbyfobss6xeclCGhQMgW1ClZu9bZ4s/snJGfv9Jbpo=;
        b=niflDS6X1dHpvdvWUhc5qJK9T2fHqSk26XcjIsJazBrZWH1nx9ztIeYx7fKAcn3TMJ
         CQatCzmHsgDshvRRbJlpbUVu4l/G2KnbcMRPxNQbXKMS3hNcZsTi8B64ecELUnsgusiq
         fNjW0xUcUXIqTyGsyVly+eV9Mmp5UytFp19jMjo94Vp40/mPK+qtNeYf7JjJkGQAnfsb
         l1vP+wQXUs/XPeuhiuL/5DjbUwhJ8W+hV4pwHeibUWxB3AiM4jHNj/ovo/3JEThz2lZ2
         RYb8/T4jkE/mwoNFJx9jHGkJd3oMjboXGtTnffUCjqhIy8NyEING/8/PdHeHrUk1l4Sg
         U1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127168; x=1697731968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQbyfobss6xeclCGhQMgW1ClZu9bZ4s/snJGfv9Jbpo=;
        b=uhgjFI16fJXP3eb5GrU2l6UqEqqeroAGlwh5i2gXIoamHMnTclXWtg5V0fjiy6i0Md
         7GVyEy/lUgONygmh6kNfRel3/1VmoDonskPcA+GMPILckWY/qGoMRHnzCIlcF9Fv4RDC
         h0KxMjYxSJXsA160Qz1QBs8Fvnv+6IO+7/wrpye9/fdRJMsXpZhBX/z63eTLXY8bPIJF
         abmabMUgScMDQUhIZd0fhZtQMAQl+dcA8zyLkfi3YgRwASNaNB+O3Kv7jLxEt/blXdZx
         M7q7WbEqKQGgEKE8I2prIC3BUqDucKxQJUnTYq1CBTTjx/HAp7+OaYXqwYgX/UwG8YKr
         AOUA==
X-Gm-Message-State: AOJu0YwbhFijfH/SZKjaIEnMAowIRHVjhVpf+u3OD4z95tMxtp3wuIFS
        DuL43AIbr5GiILJhiggbHKF9lju7EYPvGDBb
X-Google-Smtp-Source: AGHT+IFcqbuNzLQmgxkQeiKP2KIso3r6ZxxKVuexp+Jb8ccabLciAyOXFrL77NO8rhOPn+oPIIJ4xw==
X-Received: by 2002:a17:906:99c5:b0:9ae:3768:f0ce with SMTP id s5-20020a17090699c500b009ae3768f0cemr20792970ejn.0.1697127167910;
        Thu, 12 Oct 2023 09:12:47 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ci24-20020a170906c35800b009a2235ed496sm11414461ejb.141.2023.10.12.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:12:47 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/4] x86/percpu: Use explicit segment registers in lib/cmpxchg{8,16}b_emu.S
Date:   Thu, 12 Oct 2023 18:10:36 +0200
Message-ID: <20231012161237.114733-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012161237.114733-1-ubizjak@gmail.com>
References: <20231012161237.114733-1-ubizjak@gmail.com>
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

PER_CPU_VAR macro is intended to be applied to a symbol, it is not
intended to be used as a selector between %fs and %gs segment
registers for general operands.

The address to these emulation functions is passed in a register, so
use explicit segment registers to access percpu variable instead.

Also add a missing function comment to this_cpu_cmpxchg8b_emu.

No functional changes intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
 arch/x86/lib/cmpxchg8b_emu.S  | 30 +++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 6962df315793..2bd8b89bce75 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -23,14 +23,14 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	cli
 
 	/* if (*ptr == old) */
-	cmpq	PER_CPU_VAR(0(%rsi)), %rax
+	cmpq	%gs:(%rsi), %rax
 	jne	.Lnot_same
-	cmpq	PER_CPU_VAR(8(%rsi)), %rdx
+	cmpq	%gs:8(%rsi), %rdx
 	jne	.Lnot_same
 
 	/* *ptr = new */
-	movq	%rbx, PER_CPU_VAR(0(%rsi))
-	movq	%rcx, PER_CPU_VAR(8(%rsi))
+	movq	%rbx, %gs:(%rsi)
+	movq	%rcx, %gs:8(%rsi)
 
 	/* set ZF in EFLAGS to indicate success */
 	orl	$X86_EFLAGS_ZF, (%rsp)
@@ -42,8 +42,8 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	/* *ptr != old */
 
 	/* old = *ptr */
-	movq	PER_CPU_VAR(0(%rsi)), %rax
-	movq	PER_CPU_VAR(8(%rsi)), %rdx
+	movq	%gs:(%rsi), %rax
+	movq	%gs:8(%rsi), %rdx
 
 	/* clear ZF in EFLAGS to indicate failure */
 	andl	$(~X86_EFLAGS_ZF), (%rsp)
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 49805257b125..b7d68d5e2d31 100644
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
+ * Emulate 'cmpxchg8b %fs:(%esi)'
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
+	cmpl	%fs:(%esi), %eax
 	jne	.Lnot_same2
-	cmpl	PER_CPU_VAR(4(%esi)), %edx
+	cmpl	%fs:4(%esi), %edx
 	jne	.Lnot_same2
 
-	movl	%ebx, PER_CPU_VAR(0(%esi))
-	movl	%ecx, PER_CPU_VAR(4(%esi))
+	movl	%ebx, %fs:(%esi)
+	movl	%ecx, %fs:4(%esi)
 
 	orl	$X86_EFLAGS_ZF, (%esp)
 
@@ -72,8 +84,8 @@ SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
 	RET
 
 .Lnot_same2:
-	movl	PER_CPU_VAR(0(%esi)), %eax
-	movl	PER_CPU_VAR(4(%esi)), %edx
+	movl	%fs:(%esi), %eax
+	movl	%fs:4(%esi), %edx
 
 	andl	$(~X86_EFLAGS_ZF), (%esp)
 
-- 
2.41.0

