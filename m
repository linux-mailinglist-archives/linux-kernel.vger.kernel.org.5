Return-Path: <linux-kernel+bounces-112742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA102887DB5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B9A2813EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B0D225AD;
	Sun, 24 Mar 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZPIVBob"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF836224F5;
	Sun, 24 Mar 2024 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299968; cv=none; b=sRGW2A8TnHmG+j0OqGNfFQumMi7Nhculy1csHpbX2h3sa5Cs2N04Lq2n9qeIvqQBmSZJ5RZKm3gqNrmBirLGC9PlOhRhJH+CADd9nQag4+NSJpaIT/zpM8tc5cUlf6hiOhR2bqqyiAtgEX3UY0qj6Y/cpoOlA5mi474uY0lWZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299968; c=relaxed/simple;
	bh=8zZ5sjJpy7HDFdym5rsFWFQr8cLRIK2S91wSo8lhCz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaP4lYcTNE0HQq6aAlrjxi4eHje7Mr007DbM5UJ/f3Q9ebGBidFu7igGxVVVd7iu3al+0YDFkjhmo6g0ctKTooVffNKswssYHXXOkYZDgLu3zgtc35U/HAji7+w3U0Mn2dyh0+A5wxtelk+y5lgueW1iG0UYL0vs1S2Q5wlNoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZPIVBob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8626C433C7;
	Sun, 24 Mar 2024 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299968;
	bh=8zZ5sjJpy7HDFdym5rsFWFQr8cLRIK2S91wSo8lhCz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZPIVBobtQP5SHOAD5x2EGo1o4DZinOGJ1MJ40BFj9kpBL9QRz/z4GOKQP6Im2ua8
	 2vP2RxcRzn9ByIbCxwtvjowYm+tIg3xfSwptHXoEw87nDwdVXEumI3eH0LGjUYRzrW
	 x2+eYFoZIX8i2Q27W43152osWUriudG18lSbToa7iMjSFSsjEwujgn2Kkg+ZEezQwN
	 Al59wBksIE7G127uxcLrXMy3UJWzkhcYxKKKnwIrpvCE6ag35/wLRhC+kbPJesjJib
	 xEru5SfaSbBUqUGd8VQsoOXKIyhtF+N07MO+325fM1GOEJlg09UdtlmGbdhVvHSWzJ
	 H5z19n9KKA/Fg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	frederic@kernel.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 07/11] rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
Date: Sun, 24 Mar 2024 13:05:42 -0400
Message-ID: <20240324170552.545730-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170552.545730-1-sashal@kernel.org>
References: <20240324170552.545730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.1
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 0bb11a372fc8d7006b4d0f42a2882939747bdbff ]

The current code will scan the entirety of each per-CPU list of exiting
tasks in ->rtp_exit_list with interrupts disabled.  This is normally just
fine, because each CPU typically won't have very many tasks in this state.
However, if a large number of tasks block late in do_exit(), these lists
could be arbitrarily long.  Low probability, perhaps, but it really
could happen.

This commit therefore occasionally re-enables interrupts while traversing
these lists, inserting a dummy element to hold the current place in the
list.  In kernels built with CONFIG_PREEMPT_RT=y, this re-enabling happens
after each list element is processed, otherwise every one-to-two jiffies.

[ paulmck: Apply Frederic Weisbecker feedback. ]

Link: https://lore.kernel.org/all/ZdeI_-RfdLR8jlsm@localhost.localdomain/

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tasks.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 4dc355b2ac229..7e05edf144225 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -971,13 +971,33 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	 */
 
 	for_each_possible_cpu(cpu) {
+		unsigned long j = jiffies + 1;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
 		struct task_struct *t;
+		struct task_struct *t1;
+		struct list_head tmp;
 
 		raw_spin_lock_irq_rcu_node(rtpcp);
-		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
+		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
 			if (list_empty(&t->rcu_tasks_holdout_list))
 				rcu_tasks_pertask(t, hop);
+
+			// RT kernels need frequent pauses, otherwise
+			// pause at least once per pair of jiffies.
+			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
+				continue;
+
+			// Keep our place in the list while pausing.
+			// Nothing else traverses this list, so adding a
+			// bare list_head is OK.
+			list_add(&tmp, &t->rcu_tasks_exit_list);
+			raw_spin_unlock_irq_rcu_node(rtpcp);
+			cond_resched(); // For CONFIG_PREEMPT=n kernels
+			raw_spin_lock_irq_rcu_node(rtpcp);
+			t1 = list_entry(tmp.next, struct task_struct, rcu_tasks_exit_list);
+			list_del(&tmp);
+			j = jiffies + 1;
+		}
 		raw_spin_unlock_irq_rcu_node(rtpcp);
 	}
 
-- 
2.43.0


