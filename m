Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691BD76D01A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjHBOdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 10:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHBOdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 10:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788719AA;
        Wed,  2 Aug 2023 07:33:18 -0700 (PDT)
Date:   Wed, 02 Aug 2023 14:33:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690986796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4djLxpRxCI6vFN9lbiqantN6FRdXb1eJIUZGIg6LFc=;
        b=WtUXvXrIWLS/fRB7sccQgzkZr1lXLu+g5WQ4eoi1JijQXmFNKou/+o9eZwvKxbgNm2RzD8
        Lcli2d9je7GeC8by5KO4P3iba6H0+I2ArchXXWG0WAEARjIVBcdsbMpAzsmp7YVyjauORN
        vKWLkTnn8Xat0JyZ8PEcxQbvCa7O2SGKX4kfmxurQHKIF8aOj0CVJkcQ6uCiCGLJ/yeeBK
        mSgIUCw7zZA4hcFAQWUITyIeYtQWz9e6QM2Qa/Tyz5Ym/U2g8CWB8J3H7UB2YApVrZp0UL
        fqwWptRbOIrthJBsCEzNCDCHXu2KHflTb+Qw1oszT2EU1Tmp3spmR7XgOXfbhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690986796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i4djLxpRxCI6vFN9lbiqantN6FRdXb1eJIUZGIg6LFc=;
        b=5sRSeF4pJ2ijlP3JwG4X1ujzT4ce94b7LbL7QWSkH+Kz9gedUYfnoSeiIwq8elRcDWtZwB
        t/8uO8h02OtJccDg==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Prohibit probing on compiler generated
 CFI checking code
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <168904025785.116016.12766408611437534723.stgit@devnote2>
References: <168904025785.116016.12766408611437534723.stgit@devnote2>
MIME-Version: 1.0
Message-ID: <169098679641.28540.17338602832715427082.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b65413768abd27a55af74945aec58127a52b30a8
Gitweb:        https://git.kernel.org/tip/b65413768abd27a55af74945aec58127a52=
b30a8
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Tue, 11 Jul 2023 10:50:58 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 02 Aug 2023 16:27:07 +02:00

x86/kprobes: Prohibit probing on compiler generated CFI checking code

Prohibit probing on the compiler generated CFI typeid checking code
because it is used for decoding typeid when CFI error happens.

The compiler generates the following instruction sequence for indirect
call checks on x86;

 =C2=A0 movl    -<id>, %r10d       ; 6 bytes
   addl    -4(%reg), %r10d    ; 4 bytes
   je      .Ltmp1             ; 2 bytes
   ud2                        ; <- regs->ip

And handle_cfi_failure() decodes these instructions (movl and addl)
for the typeid and the target address. Thus if we put a kprobe on
those instructions, the decode will fail and report a wrong typeid
and target address.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/168904025785.116016.12766408611437534723.stgi=
t@devnote2
---
 arch/x86/kernel/kprobes/core.c | 34 +++++++++++++++++++++++++++++++++-
 include/linux/cfi.h            |  4 +++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index f7f6042..e8babeb 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -45,6 +45,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pgtable.h>
 #include <linux/set_memory.h>
+#include <linux/cfi.h>
=20
 #include <asm/text-patching.h>
 #include <asm/cacheflush.h>
@@ -293,7 +294,40 @@ static int can_probe(unsigned long paddr)
 #endif
 		addr +=3D insn.length;
 	}
+	if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+		/*
+		 * The compiler generates the following instruction sequence
+		 * for indirect call checks and cfi.c decodes this;
+		 *
+		 *=C2=A0  movl    -<id>, %r10d       ; 6 bytes
+		 *   addl    -4(%reg), %r10d    ; 4 bytes
+		 *   je      .Ltmp1             ; 2 bytes
+		 *   ud2                        ; <- regs->ip
+		 *   .Ltmp1:
+		 *
+		 * Also, these movl and addl are used for showing expected
+		 * type. So those must not be touched.
+		 */
+		__addr =3D recover_probed_instruction(buf, addr);
+		if (!__addr)
+			return 0;
+
+		if (insn_decode_kernel(&insn, (void *)__addr) < 0)
+			return 0;
+
+		if (insn.opcode.value =3D=3D 0xBA)
+			offset =3D 12;
+		else if (insn.opcode.value =3D=3D 0x3)
+			offset =3D 6;
+		else
+			goto out;
+
+		/* This movl/addl is used for decoding CFI. */
+		if (is_cfi_trap(addr + offset))
+			return 0;
+	}
=20
+out:
 	return (addr =3D=3D paddr);
 }
=20
diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 5e134f4..3552ec8 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -19,11 +19,13 @@ static inline enum bug_trap_type report_cfi_failure_noadd=
r(struct pt_regs *regs,
 {
 	return report_cfi_failure(regs, addr, NULL, 0);
 }
+#endif /* CONFIG_CFI_CLANG */
=20
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
 bool is_cfi_trap(unsigned long addr);
+#else
+static inline bool is_cfi_trap(unsigned long addr) { return false; }
 #endif
-#endif /* CONFIG_CFI_CLANG */
=20
 #ifdef CONFIG_MODULES
 #ifdef CONFIG_ARCH_USES_CFI_TRAPS
