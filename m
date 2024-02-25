Return-Path: <linux-kernel+bounces-80330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A021862D78
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EF8281FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C301BC23;
	Sun, 25 Feb 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCDSSL8H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9A1C6A1
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901721; cv=none; b=YvjkluOdOV8ozjyKobbStZtlg6/hw5jbkEPIg9x9dmOru6f/yU8Li6A+Hr5pqXdzFx8d9c4QP2sY6B3YPHKwDZRHKh1bM+X50jcpDDPQGi/dTnM27+KDB5HFrB9fXB8XP1YiWHc6G1ReDkDOxqKGVTNG/yKZCnmGIBa4bUPp+Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901721; c=relaxed/simple;
	bh=IqLfgv0CY7qkTUyv21aAmqS1ETFIUjP/QLPaIXsEnIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Klc2vouo29CNsSOrSB6HhBEK9u6wZPgxy6b6zmf6kLkw/QykVkLPjBsaDb2iJIxE6NyYML1OMrg7NJ9tBcI07/B5/4VgaEd2FCO8iS6eDBkTGvsslNzwWEfz3K/9ccq9w52jvcjs+imW05I5wpFrvV7k+dYfDSWRNmi3vj02RtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCDSSL8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C70C433C7;
	Sun, 25 Feb 2024 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901720;
	bh=IqLfgv0CY7qkTUyv21aAmqS1ETFIUjP/QLPaIXsEnIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rCDSSL8HBySNRgVYrhvPX4oxo3P4sPwhiqjEW45X11zBnm+q17QNkPMPZc5Rkz9lO
	 VM/0rZ8DjQeeWWKftNpl2Y5H3ZAA7OmasnfeKtvVcnifnodP3zWAhY3kq424is3Dt+
	 sXsHRXsjctSNIqLrr3vgfg0x2UafV3412HgMW30EieC6EfjNOs15mp28dEjTSxXl12
	 yPRouNzq89x5vIc2AlH3SeCS+DHgFuPsEXtgHxEoPnsLginZd9LpaPhreuubkyULbF
	 FnUvxM3SoxQtkw8AtbjN/5LLLvK8FVew7XHwA6wbruExJm8TajJGJxqXTJ6okKkXFH
	 iw3VAyoR49JqQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 03/16] tick: Remove useless oneshot ifdeffery
Date: Sun, 25 Feb 2024 23:54:55 +0100
Message-ID: <20240225225508.11587-4-frederic@kernel.org>
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

tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
the related ifdeferry in this file is needless and can be removed.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 88c992f48126..27aaecb2e50c 100644
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
@@ -1540,7 +1538,6 @@ void tick_irq_enter(void)
 	tick_nohz_irq_enter();
 }
 
-#if defined CONFIG_NO_HZ_COMMON || defined CONFIG_HIGH_RES_TIMERS
 static int sched_skew_tick;
 
 static int __init skew_tick(char *str)
@@ -1605,7 +1602,6 @@ void tick_cancel_sched_timer(int cpu)
 	ts->idle_calls = idle_calls;
 	ts->idle_sleeps = idle_sleeps;
 }
-#endif /* CONFIG_NO_HZ_COMMON || CONFIG_HIGH_RES_TIMERS */
 
 /*
  * Async notification about clocksource changes
-- 
2.43.0


