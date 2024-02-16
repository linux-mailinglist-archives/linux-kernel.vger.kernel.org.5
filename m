Return-Path: <linux-kernel+bounces-69133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B298584E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D920B1F2181C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479FF134CE6;
	Fri, 16 Feb 2024 18:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxQg/DY1"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CC145FE7
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708106803; cv=none; b=gRtk5Hw4EiGKFBGje4Wb6SD5ipWy0LuKyAQ3bybpWUXy+I3NKiBapk8EW+w5MWLnJufN0uu8pi2dUavvdurrfi3PssmMF/EtHbSjdXK/082F0sSVoxxKgJoH1JdPX6TvbmlAS4UrH0P1oVfHfiyy+bhUC+3io8T++pSH8BjGoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708106803; c=relaxed/simple;
	bh=GeKVjnbdns5bK22n91xVMXpiQjcDzrlmZrUwQuwmJNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLfaZ14KT9vainHJ73McKL8UTRy68bxtYdUMM13/+rnu7gjdxO8bsSUDPM7VaSpaIDPOV3VZc2ByPrNjM/Xw+VAM5nhh7ChFfjxRlsiW8+CJP5vIQlden4kSYWXV9Vb6JNf2Upk5FO6ze4daG+Vl8oiSXqqSMjH1wmJdGmYLLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxQg/DY1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d934c8f8f7so24377895ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708106801; x=1708711601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xh5X4jP++uuYjnXCzqnuN7YFRsni8pg3IhpUUiVDrs=;
        b=HxQg/DY19kgVTQYYQeSe163DCTvpVZfhgbSGL/0kk9ctmF1v6fkVYnDdLfsaU3+b5o
         +k3vsAg7RiTb6QX1rHLwxajUgMVCW5B09mgV7e5y+7qPOKZJXeTLQsDaBzGLb+deHZdu
         9s+LZayjhU6Roy+Q1/ZdN8jEKQzHHB4B/mncFzMTu9w5N5gMsO01AMm7bdCyUU2Qj+o5
         rEkUzYbH8KSI3hlE8DCl6k9ZkklGAU3KbuNMs7Vxzj8IDbaLCH0QFVO1ZSuhcuzCdmCa
         81TuMerbDPv9tVo1iRdkf/EToAzoVOw2LuzmYTQO0nOCmTJ8iY3qmS33d7CDEWp8IzOE
         un6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708106801; x=1708711601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xh5X4jP++uuYjnXCzqnuN7YFRsni8pg3IhpUUiVDrs=;
        b=WSrd3vj7wsPPiF2fS/Vqy9dKBXR97W4l/awTOZQgN4rzu5O6DU6a4gG/OikpA3VoN+
         myNXovh0oR4+s8rmLbQFhk+aWYNy9AOrWaitLU5625OvK5NvdjNwNLvylu/RuBcD9TjU
         6BbZVbJiGoPudOppkrJw27j4NFqdZ0aRneEc5ClOFGwwJtmDsMJIxKPTPQL5tJ0c+gK9
         dGxYWRnUrsqffdnGQLvkHYgDttJlyDoYqGOYmyKv6xwxbpDTE+ngF0FbMSxzmdutxIR6
         1TvGzsNtboGKDXtNu13ivXp7cwb1w63WKH8QpAresbYAhOwSCQ1J/Jgc8PVRw3772tVM
         ynTw==
X-Forwarded-Encrypted: i=1; AJvYcCUZp4PESHbAmnCBIp5/gCiK+4dzWbnuwxSxNadOlaexb+lN8dzzTfOJNZlg4XMQpaI9/yNzdfNRLJ10cWCu+CCVojGDi/W0vw8wXw6v
X-Gm-Message-State: AOJu0Yzt5a6iK1FddYS/pPZttM1Ay3hBT8j3nCraCOgmKTU0G1qtsujz
	nb5/qUOC5GP3p/Px2JdGLTijJR/R9n73VjphnFinjcxPy8PhlcwH
X-Google-Smtp-Source: AGHT+IGCyRaiMUx2Bt5zoWwdAxZSp0LwoZV/te6OrDr4/esIfdwFh3lr/ZU0l0dqxGhgewJrecxjTg==
X-Received: by 2002:a17:903:1c2:b0:1db:a2bc:22bb with SMTP id e2-20020a17090301c200b001dba2bc22bbmr3223151plh.41.1708106800941;
        Fri, 16 Feb 2024 10:06:40 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b001d720a7a616sm146700plh.165.2024.02.16.10.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 10:06:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/17] workqueue: Update how start_flush_work() is called
Date: Fri, 16 Feb 2024 08:04:56 -1000
Message-ID: <20240216180559.208276-16-tj@kernel.org>
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
index 6a2abc81ae2b..f6ea25628701 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3995,8 +3995,9 @@ void drain_workqueue(struct workqueue_struct *wq)
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
@@ -4005,12 +4006,9 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
 
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
@@ -4018,6 +4016,12 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
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
@@ -4045,17 +4049,16 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
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
@@ -4063,13 +4066,15 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
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


