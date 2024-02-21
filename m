Return-Path: <linux-kernel+bounces-75216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8441B85E4CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E39286981
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5F58565B;
	Wed, 21 Feb 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP6r4wOK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D78562D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537431; cv=none; b=GY1cmCSXbEq73Mnx75YPt2ApiXFf6i96Jx7sy2w8brKBt70r/+Vigw7E5kxg0TYSVX/G1rnNz1h9G4HChmclIoQZlvj5SC4niMYLDSpgh3XsAJSeilgcR1vjuoGXQUusvE/cT1ih9e0gKNAxbAS5BjwzWZwpaWfeHtI0/i8FCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537431; c=relaxed/simple;
	bh=4fQGQMiHqMRif8Nyr1W+8rkj7MUy7ITfhpNzvvCO2Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBes+UPS7NTIInibSEgPpn31tG0JgSZVc7QxrFirpJDW0ml3IHq/jM+XYlFjGzmqC2+E7k0X5BpJhtmNm6tpRBOSJdrKgiX61p5ZhY6zSbjyWdCbqZEXDus+V4SPALYKPN/+P/KQhITXKiLsQ0NyRzqBNSUFCJs5nMIwRw7hHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP6r4wOK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so4047284b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537429; x=1709142229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZMt/Io3+UUtSwyRSg89jJeQkGY0oywbcYSKOgFfEvQ=;
        b=JP6r4wOKXBlGpVgMIP4/349lojrUawS5TT2aBnmPpHHdZaayoTYcKV5iGuqdSHYS8Z
         c4KMW6qrJOvep+1qtsWjpJuF8EdshWOH29Rp2BWAH//qcwP3S2Q9EjkbgfkAYHAfVWny
         Y6iwIdVJlnYW3/60G+ZSj/GzyCSO8swFrXFcpmpy0G9EvhPiEwG2udFItKzMUrmGWTc2
         dCozUl995OE7lWLVLjNuzAIaut3YMeEaCc5hSOqL7ERRvLc8YqwuW73j/SstCUC6Bf+z
         CKJmUL5PUjMsFyfAli013W9IRIwkfT6V2UvOiF78cHfzeP7G/SMdaum+dzrRcTPdDzhK
         1Rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537429; x=1709142229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZMt/Io3+UUtSwyRSg89jJeQkGY0oywbcYSKOgFfEvQ=;
        b=XNlMRbgd7rMtFozWW0Np8Ct+Slefob2chUbtAKNeovMPrzxivCMzlBp1satqrNWXQb
         2gdPoKMiFg3XQNv5AW5KmHbMCT3C/QAbnXhz7/c4AzbK5CndB814dHTnHsMSjv+wk4Pa
         eE85zMQcIzrlXXkGDkzfz3RtK7TPsPtptuAJrTLu1YkHyOvBDaibJbbKSZMqyiFytVLF
         +lt16vk/OkxXFF+2rKgLCD48f9cCLjy+fhl19+DA/T33Sw+mmazLYtounA1eoiNOB8L1
         z9Cs6PY8zAtNQmOicWdL1gltkkc6j0/LA51Hn1A1dib48KH5pGrCDenqF38HLSSv9+q3
         fYzw==
X-Forwarded-Encrypted: i=1; AJvYcCXSQD+zEQFQQTgZ09gFqz4DT7uYUV2k0F0lmgoyyAHnME3ljVvZo2LRTBCYdfhrRfMQtQZuZ6UaCu8oJ+RVEYgDR/W0jtsOSYbLG/WR
X-Gm-Message-State: AOJu0Yzu8ir7IvTB8OT9bcNhFZcOObydudE9+cU4M6U1QXuaBhj8B1hi
	Z4TwIwosoAq/pClowPCeHMYsMVVwppQVfm4hI0EZtNs8we+lblLO
X-Google-Smtp-Source: AGHT+IHfQrTHMsTfDDz3prlS868jCVYr9QFFE6QsdNWQu0fhZvNaPmdc0r9iEHxp3cGCGNkczlKOVg==
X-Received: by 2002:a05:6a21:2d07:b0:19e:99c0:c1eb with SMTP id tw7-20020a056a212d0700b0019e99c0c1ebmr25730977pzb.51.1708537429501;
        Wed, 21 Feb 2024 09:43:49 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id mj5-20020a17090b368500b002997c1ec62csm8152140pjb.16.2024.02.21.09.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:49 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/7] workqueue: Update how start_flush_work() is called
Date: Wed, 21 Feb 2024 07:43:03 -1000
Message-ID: <20240221174333.700197-6-tj@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221174333.700197-1-tj@kernel.org>
References: <20240221174333.700197-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prepartion of in-BH canceling of BH work items, update start_flush_work()
so that:

- rcu_read_lock()'ing is moved to the caller.

- Instead of true or false, it now returns the worker_pool associated with
  the work item if the work item needs to be waited for. NULL if waiting is
  not needed.

- Add a WARN if it encounters a queued work item when @from_cancel. This
  shouldn't happen.

No behavior changes are intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a03252ef3c8f..71a53bec4631 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4004,8 +4004,9 @@ void drain_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL_GPL(drain_workqueue);
 
-static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
-			     bool from_cancel)
+static struct worker_pool *start_flush_work(struct work_struct *work,
+					    struct wq_barrier *barr,
+					    bool from_cancel)
 {
 	struct worker *worker = NULL;
 	struct worker_pool *pool;
@@ -4014,12 +4015,9 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 
 	might_sleep();
 
-	rcu_read_lock();
 	pool = get_work_pool(work);
-	if (!pool) {
-		rcu_read_unlock();
-		return false;
-	}
+	if (!pool)
+		return NULL;
 
 	raw_spin_lock_irq(&pool->lock);
 	/* see the comment in try_to_grab_pending() with the same code */
@@ -4027,6 +4025,12 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	if (pwq) {
 		if (unlikely(pwq->pool != pool))
 			goto already_gone;
+		/*
+		 * Cancel path should already have removed @work from worklist
+		 * in try_to_grab_pending(). Control should get here iff we need
+		 * to wait for the current execution to finish.
+		 */
+		WARN_ON_ONCE(from_cancel);
 	} else {
 		worker = find_worker_executing_work(pool, work);
 		if (!worker)
@@ -4054,17 +4058,16 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 	if (!from_cancel && (wq->saved_max_active == 1 || wq->rescuer))
 		touch_wq_lockdep_map(wq);
 
-	rcu_read_unlock();
-	return true;
+	return pool;
 already_gone:
 	raw_spin_unlock_irq(&pool->lock);
-	rcu_read_unlock();
-	return false;
+	return NULL;
 }
 
 static bool __flush_work(struct work_struct *work, bool from_cancel)
 {
 	struct wq_barrier barr;
+	struct worker_pool *pool;
 
 	if (WARN_ON(!wq_online))
 		return false;
@@ -4072,13 +4075,15 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 	if (WARN_ON(!work->func))
 		return false;
 
-	if (start_flush_work(work, &barr, from_cancel)) {
-		wait_for_completion(&barr.done);
-		destroy_work_on_stack(&barr.work);
-		return true;
-	} else {
+	rcu_read_lock();
+	pool = start_flush_work(work, &barr, from_cancel);
+	rcu_read_unlock();
+	if (!pool)
 		return false;
-	}
+
+	wait_for_completion(&barr.done);
+	destroy_work_on_stack(&barr.work);
+	return true;
 }
 
 /**
-- 
2.43.2


