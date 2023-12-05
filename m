Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7808055F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 14:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442246AbjLENaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 08:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442151AbjLENan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 08:30:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2D618C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 05:30:48 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5DMxFA014022;
        Tue, 5 Dec 2023 13:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e9OcvWXQrgehwaXmvt4tAvWEvIUngGRk7okHHuNXNu8=;
 b=USSGjNXGbVoQdlEof6nTQQ29zTg3rNY0xAfubxVONrDwUdQaKge9EwinfeHaTaqEjGT6
 UAKObtMQPmu8gFVLCUQURXc7I3EYHPRiF3JWSgcDdKroHciQvB2lRXYdRic/OWKxQ+zr
 6IQ5eVGQ8BWBXhf04meHw+62VT8uOC+qviCUEsQz5tlB/+Y0LmAlLwORGcmQY/kvrP6M
 J6uOK361lhlf7RUuGtYijPaqjRn/KCAidab/diS/4NiuUdD9zfutIQqKfrPe0luCvd3o
 O6NE1/G3e3ueSB6hC5q2/jXBzJgmLz8hOsqO90YDGdTaHzse8Q46h/5W/FY8WBpI+jMn 6w== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ut4pq8aym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B5Aw7r7026459;
        Tue, 5 Dec 2023 13:30:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8dukc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 13:30:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B5DUOOJ42861128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 13:30:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C55120040;
        Tue,  5 Dec 2023 13:30:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0068820043;
        Tue,  5 Dec 2023 13:30:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  5 Dec 2023 13:30:23 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B3ABEE12C5; Tue,  5 Dec 2023 14:30:23 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/3] entry: move exit to usermode functions to header file
Date:   Tue,  5 Dec 2023 14:30:13 +0100
Message-Id: <20231205133015.752543-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205133015.752543-1-svens@linux.ibm.com>
References: <20231205133015.752543-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ucp59YmbGAkSeOHjaR7tXYrrzrG5qNgr
X-Proofpoint-GUID: Ucp59YmbGAkSeOHjaR7tXYrrzrG5qNgr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_08,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 mlxlogscore=763 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312050105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow inlining, move exit_to_user_mode() and
exit_to_user_mode_loop() to common.h.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/linux/entry-common.h | 95 +++++++++++++++++++++++++++++++++++-
 kernel/entry/common.c        | 89 +--------------------------------
 2 files changed, 96 insertions(+), 88 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index d95ab85f96ba..f0f1a26dc638 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -7,6 +7,10 @@
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
 #include <linux/sched.h>
+#include <linux/context_tracking.h>
+#include <linux/livepatch.h>
+#include <linux/resume_user_mode.h>
+#include <linux/tick.h>
 
 #include <asm/entry-common.h>
 
@@ -258,6 +262,85 @@ static __always_inline void arch_exit_to_user_mode(void) { }
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
 
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ */
+static __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+							    unsigned long ti_work)
+{
+	/*
+	 * Before returning to user space ensure that all pending work
+	 * items have been completed.
+	 */
+	while (ti_work & EXIT_TO_USER_MODE_WORK) {
+
+		local_irq_enable_exit_to_user(ti_work);
+
+		if (ti_work & _TIF_NEED_RESCHED)
+			schedule();
+
+		if (ti_work & _TIF_UPROBE)
+			uprobe_notify_resume(regs);
+
+		if (ti_work & _TIF_PATCH_PENDING)
+			klp_update_patch_state(current);
+
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+			arch_do_signal_or_restart(regs);
+
+		if (ti_work & _TIF_NOTIFY_RESUME)
+			resume_user_mode_work(regs);
+
+		/* Architecture specific TIF work */
+		arch_exit_to_user_mode_work(regs, ti_work);
+
+		/*
+		 * Disable interrupts and reevaluate the work flags as they
+		 * might have changed while interrupts and preemption was
+		 * enabled above.
+		 */
+		local_irq_disable_exit_to_user();
+
+		/* Check if any of the above work has queued a deferred wakeup */
+		tick_nohz_user_enter_prepare();
+
+		ti_work = read_thread_flags();
+	}
+
+	/* Return the latest work state for arch_exit_to_user_mode() */
+	return ti_work;
+}
+
+/**
+ * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
+ *
+ * 1) check that interrupts are disabled
+ * 2) call tick_nohz_user_enter_prepare()
+ * 3) call exit_to_user_mode_loop() if any flags from
+ *    EXIT_TO_USER_MODE_WORK are set
+ * 4) check that interrupts are still disabled
+ */
+static __always_inline void exit_to_user_mode_prepare(struct pt_regs *regs)
+{
+	unsigned long ti_work;
+
+	lockdep_assert_irqs_disabled();
+
+	/* Flush pending rcuog wakeup before the last need_resched() check */
+	tick_nohz_user_enter_prepare();
+
+	ti_work = read_thread_flags();
+	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
+		ti_work = exit_to_user_mode_loop(regs, ti_work);
+
+	arch_exit_to_user_mode_prepare(regs, ti_work);
+
+	/* Ensure that kernel state is sane for a return to userspace */
+	kmap_assert_nomap();
+	lockdep_assert_irqs_disabled();
+	lockdep_sys_exit();
+}
+
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
  *
