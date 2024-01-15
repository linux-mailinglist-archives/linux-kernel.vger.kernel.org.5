Return-Path: <linux-kernel+bounces-25756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D282D559
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6101C213A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7803C8EA;
	Mon, 15 Jan 2024 08:55:08 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3E0C8C2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 40F8t014047556
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:55:00 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40F8rkXH042583;
	Mon, 15 Jan 2024 16:53:46 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TD5NJ1vNzz2RCYp0;
	Mon, 15 Jan 2024 16:46:40 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 15 Jan 2024 16:53:44 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>
CC: <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>, <xuewen.yan@unisoc.com>
Subject: [PATCH] lockdep: fix deadlock issue between lockdep and rcu
Date: Mon, 15 Jan 2024 16:53:16 +0800
Message-ID: <1705308796-13547-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40F8rkXH042583

There is a deadlock scenario between lockdep and rcu when
rcu nocb feature is enabled, just as following call stack:

     rcuop/x
-000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
-001|queued_spin_lock(inline) // try to hold nocb_gp_lock
-001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
-002|__raw_spin_lock_irqsave(inline)
-002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
-003|wake_nocb_gp_defer(inline)
-003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
-004|__call_rcu_common(inline)
-004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
-005|call_rcu_zapped(inline)
-005|free_zapped_rcu(ch = ?)// hold graph lock
-006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
-007|nocb_cb_wait(inline)
-007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
-008|kthread(_create = 0xFFFFFF80803122C0)
-009|ret_from_fork(asm)

     rcuop/y
-000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
-001|queued_spin_lock()
-001|lockdep_lock()
-001|graph_lock() // try to hold graph lock
-002|lookup_chain_cache_add()
-002|validate_chain()
-003|lock_acquire
-004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
-005|lock_timer_base(inline)
-006|mod_timer(inline)
-006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
-006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
-007|__call_rcu_common(inline)
-007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
-008|call_rcu_hurry(inline)
-008|rcu_sync_call(inline)
-008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
-009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
-010|nocb_cb_wait(inline)
-010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
-011|kthread(_create = 0xFFFFFF8080363740)
-012|ret_from_fork(asm)

rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.

This patch release the graph lock before lockdep call_rcu.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/locking/lockdep.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3d..c1d432a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6186,23 +6186,29 @@ static struct pending_free *get_pending_free(void)
 /*
  * Schedule an RCU callback if no RCU callback is pending. Must be called with
  * the graph lock held.
+ *
+ * Return true if graph lock need be released by the caller, otherwise false
+ * means graph lock is released by itself.
  */
-static void call_rcu_zapped(struct pending_free *pf)
+static bool call_rcu_zapped(struct pending_free *pf)
 {
 	WARN_ON_ONCE(inside_selftest());
 
 	if (list_empty(&pf->zapped))
-		return;
+		return true;
 
 	if (delayed_free.scheduled)
-		return;
+		return true;
 
 	delayed_free.scheduled = true;
 
 	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
 	delayed_free.index ^= 1;
 
+	lockdep_unlock();
 	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+
+	return false;
 }
 
 /* The caller must hold the graph lock. May be called from RCU context. */
@@ -6228,6 +6234,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_unlock;
 
 	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
 		return;
@@ -6243,9 +6250,9 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	/*
 	 * If there's anything on the open list, close and start a new callback.
 	 */
-	call_rcu_zapped(delayed_free.pf + delayed_free.index);
-
-	lockdep_unlock();
+	need_unlock = call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	if (need_unlock)
+		lockdep_unlock();
 	raw_local_irq_restore(flags);
 }
 
@@ -6286,6 +6293,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_unlock;
 
 	init_data_structures_once();
 
@@ -6293,8 +6301,9 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
-	call_rcu_zapped(pf);
-	lockdep_unlock();
+	need_unlock = call_rcu_zapped(pf);
+	if (need_unlock)
+		lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/*
@@ -6390,6 +6399,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
+	bool need_unlock;
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
@@ -6398,9 +6408,9 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 
 	pf = get_pending_free();
 	__lockdep_reset_lock(pf, lock);
-	call_rcu_zapped(pf);
-
-	graph_unlock();
+	need_unlock = call_rcu_zapped(pf);
+	if (need_unlock)
+		graph_unlock();
 out_irq:
 	raw_local_irq_restore(flags);
 }
@@ -6446,6 +6456,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	struct pending_free *pf;
 	unsigned long flags;
 	bool found = false;
+	bool need_unlock = true;
 
 	might_sleep();
 
@@ -6466,9 +6477,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (found) {
 		pf = get_pending_free();
 		__lockdep_free_key_range(pf, key, 1);
-		call_rcu_zapped(pf);
+		need_unlock = call_rcu_zapped(pf);
 	}
-	lockdep_unlock();
+	if (need_unlock)
+		lockdep_unlock();
 	raw_local_irq_restore(flags);
 
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-- 
1.9.1


