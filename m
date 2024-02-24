Return-Path: <linux-kernel+bounces-79346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4A86210D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BE21F24E26
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321DC3D9E;
	Sat, 24 Feb 2024 00:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o5GKo3Kn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F5E15D1
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 00:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733530; cv=none; b=J4h64J4i40ceD7lG7Bv7DHq2J/KezQ3RBNdY8VX3GE1yTVf4aWdSI80Yw6HGZDtXTLOrSzOGPK8O50i/K5DB70BZD+t0okSPZLBaOnNdTTZmPGlB34epNFk2lCriMvdje76CwGyaCVbVLXJZeNt1EhT9NZ9HVt7R5SFRQGVJnDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733530; c=relaxed/simple;
	bh=/MvRuZlBTMH7KRo3ZudNtaXjF43JnT01+5/C5gO6rww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=agTv9Ir4zCHZ3IX/jrhsIQ4xvNdvtwHcL3po4oT+lblD+YeUkpGzSSLu8N0CIbWKDCB1gQrewO9DBH+BVz2JRd4GEbpmH7I35QMDB4AgqIY2UdrVW+qL08wuCMhPH4FKtk7//QhTO93hxPQGAp1224klhaFpKDN97YFMC7nPcSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o5GKo3Kn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so1418633276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708733527; x=1709338327; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=11JYsWA+tSpUAfCtvYdWCKKR13hGRqHQrhgIeQOqs68=;
        b=o5GKo3KnZmd4oulgoa+pgjdraWMGFGmnRQJKlU9bWKx3sy63NOQr4GIbobA5WhXJhI
         Koq6L/GX8cAXLZOKA1chOECue+3k7phXYBZH2Y7UBOWAXqV7rbkQbUCRTx9Zjwqv4nqu
         6lZZeX+PcpwQXiwjRxjAcn6Th+Q2UJ9lBNdCK67YYEn8RMymu2IHzWqxtLVDsSFN1SVi
         H9yN6IK4iAI3QtIEkYwAJ5QliWIcmE/OL2BWwVFW257O05xd0NehRFn1iA9K+QclWih1
         sBnqxVrL95NctFzVIGqPs7ewhy5tcebGnd9gWtT2boQnZSuDmyukODwEuHewxOkk0Ztn
         bO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708733527; x=1709338327;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11JYsWA+tSpUAfCtvYdWCKKR13hGRqHQrhgIeQOqs68=;
        b=qGgEc9dpP567Zu5tRBoF69LGFXa6j/g7k6Vm8GIa73kURzag/zuPyt1NLmK/pWE/4K
         oX7c7Fwpt/dne5uUsIgjYlSoAiO89ox4Fh7FC8KS7BD1rWRZ6Br1/dFbowR4VTd1XUYs
         in7tTGlO058XahMddIAJJNxAUYljzodlAML72FK57glOTU2jM2vbHpemhe/tXsPBeXbC
         hj1vtk4yyxmFFKM+h8nK6X2UCzz892kGW9IGFlSkKl0+9MmFcUEyCFMY0P7WyT6ACq2U
         tvyxuYcwO4elZWxTc+hK3nUtm9JonwG4TsIP1hZmZO31uT39+9jB/oaNXtZgsLaJb/ta
         qcZQ==
X-Gm-Message-State: AOJu0Yyk+0/wHx3cnrzYinQSRhJuuaj1iIapwoVHNtVbs6VNSeT2VSXP
	40136rQg3bZ3bipnyzp+6TPDW0On74NPVmxhtG56O0NXrzky7aOKp/svsn/eLjDzIWFtSVSfHLE
	ZP5gfMQnkttqdbBU0ErAYtdl/Vm4OhuukiA1BZCBJ1pZJleOK8RecVKHs7q4igwBcVcckJEme8H
	Q3Dk3bwJKihVeZHRKqXxCoLL6PwN3iGmXXmc5BtwKYbs5m
X-Google-Smtp-Source: AGHT+IGV3Rl1shyl6I9uwYav0C6fLGpiKv2tzwAx7a9PcgRQcyuIXXc0TzkayO7qgRe/SMy3Ev29ciJ5DRX8
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:1003:b0:dc6:e5e9:f3af with SMTP
 id w3-20020a056902100300b00dc6e5e9f3afmr365170ybt.9.1708733527490; Fri, 23
 Feb 2024 16:12:07 -0800 (PST)
Date: Fri, 23 Feb 2024 16:11:43 -0800
In-Reply-To: <20240224001153.2584030-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240224001153.2584030-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224001153.2584030-4-jstultz@google.com>
Subject: [RESEND][PATCH v8 3/7] locking/mutex: Expose __mutex_owner()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Juri Lelli <juri.lelli@redhat.com>

Implementing proxy execution requires that scheduler code be able to
identify the current owner of a mutex. Expose __mutex_owner() for
this purpose (alone!).

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@android.com
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[Removed the EXPORT_SYMBOL]
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Reworked per Peter's suggestions]
Signed-off-by: John Stultz <jstultz@google.com>
---
v4:
* Move __mutex_owner() to kernel/locking/mutex.h instead of
  adding a new globally available accessor function to keep
  the exposure of this low, along with keeping it an inline
  function, as suggested by PeterZ
---
 kernel/locking/mutex.c | 25 -------------------------
 kernel/locking/mutex.h | 25 +++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 7de72c610c65..5741641be914 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -56,31 +56,6 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 }
 EXPORT_SYMBOL(__mutex_init);
 
-/*
- * @owner: contains: 'struct task_struct *' to the current lock owner,
- * NULL means not owned. Since task_struct pointers are aligned at
- * at least L1_CACHE_BYTES, we have low bits to store extra state.
- *
- * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
- * Bit1 indicates unlock needs to hand the lock to the top-waiter
- * Bit2 indicates handoff has been done and we're waiting for pickup.
- */
-#define MUTEX_FLAG_WAITERS	0x01
-#define MUTEX_FLAG_HANDOFF	0x02
-#define MUTEX_FLAG_PICKUP	0x04
-
-#define MUTEX_FLAGS		0x07
-
-/*
- * Internal helper function; C doesn't allow us to hide it :/
- *
- * DO NOT USE (outside of mutex code).
- */
-static inline struct task_struct *__mutex_owner(struct mutex *lock)
-{
-	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
-}
-
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
 	return (struct task_struct *)(owner & ~MUTEX_FLAGS);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 0b2a79c4013b..1c7d3d32def8 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -20,6 +20,31 @@ struct mutex_waiter {
 #endif
 };
 
+/*
+ * @owner: contains: 'struct task_struct *' to the current lock owner,
+ * NULL means not owned. Since task_struct pointers are aligned at
+ * at least L1_CACHE_BYTES, we have low bits to store extra state.
+ *
+ * Bit0 indicates a non-empty waiter list; unlock must issue a wakeup.
+ * Bit1 indicates unlock needs to hand the lock to the top-waiter
+ * Bit2 indicates handoff has been done and we're waiting for pickup.
+ */
+#define MUTEX_FLAG_WAITERS	0x01
+#define MUTEX_FLAG_HANDOFF	0x02
+#define MUTEX_FLAG_PICKUP	0x04
+
+#define MUTEX_FLAGS		0x07
+
+/*
+ * Internal helper function; C doesn't allow us to hide it :/
+ *
+ * DO NOT USE (outside of mutex & scheduler code).
+ */
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
+}
+
 #ifdef CONFIG_DEBUG_MUTEXES
 extern void debug_mutex_lock_common(struct mutex *lock,
 				    struct mutex_waiter *waiter);
-- 
2.44.0.rc0.258.g7320e95886-goog


