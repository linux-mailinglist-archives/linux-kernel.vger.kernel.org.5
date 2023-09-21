Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5A7AA37D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjIUVvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjIUVuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:50:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4587E4E1;
        Thu, 21 Sep 2023 10:36:04 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695317762;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JuFsUG6364ieWeezOlTZTtncypZmC3oy2q6XeD88HTY=;
        b=2gGZyvE+CJUiQQ96deWluBg4bBXtBlGDGEY8QKuyJuJfIRu7TQDouL7MAvFbMfvhp7aVz/
        L3+BgLhNTE/bFbn94khQ+7phmeJnLind46WGz5vrE5BqaQWt2UtVNy5Id8Mh8vWZmspiYV
        9ZwZx2GsAK3yBwPY061rSY0ZyjxDRniCz6t6JdgnaIrLuCupv9Y3ArlnPaNB4FnpvINMea
        1Sx/N44PhGF/9g9V3O2JmrLyo7F+jGF4O8GKj56QEpfm+mcJnvRkOjwNR4ZSHASuw4Q5fy
        a53GTTCMe6Iz7XxczPDovxq7WygUs6w0cCzBUZ6pVH8HdxJjgRLAXVN6TkIOgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695317762;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JuFsUG6364ieWeezOlTZTtncypZmC3oy2q6XeD88HTY=;
        b=K4cUC7VELU9IXS7hKaUT2aoOv6uiBbgpOQuTb20B51Ev0nUTkRk6qxHvOo3E5bM0MzFepj
        o8GaDL4pS1c8f/DA==
From:   "tip-bot2 for peterz@infradead.org" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Add sys_futex_wait()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230921105248.164324363@noisy.programming.kicks-ass.net>
References: <20230921105248.164324363@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <169531776161.27769.14058566442953003924.tip-bot2@tip-bot2>
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

Commit-ID:     cb8c4312afca1b2dc64107e7e7cea81911055612
Gitweb:        https://git.kernel.org/tip/cb8c4312afca1b2dc64107e7e7cea81911055612
Author:        peterz@infradead.org <peterz@infradead.org>
AuthorDate:    Thu, 21 Sep 2023 12:45:12 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Sep 2023 19:22:08 +02:00

futex: Add sys_futex_wait()

To complement sys_futex_waitv()/wake(), add sys_futex_wait(). This
syscall implements what was previously known as FUTEX_WAIT_BITSET
except it uses 'unsigned long' for the value and bitmask arguments,
takes timespec and clockid_t arguments for the absolute timeout and
uses FUTEX2 flags.

The 'unsigned long' allows FUTEX2_SIZE_U64 on 64bit platforms.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Link: https://lore.kernel.org/r/20230921105248.164324363@noisy.programming.kicks-ass.net
---
 arch/alpha/kernel/syscalls/syscall.tbl      |   1 +-
 arch/arm/tools/syscall.tbl                  |   1 +-
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |   2 +-
 arch/ia64/kernel/syscalls/syscall.tbl       |   1 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |   1 +-
 arch/microblaze/kernel/syscalls/syscall.tbl |   1 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   1 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   1 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |   1 +-
 arch/parisc/kernel/syscalls/syscall.tbl     |   1 +-
 arch/powerpc/kernel/syscalls/syscall.tbl    |   1 +-
 arch/s390/kernel/syscalls/syscall.tbl       |   1 +-
 arch/sh/kernel/syscalls/syscall.tbl         |   1 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |   1 +-
 arch/x86/entry/syscalls/syscall_32.tbl      |   1 +-
 arch/x86/entry/syscalls/syscall_64.tbl      |   1 +-
 arch/xtensa/kernel/syscalls/syscall.tbl     |   1 +-
 include/linux/syscalls.h                    |   4 +-
 include/uapi/asm-generic/unistd.h           |   4 +-
 kernel/futex/futex.h                        |   3 +-
 kernel/futex/syscalls.c                     | 120 ++++++++++++++-----
 kernel/futex/waitwake.c                     |  61 +++++-----
 kernel/sys_ni.c                             |   1 +-
 24 files changed, 156 insertions(+), 57 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 3b86519..c49f12f 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -493,3 +493,4 @@
 561	common	cachestat			sys_cachestat
 562	common	fchmodat2			sys_fchmodat2
 563	common	futex_wake			sys_futex_wake
