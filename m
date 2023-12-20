Return-Path: <linux-kernel+bounces-7227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E79E81A373
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B71A281B52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E4547A7B;
	Wed, 20 Dec 2023 15:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ki3n8obl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsh87/vq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045204778A;
	Wed, 20 Dec 2023 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 15:59:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703087947;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7xjpCVJjkT15ERbs8ASkY/KG3iwQ75AwhuRfp2uHko=;
	b=Ki3n8oblgJjMWq+zAyVMwqvcXriNkJzTfAKUgwe6ccE83xm5ReHVhyeOEfuEk3Vrd7W2wP
	mg/ZkyFXVnuFwGI6dvShdnafOUT6z33Kl9rzpr2h1Jb2llwcek5g9jEirhNcuSjKgYZxQp
	ncY5pX0TK/ECOZ61YQ7/PaJAycVGGcf3cJUwrHLzPkTbd9q9Kybbnj60uhaYKHh6CnDnoE
	7tnrFSfpQRu0pnWb8CYl2D7Aor4kDxZbCs0DtReBI0KC4tYzLQFrfb39rTQZsrokEEh+wn
	q2iL2GZ5zMnpuorQnAycYGh1ogeEa3dVJFtJDTj8TLnquPJo2SfkrxcXqiqSAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703087947;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o7xjpCVJjkT15ERbs8ASkY/KG3iwQ75AwhuRfp2uHko=;
	b=gsh87/vq/OVT8aC5TCUnqvwg4zvoPZYrNGRy82HXSvwJB0M2uIAdA1tg63JpOyqXTH3FdP
	UDjzAkHNphYIFpAQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers: Use already existing function for
 forwarding timer base
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231201092654.34614-11-anna-maria@linutronix.de>
References: <20231201092654.34614-11-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170308794650.398.12509210482975186136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7a39a5080ef0e3cf233d92165f6a778f08a08244
Gitweb:        https://git.kernel.org/tip/7a39a5080ef0e3cf233d92165f6a778f08a08244
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 01 Dec 2023 10:26:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 20 Dec 2023 16:49:38 +01:00

timers: Use already existing function for forwarding timer base

There is an already existing function for forwarding the timer
base. Forwarding the timer base is implemented directly in
get_next_timer_interrupt() as well.

Remove the code duplication and invoke __forward_timer_base() instead.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20231201092654.34614-11-anna-maria@linutronix.de

---
 kernel/time/timer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 5b02e16..1a73d39 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1939,15 +1939,9 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
-	 * base. We can only do that when @basej is past base->clk
-	 * otherwise we might rewind base->clk.
+	 * base.
 	 */
-	if (time_after(basej, base->clk)) {
-		if (time_after(nextevt, basej))
-			base->clk = basej;
-		else if (time_after(nextevt, base->clk))
-			base->clk = nextevt;
-	}
+	__forward_timer_base(base, basej);
 
 	if (time_before_eq(nextevt, basej)) {
 		expires = basem;