@@ -276,7 +359,17 @@ void arch_do_signal_or_restart(struct pt_regs *regs);
  * non-instrumentable.
  * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
-void exit_to_user_mode(void);
+static __always_inline void exit_to_user_mode(void)
+{
+	instrumentation_begin();
+	trace_hardirqs_on_prepare();
+	lockdep_hardirqs_on_prepare();
+	instrumentation_end();
+
+	user_enter_irqoff();
+	arch_exit_to_user_mode();
+	lockdep_hardirqs_on(CALLER_ADDR0);
+}
 
 /**
  * syscall_exit_to_user_mode_work - Handle work before returning to user mode
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index d7ee4bc3f2ba..6ba2bcfbe32c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -123,94 +123,9 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/* See comment for exit_to_user_mode() in entry-common.h */
-static __always_inline void __exit_to_user_mode(void)
-{
-	instrumentation_begin();
-	trace_hardirqs_on_prepare();
-	lockdep_hardirqs_on_prepare();
-	instrumentation_end();
-
-	user_enter_irqoff();
-	arch_exit_to_user_mode();
-	lockdep_hardirqs_on(CALLER_ADDR0);
-}
-
-void noinstr exit_to_user_mode(void)
-{
-	__exit_to_user_mode();
-}
-
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-					    unsigned long ti_work)
-{
-	/*
-	 * Before returning to user space ensure that all pending work
-	 * items have been completed.
-	 */
-	while (ti_work & EXIT_TO_USER_MODE_WORK) {
-
-		local_irq_enable_exit_to_user(ti_work);
-
-		if (ti_work & _TIF_NEED_RESCHED)
-			schedule();
-
-		if (ti_work & _TIF_UPROBE)
-			uprobe_notify_resume(regs);
-
-		if (ti_work & _TIF_PATCH_PENDING)
-			klp_update_patch_state(current);
-
-		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-			arch_do_signal_or_restart(regs);
-
-		if (ti_work & _TIF_NOTIFY_RESUME)
-			resume_user_mode_work(regs);
-
-		/* Architecture specific TIF work */
-		arch_exit_to_user_mode_work(regs, ti_work);
-
-		/*
-		 * Disable interrupts and reevaluate the work flags as they
-		 * might have changed while interrupts and preemption was
-		 * enabled above.
-		 */
-		local_irq_disable_exit_to_user();
-
-		/* Check if any of the above work has queued a deferred wakeup */
-		tick_nohz_user_enter_prepare();
-
-		ti_work = read_thread_flags();
-	}
-
-	/* Return the latest work state for arch_exit_to_user_mode() */
-	return ti_work;
-}
-
-static void exit_to_user_mode_prepare(struct pt_regs *regs)
-{
-	unsigned long ti_work;
-
-	lockdep_assert_irqs_disabled();
-
-	/* Flush pending rcuog wakeup before the last need_resched() check */
-	tick_nohz_user_enter_prepare();
-
-	ti_work = read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work = exit_to_user_mode_loop(regs, ti_work);
-
-	arch_exit_to_user_mode_prepare(regs, ti_work);
-
-	/* Ensure that kernel state is sane for a return to userspace */
-	kmap_assert_nomap();
-	lockdep_assert_irqs_disabled();
-	lockdep_sys_exit();
-}
-
 /*
  * If SYSCALL_EMU is set, then the only reason to report is when
  * SINGLESTEP is set (i.e. PTRACE_SYSEMU_SINGLESTEP).  This syscall
@@ -295,7 +210,7 @@ __visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr void irqentry_enter_from_user_mode(struct pt_regs *regs)
@@ -308,7 +223,7 @@ noinstr void irqentry_exit_to_user_mode(struct pt_regs *regs)
 	instrumentation_begin();
 	exit_to_user_mode_prepare(regs);
 	instrumentation_end();
-	__exit_to_user_mode();
+	exit_to_user_mode();
 }
 
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
-- 
2.40.1