+564	common	futex_wait			sys_futex_wait
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 714abeb..a6cf562 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -467,3 +467,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 63a8a9c..f33190f 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -39,7 +39,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		455
+#define __NR_compat_syscalls		456
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 6897468..6e7d372 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -913,6 +913,8 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 #define __NR_futex_wake 454
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 455
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index cd50247..4043f0c 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -374,3 +374,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 21eb35c..2484167 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -453,3 +453,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 3a4e851..f03927a 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -459,3 +459,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 6883ea3..dbb5edf 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -392,3 +392,4 @@
 451	n32	cachestat			sys_cachestat
 452	n32	fchmodat2			sys_fchmodat2
 454	n32	futex_wake			sys_futex_wake
+455	n32	futex_wait			sys_futex_wait
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 48bc0fb..faff8df 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -368,3 +368,4 @@
 451	n64	cachestat			sys_cachestat
 452	n64	fchmodat2			sys_fchmodat2
 454	n64	futex_wake			sys_futex_wake
+455	n64	futex_wait			sys_futex_wait
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index a92625f..542f756 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -441,3 +441,4 @@
 451	o32	cachestat			sys_cachestat
 452	o32	fchmodat2			sys_fchmodat2
 454	o32	futex_wake			sys_futex_wake
+455	o32	futex_wait			sys_futex_wait
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 57faa97..8e50e89 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -452,3 +452,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index e6c6ed6..ad33a99 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -540,3 +540,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 7547201..418853f 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 451  common	cachestat		sys_cachestat			sys_cachestat
 452  common	fchmodat2		sys_fchmodat2			sys_fchmodat2
 454  common	futex_wake		sys_futex_wake			sys_futex_wake
+455  common	futex_wait		sys_futex_wait			sys_futex_wait
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 902a997..8ef9557 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -456,3 +456,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8a1f887..df59a9d 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -499,3 +499,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 9e81323..0f66168 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -458,3 +458,4 @@
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
 454	i386	futex_wake		sys_futex_wake
+455	i386	futex_wait		sys_futex_wait
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index d10a600..ddf6288 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -376,6 +376,7 @@
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
 454	common	futex_wake		sys_futex_wake
+455	common	futex_wait		sys_futex_wait
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 4e511bf..ac278db 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -424,3 +424,4 @@
 451	common	cachestat			sys_cachestat
 452	common	fchmodat2			sys_fchmodat2
 454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e174ed8..11f3fdd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -552,6 +552,10 @@ asmlinkage long sys_futex_waitv(struct futex_waitv *waiters,
 
 asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long mask, int nr, unsigned int flags);
 
+asmlinkage long sys_futex_wait(void __user *uaddr, unsigned long val, unsigned long mask,
+			       unsigned int flags, struct __kernel_timespec __user *timespec,
+			       clockid_t clockid);
+
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
 asmlinkage long sys_nanosleep_time32(struct old_timespec32 __user *rqtp,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f5454e6..f6553bd 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -824,9 +824,11 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 #define __NR_futex_wake 454
 __SYSCALL(__NR_futex_wake, sys_futex_wake)
+#define __NR_futex_wait 455
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
 
 #undef __NR_syscalls
-#define __NR_syscalls 455
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 0e7821a..e74888a 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -332,6 +332,9 @@ extern int futex_requeue(u32 __user *uaddr1, unsigned int flags,
 			 u32 __user *uaddr2, int nr_wake, int nr_requeue,
 			 u32 *cmpval, int requeue_pi);
 
+extern int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+			struct hrtimer_sleeper *to, u32 bitset);
+
 extern int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		      ktime_t *abs_time, u32 bitset);
 
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 4739892..e4c8ec7 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -221,6 +221,46 @@ static int futex_parse_waitv(struct futex_vector *futexv,
 	return 0;
 }
 
