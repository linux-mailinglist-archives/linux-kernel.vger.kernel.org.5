Return-Path: <linux-kernel+bounces-159157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 341FB8B2A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59931F24448
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E851552F5;
	Thu, 25 Apr 2024 20:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jkyRxfd3"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E47153814;
	Thu, 25 Apr 2024 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077860; cv=none; b=HCr8C3jpMqH3qkbqvZi5QbFcoY/gyWUjifC3cxLCX/zLKxjJCS29zmuCtURqTwheQIcKLbDR56tbS96j3xjHMbZ8+AFbymL/8OadLT6prMJo8Z88QNeJpSo5MXIVnz/gDsnPZp5IE9A0MQ9H0Mm++12Dh3aIKIVVE4lFQ6pJSAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077860; c=relaxed/simple;
	bh=8sxkJ4DWuOJCZutr1xA6A89cSCURGEeXGMrk/zUulQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9IIu4r0diYwVt+TJDOd7SsOYwQG+kvLa0kkM45vmYvWdggOIqJtNI2JxkerHzpWOQFwfKj3FZUKFwpiD4tOXzCFm0vuSAjp3V2HFfp66HmhCOtX+jpOtzeduzyZVsdgAgvbBV6WX3VWtvIvZTzUGdMC3Aggo4FkTtse/hriAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jkyRxfd3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oHann4TH2Ah2IPapN8sqWvlYSxh8ekOAJ6wfcLQixXk=; b=jkyRxfd3GcBbNr6BqHzzx6A5Jo
	5z4OjIrxefhD6R+pJufuaS8wwJQFKeYzajwbQteZqnubgHo7Iluz+SJdp1unxCtq0nOwcPuGe38TM
	S5F59RMbkqSzwbeQJNSL9GoXuDx3kaHOQGyNQvgtdt9Es4QxZQqbIxdEMdgbBWqyRmQrNQWHptUJT
	gJ8ji4/bm2GmNbsbWPzFs7EMChXhk6od8B1Y5170ZgRcfAV+tBPpg17FC73qt84+F4nqgNkEBMJu8
	bNyLehdvELH/kHa/hye3FmD20+Ho69kLs8J+5IJ7+q64O8MhbHE5Rzvyg6W7rOE5XyzyQkAXyLylq
	qcg26LPg==;
Received: from 201-42-129-95.dsl.telesp.net.br ([201.42.129.95] helo=steammachine.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1s05wd-008iV5-Tt; Thu, 25 Apr 2024 22:43:52 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	"Boqun Feng" <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Paul Turner" <pjt@google.com>,
	linux-api@vger.kernel.org,
	"Christian Brauner" <brauner@kernel.org>,
	"Florian Weimer" <fw@deneb.enyo.de>,
	David.Laight@ACULAB.COM,
	carlos@redhat.com,
	"Peter Oskolkov" <posk@posk.io>,
	"Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
	"Chris Kennelly" <ckennelly@google.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Darren Hart" <dvhart@infradead.org>,
	"Davidlohr Bueso" <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	libc-alpha@sourceware.org,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Noah Goldstein" <goldstein.w.n@gmail.com>,
	"Daniel Colascione" <dancol@google.com>,
	longman@redhat.com,
	kernel-dev@igalia.com
Subject: [RFC PATCH 1/1] futex: Add FUTEX_SPIN operation
Date: Thu, 25 Apr 2024 17:43:32 -0300
Message-ID: <20240425204332.221162-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240425204332.221162-1-andrealmeid@igalia.com>
References: <20240425204332.221162-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new futex mode for futex wait, the futex spin.

Given the FUTEX2_SPIN flag, parse the futex value as the PID of the lock
owner. Then, before going to the normal wait path, spins while the lock
owner is running in a different CPU, to avoid the whole context switch
operation and to quickly return to userspace. If the lock owner is not
running, just sleep as the normal futex wait path.

The check for the owner to be running or not is important to avoid
spinning for something that won't be released quickly. Userspace is
responsible on providing the proper PID, the kernel does a basic check.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/uapi/linux/futex.h |  2 +-
 kernel/futex/futex.h       |  6 ++-
 kernel/futex/waitwake.c    | 79 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index d2ee625ea189..d77d692ffac2 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -63,7 +63,7 @@
 #define FUTEX2_SIZE_U32		0x02
 #define FUTEX2_SIZE_U64		0x03
 #define FUTEX2_NUMA		0x04
-			/*	0x08 */
+#define FUTEX2_SPIN		0x08
 			/*	0x10 */
 			/*	0x20 */
 			/*	0x40 */
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 8b195d06f4e8..180c1c10dc81 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -37,6 +37,7 @@
 #define FLAGS_HAS_TIMEOUT	0x0040
 #define FLAGS_NUMA		0x0080
 #define FLAGS_STRICT		0x0100
+#define FLAGS_SPIN		0x0200
 
 /* FUTEX_ to FLAGS_ */
 static inline unsigned int futex_to_flags(unsigned int op)
@@ -52,7 +53,7 @@ static inline unsigned int futex_to_flags(unsigned int op)
 	return flags;
 }
 
