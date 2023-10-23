Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A797D3026
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjJWKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjJWKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:39:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3CDA;
        Mon, 23 Oct 2023 03:39:33 -0700 (PDT)
Date:   Mon, 23 Oct 2023 10:39:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698057572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpcW9/05c8vPddJwR7qGwxD6YERGkg5tE+9qWuZlV0I=;
        b=c9nJ+HzosX3V9UAxcuypDMOfc4SRUWpqytu+xsJMhLII2BZDcYEsS6kmYhnpZN+rFjM4R7
        DlnUh25VIMhIwXFF2R6qedQ/9JA0KrVw7AHGF/wYgrrifRQQEH7Z43hVIVWydXvNi8Sn8g
        XoSGLccjPv1kzf3WK9JU/f7C/b/IeDVyE4Jjf2HV3rsP6GHN3vnB4JN+GYzCo0/9FYaqaa
        25KUFEGA7GsNSaPd3nyInfPhseJ3O7aDKQRg/68xwGQ1akn9rM8DVm8uzC59aexjaAMdy9
        GSNahgLNR4EKgshfJnnBgTOrZBcDLrDHWwBq9Mt7S5J5rzz89/ZQaFB6ebjJlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698057572;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpcW9/05c8vPddJwR7qGwxD6YERGkg5tE+9qWuZlV0I=;
        b=63iiffRXMZf/n9aDfjtAXm42cWzQNh/PieZH/54tqbZoqJ1ijkgXAVyyayO5dwsAbXgSRM
        4jhBn6i8L4biJPCg==
From:   "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/percpu] x86/percpu: Introduce const-qualified
 const_pcpu_hot to micro-optimize code generation
Cc:     Nadav Amit <namit@vmware.com>, Uros Bizjak <ubizjak@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231020162004.135244-1-ubizjak@gmail.com>
References: <20231020162004.135244-1-ubizjak@gmail.com>
MIME-Version: 1.0
Message-ID: <169805757123.3135.742796790384706189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/percpu branch of tip:

Commit-ID:     ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
Gitweb:        https://git.kernel.org/tip/ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 20 Oct 2023 18:19:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Oct 2023 11:27:35 +02:00

x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation

Some variables in pcpu_hot, currently current_task and top_of_stack
are actually per-thread variables implemented as per-CPU variables
and thus stable for the duration of the respective task.  There is
already an attempt to eliminate redundant reads from these variables
using this_cpu_read_stable() asm macro, which hides the dependency
on the read memory address. However, the compiler has limited ability
to eliminate asm common subexpressions, so this approach results in a
limited success.

The solution is to allow more aggressive elimination by aliasing
pcpu_hot into a const-qualified const_pcpu_hot, and to read stable
per-CPU variables from this constant copy.

The current per-CPU infrastructure does not support reads from
const-qualified variables. However, when the compiler supports segment
qualifiers, it is possible to declare the const-aliased variable in
the relevant named address space. The compiler considers access to the
variable, declared in this way, as a read from a constant location,
and will optimize reads from the variable accordingly.

By implementing constant-qualified const_pcpu_hot, the compiler can
eliminate redundant reads from the constant variables, reducing the
number of loads from current_task from 3766 to 3217 on a test build,
a -14.6% reduction.

The reduction of loads translates to the following code savings:

        text           data     bss      dec            hex filename
  25,477,353        4389456  808452 30675261        1d4113d vmlinux-old.o
  25,476,074        4389440  808452 30673966        1d40c2e vmlinux-new.o

representing a code size reduction of -1279 bytes.

[ mingo: Updated the changelog, EXPORT(const_pcpu_hot). ]

Co-developed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20231020162004.135244-1-ubizjak@gmail.com
---
 arch/x86/include/asm/current.h   | 7 +++++++
 arch/x86/include/asm/percpu.h    | 6 +++---
 arch/x86/include/asm/processor.h | 3 +++
 arch/x86/kernel/cpu/common.c     | 1 +
 arch/x86/kernel/vmlinux.lds.S    | 1 +
 include/linux/compiler.h         | 2 +-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7..0538d24 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -36,8 +36,15 @@ static_assert(sizeof(struct pcpu_hot) == 64);
 
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
+/* const-qualified alias to pcpu_hot, aliased by linker. */
+DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+			const_pcpu_hot);
+
 static __always_inline struct task_struct *get_current(void)
 {
+	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+		return const_pcpu_hot.current_task;
+
 	return this_cpu_read_stable(pcpu_hot.current_task);
 }
 
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index bbcc1ca..b86b27d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -413,9 +413,9 @@ do {									\
  * accessed while this_cpu_read_stable() allows the value to be cached.
  * this_cpu_read_stable() is more efficient and can be used if its value
  * is guaranteed to be valid across cpus.  The current users include
- * get_current() and get_thread_info() both of which are actually
- * per-thread variables implemented as per-cpu variables and thus
- * stable for the duration of the respective task.
+ * pcpu_hot.current_task and pcpu_hot.top_of_stack, both of which are
+ * actually per-thread variables implemented as per-CPU variables and
+ * thus stable for the duration of the respective task.
  */
 #define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
 #define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 0086920..b47a997 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -518,6 +518,9 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  and around vm86 mode and sp0 on x86_64 is special because of the
 	 *  entry trampoline.
 	 */
+	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+		return pcpu_hot.top_of_stack;
+
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 382d4e6..4cc0ab0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2051,6 +2051,7 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
+EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2..e701f2d 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ ENTRY(phys_startup_64)
 #endif
 
 jiffies = jiffies_64;
+const_pcpu_hot = pcpu_hot;
 
 #if defined(CONFIG_X86_64)
 /*
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a1..bf9815e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -212,7 +212,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #define ___ADDRESSABLE(sym, __attrs) \
 	static void * __used __attrs \
-		__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)&sym;
+	__UNIQUE_ID(__PASTE(__addressable_,sym)) = (void *)(uintptr_t)&sym;
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