+static int futex2_setup_timeout(struct __kernel_timespec __user *timeout,
+				clockid_t clockid, struct hrtimer_sleeper *to)
+{
+	int flag_clkid = 0, flag_init = 0;
+	struct timespec64 ts;
+	ktime_t time;
+	int ret;
+
+	if (!timeout)
+		return 0;
+
+	if (clockid == CLOCK_REALTIME) {
+		flag_clkid = FLAGS_CLOCKRT;
+		flag_init = FUTEX_CLOCK_REALTIME;
+	}
+
+	if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC)
+		return -EINVAL;
+
+	if (get_timespec64(&ts, timeout))
+		return -EFAULT;
+
+	/*
+	 * Since there's no opcode for futex_waitv, use
+	 * FUTEX_WAIT_BITSET that uses absolute timeout as well
+	 */
+	ret = futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
+	if (ret)
+		return ret;
+
+	futex_setup_timer(&time, to, flag_clkid, 0);
+	return 0;
+}
+
+static inline void futex2_destroy_timeout(struct hrtimer_sleeper *to)
+{
+	hrtimer_cancel(&to->timer);
+	destroy_hrtimer_on_stack(&to->timer);
+}
+
 /**
  * sys_futex_waitv - Wait on a list of futexes
  * @waiters:    List of futexes to wait on
@@ -250,8 +290,6 @@ SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
 {
 	struct hrtimer_sleeper to;
 	struct futex_vector *futexv;
-	struct timespec64 ts;
-	ktime_t time;
 	int ret;
 
 	/* This syscall supports no flags for now */
@@ -261,30 +299,8 @@ SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
 	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
 		return -EINVAL;
 
