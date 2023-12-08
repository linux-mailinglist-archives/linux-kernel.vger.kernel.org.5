Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9CE80A940
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjLHQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574509AbjLHQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:35:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F5F1BE4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:35:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D02EC433C8;
        Fri,  8 Dec 2023 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702053341;
        bh=/Vr54DRtLZd4aKRU80jRMolyKRZJenT4nAxAfj9vNgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kqw5cSnRlXfjEbUQjs6WgIcysAOrhanmR902+VQbClMrPLkXY683HU5mJIYOzkTH3
         Yyue4EEiHDrdVsjDxVESagqcPXSMMrn9ULPcPXs0DEBlcDzw1koo1hDb/ldwLf7+dA
         e4lSJPR3TjZWnnHX0GERGFLrWlb9svcRzxZYBGOShKnRhor2Tqf9WNmRQNeFlBOmT+
         /mgGpK6XejchUuv4nmS/e8wkrrD+3+ViY72f1giw+hL5APgTaAmwVfen3vxcjdbjBs
         2ELu3e14nWeWdIWRRznQnfFErm2+uXCMBhnQqsoRklEnJGMjFpu9JMgHdvpiT849pE
         sKPBxbOmYlk0g==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 9/9] samples/ftrace: Add support for ftrace direct samples on powerpc
Date:   Fri,  8 Dec 2023 22:00:48 +0530
Message-ID: <4735fcdfb8977c6f437796590c0e3cbbf644d0de.1702045299.git.naveen@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702045299.git.naveen@kernel.org>
References: <cover.1702045299.git.naveen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add powerpc 32-bit and 64-bit samples for ftrace direct. This serves to
show the sample instruction sequence to be used by ftrace direct calls
to adhere to the ftrace ABI.

On 64-bit powerpc, TOC setup requires some additional work.

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 arch/powerpc/Kconfig                        |   2 +
 samples/ftrace/ftrace-direct-modify.c       |  94 ++++++++++++++++-
 samples/ftrace/ftrace-direct-multi-modify.c | 110 +++++++++++++++++++-
 samples/ftrace/ftrace-direct-multi.c        |  64 +++++++++++-
 samples/ftrace/ftrace-direct-too.c          |  72 ++++++++++++-
 samples/ftrace/ftrace-direct.c              |  61 ++++++++++-
 6 files changed, 398 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4fe04fdca33a..28de3a5f3e98 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -274,6 +274,8 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR		if PPC32 && $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=r2)
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index e2a6a69352df..bd985035b937 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
-#ifndef CONFIG_ARM64
+#if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
 
