Return-Path: <linux-kernel+bounces-83729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302C869DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C4B28320B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D87F153BEF;
	Tue, 27 Feb 2024 17:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWKFDBSO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05150150994
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054947; cv=none; b=EA6kh/vn9w/MbywBuXXpAu2g+feh502rsplUcNtYM1yuPhdikYiK3t3DIifdt6dAZlEL08ruPDi0wUDz+HL9fjrdoCyflddpaVqldG9dM5w11eWRrCNK9jCZg65xc+y0x0iwIO6fAMyQbMdwzrwkt21lld6azlZIGLHWTLfQ7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054947; c=relaxed/simple;
	bh=7pgXNyr370rE27KGysSsc8ThMZDf98eDMv4YAJguPuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pYEJOJhL2YTi+3gQjEQBlgCR33FttRxoL7ySVYYBfRT0tXbtNsRM1jtW9SrSmbDSlWpr2UR5L0Z6glj2CF1UpkeEc27XrZVrWBv1xcuz3xLJknhttg12lPcaxf5UXoXcm3gKh7+hTyUJ+ttaAL4Wp3yqzzjLo3E9z2TWZcpCWJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWKFDBSO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4257371a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709054944; x=1709659744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ksdGhBLgzF2GG0ivGYrJOJEwZ+rvHdJ+8/q6fi1Gxlo=;
        b=eWKFDBSO4zqcvTkGarT1E9TGGgbY439B50dTT7tnmc8NMu1wajLVh7YGXOKBx+jrbD
         AYg5zW3Eh205XFklXFa+4dBh94ssXjc1Qpv8PjR+B71PUwH8guoAPigXCNuvBYv5Bj1V
         Yk/ApyDyBlIW6y3cp8i+nHTzNe94YcAt9R/igvNTTZE4CEwdZIqc+4Ot9noOKOy19c8U
         gzNgEPvqtNkPTgVlTaCrgWZV/kOkBbtRk86kuGveTEmWy6WzuNuemVLWUihpqVGu3ob1
         c8cCoxqWMSXZTELkoZTP+fDc5SbstFOKSNYkoq94rLeeeg6LKS9vUHGMvS15IosJTBuT
         LBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054944; x=1709659744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ksdGhBLgzF2GG0ivGYrJOJEwZ+rvHdJ+8/q6fi1Gxlo=;
        b=D4nRvpKNTIxTUNPkf9MP1Ok+zUK9ahX8otnd0/9glz2KeYuNL4Rh9i1ZMN7fLdH49P
         wV1lTvtD9R/lR3+CBFLFrOwCy+OlUqgL64xaCac6viisK8cHd6llbOrIwEhLyb1EhAnP
         21k/q7ju8uBNKuVrhRwTLwjzxA4GNxlsx+hu4SRqYhakFKgE5nBgNBs+YrRtDKl15NwV
         1t1z0vxzI/5fGXZKkf9hX1Qij2jLQaZF9ecvT3Ui3dH94ietN0SHpMVEIdQIomFRVRZH
         +RxR4pA0aJAlpxgXOz1gIeHSuuUXPbyI5DDiq8O+J5wgoyUoEA6IyYigXnYvFhtuLyGh
         Zbyg==
X-Forwarded-Encrypted: i=1; AJvYcCXtr2ApDqGHJutVg7L+y1I770uT6UKp7S+1fg/uJySU+zp9vk8RV546sHVaYIPvHuMpKw8HQn4P1MxtdZzpHzFuSeNWt6JbgcFm6Upl
X-Gm-Message-State: AOJu0Yyu/nkKmt6X8gGv0HWlXJ/aY9BrKnZw1WTMwlXPJ3BWCSyVGKMO
	rhp8qYW/KfslmtbVIY5a067d5ULJSgjDtz1Kb4rjNHK5V0nhpAW4ka3DUQ9JK8w=
X-Google-Smtp-Source: AGHT+IF2FHUhnjHfPIbn9yIP/BkybjulCs38wbeZRu0glqfkJ+CG/palmJO1As+v8fTpt5czo1Pgug==
X-Received: by 2002:a17:902:d491:b0:1dc:693b:407c with SMTP id c17-20020a170902d49100b001dc693b407cmr12702400plg.42.1709054944174;
        Tue, 27 Feb 2024 09:29:04 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id ml11-20020a17090334cb00b001dc391cc28fsm1766375plb.121.2024.02.27.09.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:29:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	boqun.feng@gmail.com,
	tglx@linutronix.de,
	peterz@infradead.org,
	romain.perier@gmail.com,
	mingo@kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/6] workqueue: Allow cancel_work_sync() and disable_work() from atomic contexts on BH work items
Date: Tue, 27 Feb 2024 07:28:16 -1000
Message-ID: <20240227172852.2386358-6-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227172852.2386358-1-tj@kernel.org>
References: <20240227172852.2386358-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that work_grab_pending() can always grab the PENDING bit without
sleeping, the only thing that prevents allowing cancel_work_sync() of a BH
work item from an atomic context is the flushing of the in-flight instance.

When we're flushing a BH work item for cancel_work_sync(), we know that the
work item is not queued and must be executing in a BH context, which means
that it's safe to busy-wait for its completion from a non-hardirq atomic
context.

This patch updates __flush_work() so that it busy-waits when flushing a BH
work item for cancel_work_sync(). might_sleep() is pushed from
start_flush_work() to its callers - when operating on a BH work item,
__cancel_work_sync() now enforces !in_hardirq() instead of might_sleep().

