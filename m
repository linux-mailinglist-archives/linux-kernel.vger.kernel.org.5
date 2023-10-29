Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9C87DAE9A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJ2Vda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjJ2Vd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:33:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FDBC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:33:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698615204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=03b+M3ovvoAn9/IVDghYwfyRcYqQRt2WvXYoyE2rXIQ=;
        b=N9qxvrQfUflXt41gKJHHciPiitsitxiJiGvrMCHLX6GOgRiu/LBeMaHNPSnpbCpAafxt3/
        +fCevGoMwZe3Rc+GAfORRouHG+Tlyr5GDGpM51pLphg87EkRSy4lreXMaeYwxg8Sh2ndV+
        1MLyp3rYmMNTH2aodLIIf9uIUOsA+CAU+dn8m3pc6Snzuqf6U3xH13iGBYPSkYNvflxwnm
        ZdoPNXN3Fs2XcU4Rl1GfGkjHGMnGnBwMkmXycPt5kCKX5JCp8Qrqc2JPeMQyJbnayQLQab
        zFp786ptOpjorgJk0of5uO+0a1Dw8rJntDz1wfGrHFOvMBxju/pAgu4Syr76NA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698615204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=03b+M3ovvoAn9/IVDghYwfyRcYqQRt2WvXYoyE2rXIQ=;
        b=NlanTSqcxIYUgdDgKgreKMkIq/0efAYuFyGyBLS83n4Tfi+3Y8hx84WhUEIkofp2Nc6guJ
        0kZG2k9UEET216Dg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/core for v6.7-rc1
Message-ID: <169861500709.181063.7816209662289132093.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 29 Oct 2023 22:33:24 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-core-2023-1=
0-29-v2

up to:  1aabbc532413: signal: Don't disable preemption in ptrace_stop() on PR=
EEMPT_RT

Two small updates to ptrace_stop():

  - Add a comment to explain that the preempt_disable() before unlocking
    tasklist lock is not a correctness problem and just avoids the tracer
    to preempt the tracee before the tracee schedules out.

  - Make that preempt_disable() conditional on PREEMPT_RT=3Dn.

    RT enabled kernels cannot disable preemption at this point because
    cgroup_enter_frozen() and sched_submit_work() acquire spinlocks or
    rwlocks which are substituted by sleeping locks on RT. Acquiring a
    sleeping lock in a preemption disable region is obviously not possible.

    This obviously brings back the potential slowdown of ptrace() for RT
    enabled kernels, but that's a price to be payed for latency guarantees.

Thanks,

	tglx

------------------>
Sebastian Andrzej Siewior (2):
      signal: Add a proper comment about preempt_disable() in ptrace_stop()
      signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT


 kernel/signal.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 09019017d669..f2a5578326ad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2329,15 +2329,38 @@ static int ptrace_stop(int exit_code, int why, unsign=
ed long message,
 		do_notify_parent_cldstop(current, false, why);
=20
 	/*
-	 * Don't want to allow preemption here, because
-	 * sys_ptrace() needs this task to be inactive.
+	 * The previous do_notify_parent_cldstop() invocation woke ptracer.
+	 * One a PREEMPTION kernel this can result in preemption requirement
+	 * which will be fulfilled after read_unlock() and the ptracer will be
+	 * put on the CPU.
+	 * The ptracer is in wait_task_inactive(, __TASK_TRACED) waiting for
+	 * this task wait in schedule(). If this task gets preempted then it
+	 * remains enqueued on the runqueue. The ptracer will observe this and
+	 * then sleep for a delay of one HZ tick. In the meantime this task
+	 * gets scheduled, enters schedule() and will wait for the ptracer.
 	 *
-	 * XXX: implement read_unlock_no_resched().
+	 * This preemption point is not bad from a correctness point of
+	 * view but extends the runtime by one HZ tick time due to the
+	 * ptracer's sleep.  The preempt-disable section ensures that there
+	 * will be no preemption between unlock and schedule() and so
+	 * improving the performance since the ptracer will observe that
+	 * the tracee is scheduled out once it gets on the CPU.
+	 *
+	 * On PREEMPT_RT locking tasklist_lock does not disable preemption.
+	 * Therefore the task can be preempted after do_notify_parent_cldstop()
+	 * before unlocking tasklist_lock so there is no benefit in doing this.
+	 *
+	 * In fact disabling preemption is harmful on PREEMPT_RT because
+	 * the spinlock_t in cgroup_enter_frozen() must not be acquired
+	 * with preemption disabled due to the 'sleeping' spinlock
+	 * substitution of RT.
 	 */
-	preempt_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	read_unlock(&tasklist_lock);
 	cgroup_enter_frozen();
-	preempt_enable_no_resched();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable_no_resched();
 	schedule();
 	cgroup_leave_frozen(true);
=20

