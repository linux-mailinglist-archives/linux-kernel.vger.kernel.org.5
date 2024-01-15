Return-Path: <linux-kernel+bounces-26100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8072682DB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F041F21B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09CC179BF;
	Mon, 15 Jan 2024 14:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NlXab2cz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WukEzm0D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A933F17743
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tyreN3+pRRCj9fddFni7Yjd9oa5LLsmYxigcZC8rcg=;
	b=NlXab2czETZp0xP+IzFHm6awdOka425Kzdzign5GPkoImvVgJWFPet0O1EW09TvG7M0L3m
	Y+dn4iDZS+MzOESzvSjVs7M4BV37zoPhtQ299jVWZRsGqLkETRvccoIw2UdMEDJfaZFOgH
	uaGiiYdetxgsHsjKab2KMYxJka1GNu0bxN/NhKYHll6hFm7OldcGToYy9qqCV4dySwibWU
	5i/fqIwQZrKElFuVBQCNTxGL83OT1hcWi1xGQlI5YvU4lDXzREJ5e2qRnx5S3OdFbC6SWG
	075hrzrLNhmiTPkEsV2Fok+cgT+UxrqcOozjePeIX5Xtghz9xkzAMgUO9HFhGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8tyreN3+pRRCj9fddFni7Yjd9oa5LLsmYxigcZC8rcg=;
	b=WukEzm0DqpDbF2CDUItBPNFQBpgiXis0UKMUH26OhxA6gVei/m2F7wqKm8NtJaTG3Li47F
	oGqLobTfz0ErcmCg==
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
Subject: [PATCH v10 04/20] timers: Optimization for timer_base_try_to_set_idle()
Date: Mon, 15 Jan 2024 15:37:27 +0100
Message-Id: <20240115143743.27827-5-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tick is stopped also the timer base is_idle flag is set. When
reentering the timer_base_try_to_set_idle() with the tick stopped, there is
no need to check whether the timer base needs to be set idle again. When a
timer was enqueued in the meantime, this is already handled by the
tick_nohz_next_event() call which was executed before
tick_nohz_stop_tick().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-sched.c |  2 +-
 kernel/time/timer.c      | 11 ++++++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c6223afc801f..27f1a2ae7f39 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -886,7 +886,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	unsigned long basejiff = ts->last_jiffies;
 	u64 basemono = ts->timer_expires_base;
-	bool timer_idle;
+	bool timer_idle = ts->tick_stopped;
 	u64 expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3a668060692e..2f69a485a070 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1999,13 +1999,18 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
  * timer_base_try_to_set_idle() - Try to set the idle state of the timer bases
  * @basej:	base time jiffies
  * @basem:	base time clock monotonic
- * @idle:	pointer to store the value of timer_base->is_idle
+ * @idle:	pointer to store the value of timer_base->is_idle on return;
+ *		*idle contains the information whether tick was already stopped
  *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
+ * Returns the tick aligned clock monotonic time of the next pending timer or
+ * KTIME_MAX if no timer is pending. When tick was already stopped KTIME_MAX is
+ * returned as well.
  */
 u64 timer_base_try_to_set_idle(unsigned long basej, u64 basem, bool *idle)
 {
+	if (*idle)
+		return KTIME_MAX;
+
 	return __get_next_timer_interrupt(basej, basem, idle);
 }
 
-- 
2.39.2


