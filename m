Return-Path: <linux-kernel+bounces-7231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9C81A37B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6CB2455C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C92495FD;
	Wed, 20 Dec 2023 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVPxWxRZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4c5PdOZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC7A48792;
	Wed, 20 Dec 2023 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFMhP5Pq/AnRa8JX1yrq4gn/rIWOr9VQX/CzZB6IeTg=;
	b=OVPxWxRZNxSffzI7CPL37jtS5VYHP8PsED1M8vlQl/rQmV4RqQYBMsdg2O5DE0XW01yfuJ
	xLOrBgvyW2p6UQzEjvR+0ykYFklCmMIJ1o6ykb12XLy3mClLOJMjTpGFvOHnkdiCNPZTSS
	c6TuVK2d4xbdC6SXlgW2l9ajJ0VxdAtfLl72h6H2D/zv4DKK69V+xmlkuOsZMt2Ho5hrDL
	48f5S5D9pBYaMCCgr2WQivNsvFfEqgOFPLthuQBQ6j9HLK2Aa/rS9rwvZ8PgnpHEpRxuZr
	YW5vXhNrEyy+kGLGDhzXyBT5iMT3xaHK1RQYJ/bc7832DsPMF7QMNo9pQ7jYIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087950;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eFMhP5Pq/AnRa8JX1yrq4gn/rIWOr9VQX/CzZB6IeTg=;
	b=r4c5PdOZnXUahouPM5yF6fNYvVWB1kKX3Ghm1H2XH+ygbbc9W/MMoxl9lnWIYYhzo2yxJF
	xUUzOrA2TWwhaiCA==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Do not IPI for deferrable timers
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-7-anna-maria@linutronix.de>
References: <20231201092654.34614-7-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794956.398.15756777803011185741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d124c3393e798b1fb142ee728d5c8976d11e722d
Gitweb:        https://git.kernel.org/tip/d124c3393e798b1fb142ee728d5c8976d11e722d
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

timers: Do not IPI for deferrable timers

Deferrable timers do not prevent CPU from going idle and are not taken into
account on idle path. Sending an IPI to a remote CPU when a new first
deferrable timer was enqueued will wake up the remote CPU but nothing will
be done regarding the deferrable timers.

Drop IPI completely when a new first deferrable timer was enqueued.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-7-anna-maria@linutronix.de

---
 kernel/time/timer.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ed8d606..9188205 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -571,18 +571,15 @@ static int calc_wheel_index(unsigned long expires, unsigned long clk,
 static void
 trigger_dyntick_cpu(struct timer_base *base, struct timer_list *timer)
 {
-	if (!is_timers_nohz_active())
-		return;
-
 	/*
-	 * TODO: This wants some optimizing similar to the code below, but we
-	 * will do that when we switch from push to pull for deferrable timers.
+	 * Deferrable timers do not prevent the CPU from entering dynticks and
+	 * are not taken into account on the idle/nohz_full path. An IPI when a
+	 * new deferrable timer is enqueued will wake up the remote CPU but
+	 * nothing will be done with the deferrable timer base. Therefore skip
+	 * the remote IPI for deferrable timers completely.
 	 */
-	if (timer->flags & TIMER_DEFERRABLE) {
-		if (tick_nohz_full_cpu(base->cpu))
-			wake_up_nohz_cpu(base->cpu);
+	if (!is_timers_nohz_active() || timer->flags & TIMER_DEFERRABLE)
 		return;
-	}
 
 	/*
 	 * We might have to IPI the remote CPU if the base is idle and the

