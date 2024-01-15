Return-Path: <linux-kernel+bounces-26106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D87ED82DB75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DBC4B20EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F018AF9;
	Mon, 15 Jan 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOfR+TFm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1MnTz91"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240917C9B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEgGcKW6JMWXT3RCg8hyceZW3QBGqilSX6gklxOWvpk=;
	b=OOfR+TFmuoq1rA3vYVTvo3+FzOeggKrZ0WzzTutc+zcu82SfPSvzII9tkIgID4XXXAh9dt
	k+oXrDafspOpKlLO38OMfkEKP5cfwQZBxe8n5j0gGKL8PLw/ebdeVKCya5hmmL6dOx0s3W
	83b6felodkEXVLPDvtWIQk3S6we2XlVYc4apue+mjtBhV8Xedo87lBh5pAA8mtQaHVzIXk
	gn6DNUDU323/F5HMOxrRSzAP8y+szN/MoKB4STfcoOK0Mnvptx6/CiW4jjvkNxPO6YifMd
	BRW6UhFXMmRaQQG9OY7D92EhOeTK4bCEWULip4QU1Oq8pBZRaG2K/COFUc5jwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zEgGcKW6JMWXT3RCg8hyceZW3QBGqilSX6gklxOWvpk=;
	b=L1MnTz91citajB5OnIT2JeXGPJE4ZPdnJSdsCoXRfjHBiBtM4QgSeuuvk95svk0gN9DCrB
	mgk/Ocz6V6BIXMBA==
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
Subject: [PATCH v10 09/20] timers: Split next timer interrupt logic
Date: Mon, 15 Jan 2024 15:37:32 +0100
Message-Id: <20240115143743.27827-10-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split the logic for getting next timer interrupt (no matter of recalculated
or already stored in base->next_expiry) into a separate function named
next_timer_interrupt(). Make it available to local call sites only.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v10: Reword commit message

v9: Adapt to the fix for empty timer bases.
---
 kernel/time/timer.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 793848167852..4d6cf49a2fd1 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1951,12 +1951,29 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
+static unsigned long next_timer_interrupt(struct timer_base *base,
+					  unsigned long basej)
+{
+	if (base->next_expiry_recalc)
+		next_expiry_recalc(base);
+
+	/*
+	 * Move next_expiry for the empty base into the future to prevent an
+	 * unnecessary raise of the timer softirq when the next_expiry value
+	 * will be reached even if there is no timer pending.
+	 */
+	if (!base->timers_pending)
+		base->next_expiry = basej + NEXT_TIMER_MAX_DELTA;
+
+	return base->next_expiry;
+}
+
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 					     bool *idle)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
-	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
+	unsigned long nextevt;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1969,24 +1986,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 	}
 
 	raw_spin_lock(&base->lock);
-	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+	nextevt = next_timer_interrupt(base, basej);
 
 	if (base->timers_pending) {
-		nextevt = base->next_expiry;
-
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-	} else {
-		/*
-		 * Move next_expiry for the empty base into the future to
-		 * prevent a unnecessary raise of the timer softirq when the
-		 * next_expiry value will be reached even if there is no timer
-		 * pending.
-		 */
-		base->next_expiry = nextevt;
 	}
 
 	/*
-- 
2.39.2


