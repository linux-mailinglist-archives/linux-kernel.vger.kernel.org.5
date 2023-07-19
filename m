Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFAC75A24E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjGSWsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGSWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B51FFE;
        Wed, 19 Jul 2023 15:47:33 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AgvVg9td36+8lVbRCIaCD33d/Bj8oZTGdH74FsBEPLU=;
        b=I/F/aUMEib6TulEYVyIu2oz4scA6VNFL6wHVY66VpzzJG50Rd0q22QVISU547Nv8NqnSzX
        oMTLcIM23qaAUFl4/27nWMT8spnploJqjIWusagWpWCADBKC+kepvMhWU0JuRWon1zLhq5
        lqNIpmF2KGBk0Fe8geMcDQ60Ll7Z2eG6iNyZm8NWAGQjcvzP5AEiRxeDTgwbrYTgXmzmCI
        psTXrlJn06ij1HPfn+/Qsh3o+BH8dVqGVtWe3AQqanv4AGHYvIw33f5kFirrguRTMTC0sN
        1X+93rVWMIUZXKMrUw39G9Q59I1zRNoQlo1K9H7iWuXcDosRU6Vn+Lug20v+zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AgvVg9td36+8lVbRCIaCD33d/Bj8oZTGdH74FsBEPLU=;
        b=b0srShmqYuvis8KHVxAN+tMN1j1xjmvcwhZ167WFzxX5ael6z+gM09vYGMu8ClHfB1QI+h
        jgAjiMLLdI4QEuCw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Handle signals for shadow stack
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980685057.28540.17644050943226146562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     cb13fcfb6e7ef6d33351286f28e5fb989d4d56df
Gitweb:        https://git.kernel.org/tip/cb13fcfb6e7ef6d33351286f28e5fb989d4d56df
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:57 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:12:50 -07:00

x86/shstk: Handle signals for shadow stack

When a signal is handled, the context is pushed to the stack before
handling it. For shadow stacks, since the shadow stack only tracks return
addresses, there isn't any state that needs to be pushed. However, there
are still a few things that need to be done. These things are visible to
userspace and which will be kernel ABI for shadow stacks.

One is to make sure the restorer address is written to shadow stack, since
the signal handler (if not changing ucontext) returns to the restorer, and
the restorer calls sigreturn. So add the restorer on the shadow stack
before handling the signal, so there is not a conflict when the signal
handler returns to the restorer.

The other thing to do is to place some type of checkable token on the
thread's shadow stack before handling the signal and check it during
sigreturn. This is an extra layer of protection to hamper attackers
calling sigreturn manually as in SROP-like attacks.

For this token the shadow stack data format defined earlier can be used.
Have the data pushed be the previous SSP. In the future the sigreturn
might want to return back to a different stack. Storing the SSP (instead
of a restore offset or something) allows for future functionality that
may want to restore to a different stack.

So, when handling a signal push
 - the SSP pointing in the shadow stack data format
 - the restorer address below the restore token.

In sigreturn, verify SSP is stored in the data format and pop the shadow
stack.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-32-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/shstk.h |  5 ++-
 arch/x86/kernel/shstk.c      | 95 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/signal.c     |  1 +-
 arch/x86/kernel/signal_64.c  |  6 ++-
 4 files changed, 107 insertions(+)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index d4a5c7b..ecb23a8 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct ksignal;
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 struct thread_shstk {
@@ -18,6 +19,8 @@ void reset_thread_features(void);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 				       unsigned long stack_size);
 void shstk_free(struct task_struct *p);
+int setup_signal_shadow_stack(struct ksignal *ksig);
+int restore_signal_shadow_stack(void);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -26,6 +29,8 @@ static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
 						     unsigned long clone_flags,
 						     unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
+static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index e22928c..f02e8ea 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -232,6 +232,101 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
 	return 0;
 }
 
+static int shstk_push_sigframe(unsigned long *ssp)
+{
+	unsigned long target_ssp = *ssp;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(target_ssp, 8))
+		return -EINVAL;
+
+	*ssp -= SS_FRAME_SIZE;
+	if (put_shstk_data((void *__user)*ssp, target_ssp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int shstk_pop_sigframe(unsigned long *ssp)
+{
+	unsigned long token_addr;
+	int err;
+
+	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
+	if (unlikely(err))
+		return err;
+
+	/* Restore SSP aligned? */
+	if (unlikely(!IS_ALIGNED(token_addr, 8)))
+		return -EINVAL;
+
+	/* SSP in userspace? */
+	if (unlikely(token_addr >= TASK_SIZE_MAX))
+		return -EINVAL;
+
+	*ssp = token_addr;
+
+	return 0;
+}
+
+int setup_signal_shadow_stack(struct ksignal *ksig)
+{
+	void __user *restorer = ksig->ka.sa.sa_restorer;
+	unsigned long ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	if (!restorer)
+		return -EINVAL;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
+		return -EINVAL;
+
+	err = shstk_push_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	/* Push restorer address */
+	ssp -= SS_FRAME_SIZE;
+	err = write_user_shstk_64((u64 __user *)ssp, (u64)restorer);
+	if (unlikely(err))
+		return -EFAULT;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return 0;
+}
+
+int restore_signal_shadow_stack(void)
+{
+	unsigned long ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
+		return -EINVAL;
+
+	err = shstk_pop_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index cfeec3e..65fe209 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -40,6 +40,7 @@
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/shstk.h>
 
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 0e808c7..cacf2ed 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -175,6 +175,9 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -260,6 +263,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
