Return-Path: <linux-kernel+bounces-7226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978DE81A371
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA58B1C21040
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4772647A46;
	Wed, 20 Dec 2023 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Px0fbsSI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uwETzG2N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA454777A;
	Wed, 20 Dec 2023 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td3wSB/DOZuCWjh238SHCOj/5C7U3BaCUMkrlEk/388=;
	b=Px0fbsSIqmcP197pR6oE38hcdlJFQyVyrm4yU9YHLrfYx/GseXsuqtl49yRt8D5o9EX2uK
	HFTYpdtKxZ8OC0PYQbYItji4dqPeJ/spwZPYbSKD91E7vcgolCBo2fKGoLPVHeZLhahhD9
	TTn/UCsy2XqHMlvPJb/4fo3SgOk2KlwEIi0dYSPOBO8aHbCcE7+r68ONgq6Y5A4yDEl3+r
	NGy2DyG5IAgW1iVnmqGaf9dRvgCqtLREEWuf2VlQ1W+xaMO2zJ2rM3pnKzEQfRFclU8S/G
	foDPUMpna2C9f2Okuojx8zAe/n14CBXeAJ55SaZEo+ikEXYD8NIkF3+yeCL12A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Td3wSB/DOZuCWjh238SHCOj/5C7U3BaCUMkrlEk/388=;
	b=uwETzG2N/2EDF24Pk2vmCqQ2nlmvvuPFyJCZdsoOSr+7LOO6DR0gJtPPEL4ugwiFLSgAXR
	fmLVxk9kFyGXUECA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Rework idle logic
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-12-anna-maria@linutronix.de>
References: <20231201092654.34614-12-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794576.398.14853285355334106633.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     bb8caad5083f8fbba70faf41f1d3bab7cf09da6d
Gitweb:        https://git.kernel.org/tip/bb8caad5083f8fbba70faf41f1d3bab7cf09da6d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:33 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:39 +01:00

timers: Rework idle logic

To improve readability of the code, split base->idle calculation and
expires calculation into separate parts. While at it, update the comment
about timer base idle marking.

Thereby the following subtle change happens if the next event is just one
jiffy ahead and the tick was already stopped: Originally base->is_idle
remains true in this situation. Now base->is_idle turns to false. This may
spare an IPI if a timer is enqueued remotely to an idle CPU that is going
to tick on the next jiffy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-12-anna-maria@linutronix.de

---
 kernel/time/timer.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 1a73d39..cf51655 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1924,6 +1924,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
+	bool was_idle;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1943,27 +1944,26 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	 */
 	__forward_timer_base(base, basej);
 
-	if (time_before_eq(nextevt, basej)) {
-		expires = basem;
-		if (base->is_idle) {
-			base->is_idle = false;
-			trace_timer_base_idle(false, base->cpu);
-		}
-	} else {
-		if (base->timers_pending)
-			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
-		/*
-		 * If we expect to sleep more than a tick, mark the base idle.
-		 * Also the tick is stopped so any added timer must forward
-		 * the base clk itself to keep granularity small. This idle
-		 * logic is only maintained for the BASE_STD base, deferrable
-		 * timers may still see large granularity skew (by design).
-		 */
-		if ((expires - basem) > TICK_NSEC && !base->is_idle) {
-			base->is_idle = true;
-			trace_timer_base_idle(true, base->cpu);
-		}
+	if (base->timers_pending) {
+		/* If we missed a tick already, force 0 delta */
+		if (time_before(nextevt, basej))
+			nextevt = basej;
+		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 	}
+
+	/*
+	 * Base is idle if the next event is more than a tick away.
+	 *
+	 * If the base is marked idle then any timer add operation must forward
+	 * the base clk itself to keep granularity small. This idle logic is
+	 * only maintained for the BASE_STD base, deferrable timers may still
+	 * see large granularity skew (by design).
+	 */
+	was_idle = base->is_idle;
+	base->is_idle = time_after(nextevt, basej + 1);
+	if (was_idle != base->is_idle)
+		trace_timer_base_idle(base->is_idle, base->cpu);
+
 	raw_spin_unlock(&base->lock);
 
 	return cmp_next_hrtimer_event(basem, expires);

