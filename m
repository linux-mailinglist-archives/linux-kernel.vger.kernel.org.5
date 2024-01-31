Return-Path: <linux-kernel+bounces-47353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD139844CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923C01F23B6A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD788286B;
	Wed, 31 Jan 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1iv1NUe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6D69D01
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742707; cv=none; b=mdH+SzE6wkUq/L79Q1/TuyG2PqlAwatf1vCUGxR+YTITm0mQ8b8qRUEWmxd4wZUJ+1wmD7kewphitx3YuEqYpcJmlhdBbjDVsajmYOmLFFfyLkZCfNFcsa84/MNABsPyuU1sTcWR59sOHUQBVUbhL5FCmUo/Nlw52Abr5kwImTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742707; c=relaxed/simple;
	bh=MlUbkGKGjJi82z5TxfBnlqTsq0RVRvhDZpea1eJZW/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN8lrmYSlJm5QtHqwUDJTB+49io/aFH0cq3HmcEaNahUPLMaJJGXKPMI0bylSy4Xu/YEDopIMBzPEib6CRX8okYLAt/LnyNWJcTfLKkFhH1QwVHE3h94uFeV5xxVs93EIcV3/UqVwhU2jXu3lnexNI8WTnYcB3YIRTrowu/ptYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1iv1NUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24EDC43390;
	Wed, 31 Jan 2024 23:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742706;
	bh=MlUbkGKGjJi82z5TxfBnlqTsq0RVRvhDZpea1eJZW/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1iv1NUe6YFmz80ocBTAV/rgd85OVpBLfRdAaRWhQko51iiRTuZSjsESN4+4epWte
	 MVqy+xp9ee0/+vODHuypmRFuzISZkELUlpAu787iYFNS42CnqGtirMrLbzkR5VpZG7
	 799amkNTKfWi/jPIUPdVuyX3w9ZzLFroBT4gXMpK1qRoadY6eD8kstdsNBTvMG69SR
	 /CpvlyVZSV9He4HLIv7UKhtr6uzkHAMpIuEk/i7juVIS356hIHUZwtv0xmk+KbZWss
	 PwEBeaHHcfW2Z9bGlNdWGLx0J9eWJOB+ICo20YHNgg6EgJ4LoZSn7O9CQ21lbm/N5g
	 FCZIT1JPDKKWg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 09/15] tick: Move broadcast cancellation up to CPUHP_AP_TICK_DYING
Date: Thu,  1 Feb 2024 00:11:14 +0100
Message-ID: <20240131231120.12006-10-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131231120.12006-1-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The broadcast shutdown code is executed through a random explicit call
within stop machine from the outgoing CPU.

However the tick broadcast is a midware between the tick callback and
the clocksource, therefore it makes more sense to shut it down after the
tick callback and before the clocksource drivers.

Move it instead to the common tick shutdown CPU hotplug state where
related operations can be ordered from highest to lowest level.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h        | 6 ------
 kernel/cpu.c                | 2 --
 kernel/time/tick-common.c   | 3 +++
 kernel/time/tick-internal.h | 2 ++
 4 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index afff4c207bd8..c7840ae8ebaf 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -73,12 +73,6 @@ extern void tick_broadcast_control(enum tick_broadcast_mode mode);
 static inline void tick_broadcast_control(enum tick_broadcast_mode mode) { }
 #endif /* BROADCAST */
 
-#if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
-extern void tick_offline_cpu(unsigned int cpu);
-#else
-static inline void tick_offline_cpu(unsigned int cpu) { }
-#endif
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 extern int tick_broadcast_oneshot_control(enum tick_broadcast_state state);
 #else
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 263508073da8..5a8ad4f5ccf3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1324,8 +1324,6 @@ static int take_cpu_down(void *_param)
 	 */
 	cpuhp_invoke_callback_range_nofail(false, cpu, st, target);
 
-	/* Remove CPU from timer broadcasting */
-	tick_offline_cpu(cpu);
 	/* Park the stopper thread */
 	stop_machine_park(cpu);
 	return 0;
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index b4af8c743b73..522414089c0d 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -412,6 +412,9 @@ int tick_cpu_dying(unsigned int dying_cpu)
 
 	tick_cancel_sched_timer(dying_cpu);
 
+	/* Remove CPU from timer broadcasting */
+	tick_offline_cpu(dying_cpu);
+
 	return 0;
 }
 
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 481b7ab65e2c..a939ff6de97c 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -137,8 +137,10 @@ static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_
 #endif /* !(BROADCAST && ONESHOT) */
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
+extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_broadcast_offline(unsigned int cpu);
 #else
+static inline void tick_offline_cpu(unsigned int cpu) { }
 static inline void tick_broadcast_offline(unsigned int cpu) { }
 #endif
 
-- 
2.43.0


