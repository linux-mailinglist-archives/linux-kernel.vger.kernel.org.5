Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D7F7E9288
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 21:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjKLUWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 15:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjKLUWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 15:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14686258D;
        Sun, 12 Nov 2023 12:22:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121FC433C8;
        Sun, 12 Nov 2023 20:22:39 +0000 (UTC)
Date:   Sun, 12 Nov 2023 21:22:36 +0100
From:   Helge Deller <deller@gmx.de>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Sam James <sam@gentoo.org>, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bisected stability regression in 6.6
Message-ID: <ZVE0DJ5LS/BSO9xy@p100>
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
 <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de>
 <87edgw6kuz.fsf@gentoo.org>
 <9a84b68e9a538a66842dccc5efb8bdf8@matoro.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a84b68e9a538a66842dccc5efb8bdf8@matoro.tk>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* matoro <matoro_mailinglist_kernel@matoro.tk>:
> On 2023-11-11 16:27, Sam James wrote:
> > Helge Deller <deller@gmx.de> writes:
> > 
> > > On 11/11/23 07:31, matoro wrote:
> > > > Hi Helge, I have bisected a regression in 6.6 which is causing
> > > > userspace segfaults at a significantly increased rate in kernel 6.6.
> > > > There seems to be a pathological case triggered by the ninja build
> > > > tool.  The test case I have been using is cmake with ninja backend to
> > > > attempt to build the nghttp2 package.  In 6.6, this segfaults, not at
> > > > the same location every time, but with enough reliability that I was
> > > > able to use it as a bisection regression case, including immediately
> > > > after a reboot.  In the kernel log, these show up as "trap #15: Data
> > > > TLB miss fault" messages.  Now these messages can and do show up in
> > > > 6.5 causing segfaults, but never immediately after a reboot and
> > > > infrequently enough that the system is stable.  With kernel 6.6 I am
> > > > completely unable to build nghttp2 under any circumstances.
> > > > 
> > > > I have bisected this down to the following commit:
> > > > 
> > > > $ git bisect good
> > > > 3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
> > > > commit 3033cd4307681c60db6d08f398a64484b36e0b0f
> > > > Author: Helge Deller <deller@gmx.de>
> > > > Date:   Sat Aug 19 00:53:28 2023 +0200
> > > > 
> > > >      parisc: Use generic mmap top-down layout and brk randomization
> > > > 
> > > >      parisc uses a top-down layout by default that exactly fits
> > > > the generic
> > > >      functions, so get rid of arch specific code and use the
> > > > generic version
> > > >      by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
> > > > 
> > > >      Note that on parisc the stack always grows up and a "unlimited stack"
> > > >      simply means that the value as defined in
> > > > CONFIG_STACK_MAX_DEFAULT_SIZE_MB
> > > >      should be used. So RLIM_INFINITY is not an indicator to use
> > > > the legacy
> > > >      memory layout.
> > > > 
> > > >      Signed-off-by: Helge Deller <deller@gmx.de>
> > > > 
> > > >   arch/parisc/Kconfig             | 17 +++++++++++++
> > > >   arch/parisc/kernel/process.c    | 14 -----------
> > > >   arch/parisc/kernel/sys_parisc.c | 54
> > > > +----------------------------------------
> > > >   mm/util.c                       |  5 +++-
> > > >   4 files changed, 22 insertions(+), 68 deletions(-)
> > > 
> > > Thanks for your report!
> > > I think it's quite unlikely that this patch introduces such a bad
> > > regression.

I was wrong.
Indeed, by switching to the generic implementation with this patch
the calculation of mmap_base is wrong for parisc (because parisc
is the only architecture left where the stack grows upwards).

Could you please test the patch below. It did fixed the crashes
when building nghttp2 for me.

Helge

---

From: Helge Deller <deller@gmx.de>
Subject: [PATCH] parisc: Adjust ARCH_MMAP_RND_BITS* to previous values

Matoro reported various userspace crashes in kernel 6.6 and bisected it to
commit 3033cd430768 ("parisc: Use generic mmap top-down layout and brk
randomization").

The problem is, that mmap_base is calculated wrongly for the
stack-grows-upwards case (as on parisc). On parisc, mmap_base is simply just
below the stack start.

Reported-by: matoro <matoro_mailinglist_kernel@matoro.tk>
Signed-off-by: Helge Deller <deller@gmx.de>
Fixes: 3033cd430768 ("parisc: Use generic mmap top-down layout and brk randomization")
Cc:  <stable@vger.kernel.org> # v6.6+

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index a15ab147af2e..68cbe666510a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -138,11 +138,11 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
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
index ff6cbdb6903b..ece4b3046515 100644
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
index 8cbbfd3a3d59..0b7e715a71f2 100644
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
+	return PAGE_ALIGN(mmap_upper_limit(rlim_stack) - rnd);
+#else
 	unsigned long gap = rlim_stack->rlim_cur;
 	unsigned long pad = stack_guard_gap;
 
@@ -431,6 +440,7 @@ static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
 		gap = MAX_GAP;
 
 	return PAGE_ALIGN(STACK_TOP - gap - rnd);
+#endif
 }
 
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
