Return-Path: <linux-kernel+bounces-112750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5166887DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223901C20A3B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545C1B7E3;
	Sun, 24 Mar 2024 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5BHq08X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447C3B783;
	Sun, 24 Mar 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299989; cv=none; b=q5AmxxHmQPR8taRwTgdKvIgQ7RrOaqsQlkzt5YMj6j3b6EhGOyhJILoBR1/SZ6o91YY8oxhKXLr0fUCJm6Zu9RX7yDVjPYPFwbbELdVgQlQqGunxEWiUqSOAwwwJPzQskxKHjAywDodsrCYPWl5aNNbAdE09ZkJV/HxUN827wkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299989; c=relaxed/simple;
	bh=jdrnDwkic0v1BmPQt0AzqLbCX0WDlUL2ODaMcdpB6Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOCqQIjo5vE9tQ4oYJX0uDOMJcWyaaPK1y3ykXWYSzzS2Yrj9QJ+hSKDTmVhorvskkF3mn3KYDQ3rhHbDtX7bWsAAY4wCfZlPtALuE+qRlOyxHGrSbCvzQiK/AgTQ4S6olzcghMoQhtDn84CrifJJLC5MYTkfnuLh8jxidRWs3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5BHq08X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1747AC433F1;
	Sun, 24 Mar 2024 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711299989;
	bh=jdrnDwkic0v1BmPQt0AzqLbCX0WDlUL2ODaMcdpB6Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5BHq08Xz4LKjclK+P74msZh0RjpycXXvfe5gVcMOkCKmaTv/5UwjeReeVmmbql65
	 60UPvj6Vdpezfa85lZrtjIxklx1PYeuxnVjiPJ1zGGKQUg7LPNNazDOsmK3UGLPZ1I
	 LMjIQFg7daWYV5zgMZTjrhGz32hh/uY66BM6H7/oWaEV3fTCamuZ/zPH3Xm11QIJcL
	 2U9ERz41bVa+Tgucu5EoT1z66FIkHcA6k066smqj0oIqkaGHRU4vDXrLahMLv69dDx
	 vs3qKoFEIzJzefWk78hMLKSKmr5gNAvpROMMGWO4TJzEOHGyjnmxQEH9YedUWUslF1
	 sbkMHFlXpQwuw==
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
	arnd@arndb.de,
	hca@linux.ibm.com,
	oleg@redhat.com,
	brauner@kernel.org,
	surenb@google.com,
	tandersen@netflix.com,
	mjguzik@gmail.com,
	npiggin@gmail.com,
	zhangpeng.00@bytedance.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 04/11] rcu-tasks: Initialize data to eliminate RCU-tasks/do_exit() deadlocks
Date: Sun, 24 Mar 2024 13:06:07 -0400
Message-ID: <20240324170619.545975-4-sashal@kernel.org>
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
index 5727d42149c33..65f037bff457a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -152,6 +152,7 @@ struct task_struct init_task
 	.rcu_tasks_holdout = false,
 	.rcu_tasks_holdout_list = LIST_HEAD_INIT(init_task.rcu_tasks_holdout_list),
 	.rcu_tasks_idle_cpu = -1,
+	.rcu_tasks_exit_list = LIST_HEAD_INIT(init_task.rcu_tasks_exit_list),
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
diff --git a/kernel/fork.c b/kernel/fork.c
index 10917c3e1f036..6bacd515e0eb5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1981,6 +1981,7 @@ static inline void rcu_copy_process(struct task_struct *p)
 	p->rcu_tasks_holdout = false;
 	INIT_LIST_HEAD(&p->rcu_tasks_holdout_list);
 	p->rcu_tasks_idle_cpu = -1;
+	INIT_LIST_HEAD(&p->rcu_tasks_exit_list);
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3580055342ca9..ac8eb667a6707 100644
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


