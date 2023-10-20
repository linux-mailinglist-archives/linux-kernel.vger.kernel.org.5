Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3597D0EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377232AbjJTLm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377274AbjJTLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:42:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF9E1BD8;
        Fri, 20 Oct 2023 04:39:01 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/r6TKfAIPF4DGJsQq1QWq5Z7B0tfCqdwYnDmLEgikdw=;
        b=Tp5Rah7f6feNE2r4Oj3mkhFPPjRsjoJdGkkt4V/0Dr92ZQMO3OdLRttMQU8z0o3XFAwE6+
        01zfnIH56+tpFzvFK1kp8gVVd7Ksw1Gr54n1JxBikQ848pg1JlUuslhKjhe9D13GM0bxKP
        avhfXLZ6qDHSo5P7XCZpNZoKqij/o3wWLdz8fE4HTAG+ZKdD4VZDhYAsTELciwxcmPmrG2
        r8dGAYQLK5aCa5EML5+6R598Pb6jzhuaEFncif2fH4+DXNIm/4qrEd/o3iLeYQQvw7Zu0p
        0lach3D1StsrbDdjSYMEA/9Lw23iSHbWNtPZV1clvbkoKMrD7Q86vE+S8KAaYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801886;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/r6TKfAIPF4DGJsQq1QWq5Z7B0tfCqdwYnDmLEgikdw=;
        b=KvxXJTJXy4FouC170ttL2MVUGbzZ0drlbwj1hlP7xYVw3LNFLV2+ZoJAIorT5wrXa0Am6n
        MwysuABAG2BytsBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/boot/32: Disable stackprotector and tracing
 for mk_early_pgtbl_32()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115902.156063939@linutronix.de>
References: <20231002115902.156063939@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780188598.3135.13135735219422593841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     242db7589460ca94e28c51ffbddd621756f97e11
Gitweb:        https://git.kernel.org/tip/242db7589460ca94e28c51ffbddd621756f97e11
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 13:59:36 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 18 Oct 2023 11:11:43 +02:00

x86/boot/32: Disable stackprotector and tracing for mk_early_pgtbl_32()

Stackprotector cannot work before paging is enabled. The read from the per
CPU variable __stack_chk_guard is always accessing the virtual address
either directly on UP or via FS on SMP. In physical address mode this
results in an access to memory above 3GB.

So this works by chance as the hardware returns the same value when there
is no RAM at this physical address. When there is RAM populated above 3G
then the read is by chance the same as nothing changes that memory during
the very early boot stage.

Stop relying on pure luck and disable the stack protector for the only C
function which is called during early boot before paging is enabled.

Remove function tracing from the whole source file as there is no way to
trace this at all, but in case of CONFIG_DYNAMIC_FTRACE=n
mk_early_pgtbl_32() would access global function tracer variables in
physical address mode which again might work by chance.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115902.156063939@linutronix.de
---
 arch/x86/kernel/Makefile | 1 +
 arch/x86/kernel/head32.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3269a0e..0000325 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -16,6 +16,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
+CFLAGS_REMOVE_head32.o = -pg
 CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 246a609..bf678d6 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -70,7 +70,8 @@ asmlinkage __visible void __init __noreturn i386_start_kernel(void)
  * always zero at this stage.
  */
 void __init mk_early_pgtbl_32(void);
-void __init mk_early_pgtbl_32(void)
+
+void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
 #ifdef __pa
 #undef __pa
