Return-Path: <linux-kernel+bounces-26812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5179482E674
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1053B2304C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27496111AB;
	Tue, 16 Jan 2024 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4KmpzWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C311193;
	Tue, 16 Jan 2024 01:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF5EC433C7;
	Tue, 16 Jan 2024 01:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367081;
	bh=Fu3FMlvztkrmM0NdvB9hkbzV9Z7UjEP32kS9KxzzOSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4KmpzWiSlYffQQx3K09LzrB7/IlPrKWKNLUzmBovAWSYS0VF1fBYVSKRjfoKTvai
	 yvyksOppy7N6RvbRXe+nsDTHrFJpBZdGT8G+tuM4Gn+MTJMLbGkBd9VLCJwYoCbaOa
	 0tveQc0bvFB+FQNXt5na8HGHs+boF0S13MY63NtgjqoyITHdU7Hk/8JtWhTA7OGS64
	 sBNieV/bCT6UnSC7m+qTQhUunxe8YILzhOq9Nt6rnSf2E2vQECs0pTmKGZMx0wiIsQ
	 wPPfoSF+eTU2wSmp+vb1IuT5yd2OZYpz5ymD0tDY/h1N06JJIVLKQhSYTYhD42jBIE
	 sb1ZCEqaQ+edw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sasha Levin <sashal@kernel.org>,
	richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	chenhuacai@kernel.org,
	davem@davemloft.net,
	viro@zeniv.linux.org.uk,
	pengdonglin@sangfor.com.cn,
	rostedt@goodmis.org,
	maobibo@loongson.cn,
	zhaotianrui@loongson.cn,
	huqi@loongson.cn,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 03/21] arch: fix asm-offsets.c building with -Wmissing-prototypes
Date: Mon, 15 Jan 2024 20:03:40 -0500
Message-ID: <20240116010422.217925-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010422.217925-1-sashal@kernel.org>
References: <20240116010422.217925-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4d86896793dd6eeacdf32b85af1ef130349db4be ]

When -Wmissing-prototypes is enabled, the some asm-offsets.c files fail
to build, even when this warning is disabled in the Makefile for normal
files:

arch/sparc/kernel/asm-offsets.c:22:5: error: no previous prototype for 'sparc32_foo' [-Werror=missing-prototypes]
arch/sparc/kernel/asm-offsets.c:48:5: error: no previous prototype for 'foo' [-Werror=missing-prototypes]

Address this by making use of the same trick as x86, marking these
functions as 'static __used' to avoid the need for a prototype
by not drop them in dead-code elimination.

Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://lore.kernel.org/lkml/CAK7LNARfEmFk0Du4Hed19eX_G6tUC5wG0zP+L1AyvdpOF4ybXQ@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/alpha/kernel/asm-offsets.c     |  2 +-
 arch/loongarch/kernel/asm-offsets.c | 26 +++++++++++++-------------
 arch/sparc/kernel/asm-offsets.c     |  6 +++---
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index b121294bee26..bf1eedd27cf7 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -12,7 +12,7 @@
 #include <linux/kbuild.h>
 #include <asm/io.h>
 