This allows cancel_work_sync() and disable_work() to be called from
non-hardirq atomic contexts on BH work items.

v3: In __flush_work(), test WORK_OFFQ_BH to tell whether a work item being
    canceled can be busy waited instead of making start_flush_work() return
    the pool. (Lai)

v2: Lai pointed out that __flush_work() was accessing pool->flags outside
    the RCU critical section protecting the pool pointer. Fix it by testing
    and remembering the result inside the RCU critical section.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 74 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 19 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5c71fbd9d854..7d8eaca294c9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4020,8 +4020,6 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	struct pool_workqueue *pwq;
 	struct workqueue_struct *wq;
 
-	might_sleep();
-
 	rcu_read_lock();
 	pool = get_work_pool(work);
 	if (!pool) {
@@ -4073,6 +4071,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 static bool __flush_work(struct work_struct *work, bool from_cancel)
 {
 	struct wq_barrier barr;
+	unsigned long data;
 
 	if (WARN_ON(!wq_online))
 		return false;
@@ -4080,13 +4079,41 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!work->func))
 		return false;
 
-	if (start_flush_work(work, &barr, from_cancel)) {
-		wait_for_completion(&barr.done);
-		destroy_work_on_stack(&barr.work);
-		return true;
-	} else {
+	if (!start_flush_work(work, &barr, from_cancel))
 		return false;
+
+	/*
+	 * start_flush_work() returned %true. If @from_cancel is set, we know
+	 * that @work must have been executing during start_flush_work() and
+	 * can't currently be queued. Its data must contain OFFQ bits. If @work
+	 * was queued on a BH workqueue, we also know that it was running in the
+	 * BH context and thus can be busy-waited.
+	 */
+	data = *work_data_bits(work);
+	if (from_cancel &&
+	    !WARN_ON_ONCE(data & WORK_STRUCT_PWQ) && (data & WORK_OFFQ_BH)) {
+		/*
+		 * On RT, prevent a live lock when %current preempted soft
+		 * interrupt processing or prevents ksoftirqd from running by
+		 * keeping flipping BH. If the BH work item runs on a different
+		 * CPU then this has no effect other than doing the BH
+		 * disable/enable dance for nothing. This is copied from
+		 * kernel/softirq.c::tasklet_unlock_spin_wait().
+		 */
+		while (!try_wait_for_completion(&barr.done)) {
+			if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+				local_bh_disable();
+				local_bh_enable();
+			} else {
+				cpu_relax();
+			}
+		}
+	} else {
+		wait_for_completion(&barr.done);
 	}
+
+	destroy_work_on_stack(&barr.work);
+	return true;
 }
 
 /**
@@ -4102,6 +4129,7 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
  */
 bool flush_work(struct work_struct *work)
 {
+	might_sleep();
 	return __flush_work(work, false);
 }
 EXPORT_SYMBOL_GPL(flush_work);
@@ -4191,6 +4219,11 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 
 	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
 
+	if (*work_data_bits(work) & WORK_OFFQ_BH)
+		WARN_ON_ONCE(in_hardirq());
+	else
+		might_sleep();
+
 	/*
 	 * Skip __flush_work() during early boot when we know that @work isn't
 	 * executing. This allows canceling during early boot.
@@ -4217,19 +4250,19 @@ EXPORT_SYMBOL(cancel_work);
  * cancel_work_sync - cancel a work and wait for it to finish
  * @work: the work to cancel
  *
- * Cancel @work and wait for its execution to finish.  This function
- * can be used even if the work re-queues itself or migrates to
- * another workqueue.  On return from this function, @work is
- * guaranteed to be not pending or executing on any CPU.
+ * Cancel @work and wait for its execution to finish. This function can be used
+ * even if the work re-queues itself or migrates to another workqueue. On return
+ * from this function, @work is guaranteed to be not pending or executing on any
+ * CPU as long as there aren't racing enqueues.
  *
- * cancel_work_sync(&delayed_work->work) must not be used for
- * delayed_work's.  Use cancel_delayed_work_sync() instead.
+ * cancel_work_sync(&delayed_work->work) must not be used for delayed_work's.
+ * Use cancel_delayed_work_sync() instead.
  *
- * The caller must ensure that the workqueue on which @work was last
- * queued can't be destroyed before this function returns.
+ * Must be called from a sleepable context if @work was last queued on a non-BH
+ * workqueue. Can also be called from non-hardirq atomic contexts including BH
+ * if @work was last queued on a BH workqueue.
  *
- * Return:
- * %true if @work was pending, %false otherwise.
+ * Returns %true if @work was pending, %false otherwise.
  */
 bool cancel_work_sync(struct work_struct *work)
 {
@@ -4299,8 +4332,11 @@ EXPORT_SYMBOL_GPL(disable_work);
  * Similar to disable_work() but also wait for @work to finish if currently
  * executing.
  *
- * Must be called from a sleepable context. Returns %true if @work was pending,
- * %false otherwise.
+ * Must be called from a sleepable context if @work was last queued on a non-BH
+ * workqueue. Can also be called from non-hardirq atomic contexts including BH
+ * if @work was last queued on a BH workqueue.
+ *
+ * Returns %true if @work was pending, %false otherwise.
  */
 bool disable_work_sync(struct work_struct *work)
 {
-- 
2.43.2


