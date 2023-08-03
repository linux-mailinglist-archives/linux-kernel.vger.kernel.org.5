Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0548376E540
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjHCKJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbjHCKJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:09:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562630C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:09:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691057379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ad7l9FuC31NWow/lJV/fHJBllejOmCcZbpiHniM7Z+Q=;
        b=0z/+vymvQCLuGHrgEYbwn4yxHyfod2bOGtQNIik0z+Le1Jb6oZOG210FzMcArEg3KDT/Hq
        /D97/1T4nvj7BV2nfReSEqchmhgf0MRz+/77xdXepfuSOI29b1LMOMdArFOtqLymFMJtzy
        GV/mPb5L50mF3rX8PZ2w0foqX8RRH2I5sK8E9PHSIgKadIhn3T+uivAe+/lDx6Sw8R+DfK
        4M6PagdTPuyNfKJmq0pCHg3zOc5amUHebL1+K8OMt8bLYulzLNvcP2oEJobKv6R72T/Eqf
        kAbYn7dY7NGtNth4NpKBV+AnLhs3u7qteXhcj6vdcCObwk7u+YYTWbBBHD+mnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691057379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ad7l9FuC31NWow/lJV/fHJBllejOmCcZbpiHniM7Z+Q=;
        b=Bq1865ba57I5cPKPyN55oWdYTG93v10BQXqtmYoFHViLrOqeBuNC/n90qZcI40QN0Q8EnW
        mc2ddc5kT/Z5p5Cw==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT.
Date:   Thu,  3 Aug 2023 12:09:32 +0200
Message-Id: <20230803100932.325870-3-bigeasy@linutronix.de>
In-Reply-To: <20230803100932.325870-1-bigeasy@linutronix.de>
References: <20230803100932.325870-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On PREEMPT_RT keeping preemption disabled during the invocation of
cgroup_enter_frozen() is a problem because the function acquires css_set_lo=
ck
which is a sleeping lock on PREEMPT_RT and must not be acquired with disabl=
ed
preemption.
The preempt-disabled section is only for performance optimisation
reasons and can be avoided.

Extend the comment and don't disable preemption before scheduling on
PREEMPT_RT.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2333,11 +2333,20 @@ static int ptrace_stop(int exit_code, in
 	 * The preempt-disable section ensures that there will be no preemption
 	 * between unlock and schedule() and so improving the performance since
 	 * the ptracer has no reason to sleep.
+	 *
+	 * On PREEMPT_RT locking tasklist_lock does not disable preemption.
+	 * Therefore the task can be preempted (after
+	 * do_notify_parent_cldstop()) before unlocking tasklist_lock so there
+	 * is no benefit in doing this. The optimisation is harmful on
+	 * PEEMPT_RT because the spinlock_t (in cgroup_enter_frozen()) must not
+	 * be acquired with disabled preemption.
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
