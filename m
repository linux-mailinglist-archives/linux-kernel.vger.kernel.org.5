Return-Path: <linux-kernel+bounces-60181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04A850115
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECFC1C226C3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6546B7;
	Sat, 10 Feb 2024 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QnkTUmOt"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CA23BD
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707524624; cv=none; b=TYrb1153gmPO36ni2eCu7W+OwG5LFsMCvTPKi0qF9j2tb2etF5wVAOK8KpBVqoJOL9VieuVOo9o5aOVmA7NL8IX6Fc0tDJkBy6GY8pPGN68Ph3C8nrq6r3yjZ4MHwpK2UYI+Eofz7txUO9S9ehtbHVJ2MgDUqkVuT0SiSbPgdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707524624; c=relaxed/simple;
	bh=3DJbBrx4KmSxVmHiBdNSoYKl3Bct4nREpl0U7p4hoZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gPNBjkNQ0ULE1l1bjy8bnZGzbOMDpvo4qXNQaAO+KslB+146bvZL4N/TB6BuKpVPggri5sbqo67H8B0FrIUlucYdopij36hb+rhjh1ZTxZNQnQD1qElmgM2WNUetqiHb/sTTVLxvBrtldYcpsIGn3wWNl0w9kYWAx+7d/ZkwBhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QnkTUmOt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2250960276.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707524621; x=1708129421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z669vXCZHTlic+csHXc7vqHCpJ4DtGvq/gBFclWIjzM=;
        b=QnkTUmOtwTGF34K8gZL0Pp6mIiHALad11qn6ji/utJJaSopYNHi8JHiVg9XihGofw5
         RjY/imT3L4E0MTxe3ZdqKPsSB+u6lk9DVwPiCAA4f9bmkeHMoHtW+AWWfaHQl9FMxW5X
         LVr1y1R8EGlMdR8g1PJRdOeiJvF+G4mHUCcu6EFBL4a4cAeUSuZvJnJU6Cm58oxDHcSf
         74xPIpM4VNzzLo3fxVPkgvMn0fXDjxLolq0cqKzsuOgUh+I0mm+K8sgO5s7OqoxbaKnv
         2mMNUvYR70pGw05EWXCLgv6Gpz/CqW5HF8rQEdJTLr8gztSa575I11VtbGqI8CszGbiM
         wvTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707524621; x=1708129421;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z669vXCZHTlic+csHXc7vqHCpJ4DtGvq/gBFclWIjzM=;
        b=PvS5WAn9sH+/0jqofkeauVsoQxT7C7i4ZPCF5qv+RTt6KHzAYU9nEvIhKh80AwcUZq
         5p4WHyPAcOOYnTpDxa8F2mP/3iyxF4iICYkfB5k90rlApEi2EQTkzEnuWgHSa9abLSZV
         Ciugr4CmT49mKV6pQTeZcVVLpvlIYIVhh5mkhv6hfIAqNrJtkpygy1GJJFjBAgp5OC/z
         CUBZcVPEev4jya1ACCJoCyF7nMPk+tSzmcyt+e4ndj7ciqulYWIPim89vvBmHag9A889
         34Jy6oEZiJCz4FFSgHGttI3QhJ/qm5lHLJYX0VCXM6jAJLEq/hbPEdrFvYuPNaE034pC
         SmqA==
X-Gm-Message-State: AOJu0Yyp+3d1U1AFt9UpVlVidOTTIShktOPSS4UC6+zDsQ2GZd7dDJO0
	FkTs7k3MZ/JGcn0RmPxD+q7fwBUpMlyVzePqgDMTQ1gEcy9V+zyee7Wjv/ZjZtymnLvov7psSMA
	uydFedUxonCTZ3GP/8EOdkcJ7FVH0s2s6Vw6LDtWk+JPVGItlPZWP4wr3jEbj5YSdQrbWVa1NdL
	0G3fMiLztLIQ+UieIXAqDrynPL4NFowGaBhlyyyLbDZ59h
X-Google-Smtp-Source: AGHT+IE5SlK93JYH74a2do0HGRdiQ0w7pq86Iok+DSMbw4GbohM4QDw4xp2cwBPoZcWxB9DyqtSt7ZUX4GS2
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:72e:b0:dc6:ee66:da6b with SMTP id
 l14-20020a056902072e00b00dc6ee66da6bmr20067ybt.7.1707524620974; Fri, 09 Feb
 2024 16:23:40 -0800 (PST)
Date: Fri,  9 Feb 2024 16:23:12 -0800
In-Reply-To: <20240210002328.4126422-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240210002328.4126422-1-jstultz@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240210002328.4126422-4-jstultz@google.com>
Subject: [PATCH v8 3/7] locking/mutex: Expose __mutex_owner()
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
2.43.0.687.g38aa6559b0-goog


