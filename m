Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E547BA697
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjJEQit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjJEQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:38:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1217A8F;
        Thu,  5 Oct 2023 00:20:21 -0700 (PDT)
Date:   Thu, 05 Oct 2023 07:20:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696490417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCaK47zDCHa+WUW6K8uJlvzYxhvz2WFUP53che6f/SQ=;
        b=04YeYcBOoWjyk8/OvJFvsZDHE/6k7k9YhetsTLLGy7GxKFgecly1oRh7BpgrwA3CM081JO
        +rhYbyOslujZxT0wx+J025OdaWaMx+LyrpE8Dx9Db5AsORAilcUaxOwBKFyHwAolz81Qva
        x9CyOmeFl0ZLacVYv0bTZjTM50uDpCzl9yVgE6Qq01QuRjktKIWkBM47MO3pZH0YhGGGhy
        k/9fR2CtEKTe1fy7PlmJCNyMKZDo/nziAP8a3oaw2yDhwC3sjpHhyqLhbpBV5QCgvVjxSl
        euyezZzavAGBrW01a0/U1+iWUy6IruMVT1/CPmKjcqdOr3yi43Kf8Qy6WKxmrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696490417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCaK47zDCHa+WUW6K8uJlvzYxhvz2WFUP53che6f/SQ=;
        b=bdBu45+tykw16T2IiPNtLkS4ex8eSEjydy9tgHvUZPnsIUzy+xkDKUAov+UFub+EdVKQZJ
        2qxiokcOL2nLFdCg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Use C for percpu read/write accessors
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
In-Reply-To: <20231004192404.31733-1-ubizjak@gmail.com>
References: <20231004192404.31733-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169649041650.3135.17524840710193792958.tip-bot2@tip-bot2>
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

Commit-ID:     ca4256348660cb2162668ec3d13d1f921d05374a
Gitweb:        https://git.kernel.org/tip/ca4256348660cb2162668ec3d13d1f921d05374a
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Wed, 04 Oct 2023 21:23:08 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 09:01:53 +02:00

x86/percpu: Use C for percpu read/write accessors

The percpu code mostly uses inline assembly. Using segment qualifiers
allows to use C code instead, which enables the compiler to perform
various optimizations (e.g. propagation of memory arguments). Convert
percpu read and write accessors to C code, so the memory argument can
be propagated to the instruction that uses this argument.

Some examples of propagations:

a) into sign/zero extensions:

the code improves from:

    65 8a 05 00 00 00 00    mov    %gs:0x0(%rip),%al
    0f b6 c0                movzbl %al,%eax

to:

    65 0f b6 05 00 00 00    movzbl %gs:0x0(%rip),%eax
    00

and in a similar way for:

    movzbl %gs:0x0(%rip),%edx
    movzwl %gs:0x0(%rip),%esi
    movzbl %gs:0x78(%rbx),%eax

    movslq %gs:0x0(%rip),%rdx
    movslq %gs:(%rdi),%rbx

b) into compares:

the code improves from:

    65 8b 05 00 00 00 00    mov    %gs:0x0(%rip),%eax
    a9 00 00 0f 00          test   $0xf0000,%eax

to:

    65 f7 05 00 00 00 00    testl  $0xf0000,%gs:0x0(%rip)
    00 00 0f 00

and in a similar way for:

    testl  $0xf0000,%gs:0x0(%rip)
    testb  $0x1,%gs:0x0(%rip)
    testl  $0xff00,%gs:0x0(%rip)

    cmpb   $0x0,%gs:0x0(%rip)
    cmp    %gs:0x0(%rip),%r14d
    cmpw   $0x8,%gs:0x0(%rip)
    cmpb   $0x0,%gs:(%rax)

c) into other insns:

the code improves from:

   1a355:	83 fa ff             	cmp    $0xffffffff,%edx
   1a358:	75 07                	jne    1a361 <...>
   1a35a:	65 8b 15 00 00 00 00 	mov    %gs:0x0(%rip),%edx
   1a361:

to:

   1a35a:	83 fa ff             	cmp    $0xffffffff,%edx
   1a35d:	65 0f 44 15 00 00 00 	cmove  %gs:0x0(%rip),%edx
   1a364:	00

The above propagations result in the following code size
improvements for current mainline kernel (with the default config),
compiled with:

   # gcc (GCC) 12.3.1 20230508 (Red Hat 12.3.1-1)

   text            data     bss    dec             filename
   25508862        4386540  808388 30703790        vmlinux-vanilla.o
   25500922        4386532  808388 30695842        vmlinux-new.o

Co-developed-by: Nadav Amit <namit@vmware.com>
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
Link: https://lore.kernel.org/r/20231004192404.31733-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 65 ++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index da45120..60ea775 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -400,13 +400,66 @@ do {									\
 #define this_cpu_read_stable_8(pcp)	percpu_stable_op(8, "mov", pcp)
 #define this_cpu_read_stable(pcp)	__pcpu_size_call_return(this_cpu_read_stable_, pcp)
 
+#ifdef CONFIG_USE_X86_SEG_SUPPORT
+
+#define __raw_cpu_read(qual, pcp)					\
+({									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp));		\
+})
+
+#define __raw_cpu_write(qual, pcp, val)					\
+do {									\
+	*(qual __my_cpu_type(pcp) *)__my_cpu_ptr(&(pcp)) = (val);	\
+} while (0)
+
+#define raw_cpu_read_1(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_read_2(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_read_4(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_write_1(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_write_2(pcp, val)	__raw_cpu_write(, pcp, val)
+#define raw_cpu_write_4(pcp, val)	__raw_cpu_write(, pcp, val)
+
+#define this_cpu_read_1(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_read_2(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_read_4(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_write_1(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_write_2(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#define this_cpu_write_4(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+
+#ifdef CONFIG_X86_64
+#define raw_cpu_read_8(pcp)		__raw_cpu_read(, pcp)
+#define raw_cpu_write_8(pcp, val)	__raw_cpu_write(, pcp, val)
+
+#define this_cpu_read_8(pcp)		__raw_cpu_read(volatile, pcp)
+#define this_cpu_write_8(pcp, val)	__raw_cpu_write(volatile, pcp, val)
+#endif
+
+#else /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
 #define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
-
 #define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
 #define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
 #define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
+
+#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
+
+#ifdef CONFIG_X86_64
+#define raw_cpu_read_8(pcp)		percpu_from_op(8, , "mov", pcp)
+#define raw_cpu_write_8(pcp, val)	percpu_to_op(8, , "mov", (pcp), val)
+
+#define this_cpu_read_8(pcp)		percpu_from_op(8, volatile, "mov", pcp)
+#define this_cpu_write_8(pcp, val)	percpu_to_op(8, volatile, "mov", (pcp), val)
+#endif
+
+#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(1, , (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(2, , (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(4, , (pcp), val)
@@ -432,12 +485,6 @@ do {									\
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
-#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
 #define this_cpu_add_1(pcp, val)	percpu_add_op(1, volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(2, volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(4, volatile, (pcp), val)
@@ -476,8 +523,6 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op(8, , "mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
@@ -486,8 +531,6 @@ do {									\
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(8, , pcp, oval, nval)
 #define raw_cpu_try_cmpxchg_8(pcp, ovalp, nval)	percpu_try_cmpxchg_op(8, , pcp, ovalp, nval)
 
-#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
