Return-Path: <linux-kernel+bounces-26096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994CA82DB68
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780F31C21B97
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38B017748;
	Mon, 15 Jan 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKME5u9Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BZs3wXhs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62DD17738
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI9g9MDbA2NFp7jgDttymOb2sC6nFxhp2a/RZS0Cubo=;
	b=dKME5u9YJRG9rJBXAK+YQgOciaQpeurM1q2gGo7H/jfxRnKrlC/PnxxVZXurGGwTY+rmXc
	Ldmk2exeCLEOEpJhE3PzGps785U+vNDBLqTn/GQfF9YZnpR4Do53XoTrYwb6bwo31kTeQq
	h5Qe4It9XifK89MSwYxtYcSB9Nzs91HFVu99rFZ/9GwT3OAZ4vD+fCvCr/ZJnam3Bv8wIc
	Gk+QuEUicMziS1+XSLjIyuAyU3+vIOjzIEnA5A01l4IoBk1rbkhl2sfMlrJnmB4Qpqgjgy
	+b1bwYF0jt3dKgrbnyUkhtZei+IqjaSTu/NHB2mzluaCybNsFaJTg6xgV+AxnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MI9g9MDbA2NFp7jgDttymOb2sC6nFxhp2a/RZS0Cubo=;
	b=BZs3wXhsMMmkrUob5t5tgA7S+fbdHDyNyUea31/wUAg5nASEUBX78LfwVe21ZJgJzXKJGw
	ftF9HXeATwEkVvCQ==
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
Subject: [PATCH v10 01/20] timers: Restructure get_next_timer_interrupt()
Date: Mon, 15 Jan 2024 15:37:24 +0100
Message-Id: <20240115143743.27827-2-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_next_timer_interrupt() contains two parts for the next timer interrupt
calculation. Those two parts are separated by forwarding the base
clock. But the second part does not depend on the forwarded base
clock.

Therefore restructure get_next_timer_interrupt() to keep things together
which belong together.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 352b161113cd..5f21db4fa3ca 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1937,12 +1937,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (base->next_expiry_recalc)
 		next_expiry_recalc(base);
 
-	/*
-	 * We have a fresh next event. Check whether we can forward the
-	 * base.
-	 */
-	__forward_timer_base(base, basej);
-
 	if (base->timers_pending) {
 		nextevt = base->next_expiry;
 
@@ -1960,6 +1954,12 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		base->next_expiry = nextevt;
 	}
 
+	/*
+	 * We have a fresh next event. Check whether we can forward the
+	 * base.
+	 */
+	__forward_timer_base(base, basej);
+
 	/*
 	 * Base is idle if the next event is more than a tick away.
 	 *
-- 
2.39.2


