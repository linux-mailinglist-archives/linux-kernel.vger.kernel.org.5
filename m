Return-Path: <linux-kernel+bounces-20749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F3D828491
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC2A1C23DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D123374F7;
	Tue,  9 Jan 2024 11:10:49 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9B336AEE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 409BANLO045364;
	Tue, 9 Jan 2024 19:10:23 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4T8Shw6jWgz2RS3WG;
	Tue,  9 Jan 2024 19:03:28 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 9 Jan 2024 19:10:21 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <tj@kernel.org>, <jiangshanlai@gmail.com>
CC: <longman@redhat.com>, <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>
Subject: [PATCH] workqueue: Add rcu lock check after work execute end
Date: Tue, 9 Jan 2024 19:10:14 +0800
Message-ID: <20240109111014.2689-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
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
X-MAIL:SHSQR01.spreadtrum.com 409BANLO045364

Now the workqueue just check the atomic and lock after
work execute end. However, sometimes, drivers's work
may don't unlock rcu after call rcu_read_lock().
And as a result, it would cause rcu stall, but the rcu stall warning
can not dump the work func, because the work has finished.

In order to quickly discover those works that do not call
rcu_read_unlock after rcu_read_lock(). Add the rcu lock check.

Use rcu_preempt_depth() to check the work's rcu status,
Normally, this value is 0. If this value is bigger than 0,
it means that the rcu lock is still held after the work ends.
At this time, we print err info and print the work func.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/workqueue.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 2989b57e154a..a5a0df824df1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2634,11 +2634,12 @@ __acquires(&pool->lock)
 	lock_map_release(&lockdep_map);
 	lock_map_release(&pwq->wq->lockdep_map);
 
-	if (unlikely(in_atomic() || lockdep_depth(current) > 0)) {
-		pr_err("BUG: workqueue leaked lock or atomic: %s/0x%08x/%d\n"
+	if (unlikely(in_atomic() || lockdep_depth(current) > 0) ||
+		rcu_preempt_depth() > 0) {
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


