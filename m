Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E54F75A236
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjGSWrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGSWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7031FFD;
        Wed, 19 Jul 2023 15:47:29 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=THIN99sAZ3pgPyyFWlJH1BTbNkPM5AMsmBf1UL7g7qY=;
        b=1VXzjW1v1BysL4h0CbIZ7RYRahuJSCtY4BEQbIdekpLv5XbsLJfy6lPnTorzpV0Ns5gZtF
        DSWfEtiYptEcHPlqSjO+IrALaUAR50Sl9hj9aYl1YgVgY1iIeLSkT38eex/0b8cvkLLs11
        1QXFmvwbJHc+Epn4Dvoiq1b8HbiINl/ZP+DU+PvuMJnC0gaeqsYYa/oc4OpXldsll6Ko9r
        BerjPYI+YBDLDdCdJYD36CmadnysizL1GdwztiwxrWhoJmV5xqzV7f/CfQEGHWzJ/kpIMs
        GB37WewCBgmJTqqFNxK8Aj6FH3mYQvt6uirzz2Zvm75b+oScQ/uGVaqjVoHsgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=THIN99sAZ3pgPyyFWlJH1BTbNkPM5AMsmBf1UL7g7qY=;
        b=C84wf/ofNPHIL+U5ckaiqFslfBHxWCWoSF3oS/qPoKUn+F8uG3cYak6uX3k7QCnyQMZvri
        nzdC1rPe76fkCHCg==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86: Add PTRACE interface for shadow stack
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
Message-ID: <168980684667.28540.1044032975497428932.tip-bot2@tip-bot2>
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

Commit-ID:     62fd552865eeda5acb80dcf456b11951be5ffa30
Gitweb:        https://git.kernel.org/tip/62fd552865eeda5acb80dcf456b11951be5ffa30
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:06 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:14:15 -07:00

x86: Add PTRACE interface for shadow stack

Some applications (like GDB) would like to tweak shadow stack state via
ptrace. This allows for existing functionality to continue to work for
seized shadow stack applications. Provide a regset interface for
manipulating the shadow stack pointer (SSP).

There is already ptrace functionality for accessing xstate, but this
does not include supervisor xfeatures. So there is not a completely
clear place for where to put the shadow stack state. Adding it to the
user xfeatures regset would complicate that code, as it currently shares
logic with signals which should not have supervisor features.

Don't add a general supervisor xfeature regset like the user one,
because it is better to maintain flexibility for other supervisor
xfeatures to define their own interface. For example, an xfeature may
decide not to expose all of it's state to userspace, as is actually the
case for  shadow stack ptrace functionality. A lot of enum values remain
to be used, so just put it in dedicated shadow stack regset.

The only downside to not having a generic supervisor xfeature regset,
is that apps need to be enlightened of any new supervisor xfeature
exposed this way (i.e. they can't try to have generic save/restore
logic). But maybe that is a good thing, because they have to think
through each new xfeature instead of encountering issues when a new
supervisor xfeature was added.

By adding a shadow stack regset, it also has the effect of including the
shadow stack state in a core dump, which could be useful for debugging.

The shadow stack specific xstate includes the SSP, and the shadow stack
and WRSS enablement status. Enabling shadow stack or WRSS in the kernel
involves more than just flipping the bit. The kernel is made aware that
it has to do extra things when cloning or handling signals. That logic
is triggered off of separate feature enablement state kept in the task
struct. So the flipping on HW shadow stack enforcement without notifying
the kernel to change its behavior would severely limit what an application
could do without crashing, and the results would depend on kernel
internal implementation details. There is also no known use for controlling
this state via ptrace today. So only expose the SSP, which is something
that userspace already has indirect control over.

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
Link: https://lore.kernel.org/all/20230613001108.3040476-41-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/fpu/regset.h |  7 +--
 arch/x86/kernel/fpu/regset.c      | 81 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/ptrace.c          | 12 ++++-
 include/uapi/linux/elf.h          |  2 +-
 4 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/regset.h b/arch/x86/include/asm/fpu/regset.h
index 4f928d6..697b77e 100644
--- a/arch/x86/include/asm/fpu/regset.h
+++ b/arch/x86/include/asm/fpu/regset.h
@@ -7,11 +7,12 @@
 
 #include <linux/regset.h>
 
-extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active;
+extern user_regset_active_fn regset_fpregs_active, regset_xregset_fpregs_active,
+				ssp_active;
 extern user_regset_get2_fn fpregs_get, xfpregs_get, fpregs_soft_get,
