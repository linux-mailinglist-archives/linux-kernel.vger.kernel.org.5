Return-Path: <linux-kernel+bounces-37147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F48F83AC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7463E1C2168E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BCE7C0AD;
	Wed, 24 Jan 2024 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFJNUYrS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C17B7E58D;
	Wed, 24 Jan 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106606; cv=none; b=ADSq112xPL8/jG+LJ6Wfq8RoPfgYsD0eHw7cOyklk4Cpf32yBm41M4sfPhJJFah0o5Al6qPThBvYeo3cJEOjzaQJZPIBvIEnfctOso+GOSTYgpP4/cY+UV0Ms1cEUd+AmN7+xnh4uF8gASE3NyC0kO5FrLmu/2fkZ0qjWwnuVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106606; c=relaxed/simple;
	bh=0HoOYdpY7mCqkF6yX9oqUlAHYhcdLh1Mqx9QVhuN/ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArtGZR9Ui2gbGcWMeNgWYhqVptBkbcVXll64DFrXZXs2I/F0Pogicfg6wdfbjoGYbNxhDGbjUHnAhT/0WRCMxzdDL4Wpbx6/otkO1ehm8z07IDtNPIswDV/5YAHKGvxp+i5AdKJiM4mcVVfu5Ld9ttDJOzJ/ucKDHgY2z/9wAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFJNUYrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F28C433C7;
	Wed, 24 Jan 2024 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106606;
	bh=0HoOYdpY7mCqkF6yX9oqUlAHYhcdLh1Mqx9QVhuN/ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FFJNUYrSj1wegRlgAOWYDrN7uTmK2S+WxH608PleK+wCOcz6JEg9GW/rUykxwlsfM
	 ayZ611A0lEuZhIm1wc0DPP6nnKKNvsw7uwheAofSyAcwotKDYckrUghdNkvxnuH57j
	 ZinrDxo+x/R53dII6QWcNpnkKBMWIyJcCkxErAvrYtGGodrEzb7k8Niu8hcBi2DS11
	 CEMzUCQ6TmJNke9YdQ7Cwl2Dlft5j3VfNHFvxYDNW6b0pvfu1NiGIf5nqwTHfIfOtS
	 a7sWtHbI4AyTbfqnJF9Og1L6ioVx2qZr5XLgRvVig3qqKrAP8EJqCADzjGIfkoFwkL
	 xHKGqO4mhLhXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 5/9] um: time-travel: fix time corruption
Date: Wed, 24 Jan 2024 09:29:35 -0500
Message-ID: <20240124142949.1283818-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124142949.1283818-1-sashal@kernel.org>
References: <20240124142949.1283818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit abe4eaa8618bb36c2b33e9cdde0499296a23448c ]

In 'basic' time-travel mode (without =inf-cpu or =ext), we
still get timer interrupts. These can happen at arbitrary
points in time, i.e. while in timer_read(), which pushes
time forward just a little bit. Then, if we happen to get
the interrupt after calculating the new time to push to,
but before actually finishing that, the interrupt will set
the time to a value that's incompatible with the forward,
and we'll crash because time goes backwards when we do the
forwarding.

Fix this by reading the time_travel_time, calculating the
adjustment, and doing the adjustment all with interrupts
disabled.

Reported-by: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/time.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index fddd1dec27e6..3e270da6b6f6 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -432,9 +432,29 @@ static void time_travel_update_time(unsigned long long next, bool idle)
 	time_travel_del_event(&ne);
 }
 
+static void time_travel_update_time_rel(unsigned long long offs)
+{
+	unsigned long flags;
+
+	/*
+	 * Disable interrupts before calculating the new time so
+	 * that a real timer interrupt (signal) can't happen at
+	 * a bad time e.g. after we read time_travel_time but
+	 * before we've completed updating the time.
+	 */
+	local_irq_save(flags);
+	time_travel_update_time(time_travel_time + offs, false);
+	local_irq_restore(flags);
+}
+
 void time_travel_ndelay(unsigned long nsec)
 {
-	time_travel_update_time(time_travel_time + nsec, false);
+	/*
+	 * Not strictly needed to use _rel() version since this is
+	 * only used in INFCPU/EXT modes, but it doesn't hurt and
+	 * is more readable too.
+	 */
+	time_travel_update_time_rel(nsec);
 }
 EXPORT_SYMBOL(time_travel_ndelay);
 
@@ -568,7 +588,11 @@ static void time_travel_set_start(void)
 #define time_travel_time 0
 #define time_travel_ext_waiting 0
 
-static inline void time_travel_update_time(unsigned long long ns, bool retearly)
+static inline void time_travel_update_time(unsigned long long ns, bool idle)
+{
+}
+
+static inline void time_travel_update_time_rel(unsigned long long offs)
 {
 }
 
@@ -720,9 +744,7 @@ static u64 timer_read(struct clocksource *cs)
 		 */
 		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
 		    !time_travel_ext_waiting)
-			time_travel_update_time(time_travel_time +
-						TIMER_MULTIPLIER,
-						false);
+			time_travel_update_time_rel(TIMER_MULTIPLIER);
 		return time_travel_time / TIMER_MULTIPLIER;
 	}
 
-- 
2.43.0