-void foo(void)
+static void __used foo(void)
 {
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 173fe514fc9e..bee9f7a3108f 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -15,7 +15,7 @@
 #include <asm/processor.h>
 #include <asm/ftrace.h>
 
-void output_ptreg_defines(void)
+static void __used output_ptreg_defines(void)
 {
 	COMMENT("LoongArch pt_regs offsets.");
 	OFFSET(PT_R0, pt_regs, regs[0]);
@@ -62,7 +62,7 @@ void output_ptreg_defines(void)
 	BLANK();
 }
 
-void output_task_defines(void)
+static void __used output_task_defines(void)
 {
 	COMMENT("LoongArch task_struct offsets.");
 	OFFSET(TASK_STATE, task_struct, __state);
@@ -77,7 +77,7 @@ void output_task_defines(void)
 	BLANK();
 }
 
-void output_thread_info_defines(void)
+static void __used output_thread_info_defines(void)
 {
 	COMMENT("LoongArch thread_info offsets.");
 	OFFSET(TI_TASK, thread_info, task);
@@ -93,7 +93,7 @@ void output_thread_info_defines(void)
 	BLANK();
 }
 
-void output_thread_defines(void)
+static void __used output_thread_defines(void)
 {
 	COMMENT("LoongArch specific thread_struct offsets.");
 	OFFSET(THREAD_REG01, task_struct, thread.reg01);
@@ -129,7 +129,7 @@ void output_thread_defines(void)
 	BLANK();
 }
 
-void output_thread_fpu_defines(void)
+static void __used output_thread_fpu_defines(void)
 {
 	OFFSET(THREAD_FPR0, loongarch_fpu, fpr[0]);
 	OFFSET(THREAD_FPR1, loongarch_fpu, fpr[1]);
@@ -170,7 +170,7 @@ void output_thread_fpu_defines(void)
 	BLANK();
 }
 
-void output_thread_lbt_defines(void)
+static void __used output_thread_lbt_defines(void)
 {
 	OFFSET(THREAD_SCR0,  loongarch_lbt, scr0);
 	OFFSET(THREAD_SCR1,  loongarch_lbt, scr1);
@@ -180,7 +180,7 @@ void output_thread_lbt_defines(void)
 	BLANK();
 }
 
-void output_mm_defines(void)
+static void __used output_mm_defines(void)
 {
 	COMMENT("Size of struct page");
 	DEFINE(STRUCT_PAGE_SIZE, sizeof(struct page));
@@ -212,7 +212,7 @@ void output_mm_defines(void)
 	BLANK();
 }
 
-void output_sc_defines(void)
+static void __used output_sc_defines(void)
 {
 	COMMENT("Linux sigcontext offsets.");
 	OFFSET(SC_REGS, sigcontext, sc_regs);
@@ -220,7 +220,7 @@ void output_sc_defines(void)
 	BLANK();
 }
 
-void output_signal_defines(void)
+static void __used output_signal_defines(void)
 {
 	COMMENT("Linux signal numbers.");
 	DEFINE(_SIGHUP, SIGHUP);
@@ -258,7 +258,7 @@ void output_signal_defines(void)
 }
 
 #ifdef CONFIG_SMP
-void output_smpboot_defines(void)
+static void __used output_smpboot_defines(void)
 {
 	COMMENT("Linux smp cpu boot offsets.");
 	OFFSET(CPU_BOOT_STACK, secondary_data, stack);
@@ -268,7 +268,7 @@ void output_smpboot_defines(void)
 #endif
 
 #ifdef CONFIG_HIBERNATION
-void output_pbe_defines(void)
+static void __used output_pbe_defines(void)
 {
 	COMMENT("Linux struct pbe offsets.");
 	OFFSET(PBE_ADDRESS, pbe, address);
@@ -280,7 +280,7 @@ void output_pbe_defines(void)
 #endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-void output_fgraph_ret_regs_defines(void)
+static void __used output_fgraph_ret_regs_defines(void)
 {
 	COMMENT("LoongArch fgraph_ret_regs offsets.");
 	OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
@@ -291,7 +291,7 @@ void output_fgraph_ret_regs_defines(void)
 }
 #endif
 
-void output_kvm_defines(void)
+static void __used output_kvm_defines(void)
 {
 	COMMENT("KVM/LoongArch Specific offsets.");
 
diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index 5784f2df489a..3d9b9855dce9 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -19,14 +19,14 @@
 #include <asm/hibernate.h>
 
 #ifdef CONFIG_SPARC32
-int sparc32_foo(void)
+static int __used sparc32_foo(void)
 {
 	DEFINE(AOFF_thread_fork_kpsr,
 			offsetof(struct thread_struct, fork_kpsr));
 	return 0;
 }
 #else
-int sparc64_foo(void)
+static int __used sparc64_foo(void)
 {
 #ifdef CONFIG_HIBERNATION
 	BLANK();
@@ -45,7 +45,7 @@ int sparc64_foo(void)
 }
 #endif
 
-int foo(void)
+static int __used foo(void)
 {
 	BLANK();
 	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
-- 
2.43.0


