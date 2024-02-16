Return-Path: <linux-kernel+bounces-69123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099F8584D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC3E282F76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DBC135A67;
	Fri, 16 Feb 2024 18:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9STS7GV"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DD413541F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106784; cv=none; b=YQ5203+LoaoHWs6xY83vgp9JOiO9+XpEy9U/pz0QUdrOb7VUeWmcsFu66QDoH5dU4ClfV6fg890pk+K0eSGl/3EBkXJTEOSGttAXi5jyq5AybsXqEsuJINY95NPKTrpEl9priDB/16W5edO+7v82XR8ROkARUsyuitgP6lIPTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106784; c=relaxed/simple;
	bh=tPPHqZjVF21W3HTmNqLMh1L8ACYe5HaB4tCiqIc46fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kb37llwC0pGABQJt/OzwKkItc3xH9KJmt1uQ+8Wl/b/dEyeUqblUI0hkbpbx6Rsu6afyKZkg7ifmwkMw+n17sYvrh1+XOt2XAzw1K64dxchRzcJaSGCwqoh38nrk7OiN9a0SIHXxG4RsCZbn817VK09YuR+gMJKKES3gDDx1h/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9STS7GV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1930209a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106782; x=1708711582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiVo0gbO7Dqzblo5C6ryvAHZfaLX7ADi1ZU8tAGlpEU=;
        b=J9STS7GV0D7ECNxXOcGvDl2/7XEcjk4X3bhlxoEzbrcBbC1y677AesKv3urnz2DTLf
         qJT5I6Lwc65Cla+KWxonDcH45WnXer1L48w9cWA42Q2hm0/DF4jYAsEdw1sIyGPO4tpF
         YyRhi5wO6UwVl2OSZmoTxiF9NmjiUmiPV1ch5EL3JR/S4YaI6/zE7wpWiRXG05yAYhUR
         +M+uLHejsVt+C0A3qDWekHkNT0trDLjsBqwng90hO/KLP5IoGQcD6lyTJrYoYTi0NF1/
         Ce6Qfv/J0Bw4h3klL7XPKragoD0mQ+3q4gaVM5wqAPPXlECZgrbMhxbSu+UDi7pfoKSd
         NiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106782; x=1708711582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fiVo0gbO7Dqzblo5C6ryvAHZfaLX7ADi1ZU8tAGlpEU=;
        b=ImezeF9bxq8J3XpSTI0HSdT3LL1W2WbZ/20HuMbQa4gkwyI8csJ4QRlJ1V1LJL/P7a
         hymMGq4Hq6BNYvgz6D8Wx9343FJ/byi9RFhxSGAVEAl9OO6K7pmeuzpRnT9YHU6mxrj5
         MRce7bWB6q/U1zZWhbzCp2EwhUjl+wxKQHM/Gu8um4YKUEF+e6xXEkdjZMh8nvdzOtv+
         sXL0X8BbgwmqeL4/tBfSyNKslE9/bBsegUK2yd+vbRYVNu5Yu4cSrlcqXiBb/yh4/jJs
         j4+Pzir9KIJOIOf8jQ0NAgWB9tamryKlhMfqhL5p1J80Fd/edmUfyMJzpPkcVK76jfLc
         TG3g==
X-Forwarded-Encrypted: i=1; AJvYcCWWZJWNTYWgushuaqhzMQetETqNtjf6GH51JVVAZRtNVfR8D4U3uDq15SziJ6vd2lYlWhnPMP9+K5DKBpUs7tZW10PEW1rnpmKx57sD
X-Gm-Message-State: AOJu0Yzk8R6OurkWg3lxjFsr0UZkTpuKO7K8a7ULkmNr6SMru7xI/VlN
	3NAJN5tZx6itZBI7Zx+IHpnd+Ajlleqw4ojteOVrluw/5RCIF+9lVet3sDqS/n8=
X-Google-Smtp-Source: AGHT+IHLJ98WzO5KMmgZMW+SdjexCVlhop7CnYonD2z6uWSret/SCGrTDjbEXE+0H/XyLEfwTQhtLw==
X-Received: by 2002:a17:90b:234b:b0:299:30eb:f687 with SMTP id ms11-20020a17090b234b00b0029930ebf687mr3073017pjb.16.1708106782092;
        Fri, 16 Feb 2024 10:06:22 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id qa9-20020a17090b4fc900b002994f848bc9sm99440pjb.43.2024.02.16.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:21 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/17] workqueue: Use variable name irq_flags for saving local irq flags
Date: Fri, 16 Feb 2024 08:04:46 -1000
Message-ID: <20240216180559.208276-6-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240216180559.208276-1-tj@kernel.org>
References: <20240216180559.208276-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using the generic term `flags` for irq flags is conventional but can be
confusing as there's quite a bit of code dealing with work flags which
involves some subtleties. Let's use a more explicit name `irq_flags` for
local irq flags. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 76 +++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 962061dca05c..b590d93d054b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2029,7 +2029,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
  * try_to_grab_pending - steal work item from worklist and disable irq
  * @work: work item to steal
  * @is_dwork: @work is a delayed_work
