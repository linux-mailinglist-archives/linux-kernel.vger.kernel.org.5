Return-Path: <linux-kernel+bounces-7228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EE781A375
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488DB1C249BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E635A48790;
	Wed, 20 Dec 2023 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzaC5rhE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRrJ6v6p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75B94779B;
	Wed, 20 Dec 2023 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WyGjXO4HU/DxT+MT2cyvv4Bxj8SSc0VCc0LZoXF0s88=;
	b=hzaC5rhELNs0UNOl/M0wtaQVLKYqyX/bk9ZFQmuEbhSpDEWR2OhTTILVClwA7UXLh+FC/Z
	a0zVY+M4+jQaxFNb61rwpKT6qb+GDzLaheISgR5UWOe5tOwCh9yKEhpIEgKmWdQNCph8ni
	89ee6sD0kWsZbyskj2hrITB1DjW0pQEtQ2xXAQaLIk37douXS3BFfXB1Fz3nF+H7wrbmDA
	FcpaBvpqS5e4VHUqbGe9Hni7hFL3qYZ+mLGc53/7tQqpaA79gtj/WbXmLxYY48TvyHu3YL
	pJgsf9rmSvuEundyzeqX+MU9p6oAGzuNSSElTV2ZuMf/jTb58ETX+DRsrOV5Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087948;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WyGjXO4HU/DxT+MT2cyvv4Bxj8SSc0VCc0LZoXF0s88=;
	b=PRrJ6v6phLFjvPIy6bXt3GSgMv6PD7zEk/E/C5OVW5MXmffxHKd70P6aC07wQGo9pZ8ppX
	NduyoQy45cLPFpDg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Split out forward timer base functionality
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-10-anna-maria@linutronix.de>
References: <20231201092654.34614-10-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794724.398.14686394808339432944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1e490484aa3af42d4eeffabf96d6a02be69d586b
Gitweb:        https://git.kernel.org/tip/1e490484aa3af42d4eeffabf96d6a02be69d586b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

timers: Split out forward timer base functionality

Forwarding timer base is done when the next expiry value is calculated and
when a new timer is enqueued. When the next expiry value is calculated the
jiffies value is already available and does not need to be reread a second
time.

Splitting out the forward timer base functionality to make it executable
via both contextes - those where jiffies are already known and those, where
jiffies need to be read.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-10-anna-maria@linutronix.de

---
 kernel/time/timer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f75f932..5b02e16 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -939,30 +939,34 @@ get_target_base(struct timer_base *base, unsigned tflags)
 	return get_timer_this_cpu_base(tflags);
 }
 
-static inline void forward_timer_base(struct timer_base *base)
+static inline void __forward_timer_base(struct timer_base *base,
+					unsigned long basej)
 {
-	unsigned long jnow = READ_ONCE(jiffies);
-
 	/*
 	 * Check whether we can forward the base. We can only do that when
 	 * @basej is past base->clk otherwise we might rewind base->clk.
 	 */
-	if (time_before_eq(jnow, base->clk))
+	if (time_before_eq(basej, base->clk))
 		return;
 
 	/*
 	 * If the next expiry value is > jiffies, then we fast forward to
 	 * jiffies otherwise we forward to the next expiry value.
 	 */
-	if (time_after(base->next_expiry, jnow)) {
-		base->clk = jnow;
+	if (time_after(base->next_expiry, basej)) {
+		base->clk = basej;
 	} else {
 		if (WARN_ON_ONCE(time_before(base->next_expiry, base->clk)))
 			return;
 		base->clk = base->next_expiry;
 	}
+
 }
 
+static inline void forward_timer_base(struct timer_base *base)
+{
+	__forward_timer_base(base, READ_ONCE(jiffies));
+}
 
 /*
  * We are using hashed locking: Holding per_cpu(timer_bases[x]).lock means

