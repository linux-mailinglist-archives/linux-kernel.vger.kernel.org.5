Return-Path: <linux-kernel+bounces-112753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5BB887DCD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E23280C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00863D967;
	Sun, 24 Mar 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVOzQ/NT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C56A3D56B;
	Sun, 24 Mar 2024 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299995; cv=none; b=G3o/dtWS4zy24OCiApfykAon+zG0gvkHlHnhoYOaWoLzswyo5NhgVAsmakrdsJPgo4/9Z3wQR5w/fSdObtPL51OFHKQrxksQ+pwJ9iEk0U7UF+AmMlsJY5nwSr8hop3EwkSttOWbOkPqxVya21ZLNnokQdNLvSItCgR9F9xNGzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299995; c=relaxed/simple;
	bh=C13to/SVjuiO3F1cwxceJ1FGgcColPtf+/Pi7A6bgcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAjnW+zhYc/5htOx6oanOeCTlgUbviXFrG6tSphiZ4q8a64p5METpBIxu2NmdmZ45VaKWkFYB4nQXses1GhH8385LMvkwK/WPn8RJR5h05HJrp/mkwa9Hh/AoEW1JpKtywHNqKuzK36pYKH+P4JtZ0Da1Z/PLGkAwKS42Z6fs04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVOzQ/NT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309B6C43390;
	Sun, 24 Mar 2024 17:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299994;
	bh=C13to/SVjuiO3F1cwxceJ1FGgcColPtf+/Pi7A6bgcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVOzQ/NT89FdUzA0jesKZo+iPubuxf5uiPP5q7W1qeMIFREqCcnil0wX5DYPakd09
	 RChUIAlf87vD5R1dxhJEhCOv4SRBhL6jpxiF+jytUZGx/SgaZ7U/GmmF6KotSQkdFB
	 3dXdUsuPyYzLWXoFOtWJEV1qMhABM3wIruW7t2MEg+u1zxgRrJnA8HCe/+fKJ1m32n
	 ig2QqqY5A5wYgk96lNJXMOz0+AhRsC4tcVzKNtmu9+fAUCxQXlFHOU1UI+EH4sEOOm
	 RqklhxTNmsITbDMdAFEfyPfuANOjcDCp8pI0kGOPvwtIwlAyJM9iZiN4idd2AVFoBF
	 5wEZgOJHRWubg==
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
Subject: [PATCH AUTOSEL 6.7 07/11] rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
Date: Sun, 24 Mar 2024 13:06:10 -0400
Message-ID: <20240324170619.545975-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170619.545975-1-sashal@kernel.org>
References: <20240324170619.545975-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.10
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
index 774408899e715..4af68107544d3 100644
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


