Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A047B478D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjJANQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 09:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjJANQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 09:16:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0B8B7
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 06:16:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9a9f139cd94so2053740766b.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 06:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696166198; x=1696770998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rS7jRVcQ6NtK3qXxw1G/jurrddIxGHuAxg9jtCM/lIk=;
        b=m2mupvdZAqrvIuno5IiJqu1g9qD8GzP3o9vEponxLqFKoBzLJhUj8Dfi5v10h+Ntt5
         exI3hYsjznyqHqqhaUnGm7+Biw0SqJe2yzmFVC7cRKWF1cWL3XYAXkiGhewFamRRpMFy
         piUg/w62f5u3ZiCDeZfYoQWk43F9Y4sdY3Gc3F9Fbz46eOPxGmYXQ19MILM7MLPPNCyx
         P7iPvN6iUNA620abUPTAZ/lq2Q7zEQ1ha9pQhwsF1Ao4dkWGeTMKrdYW+VskvwIh/cTx
         57qxnHrj5zLA770JixGj/e+t5uJeLVEZKk/qc90c6ds0WGp86GqP+fVpD6M1nhTRXHfk
         E1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696166198; x=1696770998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rS7jRVcQ6NtK3qXxw1G/jurrddIxGHuAxg9jtCM/lIk=;
        b=sioa1j/ZyV5IFIsCgWUbx/7uIn0yKQkaGl0escLgNC8JC6BIA+ka4MEcBtEK44GATm
         CrwiH7utTBPhfpk4jSbyKehQ8VXV61RKRRFLr9YuuSdhAz3WH4nblCTv2d1Jnh+mzr19
         r7MIiTTl5Elpz6/8GO/YR9w8K5k4pDOlpES9Szw9fXe9hAIQysZ0GngccUCzwxEG2BEu
         kn0r5iGwA5fVxf/VQRksml1togmWEaTgsc9KZnfVLG2+VPFb6rIy2sfglKrCS2Ad7cRX
         tb7JTsWRaXuecF27bOri7gWxfHVyUv6GFGRBhgbVBN8RNAIRWnvCM4ScdKYW1HPbG890
         UosQ==
X-Gm-Message-State: AOJu0YwVGSSxzoSw4byu9sAz8kf9wwqUmQhtZJdGr8q+pAfPvjMskg/W
        J2R5N+/0Pm1YWM0HlX1d044=
X-Google-Smtp-Source: AGHT+IFqb1idNfPnJMnfnXkq8sZ2ptjGTnbjcG0pTq6iBMVgE2OAoL+xBuTRFQyjqaWDlJrFLy6INw==
X-Received: by 2002:a17:906:5397:b0:9ae:4f13:e581 with SMTP id g23-20020a170906539700b009ae4f13e581mr8391092ejo.59.1696166198188;
        Sun, 01 Oct 2023 06:16:38 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id lv23-20020a170906bc9700b0099d798a6bb5sm15504272ejb.67.2023.10.01.06.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 06:16:37 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH 3/4] x86/percpu: Use compiler segment prefix qualifier
Date:   Sun,  1 Oct 2023 15:14:35 +0200
Message-ID: <20231001131620.112484-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001131620.112484-1-ubizjak@gmail.com>
References: <20231001131620.112484-1-ubizjak@gmail.com>
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

From: Nadav Amit <namit@vmware.com>

Using a segment prefix qualifier is cleaner than using a segment prefix
in the inline assembly, and provides the compiler with more information,
telling it that __seg_gs:[addr] is different than [addr] when it
analyzes data dependencies. It also enables various optimizations that
will be implemented in the next patches.

Use segment prefix qualifiers when they are supported. Unfortunately,
gcc does not provide a way to remove segment qualifiers, which is needed
to use typeof() to create local instances of the per-cpu variable. For
this reason, do not use the segment qualifier for per-cpu variables, and
do casting using the segment qualifier instead.

Uros: Improve compiler support detection and update the patch
to the current mainline.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h  | 68 +++++++++++++++++++++++-----------
 arch/x86/include/asm/preempt.h |  2 +-
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20624b80f890..da451202a1b9 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -28,26 +28,50 @@
 #include <linux/stringify.h>
 
 #ifdef CONFIG_SMP
+
+#ifdef CONFIG_CC_HAS_NAMED_AS
+
+#ifdef CONFIG_X86_64
+#define __percpu_seg_override	__seg_gs
+#else
+#define __percpu_seg_override	__seg_fs
+#endif
+
+#define __percpu_prefix		""
+
+#else /* CONFIG_CC_HAS_NAMED_AS */
+
+#define __percpu_seg_override
 #define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
+
+#endif /* CONFIG_CC_HAS_NAMED_AS */
+
+#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
  */
