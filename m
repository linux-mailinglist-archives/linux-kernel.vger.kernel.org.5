Return-Path: <linux-kernel+bounces-47350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92095844CC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D411C24608
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF64C628;
	Wed, 31 Jan 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptQ5tTmA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0549D4BAB5
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742700; cv=none; b=lKnvnCbWc0o0wCqWBbMuCyyXokpkxQ7WK7ENvDMM7ysCFU21YWrugMqVHwADJzAuYg6B8xBnr75/CEff6ImpEDh/zvJllf3tAo3XBbTJ++sO2R4xHssR591MrbkvUy+JWnR9dTogT+eppSKjUlcXUhfgYek//rvilmrlsPCGXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742700; c=relaxed/simple;
	bh=TdBitky7dKeAUk4dshu31PUBwwuT3BbUa7Yr8mFUDQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwWnW7NP4xFmAGIOGHI5qYW6w30VLdtsfTriVEKHC3oT8aIW6vJAaD0Q1s+zroso2jq2wjBziWNY9OPxnNvj975g4nzZzp6JdCZuBaQ0mdlFzyJfUKI96GsUkQO3TUSj2iPpm5X1LHbwwXJ9eqezc7ToMZ1LDJAVT9MAyr80gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptQ5tTmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1864C433F1;
	Wed, 31 Jan 2024 23:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742699;
	bh=TdBitky7dKeAUk4dshu31PUBwwuT3BbUa7Yr8mFUDQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptQ5tTmA0NWl7GDKMTOl4pZGyfrqVtXGeGeZa1F2Qwp7vxZFNqSQJRi144tZoa59B
	 xPeSmj50BnbAyAFc0S4P3FzQw6JQqV+l/bH10lqVNSh6XBfeho36sk8Kj4vgT0lZey
	 n4joxNoePbGmdvnB8oP7NCysCkX523xulBEg6doDg+ZTHGxWKhui70ovZ45pXc+ndN
	 AeTqcYkHx0A9t+627Bdplw2QBTWuWSs+OWRhvLPEXuoN/ibv/vYatAJZiMdZlRCWp1
	 TSxfH3V+a79FWBsawBUBqhNt4K5yQmltxyam5ra0TTAkI8cmRbOaVGH+nIbT9W+VPM
	 ecKXuEynHMQzw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/15] tick: No need to clear ts->next_tick again
Date: Thu,  1 Feb 2024 00:11:11 +0100
Message-ID: <20240131231120.12006-7-frederic@kernel.org>
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

The tick sched structure is already cleared from
tick_cancel_sched_timer(), so there is no need to clear that field
again.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1fd7319b58b3..a07a04bb9d27 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1100,11 +1100,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(!cpu_online(cpu))) {
 		if (cpu == tick_do_timer_cpu)
 			tick_do_timer_cpu = TICK_DO_TIMER_NONE;
-		/*
-		 * Make sure the CPU doesn't get fooled by obsolete tick
-		 * deadline if it comes back online later.
-		 */
-		ts->next_tick = 0;
 		return false;
 	}
 
-- 
2.43.0


