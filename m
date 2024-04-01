Return-Path: <linux-kernel+bounces-127191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CE28947DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45802825C7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DFC58226;
	Mon,  1 Apr 2024 23:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e3+qatwX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D858100
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015096; cv=none; b=lLDkato9Jjf1rhmeoHFlhn+LcxTBKCG7rblv8dDfhQK+8X9Z2rUHj7kUg2v7TEbsrXPKu0aoerKPDRhc7Z4f6Px0h8NVzUJ2KTg0epne88AUj5ItCpZqWgCSOFzG4tIm4l6Zu44S9QDP6upsl/DmQ329s+3GW2ach0/2Ku2Z3gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015096; c=relaxed/simple;
	bh=Er0fnT9u3Ba8OTtjlVXsTFy29JrXcDtlgfYMhmhcLWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B1hxC1agJDwtMAhQZ6xFzdbA9TmzdQbk7dao6u06OUbhLaoZ7eooDlwWMeC9yiuP73J3BiWsPxuj1EAS5Ca6v8ltMVRZXorI0TJtafEglV+S8YCVLgkrxD1xz+5F6H4eJmQ6jmymJBh8ekQWyeg3FyxjiXZm8+umCB9BHTGaNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e3+qatwX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610c23abd1fso85876777b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712015093; x=1712619893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0uc0GIwNX9TQ2eyKhoV3DbzxqwGn/ULqzDV9v8PRZss=;
        b=e3+qatwXFHTNtVE4Ynq8cJiLnEInTOqstn/Quc8vRj9rio3E/VXf5+Jvf0ZSgVI6y0
         ElOv/XSyyX4SX05AqCq911gnv59Kb4JXlnS0UlpHewJeW/4FFTUKi9DpNA5odXVXxHQW
         tR7c6CQaBls+kmSTMaPXjfZtlGiyKESjPGX6S8/6bpHzCk3eKNjdpFm4W5KSV/sCyx2F
         RD1NGgdU/YC9XVKVl7N+FrCEbr5V6sgyJddluaZZBNbahGVvYeS/FqA4ksjuqBLAChP0
         NzRwWsb/haryQ5lz+8YDFtQAvs6bt+0eRMB6Uh7pQ+kdoFSj/SKMxH2DLHaMOc92no2h
         vcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015093; x=1712619893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uc0GIwNX9TQ2eyKhoV3DbzxqwGn/ULqzDV9v8PRZss=;
        b=P1Soy3Uja1baCiorP0xwqkrYSfvzcT2VpaUzxQWhv01fSry45W/+dpvgYFtqlDNxKT
         MAle8TsWyNgAcwBZRFwn7X6rV4STu7/Ip1HcPffIEGeoa0KYzWnKOrQ18MxaUxfzwaIN
         /vc8B7nznJmttKPsBR/qnXiv2iP3JyiSsWJH8L/9QRgjuaQGkdLrqSODjVtj+vrgoJLj
         Hxu7pzM7oJlkMgvZQ6COYPnS7NuvVS/C5LFxOZ/A2LYF8wXdp8TF3EioG0NCXB80SVdW
         vqlhcTM1NZwnKjWFv1BJZamTnnGoLh5b+y6ElQA5Js8YnNx+yWqGjE1XnlFWigmJ/zlv
         3Daw==
X-Gm-Message-State: AOJu0Ywi4Y+SuTfyD9j5VpwJZNLjkms09vtdW6uuqRmp5LErfY6YpTsZ
	TbKpvWqot2nQEti0buW+QEZNPNi9U9pFQcTnboZgC0C5cMxUDMeUUtb4pqJHIT5Er25SQ+S2DCb
	jJuryafLXCvDKoYK7xyk0kStNe3pGaz9xzRs8jTsT38RbLwRqq0auUlQwx4kMnweMOhv0sy8fCZ
	vLNYGDenAuYddDL+sAFCA7HBPbg+2mXBIXWGW1qCZi6v9P
X-Google-Smtp-Source: AGHT+IGlFPwDuT56HmSq77B4zYaAm/qWzISnwik3PxGEpmphABZvFYU+ukksVNe+ZhCjOCT60269mo0fiLDu
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:f12:b0:614:9623:90ca with SMTP id
 dc18-20020a05690c0f1200b00614962390camr1743830ywb.6.1712015092791; Mon, 01
 Apr 2024 16:44:52 -0700 (PDT)
Date: Mon,  1 Apr 2024 16:44:25 -0700
In-Reply-To: <20240401234439.834544-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401234439.834544-1-jstultz@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401234439.834544-4-jstultz@google.com>
Subject: [RESEND][PATCH v9 3/7] locking/mutex: Expose __mutex_owner()
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
2.44.0.478.gd926399ef9-goog


