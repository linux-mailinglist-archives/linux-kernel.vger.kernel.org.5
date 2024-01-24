Return-Path: <linux-kernel+bounces-37382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BE83AF28
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DD61C236F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732BC82D8B;
	Wed, 24 Jan 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+5+0qTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03B82D61
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115917; cv=none; b=cqPmwllO7cmTuUgXFTfz8d9bN1QYr7wKutuMAzWOnlJKIFGcdRFyYaB/Hg8g76GTpEoF8hhdp90kt7AL+4VqFJieeqs2sU/CMUl7r6qaPKAtOt6m6ISwi8SbiN335v4Yre8MuhgRDyUFvDei6PxkMcWSHQ7JqrcrCUcsig64SYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115917; c=relaxed/simple;
	bh=uzYnPBI5fpXuU09Kdz9I43Q6jP1A/pGf8ZYQb0OnNe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZq5/08FZtkuvNkmkm8l02PLOgOXR3Y2briGns8YmaI7TbIiDud64sW8ZRsJ8B9SPhtp+YVJzJGaA/VA2mLpe65/BI+aGWS7PHiiQrMVug9/vLfYE9AID8A85UO+4HN+4mB36zWi60mQYaQ6TO9GkqFoQupTExQQ8CD1asf5G/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+5+0qTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0B0C43390;
	Wed, 24 Jan 2024 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115917;
	bh=uzYnPBI5fpXuU09Kdz9I43Q6jP1A/pGf8ZYQb0OnNe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+5+0qTfzlsiEbgesln38n9/trBqNWVhrZLe9aNxDqgiIzvWBj2yy8vGBUTTyhf20
	 6KxW7NkM/wYuzCk6p9cwoQrCjCe48GcAgTZmqZ08XHpzq3jB4jC5mrElGtEmjE5TtY
	 h9EyX1jch0iWmK8rjFGnta7q7X7QwwHn9lMArleRfHYtzR3qJrVTUPRTHJz7sZAS0j
	 xdTTqs/41lJh+j7HiZ6cAJOlbsLiUlEdW3coIAPrVo4RMr3YYraCfYrTDC/2D/Ynza
	 duOOEZwpXvC0Ip6fpvzbqaYMJLbUpUuUus4b2v4akUmhfvlAI/JbGkQPVdvIyN6OCS
	 VhoAE78NCB8vw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/15] tick: Remove useless oneshot ifdeffery
Date: Wed, 24 Jan 2024 18:04:47 +0100
Message-ID: <20240124170459.24850-4-frederic@kernel.org>
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

tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
the related ifdeferry in this file is needless and can be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 6f69ae88e47e..75385b9a233e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -43,7 +43,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 	return &per_cpu(tick_cpu_sched, cpu);
 }
 
-#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
  * The time when the last jiffy update happened. Write access must hold
  * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
@@ -290,7 +289,6 @@ static enum hrtimer_restart tick_nohz_highres_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
-#endif
 
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
@@ -636,7 +634,7 @@ void __init tick_nohz_init(void)
 	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
 		cpumask_pr_args(tick_nohz_full_mask));
 }
-#endif
+#endif /* #ifdef CONFIG_NO_HZ_FULL */
 
 /*
  * NOHZ - aka dynamic tick functionality
@@ -1506,7 +1504,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
@@ -1565,7 +1562,6 @@ void tick_cancel_sched_timer(int cpu)
 	ts->idle_sleeptime = idle_sleeptime;
 	ts->iowait_sleeptime = iowait_sleeptime;
 }
-#endif /* CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Async notification about clocksource changes
-- 
2.43.0