@@ -164,6 +164,98 @@ asm (
 
 #endif /* CONFIG_LOONGARCH */
 
+#ifdef CONFIG_PPC32
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	bl		my_direct_func1\n"
+"	lwz		0, 20(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 32\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	bl		my_direct_func2\n"
+"	lwz		0, 20(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 32\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	bl		my_direct_func1\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 48(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 64\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	bl		my_direct_func2\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 48(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 64\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC64 */
+
 static struct ftrace_ops direct;
 
 static unsigned long my_tramp = (unsigned long)my_tramp1;
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 2e349834d63c..478e879a23af 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
-#ifndef CONFIG_ARM64
+#if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
 
@@ -184,6 +184,114 @@ asm (
 
 #endif /* CONFIG_LOONGARCH */
 
+#ifdef CONFIG_PPC32
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -24(1)\n"
+"	stw		3, 16(1)\n"
+"	mr		3, 0\n"
+"	addi		3, 3, 16\n"
+"	bl		my_direct_func1\n"
+"	lwz		3, 16(1)\n"
+"	lwz		0, 28(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 40\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -24(1)\n"
+"	stw		3, 16(1)\n"
+"	mr		3, 0\n"
+"	addi		3, 3, 16\n"
+"	bl		my_direct_func2\n"
+"	lwz		3, 16(1)\n"
+"	lwz		0, 28(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 40\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -48(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	std		3, 32(1)\n"
+"	mr		3, 0\n"
+"	addi		3, 3, 20\n"
+"	bl		my_direct_func1\n"
+"	ld		3, 32(1)\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 64(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 80\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -48(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	std		3, 32(1)\n"
+"	mr		3, 0\n"
+"	addi		3, 3, 20\n"
+"	bl		my_direct_func2\n"
+"	ld		3, 32(1)\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 64(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 80\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC64 */
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 9243dbfe4d0c..558f4ad8d84a 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,7 +4,7 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
-#ifndef CONFIG_ARM64
+#if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
 
@@ -116,6 +116,68 @@ asm (
 
 #endif /* CONFIG_LOONGARCH */
 
+#ifdef CONFIG_PPC32
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -24(1)\n"
+"	stw		3, 16(1)\n"
+"	mr		3, 0\n"
+"	addi		3, 3, 16\n"
+"	bl		my_direct_func\n"
+"	lwz		3, 16(1)\n"
+"	lwz		0, 28(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 40\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -48(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	std		3, 32(1)\n"
+"	mr		3, 0\n"
+"	addi		3, 3, 20\n"
+"	bl		my_direct_func\n"
+"	ld		3, 32(1)\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 64(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 80\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC64 */
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_multi_init(void)
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e39c3563ae4e..2a35b5d88304 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,7 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
-#ifndef CONFIG_ARM64
+#if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
 
@@ -125,6 +125,76 @@ asm (
 
 #endif /* CONFIG_LOONGARCH */
 
+#ifdef CONFIG_PPC32
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -32(1)\n"
+"	stw		3, 16(1)\n"
+"	stw		4, 20(1)\n"
+"	stw		5, 24(1)\n"
+"	stw		6, 28(1)\n"
+"	bl		my_direct_func\n"
+"	lwz		6, 28(1)\n"
+"	lwz		5, 24(1)\n"
+"	lwz		4, 20(1)\n"
+"	lwz		3, 16(1)\n"
+"	lwz		0, 36(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 48\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -64(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	std		3, 32(1)\n"
+"	std		4, 40(1)\n"
+"	std		5, 48(1)\n"
+"	std		6, 56(1)\n"
+"	bl		my_direct_func\n"
+"	ld		6, 56(1)\n"
+"	ld		5, 48(1)\n"
+"	ld		4, 40(1)\n"
+"	ld		3, 32(1)\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 80(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 96\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC64 */
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_init(void)
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 32c477da1e9a..5585ffb6dd41 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,7 +3,7 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
-#ifndef CONFIG_ARM64
+#if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
 
@@ -110,6 +110,65 @@ asm (
 
 #endif /* CONFIG_LOONGARCH */
 
+#ifdef CONFIG_PPC32
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	stw		0, 4(1)\n"
+"	stwu		1, -16(1)\n"
+"	mflr		0\n"
+"	stw		0, 4(1)\n"
+"	stwu		1, -24(1)\n"
+"	stw		3, 16(1)\n"
+"	bl		my_direct_func\n"
+"	lwz		3, 16(1)\n"
+"	lwz		0, 28(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 40\n"
+"	lwz		0, 4(1)\n"
+"	blr\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC64
+
+asm (
+"	.pushsection	.text, \"ax\", @progbits\n"
+"	.type		my_tramp, @function\n"
+"	.globl		my_tramp\n"
+"   my_tramp:"
+"	std		0, 16(1)\n"
+"	stdu		1, -32(1)\n"
+"	mflr		0\n"
+"	std		0, 16(1)\n"
+"	stdu		1, -48(1)\n"
+"	std		2, 24(1)\n"
+"	bcl		20, 31, 1f\n"
+"   1:	mflr		12\n"
+"	ld		2, (2f - 1b)(12)\n"
+"	std		3, 32(1)\n"
+"	bl		my_direct_func\n"
+"	ld		3, 32(1)\n"
+"	ld		2, 24(1)\n"
+"	ld		0, 64(1)\n"
+"	mtlr		0\n"
+"	addi		1, 1, 80\n"
+"	ld		0, 16(1)\n"
+"	blr\n"
+"   2:	.quad		.TOC.@tocbase\n"
+"	.size		my_tramp, .-my_tramp\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_PPC64 */
+
+
 static struct ftrace_ops direct;
 
 static int __init ftrace_direct_init(void)
-- 
2.43.0

