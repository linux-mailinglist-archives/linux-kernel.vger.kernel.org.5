Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE57B9E8A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbjJEOId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjJEOGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:06:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE527A87;
        Thu,  5 Oct 2023 00:20:20 -0700 (PDT)
Date:   Thu, 05 Oct 2023 07:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696490418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxdkJDsagE2u95u3CrNYRo5RQ6LTld++pfOtIiKNmso=;
        b=44BGnwY1Bew5PdTSxmHsVCScK1/vW9C55m2KBObUwE0tiGi2aOQlWkdmFVvNYSuEBMstfz
        bPtHuzdwQROYaIYc5G8JRPlTAEFPOqGTWYJA+xbHZvfnpd1GCjkzMy0QS4aSYagpxoO7Gk
        8C/HSKcs8qL10oTrCNoeedia05GJXh0v2LJU5FTAJa60ydfXuodgJCDrHylSYUy/FN3UBn
        aWK/224p1TG99ITH9Vdhkzkn2AyTDooFAdGSGVXdF4ieQouLijdIDfWo6du4K4OVZPZONS
        n/OM11LYwSk2yQRCmJ54fg3x1rsMx4DnF68GJP5+d+1pkPda91MP4Id6AUkJaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696490418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SxdkJDsagE2u95u3CrNYRo5RQ6LTld++pfOtIiKNmso=;
        b=VA/CYKv2GfnjnTV3qLiToJnimPOveh0mnodHYNgprwd5FM5h+tYRQ8Zi7+q0og0aPv0+45
        ernBwKYAC0PpBUCQ==
From:   "tip-bot2 for Nadav Amit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Use compiler segment prefix qualifier
Cc:     Nadav Amit <namit@vmware.com>, Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231004145137.86537-4-ubizjak@gmail.com>
References: <20231004145137.86537-4-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169649041744.3135.4005058021349151239.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     9a462b9eafa6dda16ea8429b151edb1fb535d744
Gitweb:        https://git.kernel.org/tip/9a462b9eafa6dda16ea8429b151edb1fb535d744
Author:        Nadav Amit <namit@vmware.com>
AuthorDate:    Wed, 04 Oct 2023 16:49:43 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 09:01:52 +02:00

x86/percpu: Use compiler segment prefix qualifier

Using a segment prefix qualifier is cleaner than using a segment prefix
in the inline assembly, and provides the compiler with more information,
telling it that __seg_gs:[addr] is different than [addr] when it
analyzes data dependencies. It also enables various optimizations that
will be implemented in the next patches.

Use segment prefix qualifiers when they are supported. Unfortunately,
gcc does not provide a way to remove segment qualifiers, which is needed
to use typeof() to create local instances of the per-CPU variable. For
this reason, do not use the segment qualifier for per-CPU variables, and
do casting using the segment qualifier instead.

Uros: Improve compiler support detection and update the patch
to the current mainline.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20231004145137.86537-4-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h  | 68 ++++++++++++++++++++++-----------
 arch/x86/include/asm/preempt.h |  2 +-
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 20624b8..da45120 100644
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
index 4527e14..4b2a35d 100644
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
 
