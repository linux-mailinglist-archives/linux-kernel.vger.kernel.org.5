Return-Path: <linux-kernel+bounces-75217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D1F85E4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964012853CE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503985948;
	Wed, 21 Feb 2024 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWlbRnCo"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522385659
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537433; cv=none; b=bhfaPI0IToNFy25IrkVhujvB207GxbL7Ogmwg1DIGEPgQi0PGik1HQmr/iZAgqH94nKiLPZQnUNjf/PJwuJbEuVW6/X5sZyeLHsuxsP9bYIwJ5f4gwnQN2R4EqYw/K5/760mn/oHQkdnulrU+rkiZsXvLyAtjGEBQg4UIz5HMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537433; c=relaxed/simple;
	bh=S0RuiQevjMlYgqxWp3So6NSxDuSVYSFAubbX2xvEfmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtqAl8gLY5xoAu9dbgwDQr5PSeL9Xlfug4yK6dU+h0blEbH2DIpVi0MhqAPlgKwcB+SpdC3r+qFUquIp1DBzNinIv1uqCsn4cwXXy3ede4ngXhk1ikXCV/REKFGRTF6i4BbLkLn5qfuDcGWWG3F66ret82T0u2Pvar0LndAzqy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWlbRnCo; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce942efda5so4422487a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708537431; x=1709142231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4J5X7kFZtGhjG2atVvlFXl8To072VDO3yIhGqaqE1L0=;
        b=nWlbRnComtkkSY9B598DS10RqX4k1vuHhiXzaAD/xqpvAx4rZ5cmVaonEzSF0klgLQ
         012CyArL+RTlr7xTsX0691sHLU249i0+4tnx6jpUfRTD/D7wAuGBTrtLlfVvqDYszr7D
         20FtAh0emSCjum4nR5OCkP+bHrvL7A4KVKu4dt5qohn3KKBlGu0jMoA8FnpYhlWPGUKO
         rB1Nl6LciuwTD2Mpe+B8IQPOQ6ZSNPY2ikOvOZ6LoI7DXrWe6hDxPA4KEMe3tIKer02n
         aRlcpd79daSOSOvr5K3VLk2gxFKtTXIyf13mIMMbH0qo/wiQbtetqgHX5Cy3D2viINeL
         DKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708537431; x=1709142231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4J5X7kFZtGhjG2atVvlFXl8To072VDO3yIhGqaqE1L0=;
        b=VQgqP5ygzynPr6u+JdxaW28dKM0nrI5g+vyqEdtYMhlGNxoY6lqE7IZRkMF7gVxcYa
         odH9Tsz2OhOrmFIVhfGND5cIEOcKTMkG9pbAB15YUC4cxMh6OE9BqjNAmqcj1Axtd9Qo
         FjsgDORMiCSkbyZ1NW+owlgxJmlDE7LsZ/Z+aiQRvLgSdGRZjp0VBcePBujXzlboXFoR
         6KPP1IOigVE5UCAkpE0c3S1zArp1I548PPos1X5jP4JFsmBOKKpYWfzi+jCVF9p1q/+U
         mV+owchMW+Pe2r2pGJFpZKPJxOZBxM03piXmTU/S0SHbTm4V0gUMaqSwcmatKRsEIxjA
         MIDg==
X-Forwarded-Encrypted: i=1; AJvYcCXNg7r5Zw9FajNm7C9TRaCsXlhdW58/h4Eh1xYNCoRkOgohqMlR2+Hwm7gEsul+DMlCQP0GWovoxc/Dl5sRYC4SdTlw8EzlEjkqVoVG
X-Gm-Message-State: AOJu0YxC6YntmO9BDyQOtz7VxQkvDyFW1jPepgcBTZH8bqdjkQuH0fVy
	ie1GzDzVlU7O4jak8Uepf2U6sK4UFwtZBOaJKU47Qv8RyQ/BIuZv
X-Google-Smtp-Source: AGHT+IEnApy10XZNSxD02mhc2aUdLnwwuyQ1sza0pjItN368ARfiGtrcs7FdaZfsovGfU7osONJz0g==
X-Received: by 2002:a05:6a21:1690:b0:1a0:5841:669d with SMTP id np16-20020a056a21169000b001a05841669dmr20214358pzb.39.1708537431416;
        Wed, 21 Feb 2024 09:43:51 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b006e13a5ab1e5sm7043694pfn.73.2024.02.21.09.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:43:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/7] workqueue: Allow cancel_work_sync() and disable_work() from atomic contexts on BH work items
Date: Wed, 21 Feb 2024 07:43:04 -1000
Message-ID: <20240221174333.700197-7-tj@kernel.org>
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

v2: Lai pointed out that __flush_work() was accessing pool->flags outside
    the RCU critical section protecting the pool pointer. Fix it by testing
    and remembering the result inside the RCU critical section.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c | 64 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 71a53bec4631..e0a65e326fcb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4013,8 +4013,6 @@ static struct worker_pool *start_flush_work(struct work_struct *work,
 	struct pool_workqueue *pwq;
 	struct workqueue_struct *wq;
 
-	might_sleep();
-
 	pool = get_work_pool(work);
 	if (!pool)
 		return NULL;
@@ -4068,6 +4066,7 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 {
 	struct wq_barrier barr;
 	struct worker_pool *pool;
+	bool is_bh;
 
 	if (WARN_ON(!wq_online))
 		return false;
@@ -4077,11 +4076,37 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 
 	rcu_read_lock();
 	pool = start_flush_work(work, &barr, from_cancel);
+	is_bh = pool && (pool->flags & POOL_BH);
 	rcu_read_unlock();
 	if (!pool)
 		return false;
 
-	wait_for_completion(&barr.done);
+	if (is_bh && from_cancel) {
+		/*
+		 * We're flushing a BH work item which is being canceled. It
+		 * must have been executing during start_flush_work() and can't
+		 * currently be queued. If @work is still executing, we know it
+		 * is running in the BH context and thus can be busy-waited.
+		 *
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
+	}
+
 	destroy_work_on_stack(&barr.work);
 	return true;
 }
@@ -4099,6 +4124,7 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
  */
 bool flush_work(struct work_struct *work)
 {
+	might_sleep();
 	return __flush_work(work, false);
 }
 EXPORT_SYMBOL_GPL(flush_work);
@@ -4188,6 +4214,11 @@ static bool __cancel_work_sync(struct work_struct *work, u32 cflags)
 
 	ret = __cancel_work(work, cflags | WORK_CANCEL_DISABLE);
 
+	if (*work_data_bits(work) & WORK_OFFQ_BH)
+		WARN_ON_ONCE(in_hardirq());
+	else
+		might_sleep();
+
 	/*
 	 * Skip __flush_work() during early boot when we know that @work isn't
 	 * executing. This allows canceling during early boot.
@@ -4214,19 +4245,19 @@ EXPORT_SYMBOL(cancel_work);
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
@@ -4296,8 +4327,11 @@ EXPORT_SYMBOL_GPL(disable_work);
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


