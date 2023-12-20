Return-Path: <linux-kernel+bounces-7230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A1281A37A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6821F23309
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B920495D0;
	Wed, 20 Dec 2023 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCumy64a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZigY6SB8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A4481AE;
	Wed, 20 Dec 2023 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=232aJJhHA3GkLoMcpuCeUflrMMOWDdohu1QKRUm1Q2Q=;
	b=gCumy64aKzoiwepfogegHuAFT4Om1Xq1uYNygLY1GpZzDeQbLccOkCgR/3uivmrZpw3bEf
	lhHT4/rgQe9hku120gzt3xnI8FH7Hr1twVgZlWZ01YT/BWUrKAdDsxgbwM61I51h6Up4xW
	0bcJz9foyA6wku+89iM/QOggNyAtDHYMg8QpP3nFBHU7r648vh4H6IwGEmsxRFNj026og2
	6jW+niRvyNsUm2j/2TPSpVFcyu8G4ufEMCfFFRwxu3KZKBWKFVxLT5dvaQMiOGxng5kcPB
	fNeb2ozFNMgcOpXXhD0TZFz02a2hiDMNbcg8kG0Oul0lQiVRKaJKXvhD8pa2dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087949;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=232aJJhHA3GkLoMcpuCeUflrMMOWDdohu1QKRUm1Q2Q=;
	b=ZigY6SB8h0ztDUA6FpCo+GMMFDOfcubd/HW1ov5ZeoSDdb5gwJq8Ni3PAx+x4KEx/CxI9N
	7Qm+xNX1eGtElKCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Move store of next event into
 __next_timer_interrupt()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-8-anna-maria@linutronix.de>
References: <20231201092654.34614-8-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794894.398.9108657349388521150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b5e6f59888c7bde3c05f61b3ce06b78a86713fc0
Gitweb:        https://git.kernel.org/tip/b5e6f59888c7bde3c05f61b3ce06b78a86713fc0
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

timers: Move store of next event into __next_timer_interrupt()

Both call sites of __next_timer_interrupt() store the return value directly
in base->next_expiry. Move the store into __next_timer_interrupt() and to
make its purpose more clear, rename the function to next_expiry_recalc().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-8-anna-maria@linutronix.de

---
 kernel/time/timer.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 9188205..490ff8e 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1800,8 +1800,10 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
 /*
  * Search the first expiring timer in the various clock levels. Caller must
  * hold base->lock.
+ *
+ * Store next expiry time in base->next_expiry.
  */
-static unsigned long __next_timer_interrupt(struct timer_base *base)
+static void next_expiry_recalc(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
@@ -1867,10 +1869,9 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 		clk += adj;
 	}
 
+	base->next_expiry = next;
 	base->next_expiry_recalc = false;
 	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
-
-	return next;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1930,7 +1931,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	raw_spin_lock(&base->lock);
 	if (base->next_expiry_recalc)
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 	nextevt = base->next_expiry;
 
 	/*
@@ -2021,7 +2022,7 @@ static inline void __run_timers(struct timer_base *base)
 		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
 			     && base->timers_pending);
 		base->clk++;
-		base->next_expiry = __next_timer_interrupt(base);
+		next_expiry_recalc(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);

