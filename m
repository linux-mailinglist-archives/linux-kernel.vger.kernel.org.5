Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9032777A90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjHJOX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbjHJOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:23:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDA2724;
        Thu, 10 Aug 2023 07:23:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0AF65DD3;
        Thu, 10 Aug 2023 14:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89935C433C8;
        Thu, 10 Aug 2023 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691677420;
        bh=v595bHoeyNn6tQTZFJfqAWz27K2FECm/q0MGvugZTZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxT8ZQR60KYnGL1DSAXEZb3e1nnFuS8GiPW51vMID+/XwWUWUbg5irPFhH22d+v5I
         5P6keUTpqVVa6BuazI5kKmsRIVW+YoGuU3R9tfmzBlVq7RuFqDjkHpl7L0HQENHSjZ
         dqogsDVC0AgR5QsqljD6o0S64dhRp9SzJO1TgwJz/WNdMfM02VHc3Wk8sCW2QGYrei
         u9bZmviAMmcQHlvPrvCws57z2H9HKs18wiTjUFMI9BUI22xd24e9YF8GmzbclD2/hS
         YPszKWmjRf+wEWSq8Xr00+3rsFkOfBHam8jOtbyM9s2NLNhUkREwhzS78LuHQUgb3R
         40Lce0N0wPBkA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "David S. Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Qing Zhang <zhangqing@loongson.cn>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Qi Hu <huqi@loongson.cn>, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org
Subject: [PATCH 15/17] arch: fix asm-offsets.c building with -Wmissing-prototypes
Date:   Thu, 10 Aug 2023 16:19:33 +0200
Message-Id: <20230810141947.1236730-16-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When -Wmissing-prototypes is enabled, the some asm-offsets.c files fail
to build, even when this warning is disabled in the Makefile for normal
files:

arch/sparc/kernel/asm-offsets.c:22:5: error: no previous prototype for 'sparc32_foo' [-Werror=missing-prototypes]
arch/sparc/kernel/asm-offsets.c:48:5: error: no previous prototype for 'foo' [-Werror=missing-prototypes]

Address this by making use of the same trick we have on other architectures,
renaming the unused global function to main(), which has an implicit
prototype.

On loongarch, there are many functions in this file, so the trick does
not work, adding explicit declarations works around it in a slightly
more ugly way but is the best I could come up with here.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/asm-offsets.c     |  2 +-
 arch/ia64/kernel/asm-offsets.c      |  2 +-
 arch/loongarch/kernel/asm-offsets.c | 12 ++++++++++++
 arch/sparc/kernel/asm-offsets.c     | 13 ++-----------
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index b121294bee266..b87487e70488d 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -12,7 +12,7 @@
 #include <linux/kbuild.h>
 #include <asm/io.h>
 
-void foo(void)
+int main(void)
 {
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
diff --git a/arch/ia64/kernel/asm-offsets.c b/arch/ia64/kernel/asm-offsets.c
index be3b90fef2e92..62b9aaf10b3c0 100644
--- a/arch/ia64/kernel/asm-offsets.c
+++ b/arch/ia64/kernel/asm-offsets.c
@@ -20,7 +20,7 @@
 #include "../kernel/sigframe.h"
 #include "../kernel/fsyscall_gtod_data.h"
 
-void foo(void)
+int main(void)
 {
 	DEFINE(IA64_TASK_SIZE, sizeof (struct task_struct));
 	DEFINE(IA64_THREAD_INFO_SIZE, sizeof (struct thread_info));
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 8da0726777edb..735115f8341c9 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/ftrace.h>
 
+void output_ptreg_defines(void);
 void output_ptreg_defines(void)
 {
 	COMMENT("LoongArch pt_regs offsets.");
@@ -61,6 +62,7 @@ void output_ptreg_defines(void)
 	BLANK();
 }
 
+void output_task_defines(void);
 void output_task_defines(void)
 {
 	COMMENT("LoongArch task_struct offsets.");
@@ -76,6 +78,7 @@ void output_task_defines(void)
 	BLANK();
 }
 
+void output_thread_info_defines(void);
 void output_thread_info_defines(void)
 {
 	COMMENT("LoongArch thread_info offsets.");
@@ -92,6 +95,7 @@ void output_thread_info_defines(void)
 	BLANK();
 }
 
+void output_thread_defines(void);
 void output_thread_defines(void)
 {
 	COMMENT("LoongArch specific thread_struct offsets.");
@@ -128,6 +132,7 @@ void output_thread_defines(void)
 	BLANK();
 }
 
+void output_thread_fpu_defines(void);
 void output_thread_fpu_defines(void)
 {
 	OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
@@ -169,6 +174,7 @@ void output_thread_fpu_defines(void)
 	BLANK();
 }
 
+void output_thread_lbt_defines(void);
 void output_thread_lbt_defines(void)
 {
 	OFFSET(THREAD_SCR0,  loongarch_lbt, scr0);
@@ -179,6 +185,7 @@ void output_thread_lbt_defines(void)
 	BLANK();
 }
 
+void output_mm_defines(void);
 void output_mm_defines(void)
 {
 	COMMENT("Size of struct page");
@@ -211,6 +218,7 @@ void output_mm_defines(void)
 	BLANK();
 }
 
+void output_sc_defines(void);
 void output_sc_defines(void)
 {
 	COMMENT("Linux sigcontext offsets.");
@@ -219,6 +227,7 @@ void output_sc_defines(void)
 	BLANK();
 }
 
+void output_signal_defines(void);
 void output_signal_defines(void)
 {
 	COMMENT("Linux signal numbers.");
@@ -257,6 +266,7 @@ void output_signal_defines(void)
 }
 
 #ifdef CONFIG_SMP
+void output_smpboot_defines(void);
 void output_smpboot_defines(void)
 {
 	COMMENT("Linux smp cpu boot offsets.");
@@ -267,6 +277,7 @@ void output_smpboot_defines(void)
 #endif
 
 #ifdef CONFIG_HIBERNATION
+void output_pbe_defines(void);
 void output_pbe_defines(void)
 {
 	COMMENT("Linux struct pbe offsets.");
@@ -279,6 +290,7 @@ void output_pbe_defines(void)
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void output_fgraph_ret_regs_defines(void);
 void output_fgraph_ret_regs_defines(void)
 {
 	COMMENT("LoongArch fgraph_ret_regs offsets.");
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 5784f2df489a4..4c8c9a6df2aa5 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -18,16 +18,12 @@
 
 #include <asm/hibernate.h>
 
-#ifdef CONFIG_SPARC32
-int sparc32_foo(void)
+int main(void)
 {
+#ifdef CONFIG_SPARC32
 	DEFINE(AOFF_thread_fork_kpsr,
 			offsetof(struct thread_struct, fork_kpsr));
-	return 0;
-}
 #else
-int sparc64_foo(void)
-{
 #ifdef CONFIG_HIBERNATION
 	BLANK();
 	OFFSET(SC_REG_FP, saved_context, fp);
@@ -41,12 +37,7 @@ int sparc64_foo(void)
 	OFFSET(SC_REG_G5, saved_context, g5);
 	OFFSET(SC_REG_G6, saved_context, g6);
 #endif
-	return 0;
-}
 #endif
-
-int foo(void)
-{
 	BLANK();
 	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
 	BLANK();
-- 
2.39.2

