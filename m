Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA317E99E9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjKMKNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjKMKNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:13:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38327D79;
        Mon, 13 Nov 2023 02:13:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA3C433C8;
        Mon, 13 Nov 2023 10:13:00 +0000 (UTC)
Date:   Mon, 13 Nov 2023 11:12:57 +0100
From:   Helge Deller <deller@gmx.de>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc:     matoro <matoro_mailinglist_kernel@matoro.tk>
Subject: [PATCH] parisc: Fix mmap_base calculation when stack grows upwards
Message-ID: <ZVH2qeS1bG7/1J/l@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matoro reported various userspace crashes on the parisc platform with kernel
6.6 and bisected it to commit 3033cd430768 ("parisc: Use generic mmap top-down
layout and brk randomization").

That commit switched parisc to use the common infrastructure to calculate
mmap_base, but missed that the mmap_base() function takes care for
architectures where the stack grows downwards only.

Fix the mmap_base() calculation to include the stack-grows-upwards case
and thus fix the userspace crashes on parisc.

Reported-by: matoro <matoro_mailinglist_kernel@matoro.tk>
Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: matoro <matoro_mailinglist_kernel@matoro.tk>
Fixes: 3033cd430768 ("parisc: Use generic mmap top-down layout and brk randomization")
Cc:  <stable@vger.kernel.org> # v6.6+

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fd69dfa0cdab..a7c9c0e69e5a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -140,11 +140,11 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
 	default 8
 
 config ARCH_MMAP_RND_BITS_MAX
-	default 24 if 64BIT
-	default 17
+	default 18 if 64BIT
+	default 13
 
 config ARCH_MMAP_RND_COMPAT_BITS_MAX
-	default 17
+	default 13
 
 # unless you want to implement ACPI on PA-RISC ... ;-)
 config PM
diff --git a/arch/parisc/include/asm/elf.h b/arch/parisc/include/asm/elf.h
index 140eaa97bf21..2d73d3c3cd37 100644
--- a/arch/parisc/include/asm/elf.h
+++ b/arch/parisc/include/asm/elf.h
@@ -349,15 +349,7 @@ struct pt_regs;	/* forward declaration... */
 
 #define ELF_HWCAP	0
 
-/* Masks for stack and mmap randomization */
-#define BRK_RND_MASK	(is_32bit_task() ? 0x07ffUL : 0x3ffffUL)
-#define MMAP_RND_MASK	(is_32bit_task() ? 0x1fffUL : 0x3ffffUL)
-#define STACK_RND_MASK	MMAP_RND_MASK
-
-struct mm_struct;
-extern unsigned long arch_randomize_brk(struct mm_struct *);
-#define arch_randomize_brk arch_randomize_brk
-
+#define STACK_RND_MASK	0x7ff	/* 8MB of VA */
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
 struct linux_binprm;
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index c05d121cf5d0..982aca20f56f 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -47,6 +47,8 @@
 
 #ifndef __ASSEMBLY__
 
+struct rlimit;
+unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
 unsigned long calc_max_stack_size(unsigned long stack_max);
 
 /*
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index ab896eff7a1d..98af719d5f85 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-static unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
 {
 	unsigned long stack_base;
 
diff --git a/mm/util.c b/mm/util.c
index aa01f6ea5a75..744b4d7e3fae 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -414,6 +414,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
 
 static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 {
+#ifdef CONFIG_STACK_GROWSUP
+	/*
+	 * For an upwards growing stack the calculation is much simpler.
+	 * Memory for the maximum stack size is reserved at the top of the
+	 * task. mmap_base starts directly below the stack and grows
+	 * downwards.
+	 */
+	return PAGE_ALIGN_DOWN(mmap_upper_limit(rlim_stack) - rnd);
+#else
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_guard_gap;
 
@@ -431,6 +440,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 		gap = MAX_GAP;
 
 	return PAGE_ALIGN(STACK_TOP - gap - rnd);
+#endif
 }
 
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
