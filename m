Return-Path: <linux-kernel+bounces-39001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE083C98A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D509B27212
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3513DBB0;
	Thu, 25 Jan 2024 17:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHNLegyV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751B313D51A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202399; cv=none; b=rXPbO8qxdLRslMrAM4sq01kQNBeLmczrYb9PxtHalmmBkSRL+8M6ygmgN+1wVw1mDkboNvkarF43OBsV9fAGGAWVAhAY2Qr6Q8kET9EDuqXghkEtUhZANtlNF0hrtX4OL3fyGCLfRYLg61bvrvGE5Ggc8N9iTwXwYAamaM+qYZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202399; c=relaxed/simple;
	bh=+tCMWSE2szClLYv7bFxkQ7nvgpnyXrgjQocHvOCok8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kId24K+0hmoQ+gvJvUkjs9cA+wXLCbXlCS5MfuoyjTKagwQHUcGMJ0gJBWLbmbr/VCS7pJJGIPlJsbY1tDi8bEV7kxjLxxQRL1SepCej2Jc/8sIOFrVuLoWNOfaCXV7cloaZYtH/ofDRWy35AZroebSVMAefdHmMaXuLF420RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHNLegyV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ddcfbc569dso649189b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202397; x=1706807197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jha+NR5Ao6Wy5J8HzZvSArFX6rZQPh5N7E6tL94yFgY=;
        b=aHNLegyVg7dCeB+PkLqGyMzpNt5TkgI+ViLHPE0oHRQrRIMoWdROBAocwyuw59RIBl
         kpCakzagNyCvWgCEx//8d24b9Q5YVs/wyaAr2e3eDaq6uihQuHI7ut3lkpbGBpLXayjd
         IoHalhuUW8xE4fwFtzVwESaagl8jup7fRhxQRApg6m3eD2xD/HVL8pV94uagewbKRoqr
         EZzxFZFsEq/hFvebCmB17KmQGTHu02TqjTrSLMrSIZW8l0KTd7GiWNEqr7y6FYs9Yl5v
         SSXBDebQBMwD5GLQKBAg6QUb97kR4Xepu4mn3uZUhIsihHr9wf3Xq7yZ/IPn3LA4RF4i
         cWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202397; x=1706807197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jha+NR5Ao6Wy5J8HzZvSArFX6rZQPh5N7E6tL94yFgY=;
        b=tUpanJQuJ2GnoPksOnmUG4pQeqxGd27huSdwKuR0gvQs0ivwCEANSrkL5ItFjZSZCj
         ZAiW0lpdrfVhfh4O2atMmBQdJaT2SmJik+dRs1x4F8YOBzdvNJ5nmphh6VGYlviUI0MC
         b5ugpII6nBG3meWqGrQtcickKPXlT3nyj++MYiPYCw0OPOET+xsxoamYwYhM7kOzw6Cv
         jHdL1lBflpiCDNTa6s1dmypRY0D+QAUXXXkg4JFwXaUY9eybCSPwfiMu5SCCz7yKlVmD
         erir8vBGrFxBCn5y75Tz33PjVIM5KZAsF+ppDYy7PB3Z0ejDmPr+NM5vqRj/ShqlxbqX
         63Zw==
X-Gm-Message-State: AOJu0Yxu0v3L8AIlg8P3Bc9OZbsgmxEQ5jgtQX+Mz6lVk0CGNGg1/J92
	ma6g1+RRMXpaONdo1DhLSjegc/WrqbLHrCrOTIWGlNGw6yeX6/6YlYcC2L5E
X-Google-Smtp-Source: AGHT+IGW0lSSph6hbxLxsySU8p4lc2F+dD+EaV3UmLtM+u4Ke+CZYFc+Qpu+MoD8/ZLj//ItKJ+UIQ==
X-Received: by 2002:a62:8e09:0:b0:6db:d6d2:6555 with SMTP id k9-20020a628e09000000b006dbd6d26555mr1000062pfe.62.1706202396695;
        Thu, 25 Jan 2024 09:06:36 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id fi35-20020a056a0039a300b006d94291679asm16098080pfb.78.2024.01.25.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] workqueue: Move nr_active handling into helpers
Date: Thu, 25 Jan 2024 07:05:57 -1000
Message-ID: <20240125170628.2017784-5-tj@kernel.org>
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

__queue_work(), pwq_dec_nr_in_flight() and wq_adjust_max_active() were
open-coding nr_active handling, which is fine given that the operations are
trivial. However, the planned unbound nr_active update will make them more
complicated, so let's move them into helpers.

- pwq_tryinc_nr_active() is added. It increments nr_active if under
  max_active limit and return a boolean indicating whether inc was
  successful. Note that the function is structured to accommodate future
  changes. __queue_work() is updated to use the new helper.

- pwq_activate_first_inactive() is updated to use pwq_tryinc_nr_active() and
  thus no longer assumes that nr_active is under max_active and returns a
  boolean to indicate whether a work item has been activated.

- wq_adjust_max_active() no longer tests directly whether a work item can be
  activated. Instead, it's updated to use the return value of
  pwq_activate_first_inactive() to tell whether a work item has been
  activated.