-	if (timeout) {
-		int flag_clkid = 0, flag_init = 0;
-
-		if (clockid == CLOCK_REALTIME) {
-			flag_clkid = FLAGS_CLOCKRT;
-			flag_init = FUTEX_CLOCK_REALTIME;
-		}
-
-		if (clockid != CLOCK_REALTIME && clockid != CLOCK_MONOTONIC)
-			return -EINVAL;
-
-		if (get_timespec64(&ts, timeout))
-			return -EFAULT;
-
-		/*
-		 * Since there's no opcode for futex_waitv, use
-		 * FUTEX_WAIT_BITSET that uses absolute timeout as well
-		 */
-		ret = futex_init_timeout(FUTEX_WAIT_BITSET, flag_init, &ts, &time);
-		if (ret)
-			return ret;
-
-		futex_setup_timer(&time, &to, flag_clkid, 0);
-	}
+	if (timeout && (ret = futex2_setup_timeout(timeout, clockid, &to)))
+		return ret;
 
 	futexv = kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
 	if (!futexv) {
@@ -299,10 +315,8 @@ SYSCALL_DEFINE5(futex_waitv, struct futex_waitv __user *, waiters,
 	kfree(futexv);
 
 destroy_timer:
-	if (timeout) {
-		hrtimer_cancel(&to.timer);
-		destroy_hrtimer_on_stack(&to.timer);
-	}
+	if (timeout)
+		futex2_destroy_timeout(&to);
 	return ret;
 }
 
@@ -336,6 +350,52 @@ SYSCALL_DEFINE4(futex_wake,
 	return futex_wake(uaddr, FLAGS_STRICT | flags, nr, mask);
 }
 
+/*
+ * sys_futex_wait - Wait on a futex
+ * @uaddr:	Address of the futex to wait on
+ * @val:	Value of @uaddr
+ * @mask:	bitmask
+ * @flags:	FUTEX2 flags
+ * @timeout:	Optional absolute timeout
+ * @clockid:	Clock to be used for the timeout, realtime or monotonic
+ *
+ * Identical to the traditional FUTEX_WAIT_BITSET op, except it is part of the
+ * futex2 familiy of calls.
+ */
+
+SYSCALL_DEFINE6(futex_wait,
+		void __user *, uaddr,
+		unsigned long, val,
+		unsigned long, mask,
+		unsigned int, flags,
+		struct __kernel_timespec __user *, timeout,
+		clockid_t, clockid)
+{
+	struct hrtimer_sleeper to;
+	int ret;
+
+	if (flags & ~FUTEX2_VALID_MASK)
+		return -EINVAL;
+
+	flags = futex2_to_flags(flags);
+	if (!futex_flags_valid(flags))
+		return -EINVAL;
+
+	if (!futex_validate_input(flags, val) ||
+	    !futex_validate_input(flags, mask))
+		return -EINVAL;
+
+	if (timeout && (ret = futex2_setup_timeout(timeout, clockid, &to)))
+		return ret;
+
+	ret = __futex_wait(uaddr, flags, val, timeout ? &to : NULL, mask);
+
+	if (timeout)
+		futex2_destroy_timeout(&to);
+
+	return ret;
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE2(set_robust_list,
 		struct compat_robust_list_head __user *, head,
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index ceb05b8..b109a08 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -632,20 +632,18 @@ retry_private:
 	return ret;
 }
 
-int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
+int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
+		 struct hrtimer_sleeper *to, u32 bitset)
 {
-	struct hrtimer_sleeper timeout, *to;
-	struct restart_block *restart;
-	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
+	struct futex_hash_bucket *hb;
 	int ret;
 
 	if (!bitset)
 		return -EINVAL;
+
 	q.bitset = bitset;
 
-	to = futex_setup_timer(abs_time, &timeout, flags,
-			       current->timer_slack_ns);
 retry:
 	/*
 	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
@@ -653,18 +651,17 @@ retry:
 	 */
 	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
-		goto out;
+		return ret;
 
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
 	futex_wait_queue(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
-	ret = 0;
 	if (!futex_unqueue(&q))
-		goto out;
-	ret = -ETIMEDOUT;
+		return 0;
+
 	if (to && !to->task)
-		goto out;
+		return -ETIMEDOUT;
 
 	/*
 	 * We expect signal_pending(current), but we might be the
@@ -673,24 +670,38 @@ retry:
 	if (!signal_pending(current))
 		goto retry;
 
-	ret = -ERESTARTSYS;
-	if (!abs_time)
-		goto out;
+	return -ERESTARTSYS;
+}
 
-	restart = &current->restart_block;
-	restart->futex.uaddr = uaddr;
-	restart->futex.val = val;
-	restart->futex.time = *abs_time;
-	restart->futex.bitset = bitset;
-	restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
+int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val, ktime_t *abs_time, u32 bitset)
+{
+	struct hrtimer_sleeper timeout, *to;
+	struct restart_block *restart;
+	int ret;
+
+	to = futex_setup_timer(abs_time, &timeout, flags,
+			       current->timer_slack_ns);
+
+	ret = __futex_wait(uaddr, flags, val, to, bitset);
+
+	/* No timeout, nothing to clean up. */
+	if (!to)
+		return ret;
+
+	hrtimer_cancel(&to->timer);
+	destroy_hrtimer_on_stack(&to->timer);
 
-	ret = set_restart_fn(restart, futex_wait_restart);
+	if (ret == -ERESTARTSYS) {
+		restart = &current->restart_block;
+		restart->futex.uaddr = uaddr;
+		restart->futex.val = val;
+		restart->futex.time = *abs_time;
+		restart->futex.bitset = bitset;
+		restart->futex.flags = flags | FLAGS_HAS_TIMEOUT;
 
-out:
-	if (to) {
-		hrtimer_cancel(&to->timer);
-		destroy_hrtimer_on_stack(&to->timer);
+		return set_restart_fn(restart, futex_wait_restart);
 	}
+
 	return ret;
 }
 
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 983c058..13df391 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -88,6 +88,7 @@ COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 COND_SYSCALL(futex_waitv);
 COND_SYSCALL(futex_wake);
+COND_SYSCALL(futex_wait);
 COND_SYSCALL(kexec_load);
 COND_SYSCALL_COMPAT(kexec_load);
 COND_SYSCALL(init_module);
