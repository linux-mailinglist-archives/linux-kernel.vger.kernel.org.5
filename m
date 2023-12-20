Return-Path: <linux-kernel+bounces-7225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9988481A370
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5871F262BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307D4779C;
	Wed, 20 Dec 2023 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bkAfuWde";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hoRBxrVf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EBD47771;
	Wed, 20 Dec 2023 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087945;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP3aAkdQoWZVpNzAO+LKKTgDZR1ZVplKuZ3SA3WwaZo=;
	b=bkAfuWde2N5yyQWYJg/wuoHTAPyOyAz2x5tWJzLpqUfhmERmYvvxV617PNanmjszHLfoue
	ZUwOuIfb4ZdLHLi1igfil8tze6Yhw5pwYb1f31MWVYezAp6iA/tkhXyyBawE59hWwCYApV
	l5JT0XVUjUvRK/lVovrO1xbeGATQrIMHfET/gQunRffUvYLwU+PyLRi/ARo1ZYzb3GWqgS
	lYsQTezGjDXJ6rkBKzCFktXwkkFmENbCGvNXSD+KBpsJomKqOGHr6utNQokVemCOjhfs0l
	k9P3z9Cpz4+payiKs6D+a9ODURI6UsY8sE5sgh+JXH+BrZcNSacLQ1Ato14nKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087945;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jP3aAkdQoWZVpNzAO+LKKTgDZR1ZVplKuZ3SA3WwaZo=;
	b=hoRBxrVfuMNPWo9bY6kKteNO97p85VVsGxGa+KAGY7FL9eSsfrW/MbrS07n2xZv3m4KMqF
	h8Hgqd0WUWhcAnAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers: Fix nextevt calculation when no timers are pending
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-13-anna-maria@linutronix.de>
References: <20231201092654.34614-13-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794496.398.15842990234534147833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5
Gitweb:        https://git.kernel.org/tip/da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:39 +01:00

timers: Fix nextevt calculation when no timers are pending

When no timer is queued into an empty timer base, the next_expiry will not
be updated. It was originally calculated as

  base->clk + NEXT_TIMER_MAX_DELTA

When the timer base stays empty long enough (> NEXT_TIMER_MAX_DELTA), the
next_expiry value of the empty base suggests that there is a timer pending
soon. This might be more a kind of a theoretical problem, but the fix
doesn't hurt.

Use only base->next_expiry value as nextevt when timers are
pending. Otherwise nextevt will be jiffies + NEXT_TIMER_MAX_DELTA. As all
information is in place, update base->next_expiry value of the empty timer
base as well.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-13-anna-maria@linutronix.de

---
 kernel/time/timer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index cf51655..352b161 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1922,8 +1922,8 @@ static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 {
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
+	unsigned long nextevt = basej + NEXT_TIMER_MAX_DELTA;
 	u64 expires = KTIME_MAX;
-	unsigned long nextevt;
 	bool was_idle;
 
 	/*
@@ -1936,7 +1936,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
 		next_expiry_recalc(base);
-	nextevt = base->next_expiry;
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1945,10 +1944,20 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	__forward_timer_base(base, basej);
 
 	if (base->timers_pending) {
+		nextevt = base->next_expiry;
+
 		/* If we missed a tick already, force 0 delta */
 		if (time_before(nextevt, basej))
 			nextevt = basej;
 		expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
+	} else {
+		/*
+		 * Move next_expiry for the empty base into the future to
+		 * prevent a unnecessary raise of the timer softirq when the
+		 * next_expiry value will be reached even if there is no timer
+		 * pending.
+		 */
+		base->next_expiry = nextevt;
 	}
 
 	/*

