Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0960A777A88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235676AbjHJOXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjHJOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:23:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B382704;
        Thu, 10 Aug 2023 07:23:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92C6965DC3;
        Thu, 10 Aug 2023 14:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87822C433C7;
        Thu, 10 Aug 2023 14:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677406;
        bh=cs9hAoMZsISt2PoCjIqaqsE5Y0qpeoj7NexdJjqc7FI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhFCHi3JfnnOM/wH/IUOXANZeACqMVIJZ1ytPw9oqirmgzUbc4ifzc3UZCYagrzFa
         ab1BvcU8okF47/4vwMqvZE5SZcJsgFQR1j3MeDVm2xwJkG9X3SnjwhfSt3QZ8F5Tmz
         WbTe91EB1rcFkUsKbPcVuSqsvK1JV67KuASRjv0aOxBQc/TX+0g5x8CYtAo/w9ZN0T
         xAA6+TqvJPn7tmPP1BasNe0rDYp2JDl17cAbUzvfKuyAk7KJBvEI1h9mu8/Kr1hehw
         4aa2owUC1brNn4/3U/VkfmM8Bkm2fdDLdQUnKxG3D1cch/NrLlHAsCUdn7G2Ox4pZ6
         z8Zf/Z+WsCXJA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 14/17] kprobes: unify kprobes_exceptions_nofify() prototypes
Date:   Thu, 10 Aug 2023 16:19:32 +0200
Message-Id: <20230810141947.1236730-15-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Most architectures that support kprobes declare this function in their
own asm/kprobes.h header and provide an override, but some are missing
the prototype, which causes a warning for the __weak stub implementation:

kernel/kprobes.c:1865:12: error: no previous prototype for 'kprobe_exceptions_notify' [-Werror=missing-prototypes]
 1865 | int __weak kprobe_exceptions_notify(struct notifier_block *self,

Move the prototype into linux/kprobes.h so it is visible to all
the definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/kprobes.h     | 3 ---
 arch/arm/include/asm/kprobes.h     | 2 --
 arch/arm64/include/asm/kprobes.h   | 2 --
 arch/ia64/include/asm/kprobes.h    | 2 --
 arch/mips/include/asm/kprobes.h    | 2 --
 arch/powerpc/include/asm/kprobes.h | 2 --
 arch/s390/include/asm/kprobes.h    | 2 --
 arch/sh/include/asm/kprobes.h      | 2 --
 arch/sparc/include/asm/kprobes.h   | 2 --
 arch/x86/include/asm/kprobes.h     | 2 --
 include/linux/kprobes.h            | 4 ++++
 11 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/arc/include/asm/kprobes.h b/arch/arc/include/asm/kprobes.h
index de1566e32cb89..68e8301c0df2c 100644
--- a/arch/arc/include/asm/kprobes.h
+++ b/arch/arc/include/asm/kprobes.h
@@ -32,9 +32,6 @@ struct kprobe;
 
 void arch_remove_kprobe(struct kprobe *p);
 
-int kprobe_exceptions_notify(struct notifier_block *self,
-			     unsigned long val, void *data);
-
 struct prev_kprobe {
 	struct kprobe *kp;
 	unsigned long status;
diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
index e26a278d301ab..5b8dbf1b0be49 100644
--- a/arch/arm/include/asm/kprobes.h
+++ b/arch/arm/include/asm/kprobes.h
@@ -40,8 +40,6 @@ struct kprobe_ctlblk {
 
 void arch_remove_kprobe(struct kprobe *);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
-int kprobe_exceptions_notify(struct notifier_block *self,
-			     unsigned long val, void *data);
 
 /* optinsn template addresses */
 extern __visible kprobe_opcode_t optprobe_template_entry[];
diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 05cd82eeca136..be7a3680dadff 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -37,8 +37,6 @@ struct kprobe_ctlblk {
 
 void arch_remove_kprobe(struct kprobe *);
 int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
-int kprobe_exceptions_notify(struct notifier_block *self,
-			     unsigned long val, void *data);
 void __kretprobe_trampoline(void);
 void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 
diff --git a/arch/ia64/include/asm/kprobes.h b/arch/ia64/include/asm/kprobes.h
index 9e956768946cc..56004f97df6d2 100644
--- a/arch/ia64/include/asm/kprobes.h
+++ b/arch/ia64/include/asm/kprobes.h
@@ -107,8 +107,6 @@ struct arch_specific_insn {
 };
 
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-				    unsigned long val, void *data);
 
 extern void arch_remove_kprobe(struct kprobe *p);
 
diff --git a/arch/mips/include/asm/kprobes.h b/arch/mips/include/asm/kprobes.h
index 68b1e5d458cfb..bc27d99c94363 100644
--- a/arch/mips/include/asm/kprobes.h
+++ b/arch/mips/include/asm/kprobes.h
@@ -71,8 +71,6 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
 
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-				    unsigned long val, void *data);
 
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_KPROBES_H */
diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index c8e4b4fd4e330..4525a9c68260d 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -84,8 +84,6 @@ struct arch_optimized_insn {
 	kprobe_opcode_t *insn;
 };
 
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-					unsigned long val, void *data);
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 extern int kprobe_handler(struct pt_regs *regs);
 extern int kprobe_post_handler(struct pt_regs *regs);
diff --git a/arch/s390/include/asm/kprobes.h b/arch/s390/include/asm/kprobes.h
index 83f732ca3af4d..3f87125dd9b0d 100644
--- a/arch/s390/include/asm/kprobes.h
+++ b/arch/s390/include/asm/kprobes.h
@@ -72,8 +72,6 @@ struct kprobe_ctlblk {
 void arch_remove_kprobe(struct kprobe *p);
 
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
-int kprobe_exceptions_notify(struct notifier_block *self,
-	unsigned long val, void *data);
 
 #define flush_insn_slot(p)	do { } while (0)
 
diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
index eeba83e0a7d29..65d4c3316a5bd 100644
--- a/arch/sh/include/asm/kprobes.h
+++ b/arch/sh/include/asm/kprobes.h
@@ -46,8 +46,6 @@ struct kprobe_ctlblk {
 };
 
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-				    unsigned long val, void *data);
 extern int kprobe_handle_illslot(unsigned long pc);
 #else
 
diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index 06c2bc767ef75..aec742cd898f2 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -47,8 +47,6 @@ struct kprobe_ctlblk {
 	struct prev_kprobe prev_kprobe;
 };
 
-int kprobe_exceptions_notify(struct notifier_block *self,
-			     unsigned long val, void *data);
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
 asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 				      struct pt_regs *regs);
diff --git a/arch/x86/include/asm/kprobes.h b/arch/x86/include/asm/kprobes.h
index a2e9317aad495..5939694dfb28d 100644
--- a/arch/x86/include/asm/kprobes.h
+++ b/arch/x86/include/asm/kprobes.h
@@ -113,8 +113,6 @@ struct kprobe_ctlblk {
 };
 
 extern int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
-extern int kprobe_exceptions_notify(struct notifier_block *self,
-				    unsigned long val, void *data);
 extern int kprobe_int3_handler(struct pt_regs *regs);
 
 #else
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 85a64cb95d755..987911cdc90a2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -450,6 +450,10 @@ int kprobe_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 
 int arch_kprobe_get_kallsym(unsigned int *symnum, unsigned long *value,
 			    char *type, char *sym);
+
+int kprobe_exceptions_notify(struct notifier_block *self,
+			     unsigned long val, void *data);
+
 #else /* !CONFIG_KPROBES: */
 
 static inline int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
-- 
2.39.2

