Return-Path: <linux-kernel+bounces-47347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09306844CBE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCFF1C24E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467ED4879D;
	Wed, 31 Jan 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu2BMKfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80F4878D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742693; cv=none; b=sdK11/339JHagYebTadWOENMVet56zmPBJE6+4GEm5BiwiLfgd7+3QMkEwc0uQkMeYvlVnho86uXdAZc+1sA+q5Z/q/XXZIJBA2LUJ/vzIcpxSIxXGAcBFcY48C7jQq0qFPjatENIe1OdZdB/ZCYY6e67D8eZ4iUatK+A72X2Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742693; c=relaxed/simple;
	bh=bdfS8bPbTsmzbdiim69fTRLC6qHuhmCc45TsOfVHL2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vet5CWtG7LGZadHLiSuC7jdQx3VpphMH+kSFGa/dfyrLBl2Px3oqWPWHCkfkBBNvvwV0QFbAN09HYKsu+amU7YNLFIUQSpP38axkWqhLE2zXM/mFdWtGjDrx7q8BXsCu1hlHDroX/UmIJkchuduvmPYC/+YuK6JGENMcq9hnYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu2BMKfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A22C433C7;
	Wed, 31 Jan 2024 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742693;
	bh=bdfS8bPbTsmzbdiim69fTRLC6qHuhmCc45TsOfVHL2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pu2BMKfxpDonJh96TUh4I4OS27tDicdRWAeUYtR89pMgcIYaqvcf33MmyCmIuECpE
	 z5F7ZOFxbLEqTQD9oibni2BhUXXUGcyVRw7GxBc/nq15gVXeHpcTCShV3VHDCmuRtl
	 xog5UJ54vaweu4GcjxieY4FB0WAttRG/rZQ8mIlZu0NLGqvdnII2KWgBSWrU68h20v
	 tUq3UNMeul79lwRvFtl2cC9v1gYQjjsL7Tfee/Zu5FJT+iV4Z2IqfHty/UJ76oKjI+
	 JilVAiHp2sMGWEFPwrFIwsgapuxVwOTAsoYrmUbDtPTCHrCN6tAkgvdbJGYg1hS7wV
	 26sr/sDAvRe3Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/15] tick: Remove useless oneshot ifdeffery
Date: Thu,  1 Feb 2024 00:11:08 +0100
Message-ID: <20240131231120.12006-4-frederic@kernel.org>
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

tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
the related ifdeferry in this file is needless and can be removed.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cc19c4ff5a25..e674269692ab 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -43,7 +43,6 @@ struct tick_sched *tick_get_tick_sched(int cpu)
 	return &per_cpu(tick_cpu_sched, cpu);
 }
 
-#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
 /*
  * The time when the last jiffy update happened. Write access must hold
  * jiffies_lock and jiffies_seq. tick_nohz_next_event() needs to get a
@@ -289,7 +288,6 @@ static enum hrtimer_restart tick_nohz_handler(struct hrtimer *timer)
 
 	return HRTIMER_RESTART;
 }
-#endif
 
 #ifdef CONFIG_NO_HZ_FULL
 cpumask_var_t tick_nohz_full_mask;
@@ -635,7 +633,7 @@ void __init tick_nohz_init(void)
 	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
 		cpumask_pr_args(tick_nohz_full_mask));
 }
-#endif
+#endif /* #ifdef CONFIG_NO_HZ_FULL */
 
 /*
  * NOHZ - aka dynamic tick functionality
@@ -1502,7 +1500,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
@@ -1567,7 +1564,6 @@ void tick_cancel_sched_timer(int cpu)
 	ts->idle_calls = idle_calls;
 	ts->idle_sleeps = idle_sleeps;
 }
-#endif /* CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Async notification about clocksource changes
-- 
2.43.0


