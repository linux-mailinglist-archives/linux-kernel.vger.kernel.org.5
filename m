Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADC67A9B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjIUTCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIUTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DCE7E4CC;
        Thu, 21 Sep 2023 10:36:02 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:35:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uC12/rilTZVClOtuhAIBo3hgsDJyZhHceNPIIAVhvMs=;
        b=TLGGKmWQdrpCpBwXnOw62mkudakedMYR2qcrCWAu+OGos/uWgTpShnrn+ChpaM8lbOxOsV
        aJG6mQ6nvsAK65jrVqpJHX+3+z/06U8RREUzJuIjsYWZnVd3y1hLOEjTRcFaXBtDVFTiXB
        Rd4vhjyAK7d5wcR+w8Zs4jOgcgW6FirTmJvHTVUkyB3L83c9T8uQ+tkMHSWgaALY6q2rAh
        GWSscZu2kYYLEm9lUvr2a/zVmQXlFJ5RC8zqjpzR52b5CbkedWGsz4YI6xsI5nlVPXFsNm
        bEF/DjBxGzfEg2Y4x/aXYpkKj7i3zayC2I22KvxVj/oPSasybgn7JAvVwd7g0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317760;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uC12/rilTZVClOtuhAIBo3hgsDJyZhHceNPIIAVhvMs=;
        b=/OmIrzLu3YzgwhdjS6LKTMTA1B+t9rs7QttWq8JGg25EmQZ0rrHfnRQPGRoNq+uKgf6Q+b
        OWMmakvh0gq/+FBw==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Add sys_futex_requeue()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105248.511860556@noisy.programming.kicks-ass.net>
References: <20230921105248.511860556@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531775974.27769.6116959399118400043.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f4b5f972216782a4acb1ae00dcb55173847c2ff
Gitweb:        https://git.kernel.org/tip/0f4b5f972216782a4acb1ae00dcb55173847c2ff
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:10 +02:00

futex: Add sys_futex_requeue()

Finish off the 'simple' futex2 syscall group by adding
sys_futex_requeue(). Unlike sys_futex_{wait,wake}() its arguments are
too numerous to fit into a regular syscall. As such, use struct
futex_waitv to pass the 'source' and 'destination' futexes to the
syscall.

This syscall implements what was previously known as FUTEX_CMP_REQUEUE
and uses {val, uaddr, flags} for source and {uaddr, flags} for
destination.

This design explicitly allows requeueing between different types of
futex by having a different flags word per uaddr.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20230921105248.511860556@noisy.programming.kicks-ass.net
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
 include/uapi/asm-generic/unistd.h           |  4 +-
 kernel/futex/syscalls.c                     | 38 ++++++++++++++++++++-
 kernel/sys_ni.c                             |  1 +-
 22 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index c49f12f..b1865f9 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -494,3 +494,4 @@
 562	common	fchmodat2			sys_fchmodat2
 563	common	futex_wake			sys_futex_wake
 564	common	futex_wait			sys_futex_wait
+565	common	futex_requeue			sys_futex_requeue
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index a6cf562..93d0d46 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -468,3 +468,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index f33190f..531effc 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		456
+#define __NR_compat_syscalls		457
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 6e7d372..c453291 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -915,6 +915,8 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_wait 455
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 456
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 4043f0c..81375ea 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -375,3 +375,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 2484167..f7f997a 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -454,3 +454,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index f03927a..2967ec2 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -460,3 +460,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index dbb5edf..383abb1 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -393,3 +393,4 @@
 452	n32	fchmodat2			sys_fchmodat2
 454	n32	futex_wake			sys_futex_wake
 455	n32	futex_wait			sys_futex_wait
+456	n32	futex_requeue			sys_futex_requeue
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index faff8df..c9bd09b 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -369,3 +369,4 @@
 452	n64	fchmodat2			sys_fchmodat2
 454	n64	futex_wake			sys_futex_wake
 455	n64	futex_wait			sys_futex_wait
+456	n64	futex_requeue			sys_futex_requeue
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 542f756..ba5ef6c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -442,3 +442,4 @@
 452	o32	fchmodat2			sys_fchmodat2
 454	o32	futex_wake			sys_futex_wake
 455	o32	futex_wait			sys_futex_wait
+456	o32	futex_requeue			sys_futex_requeue
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 8e50e89..9f0f6df 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index ad33a99..26fc419 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -541,3 +541,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 418853f..31be90b 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
 455  common	futex_wait		sys_futex_wait			sys_futex_wait
+456  common	futex_requeue		sys_futex_requeue			sys_futex_requeue
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 8ef9557..4bc5d48 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -457,3 +457,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index df59a9d..8404c8e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -500,3 +500,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0f66168..31c48bc 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -459,3 +459,4 @@
 452	i386	fchmodat2		sys_fchmodat2
 454	i386	futex_wake		sys_futex_wake
 455	i386	futex_wait		sys_futex_wait
+456	i386	futex_requeue		sys_futex_requeue
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ddf6288..a577bb2 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -377,6 +377,7 @@
 453	64	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
+456	common	futex_requeue		sys_futex_requeue
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index ac278db..dd71ecc 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -425,3 +425,4 @@
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
 455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 11f3fdd..0901af6 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -556,6 +556,9 @@ asmlinkage long sys_futex_wait(void __user *uaddr, unsigned long val, unsigned l
 			       unsigned int flags, struct __kernel_timespec __user *timespec,
 			       clockid_t clockid);
 
+asmlinkage long sys_futex_requeue(struct futex_waitv __user *waiters,
+				  unsigned int flags, int nr_wake, int nr_requeue);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f6553bd..d9e9cd1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -826,9 +826,11 @@ __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
 #define __NR_futex_wait 455
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
+#define __NR_futex_requeue 456
+__SYSCALL(__NR_futex_requeue, sys_futex_requeue)
 
 #undef __NR_syscalls
-#define __NR_syscalls 456
+#define __NR_syscalls 457
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index dde9b74..8200d86 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -396,6 +396,44 @@ SYSCALL_DEFINE6(futex_wait,
 	return ret;
 }
 
+/*
+ * sys_futex_requeue - Requeue a waiter from one futex to another
+ * @waiters:	array describing the source and destination futex
+ * @flags:	unused
+ * @nr_wake:	number of futexes to wake
+ * @nr_requeue:	number of futexes to requeue
+ *
+ * Identical to the traditional FUTEX_CMP_REQUEUE op, except it is part of the
+ * futex2 family of calls.
+ */
+
+SYSCALL_DEFINE4(futex_requeue,
+		struct futex_waitv __user *, waiters,
+		unsigned int, flags,
+		int, nr_wake,
+		int, nr_requeue)
+{
+	struct futex_vector futexes[2];
+	u32 cmpval;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+
+	if (!waiters)
+		return -EINVAL;
+
+	ret = futex_parse_waitv(futexes, waiters, 2);
+	if (ret)
+		return ret;
+
+	cmpval = futexes[0].w.val;
+
+	return futex_requeue(u64_to_user_ptr(futexes[0].w.uaddr), futexes[0].w.flags,
+			     u64_to_user_ptr(futexes[1].w.uaddr), futexes[1].w.flags,
+			     nr_wake, nr_requeue, &cmpval, 0);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 13df391..9db51ea 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -89,6 +89,7 @@ COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL(futex_wake);
 COND_SYSCALL(futex_wait);
+COND_SYSCALL(futex_requeue);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);
