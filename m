Return-Path: <linux-kernel+bounces-80336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B567A862D7E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FD281FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8452C6A6;
	Sun, 25 Feb 2024 22:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7oYwvG4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B672576B
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901734; cv=none; b=Iet1CLtRTQEGgtBXcbpUaVEsyXfBh79xDQoBluFqHdHh9HzmGA+gJ+4+TCYP+xvYpYbyH5Oax1u2+3h7oPnhF9PXw5/kFQ0UO85dHyb3e/DLzQGoknBp0YqORngSsB9m0y+YDxQyt03XIhg9AEqlF8iEHdKBbQli+gf2rmuJT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901734; c=relaxed/simple;
	bh=a2TLuKZ1NcjYXwjYQRiKiZcFGSpIbLE6pKtHI2QYajQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZicznxWB6rmEWq29uTFg8zs2RHH7I+aLC4zL78Cd5Aadf6Qs74shE68K84WZQxziKA42MDLexGEDk3DREDJZj+j7d55YynKvRDkyIB17bRd8E6mgD6qDxzhKABEyCIeTtVAAMFbnF9QV3P2Brfy1YCMMqE9T54UBWSz9ZPPOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7oYwvG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F1DC43330;
	Sun, 25 Feb 2024 22:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901733;
	bh=a2TLuKZ1NcjYXwjYQRiKiZcFGSpIbLE6pKtHI2QYajQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7oYwvG4n1Y7nG60vnmZjcVkm5N0H1Z4Xn/LhEoBOrMY7z4uX9D9hOMYtj6hC2Bjo
	 7Ftd8HoYbh8PsFjzgUweXRX/AkY4PENBhAzsxOK5aIOPIqbCBScse3s2aDIE6xD9Mq
	 oUYEgUFr/Tal9YFs1UjrC2mqn5nEJMJFAMVKNFi20Hq5oZVcvJEx4RsdTv+D1ZvnAy
	 lEX7mTUIYOGepiZrqrWGe1jsljnXvlle5FVGyacpkbtLsM4Eio9/N/UvzXiNCiZbNE
	 itZdcMLiGD9k2WKnfDOCasexBUJ2CP4yYhZAR1m1OrRGDB4mN5nIIdFlUR9cPg0JcB
	 jCI+dyxCZeTnw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 09/16] tick: Move broadcast cancellation up to CPUHP_AP_TICK_DYING
Date: Sun, 25 Feb 2024 23:55:01 +0100
Message-ID: <20240225225508.11587-10-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
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
index a3243c4ac45f..5f2105e637bd 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -142,8 +142,10 @@ static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_
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