-#define arch_raw_cpu_ptr(ptr)				\
-({							\
-	unsigned long tcp_ptr__;			\
-	asm ("add " __percpu_arg(1) ", %0"		\
-	     : "=r" (tcp_ptr__)				\
-	     : "m" (this_cpu_off), "0" (ptr));		\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;	\
+#define arch_raw_cpu_ptr(ptr)					\
+({								\
+	unsigned long tcp_ptr__;				\
+	asm ("add " __percpu_arg(1) ", %0"			\
+	     : "=r" (tcp_ptr__)					\
+	     : "m" (__my_cpu_var(this_cpu_off)), "0" (ptr));	\
+	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#else
+#else /* CONFIG_SMP */
+#define __percpu_seg_override
 #define __percpu_prefix		""
-#endif
+#define __force_percpu_prefix	""
+#endif /* CONFIG_SMP */
 
+#define __my_cpu_type(var)	typeof(var) __percpu_seg_override
+#define __my_cpu_ptr(ptr)	(__my_cpu_type(*ptr) *)(uintptr_t)(ptr)
+#define __my_cpu_var(var)	(*__my_cpu_ptr(&var))
 #define __percpu_arg(x)		__percpu_prefix "%" #x
+#define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
 
 /*
  * Initialized pointers to per-cpu variables needed for the boot
@@ -107,14 +131,14 @@ do {									\
 		(void)pto_tmp__;					\
 	}								\
 	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
-	    : [var] "+m" (_var)						\
+	    : [var] "+m" (__my_cpu_var(_var))				\
 	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
 #define percpu_unary_op(size, qual, op, _var)				\
 ({									\
 	asm qual (__pcpu_op1_##size(op, __percpu_arg([var]))		\
-	    : [var] "+m" (_var));					\
+	    : [var] "+m" (__my_cpu_var(_var)));				\
 })
 
 /*
@@ -144,14 +168,14 @@ do {									\
 	__pcpu_type_##size pfo_val__;					\
 	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "m" (_var));					\
+	    : [var] "m" (__my_cpu_var(_var)));				\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_stable_op(size, op, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __percpu_arg(P[var]), "%[val]")	\
+	asm(__pcpu_op2_##size(op, __force_percpu_arg(P[var]), "%[val]")	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
 	    : [var] "p" (&(_var)));					\
 	(typeof(_var))(unsigned long) pfo_val__;			\
@@ -166,7 +190,7 @@ do {									\
 	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
 				     __percpu_arg([var]))		\
 		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : : "memory");					\
 	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
 })
@@ -187,7 +211,7 @@ do {									\
 				    __percpu_arg([var]))		\
 		  "\n\tjnz 1b"						\
 		  : [oval] "=&a" (pxo_old__),				\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pxo_new__)		\
 		  : "memory");						\
 	(typeof(_var))(unsigned long) pxo_old__;			\
@@ -204,7 +228,7 @@ do {									\
 	asm qual (__pcpu_op2_##size("cmpxchg", "%[nval]",		\
 				    __percpu_arg([var]))		\
 		  : [oval] "+a" (pco_old__),				\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
 	(typeof(_var))(unsigned long) pco_old__;			\
@@ -221,7 +245,7 @@ do {									\
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
 		    [oval] "+a" (pco_old__),				\
-		    [var] "+m" (_var)					\
+		    [var] "+m" (__my_cpu_var(_var))			\
 		  : [nval] __pcpu_reg_##size(, pco_new__)		\
 		  : "memory");						\
 	if (unlikely(!success))						\
@@ -244,7 +268,7 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : [var] "+m" (_var),					\
+		  : [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -276,7 +300,7 @@ do {									\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
-		    [var] "+m" (_var),					\
+		    [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -313,7 +337,7 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (_var),					\
+		  : [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -345,7 +369,7 @@ do {									\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
 		  : CC_OUT(z) (success),				\
-		    [var] "+m" (_var),					\
+		    [var] "+m" (__my_cpu_var(_var)),			\
 		    "+a" (old__.low),					\
 		    "+d" (old__.high)					\
 		  : "b" (new__.low),					\
@@ -494,7 +518,7 @@ static inline bool x86_this_cpu_variable_test_bit(int nr,
 	asm volatile("btl "__percpu_arg(2)",%1"
 			CC_SET(c)
 			: CC_OUT(c) (oldbit)
-			: "m" (*(unsigned long __percpu *)addr), "Ir" (nr));
+			: "m" (*__my_cpu_ptr((unsigned long __percpu *)(addr))), "Ir" (nr));
 
 	return oldbit;
 }
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 2d13f25b1bd8..e25b95e7cf82 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -92,7 +92,7 @@ static __always_inline void __preempt_count_sub(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", pcpu_hot.preempt_count, e,
+	return GEN_UNARY_RMWcc("decl", __my_cpu_var(pcpu_hot.preempt_count), e,
 			       __percpu_arg([var]));
 }
 
-- 
2.41.0

