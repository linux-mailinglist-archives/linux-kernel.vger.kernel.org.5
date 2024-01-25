Return-Path: <linux-kernel+bounces-38998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 964C483C987
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FCD28F9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD213667A;
	Thu, 25 Jan 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAg5FnUq"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115271292F1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202394; cv=none; b=QzLMckkqA6VaKoFSvZmDH7zf/S0mbf8k1TGefq7extKbg+doesLdtmntboX38d//a27vKTnPXy/3O1bMBtI3TL90Pr+o850SE1iSznmq2KBdmq7oYoOYjGoISKslENmz2XtyF80dQHh+fx+w0yO/hhJafvLj6DEoeQ4t9hOuKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202394; c=relaxed/simple;
	bh=tHaCGiHYjjOvotqUAP75jtwPGcfMtkbUj+arO9XpAIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7PG/ifAFsNwsAPrCi1zmQAMB58JIfJ27xYIWkAAqrHGZ7YIj3bDOhNziepKEQTdEaZI1wWokF7t2WPdC/81R/SkTan37GJXjwFhmhY1PeZnDDADdkdAu6Hv8XRDxDEFvdJzQP+Hrab9xDpHCCxix5YSXRwOuQ7H8VEBB20aGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAg5FnUq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290b9f83037so743006a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202392; x=1706807192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8aqxMtLvyQraeLHjZZtjq/H+09uA3xQxGGRy0QTkLU=;
        b=EAg5FnUqPeb2eX1IkpQ87+L9T5BkeSEJc3yE9jR5oBVm+sCm91js3PtISUP+blpSK1
         JFr1AG9VJN+ufSyRBaBOb0QX2QoEIvS3PdROM0Vlz9+KCZtWm2kHVlBY0V9fN1jULQJ1
         i3ENSkDNO6++1uyoDW9KKzgQSCImyZF8QhIVMAMnYoiHv2NBNY5pMFgduObaf3nGRB7Z
         vZUX0b6aenlgFkF1lt7H3U7JcAEhto0vqR3RmDvu9m3uls8JNtIU+2jWIucAx+nc5gdh
         ZSGkYWLr0ftJFId0G0zq7gseY1MC2UbEwws6y7SUd774jYfbJ98nozEm7Pdot3M78ai7
         dhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202392; x=1706807192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8aqxMtLvyQraeLHjZZtjq/H+09uA3xQxGGRy0QTkLU=;
        b=q7kAnxeQLhiYO9OvNNM9MjSY9UqNR04opMWz9zCyGFbBhqF3n9msjRhb+rWfEhC7jJ
         tE7PrPAEOBG5JqF1LsCDihHf2t21v41MOfhdR7fF6mcJbWi74dTfTPedrwFGIuHRZkaP
         eOYCLprEDMjJWk8tl3KAEmtMQ9OAkK4n2yWJirhiL3sLwViVbuoacgT7EeY3w1aJBGWv
         TojGFSNFTzHoL/fpPbnU2qJyeNE/Wmo9DlhyuO6nn3NMg3GuJ5AZHgJjCLhtYW5sZiCh
         aBs3sor9PpXl7KuFCULAgvK14Z0zbI9Gl+YPn3TS8uR7RmrH9rWc1LcRLE1ks/9VIn4i
         lyMQ==
X-Gm-Message-State: AOJu0Yx/BI7kyMfzJCqo1FN12mzQowVqiObwQlFk0bSR2YYKXeZDc8GQ
	lQVkKSmcMiQKgc/RtOdhDQ0kEBWASTvyxp6XHuwiQmqEwGBV9KfgPBtcBYZd
X-Google-Smtp-Source: AGHT+IEmrTfJNbBiCJSPKNLjB/46yF85grX/KsTQpucODjQeGzXnOH+CAK2omi/GHLt2hetW+h6jqw==
X-Received: by 2002:a17:90b:388b:b0:28e:79f9:b6c3 with SMTP id mu11-20020a17090b388b00b0028e79f9b6c3mr125245pjb.15.1706202392164;
        Thu, 25 Jan 2024 09:06:32 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ft8-20020a17090b0f8800b00290d2385af5sm1783239pjb.27.2024.01.25.09.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:31 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/10] workqueue: Move pwq->max_active to wq->max_active
Date: Thu, 25 Jan 2024 07:05:54 -1000
Message-ID: <20240125170628.2017784-2-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
References: <20240125170628.2017784-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

max_active is a workqueue-wide setting and the configured value is stored in
wq->saved_max_active; however, the effective value was stored in
pwq->max_active. While this is harmless, it makes max_active update process
more complicated and gets in the way of the planned max_active semantic
updates for unbound workqueues.

