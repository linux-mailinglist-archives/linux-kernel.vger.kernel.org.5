Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E67FEB43
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjK3I7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3I7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:59:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4357BB9;
        Thu, 30 Nov 2023 00:59:47 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:59:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701334785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0LR4zPKXvm7NvzMxgz4J/hjCIAaXCpTlSh1BXJxmOgQ=;
        b=T0yNg63kaIh0ySWe9LTnOSW7y0UMEYCrWOuMoUUI8WEXX2Wlk3NagQ99uoGvpt/291Rqq5
        yfpU0W3d9cmdun3ZyS+J+zjZ8ItQTUFpNnCBZzmBC71LpeyWV60AaBpjSNke0V3krDjDgI
        4v7LaJhJNAaghxP4+1olADtVnmeczaRV/2fqfH28xwEG/RcRWL8eEB2oEXEz93oy2D48Cc
        LsaSj2yJdjqDmsojsgXiog7kYRvfYe9dBcwoY8UM4GfWmEmBcVV1TDB1p/7oCYGW20QZVn
        aTfy7Lds82CPRn1Vp9thqjWgUIHTgN6Mu5SEdoul6szbW1KqeUCtZtpvmQJxsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701334785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0LR4zPKXvm7NvzMxgz4J/hjCIAaXCpTlSh1BXJxmOgQ=;
        b=tw3Z+1VdzkNrS26RMGVO4eBqvdje24+5eodyUIR8Yxf90AjmHUCbrnmkvnKIfr3uogVn1y
        wwF3+qaUZBRb45Aw==
From:   "tip-bot2 for Jun'ichi Nomura" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Ignore NMIs during very early boot
Cc:     "Jun'ichi Nomura" <junichi.nomura@nec.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170133478498.398.5261666675868615202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     78a509fba9c9b1fcb77f95b7c6be30da3d24823a
Gitweb:        https://git.kernel.org/tip/78a509fba9c9b1fcb77f95b7c6be30da3d24823a
Author:        Jun'ichi Nomura <junichi.nomura@nec.com>
AuthorDate:    Wed, 29 Nov 2023 15:44:49 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 09:55:40 +01:00

x86/boot: Ignore NMIs during very early boot

When there are two racing NMIs on x86, the first NMI invokes NMI handler and
the 2nd NMI is latched until IRET is executed.

If panic on NMI and panic kexec are enabled, the first NMI triggers
panic and starts booting the next kernel via kexec. Note that the 2nd
NMI is still latched. During the early boot of the next kernel, once
an IRET is executed as a result of a page fault, then the 2nd NMI is
unlatched and invokes the NMI handler.

However, NMI handler is not set up at the early stage of boot, which
results in a boot failure.

Avoid such problems by setting up a NOP handler for early NMIs.

[ mingo: Refined the changelog. ]

Signed-off-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Derek Barbosa <debarbos@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/boot/compressed/ident_map_64.c    | 5 +++++
 arch/x86/boot/compressed/idt_64.c          | 1 +
 arch/x86/boot/compressed/idt_handlers_64.S | 1 +
 arch/x86/boot/compressed/misc.h            | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 473ba59..d040080 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -386,3 +386,8 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 	 */
 	kernel_add_identity_map(address, end);
 }
+
+void do_boot_nmi_trap(struct pt_regs *regs, unsigned long error_code)
+{
+	/* Empty handler to ignore NMI during early boot */
+}
diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 3cdf94b..d100284 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -61,6 +61,7 @@ void load_stage2_idt(void)
 	boot_idt_desc.address = (unsigned long)boot_idt;
 
 	set_idt_entry(X86_TRAP_PF, boot_page_fault);
+	set_idt_entry(X86_TRAP_NMI, boot_nmi_trap);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	/*
diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
index 22890e1..4d03c85 100644
--- a/arch/x86/boot/compressed/idt_handlers_64.S
+++ b/arch/x86/boot/compressed/idt_handlers_64.S
@@ -70,6 +70,7 @@ SYM_FUNC_END(\name)
 	.code64
 
 EXCEPTION_HANDLER	boot_page_fault do_boot_page_fault error_code=1
+EXCEPTION_HANDLER	boot_nmi_trap do_boot_nmi_trap error_code=0
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 EXCEPTION_HANDLER	boot_stage1_vc do_vc_no_ghcb		error_code=1
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index c0d502b..bc2f0f1 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -196,6 +196,7 @@ static inline void cleanup_exception_handling(void) { }
 
 /* IDT Entry Points */
 void boot_page_fault(void);
+void boot_nmi_trap(void);
 void boot_stage1_vc(void);
 void boot_stage2_vc(void);
 
