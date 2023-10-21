Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B257D1D82
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjJUOh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUOhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:37:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A0D5B
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:37:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9becde9ea7bso614352866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697899071; x=1698503871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A4pUxzTEqmI0KLXHFsmhEKj3JzjklMT09D9RoLa7I6c=;
        b=S2dF3fOApsGDVC4AAnbIVELBtIy3n3L+K2+CBXQOm3/4NglDjBGE57CdQeweJAfs1V
         M70WMRxE0AkEuAio/VA0SNAos8avgIXw4iT3oiWbKouGc/Ft4Udp1DKaTcgGCMPgAAwP
         iiF9XCP98U+soe3HO0g6xvWEziePwXvCzptrpglbm4pgCa3UxHhJvFFJ3xwOrylcoRQJ
         gmv2mvRTqjttcwh/7jqpEWrS8OzT4E8ZTYG9b5v2O+NQLISaVGP7p5qTtWYbwmzr4puC
         1/vdZx2g6R8V2m6Bhz1UPmb82SRmh0QkRX7O8dMZH6FgWByY71T+TSnyOoAp0HlwPCW3
         E5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697899071; x=1698503871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4pUxzTEqmI0KLXHFsmhEKj3JzjklMT09D9RoLa7I6c=;
        b=ByGR16h81Vm4S7h1AqmE5OT8DqWIhfeufgePyfvtBpkDXzIjf2rCB0vRIWrIuJ6BT2
         2RjD2Q89XraAG5dFMWWlnWeGQUGF99ldBThAS2ICYKJbVG9urzkEADt1VQb6NKRFOu1y
         LA+KWhXIHknfMQRNBKr6dxQJWSIP7OSgZxXkhlOxJpPbvHnziAma/ncCwn050p1AnPlw
         pKkFYtAQ1QUnTplBgBP1k1Ik5XLT5TqZhv35KZY062f5y1PZfOKzWjP2K8ry1nOgmpHu
         YhrocAdl7DLQpHyOUxN3WIF/biM1B2k8h+keAzWGuRatpoowoUA+PIRSRkZmA6RT6lJI
         XNMQ==
X-Gm-Message-State: AOJu0YzUzSI/1nWm28myYIoiP46Oim8ovT9OP6aj72eAsFc6i/9c0ys+
        Djg7fSP8b225DNVyNzEm6vs=
X-Google-Smtp-Source: AGHT+IHvLQNt373iKnkUAMMv0uqeQhkSSPh0nhT/+40a0VuR41cjvm2XLzULUe48pAzrCzCy5zWmzw==
X-Received: by 2002:a17:906:f291:b0:9c7:6523:407b with SMTP id gu17-20020a170906f29100b009c76523407bmr4677146ejb.17.1697899071232;
        Sat, 21 Oct 2023 07:37:51 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id p26-20020a170906229a00b009b65a698c16sm3703310eja.220.2023.10.21.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 07:37:50 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH -tip v2] x86/percpu: Introduce const-qualified const_pcpu_hot
Date:   Sat, 21 Oct 2023 16:36:59 +0200
Message-ID: <20231021143739.843941-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Some variables in pcpu_hot, currently current_task and top_of_stack
are actually per-thread variables implemented as per-cpu variables
and thus stable for the duration of the respective task.  There is
already an attempt to eliminate redundant reads from these variables
using this_cpu_read_stable() asm macro, which hides the dependency
on the read memory address. However, the compiler has limited ability
to eliminate asm common subexpressions, so this approach results in a
limited success.

The solution is to allow more aggressive elimination by aliasing
pcpu_hot into a const-qualified const_pcpu_hot, and to read stable
per-cpu variables from this constant copy.

The current per-cpu infrastructure does not support reads from
const-qualified variables. However, when the compiler supports segment
qualifiers, it is possible to declare the const-aliased variable in
the relevant named address space. The compiler considers access to the
variable, declared in this way, as a read from a constant location,
and will optimize reads from the variable accordingly.

By implementing constant-qualified const_pcpu_hot, the compiler can
eliminate redundant reads from the constant variables, reducing the
number of loads from current_task from 3766 to 3217 on a test build,
a 14.6% reduction.

The reduction of loads translates to the following code savings:

   text    data     bss     dec     hex filename
25477353        4389456  808452 30675261        1d4113d vmlinux-old.o
25476074        4389440  808452 30673966        1d40c2e vmlinux-new.o

representing a code size reduction of 1279 bytes.
---
v2: Export const_pcpu_hot symbol.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Co-developed-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/current.h   | 7 +++++++
 arch/x86/include/asm/percpu.h    | 6 +++---
 arch/x86/include/asm/processor.h | 3 +++
 arch/x86/kernel/cpu/common.c     | 1 +
 arch/x86/kernel/vmlinux.lds.S    | 1 +
 include/linux/compiler.h         | 2 +-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7b69e5..0538d2436673 100644
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
index bbcc1ca737f0..630bb912a46b 100644
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
+ * actually per-thread variables implemented as per-cpu variables and
+ * thus stable for the duration of the respective task.
  */
 #define this_cpu_read_stable_1(pcp)	percpu_stable_op(1, "mov", pcp)
 #define this_cpu_read_stable_2(pcp)	percpu_stable_op(2, "mov", pcp)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index ae81a7191c1c..a807025a4dee 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -533,6 +533,9 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  and around vm86 mode and sp0 on x86_64 is special because of the
 	 *  entry trampoline.
 	 */
+	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+		return pcpu_hot.top_of_stack;
+
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b14fc8c1c953..9058da9ae011 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2049,6 +2049,7 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
+EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);
 
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 54a5596adaa6..1239be7cc8d8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ ENTRY(phys_startup_64)
 #endif
 
 jiffies = jiffies_64;
+const_pcpu_hot = pcpu_hot;
 
 #if defined(CONFIG_X86_64)
 /*
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index d7779a18b24f..bf9815eaf4aa 100644
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
 
-- 
2.41.0

