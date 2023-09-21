Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B057AA166
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjIUVCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjIUVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:01:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E70A81FFB;
        Thu, 21 Sep 2023 10:36:34 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpdaK9Y/hgUOWkKEp7eAOLi63fnSsZpdnlSeFIfSZuA=;
        b=v7jGn3YlwHmsqNEKdZB2Wx1rrOHInzprRMX9+RTK7sqk42XCB7Lfr1pW2Klqgp3ZX8nZJ9
        WoQvgPF7VmPBs3YlLwbEB5r5jp7YlZrYsJvEJbqcJ1Wgx/bj7hliiHgimBOXmObrR0DIBj
        ct7OU/pIw9NKo9V6Qy58Hhrw0KKoUZuS4QjDvbgwJ7z7wljU/T5QfheOT1lHTHKZuvU5Ny
        3TwpNwNCP6esYv7tyJLGmvXdd/YWGAP1LRPPxKDR9KEPyHW9OajScLYAq77ZvDtAWPcqCf
        ulUoEgXLvmWyucrXbJZirosVn10OybXQHGMrG7v1JmiUpd41b66j2/JcoWe/RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317765;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zpdaK9Y/hgUOWkKEp7eAOLi63fnSsZpdnlSeFIfSZuA=;
        b=1pYAqSZXT84SkvO0RcS7RfkFbBHni0eOphgGmqzLWi4eCslqMm4e6lk6Z2MbaTsFyJHTxB
        Jtqi0blJmwaIEPCQ==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Add sys_futex_wake()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105247.936205525@noisy.programming.kicks-ass.net>
References: <20230921105247.936205525@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776454.27769.17624665546160714090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9f6c532f59b20580acf8ede9409c9b8dce6e74e1
Gitweb:        https://git.kernel.org/tip/9f6c532f59b20580acf8ede9409c9b8dce6e74e1
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:07 +02:00

futex: Add sys_futex_wake()

To complement sys_futex_waitv() add sys_futex_wake(). This syscall
implements what was previously known as FUTEX_WAKE_BITSET except it
uses 'unsigned long' for the bitmask and takes FUTEX2 flags.

The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20230921105247.936205525@noisy.programming.kicks-ass.net
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +-
 arch/arm/tools/syscall.tbl                  |  1 +-
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +-
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +-
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +-
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +-
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +-
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +-
 include/linux/syscalls.h                    |  3 ++-
 include/uapi/asm-generic/unistd.h           |  4 ++-
 kernel/futex/syscalls.c                     | 30 ++++++++++++++++++++-
 kernel/sys_ni.c                             |  1 +-
 22 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index ad37569..3b86519 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -492,3 +492,4 @@
 560	common	set_mempolicy_home_node		sys_ni_syscall
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
+563	common	futex_wake			sys_futex_wake
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index c572d6c..714abeb 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -466,3 +466,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index bd77253..63a8a9c 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		453
+#define __NR_compat_syscalls		455
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 78b6831..6897468 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -911,6 +911,8 @@ __SYSCALL(__NR_set_mempolicy_home_node, sys_set_mempolicy_home_node)
 __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_futex_wake 454
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 83d8609..cd50247 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -373,3 +373,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 259ceb1..21eb35c 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index a3798c2..3a4e851 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -458,3 +458,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 152034b..6883ea3 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -391,3 +391,4 @@
 450	n32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
+454	n32	futex_wake			sys_futex_wake
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index cb5e757..48bc0fb 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -367,3 +367,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
+454	n64	futex_wake			sys_futex_wake
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 1a64681..a92625f 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -440,3 +440,4 @@
 450	o32	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
+454	o32	futex_wake			sys_futex_wake
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index e97c175..57faa97 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 20e5058..e6c6ed6 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -539,3 +539,4 @@
 450 	nospu	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 0122cc1..7547201 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450  common	set_mempolicy_home_node	sys_set_mempolicy_home_node	sys_set_mempolicy_home_node
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
+454  common	futex_wake		sys_futex_wake			sys_futex_wake
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index e90d585..902a997 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -455,3 +455,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 4ed06c7..8a1f887 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -498,3 +498,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd..9e81323 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,4 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+454	i386	futex_wake		sys_futex_wake
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee3..d10a600 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,7 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	futex_wake		sys_futex_wake
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index fc1a4f3..4e511bf 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -423,3 +423,4 @@
 450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
+454	common	futex_wake			sys_futex_wake
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc..e174ed8 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -549,6 +549,9 @@ asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
 				unsigned int nr_futexes, unsigned int flags,
 				struct __kernel_timespec __user *timeout, clockid_t clockid);
+
+asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c..f5454e6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -822,9 +822,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
+#define __NR_futex_wake 454
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
 
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 455
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 2339f9c..7049a52 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -306,6 +306,36 @@ destroy_timer:
 	return ret;
 }
 
+/*
+ * sys_futex_wake - Wake a number of futexes
+ * @uaddr:	Address of the futex(es) to wake
+ * @mask:	bitmask
+ * @nr:		Number of the futexes to wake
+ * @flags:	FUTEX2 flags
+ *
+ * Identical to the traditional FUTEX_WAKE_BITSET op, except it is part of the
+ * futex2 family of calls.
+ */
+
+SYSCALL_DEFINE4(futex_wake,
+		void __user *, uaddr,
+		unsigned long, mask,
+		int, nr,
+		unsigned int, flags)
+{
+	if (flags & ~FUTEX2_VALID_MASK)
+		return -EINVAL;
+
+	flags = futex2_to_flags(flags);
+	if (!futex_flags_valid(flags))
+		return -EINVAL;
+
+	if (!futex_validate_input(flags, mask))
+		return -EINVAL;
+
+	return futex_wake(uaddr, flags, nr, mask);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e137c13..983c058 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -87,6 +87,7 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
+COND_SYSCALL(futex_wake);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);
