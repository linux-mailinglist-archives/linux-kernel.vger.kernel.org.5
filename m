Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7F1756395
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGQM5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjGQM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:57:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C21A172B;
        Mon, 17 Jul 2023 05:57:06 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WIJ3Or8r4OlS0GbeJKE8K6YEjt2+zA+MGlHC92BRus=;
        b=sfp13YX9jNMpOZqF1/8aS+TWoS/7ZwamiLBUwFnqpIlvwXpt56yn3sWR9GByEFGcT/NaH0
        IdjD5xAPcDfTdVAZfd7D9T/484R4LsqiEp/HndDhBo9yl3sggf32b1Vbt4+cYdF6rtEEpv
        ozjwnz411otmbmGmNF8a1VTCAD5AV3bU1sgf8KZvtGMTsgrFl/wz+JC3E4d8Iu3JpSlhM/
        qvmkb9Vex4NotSKWb18JDLky0QioCHtDvN4qEhASzX9gTu/pAuE6890VFAhLLwVVNT0sfI
        XzbWso8OtgEPen3IJ8VTNjLTlwE2iy611ZikOiqG778ukNN7kK14ca5se2oBjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598576;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WIJ3Or8r4OlS0GbeJKE8K6YEjt2+zA+MGlHC92BRus=;
        b=HWOWsM2n/rj/mb0Ts6BNh8fQhaNtGM64BEiVjV0YgdWr09eUsyTkao0jNPA9WheZL4BBnb
        yWZd2Jk/t/rQzhBA==
From:   "tip-bot2 for Wander Lairson Costa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: avoid false lockdep splat in put_task_struct()
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Wander Lairson Costa <wander@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230614122323.37957-3-wander@redhat.com>
References: <20230614122323.37957-3-wander@redhat.com>
MIME-Version: 1.0
Message-ID: <168959857602.28540.13321675030770111879.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     893cdaaa3977be6afb3a7f756fbfd7be83f68d8c
Gitweb:        https://git.kernel.org/tip/893cdaaa3977be6afb3a7f756fbfd7be83f68d8c
Author:        Wander Lairson Costa <wander@redhat.com>
AuthorDate:    Wed, 14 Jun 2023 09:23:22 -03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:48 +02:00

sched: avoid false lockdep splat in put_task_struct()

In put_task_struct(), a spin_lock is indirectly acquired under the kernel
stock. When running the kernel in real-time (RT) configuration, the
operation is dispatched to a preemptible context call to ensure
guaranteed preemption. However, if PROVE_RAW_LOCK_NESTING is enabled
and __put_task_struct() is called while holding a raw_spinlock, lockdep
incorrectly reports an "Invalid lock context" in the stock kernel.

This false splat occurs because lockdep is unaware of the different
route taken under RT. To address this issue, override the inner wait
type to prevent the false lockdep splat.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230614122323.37957-3-wander@redhat.com
---
 include/linux/sched/task.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 6b687c1..a23af22 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -126,6 +126,19 @@ static inline void put_task_struct(struct task_struct *t)
 		return;
 
 	/*
+	 * In !RT, it is always safe to call __put_task_struct().
+	 * Under RT, we can only call it in preemptible context.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
+
+		lock_map_acquire_try(&put_task_map);
+		__put_task_struct(t);
+		lock_map_release(&put_task_map);
+		return;
+	}
+
+	/*
 	 * under PREEMPT_RT, we can't call put_task_struct
 	 * in atomic context because it will indirectly
 	 * acquire sleeping locks.
@@ -145,10 +158,7 @@ static inline void put_task_struct(struct task_struct *t)
 	 * when it fails to fork a process. Therefore, there is no
 	 * way it can conflict with put_task_struct().
 	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
-		call_rcu(&t->rcu, __put_task_struct_rcu_cb);
-	else
-		__put_task_struct(t);
+	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
 }
 
 DEFINE_FREE(put_task, struct task_struct *, if (_T) put_task_struct(_T))
