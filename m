Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8807CE704
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjJRSml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJRSmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:42:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C29119
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:42:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9c3aec5f326so797533566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697654556; x=1698259356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxbQLc6yAVNBHcXmAP4XSHCZwfSgLzoyAYxaXVpXJKo=;
        b=RGD3LFqZZl7wBkr90Eiqv5ZazOZyGvvFObB7tXxBSHIfyi4Vh7RoxLtRoEn5UcQIsj
         SX+OxNh/gy9Un9itLTn7OcfISfkgxiIEXGIX2DeUjLoUOg/QouPMiSCheNyvM9fW4qk9
         FMjyDRUOFbs+cbDAUoqB73dPIG50e02DmwPxeg3Z8MTdSw9/OOcx2cQ/5GChmLdE/xcK
         en2brycg6ZmvhLZ5/D6uwbjWsuMQ1DxKbO3GP9EpxFG5owYAmEieEhkCQOo93cMpt76m
         hZj5lUahQvrFWNtNdchlCy6+QW9G4ZhVQYyfAm8SPVzXcXIPl8Abn6kaMRMTyJoGNcg4
         6jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697654556; x=1698259356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PxbQLc6yAVNBHcXmAP4XSHCZwfSgLzoyAYxaXVpXJKo=;
        b=bORXOIFM5oZvcfFpUrNeRBFeHv6ywiB71aU531Igoz75vZT8sqazN7Gazs2eB7w1j+
         FU1myV4CrlV/VBuACO/+2xNyVhQlIXHjnY6uj7uVSuuS+3mMolh2mEu36MWJE3jSdnZi
         BEkoGRzxIW7o9ND+kpp83i5SDCAocdskJPB81MpF9kaiZxkf8kx3QikjC1xS+PQEs8qF
         rxOpmnYjDwDyHO1uSh5XOw8UO/vjdQN1yUDF54KRyX5exZQeBzPVWXCgmZAo2WsYVC9p
         RGGrDJbudgXKGdrG/ol8VNA3lVmCYbHP16F2T16/nbx2BqgM3GmngjGWR3oZccP9pFQA
         P+Bg==
X-Gm-Message-State: AOJu0YxRJteKkHgelJMGhqIR0XAn2nc9z9GM54bqw236RBQgRZ0LNucB
        ZcVkBne5rbJJMC6id6b+0+o=
X-Google-Smtp-Source: AGHT+IFwYRhFfbuZXZo1Eb1Tat8DZ2dvgmPMvPNmSkV9EvIpJAzHABwCbt8uLa/mgRKW9qbL8k218g==
X-Received: by 2002:a17:906:6a19:b0:9ad:e3fd:d46c with SMTP id qw25-20020a1709066a1900b009ade3fdd46cmr5604941ejc.10.1697654555768;
        Wed, 18 Oct 2023 11:42:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id f17-20020a1709062c5100b009aa292a2df2sm2118213ejh.217.2023.10.18.11.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 11:42:35 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] x86: clean up fpu switching in the middle of task switching
Date:   Wed, 18 Oct 2023 20:41:58 +0200
Message-ID: <20231018184227.446318-1-ubizjak@gmail.com>
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

From: Linus Torvalds <torvalds@linux-foundation.org>

It happens to work, but it's very very wrong, because our 'current'
macro is magic that is supposedly loading a stable value.

It just happens to be not quite stable enough and the compilers
re-load the value enough for this code to work.  But it's wrong.

The whole

        struct fpu *prev_fpu = &prev->fpu;

thing in __switch_to() is pretty ugly. There's no reason why we
should look at that 'prev_fpu' pointer there, or pass it down.

And it only generates worse code, in how it loads 'current' when
__switch_to() has the right task pointers.

The attached patch not only cleans this up, it actually
generates better code too:

 (a) it removes one push/pop pair at entry/exit because there's one
less register used (no 'current')

 (b) it removes that pointless load of 'current' because it just uses
the right argument:

-       movq    %gs:pcpu_hot(%rip), %r12
-       testq   $16384, (%r12)
+       testq   $16384, (%rdi)

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/fpu/sched.h | 10 ++++++----
 arch/x86/kernel/process_32.c     |  7 +++----
 arch/x86/kernel/process_64.c     |  7 +++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
index ca6e5e5f16b2..c485f1944c5f 100644
--- a/arch/x86/include/asm/fpu/sched.h
+++ b/arch/x86/include/asm/fpu/sched.h
@@ -37,10 +37,12 @@ extern void fpu_flush_thread(void);
  * The FPU context is only stored/restored for a user task and
  * PF_KTHREAD is used to distinguish between kernel and user threads.
  */
-static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
+static inline void switch_fpu_prepare(struct task_struct *old, int cpu)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU) &&
-	    !(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
+		struct fpu *old_fpu = &old->thread.fpu;
+
 		save_fpregs_to_fpstate(old_fpu);
 		/*
 		 * The save operation preserved register state, so the
@@ -60,10 +62,10 @@ static inline void switch_fpu_prepare(struct fpu *old_fpu, int cpu)
  * Delay loading of the complete FPU state until the return to userland.
  * PKRU is handled separately.
  */
-static inline void switch_fpu_finish(void)
+static inline void switch_fpu_finish(struct task_struct *new)
 {
 	if (cpu_feature_enabled(X86_FEATURE_FPU))
-		set_thread_flag(TIF_NEED_FPU_LOAD);
+		set_tsk_thread_flag(new, TIF_NEED_FPU_LOAD);
 }
 
 #endif /* _ASM_X86_FPU_SCHED_H */
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 708c87b88cc1..0917c7f25720 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -156,13 +156,12 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev = &prev_p->thread,
 			     *next = &next_p->thread;
-	struct fpu *prev_fpu = &prev->fpu;
 	int cpu = smp_processor_id();
 
 	/* never put a printk in __switch_to... printk() calls wake_up*() indirectly */
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-		switch_fpu_prepare(prev_fpu, cpu);
+	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
+		switch_fpu_prepare(prev_p, cpu);
 
 	/*
 	 * Save away %gs. No need to save %fs, as it was saved on the
@@ -209,7 +208,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 
 	raw_cpu_write(pcpu_hot.current_task, next_p);
 
-	switch_fpu_finish();
+	switch_fpu_finish(next_p);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in(next_p);
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 33b268747bb7..1553e19904e0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -562,14 +562,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 {
 	struct thread_struct *prev = &prev_p->thread;
 	struct thread_struct *next = &next_p->thread;
-	struct fpu *prev_fpu = &prev->fpu;
 	int cpu = smp_processor_id();
 
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_ENTRY) &&
 		     this_cpu_read(pcpu_hot.hardirq_stack_inuse));
 
-	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
-		switch_fpu_prepare(prev_fpu, cpu);
+	if (!test_tsk_thread_flag(prev_p, TIF_NEED_FPU_LOAD))
+		switch_fpu_prepare(prev_p, cpu);
 
 	/* We must save %fs and %gs before load_TLS() because
 	 * %fs and %gs may be cleared by load_TLS().
@@ -623,7 +622,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	raw_cpu_write(pcpu_hot.current_task, next_p);
 	raw_cpu_write(pcpu_hot.top_of_stack, task_top_of_stack(next_p));
 
-	switch_fpu_finish();
+	switch_fpu_finish(next_p);
 
 	/* Reload sp0. */
 	update_task_stack(next_p);
-- 
2.41.0

