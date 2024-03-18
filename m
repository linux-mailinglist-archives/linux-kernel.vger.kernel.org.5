Return-Path: <linux-kernel+bounces-106791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECD387F3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B88B2122D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2845CDEB;
	Mon, 18 Mar 2024 23:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UStO95yQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F55CDD2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 23:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710803263; cv=none; b=WkD7fq7GF4FcELvu2FVF7koEUIy2kjSE/cerutWb3FomsuRLaUXXd7P/5zKM90wG9IOFjMMoHv8oTEsIMeWrnXQ7IDBbBqXdk5+S5K8zffMZAflVaNNI0N6vwI7YFMbaKOCZOh2SocGE1cJ6Y4HHIMNfigbu3m73nVhGC38E82o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710803263; c=relaxed/simple;
	bh=UlqDvrWu4RSFciz62KAMjWvFnMF0iPska1bZHtuPE10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESpDYitjnCRp0RD5RhY8b1iF55RHJEemBy9OVz46eCMq4EkYXs3rEVt+34ISvtwvbdU6Tw/dvx0qZnL+Bvfi5lF9uR9hzldSUrgRJ3r9MHO0z4iOM4p1sy5x8NVDwe2z4g7ufjl4ejQPapAV47BORyoIKuWIDF6qM3d17Lg/A2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UStO95yQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD4FC433C7;
	Mon, 18 Mar 2024 23:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710803263;
	bh=UlqDvrWu4RSFciz62KAMjWvFnMF0iPska1bZHtuPE10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UStO95yQxncL8EQxEj7jQjHfGnqXUvWj55VuGwalJc+F0rneHurLlSBTCvD66afYi
	 v8r/8mHh7OeeoTHx676FxJGR+B5H5u1GhlvaW5IH5WDSUcCXeWwZf218jWBpbaHLcF
	 Czb1/2QPLbGr8dbjNAXt63d2FMWIjewO9PeBHQLn+uDflcK4hMubaiGOUSI3oWB0Br
	 0cu7DhlFlm3ZIl6rpOcJ3OU5Y3qwpYo4qu7yUJCh8iURaB1Bxt83bz72vHxeu0ZP46
	 FOABFoRdoTxeAjge/Tqkd9Czl3GnYeMjcvQen5j5DwQTGiOPVGkN1q+xol24T6M3KT
	 f+LBjyQtMXokg==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in nohz_full
Date: Tue, 19 Mar 2024 00:07:29 +0100
Message-ID: <20240318230729.15497-3-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318230729.15497-1-frederic@kernel.org>
References: <20240318230729.15497-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While running in nohz_full mode, a task may enqueue a timer while the
tick is stopped. However the only places where the timer wheel,
alongside the timer migration machinery's decision, may reprogram the
next event accordingly with that new timer's expiry are the idle loop or
any IRQ tail.

However neither the idle task nor an interrupt may run on the CPU if it
resumes busy work in userspace for a long while in full dynticks mode.

To solve this, the timer enqueue path raises a self-IPI that will
re-evaluate the timer wheel on its IRQ tail. This asynchronous solution
avoids potential locking inversion.

This is supposed to happen both for local and global timers but commit:

	b2cf7507e186 ("timers: Always queue timers on the local CPU")

broke the global timers case with removing the ->is_idle field handling
for the global base. As a result, global timers enqueue may go unnoticed
in nohz_full.

Fix this with restoring the idle tracking of the global timer's base,
allowing self-IPIs again on enqueue time.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Fixes: b2cf7507e186 ("timers: Always queue timers on the local CPU")
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index e69e75d3858c..dee29f1f5b75 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -642,7 +642,8 @@ trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 	 * the base lock:
 	 */
 	if (base->is_idle) {
-		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED));
+		WARN_ON_ONCE(!(timer->flags & TIMER_PINNED ||
+			       tick_nohz_full_cpu(base->cpu)));
 		wake_up_nohz_cpu(base->cpu);
 	}
 }
@@ -2292,6 +2293,13 @@ static inline u64 __get_next_timer_interrupt(unsigned long basej, u64 basem,
 		 */
 		if (!base_local->is_idle && time_after(nextevt, basej + 1)) {
 			base_local->is_idle = true;
+			/*
+			 * Global timers queued locally while running in a task
+			 * in nohz_full mode need a self-IPI to kick reprogramming
+			 * in IRQ tail.
+			 */
+			if (tick_nohz_full_cpu(base_local->cpu))
+				base_global->is_idle = true;
 			trace_timer_base_idle(true, base_local->cpu);
 		}
 		*idle = base_local->is_idle;
@@ -2364,6 +2372,8 @@ void timer_clear_idle(void)
 	 * path. Required for BASE_LOCAL only.
 	 */
 	__this_cpu_write(timer_bases[BASE_LOCAL].is_idle, false);
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__this_cpu_write(timer_bases[BASE_GLOBAL].is_idle, false);
 	trace_timer_base_idle(false, smp_processor_id());
 
 	/* Activate without holding the timer_base->lock */
-- 
2.44.0


