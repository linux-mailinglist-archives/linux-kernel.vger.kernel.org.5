Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA6D7F171E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjKTPSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbjKTPSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:18:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F843185
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700493479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=A74GiK3pLF9MwoaCywVmBYx44DDglPqYJJKFyxUlFJ4=;
        b=NdU739Iod9CkPNu+uDd/NQTvbLKk3zZtM9r96+i6UWJkL5aTvjh/J7nedZ5YGpepnaRwfM
        YQvAdVNBDAoisrFXzhS61cprxDYpyzucA1O5pIPSdM0qpJfJEJS0T3TGhV8xZMEr5IblVR
        UtUqWmZst9N4gmb4idM8YenK18h8/n8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-7D_F4OmXPqi3g3S5WM-iHw-1; Mon,
 20 Nov 2023 10:17:57 -0500
X-MC-Unique: 7D_F4OmXPqi3g3S5WM-iHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0A672818743;
        Mon, 20 Nov 2023 15:17:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.3])
        by smtp.corp.redhat.com (Postfix) with SMTP id BB4E71121309;
        Mon, 20 Nov 2023 15:17:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 20 Nov 2023 16:16:51 +0100 (CET)
Date:   Mon, 20 Nov 2023 16:16:49 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] simplify force_sig_info_to_task(), kill
 recalc_sigpending_and_wake()
Message-ID: <20231120151649.GA15995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of recalc_sigpending_and_wake() is not clear, it looks
"obviously unneeded" because we are going to send the signal which
can't be blocked or ignored.

Add the comment to explain why we can't rely on send_signal_locked()
and make this logic more simple/explicit. recalc_sigpending_and_wake()
has no other users, it can die.

In fact I think we don't even need signal_wake_up(), the target task
must be either current or a TASK_TRACED child, otherwise the usage of
siglock is not safe. But this needs another change.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/signal.h |  1 -
 kernel/signal.c              | 17 ++++-------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 134a2c0bc283..c1452225fb2e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -441,7 +441,6 @@ static inline bool fault_signal_pending(vm_fault_t fault_flags,
  * This is required every time the blocked sigset_t changes.
  * callers must hold sighand->siglock.
  */
-extern void recalc_sigpending_and_wake(struct task_struct *t);
 extern void recalc_sigpending(void);
 extern void calculate_sigpending(void);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index f5781a54d89d..fb3f5568ab52 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -171,16 +171,6 @@ static bool recalc_sigpending_tsk(struct task_struct *t)
 	return false;
 }
 
-/*
- * After recalculating TIF_SIGPENDING, we need to make sure the task wakes up.
- * This is superfluous when called on current, the wakeup is a harmless no-op.
- */
-void recalc_sigpending_and_wake(struct task_struct *t)
-{
-	if (recalc_sigpending_tsk(t))
-		signal_wake_up(t, 0);
-}
-
 void recalc_sigpending(void)
 {
 	if (!recalc_sigpending_tsk(current) && !freezing(current))
@@ -1348,10 +1338,8 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 		action->sa.sa_handler = SIG_DFL;
 		if (handler == HANDLER_EXIT)
 			action->sa.sa_flags |= SA_IMMUTABLE;
-		if (blocked) {
+		if (blocked)
 			sigdelset(&t->blocked, sig);
-			recalc_sigpending_and_wake(t);
-		}
 	}
 	/*
 	 * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won't expect
@@ -1361,6 +1349,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	    (!t->ptrace || (handler == HANDLER_EXIT)))
 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
 	ret = send_signal_locked(sig, info, t, PIDTYPE_PID);
+	/* This can happen if the signal was already pending and blocked */
+	if (!task_sigpending(t))
+		signal_wake_up(t, 0);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
 	return ret;
-- 
2.25.1.362.g51ebf55


