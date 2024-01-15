Return-Path: <linux-kernel+bounces-26113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3B182DB7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C6E2821FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511E319473;
	Mon, 15 Jan 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJ0ZdCXs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MHGgPXm8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CD418E1E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgXCRky76cIAK5QBFsb3qOUmiS36hjINUCdmIygML+w=;
	b=VJ0ZdCXsTwC3rHgQvht3mFDy8gMSW7AsbulTkecRFJ2Z+Ju9JPZXmawgbflukXbt5vgBWe
	KoAdUAQiIYZj9c3G+ACdgevN3KtEj59A6YXhOwB3PxjpgD0w3wuOPKlr6g+G2vhRTCFTN0
	KXDI2rTeKIjmNTpyNDzBBtDVqevBouoMOswftP5rL36OeUJAIEFu9YUdUUWggGpC7pwSIZ
	IIORwcCgDMWlkQ+mRZc0pvNWNNWj7hTiUqt1eBvTNfP8MohcZzchWXpz3DX8xGDQ6Iq+0L
	pjE+a4/quqWC/j7/TNb5IbGcfTmKB5R5LVodaUb7pwqqkShObFwWnxGH//uuMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgXCRky76cIAK5QBFsb3qOUmiS36hjINUCdmIygML+w=;
	b=MHGgPXm8qWbBjcbzLFlIsP+V77UUBvpMyV8XjM6R3228s7QVVTwUJQ0sqMlPvj3iFVm+Sn
	mBcwtPddeKZe2PCQ==
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
Subject: [PATCH v10 17/20] timers: Introduce function to check timer base is_idle flag
Date: Mon, 15 Jan 2024 15:37:40 +0100
Message-Id: <20240115143743.27827-18-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 flag

To prepare for the conversion of the NOHZ timer placement to a pull at
expiry time model it's required to have a function that returns the value
of the is_idle flag of the timer base to keep the hierarchy states during
online in sync with timer base state.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v10: Fix fallout of 0day: Move function definition of timer_base_is_idle()
     into SMP && NO_HZ_COMMON ifdef section

v9: new in v9
---
 kernel/time/tick-internal.h |  1 +
 kernel/time/timer.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index ccf39befde85..7e3090109e33 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,6 +165,7 @@ extern void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
 					      unsigned int cpu);
 extern void timer_lock_remote_bases(unsigned int cpu);
 extern void timer_unlock_remote_bases(unsigned int cpu);
+extern bool timer_base_is_idle(void);
 # endif
 #else /* CONFIG_NO_HZ_COMMON */
 static inline void timers_update_nohz(void) { }
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index eb99297a96fe..3c49d8fdfd53 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2099,6 +2099,16 @@ void timer_lock_remote_bases(unsigned int cpu)
 	raw_spin_lock(&base_local->lock);
 	raw_spin_lock_nested(&base_global->lock, SINGLE_DEPTH_NESTING);
 }
+
+/**
+ * timer_base_is_idle() - Return whether timer base is set idle
+ *
+ * Returns value of local timer base is_idle value.
+ */
+bool timer_base_is_idle(void)
+{
+	return __this_cpu_read(timer_bases[BASE_LOCAL].is_idle);
+}
 # endif /* CONFIG_SMP */
 
 static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
-- 
2.39.2