This patches moves pwq->max_active to wq->max_active. This simplifies the
code and makes freezing and noop max_active updates cheaper too. No
user-visible behavior change is intended.

As wq->max_active is updated while holding wq mutex but read without any
locking, it now uses WRITE/READ_ONCE(). A new locking locking rule WO is
added for it.

v2: wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 133 ++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 8ca65665efe9..67d9ac1f0990 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -143,6 +143,9 @@ enum {
  *
  * WR: wq->mutex protected for writes.  RCU protected for reads.
  *
+ * WO: wq->mutex protected for writes. Updated with WRITE_ONCE() and can be read
+ *     with READ_ONCE() without locking.
+ *
  * MD: wq_mayday_lock protected.
  *
  * WD: Used internally by the watchdog.
@@ -250,7 +253,6 @@ struct pool_workqueue {
 	 * is marked with WORK_STRUCT_INACTIVE iff it is in pwq->inactive_works.
 	 */
 	int			nr_active;	/* L: nr of active works */
-	int			max_active;	/* L: max active works */
 	struct list_head	inactive_works;	/* L: inactive works */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
@@ -298,7 +300,8 @@ struct workqueue_struct {
 	struct worker		*rescuer;	/* MD: rescue worker */
 
 	int			nr_drainers;	/* WQ: drain in progress */
-	int			saved_max_active; /* WQ: saved pwq max_active */
+	int			max_active;	/* WO: max active works */
+	int			saved_max_active; /* WQ: saved max_active */
 
 	struct workqueue_attrs	*unbound_attrs;	/* PW: only for unbound wqs */
 	struct pool_workqueue	*dfl_pwq;	/* PW: only for unbound wqs */
@@ -1492,7 +1495,7 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 		pwq->nr_active--;
 		if (!list_empty(&pwq->inactive_works)) {
 			/* one down, submit an inactive one */
-			if (pwq->nr_active < pwq->max_active)
+			if (pwq->nr_active < READ_ONCE(pwq->wq->max_active))
 				pwq_activate_first_inactive(pwq);
 		}
 	}
@@ -1793,7 +1796,13 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	pwq->nr_in_flight[pwq->work_color]++;
 	work_flags = work_color_to_flags(pwq->work_color);
 
-	if (likely(pwq->nr_active < pwq->max_active)) {
+	/*
+	 * Limit the number of concurrently active work items to max_active.
+	 * @work must also queue behind existing inactive work items to maintain
+	 * ordering when max_active changes. See wq_adjust_max_active().
+	 */
+	if (list_empty(&pwq->inactive_works) &&
+	    pwq->nr_active < READ_ONCE(pwq->wq->max_active)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
@@ -4143,50 +4152,6 @@ static void pwq_release_workfn(struct kthread_work *work)
 	}
 }
 
-/**
- * pwq_adjust_max_active - update a pwq's max_active to the current setting
- * @pwq: target pool_workqueue
- *
- * If @pwq isn't freezing, set @pwq->max_active to the associated
- * workqueue's saved_max_active and activate inactive work items
- * accordingly.  If @pwq is freezing, clear @pwq->max_active to zero.
- */
-static void pwq_adjust_max_active(struct pool_workqueue *pwq)
-{
-	struct workqueue_struct *wq = pwq->wq;
-	bool freezable = wq->flags & WQ_FREEZABLE;
-	unsigned long flags;
-
-	/* for @wq->saved_max_active */
-	lockdep_assert_held(&wq->mutex);
-
-	/* fast exit for non-freezable wqs */
-	if (!freezable && pwq->max_active == wq->saved_max_active)
-		return;
-
-	/* this function can be called during early boot w/ irq disabled */
-	raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-
-	/*
-	 * During [un]freezing, the caller is responsible for ensuring that
-	 * this function is called at least once after @workqueue_freezing
-	 * is updated and visible.
-	 */
-	if (!freezable || !workqueue_freezing) {
-		pwq->max_active = wq->saved_max_active;
-
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < pwq->max_active)
-			pwq_activate_first_inactive(pwq);
-
-		kick_pool(pwq->pool);
-	} else {
-		pwq->max_active = 0;
-	}
-
-	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-}
-
 /* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
@@ -4219,9 +4184,6 @@ static void link_pwq(struct pool_workqueue *pwq)
 	/* set the matching work_color */
 	pwq->work_color = wq->work_color;
 
-	/* sync max_active to the current setting */
-	pwq_adjust_max_active(pwq);
-
 	/* link in @pwq */
 	list_add_rcu(&pwq->pwqs_node, &wq->pwqs);
 }