- nr_active decrement and activating the first inactive work item is
  factored into pwq_dec_nr_active().

v3: - WARN_ON_ONCE(!WORK_STRUCT_INACTIVE) added to __pwq_activate_work() as
      now we're calling the function unconditionally from
      pwq_activate_first_inactive().

v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 86 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 67 insertions(+), 19 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3a4c269204f3..6a0ce3a3cca2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1464,11 +1464,14 @@ static bool pwq_is_empty(struct pool_workqueue *pwq)
 static void __pwq_activate_work(struct pool_workqueue *pwq,
 				struct work_struct *work)
 {
+	unsigned long *wdb = work_data_bits(work);
+
+	WARN_ON_ONCE(!(*wdb & WORK_STRUCT_INACTIVE));
 	trace_workqueue_activate_work(work);
 	if (list_empty(&pwq->pool->worklist))
 		pwq->pool->watchdog_ts = jiffies;
 	move_linked_works(work, &pwq->pool->worklist, NULL);
-	__clear_bit(WORK_STRUCT_INACTIVE_BIT, work_data_bits(work));
+	__clear_bit(WORK_STRUCT_INACTIVE_BIT, wdb);
 }
 
 /**
@@ -1493,12 +1496,66 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
 	return true;
 }
 
-static void pwq_activate_first_inactive(struct pool_workqueue *pwq)
+/**
+ * pwq_tryinc_nr_active - Try to increment nr_active for a pwq
+ * @pwq: pool_workqueue of interest
+ *
+ * Try to increment nr_active for @pwq. Returns %true if an nr_active count is
+ * successfully obtained. %false otherwise.
+ */
+static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
+{
+	struct workqueue_struct *wq = pwq->wq;
+	struct worker_pool *pool = pwq->pool;
+	bool obtained;
+
+	lockdep_assert_held(&pool->lock);
+
+	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
+
+	if (obtained)
+		pwq->nr_active++;
+	return obtained;
+}
+
+/**
+ * pwq_activate_first_inactive - Activate the first inactive work item on a pwq
+ * @pwq: pool_workqueue of interest
+ *
+ * Activate the first inactive work item of @pwq if available and allowed by
+ * max_active limit.
+ *
+ * Returns %true if an inactive work item has been activated. %false if no
+ * inactive work item is found or max_active limit is reached.
+ */
+static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
+{
+	struct work_struct *work =
+		list_first_entry_or_null(&pwq->inactive_works,
+					 struct work_struct, entry);
+
+	if (work && pwq_tryinc_nr_active(pwq)) {
+		__pwq_activate_work(pwq, work);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+/**
+ * pwq_dec_nr_active - Retire an active count
+ * @pwq: pool_workqueue of interest
+ *
+ * Decrement @pwq's nr_active and try to activate the first inactive work item.
+ */
+static void pwq_dec_nr_active(struct pool_workqueue *pwq)
 {
-	struct work_struct *work = list_first_entry(&pwq->inactive_works,
-						    struct work_struct, entry);
+	struct worker_pool *pool = pwq->pool;
 
-	pwq_activate_work(pwq, work);
+	lockdep_assert_held(&pool->lock);
+
+	pwq->nr_active--;
+	pwq_activate_first_inactive(pwq);
 }
 
 /**
@@ -1516,14 +1573,8 @@ static void pwq_dec_nr_in_flight(struct pool_workqueue *pwq, unsigned long work_
 {
 	int color = get_work_color(work_data);
 
-	if (!(work_data & WORK_STRUCT_INACTIVE)) {
-		pwq->nr_active--;
-		if (!list_empty(&pwq->inactive_works)) {
-			/* one down, submit an inactive one */
-			if (pwq->nr_active < READ_ONCE(pwq->wq->max_active))
-				pwq_activate_first_inactive(pwq);
-		}
-	}
+	if (!(work_data & WORK_STRUCT_INACTIVE))
+		pwq_dec_nr_active(pwq);
 
 	pwq->nr_in_flight[color]--;
 
@@ -1825,13 +1876,11 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * @work must also queue behind existing inactive work items to maintain
 	 * ordering when max_active changes. See wq_adjust_max_active().
 	 */
-	if (list_empty(&pwq->inactive_works) &&
-	    pwq->nr_active < READ_ONCE(pwq->wq->max_active)) {
+	if (list_empty(&pwq->inactive_works) && pwq_tryinc_nr_active(pwq)) {
 		if (list_empty(&pool->worklist))
 			pool->watchdog_ts = jiffies;
 
 		trace_workqueue_activate_work(work);
-		pwq->nr_active++;
 		insert_work(pwq, work, &pool->worklist, work_flags);
 		kick_pool(pool);
 	} else {
@@ -4684,9 +4733,8 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 		/* this function can be called during early boot w/ irq disabled */
 		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
 
-		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < wq->max_active)
-			pwq_activate_first_inactive(pwq);
+		while (pwq_activate_first_inactive(pwq))
+			;
 
 		kick_pool(pwq->pool);
 
-- 
2.43.0


