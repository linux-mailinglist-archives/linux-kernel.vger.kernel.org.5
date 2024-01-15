Return-Path: <linux-kernel+bounces-26107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0182DB78
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288511C21BE1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BD18C16;
	Mon, 15 Jan 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbSTa+5p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tgJIiLML"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314A17C7C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr+0oSb+AndOblwVvQzleNBKd5oIVJXXyPBNDPB6wYY=;
	b=YbSTa+5pAcCvS4Wu/iTQy+7Efu4QkhWpb+LdmNJp3T/95XWrgehdESVtjUbLKPcQ8dqMlU
	xTtHaf5bF+8GKvsYaB8Zc4mQY3fFJllBcgiuJwZJVmpMbgjbBL6lGTx55h54r4OezUZbhJ
	IRfBUP3Fa9GZ2DU7soBptOC0lTWKHmFgDVNIl+gktGqF+yxvkowCu4DaEYTF5aWLhwyADV
	rhtl+MyMqATNTeqPe6pdPEZnmoqfzEb9MOzS/vp1sBQraZjg5f3rfPf69ytEIbn8MvtVPa
	JfKEhZ75t3n/omQyjat4E3DSeqNK2T2SXL16Hd0hAvPIDhx+wuEz99NmmAcH4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fr+0oSb+AndOblwVvQzleNBKd5oIVJXXyPBNDPB6wYY=;
	b=tgJIiLMLs5RmyS9MgTYmslgvJZvQpm6vHXIxjarUqg90tW0RG5XhKAJ8G2UwoJYq3URsi7
	On9mOU4z1EnxBhAw==
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
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v10 11/20] timers: Retrieve next expiry of pinned/non-pinned timers separately
Date: Mon, 15 Jan 2024 15:37:34 +0100
Message-Id: <20240115143743.27827-12-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 timers separately

For the conversion of the NOHZ timer placement to a pull at expiry time
model it's required to have separate expiry times for the pinned and the
non-pinned (movable) timers. Therefore struct timer_events is introduced.

No functional change

Originally-by: Richard Cochran (linutronix GmbH) <richardcochran@gmail.com>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
v10: Fix no functional change message

v9: Update was required (change of preceding patches)
---
 kernel/time/timer.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5ca831444954..f119b44e44e0 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -221,6 +221,11 @@ struct timer_base {
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
 
+struct timer_events {
+	u64	local;
+	u64	global;
+};
+
 #ifdef CONFIG_NO_HZ_COMMON
 
 static DEFINE_STATIC_KEY_FALSE(timers_nohz_active);
@@ -1986,10 +1991,11 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
+	struct timer_events tevt = { .local = KTIME_MAX, .global = KTIME_MAX };
 	unsigned long nextevt, nextevt_local, nextevt_global;
 	struct timer_base *base_local, *base_global;
-	u64 expires = KTIME_MAX;
 	bool local_first;
+	u64 expires;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1998,7 +2004,7 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	if (cpu_is_offline(smp_processor_id())) {
 		if (idle)
 			*idle = true;
-		return expires;
+		return tevt.local;
 	}
 
 	base_local = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
@@ -2014,13 +2020,32 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 
 	nextevt = local_first ? nextevt_local : nextevt_global;
 
-	if (base_local->timers_pending || base_global->timers_pending) {
+	/*
+	 * If the @nextevt is at max. one tick away, use @nextevt and store
+	 * it in the local expiry value. The next global event is irrelevant in
+	 * this case and can be left as KTIME_MAX.
+	 */
+	if (time_before_eq(nextevt, basej + 1)) {
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
-		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		tevt.local = basem + (u64)(nextevt - basej) * TICK_NSEC;
+		goto forward;
 	}
 
+	/*
+	 * Update tevt.* values:
+	 *
+	 * If the local queue expires first, then the global event can be
+	 * ignored. If the global queue is empty, nothing to do either.
+	 */
+	if (!local_first && base_global->timers_pending)
+		tevt.global = basem + (u64)(nextevt_global - basej) * TICK_NSEC;
+
+	if (base_local->timers_pending)
+		tevt.local = basem + (u64)(nextevt_local - basej) * TICK_NSEC;
+
+forward:
 	/*
 	 * We have a fresh next event. Check whether we can forward the
 	 * base.
@@ -2051,6 +2076,8 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	raw_spin_unlock(&base_global->lock);
 	raw_spin_unlock(&base_local->lock);
 
+	expires = min_t(u64, tevt.local, tevt.global);
+
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
-- 
2.39.2


