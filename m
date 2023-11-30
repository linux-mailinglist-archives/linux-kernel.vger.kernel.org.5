Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F07C7FEEB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345311AbjK3MQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjK3MPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:15:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA72210F1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:15:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BF8C433CB;
        Thu, 30 Nov 2023 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701346557;
        bh=QpkN41YvSor1jwumkkXVhFGSPSCKfdeY2ecGbrzFEKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESf7vaUAsJQo7XbJJ8CY2vaTnHvoHNkbU+ygbu3pIqsTakCmjixNfhQdDwhH3M718
         P+FG9fxJPsUVU3NcK/w6YcR0sDARftVKj8+wU35OIOClovLMLg1lIOfDHEoGWR+a50
         oZak4RqQlqHKEsRKyQ6byP+eJAo5/NhtajBcjS7OJpOF95XYkmqEzzkGOElrQAVaJ/
         Hmr+XLn1TqJ1CCfBzuXI9oYXnIykLF5SqtDikWD1gDsglAVcUUwQzULlYKbBg9jPX+
         fdFuDlRkyQtR81vEQcVsQtWROxYKog+kRHChF2O5LrM3xskVq4hNhXysKZ0+TvRWPm
         tPFN0WTdrCPGQ==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Song Shuai <suagrfillet@gmail.com>,
        Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        songshuaishuai@tinylab.org,
        Evgenii Shatokhin <e.shatokhin@yadro.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v12 for-next 4/4] samples: ftrace: Add RISC-V support for SAMPLE_FTRACE_DIRECT[_MULTI]
Date:   Thu, 30 Nov 2023 13:15:31 +0100
Message-Id: <20231130121531.1178502-5-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130121531.1178502-1-bjorn@kernel.org>
References: <20231130121531.1178502-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Shuai <suagrfillet@gmail.com>

Add RISC-V variants of the ftrace-direct* samples.

Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig                          |  2 +
 samples/ftrace/ftrace-direct-modify.c       | 35 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 41 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 25 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 28 ++++++++++++++
 samples/ftrace/ftrace-direct.c              | 24 ++++++++++++
 6 files changed, 155 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 4684cdc754a0..0ee79a92918d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -142,6 +142,8 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
+	select HAVE_SAMPLE_FTRACE_DIRECT
+	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index e2a6a69352df..81220390851a 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -24,6 +24,41 @@ extern void my_tramp2(void *);
 
 static unsigned long my_ip = (unsigned long)schedule;
 
+#ifdef CONFIG_RISCV
+#include <asm/asm.h>
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"	addi	sp,sp,-2*"SZREG"\n"
+"	"REG_S"	t0,0*"SZREG"(sp)\n"
+"	"REG_S"	ra,1*"SZREG"(sp)\n"
+"	call	my_direct_func1\n"
+"	"REG_L"	t0,0*"SZREG"(sp)\n"
+"	"REG_L"	ra,1*"SZREG"(sp)\n"
+"	addi	sp,sp,2*"SZREG"\n"
+"	jr	t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+
+"   my_tramp2:\n"
+"	addi	sp,sp,-2*"SZREG"\n"
+"	"REG_S"	t0,0*"SZREG"(sp)\n"
+"	"REG_S"	ra,1*"SZREG"(sp)\n"
+"	call	my_direct_func2\n"
+"	"REG_L"	t0,0*"SZREG"(sp)\n"
+"	"REG_L"	ra,1*"SZREG"(sp)\n"
+"	addi	sp,sp,2*"SZREG"\n"
+"	jr	t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 2e349834d63c..f943e40d57fd 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -22,6 +22,47 @@ void my_direct_func2(unsigned long ip)
 extern void my_tramp1(void *);
 extern void my_tramp2(void *);
 
+#ifdef CONFIG_RISCV
+#include <asm/asm.h>
+
+asm (
+"	.pushsection    .text, \"ax\", @progbits\n"
+"	.type		my_tramp1, @function\n"
+"	.globl		my_tramp1\n"
+"   my_tramp1:\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
+"       mv	a0,t0\n"
+"       call	my_direct_func1\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
+"	jr	t0\n"
+"	.size		my_tramp1, .-my_tramp1\n"
+
+"	.type		my_tramp2, @function\n"
+"	.globl		my_tramp2\n"
+"   my_tramp2:\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
+"       mv	a0,t0\n"
+"       call	my_direct_func2\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
+"	jr	t0\n"
+"	.size		my_tramp2, .-my_tramp2\n"
+"	.popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index 9243dbfe4d0c..aed6df2927ce 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -17,6 +17,31 @@ void my_direct_func(unsigned long ip)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+#include <asm/asm.h>
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
+"       mv	a0,t0\n"
+"       call	my_direct_func\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
+"       jr	t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e39c3563ae4e..6ff546a5d7eb 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -19,6 +19,34 @@ void my_direct_func(struct vm_area_struct *vma, unsigned long address,
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+#include <asm/asm.h>
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi	sp,sp,-5*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	a1,1*"SZREG"(sp)\n"
+"       "REG_S"	a2,2*"SZREG"(sp)\n"
+"       "REG_S"	t0,3*"SZREG"(sp)\n"
+"       "REG_S"	ra,4*"SZREG"(sp)\n"
+"       call	my_direct_func\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	a1,1*"SZREG"(sp)\n"
+"       "REG_L"	a2,2*"SZREG"(sp)\n"
+"       "REG_L"	t0,3*"SZREG"(sp)\n"
+"       "REG_L"	ra,4*"SZREG"(sp)\n"
+"       addi	sp,sp,5*"SZREG"\n"
+"       jr	t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 32c477da1e9a..ef0945670e1e 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -16,6 +16,30 @@ void my_direct_func(struct task_struct *p)
 
 extern void my_tramp(void *);
 
+#ifdef CONFIG_RISCV
+#include <asm/asm.h>
+
+asm (
+"       .pushsection    .text, \"ax\", @progbits\n"
+"       .type           my_tramp, @function\n"
+"       .globl          my_tramp\n"
+"   my_tramp:\n"
+"       addi	sp,sp,-3*"SZREG"\n"
+"       "REG_S"	a0,0*"SZREG"(sp)\n"
+"       "REG_S"	t0,1*"SZREG"(sp)\n"
+"       "REG_S"	ra,2*"SZREG"(sp)\n"
+"       call	my_direct_func\n"
+"       "REG_L"	a0,0*"SZREG"(sp)\n"
+"       "REG_L"	t0,1*"SZREG"(sp)\n"
+"       "REG_L"	ra,2*"SZREG"(sp)\n"
+"       addi	sp,sp,3*"SZREG"\n"
+"       jr	t0\n"
+"       .size           my_tramp, .-my_tramp\n"
+"       .popsection\n"
+);
+
+#endif /* CONFIG_RISCV */
+
 #ifdef CONFIG_X86_64
 
 #include <asm/ibt.h>
-- 
2.40.1

