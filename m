Return-Path: <linux-kernel+bounces-7232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7A881A37D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E7C0B26D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8B945C18;
	Wed, 20 Dec 2023 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8i5zmYJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FiNT2VbF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0F487BE;
	Wed, 20 Dec 2023 15:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6orTWLX4jF280KMDj0LvfxF+CGeUwBDqDHyIaGq8Sog=;
	b=X8i5zmYJy5pkvlLtCyEN2A6J0//niCnFy1XpNceCDd7HVTzvLzx+FxuuEn71TGLEggGoSl
	pMKXoOKJxFKtJGUk/dEnRHl3PelkiZvsWksMRDQzMcMWHtD2ZL6hDDdpM4RZQcgdwh+Tjf
	jn9jraQ+OFD/5L3KhH2XoHgiet4gDCrkZQFW/945XTo2+CM9NvDuYKMaFJAgj4cD/lClJ9
	kSC7/A46tanbCNUhPznPddE20FkIxGh7AxlbZDWY29Ds6efGCijCW7LzbqhG1zkAKdvCnb
	Xw9rMlqaPFmnGZxQITvQ7OdWqPV2faKSinBEuN1ZcLel1C8x7cv6ydV0uGQ8KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6orTWLX4jF280KMDj0LvfxF+CGeUwBDqDHyIaGq8Sog=;
	b=FiNT2VbF3Sc2HM2ciTDk1gFM0+DdKH05G0MkvT0MdMWXsggUHzW3/ods6cmgVRsQrJomRB
	G/1PaXN4FJsi6qCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tracing/timers: Add tracepoint for tracking timer
 base is_idle flag
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-6-anna-maria@linutronix.de>
References: <20231201092654.34614-6-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308795011.398.2295802154247417093.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b573c73101d8786446535b2ab28cbc8907bda9a9
Gitweb:        https://git.kernel.org/tip/b573c73101d8786446535b2ab28cbc8907bda9a9
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

tracing/timers: Add tracepoint for tracking timer base is_idle flag

When debugging timer code the timer tracepoints are very important. There
is no tracepoint when the is_idle flag of the timer base changes. Instead
of always adding manually trace_printk(), add tracepoints which can be
easily enabled whenever required.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-6-anna-maria@linutronix.de

---
 include/trace/events/timer.h | 20 ++++++++++++++++++++
 kernel/time/timer.c          | 14 +++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 99ada92..1ef58a0 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -142,6 +142,26 @@ DEFINE_EVENT(timer_class, timer_cancel,
 	TP_ARGS(timer)
 );
 
+TRACE_EVENT(timer_base_idle,
+
+	TP_PROTO(bool is_idle, unsigned int cpu),
+
+	TP_ARGS(is_idle, cpu),
+
+	TP_STRUCT__entry(
+		__field( bool,		is_idle	)
+		__field( unsigned int,	cpu	)
+	),
+
+	TP_fast_assign(
+		__entry->is_idle	= is_idle;
+		__entry->cpu		= cpu;
+	),
+
+	TP_printk("is_idle=%d cpu=%d",
+		  __entry->is_idle, __entry->cpu)
+);
+
 #define decode_clockid(type)						\
 	__print_symbolic(type,						\
 		{ CLOCK_REALTIME,	"CLOCK_REALTIME"	},	\
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a81d793..ed8d606 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1950,7 +1950,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	if (time_before_eq(nextevt, basej)) {
 		expires = basem;
-		base->is_idle = false;
+		if (base->is_idle) {
+			base->is_idle = false;
+			trace_timer_base_idle(false, base->cpu);
+		}
 	} else {
 		if (base->timers_pending)
 			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
@@ -1961,8 +1964,10 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		 * logic is only maintained for the BASE_STD base, deferrable
 		 * timers may still see large granularity skew (by design).
 		 */
-		if ((expires - basem) > TICK_NSEC)
+		if ((expires - basem) > TICK_NSEC && !base->is_idle) {
 			base->is_idle = true;
+			trace_timer_base_idle(true, base->cpu);
+		}
 	}
 	raw_spin_unlock(&base->lock);
 
@@ -1984,7 +1989,10 @@ void timer_clear_idle(void)
 	 * sending the IPI a few instructions smaller for the cost of taking
 	 * the lock in the exit from idle path.
 	 */
-	base->is_idle = false;
+	if (base->is_idle) {
+		base->is_idle = false;
+		trace_timer_base_idle(false, smp_processor_id());
+	}
 }
 #endif
 

