Return-Path: <linux-kernel+bounces-54824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3596C84B41C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295D0B25311
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B03132C10;
	Tue,  6 Feb 2024 11:45:15 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B7A132468
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219915; cv=none; b=VCZ/2X0SMIEj7XJYx12Ijic91djQzzYY91UMf7bF2tJ+i05GTy4ZaKicMPV1PgpdPkQTF/MHAXzdSik/Q4qwa/7gt7hJm/HsrTPotBNaCxXHaifJWKvPka/1PiPfoSimSrdU8Gt+zkfHaZN+MSta2tvFMKr3nibe8OWRorTtEKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219915; c=relaxed/simple;
	bh=HCsSN7olhvXJs/2wLqhN4v/w4yNjAhygxT+49NJS1lM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bz+oayOP5H9bbkksKu2jMorKwDc3GSkmIGe8SNr1TfvEtQiYkOiz/lKlsIPn2IVX1j39Qx20pnTkUe/JrRzrc/Eur/DFMgBZ4yvYx/TDeglpF0YUL+6Tq+U5tVEdjBW/76HXsD5FMARyh5tHaN+wFIArF74IsZZy3g76CSlDir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 416Bj16J094778;
	Tue, 6 Feb 2024 19:45:01 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TThHq6JvDz2K25NP;
	Tue,  6 Feb 2024 19:44:55 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 6 Feb 2024 19:44:59 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
        <longman@redhat.com>, <boqun.feng@gmail.com>
CC: <bvanassche@acm.org>, <cmllamas@google.com>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>, <xuewen.yan@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH V4] lockdep: fix deadlock issue between lockdep and rcu
Date: Tue, 6 Feb 2024 19:44:55 +0800
Message-ID: <1707219895-31977-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 416Bj16J094778

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

Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
Cc: <stable@vger.kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Carlos Llamas <cmllamas@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
changes of v4: add Reviewed-by info from reviewers.
changes of v3: correct code comments and add Cc tag.
changes of v2: update patch according to Boqun's suggestions.
---
---
 kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3d..3468d82 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
 static void free_zapped_rcu(struct rcu_head *cb);
 
 /*
- * Schedule an RCU callback if no RCU callback is pending. Must be called with
- * the graph lock held.
- */
-static void call_rcu_zapped(struct pending_free *pf)
+* See if we need to queue an RCU callback, must called with
+* the lockdep lock held, returns false if either we don't have
+* any pending free or the callback is already scheduled.
+* Otherwise, a call_rcu() must follow this function call.
+*/
+static bool prepare_call_rcu_zapped(struct pending_free *pf)
 {
 	WARN_ON_ONCE(inside_selftest());
 
 	if (list_empty(&pf->zapped))
-		return;
+		return false;
 
 	if (delayed_free.scheduled)
-		return;
+		return false;
 
 	delayed_free.scheduled = true;
 
 	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
 	delayed_free.index ^= 1;
 
-	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+	return true;
 }
 
 /* The caller must hold the graph lock. May be called from RCU context. */
@@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
 		return;
@@ -6239,14 +6242,18 @@ static void free_zapped_rcu(struct rcu_head *ch)
 	pf = delayed_free.pf + (delayed_free.index ^ 1);
 	__free_zapped_classes(pf);
 	delayed_free.scheduled = false;
+	need_callback =
+		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	lockdep_unlock();
+	raw_local_irq_restore(flags);
 
 	/*
-	 * If there's anything on the open list, close and start a new callback.
-	 */
-	call_rcu_zapped(delayed_free.pf + delayed_free.index);
+	* If there's pending free and its callback has not been scheduled,
+	* queue an RCU callback.
+	*/
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	lockdep_unlock();
-	raw_local_irq_restore(flags);
 }
 
 /*
@@ -6286,6 +6293,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 {
 	struct pending_free *pf;
 	unsigned long flags;
+	bool need_callback;
 
 	init_data_structures_once();
 
@@ -6293,10 +6301,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
 	lockdep_lock();
 	pf = get_pending_free();
 	__lockdep_free_key_range(pf, start, size);
-	call_rcu_zapped(pf);
+	need_callback = prepare_call_rcu_zapped(pf);
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
-
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 	/*
 	 * Wait for any possible iterators from look_up_lock_class() to pass
 	 * before continuing to free the memory they refer to.
@@ -6390,6 +6399,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 	struct pending_free *pf;
 	unsigned long flags;
 	int locked;
+	bool need_callback = false;
 
 	raw_local_irq_save(flags);
 	locked = graph_lock();
@@ -6398,11 +6408,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
 
 	pf = get_pending_free();
 	__lockdep_reset_lock(pf, lock);
-	call_rcu_zapped(pf);
+	need_callback = prepare_call_rcu_zapped(pf);
 
 	graph_unlock();
 out_irq:
 	raw_local_irq_restore(flags);
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 }
 
 /*
@@ -6446,6 +6458,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	struct pending_free *pf;
 	unsigned long flags;
 	bool found = false;
+	bool need_callback = false;
 
 	might_sleep();
 
@@ -6466,11 +6479,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (found) {
 		pf = get_pending_free();
 		__lockdep_free_key_range(pf, key, 1);
-		call_rcu_zapped(pf);
+		need_callback = prepare_call_rcu_zapped(pf);
 	}
 	lockdep_unlock();
 	raw_local_irq_restore(flags);
 
+	if (need_callback)
+		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
+
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
 	synchronize_rcu();
 }
-- 
1.9.1


