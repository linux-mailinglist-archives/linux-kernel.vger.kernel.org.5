Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A157A6C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjISURA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjISUQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:16:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F9BE;
        Tue, 19 Sep 2023 13:16:52 -0700 (PDT)
Date:   Tue, 19 Sep 2023 20:16:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695154611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlQH9ja3AEV3lasY1kCndebMW6lqw5qt1mFUHrGN+1Y=;
        b=li6L72f2fQX26rC+LLqd3qQYmvaMQXquaR7HdSc6PSJ6SWvAt/Apk0u3Yq5boRwPxAQKoP
        Jb+y9ufjY4B1VJ7nGjYK3zVf3DFd0sanhaG6ldJWvu/uGMdNicV0EBs+Qv2OFVPkj+cwYM
        BZKtaUkkGrTszGUp9kLZN37IU1kn1EgmagwmxEoqGtvZhAC8T7HO+HlRlHFlSStJpmYGSL
        WK50s/uBXHcd8ExD4+TRM7Ir6nfK9ceUnwJ3AlDN3Ske7TxNsd04lkgMx0waMXU6gVjC2t
        EHCCm+yyjT1NvcDgMiUOnZ1h7WPa3tqCFEMfO1oH8VipPfe8nA1O1YlzBeayRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695154611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlQH9ja3AEV3lasY1kCndebMW6lqw5qt1mFUHrGN+1Y=;
        b=/rZYYYjIEjYrsntPkT9plYrK0FqUckWiiDUYYkfIywmbC49T3458I1aptGSIWxbGRREdQe
        /2AwnMpkSDlXREDw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] signal: Don't disable preemption in ptrace_stop() on
 PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230803100932.325870-3-bigeasy@linutronix.de>
References: <20230803100932.325870-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <169515461053.27769.8949434164650886984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/core branch of tip:

Commit-ID:     1aabbc532413ced293952f8e149ad0a607d6e470
Gitweb:        https://git.kernel.org/tip/1aabbc532413ced293952f8e149ad0a607d6e470
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 03 Aug 2023 12:09:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 Sep 2023 22:08:29 +02:00

signal: Don't disable preemption in ptrace_stop() on PREEMPT_RT

On PREEMPT_RT keeping preemption disabled during the invocation of
cgroup_enter_frozen() is a problem because the function acquires
css_set_lock which is a sleeping lock on PREEMPT_RT and must not be
acquired with disabled preemption.

The preempt-disabled section is only for performance optimisation reasons
and can be avoided.

Extend the comment and don't disable preemption before scheduling on
PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20230803100932.325870-3-bigeasy@linutronix.de

---
 kernel/signal.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 3035beb..f2a5578 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2345,11 +2345,22 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * will be no preemption between unlock and schedule() and so
 	 * improving the performance since the ptracer will observe that
 	 * the tracee is scheduled out once it gets on the CPU.
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
 
