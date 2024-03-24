Return-Path: <linux-kernel+bounces-112739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD77887DAF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E842B281466
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A6819474;
	Sun, 24 Mar 2024 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZW4dLLU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3E1B941;
	Sun, 24 Mar 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299963; cv=none; b=ljQXtI8VPTbYyo1uPn2V9JiXqbzvCpH05OHDQFihVeUbyffoIVorgbhToqfCUtQJIuQWRl3JxwErONcpMVnUlB3EacRxG/MHhboN5nttOdtJWrvSxi8lSMJZed3lNT17qtVSqbQcldsUWTq1ffAVEu9CzTsCFjFuD0Gl572XQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299963; c=relaxed/simple;
	bh=GaqpN9O7l72lvXtYBJY5RrcBLh+brIkVKHbII7zKCD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uU2o1s7VNbp4YNP42AzhJJmKAI6/luoQWWAjTSVkLRFl5c3W2Ksjz3IobmMjOFQgQXaiJN6XSbjq3OIjwxS53oTuQuG6jP5lKnwXeLm6oT+KV5z9hW3j7hdUgIHZ8vN2sNvL+wK1gD5GrbYaqX3AcYWMk8YdDzs1G/WH4IJ94xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZW4dLLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF85C433A6;
	Sun, 24 Mar 2024 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299963;
	bh=GaqpN9O7l72lvXtYBJY5RrcBLh+brIkVKHbII7zKCD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZW4dLLUeNov6HDK3wD73UeKlqi1AElQIgHRVTORS0H5ALcMXLB99KtuqtOG13O/X
	 KCyKPYqpWWxhSa0pgoEVll2cCZyf/sQuJcx4edBPfEX5O612hPAABmmsXIzIXj9yT7
	 9JxkLXxQoW8bqboIt6tfxu+Ji6JLGkLMtqVfKO1gjB+XQTePa3hf9zSKDrVW5+inv/
	 gYqt4bgcJcF1euWeJE+0w0aWaBu8GHQ6b9YGXmlmaR0KXfCuMo9r0MnWNHCQf+4KX2
	 7uJGvZy2onijKCY7RhvFQEeg/ofmgk6zlHXfXQMYASXF8oPHDiQMrYlQ4ol9VL9sZJ
	 J6SQS7fwnFKTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	quic_neeraju@quicinc.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	kent.overstreet@linux.dev,
	akpm@linux-foundation.org,
	oleg@redhat.com,
	hca@linux.ibm.com,
	brauner@kernel.org,
	surenb@google.com,
	tandersen@netflix.com,
	mjguzik@gmail.com,
	npiggin@gmail.com,
	zhangpeng.00@bytedance.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 04/11] rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
Date: Sun, 24 Mar 2024 13:05:39 -0400
Message-ID: <20240324170552.545730-4-sashal@kernel.org>
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

[ Upstream commit 46faf9d8e1d52e4a91c382c6c72da6bd8e68297b ]

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

This commit therefore initializes the data structures that will be needed
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
 init/init_task.c   | 1 +
 kernel/fork.c      | 1 +
 kernel/rcu/tasks.h | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/init/init_task.c b/init/init_task.c
index 7ecb458eb3da6..4daee6d761c86 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -147,6 +147,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
+	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
diff --git a/kernel/fork.c b/kernel/fork.c
index 0d944e92a43ff..af7203be1d2d1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1976,6 +1976,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b7d5f27570532..4a5d562e31892 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -277,6 +277,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		rtpcp->rtpp = rtp;
 		if (!rtpcp->rtp_blkd_tasks.next)
 			INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
+		if (!rtpcp->rtp_exit_list.next)
+			INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
 	}
 
 	pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=%d.\n", rtp->name,
-- 
2.43.0