@@ -4662,6 +4624,52 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
+/**
+ * wq_adjust_max_active - update a wq's max_active to the current setting
+ * @wq: target workqueue
+ *
+ * If @wq isn't freezing, set @wq->max_active to the saved_max_active and
+ * activate inactive work items accordingly. If @wq is freezing, clear
+ * @wq->max_active to zero.
+ */
+static void wq_adjust_max_active(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+
+	lockdep_assert_held(&wq->mutex);
+
+	if ((wq->flags & WQ_FREEZABLE) && workqueue_freezing) {
+		WRITE_ONCE(wq->max_active, 0);
+		return;
+	}
+
+	if (wq->max_active == wq->saved_max_active)
+		return;
+
+	/*
+	 * Update @wq->max_active and then kick inactive work items if more
+	 * active work items are allowed. This doesn't break work item ordering
+	 * because new work items are always queued behind existing inactive
+	 * work items if there are any.
+	 */
+	WRITE_ONCE(wq->max_active, wq->saved_max_active);
+
+	for_each_pwq(pwq, wq) {
+		unsigned long flags;
+
+		/* this function can be called during early boot w/ irq disabled */
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+
+		while (!list_empty(&pwq->inactive_works) &&
+		       pwq->nr_active < wq->max_active)
+			pwq_activate_first_inactive(pwq);
+
+		kick_pool(pwq->pool);
+
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+	}
+}
+
 __printf(1, 4)
 struct workqueue_struct *alloc_workqueue(const char *fmt,
 					 unsigned int flags,
@@ -4669,7 +4677,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 {
 	va_list args;
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 	int len;
 
 	/*
@@ -4708,6 +4715,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	/* init wq */
 	wq->flags = flags;
+	wq->max_active = max_active;
 	wq->saved_max_active = max_active;
 	mutex_init(&wq->mutex);
 	atomic_set(&wq->nr_pwqs_to_flush, 0);
@@ -4736,8 +4744,7 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	mutex_lock(&wq_pool_mutex);
 
 	mutex_lock(&wq->mutex);
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
+	wq_adjust_max_active(wq);
 	mutex_unlock(&wq->mutex);
 
 	list_add_tail_rcu(&wq->list, &workqueues);
@@ -4875,8 +4882,6 @@ EXPORT_SYMBOL_GPL(destroy_workqueue);
  */
 void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 {
-	struct pool_workqueue *pwq;
-
 	/* disallow meddling with max_active for ordered workqueues */
 	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
 		return;
@@ -4887,9 +4892,7 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 
 	wq->flags &= ~__WQ_ORDERED;
 	wq->saved_max_active = max_active;
-
-	for_each_pwq(pwq, wq)
-		pwq_adjust_max_active(pwq);
+	wq_adjust_max_active(wq);
 
 	mutex_unlock(&wq->mutex);
 }
@@ -5136,8 +5139,8 @@ static void show_pwq(struct pool_workqueue *pwq)
 	pr_info("  pwq %d:", pool->id);
 	pr_cont_pool_info(pool);
 
-	pr_cont(" active=%d/%d refcnt=%d%s\n",
-		pwq->nr_active, pwq->max_active, pwq->refcnt,
+	pr_cont(" active=%d refcnt=%d%s\n",
+		pwq->nr_active, pwq->refcnt,
 		!list_empty(&pwq->mayday_node) ? " MAYDAY" : "");
 
 	hash_for_each(pool->busy_hash, bkt, worker, hentry) {
@@ -5685,7 +5688,6 @@ EXPORT_SYMBOL_GPL(work_on_cpu_safe_key);
 void freeze_workqueues_begin(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5694,8 +5696,7 @@ void freeze_workqueues_begin(void)
 
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
@@ -5760,7 +5761,6 @@ bool freeze_workqueues_busy(void)
 void thaw_workqueues(void)
 {
 	struct workqueue_struct *wq;
-	struct pool_workqueue *pwq;
 
 	mutex_lock(&wq_pool_mutex);
 
@@ -5772,8 +5772,7 @@ void thaw_workqueues(void)
 	/* restore max_active and repopulate worklist */
 	list_for_each_entry(wq, &workqueues, list) {
 		mutex_lock(&wq->mutex);
-		for_each_pwq(pwq, wq)
-			pwq_adjust_max_active(pwq);
+		wq_adjust_max_active(wq);
 		mutex_unlock(&wq->mutex);
 	}
 
-- 
2.43.0


