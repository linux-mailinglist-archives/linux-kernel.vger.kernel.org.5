Return-Path: <linux-kernel+bounces-26108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0482DB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008A028266C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2B18E18;
	Mon, 15 Jan 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XoTSyhcG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g08rqGsE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36C1805E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0MYhdyqdCnNF2sikCCC+B6J3YzfhlbKGb8NzRYHY1Q=;
	b=XoTSyhcGXL3jewDT8HeyR35QvUNIwwU5TQmxnt8IqAsASAAa7s6QlLsGaP9rjri5CVBtkh
	bt2NmkVvbHCYMfA/RffmV+1YNGNRkBrsVc8Pm1XOJ4FM119w8CHQ3bwbGy6alkxKGxwEw8
	9MlVF1ZGDuTkS2bItWoFLKsJR+dy+cww2ThJvEhGlXJO1u0C1qubSvBFZrXxEONbwbtvBR
	8ywQDFqZhlpTf/T0yPXCkLgffWz0kGEOVoQMQtSgNiYlbbRJULMChJ1BZDTWgEGiVSx3U9
	NnCB2ToDM1XZaJR/KjNCRSuto1povy5FzB1hQlCt9pMumKbyKmYBkjYvH+AJ0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0MYhdyqdCnNF2sikCCC+B6J3YzfhlbKGb8NzRYHY1Q=;
	b=g08rqGsEbLNBGwipTVvkMSon7N5/imR58bml+pm9R18WMYCyhxI3JHagKL/BjtMNScic1Z
	jMV806HMjOLAOZDA==
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
Subject: [PATCH v10 12/20] timers: Split out "get next timer interrupt" functionality
Date: Mon, 15 Jan 2024 15:37:35 +0100
Message-Id: <20240115143743.27827-13-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 functionality

The functionality for getting the next timer interrupt in
get_next_timer_interrupt() is split into a separate function
fetch_next_timer_interrupt() to be usable by other call sites.

This is preparatory work for the conversion of the NOHZ timer
placement to a pull at expiry time model. No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Update was required (change of preceding patches)
v9: Update was required (change of preceding patches)
v6: s/splitted/split
v5: Update commit message
v4: Fix typo in comment
---
 kernel/time/timer.c | 64 +++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f119b44e44e0..9fa759dd80f5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1988,30 +1988,13 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 	return base->next_expiry;
 }
 
-static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
-					     bool *idle)
+static unsigned long fetch_next_timer_interrupt(unsigned long basej, u64 basem,
+						struct timer_base *base_local,
+						struct timer_base *base_global,
+						struct timer_events *tevt)
 {
-	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
-	struct timer_base *base_local, *base_global;
 	bool local_first;
-	u64 expires;
-
-	/*
-	 * Pretend that there is no timer pending if the cpu is offline.
-	 * Possible pending timers will be migrated later to an active cpu.
-	 */
-	if (cpu_is_offline(smp_processor_id())) {
-		if (idle)
-			*idle = true;
-		return tevt.local;
-	}
-
-	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
-	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
-
-	raw_spin_lock(&base_local->lock);
-	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 
 	nextevt_local = next_timer_interrupt(base_local, basej);
 	nextevt_global = next_timer_interrupt(base_global, basej);
@@ -2029,8 +2012,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		goto forward;
+		tevt->local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		return nextevt;
 	}
 
 	/*
@@ -2040,12 +2023,41 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	 * ignored. If the global queue is empty, nothing to do either.
 	 */
 	if (!local_first && base_global->timers_pending)
-		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+		tevt->global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
 
 	if (base_local->timers_pending)
-		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+		tevt->local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+	return nextevt;
+}
+
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
+					     bool *idle)
+{
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
+	struct timer_base *base_local, *base_global;
+	unsigned long nextevt;
+	u64 expires;
+
+	/*
+	 * Pretend that there is no timer pending if the cpu is offline.
+	 * Possible pending timers will be migrated later to an active cpu.
+	 */
+	if (cpu_is_offline(smp_processor_id())) {
+		if (idle)
+			*idle = true;
+		return tevt.local;
+	}
+
+	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
+	base_global = this_cpu_ptr(&timer_bases[BASE_GLOBAL]);
+
+	raw_spin_lock(&base_local->lock);
+	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
+
+	nextevt = fetch_next_timer_interrupt(basej, basem, base_local,
+					     base_global, &tevt);
 
-forward:
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
-- 
2.39.2


