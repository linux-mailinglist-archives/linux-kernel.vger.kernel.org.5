Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E77FF07B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345663AbjK3Nnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjK3Nnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:43:46 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A54FDD;
        Thu, 30 Nov 2023 05:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YZ0GfTPU5Y9/KIDudfiquHny4LAq8atLh8MsbRLgf+Y=; b=UyepradYwE1I39llEfbubbm/q+
        w0zCrEkYd5IS8pW3dI+UeR5IBw/z3fy9J5WdUeqUp5Mmkjn+a0AaksqAiv8O/4CBpUXh3+/skEVIN
        +5sDwVZq4vsGXroUSi3gOLpbf2Es/qCoC+9AsHEmtaYOfYXkn8eOmyF2oSO1kQZCKTM4s9E+DcHyB
        tPpQo93S5Z+BcpudJi+lYex/A6Fhrwi2vx5spgZHjyyDbwpK2UehezXKHiCBR86CX6fsa4F0n9boK
        OCjx6zjDz3kniu4YhoY5/V40m2tZw1HdgxWKxjU8YgNruo3ZUR97w1jx+6gkOynAI9KjmQNGD9Wgm
        FPCR79jQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8hJs-0013s8-0p;
        Thu, 30 Nov 2023 13:43:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 563A7300A7E; Thu, 30 Nov 2023 14:43:07 +0100 (CET)
Message-Id: <20231130134204.026354676@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 30 Nov 2023 14:36:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     peterz@infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, davem@davemloft.net, dsahern@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        samitolvanen@google.com, keescook@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-arch@vger.kernel.org,
        llvm@lists.linux.dev, jpoimboe@kernel.org, joao@overdrivepizza.com,
        mark.rutland@arm.com
Subject: [PATCH v2 1/2] cfi: Flip headers
References: <20231130133630.192490507@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normal include order is that linux/foo.h should include asm/foo.h, CFI has it
the wrong way around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/riscv/include/asm/cfi.h |    3 ++-
 arch/riscv/kernel/cfi.c      |    2 +-
 arch/x86/include/asm/cfi.h   |    3 ++-
 arch/x86/kernel/cfi.c        |    4 ++--
 include/asm-generic/Kbuild   |    1 +
 include/asm-generic/cfi.h    |    5 +++++
 include/linux/cfi.h          |    1 +
 7 files changed, 14 insertions(+), 5 deletions(-)

--- a/arch/riscv/include/asm/cfi.h
+++ b/arch/riscv/include/asm/cfi.h
@@ -7,8 +7,9 @@
  *
  * Copyright (C) 2023 Google LLC
  */
+#include <linux/bug.h>
 
-#include <linux/cfi.h>
+struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
--- a/arch/riscv/kernel/cfi.c
+++ b/arch/riscv/kernel/cfi.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2023 Google LLC
  */
-#include <asm/cfi.h>
+#include <linux/cfi.h>
 #include <asm/insn.h>
 
 /*
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -7,8 +7,9 @@
  *
  * Copyright (C) 2022 Google LLC
  */
+#include <linux/bug.h>
 
-#include <linux/cfi.h>
+struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -4,10 +4,10 @@
  *
  * Copyright (C) 2022 Google LLC
  */
-#include <asm/cfi.h>
+#include <linux/string.h>
+#include <linux/cfi.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
-#include <linux/string.h>
 
 /*
  * Returns the target address and the expected type when regs->ip points
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -11,6 +11,7 @@ mandatory-y += bitops.h
 mandatory-y += bug.h
 mandatory-y += bugs.h
 mandatory-y += cacheflush.h
+mandatory-y += cfi.h
 mandatory-y += checksum.h
 mandatory-y += compat.h
 mandatory-y += current.h
--- /dev/null
+++ b/include/asm-generic/cfi.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_GENERIC_CFI_H
+#define __ASM_GENERIC_CFI_H
+
+#endif /* __ASM_GENERIC_CFI_H */
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -9,6 +9,7 @@
 
 #include <linux/bug.h>
 #include <linux/module.h>
+#include <asm/cfi.h>
 
 #ifdef CONFIG_CFI_CLANG
 enum bug_trap_type report_cfi_failure(struct pt_regs *regs, unsigned long addr,


