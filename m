Return-Path: <linux-kernel+bounces-971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416B8148B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197A7B2343B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526F62D61E;
	Fri, 15 Dec 2023 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rlNUTVj1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCbWa5Az"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4B22DB7C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702645511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U2tDiKHKYr5BFBF9MXdN4euPv07ro9CC99NNHl3ihkg=;
	b=rlNUTVj11k9F9xc53az5oRZhTvMk3vR94kDWFOfa7PKvXnflbuwCP1YKdtZGHxLpdRhcgg
	fDm25g5wa4AfJJLPZK2dxPjsW2nBasLq4ivhyW54mNkGHLlGMcy46RAmGtr+8CtBkltUFP
	a00rKENsxQjPdgL8Wuhu8eWz9LhHREfhMsEashAZZ9/I0vIvFrbEle23ziddTULY32XYKT
	NURUrmnfZ/rMFgoT3TeGgb/Uoe4G7quDjS6FlR8LZFqtesbqjcADn2ZmTYx43LJZgjByGc
	MUOIjFrFOXGNCvrdwoTMJpXW9qa+k85M5Ox2A7EhML7EYrK0JtetLNekGnRN6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702645511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U2tDiKHKYr5BFBF9MXdN4euPv07ro9CC99NNHl3ihkg=;
	b=aCbWa5AznxUTz9+fLqfPxDsN2XeRkh9QsBGsRJ837u6cYvKn96zQhQAwbLWBVxvV1EGE+i
	+rFPQBp4IS/u5cCw==
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched/idle: Prevent stopping the tick when there is no cpuidle driver
Date: Fri, 15 Dec 2023 14:05:01 +0100
Message-Id: <20231215130501.24542-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When there is no cpuidle driver, the system tries to stop the tick even if
the system is fully loaded. But stopping the tick is not for free and it
decreases performance on a fully loaded system. As there is no (cpuidle)
framework which brings CPU in a power saving state when nothing needs to be
done, there is also no power saving benefit when stopping the tick.

Therefore do not stop the tick when there is no cpuidle driver.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/sched/idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 565f8374ddbb..fd111686aaf3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -165,8 +165,6 @@ static void cpuidle_idle_call(void)
 	 */
 
 	if (cpuidle_not_available(drv, dev)) {
-		tick_nohz_idle_stop_tick();
-
 		default_idle_call();
 		goto exit_idle;
 	}
-- 
2.39.2


