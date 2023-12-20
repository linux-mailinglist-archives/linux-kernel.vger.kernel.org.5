Return-Path: <linux-kernel+bounces-7235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CCC81A383
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B563D1F25B99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF14AF65;
	Wed, 20 Dec 2023 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GaBUKp9f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="02DPsY78"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B18495F4;
	Wed, 20 Dec 2023 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnVjiQN+/ysegfjW8F2bMiUTrNmuwyS/IDo6pLh2xgs=;
	b=GaBUKp9fn6Imi5GCiy9ZOnRZ3FEMzqvDMSQgDBHDd6NJvRfHdiTkE7fWZSJNwFgdKug9zE
	EiKsW6HqFPaoyM5vZJ9SiFyU/509M/RBV5eY8lMy2i9ke1VdQV9EIvq/ytX6nx6l9Ek1te
	nKVfnYxxmscdOSLAWIhxtCVXUT/B61Vwsvg65aUdHVYZCpvFLyoQCpkMgkNtL3Razhlxhq
	OWW1yAHkR8a6TkfqH7KovtHLy65U7WfBIbN5uFt96R/PuavJFFEyDPHjQb49xTv5O8918Y
	NfsFyWAHzrfabFtwiPNc8qNrbVObp6tqgcS6nK2asdRvXmgrsl8VLx5Qw6095Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087952;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnVjiQN+/ysegfjW8F2bMiUTrNmuwyS/IDo6pLh2xgs=;
	b=02DPsY783mj2jofqLJNKdx6bgDgDvQ4wY8H6ZshbaoxlKCKfdF6XRfrAo5P+HR5FY4N6sI
	POXgdG5R57K6OaBA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick/sched: Cleanup confusing variables
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-3-anna-maria@linutronix.de>
References: <20231201092654.34614-3-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308795185.398.6524480484626871187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     318050671affa92fd166d988d08d4041c7b113c4
Gitweb:        https://git.kernel.org/tip/318050671affa92fd166d988d08d4041c7b113c4
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:37 +01:00

tick/sched: Cleanup confusing variables

tick_nohz_stop_tick() contains the expires (u64 variable) and tick
(ktime_t) variable. In the beginning the value of expires is written to
tick. Afterwards none of the variables is changed. They are only used for
checks.

Drop the not required variable tick and use always expires instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-3-anna-maria@linutronix.de

---
 kernel/time/tick-sched.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index ff25fdf..fce3c6f 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -887,7 +887,6 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
 	u64 basemono = ts->timer_expires_base;
 	u64 expires = ts->timer_expires;
-	ktime_t tick = expires;
 
 	/* Make sure we won't be trying to stop it twice in a row. */
 	ts->timer_expires_base = 0;
@@ -910,7 +909,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	/* Skip reprogram of event if it's not changed */
 	if (ts->tick_stopped && (expires == ts->next_tick)) {
 		/* Sanity check: make sure clockevent is actually programmed */
-		if (tick == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
+		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			return;
 
 		WARN_ON_ONCE(1);
@@ -935,7 +934,7 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		trace_tick_stop(1, TICK_DEP_MASK_NONE);
 	}
 
-	ts->next_tick = tick;
+	ts->next_tick = expires;
 
 	/*
 	 * If the expiration time == KTIME_MAX, then we simply stop
@@ -950,11 +949,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 	}
 
 	if (ts->nohz_mode == NOHZ_MODE_HIGHRES) {
-		hrtimer_start(&ts->sched_timer, tick,
+		hrtimer_start(&ts->sched_timer, expires,
 			      HRTIMER_MODE_ABS_PINNED_HARD);
 	} else {
-		hrtimer_set_expires(&ts->sched_timer, tick);
-		tick_program_event(tick, 1);
+		hrtimer_set_expires(&ts->sched_timer, expires);
+		tick_program_event(expires, 1);
 	}
 }
 

