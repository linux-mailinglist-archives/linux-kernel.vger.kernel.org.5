Return-Path: <linux-kernel+bounces-112749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C03887DC5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C227DB218F6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C03A8D8;
	Sun, 24 Mar 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbeF6xN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A6139FFA;
	Sun, 24 Mar 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299985; cv=none; b=EZ+0vEYQ4BVdL6nrfilswjxVqbYtq3kgUVp37H9v/m3UoN1wXDBZloC8wudcLFPEPZoRYncGHy77k8tOrGBjr07azlDy7S51HR5mp42CvvPfaQTKzPqKn/A+Jr0Z0RiuDMjuNAk4jB48yu0cvXFXHzfd9h9GIFycjoC6OP3GNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299985; c=relaxed/simple;
	bh=Ff/xTjGvpE3YHuaLbsD7nmrBqNTIVUTpWJloARUyFPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApUf57WbLaEHJhcQYZL/Lvlv2D6tZNbQD8TikU5Vocx0DClHZGgDKW9VOIeOQ5RKUeg4En53lKktUQH4KUYsIo5KMAkSGzdjIWgzGPXIkD2GSpDbWhOVzrXRSTbGLRHtTEN6KY8Lt97q8k9gx80XLq/iAPg4/7pScoxKZ2Z+8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbeF6xN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86213C433C7;
	Sun, 24 Mar 2024 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299985;
	bh=Ff/xTjGvpE3YHuaLbsD7nmrBqNTIVUTpWJloARUyFPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbeF6xN0KI63pKBXbx7ZLU5npGT5mz8GZ9QkFJ692yGxCQXrrtybJAP8tMSTxJnY2
	 BogkVCfEsMXv2vo+SHCRNfkKcXdC8KknbpXl78WbIlYT9SKb3+z2a/MZnheq2ogWF5
	 j9sIyWKW9vr3GiVMwLnF3UwGe8RkANVqIDUPTjhNMbnnFO9uwIJ+dtOcRbELwkRLbw
	 3p6lf8+ZuqiMP27Jyw8O4npPtAGY+J9bQa9Qaaves5oN88Damb9oUgLaOIDarRc90z
	 2yFjmj3at6HmHyUyfzb/5YUsqg4AZEdzUbw/FepaTX5PB4TvjKk4vZjrUkvTyg82M3
	 2gCatNpayFwOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 03/11] rcu-tasks: Add data to eliminate RCU-tasks/do_exit() deadlocks
Date: Sun, 24 Mar 2024 13:06:06 -0400
Message-ID: <20240324170619.545975-3-sashal@kernel.org>
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

[ Upstream commit bfe93930ea1ea3c6c115a7d44af6e4fea609067e ]

Holding a mutex across synchronize_rcu_tasks() and acquiring
that same mutex in code called from do_exit() after its call to
exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
results in deadlock.  This is by design, because tasks that are far
enough into do_exit() are no longer present on the tasks list, making
it a bit difficult for RCU Tasks to find them, let alone wait on them
to do a voluntary context switch.  However, such deadlocks are becoming
more frequent.  In addition, lockdep currently does not detect such
deadlocks and they can be difficult to reproduce.

In addition, if a task voluntarily context switches during that time
(for example, if it blocks acquiring a mutex), then this task is in an
RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
just as well take advantage of that fact.

This commit therefore adds the data structures that will be needed
to rely on these quiescent states and to eliminate these deadlocks.

Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/

Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reported-by: Yang Jihong <yangjihong1@huawei.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yang Jihong <yangjihong1@huawei.com>
Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched.h | 2 ++
 kernel/rcu/tasks.h    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c316972485..c610cba18e0e2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -855,6 +855,8 @@ struct task_struct {
 	u8				rcu_tasks_idx;
 	int				rcu_tasks_idle_cpu;
 	struct list_head		rcu_tasks_holdout_list;
+	int				rcu_tasks_exit_cpu;
+	struct list_head		rcu_tasks_exit_list;
 #endif /* #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_TRACE_RCU
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f54d5782eca0b..3580055342ca9 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -32,6 +32,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @rtp_irq_work: IRQ work queue for deferred wakeups.
  * @barrier_q_head: RCU callback for barrier operation.
  * @rtp_blkd_tasks: List of tasks blocked as readers.
+ * @rtp_exit_list: List of tasks in the latter portion of do_exit().
  * @cpu: CPU number corresponding to this entry.
  * @rtpp: Pointer to the rcu_tasks structure.
  */
@@ -46,6 +47,7 @@ struct rcu_tasks_percpu {
 	struct irq_work rtp_irq_work;
 	struct rcu_head barrier_q_head;
 	struct list_head rtp_blkd_tasks;
+	struct list_head rtp_exit_list;
 	int cpu;
 	struct rcu_tasks *rtpp;
 };
-- 
2.43.0


