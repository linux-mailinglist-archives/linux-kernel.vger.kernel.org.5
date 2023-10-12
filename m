Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1337C77BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442682AbjJLUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343828AbjJLUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 16:18:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFFEBB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:17:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso227739766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 13:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697141875; x=1697746675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP3aL79sYs1c4BQa/blYah2PDJJ2vnSgtty8PYNApno=;
        b=OBT+JQwUiTaaewIJOAP8bA/+OUrV5fINBa6qSsFmrEtVpBM26wwelwIH96gPAVMzFp
         6Y5wjg5KpnX4eOkpCozcTlPSSzskM7X51/eFC61KtpVYdBcL5TamUmlUPjeNfWZmoKUd
         lL6fPZfpR2aiuDRFiLtHZGRZwaLqbt/4YtbR2wzfn5WJ6YpF6whl+TCiGNMwDFzXQPHq
         Kmdu04kKTu7WJast9a1x5GfdzEk5gCzR2M75U7gLxlqMtBjLIV9xnUMft739C7Ay2QLJ
         oZkMgI7HWgovoXKUaFZJWbffiKaDyIi1t2glat08mScCUqVwWN/86F4WrtxaplJNEOGe
         KqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697141875; x=1697746675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dP3aL79sYs1c4BQa/blYah2PDJJ2vnSgtty8PYNApno=;
        b=TfRmPiIkTNXYoyB5jg/zQiBe3RkWq2VXGy9i31aHRQ6Uo+Tej63ocyCE0cijViAFct
         iA+r5qt3D7UlgPs1i/yIYHEiDsz1aqraebUnBppVG4boY55qVEoVC7QmiArUM4+GIivr
         W6DHP2msIOwomRfJSNnNLPVPJDZq5ry5+9YHtPHDnoOMXKmN3E2fAD61achel/qqyGbO
         GlmC6Vc4oF8TSxVo24XNJ6vSKA3ayT/UW7dThzV1/E0oNmmANDUeh7xYI0D6dG+6IVqB
         gAuiTIfNlnNvq/tMaNn2hRwhwlgQyr4pKNQNHuNqBmwMa7vbQT6jo44vA3YW+GR6Ggiq
         QC+Q==
X-Gm-Message-State: AOJu0YwPgMftuJN9ftvcpSKPrba11Udc87IDr6AT/Q1tghWOfNiPOybv
        roesfwY9srXzojK3zzfe4qQ=
X-Google-Smtp-Source: AGHT+IELD/QO6fBcwqkcTgyrHC0COQGBYhxDdLfdbjk87Rjg0EnZvIr/K2PKpKW7JQhrL4PcCINltg==
X-Received: by 2002:a17:907:c205:b0:9a5:c54f:da1c with SMTP id ti5-20020a170907c20500b009a5c54fda1cmr22823408ejc.47.1697141874988;
        Thu, 12 Oct 2023 13:17:54 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709064ec300b00997d7aa59fasm11692552ejv.14.2023.10.12.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:17:54 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/4] x86/percpu: Introduce PER_CPU_ARG and use it in cmpxchg{8,16}b_emu.S
Date:   Thu, 12 Oct 2023 22:12:04 +0200
Message-ID: <20231012201743.292149-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012201743.292149-1-ubizjak@gmail.com>
References: <20231012201743.292149-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PER_CPU_VAR macro is intended to be applied to a symbol and should not
be used with general operands. Introduce new PER_CPU_ARG macro and
use it in cmpxchg{8,16}b_emu.S instead.

PER_CPU_VAR macro will be repurposed for %rip-relative addressing.

Also add a missing function comment to this_cpu_cmpxchg8b_emu.

No functional changes intended.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
--
v2: Introduce PER_CPU_ARG macro to conditionally enable
    segment registers in cmpxchg{8,16}b_emu.S for CONFIG_SMP.
---
 arch/x86/include/asm/percpu.h |  2 ++
 arch/x86/lib/cmpxchg16b_emu.S | 12 ++++++------
 arch/x86/lib/cmpxchg8b_emu.S  | 24 ++++++++++++++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 34734d730463..83e6a4bcea38 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -11,8 +11,10 @@
 #ifdef __ASSEMBLY__
 
 #ifdef CONFIG_SMP
+#define PER_CPU_ARG(arg)	%__percpu_seg:arg
 #define PER_CPU_VAR(var)	%__percpu_seg:var
 #else /* ! SMP */
+#define PER_CPU_ARG(arg)	arg
 #define PER_CPU_VAR(var)	var
 #endif	/* SMP */
 
diff --git a/arch/x86/lib/cmpxchg16b_emu.S b/arch/x86/lib/cmpxchg16b_emu.S
index 6962df315793..b6b942d07a00 100644
--- a/arch/x86/lib/cmpxchg16b_emu.S
+++ b/arch/x86/lib/cmpxchg16b_emu.S
@@ -23,14 +23,14 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	cli
 
 	/* if (*ptr == old) */
-	cmpq	PER_CPU_VAR(0(%rsi)), %rax
+	cmpq	PER_CPU_ARG(0(%rsi)), %rax
 	jne	.Lnot_same
-	cmpq	PER_CPU_VAR(8(%rsi)), %rdx
+	cmpq	PER_CPU_ARG(8(%rsi)), %rdx
 	jne	.Lnot_same
 
 	/* *ptr = new */
-	movq	%rbx, PER_CPU_VAR(0(%rsi))
-	movq	%rcx, PER_CPU_VAR(8(%rsi))
+	movq	%rbx, PER_CPU_ARG(0(%rsi))
+	movq	%rcx, PER_CPU_ARG(8(%rsi))
 
 	/* set ZF in EFLAGS to indicate success */
 	orl	$X86_EFLAGS_ZF, (%rsp)
@@ -42,8 +42,8 @@ SYM_FUNC_START(this_cpu_cmpxchg16b_emu)
 	/* *ptr != old */
 
 	/* old = *ptr */
-	movq	PER_CPU_VAR(0(%rsi)), %rax
-	movq	PER_CPU_VAR(8(%rsi)), %rdx
+	movq	PER_CPU_ARG(0(%rsi)), %rax
+	movq	PER_CPU_ARG(8(%rsi)), %rdx
 
 	/* clear ZF in EFLAGS to indicate failure */
 	andl	$(~X86_EFLAGS_ZF), (%rsp)
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 49805257b125..9a0a7feeaf7c 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
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
+	cmpl	PER_CPU_ARG(0(%esi)), %eax
 	jne	.Lnot_same2
-	cmpl	PER_CPU_VAR(4(%esi)), %edx
+	cmpl	PER_CPU_ARG(4(%esi)), %edx
 	jne	.Lnot_same2
 
-	movl	%ebx, PER_CPU_VAR(0(%esi))
-	movl	%ecx, PER_CPU_VAR(4(%esi))
+	movl	%ebx, PER_CPU_ARG(0(%esi))
+	movl	%ecx, PER_CPU_ARG(4(%esi))
 
 	orl	$X86_EFLAGS_ZF, (%esp)
 
@@ -72,8 +84,8 @@ SYM_FUNC_START(this_cpu_cmpxchg8b_emu)
 	RET
 
 .Lnot_same2:
-	movl	PER_CPU_VAR(0(%esi)), %eax
-	movl	PER_CPU_VAR(4(%esi)), %edx
+	movl	PER_CPU_ARG(0(%esi)), %eax
+	movl	PER_CPU_ARG(4(%esi)), %edx
 
 	andl	$(~X86_EFLAGS_ZF), (%esp)
 
-- 
2.41.0

