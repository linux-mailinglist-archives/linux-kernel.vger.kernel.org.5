Return-Path: <linux-kernel+bounces-26098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CCA82DB69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E41F22969
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599671775A;
	Mon, 15 Jan 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iqQYd40g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jpYB6+8/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87C1773A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrRJNa/4dVg7BTloDs+oOr0KGfNkWbg12FR3FDPf3kI=;
	b=iqQYd40g6jjZ8kvPdnidNQc8zqE5Zq5Oyd0ENex12OAECMGf7KJPZOxPlpgecMDOfNqmjp
	iSy92IYa4iyCzHf9wnuCjjdxhwFefVqTiZhARgqzAOiIsvFWKHCR6BK/KNe2vdP5Ua7sB1
	vAXuf2/mj9R/MgJpjnqHHWbls4jIzdmidCZzDt3zJQFSV0knI5FtJFmMI3/Hii6OM9QZIy
	jvNw99w1eN8BfV4GjgNbYAjA/7fvkozUcKJa1qjp+T8O9TDalR84pVax7b9P/1FamlfGCe
	ma7GDWmdCIter2i5Q6ndvM5UikKP/QzDrf8+OcsFKhDYPIOPWSymcysUKyLXGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TrRJNa/4dVg7BTloDs+oOr0KGfNkWbg12FR3FDPf3kI=;
	b=jpYB6+8/2KkjAvRHid8a5at40ByDrZXjwLFmJvXJPlY2UnGF/8Tkauw4/zFeqbbofToFQd
	OONQDpUIoneCDnBw==
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
Subject: [PATCH v10 02/20] timers: Split out get next timer interrupt
Date: Mon, 15 Jan 2024 15:37:25 +0100
Message-Id: <20240115143743.27827-3-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split out get_next_timer_interrupt() to be able to extend it and make it
reusable for other call sites.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5f21db4fa3ca..2aea55d53416 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1911,15 +1911,7 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 	return DIV_ROUND_UP_ULL(nextevt, TICK_NSEC) * TICK_NSEC;
 }
 
-/**
- * get_next_timer_interrupt - return the time (clock mono) of the next timer
- * @basej:	base time jiffies
- * @basem:	base time clock monotonic
- *
- * Returns the tick aligned clock monotonic time of the next pending
- * timer or KTIME_MAX if no timer is pending.
- */
-u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
@@ -1978,6 +1970,19 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	return cmp_next_hrtimer_event(basem, expires);
 }
 
+/**
+ * get_next_timer_interrupt() - return the time (clock mono) of the next timer
+ * @basej:	base time jiffies
+ * @basem:	base time clock monotonic
+ *
+ * Returns the tick aligned clock monotonic time of the next pending
+ * timer or KTIME_MAX if no timer is pending.
+ */
+u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
+{
+	return __get_next_timer_interrupt(basej, basem);
+}
+
 /**
  * timer_clear_idle - Clear the idle state of the timer base
  *
-- 
2.39.2


