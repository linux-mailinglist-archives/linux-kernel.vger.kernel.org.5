Return-Path: <linux-kernel+bounces-1365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D21B814E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12546285FD6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDD4186D;
	Fri, 15 Dec 2023 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZY3DOSR5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwH1vhsj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E03FE2A;
	Fri, 15 Dec 2023 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702660232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hXWC+KQ48HdWABG8tICGwil7n9P1nfuL/9s+0V/nEk=;
	b=ZY3DOSR51N4hU9NBb4MoCr/OWzpWMWXwCQFexNPapBTZqqNF2KIIZRFSuRTUGfddjVU+qB
	k7DMO7EfFAkOfhGSKD4sey6cj6mYZ1Mj/Q8o2c/bJH+yG0FUIhjDluzJq8GG+jZE/CW+Hr
	coXQDRnc/TV+Bvi+34b4Eef8lTMtevJfed6q/fWlGoC2fUzEHJWvineyRtJG3PBZteochR
	N5plHUqHizXQz7z8I4lq+Qf4H0JW83hrHsg88ybxsssLJPIMuzgr9cbfsLEj+WIeqFtF68
	jGXN1AVYdk+p0oJ6kiGF7anFUH7Iz2siXXI0N/oJgf6Tv58rjSIWhPBQRWXxsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702660232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hXWC+KQ48HdWABG8tICGwil7n9P1nfuL/9s+0V/nEk=;
	b=uwH1vhsj09Tb2R70oCOs1K5DC7+atNXD5r4Ii29g2VFnHjntTLEOaITCNiXdxZBKy4oRe4
	DjOHaUfmhOrgUKBw==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 02/24] locking/local_lock: Add local nested BH locking infrastructure.
Date: Fri, 15 Dec 2023 18:07:21 +0100
Message-ID: <20231215171020.687342-3-bigeasy@linutronix.de>
In-Reply-To: <20231215171020.687342-1-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add local_lock_nested_bh() locking. It is based on local_lock_t and the
naming follows the preempt_disable_nested() example.

For !PREEMPT_RT + !LOCKDEP it is a per-CPU annotation for locking
assumptions based on local_bh_disable(). The macro is optimized away
during compilation.
For !PREEMPT_RT + LOCKDEP the local_lock_nested_bh() is reduced to
the usual lock-acquire plus lockdep_assert_in_softirq() - ensuring that
BH is disabled.

For PREEMPT_RT local_lock_nested_bh() acquires the specified per-CPU
lock. It does not disable CPU migration because it relies on
local_bh_disable() disabling CPU migration.
With LOCKDEP it performans the usual lockdep checks as with !PREEMPT_RT.
Due to include hell the softirq check has been moved spinlock.c.

The intention is to use this locking in places where locking of a per-CPU
variable relies on BH being disabled. Instead of treating disabled
bottom halves as a big per-CPU lock, PREEMPT_RT can use this to reduce
the locking scope to what actually needs protecting.
A side effect is that it also documents the protection scope of the
per-CPU variables.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/local_lock.h          | 10 ++++++++++
 include/linux/local_lock_internal.h | 31 +++++++++++++++++++++++++++++
 include/linux/lockdep.h             |  3 +++
 kernel/locking/spinlock.c           |  8 ++++++++
 4 files changed, 52 insertions(+)

diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index 706c4b65d9449..303caac7fbbbc 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -62,4 +62,14 @@ DEFINE_LOCK_GUARD_1(local_lock_irqsave, local_lock_t,
 		    local_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
=20
+#define local_lock_nested_bh(_lock)				\
+	__local_lock_nested_bh(_lock)
+
+#define local_unlock_nested_bh(_lock)				\
+	__local_unlock_nested_bh(_lock)
+
+DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t,
+		    local_lock_nested_bh(_T->lock),
+		    local_unlock_nested_bh(_T->lock))
+
 #endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index 975e33b793a77..8dd71fbbb6d2b 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -62,6 +62,17 @@ do {								\
 	local_lock_debug_init(lock);				\
 } while (0)
=20
+#define __spinlock_nested_bh_init(lock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_NORMAL);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
@@ -98,6 +109,15 @@ do {								\
 		local_irq_restore(flags);			\
 	} while (0)
=20
+#define __local_lock_nested_bh(lock)				\
+	do {							\
+		lockdep_assert_in_softirq();			\
+		local_lock_acquire(this_cpu_ptr(lock));	\
+	} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+	local_lock_release(this_cpu_ptr(lock))
+
 #else /* !CONFIG_PREEMPT_RT */
=20
 /*
@@ -138,4 +158,15 @@ typedef spinlock_t local_lock_t;
=20
 #define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
=20
+#define __local_lock_nested_bh(lock)				\
+do {								\
+	lockdep_assert_in_softirq_func();			\
+	spin_lock(this_cpu_ptr(lock));				\
+} while (0)
+
+#define __local_unlock_nested_bh(lock)				\
+do {								\
+	spin_unlock(this_cpu_ptr((lock)));			\
+} while (0)
+
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index dc2844b071c2c..881732fa0df8c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -657,6 +657,8 @@ do {									\
 		     (!in_softirq() || in_irq() || in_nmi()));		\
 } while (0)
=20
+extern void lockdep_assert_in_softirq_func(void);
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -670,6 +672,7 @@ do {									\
 # define lockdep_assert_preemption_enabled() do { } while (0)
 # define lockdep_assert_preemption_disabled() do { } while (0)
 # define lockdep_assert_in_softirq() do { } while (0)
+# define lockdep_assert_in_softirq_func() do { } while (0)
 #endif
=20
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 8475a0794f8c5..438c6086d540e 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -413,3 +413,11 @@ notrace int in_lock_functions(unsigned long addr)
 	&& addr < (unsigned long)__lock_text_end;
 }
 EXPORT_SYMBOL(in_lock_functions);
+
+#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_PREEMPT_RT)
+void notrace lockdep_assert_in_softirq_func(void)
+{
+	lockdep_assert_in_softirq();
+}
+EXPORT_SYMBOL(lockdep_assert_in_softirq_func);
+#endif
--=20
2.43.0


