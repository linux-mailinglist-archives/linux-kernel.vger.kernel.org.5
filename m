Return-Path: <linux-kernel+bounces-29362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22381830D43
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3358C1C21F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580A249EA;
	Wed, 17 Jan 2024 19:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uwV9ug5m"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37473241E0
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705519584; cv=none; b=kjDOog3MifEgR09eBTjwQOiBWJ/OwGdqM8cQ4hOVR1WTHjjE+tJwvn3shVKL5XIWe+1IGyM/5yoLkSgKl7uKr7JvXfPPCkJtfHXcOjlO70D3kdLQuCkxPKIj48JG1AJPcFSqIngMmsyXKZLbm3gi5otvfVybv7syI2LNbJkXDnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705519584; c=relaxed/simple;
	bh=Ip5hgW1qCfchRNvXDDENndcOg3DIGPo6NUmQcbn3LKk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=oFo+YFocC+mI0XRua83ecO+D1D49molWelClqFzlZLE5NAKIEY7EfNQ44d9APQjRyv4HB4LsFZ1UYqrqOCDXyAZaah/ed2b2GP7q77TazLXKJg30ElDNIhJttwt9pIXW7jlt4M5dgvTODK4AHtU+Pio84lqicxribuN3qKhNHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uwV9ug5m; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dylanbhatch.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5efb07ddb0fso156956397b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705519582; x=1706124382; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KlbIib/4EWXfqKbgn9tI1Srz2znKpmTWRxzKkUQrUwE=;
        b=uwV9ug5mO08krw+dnZqDXc8YLVlCFQDSlOzHT4ogij8egcyP+A8vvH8mtaH4S7SD0x
         i+mvcfDdQvABYCtPf9ibSfnFRnz4BjwydzUfdEdM18Xzg3c0+XrQfIqaPWMcTcD/asbW
         8ZZ6XtGeU+2hpyUUou2ki+2tT78Tde1QIGUUS+4riMWZ3ij5avyla7tDWytR8LkcKtSR
         Lq4b/Xqh07j8/VskQBPA5F7Ng2AHo3ArLc3HzJwe+pvmCnY0zoGd2sfGVCCYGAIGht8T
         vtY96HRA86qbNQUQOa023pPx4UpAvF2KAD3rW8vthftzgyDfyb0H96DYea0PWnHOrtjQ
         lcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705519582; x=1706124382;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlbIib/4EWXfqKbgn9tI1Srz2znKpmTWRxzKkUQrUwE=;
        b=ZhKaW6lj0sC1eIl9QUKEBJGqJe4bd56Dxb2CbOtVlDc56AVuO02HhMSPlLgyWcb3g8
         eLmk+nsKE+EWG8i5CtzsH/Aj8YwuFw1wl02EshVtzJ94BsnotMnSzoegLStO1d5CZ5k/
         pZDb+XX7bEmoM2ndu54Y1/sy73FdN5j9cLLHaTlk6s1uSx5IIKSa7tPcOBBtqyxJvrNS
         ZCP9Yh9ajSGhpdFebvElCkD2ix00GJengluAa5wvyK7MLs+6q4S9pVOh9Rq2pqRSpEh/
         Keiy7Gx2Mo+EK0V9gNJD3SBwTMOOM96WusqQEBd6Rh6VNNHtoAcR0YYxTKjMLNui3seL
         rcVg==
X-Gm-Message-State: AOJu0YyKYt5h9CFSX6fK9+moV9+KvZGU06FtF0+zPmpN3HtfZPfi+pnL
	p9VYo1IR39fe65fn1RvVl4mV41DwiLTEPobLh+7eqFiA
X-Google-Smtp-Source: AGHT+IFKeRiB5diwCTwV7lbySPD0iM1d4hSJ9nJK4et4u00dpUXpcwk86UevpfL6obXMkm9zua9Eog1p4PxFFm3Dow==
X-Received: from dyl-pickles.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4c3f])
 (user=dylanbhatch job=sendgmr) by 2002:a25:9345:0:b0:dc2:4d1d:87e7 with SMTP
 id g5-20020a259345000000b00dc24d1d87e7mr42361ybo.10.1705519582172; Wed, 17
 Jan 2024 11:26:22 -0800 (PST)
