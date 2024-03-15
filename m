Return-Path: <linux-kernel+bounces-104050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD65887C84D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749BA282B24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07E812B95;
	Fri, 15 Mar 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nxAY3pNd"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ACB101C4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710477627; cv=none; b=Y99XVxq8wqaOgB5dQkcTYYbm3A4HeBr7Pe3lt1XBU2YAcYB8TU8z/fkfplIR0AMvcSSB7i1YFqZxmXgZiYhuJ7YT7nv4lqsb9C5imeqJhmI6MlKLQacMRZhWVVu8asyGwpBBOIujyPEpua/RKiN17rT4rdxZEUS4Q5K74VLGkW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710477627; c=relaxed/simple;
	bh=RoIcrErNdRRmnt6YHmJ5Updj0dP2brw5ELAlflT/1hs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMQB9eH1cNxI9GyvOJHDdKtzIeY0lBdcSB0cFV3R+OK6wnvbr4HKY1y2KmvDV2HjLRk/+a4cl6YkvPFimLJ/eTqjdcrmLH/K3Q41igI4Ifxvrymfo8kK6rrZ7eW0JX0kYsDJIVjFvUgTo/fbKt7nPBzA3DKkMgSYxNhdj8TnN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nxAY3pNd; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso2769366276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 21:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710477625; x=1711082425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaAjw+GLN3fthD1Tt2Fd5YB8ROakR8eIp7hBkVpSiIo=;
        b=nxAY3pNdYizTuB4L59lJLODjrpV5nwvBXX1l3pplVvlKhwZCGjdReZ+OIuyeVwHSHp
         uQlUzlVfNJ2UX08AtGf2vXXgx+KC2TTYH2vpWLIMsuAuW2Pd6d9dTZ5ty+4CTQStwvfI
         ttuJJmkfsP2w5D2vbww9++ViVISyEOm8pEbdObLLyXhYSL9Wwun4gGBKILJQMgYnswPZ
         frzNkVsTeCl69UUV1mypRopw9SmCCktYzSb3bLlJ5sw1ZlLnRXNFsYkRpFyGRvgUo0zN
         rrbDTTY+XvVd8PfoVhq6c2cRhfY6U0d7+6sLBACh49SAJydtz6zCnY3yydNQYmRjS5yn
         js/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710477625; x=1711082425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QaAjw+GLN3fthD1Tt2Fd5YB8ROakR8eIp7hBkVpSiIo=;
        b=dggEopVx1zFNhGa/nmWCP2NaeZTpnD2m6Trrjcwc6QE9Tij8Shx3sQotw87cjip5pA
         KFkOZYhdYpBsSW64bDNUVBNnfWu9jKZB61vB5f5ri9UKRdG7envTurAtKNEQPpqzBuht
         6bPiFJuW1HrMVY7V0bPoIVr64J5K3vbNjYI73LK/u6EqxzREyS8Rx9Nf1lAbA8EFHW1U
         E/pbxV1pc5WiNkATc4NxWuwrIcEGDfSTBTqPJjHLucb/NtOyzal1Lkh2y3OEDuX3t9n2
         s7TeKd6fSbsOe2lplxnQLh3OorGQQA/ObMdX3rFgzcDbte7DjcXH9Yt9DKdjuLmVkv84
         tq8w==
X-Gm-Message-State: AOJu0Yw99dzF/ErN8XbMS/HduM2F7nT9tvCY0xfRii/jCBAvX+BxzCYB
	TqdDyQhmXy3KruRwXg02SsJbkkubezEe0qZJ9wjJbu1JO42k7jUHXvxFlWwJVGJRGpzNUNKjNtJ
	AyeqkItJ8kTsTA8u8dJrc6vX9VzKRxCin1TRlqA5QAzsh6U0Z846wEoY9Nccz/iRLXgMI2VMTlU
	Cn8fBXIc2l6ncF8nSsP7nzDmHEZbz1bdLslt1jvmwYpN4T
X-Google-Smtp-Source: AGHT+IHrGFmuVdNv87RfxHRPYm5/7AnTutaFZYOVGNZQsMeBVL96LxwznLFIO7HJaAWLPjy4VEuQxTmDbtQT
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6902:72e:b0:dcc:94b7:a7a3 with SMTP id
 l14-20020a056902072e00b00dcc94b7a7a3mr216175ybt.12.1710477624535; Thu, 14 Mar
 2024 21:40:24 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:39:48 -0700
In-Reply-To: <20240315044007.2778856-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240315044007.2778856-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240315044007.2778856-4-jstultz@google.com>
Subject: [PATCH v9 3/7] locking/mutex: Expose __mutex_owner()
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
2.44.0.291.gc1ea87d7ee-goog