-#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE)
+#define FUTEX2_VALID_MASK (FUTEX2_SIZE_MASK | FUTEX2_PRIVATE | FUTEX2_SPIN)
 
 /* FUTEX2_ to FLAGS_ */
 static inline unsigned int futex2_to_flags(unsigned int flags2)
@@ -65,6 +66,9 @@ static inline unsigned int futex2_to_flags(unsigned int flags2)
 	if (flags2 & FUTEX2_NUMA)
 		flags |= FLAGS_NUMA;
 
+	if (flags2 & FUTEX2_SPIN)
+		flags |= FLAGS_SPIN;
+
 	return flags;
 }
 
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375d9521..94feac92cf4f 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -372,6 +372,78 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 	__set_current_state(TASK_RUNNING);
 }
 
+static inline bool task_on_cpu(struct task_struct *p)
+{
+#ifdef CONFIG_SMP
+	return !!(p->on_cpu);
+#else
+	return false;
+#endif
+}
+
+static int futex_spin(struct futex_hash_bucket *hb, struct futex_q *q,
+		       struct hrtimer_sleeper *timeout, void __user *uaddr, u32 val)
+{
+	struct task_struct *p;
+	u32 pid, uval;
+	unsigned int i = 0;
+
+	if (futex_get_value_locked(&uval, uaddr))
+		return -EFAULT;
+
+	pid = uval;
+
+	p = find_get_task_by_vpid(pid);
+	if (!p) {
+		printk("%s: no task found with PID %d\n", __func__, pid);
+		return -EAGAIN;
+	}
+
+	if (unlikely(p->flags & PF_KTHREAD)) {
+		put_task_struct(p);
+		printk("%s: can't spin in a kernel task\n", __func__);
+		return -EPERM;
+	}
+
+	futex_queue(q, hb);
+
+	if (timeout)
+		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
+
+	while (1) {
+		if (likely(!plist_node_empty(&q->list))) {
+			if (timeout && !timeout->task)
+				return 0;
+
+			/* spin */
+			if (task_on_cpu(p)) {
+				i++;
+				continue;
+			/* task is not running, sleep */
+			} else {
+				break;
+			}
+		} else {
+			printk("%s: woke after %d spins\n", __func__, i);
+			return 0;
+		}
+	}
+
+	printk("%s: spinned %d times, sleeping\n", __func__, i);
+
+	/* spinning didn't work, go to the normal path */
+	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+
+	if (likely(!plist_node_empty(&q->list))) {
+		if (!timeout || timeout->task)
+			schedule();
+	}
+
+	__set_current_state(TASK_RUNNING);
+
+	return 0;
+}
+
 /**
  * futex_unqueue_multiple - Remove various futexes from their hash bucket
  * @v:	   The list of futexes to unqueue
@@ -665,8 +737,11 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	if (ret)
 		return ret;
 
-	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue(hb, &q, to);
+	if (flags & FLAGS_SPIN)
+		futex_spin(hb, &q, to, uaddr, val);
+	else
+		/* futex_queue and wait for wakeup, timeout, or a signal. */
+		futex_wait_queue(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!futex_unqueue(&q))
-- 
2.44.0


