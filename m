Return-Path: <linux-kernel+bounces-80333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61124862D7B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137E51F22A58
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF061F94B;
	Sun, 25 Feb 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDxXy8zs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ADC1F608
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901727; cv=none; b=VyfMoNwM05CLJRd/qE4Z1nTUM3RIaTtENO8I/Q3izXRthztrzbLkwvynad7iTV99RNmQJtACxHgdOzsU9ZB9YviuNAH5L7rAhSyBbfgp6WLY94oIsMI5bDq3M3ihum1SeCazJT+4aL6gzFS26qRuO87wy5s5phRIY1sBXBmXiWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901727; c=relaxed/simple;
	bh=elCK0+UoX/y8indul9dlqt/x3/BB/vOLFTEHdirzUYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owVZCcIXh4uUoX/AVS9qizvkH0wesUzxPc0VtChgKFLUUK+9nhFcU2ivmT4iZv0bsv/Ab+MPuw5e/rg5zP9eHtb2HP+H6Lmc1zIxRS5m1xQshl47WIsRvC1mq/gYv4QpHYfIT8K38nbDS5AmQu3WsDuRKgmNl3sg023e+oHRb5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDxXy8zs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B06C433C7;
	Sun, 25 Feb 2024 22:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901726;
	bh=elCK0+UoX/y8indul9dlqt/x3/BB/vOLFTEHdirzUYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oDxXy8zs+PD/0lFXaeh+O7GkIW/2o2BmLXGid5juParGagr6D/1nuC1RpV/4D/KRV
	 Jv7qk9e13MvoUXQUvt4gnxtdZx0xh2/gt59C+ZxP71ylsVMpSTThjcIT/jTic64+jO
	 S21gfq2BPBG1Yj3HWuHVKqM8rGgZZ32yssOa9BfVRDrQrytFI9oXNIfsno5DHxceUD
	 sVv6Sp9TWvIctBEeZMuaZXpDn4INZE0tDFVuK023M43zPseubxNB6w3uwWk4LjmUaT
	 HxNa9xd+WRRmJDx263Ie4UN4ajiGbplFKA3GTzyqsLlXmzKpK5JA+QQ1Okb2aBJOtO
	 JXEMQmz38YtFg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 06/16] tick: No need to clear ts->next_tick again
Date: Sun, 25 Feb 2024 23:54:58 +0100
Message-ID: <20240225225508.11587-7-frederic@kernel.org>
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

The tick sched structure is already cleared from
tick_cancel_sched_timer(), so there is no need to clear that field
again.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9f75f5621965..b17895de26b9 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1143,11 +1143,6 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
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


