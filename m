Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A77D13E6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377837AbjJTQUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:20:17 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89958A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:20:15 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso2219929a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697818814; x=1698423614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djUEh+V9HtHiOjNuky1TdbS1mFyQzEaDgKE3FsLY6IY=;
        b=DlZaxkEWg9jvpB2t6HAReKvsB38lpHgXkDvI82tn13Eag8rxurI/nxVV1fIFJK9yDf
         mV2fvrW2IR9gqaoih9JTnVdpVgdFZsWjNbY0yxK7wd9n6bwYwCpg+bNM0PAGk8l0TFSV
         Amkgl0A1QvzEHh1WvHEvi4iik+R5Kb1vuAPaI3NAZzZSjEaBYzUlxmfbmsEcSdgmvbsf
         Si/f3w0cQibSpCSl9eyfBxUh9r+1kz4mWisCSC3W2TpL10ih5iPQps87j6BgVDQuX9Ot
         PncABcMBtVvFIZ/sfXZfqdBEJirakI25SkZqIG9XjIehAUsFrcleDhmOE496z4PdNVId
         tVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818814; x=1698423614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=djUEh+V9HtHiOjNuky1TdbS1mFyQzEaDgKE3FsLY6IY=;
        b=itmOkqm7pIqbbF5XvfaHJoVmo/Rwya9p/8D+QpB1lQXWqwFJVVzEF9tt7/IYw+5bqC
         McvZPwG+DWwJ/DdTwOdi118ohsCIlOUm3K+i/c6thMKPcvOu9DfRBcM/WJa1JznE7POw
         1M4UcIGerLrOKnlO648eqp5IPILiGbCNH0Ktk3vq+ki4fi/a9Gz964Ja/JQvYub87WwZ
         UXq2ZQldlNupMUbI+2fxdPvDL2dpQzS39OZyTxOa8tkvowEGwcund8EkVyhQLAffIltK
         ItcftLlz1Nf0vQnwI4Iq5aKZe24Sqb7Ia2Z4UpPmOgI747ACUgqDphIuxPBl7cqHjscA
         kdFQ==
X-Gm-Message-State: AOJu0YyXoMQWzbj0OUpNFjOdasC2NGtxXfcsv5kOIFUAWCIbIbutICox
        kuVzOWvFTpPTnVm1RnmLSEw=
X-Google-Smtp-Source: AGHT+IEj3e2bk7Bg/YiorS/mvcBZuzF6TnwBpeYilqbXp9IM33eD702o2G8HA4UQ73AZJgHvDbR/iA==
X-Received: by 2002:a05:6402:40c5:b0:52f:86a1:3861 with SMTP id z5-20020a05640240c500b0052f86a13861mr2186184edb.7.1697818813673;
        Fri, 20 Oct 2023 09:20:13 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id e26-20020a50d4da000000b0053f29ba5adesm1755874edj.50.2023.10.20.09.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 09:20:13 -0700 (PDT)
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
Subject: [PATCH] x86/percpu: Introduce const-qualified const_pcpu_hot
Date:   Fri, 20 Oct 2023 18:19:20 +0200
Message-ID: <20231020162004.135244-1-ubizjak@gmail.com>
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
a -14.6% reduction.

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
 arch/x86/include/asm/current.h   | 7 +++++++
 arch/x86/include/asm/percpu.h    | 6 +++---
 arch/x86/include/asm/processor.h | 3 +++
 arch/x86/kernel/vmlinux.lds.S    | 1 +
 include/linux/compiler.h         | 2 +-
 5 files changed, 15 insertions(+), 4 deletions(-)

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

