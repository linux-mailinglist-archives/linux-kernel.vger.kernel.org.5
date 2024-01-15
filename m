Return-Path: <linux-kernel+bounces-26102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C699382DB6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD5281101
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA1417C6A;
	Mon, 15 Jan 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f57/0sSB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WqiDL90+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776F17999
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd7ZSY9uCCvXsEjv5hsri8WxYcwJShixETTpt1BLsE4=;
	b=f57/0sSBXZ1JRAX3RVEVr5HFQv6Lqb5w3CD5uk8FY+PR9dgPCaun9CyEOq7cdBwCYK3TwZ
	QV4OykKeDthyz2Q5gL0/pysVAVrZy/qsIrc4ePzSvIqEJRO3QTh+3TB4JIbsuPoKgb4SaI
	98gmtJ/nGofxAzq1BWJ1HpmbxTdutIV7/1oo3Yis2h0Ht3WkFR8EVxHEyaXi7cfzn4hbyz
	dPubmZNV6uAofAmMhnWHw+CP8T7VzwJGSEh9KGL6SGLwpR5gNKzzLdiQYNhcEDRrZw+efJ
	pUBOOZ+rHMo0345vx2R+yOthEkzdKNUNqtr74EEpTZDQsNVy7ZcMvCVgxdCG9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dd7ZSY9uCCvXsEjv5hsri8WxYcwJShixETTpt1BLsE4=;
	b=WqiDL90+9AC1nMXbkvsV88JCQ77hfxzaVccWYpl01ws4yhT+L5Gkum9jw4wwsNZ9ofshe6
	ukC2UFG/zu2l6KAA==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v10 05/20] timers: Introduce add_timer() variants which modify timer flags
Date: Mon, 15 Jan 2024 15:37:28 +0100
Message-Id: <20240115143743.27827-6-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 timer flags

A timer might be used as a pinned timer (using add_timer_on()) and later on
as non-pinned timer using add_timer(). When the "NOHZ timer pull at expiry
model" is in place, the TIMER_PINNED flag is required to be used whenever a
timer needs to expire on a dedicated CPU. Otherwise the flag must not be
set if expiration on a dedicated CPU is not required.

add_timer_on()'s behavior will be changed during the preparation patches
for the "NOHZ timer pull at expiry model" to unconditionally set
TIMER_PINNED flag. To be able to clear/ set the flag when queueing a
timer, two variants of add_timer() are introduced.

This is a preparatory patch and has no functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v10: Commit message reworded as suggested by bigeasy

v9: Update documentation to match kernel-doc style (missing brackets after
    function names)

New in v6
---
 include/linux/timer.h |  2 ++
 kernel/time/timer.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 26a545bb0153..404bb31a95c7 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -179,6 +179,8 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
 #define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
 
 extern void add_timer(struct timer_list *timer);
+extern void add_timer_local(struct timer_list *timer);
+extern void add_timer_global(struct timer_list *timer);
 
 extern int try_to_del_timer_sync(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2f69a485a070..3cf016d6fa59 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1245,6 +1245,40 @@ void add_timer(struct timer_list *timer)
 }
 EXPORT_SYMBOL(add_timer);
 
+/**
+ * add_timer_local() - Start a timer on the local CPU
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is set.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_local(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags |= TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_local);
+
+/**
+ * add_timer_global() - Start a timer without TIMER_PINNED flag set
+ * @timer:	The timer to be started
+ *
+ * Same as add_timer() except that the timer flag TIMER_PINNED is unset.
+ *
+ * See add_timer() for further details.
+ */
+void add_timer_global(struct timer_list *timer)
+{
+	if (WARN_ON_ONCE(timer_pending(timer)))
+		return;
+	timer->flags &= ~TIMER_PINNED;
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
+}
+EXPORT_SYMBOL(add_timer_global);
+
 /**
  * add_timer_on - Start a timer on a particular CPU
  * @timer:	The timer to be started
-- 
2.39.2


