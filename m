Return-Path: <linux-kernel+bounces-112765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C8887DE6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C701F210B8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B0150A75;
	Sun, 24 Mar 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHpTdsjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366441E4AA;
	Sun, 24 Mar 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711300021; cv=none; b=JSczzvVejGVudtiXj4yoFqLPVelTAr8v+IV6s5O0VDEcZLLQu8DKQD87NZiLS6g0XT9g5JP542hGxJNpmowLwyv1y/dhNUfDHBUf/LEDnOG889ElcOPA7rPFI71yIUNygB0z1kVMYMZddCUk+n7YwQcOWZzk6wDxKnUYbWNXp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711300021; c=relaxed/simple;
	bh=arNhS05/+OfLEN7T1cOmaqzxIW9GP7B1pr5xKf8yKfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TQo4dOG1eD/7qOt6O4XV4IWXrGy4552H2CoyJhcJZLpikROe1tSPaXszYKNz/ODY+P3TF7figt7zGOJk1bqHcwT/boVhbhtHRAJjahV0XjCWHc5cJBE+dPxBcZE4DxMVYzcc+jJuv7SwfKV0KXs8+sm77uzCFfYKbuKc8CnI+88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHpTdsjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F22C433F1;
	Sun, 24 Mar 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711300020;
	bh=arNhS05/+OfLEN7T1cOmaqzxIW9GP7B1pr5xKf8yKfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tHpTdsjLwNDEWJbqaelpxHecKEJB0/thQ0ftbupoa3NoIpw39B/nN/d7G297Tyfkb
	 7dgxrFyUbZHWeSetHWGY9H8aPfCSMymAZu0Wx0w/jLKMuStufTe1oeaj7tXFA24wIF
	 5suyNypcbZYBP1zlGEfAMuP4vfByNOUCprs2X0PWXHZ5D2xPQULRibXtW0W9SpaZrk
	 FU/cDDQEWuuRSTnr+Ns87fs9ZY4i/BnDq9VqZ6HDEW1qLXSX3nkENc8FDHLz257PRd
	 UMpVRtM28ur8nAft5tf/RITUWq4QpY2MhCTopoXsaNQpwW+Nr8XjKtn/tKSMx844Af
	 EIEodO4fQXmWA==
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
Subject: [PATCH AUTOSEL 6.6 07/11] rcu-tasks: Maintain real-time response in rcu_tasks_postscan()
Date: Sun, 24 Mar 2024 13:06:37 -0400
Message-ID: <20240324170645.546220-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324170645.546220-1-sashal@kernel.org>
References: <20240324170645.546220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.22
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
index e8b72954ee106..c4ab26e77c8fa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -968,13 +968,33 @@ static void rcu_tasks_postscan(struct list_head *hop)
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


