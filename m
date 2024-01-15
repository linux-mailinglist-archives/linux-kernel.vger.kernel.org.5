Return-Path: <linux-kernel+bounces-26111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C6482DB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AC31C21BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7B18ECA;
	Mon, 15 Jan 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ie8gWsdU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atGElf/B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9E18C01
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Opkow5gPOaaBUb3NbiN3AOkG3DcAm/G1qJk4x5I78GI=;
	b=ie8gWsdUYa+mDSLuzV7dk7msmvEw1vRr4MX7/KUDaezICOJHY5kGXthCkRRrq2V/Cm3QwT
	M/Ia4z+ICY3uEuKwzf+KJlwoCRioqjhG5E13ONLvcsGwXLtI6hdf3qlCZlTmqAHITBQnV/
	oCmnmfKS4Ec15QGfvdk/K10X3oZ5J+4UrWvzf6cl/l+KT72NR1/6rUxenmm0HuPSDIFOEd
	Ig9fkQEMR2/Exz+mAs2mKoK63fKL4Y7v3bWXdFksZb7DIJ1wO7gDBLfTGXB6yWhCu8Isgb
	hoGlq1Q7rouQh+yiYK2hDV43qJ91UebEjVLWxcgDnugQhnfUmp/oz2iJ8qyzCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Opkow5gPOaaBUb3NbiN3AOkG3DcAm/G1qJk4x5I78GI=;
	b=atGElf/B15NatGtc5QWfPX7yXEKL5ON23WrledoHFHNeTOnwOonj+qkfzRdjJFyPyW6n21
	PvNi9dInYpmACHDg==
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
Subject: [PATCH v10 15/20] timers: Check if timers base is handled already
Date: Mon, 15 Jan 2024 15:37:38 +0100
Message-Id: <20240115143743.27827-16-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the conversion of the NOHZ timer placement to a pull at expiry
time model, the per CPU timer bases with non pinned timers are no
longer handled only by the local CPU. In case a remote CPU already
expires the non pinned timers base of the local CPU, nothing more
needs to be done by the local CPU. A check at the begin of the expire
timers routine is required, because timer base lock is dropped before
executing the timer callback function.

This is a preparatory work, but has no functional impact right now.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v10: s/cpu/CPU/ in commit message

v6: Drop double negation
---
 kernel/time/timer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ccb2a5c03b87..eb99297a96fe 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2225,6 +2225,9 @@ static inline void __run_timers(struct timer_base *base)
 
 	lockdep_assert_held(&base->lock);
 
+	if (base->running_timer)
+		return;
+
 	while (time_after_eq(jiffies, base->clk) &&
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels = collect_expired_timers(base, heads);
-- 
2.39.2