Date: Wed, 17 Jan 2024 19:25:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240117192534.1327608-1-dylanbhatch@google.com>
Subject: [RFC PATCH] getrusage: Use trylock when getting sighand lock.
From: Dylan Hatch <dylanbhatch@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	Kees Cook <keescook@chromium.org>, Frederic Weisbecker <frederic@kernel.org>, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, Dylan Hatch <dylanbhatch@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mike Christie <michael.christie@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Stefan Roesch <shr@devkernel.io>, 
	Joey Gouly <joey.gouly@arm.com>, Josh Triplett <josh@joshtriplett.org>, Helge Deller <deller@gmx.de>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Florent Revest <revest@chromium.org>, 
	Miguel Ojeda <ojeda@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Processes with many threads run the risk of causing a hard lockup if
too many threads are calling getrusage() at once. This is because a
calling thread with RUSAGE_SELF spins on the sighand lock with irq
disabled, and the critical section of getrusage scales linearly with the
size of the process. All cpus may end up spinning on the sighand lock
for a long time because another thread has the lock and is busy
iterating over 250k+ threads.

In order to mitigate this, periodically re-enable interrupts while
waiting for the sighand lock. This approach lacks the FIFO fairness of a
normal spinlock mechanism, but this effect is somewhat contained to
different threads within the same process.

-- Alternatives Considered --

In an earlier version of the above approach, we added a cond_resched()
call when disabling interrupts to prevent soft lockups. This solution
turned out not to be workable on its own since getrusage() is called
from a non-preemptible context in kernel/exit.c, but could possibly be
adapted by having an alternate version of getrusage() that can be called
from a preemptible context.

Another alternative would be to have getruage() itself release the lock
and enable interrupts periodically while iterating over large numbers of
threads. However, this would be difficult to implement correctly, and
the correctness/consistency of the data reported by getrusage() would be
questionable.

One final alternative might be to add a per-process mutex for callers of
getrusage() to acquire before acquiring the sighand lock, or to be used
as a total replacement of the sigahnd lock. We haven't fully explored
what the implications of this might be.

Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
---
 include/linux/sched/signal.h | 13 +++++++++++
 kernel/signal.c              | 43 ++++++++++++++++++++++++++++++++++++
 kernel/sys.c                 |  8 ++++++-
 3 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3499c1a8b9295..7852f16139965 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -747,6 +747,19 @@ static inline struct sighand_struct *lock_task_sighand(struct task_struct *task,
 	return ret;
 }
 
+extern struct sighand_struct *__lock_task_sighand_safe(struct task_struct *task,
+							unsigned long *flags);
+
+static inline struct sighand_struct *lock_task_sighand_safe(struct task_struct *task,
+						       unsigned long *flags)
+{
+	struct sighand_struct *ret;
+
+	ret = __lock_task_sighand_safe(task, flags);
+	(void)__cond_lock(&task->sighand->siglock, ret);
+	return ret;
+}
+
 static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 47a7602dfe8df..6d60c73b7ab91 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1397,6 +1397,49 @@ int zap_other_threads(struct task_struct *p)
 	return count;
 }
 
+struct sighand_struct *__lock_task_sighand_safe(struct task_struct *tsk,
+						unsigned long *flags)
+{
+	struct sighand_struct *sighand;
+	int n;
+	bool lock = false;
+
+again:
+	rcu_read_lock();
+	local_irq_save(*flags);
+	for (n = 0; n < 500; n++) {
+		sighand = rcu_dereference(tsk->sighand);
+		if (unlikely(sighand == NULL))
+			break;
+
+		/*
+		 * The downside of this approach is we loose the fairness of
+		 * FIFO waiting because the acqusition order between multiple
+		 * waiting tasks is effectively random.
+		 */
+		lock = spin_trylock(&sighand->siglock);
+		if (!lock) {
+			cpu_relax();
+			continue;
+		}
+
+		/* __lock_task_sighand has context explaining this check. */
+		if (likely(sighand == rcu_access_pointer(tsk->sighand)))
+			break;
+		spin_unlock(&sighand->siglock);
+		lock = false;
+	}
+	rcu_read_unlock();
+
+	/* Handle pending IRQ */
+	if (!lock && sighand) {
+		local_irq_restore(*flags);
+		goto again;
+	}
+
+	return sighand;
+}
+
 struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
 					   unsigned long *flags)
 {
diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d8..1b1254a3c506b 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1798,7 +1798,13 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		goto out;
 	}
 
-	if (!lock_task_sighand(p, &flags))
+	/*
+	 * We use lock_task_sighand_safe here instead of lock_task_sighand
+	 * because one process with many threads all calling getrusage may
+	 * otherwise cause an NMI watchdog timeout by disabling IRQs for too
+	 * long.
+	 */
+	if (!lock_task_sighand_safe(p, &flags))
 		return;
 
 	switch (who) {
-- 
2.43.0.381.gb435a96ce8-goog


