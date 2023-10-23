Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DED7D3956
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjJWOba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjJWOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:31:28 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7863B100
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:31:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b95622c620so516356266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698071485; x=1698676285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCrIDDGUzoTCFuRz62JE4CkhtkOJ+rZqIv4mIF+kCq4=;
        b=EczKbvaQ74I7H4rsy0tJulGGJzsOAWvrZ3ifdNGqcv3xsAi5WqTcpxDzV9PGGDM+Cx
         F7AE4McsJvfc+JSWdvT3rQzFhqEnGxMjRqoXEjKVqO6Ya63OmZagD40I1bomCwxQz9ol
         5uC8fNL0LQwbq9ZF6v/FFiDxs+d1h7LgfCnHjJwXzaMNYnalUnzFYKVqwSneACOi65X5
         VlSOgKSvaSIYwB0LHaXUf58WrEkRr+EKb8s+22sn5YoyOF1Txsukbr/xzOWhye3M539j
         TTaJWd+fhrH+qj8o2J2Ry/outsB+XK+RM+NBkTjFKhk3SCAbM3Br73hNELHCDuP9F20f
         STIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698071485; x=1698676285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCrIDDGUzoTCFuRz62JE4CkhtkOJ+rZqIv4mIF+kCq4=;
        b=edFYfY5lXmOMF9/4zpMBsB+wYkqbqkejvDaAuHT7Pd+b4PDh4qvHAl4k3yr8iI9PMc
         3MBDuPS/HkxgI36JHbXHTqYiROUfbEsjA4lD189ekNCLp/PRpo9Tjdp6zj7sTay3rtWz
         wboVUfDrXIx2Ny0Hf9tEfKob6dTUhwMtll6telJfHcNTbnC/Feug0AM3Vd/6PoO5Da68
         2rZmAobFP7STWGli4kDvvCgjMX12Ipt3FjgUKJWhIHOKNC385vCB7xeb5ABRdyyX1Z2A
         GoYqeIEKfFwxKgnX3VIX3eiHPiSCSLdKINsoRxDh3VGpk6vZBfLWAM0ZBbYKnu4PqoVS
         iF1w==
X-Gm-Message-State: AOJu0Yx5xqR7V05vT6riaY7Sr80ID5SmSUHlzLduu/tiOhdUbpeQYqip
        Scgv3IjXFsoojkQN5+rEkMc=
X-Google-Smtp-Source: AGHT+IHvmuip+XgVHXialKUjaFJw6X51q7620OSdtGPyDK5FCe8hWptx4Q6fVX5Y2yYMMW7g3ZTBjw==
X-Received: by 2002:a17:907:72ce:b0:9bf:b5bc:6c50 with SMTP id du14-20020a17090772ce00b009bfb5bc6c50mr8084992ejc.4.1698071484617;
        Mon, 23 Oct 2023 07:31:24 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ov5-20020a170906fc0500b009ad8acac02asm6805389ejb.172.2023.10.23.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:31:24 -0700 (PDT)
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
Subject: [PATCH -tip v3] x86/percpu: Introduce const-qualified const_pcpu_hot
Date:   Mon, 23 Oct 2023 16:30:43 +0200
Message-ID: <20231023143100.4014-1-ubizjak@gmail.com>
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
v2: Export const_pcpu_hot symbol.
---
v3: Rename const_pcpu_hot to const__pcpu_hot.
    Return const__pcpu_hot.top_of_stack from current_top_of_stack().
---
 arch/x86/include/asm/current.h   | 7 +++++++
 arch/x86/include/asm/percpu.h    | 6 +++---
 arch/x86/include/asm/processor.h | 3 +++
 arch/x86/kernel/cpu/common.c     | 1 +
 arch/x86/kernel/vmlinux.lds.S    | 1 +
 include/linux/compiler.h         | 2 +-
 6 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index a1168e7b69e5..6d8384f6d62d 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -36,8 +36,15 @@ static_assert(sizeof(struct pcpu_hot) == 64);
 
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
+/* const-qualified alias to pcpu_hot, aliased by linker. */
+DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+			const__pcpu_hot);
+
 static __always_inline struct task_struct *get_current(void)
 {
+	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+		return const__pcpu_hot.current_task;
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
index ae81a7191c1c..dd10f35f2af6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -533,6 +533,9 @@ static __always_inline unsigned long current_top_of_stack(void)
 	 *  and around vm86 mode and sp0 on x86_64 is special because of the
 	 *  entry trampoline.
 	 */
+	if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
+		return const__pcpu_hot.top_of_stack;
+
 	return this_cpu_read_stable(pcpu_hot.top_of_stack);
 }
 
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b14fc8c1c953..d24e92ad3283 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2049,6 +2049,7 @@ DEFINE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot) = {
 	.top_of_stack	= TOP_OF_INIT_STACK,
 };
 EXPORT_PER_CPU_SYMBOL(pcpu_hot);
+EXPORT_PER_CPU_SYMBOL(const__pcpu_hot);
 
 #ifdef CONFIG_X86_64
 DEFINE_PER_CPU_FIRST(struct fixed_percpu_data,
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 54a5596adaa6..4afbadbf0ab4 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -46,6 +46,7 @@ ENTRY(phys_startup_64)
 #endif
 
 jiffies = jiffies_64;
+const__pcpu_hot = pcpu_hot;
 
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