- * @flags: place to store irq state
+ * @irq_flags: place to store irq state
  *
  * Try to grab PENDING bit of @work.  This function can handle @work in any
  * stable state - idle, on timer or on worklist.
@@ -2051,17 +2051,17 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
  * irqsafe, ensures that we return -EAGAIN for finite short period of time.
  *
  * On successful return, >= 0, irq is disabled and the caller is
- * responsible for releasing it using local_irq_restore(*@flags).
+ * responsible for releasing it using local_irq_restore(*@irq_flags).
  *
  * This function is safe to call from any context including IRQ handler.
  */
 static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
-			       unsigned long *flags)
+			       unsigned long *irq_flags)
 {
 	struct worker_pool *pool;
 	struct pool_workqueue *pwq;
 
-	local_irq_save(*flags);
+	local_irq_save(*irq_flags);
 
 	/* try to steal the timer if it exists */
 	if (is_dwork) {
@@ -2136,7 +2136,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 	raw_spin_unlock(&pool->lock);
 fail:
 	rcu_read_unlock();
-	local_irq_restore(*flags);
+	local_irq_restore(*irq_flags);
 	if (work_is_canceling(work))
 		return -ENOENT;
 	cpu_relax();
@@ -2344,16 +2344,16 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 		   struct work_struct *work)
 {
 	bool ret = false;
-	unsigned long flags;
+	unsigned long irq_flags;
 
-	local_irq_save(flags);
+	local_irq_save(irq_flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_work(cpu, wq, work);
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_irq_restore(irq_flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_work_on);
@@ -2410,7 +2410,7 @@ static int select_numa_node_cpu(int node)
 bool queue_work_node(int node, struct workqueue_struct *wq,
 		     struct work_struct *work)
 {
-	unsigned long flags;
+	unsigned long irq_flags;
 	bool ret = false;
 
 	/*
@@ -2424,7 +2424,7 @@ bool queue_work_node(int node, struct workqueue_struct *wq,
 	 */
 	WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND));
 
-	local_irq_save(flags);
+	local_irq_save(irq_flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		int cpu = select_numa_node_cpu(node);
@@ -2433,7 +2433,7 @@ bool queue_work_node(int node, struct workqueue_struct *wq,
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_irq_restore(irq_flags);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(queue_work_node);
@@ -2503,17 +2503,17 @@ bool queue_delayed_work_on(int cpu, struct workqueue_struct *wq,
 {
 	struct work_struct *work = &dwork->work;
 	bool ret = false;
-	unsigned long flags;
+	unsigned long irq_flags;
 
 	/* read the comment in __queue_work() */
-	local_irq_save(flags);
+	local_irq_save(irq_flags);
 
 	if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work))) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_irq_restore(irq_flags);
 	return ret;
 }
 EXPORT_SYMBOL(queue_delayed_work_on);
@@ -2539,16 +2539,16 @@ EXPORT_SYMBOL(queue_delayed_work_on);
 bool mod_delayed_work_on(int cpu, struct workqueue_struct *wq,
 			 struct delayed_work *dwork, unsigned long delay)
 {
-	unsigned long flags;
+	unsigned long irq_flags;
 	int ret;
 
 	do {
-		ret = try_to_grab_pending(&dwork->work, true, &flags);
+		ret = try_to_grab_pending(&dwork->work, true, &irq_flags);
 	} while (unlikely(ret == -EAGAIN));
 
 	if (likely(ret >= 0)) {
 		__queue_delayed_work(cpu, wq, dwork, delay);
-		local_irq_restore(flags);
+		local_irq_restore(irq_flags);
 	}
 
 	/* -ENOENT from try_to_grab_pending() becomes %true */
@@ -4105,18 +4105,18 @@ EXPORT_SYMBOL(flush_rcu_work);
 
 static bool __cancel_work(struct work_struct *work, bool is_dwork)
 {
-	unsigned long flags;
+	unsigned long irq_flags;
 	int ret;
 
 	do {
-		ret = try_to_grab_pending(work, is_dwork, &flags);
+		ret = try_to_grab_pending(work, is_dwork, &irq_flags);
 	} while (unlikely(ret == -EAGAIN));
 
 	if (unlikely(ret < 0))
 		return false;
 
 	set_work_pool_and_clear_pending(work, get_work_pool_id(work));
-	local_irq_restore(flags);
+	local_irq_restore(irq_flags);
 	return ret;
 }
 
@@ -4137,11 +4137,11 @@ static int cwt_wakefn(wait_queue_entry_t *wait, unsigned mode, int sync, void *k
 static bool __cancel_work_sync(struct work_struct *work, bool is_dwork)
 {
 	static DECLARE_WAIT_QUEUE_HEAD(cancel_waitq);
-	unsigned long flags;
+	unsigned long irq_flags;
 	int ret;
 
 	do {
-		ret = try_to_grab_pending(work, is_dwork, &flags);
+		ret = try_to_grab_pending(work, is_dwork, &irq_flags);
 		/*
 		 * If someone else is already canceling, wait for it to
 		 * finish.  flush_work() doesn't work for PREEMPT_NONE
@@ -4175,7 +4175,7 @@ static bool __cancel_work_sync(struct work_struct *work, bool is_dwork)
 
 	/* tell other tasks trying to grab @work to back off */
 	mark_work_canceling(work);
-	local_irq_restore(flags);
+	local_irq_restore(irq_flags);
 
 	/*
 	 * Skip __flush_work() during early boot when we know that @work isn't
@@ -5381,15 +5381,15 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 
 		activated = false;
 		for_each_pwq(pwq, wq) {
-			unsigned long flags;
+			unsigned long irq_flags;
 
 			/* can be called during early boot w/ irq disabled */
-			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+			raw_spin_lock_irqsave(&pwq->pool->lock, irq_flags);
 			if (pwq_activate_first_inactive(pwq, true)) {
 				activated = true;
 				kick_pool(pwq->pool);
 			}
-			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, irq_flags);
 		}
 	} while (activated);
 }
@@ -5762,7 +5762,7 @@ EXPORT_SYMBOL_GPL(workqueue_congested);
 unsigned int work_busy(struct work_struct *work)
 {
 	struct worker_pool *pool;
-	unsigned long flags;
+	unsigned long irq_flags;
 	unsigned int ret = 0;
 
 	if (work_pending(work))
@@ -5771,10 +5771,10 @@ unsigned int work_busy(struct work_struct *work)
 	rcu_read_lock();
 	pool = get_work_pool(work);
 	if (pool) {
-		raw_spin_lock_irqsave(&pool->lock, flags);
+		raw_spin_lock_irqsave(&pool->lock, irq_flags);
 		if (find_worker_executing_work(pool, work))
 			ret |= WORK_BUSY_RUNNING;
-		raw_spin_unlock_irqrestore(&pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pool->lock, irq_flags);
 	}
 	rcu_read_unlock();
 
@@ -6006,7 +6006,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 {
 	struct pool_workqueue *pwq;
 	bool idle = true;
-	unsigned long flags;
+	unsigned long irq_flags;
 
 	for_each_pwq(pwq, wq) {
 		if (!pwq_is_empty(pwq)) {
@@ -6020,7 +6020,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 	pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
 
 	for_each_pwq(pwq, wq) {
-		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+		raw_spin_lock_irqsave(&pwq->pool->lock, irq_flags);
 		if (!pwq_is_empty(pwq)) {
 			/*
 			 * Defer printing to avoid deadlocks in console
@@ -6031,7 +6031,7 @@ void show_one_workqueue(struct workqueue_struct *wq)
 			show_pwq(pwq);
 			printk_deferred_exit();
 		}
-		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, irq_flags);
 		/*
 		 * We could be printing a lot from atomic context, e.g.
 		 * sysrq-t -> show_all_workqueues(). Avoid triggering
@@ -6050,10 +6050,10 @@ static void show_one_worker_pool(struct worker_pool *pool)
 {
 	struct worker *worker;
 	bool first = true;
-	unsigned long flags;
+	unsigned long irq_flags;
 	unsigned long hung = 0;
 
-	raw_spin_lock_irqsave(&pool->lock, flags);
+	raw_spin_lock_irqsave(&pool->lock, irq_flags);
 	if (pool->nr_workers == pool->nr_idle)
 		goto next_pool;
 
@@ -6081,7 +6081,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 	pr_cont("\n");
 	printk_deferred_exit();
 next_pool:
-	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	raw_spin_unlock_irqrestore(&pool->lock, irq_flags);
 	/*
 	 * We could be printing a lot from atomic context, e.g.
 	 * sysrq-t -> show_all_workqueues(). Avoid triggering
@@ -7212,10 +7212,10 @@ static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
 static void show_cpu_pool_hog(struct worker_pool *pool)
 {
 	struct worker *worker;
-	unsigned long flags;
+	unsigned long irq_flags;
 	int bkt;
 
-	raw_spin_lock_irqsave(&pool->lock, flags);
+	raw_spin_lock_irqsave(&pool->lock, irq_flags);
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
 		if (task_is_running(worker->task)) {
@@ -7233,7 +7233,7 @@ static void show_cpu_pool_hog(struct worker_pool *pool)
 		}
 	}
 
-	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	raw_spin_unlock_irqrestore(&pool->lock, irq_flags);
 }
 
 static void show_cpu_pools_hogs(void)
-- 
2.43.2


