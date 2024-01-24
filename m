Return-Path: <linux-kernel+bounces-37388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B7F83AF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B5161C21CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24E71272A5;
	Wed, 24 Jan 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VER8K9h2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F6D86AF3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115931; cv=none; b=KBiuaANn1slV+VDuDWjTm6rK2P0VNpH1BXU3JopLi3Y5M/zmwrapAoluzNKrR/LGIzQtdKfHNhHOx6j8bjQjoPUwogbC8NOclJzc1TKxPxiB4nbDhT3Kr8CJA+Cg4OrABH5g32NSh5jwxNTRz+h2G5KC6z4whgDE9yPfZ49Del0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115931; c=relaxed/simple;
	bh=M4HS4i9INNBmGr3d/GfNARoMdgXE99jEy5fvedm3YDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQxiWmZhi8GFwV9dZTVCUdSog90bfxBuD4u4WXqgwwIvxF/ep+RFMt9ahFEc3Uw5jjQJliwJXLKTH0IqnTvuYenM0WD2T7gb90R4EstTn1GJ9tTd3vbHGFXQUxs0r1CVfJOjy3a5cE8vFqGvFH6VqKybtGEqeRutWuT5Zz9NA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VER8K9h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E49C43394;
	Wed, 24 Jan 2024 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115930;
	bh=M4HS4i9INNBmGr3d/GfNARoMdgXE99jEy5fvedm3YDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VER8K9h2lzl9Xmakflxcyi4nVrh3leQVSrph5vFLdBqjPjsF9Anyt/c21xBTvxPu6
	 TERvPKs0A/R5dr1/2RhuSDG04alj6MUmkMj+t8zTJH6fl43dG2eQ0/St04tvTo4f16
	 UT+9WOxWMMBrrYhr4eGRwbXelsZ/14wkhhf4qIKDqQZqkymmQy5RU+yVC/45in3u1u
	 mWRV+ZX8/vZ+uIM7WY5P4az1ZBWYpMkGcc5mSyNfv9h9N4enfCN9IxHHCA6+hUMujN
	 6p9mPdQ650qF5uFDzVfqlwBJeXcFgo6UJCbX7mrOgT5F5AGNMn3JQIgD/v0frLVkvz
	 JShPiwyDA/zsA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 09/15] tick: Move broadcast cancellation up to CPUHP_AP_TICK_DYING
Date: Wed, 24 Jan 2024 18:04:53 +0100
Message-ID: <20240124170459.24850-10-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170459.24850-1-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The broadcast shutdown code is executed through a random explicit call
within stop machine from the outgoing CPU.

However The tick broadcast is a midware between the tick callback and
the clocksource, therefore it makes more sense to shut it down after the
tick callback and before the clocksource drivers.

Move it instead to the common tick shutdown CPU hotplug state where
related operations can be ordered from highest to lowest level.

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


