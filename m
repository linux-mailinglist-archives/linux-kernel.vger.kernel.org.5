Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DE476E542
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbjHCKJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjHCKJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:09:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D600D30FD
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:09:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691057378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpjoDTQpFQHCdfIIfIOuJHC3wPs+6uNYjZf1fx8U6Tw=;
        b=SKNtVp0PYSCMMWIY+YYI0/rEZDFa7CZ1GkKHbTz+l6xNZsH6LGrAbdeTwLinBIEpNiZX5m
        ci4HrcSp6fFzYwPmLZ+tihX+zykBYtopjxp0DjRcseEBcb7t2OvIEvM81GdqBiUal64qWh
        Z4bLcqOU1+DldRbE96DIN6qvDbgRYxgISUNNvl9ypQ4bgwh1DBKNGE4yKS+fak1Dcz9l0D
        7D++X2llN3febj4r/iXA+E1vM3odoUsv8xSDJZx3RaLdfKsdV8rtj1Se2ibUhGmg4NUZEe
        sPBFWRhOj0zzdqyWEYhQ2gfRziw2T9tQd6XAgtHaGPykTFMIipP1AszkqmPGww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691057378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qpjoDTQpFQHCdfIIfIOuJHC3wPs+6uNYjZf1fx8U6Tw=;
        b=+2bXTdvUtuFxSFiHu5U1NZAqrLZ+PCmxVtQrWhgnSeFRFbh76UH9GTFiD4hVl16SJgL5gU
        evxUBWyz9ClA6oBA==
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] signal: Add proper comment about the preempt-disable in ptrace_stop().
Date:   Thu,  3 Aug 2023 12:09:31 +0200
Message-Id: <20230803100932.325870-2-bigeasy@linutronix.de>
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

Commit 53da1d9456fe7 ("fix ptrace slowness") added a preempt-disable section
between read_unlock() and the following schedule() invocation without
explaining why it is needed.

Replace the comment with an explanation why this is needed. Clarify that
it is needed for correctness but for performance reasons.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/signal.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2318,10 +2318,21 @@ static int ptrace_stop(int exit_code, in
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
+	 * This preemption point is not bad from correctness point of view but
+	 * extends the runtime by one HZ tick time due to the ptracer's sleep.
+	 * The preempt-disable section ensures that there will be no preemption
+	 * between unlock and schedule() and so improving the performance since
+	 * the ptracer has no reason to sleep.
 	 */
 	preempt_disable();
 	read_unlock(&tasklist_lock);
