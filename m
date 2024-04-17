Return-Path: <linux-kernel+bounces-149275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A34F8A8EB5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990B11F227C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD23E13C3EF;
	Wed, 17 Apr 2024 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UYVIt7K"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3B4C62E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713391540; cv=none; b=ZThuwr6b/cqijhcKGkBEMA7jeL/Xopx1WcI8sd+QnPKHS5FtSJwV89GyTdI0fLdadSlhVJZhZzOXUkjFAEJwEogWOV5AP41bxiFB0j/gy0NKqNoLm40x/VELKKzAK7pl6kYCqmeFdTdY27nONfYVUqmu8P8xWyw/mvJvkEGKCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713391540; c=relaxed/simple;
	bh=erqmtlpijRRSqOo+MRwOcq5rPRXpS5P7NhauhD3F73c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZVjPBM4EjWuYXAl8Tj18+EgIpgbv/ylEUrgUwh4mGhelbhBiBm+aD/xai220fDJJOir7YvClJmhSt14YYUUhVbiQbLFV2wKMSWPASZg/jiKzNHrGUEKN2UiEbVnCoY+7PBt77hfJ/UAxBBy8Ip/4+IPXAln1p82sXb2CzmFdqFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UYVIt7K; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a48ed89c7eso296266a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713391539; x=1713996339; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sQAd7m1bsb6+Pms8yhE5r0z3pGxSqo7PimBQcO9YDQ=;
        b=1UYVIt7KoymJSfl5jWOS05O0EQZBUyAjBa3kKLs4aA0cFrCftpJzUisg4/ItWBF26c
         CDUOoU6SNvKiNr3hoEEjNtaMiER9SVosITe4dzIICvHWMQS1ZXu4S1R/WigVvi4ni1kc
         MblRqEnSmejvoDl/PcPGNI99+VkX6eCgalYQhqaex05ytkbSFvodJ+LmEh0feU3APiag
         HRzAaHJw83Mi6ZfivVoq4cT+k8uq//ed49PnSCIdogAx2CdkcrxRE8Ibm4tyUC6tNd8r
         e/3EkXGBRIuknO1TzT9mC8YYhvDWO4uqlIx4Cf78+B8NYuCfQpB0WIQtHSzv01IY++tn
         Buzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713391539; x=1713996339;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sQAd7m1bsb6+Pms8yhE5r0z3pGxSqo7PimBQcO9YDQ=;
        b=jNpLmMYLXEiUZXI+tcnNrUtLuHgxOQIn+zMFsd0PrXfmlerP/DeB3Rfm1bpkOviNWE
         g+i8hjEG/LH44Rm01aAcSyBlTC70MGVnfX0r866MR5z+gEmqwSWNMLWbAzGGOBAuoV2l
         v37/McVMxr7Ew2Fvpjz+6/+XuwowtdAPbGQ0zSFaxGgtrPWn7bIvXsaRSINKwM5RUFN+
         5yWzQN2IwPjzess51LKQmPMCiT15nOj2jKq1C+2as14I9SrmllFeFOHUs+0+7wgn/60E
         dwRM8fA2RKvILhynaIYIckqCik9ZtG7ek6AuBgp2Bh+a9pUY0LX/ogQPTblho73yPYUr
         HgUw==
X-Gm-Message-State: AOJu0Yw9RDNEFg4z5FVldHcmhFwpG49z/QygnPkNTKmqH5VDTWLy14M1
	gER2KBIGWmYxqXG6OgKq8+q5g8+9nKdEV1BHl5O0c50Z9HmXWIscxIRVkytVh3Tq+3cTxTDtGhL
	6J6mCNeVmQA==
X-Google-Smtp-Source: AGHT+IGovgi8/xH9OY96galhVVKt2bjrErfL7IPTXr63Z3HFufHi99S0SH/qaFy+Ux5/+5S4orwg+2OVHKBWug==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:90b:4a03:b0:2a2:544:71e4 with SMTP id
 kk3-20020a17090b4a0300b002a2054471e4mr11998pjb.4.1713391538604; Wed, 17 Apr
 2024 15:05:38 -0700 (PDT)
Date: Wed, 17 Apr 2024 22:05:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417220534.1370087-1-cmllamas@google.com>
Subject: [PATCH v4 RESEND] lockdep: fix deadlock issue between lockdep and rcu
From: Carlos Llamas <cmllamas@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Bart Van Assche <bvanassche@acm.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Xuewen Yan <xuewen.yan@unisoc.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

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
Cc:  <stable@vger.kernel.org>
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
 kernel/locking/lockdep.c | 48 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..3468d8230e5f 100644
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
2.44.0.683.g7961c838ac-goog


