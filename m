Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE97C843D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJMLSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjJMLSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:18:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE3B7;
        Fri, 13 Oct 2023 04:18:29 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:18:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697195907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubTp/0jO7M8gTlbN18aXMtPlK8oLH70xqfq1ZuyfzV0=;
        b=pJfk1kwCXhmY/6CLtV4kbtgrs8nBymXpcmBimvVYVwoNgrYQyzJjEq0DGs4EnPdjBkSMRT
        3N64rBsd7kwUyygrhM0x1cbZbo6m2FivDYAwRkx4xyAwUHZxekTzs1TloKNTmit95ztfg9
        E0HVH88wibWqH3w41pL9UDA/WaggpQh0B4+x3pg40mHWW6lhUOgiiy/sjJ2nd2/bGww6wI
        mibgRAD+fWLVmlhPTSA7a9vHwaaWdFDI69vcQ5MvMWT46At8C7z24Dudre3UhKiKsyXMeQ
        gzoKw38CHUXOT6EP98Iy7eIW2wk+UusXIUI8mXqxv6olAOzVCdTsq8HI2dlEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697195907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubTp/0jO7M8gTlbN18aXMtPlK8oLH70xqfq1ZuyfzV0=;
        b=QXu+iRrSRdi8ennv6D94GeiGdaq5KC/H7eAK48l7ElfTM2HpFH+t9sCPugC7OLiHVb1Ylj
        RhVgNa7jI82/DqDg==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Clean up syscall fast exit tests
Cc:     Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231011224351.130935-4-brgerst@gmail.com>
References: <20231011224351.130935-4-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <169719590633.3135.1644131863421264861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     1a09a27153f91cd7676b2d4ca574577572a8c999
Gitweb:        https://git.kernel.org/tip/1a09a27153f91cd7676b2d4ca574577572a8c999
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Wed, 11 Oct 2023 18:43:51 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Oct 2023 13:05:28 +02:00

x86/entry/32: Clean up syscall fast exit tests

Merge compat and native code and clarify comments.

No change in functionality expected.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20231011224351.130935-4-brgerst@gmail.com
---
 arch/x86/entry/common.c | 48 ++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 4c7154d..d813160 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -255,34 +255,30 @@ __visible noinstr bool do_fast_syscall_32(struct pt_regs *regs)
 	if (!__do_fast_syscall_32(regs))
 		return false;
 
-#ifdef CONFIG_X86_64
 	/*
-	 * Opportunistic SYSRETL: if possible, try to return using SYSRETL.
-	 * SYSRETL is available on all 64-bit CPUs, so we don't need to
-	 * bother with SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
+	 * Check that the register state is valid for using SYSRETL/SYSEXIT
+	 * to exit to userspace.  Otherwise use the slower but fully capable
+	 * IRET exit path.
 	 */
-	return regs->cs == __USER32_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)) == 0;
-#else
-	/*
-	 * Opportunistic SYSEXIT: if possible, try to return using SYSEXIT.
-	 *
-	 * Unlike 64-bit opportunistic SYSRET, we can't check that CX == IP,
-	 * because the ECX fixup above will ensure that this is essentially
-	 * never the case.
-	 *
-	 * We don't allow syscalls at all from VM86 mode, but we still
-	 * need to check VM, because we might be returning from sys_vm86.
-	 */
-	return regs->cs == __USER_CS && regs->ss == __USER_DS &&
-		regs->ip == landing_pad &&
-		(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)) == 0;
-#endif
+
+	/* XEN PV guests always use the IRET path */
+	if (cpu_feature_enabled(X86_FEATURE_XENPV))
+		return false;
+
+	/* EIP must point to the VDSO landing pad */
+	if (unlikely(regs->ip != landing_pad))
+		return false;
+
+	/* CS and SS must match the values set in MSR_STAR */
+	if (unlikely(regs->cs != __USER32_CS || regs->ss != __USER_DS))
+		return false;
+
+	/* If the TF, RF, or VM flags are set, use IRET */
+	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF | X86_EFLAGS_VM)))
+		return false;
+
+	/* Use SYSRETL/SYSEXIT to exit to userspace */
+	return true;
 }
 
 /* Returns true to return using SYSEXIT/SYSRETL, or false to use IRET */
