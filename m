Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308B17BA3C9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbjJEP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjJEP4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFEC8A6D;
        Thu,  5 Oct 2023 01:28:38 -0700 (PDT)
Date:   Thu, 05 Oct 2023 08:28:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696494516;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqgY7Cz8sg3wxaii9XadAw8CeZ04T8Ph7HiN4dY22Sc=;
        b=XAjKeV6tDLJ59AHB4T8CD6+1E1F3Se4Ba07FxCNMiJfGK95ESCYelyeFtcC3cNHpEDwmeM
        9dpCtpPt+Oeb0U4u0hKeAIi404yWh7/YrqSFiNP9LyzTUj1H/wo+jmq8R6eMC7Lnbjj48q
        tgz7tEVmEyhCepl+WQbh+GwNYgabwDMISn5slieWpsgM3TSAPblsNIVOwV5Jw30MvNaUu9
        3gxC2RcM10pZ5ErugS7erUG1SW9Xk6RZsphsKWRjL0/NBg5zbdiyLcINjkTs2ycOlYJ0lY
        ivEsVF2JHH1jVE2op6+gNeXUc8j3k1+d33tkuStJ5r9CK3qvmJ95Jo8ifPEqbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696494516;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqgY7Cz8sg3wxaii9XadAw8CeZ04T8Ph7HiN4dY22Sc=;
        b=0v/8kvq47hvjFaXoefnPNe1u0rFf/26x2TAJuo42Ix5DSBqVRK7woB2cZe0JCAzpof0a9Z
        uOY9lhQ4LyoT1EAQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Convert do_fast_syscall_32() to bool
 return type
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230721161018.50214-5-brgerst@gmail.com>
References: <20230721161018.50214-5-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <169649451540.3135.8517965195722956922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     0d3109ad2e6125add5b3c88e8de3fb7bfd4e8c49
Gitweb:        https://git.kernel.org/tip/0d3109ad2e6125add5b3c88e8de3fb7bfd4e8c49
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 21 Jul 2023 12:10:15 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 05 Oct 2023 10:06:42 +02:00

x86/entry/32: Convert do_fast_syscall_32() to bool return type

Doesn't have to be 'long' - this simplifies the code a bit.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230721161018.50214-5-brgerst@gmail.com
---
 arch/x86/entry/common.c          | 10 +++++-----
 arch/x86/entry/entry_32.S        |  2 +-
 arch/x86/entry/entry_64_compat.S |  2 +-
 arch/x86/include/asm/syscall.h   |  4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 328990d..f1f3bf1 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -193,8 +193,8 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	return true;
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 {
 	/*
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
@@ -212,7 +212,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 
 	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
 	if (!__do_fast_syscall_32(regs))
-		return 0;
+		return false;
 
 #ifdef CONFIG_X86_64
 	/*
@@ -245,8 +245,8 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 #endif
 }
 
-/* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
-__visible noinstr long do_SYSENTER_32(struct pt_regs *regs)
+/* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
+__visible noinstr bool do_SYSENTER_32(struct pt_regs *regs)
 {
 	/* SYSENTER loses RSP, but the vDSO saved it in RBP. */
 	regs->sp = regs->bp;
diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 6e6af42..c73047b 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -837,7 +837,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 
 	movl	%esp, %eax
 	call	do_SYSENTER_32
-	testl	%eax, %eax
+	testb	%al, %al
 	jz	.Lsyscall_32_done
 
 	STACKLEAK_ERASE
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index b162723..27c05d0 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -212,7 +212,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_after_hwframe, SYM_L_GLOBAL)
 
 sysret32_from_system_call:
 	/* XEN PV guests always use IRET path */
-	ALTERNATIVE "testl %eax, %eax; jz swapgs_restore_regs_and_return_to_usermode", \
+	ALTERNATIVE "testb %al, %al; jz swapgs_restore_regs_and_return_to_usermode", \
 		    "jmp swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV
 
 	/*
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 4fb36fb..c7e25c9 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -131,7 +131,7 @@ void do_syscall_64(struct pt_regs *regs, int nr);
 #endif	/* CONFIG_X86_32 */
 
 void do_int80_syscall_32(struct pt_regs *regs);
-long do_fast_syscall_32(struct pt_regs *regs);
-long do_SYSENTER_32(struct pt_regs *regs);
+bool do_fast_syscall_32(struct pt_regs *regs);
+bool do_SYSENTER_32(struct pt_regs *regs);
 
 #endif	/* _ASM_X86_SYSCALL_H */
