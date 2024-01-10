Return-Path: <linux-kernel+bounces-21687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4EB8292C8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 04:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2051F266D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901BD63D9;
	Wed, 10 Jan 2024 03:28:11 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7E63A7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40A3Rdb8060328;
	Wed, 10 Jan 2024 11:27:39 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T8tNW3c4Wz2QNS93;
	Wed, 10 Jan 2024 11:20:43 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 10 Jan 2024 11:27:37 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <tj@kernel.org>, <longman@redhat.com>
CC: <jiangshanlai@gmail.com>, <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] workqueue: Add rcu lock check after work execute end
Date: Wed, 10 Jan 2024 11:27:24 +0800
Message-ID: <20240110032724.3339-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9bed61e4-7c08-4c61-a7e4-bdd39335cec1@redhat.com>
References: <9bed61e4-7c08-4c61-a7e4-bdd39335cec1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 40A3Rdb8060328

Now the workqueue just check the atomic and lock after
work execute end. However, sometimes, drivers's work
may don't unlock rcu after call rcu_read_lock().
And as a result, it would cause rcu stall, but the rcu stall warning
can not dump the work func, because the work has finished.

In order to quickly discover those works that do not call
rcu_read_unlock after rcu_read_lock(). Add the rcu lock check.

Use rcu_preempt_depth() to check the work's rcu status,
Normally, this value is 0. If this value is bigger than 0,
it means the work are still holding rcu lock.
At this time, we print err info and print the work func.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
V2:
- move check to unlikely() helper (Longman)
---
 kernel/workqueue.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..c2a73364f5ad 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2634,11 +2634,12 @@ __acquires(&pool->lock)
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
-	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
-		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
+	if (unlikely(in_atomic() || lockdep_depth(current) > 0 ||
+		rcu_preempt_depth() > 0)) {
+		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d/%d\n"
 		       "     last function: %ps\n",
-		       current->comm, preempt_count(), task_pid_nr(current),
-		       worker->current_func);
+		       current->comm, preempt_count(), rcu_preempt_depth(),
+		       task_pid_nr(current), worker->current_func);
 		debug_show_held_locks(current);
 		dump_stack();
 	}
-- 
2.25.1


