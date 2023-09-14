Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604647A028E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 13:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbjINL1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 07:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjINL1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 07:27:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C496FCC7;
        Thu, 14 Sep 2023 04:27:04 -0700 (PDT)
Date:   Thu, 14 Sep 2023 11:27:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694690823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C2eIxHiduCk3JbLorX9Ji4Nx7NlYAdZ70IiuqCGjqY=;
        b=CEc+SNFo5GssH2ahZbc7JQM8ltbys7Q0AC2dx3xSkjLBc0jnSDZc1CHc34rA6V67SM0TPY
        UTsUQR36XrRpgrsgEjxFYYtd7YRS1GW5JpPaUpNzKhuW26ipWXR4KS1rnu4TOZ6iUWxSkr
        5YwnsAkHGV9Sjjwh/DEbvpoO049Aox8tsKW1DOFYw0evpIiV8KxSMwUF8QqIPa16UMtJKk
        qNAV/kvfYC2yjJmEGQWFu7E22fKtSxIrqE2X7y7sV7QPVMQhQk78DSPNDAdxCbgrnsDjn8
        9FgLKrzYrdKQ9UxYBjegmwrcsFeDCjnK+Ao/Lm+kRHfSVRFswbWf/1kgWMz9ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694690823;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/C2eIxHiduCk3JbLorX9Ji4Nx7NlYAdZ70IiuqCGjqY=;
        b=sfvGmLh/g1i6SrwMlEHAyiRU4bA4KQS74xX6H9Uj4qdOAo05PvXeYyjKY4cNUGUuhQRrQD
        Qhhe0uLWHdDvKHBA==
From:   "tip-bot2 for Nikolay Borisov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Make IA32 syscalls' availability depend
 on ia32_enabled()
Cc:     Nikolay Borisov <nik.borisov@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230623111409.3047467-6-nik.borisov@suse.com>
References: <20230623111409.3047467-6-nik.borisov@suse.com>
MIME-Version: 1.0
Message-ID: <169469082265.27769.12116895179692059890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     61382281e9054df523d3f9cfdba2faff88955f97
Gitweb:        https://git.kernel.org/tip/61382281e9054df523d3f9cfdba2faff88955f97
Author:        Nikolay Borisov <nik.borisov@suse.com>
AuthorDate:    Fri, 23 Jun 2023 14:14:08 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 13:19:53 +02:00

x86/entry: Make IA32 syscalls' availability depend on ia32_enabled()

Another major aspect of supporting running of 32bit processes is the
ability to access 32bit syscalls. Such syscalls can be invoked by
using the legacy int 0x80 handler and  sysenter/syscall instructions.

If IA32 emulation is disabled ensure that each of those 3 distinct
mechanisms are also disabled. For int 0x80 a #GP exception would be
generated since the respective descriptor is not going to be loaded at
all. Invoking sysenter will also result in a #GP since IA32_SYSENTER_CS
contains an invalid segment. Finally, syscall instruction cannot really
be disabled so it's configured to execute a minimal handler.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20230623111409.3047467-6-nik.borisov@suse.com

---
 arch/x86/include/asm/proto.h |  3 +++-
 arch/x86/kernel/cpu/common.c | 37 +++++++++++++++++------------------
 arch/x86/kernel/idt.c        |  7 +++++++-
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 12ef86b..4d84122 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -36,6 +36,9 @@ void entry_INT80_compat(void);
 #ifdef CONFIG_XEN_PV
 void xen_entry_INT80_compat(void);
 #endif
+#else /* !CONFIG_IA32_EMULATION */
+#define entry_SYSCALL_compat NULL
+#define entry_SYSENTER_compat NULL
 #endif
 
 void x86_configure_nx(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b3f8cba..afa755e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -62,6 +62,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/ia32.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
 #include <asm/sev.h>
@@ -2074,24 +2075,24 @@ void syscall_init(void)
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
-#ifdef CONFIG_IA32_EMULATION
-	wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
-	/*
-	 * This only works on Intel CPUs.
-	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
-	 * This does not cause SYSENTER to jump to the wrong location, because
-	 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
-	 */
-	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
-	wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
-		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
-	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
-#else
-	wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
-	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
-	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
-	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
-#endif
+	if (ia32_enabled()) {
+		wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
+		/*
+		 * This only works on Intel CPUs.
+		 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
+		 * This does not cause SYSENTER to jump to the wrong location, because
+		 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
+		 */
+		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
+		wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
+			    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
+		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
+	} else {
+		wrmsrl_cstar((unsigned long)entry_SYSCALL32_ignore);
+		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
+		wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
+		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
+	}
 
 	/*
 	 * Flags to clear on syscall; clear as much as possible
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index b786d48..8857abc 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -10,6 +10,7 @@
 #include <asm/proto.h>
 #include <asm/desc.h>
 #include <asm/hw_irq.h>
+#include <asm/ia32.h>
 #include <asm/idtentry.h>
 
 #define DPL0		0x0
@@ -116,6 +117,9 @@ static const __initconst struct idt_data def_idts[] = {
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
+};
+
+static const struct idt_data ia32_idt[] __initconst = {
 #if defined(CONFIG_IA32_EMULATION)
 	SYSG(IA32_SYSCALL_VECTOR,	entry_INT80_compat),
 #elif defined(CONFIG_X86_32)
@@ -225,6 +229,9 @@ void __init idt_setup_early_traps(void)
 void __init idt_setup_traps(void)
 {
 	idt_setup_from_table(idt_table, def_idts, ARRAY_SIZE(def_idts), true);
+
+	if (ia32_enabled())
+		idt_setup_from_table(idt_table, ia32_idt, ARRAY_SIZE(ia32_idt), true);
 }
 
 #ifdef CONFIG_X86_64