-				 xstateregs_get;
+				 xstateregs_get, ssp_get;
 extern user_regset_set_fn fpregs_set, xfpregs_set, fpregs_soft_set,
-				 xstateregs_set;
+				 xstateregs_set, ssp_set;
 
 /*
  * xstateregs_active == regset_fpregs_active. Please refer to the comment
diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index 6d056b6..6bc1eb2 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -8,6 +8,7 @@
 #include <asm/fpu/api.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/prctl.h>
 
 #include "context.h"
 #include "internal.h"
@@ -174,6 +175,86 @@ out:
 	return ret;
 }
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+int ssp_active(struct task_struct *target, const struct user_regset *regset)
+{
+	if (target->thread.features & ARCH_SHSTK_SHSTK)
+		return regset->n;
+
+	return 0;
+}
+
+int ssp_get(struct task_struct *target, const struct user_regset *regset,
+	    struct membuf to)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct cet_user_state *cetregs;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		return -ENODEV;
+
+	sync_fpstate(fpu);
+	cetregs = get_xsave_addr(&fpu->fpstate->regs.xsave, XFEATURE_CET_USER);
+	if (WARN_ON(!cetregs)) {
+		/*
+		 * This shouldn't ever be NULL because shadow stack was
+		 * verified to be enabled above. This means
+		 * MSR_IA32_U_CET.CET_SHSTK_EN should be 1 and so
+		 * XFEATURE_CET_USER should not be in the init state.
+		 */
+		return -ENODEV;
+	}
+
+	return membuf_write(&to, (unsigned long *)&cetregs->user_ssp,
+			    sizeof(cetregs->user_ssp));
+}
+
+int ssp_set(struct task_struct *target, const struct user_regset *regset,
+	    unsigned int pos, unsigned int count,
+	    const void *kbuf, const void __user *ubuf)
+{
+	struct fpu *fpu = &target->thread.fpu;
+	struct xregs_state *xsave = &fpu->fpstate->regs.xsave;
+	struct cet_user_state *cetregs;
+	unsigned long user_ssp;
+	int r;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !ssp_active(target, regset))
+		return -ENODEV;
+
+	if (pos != 0 || count != sizeof(user_ssp))
+		return -EINVAL;
+
+	r = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &user_ssp, 0, -1);
+	if (r)
+		return r;
+
+	/*
+	 * Some kernel instructions (IRET, etc) can cause exceptions in the case
+	 * of disallowed CET register values. Just prevent invalid values.
+	 */
+	if (user_ssp >= TASK_SIZE_MAX || !IS_ALIGNED(user_ssp, 8))
+		return -EINVAL;
+
+	fpu_force_restore(fpu);
+
+	cetregs = get_xsave_addr(xsave, XFEATURE_CET_USER);
+	if (WARN_ON(!cetregs)) {
+		/*
+		 * This shouldn't ever be NULL because shadow stack was
+		 * verified to be enabled above. This means
+		 * MSR_IA32_U_CET.CET_SHSTK_EN should be 1 and so
+		 * XFEATURE_CET_USER should not be in the init state.
+		 */
+		return -ENODEV;
+	}
+
+	cetregs->user_ssp = user_ssp;
+	return 0;
+}
+#endif /* CONFIG_X86_USER_SHADOW_STACK */
+
 #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 
 /*
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index dfaa270..095f04b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -58,6 +58,7 @@ enum x86_regset_64 {
 	REGSET64_FP,
 	REGSET64_IOPERM,
 	REGSET64_XSTATE,
+	REGSET64_SSP,
 };
 
 #define REGSET_GENERAL \
@@ -1267,6 +1268,17 @@ static struct user_regset x86_64_regsets[] __ro_after_init = {
 		.active		= ioperm_active,
 		.regset_get	= ioperm_get
 	},
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+	[REGSET64_SSP] = {
+		.core_note_type	= NT_X86_SHSTK,
+		.n		= 1,
+		.size		= sizeof(u64),
+		.align		= sizeof(u64),
+		.active		= ssp_active,
+		.regset_get	= ssp_get,
+		.set		= ssp_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_x86_64_view = {
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 0c8cf35..786d517 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -409,6 +409,8 @@ typedef struct elf64_shdr {
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+/* Old binutils treats 0x203 as a CET state */
+#define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
