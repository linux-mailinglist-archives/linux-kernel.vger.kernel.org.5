Return-Path: <linux-kernel+bounces-126330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175789353D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1F91F22B82
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E791474C2;
	Sun, 31 Mar 2024 17:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xwFZQQGO"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5129145356
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906018; cv=none; b=in9EmLpC+g9/eFagyC3lPNcIu5942yoHV2c3l0majnRQNLE4c33yCVHpqDFAcVRmFyXYs4ufmZ9zJESBSH8xQsl6kKB0JZpo8NXCTedYHBIPFOzbj0sGz7j83eObjThRWfSSEVXwo0Q+MV6ELcHMdzwPBuvq59KfhuiRxZflOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906018; c=relaxed/simple;
	bh=67lOWMZ6BwW89wBJNwjyk+x7EvS3cNwshmjRuUkh9Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6WGLxqTLzmu8x5LKM2cv01uK6I3ohUi3sm4QFYa5j74o6oizZa80GzDNfiq4de/gxJJGi7QyB6sU5rSIXbABr9RSaOPlcDPnAwdEV8OH1sLuY+5+0ijsrOBA58bV4Samk997W7beFVRlsyUEztueTxGW7TcpdV8058C9txUAAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xwFZQQGO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JuXH0teYwDflxG0HG7HxVUegvI27jzlo2icmDVUsmWE=; b=xwFZQQGOHtoB8tURrJNetvjwQ0
	CFVzhgObPRvJkxh0DxSucoLT2XhHNhCzRzM0sMkGPKT4en+oSG3t8qw0NC4orGe+xe7rp0OaAgvoP
	kcmDleiAl5zyGbhyJJ5bTzYrHeYkAHjJqCCfMjzutMVRSMKbHEzG4xBeoYqZ2bllkdLT/I2tQc/Gx
	3bks9ZVM19umQRtcOXkd8Mx59FunNSiHHhwLPDzEtKqWLskIMINvFkwiL/qPus9Q8uQXHDNzGxiHk
	IuukuT6LlTjOChgYe7GE5i8KNYAGY1TBaK82qb2mm7A34nF967kMFY4ADbNYdxcXSnkFqpLSUeHF6
	lE9XyDcw==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxM-00000005z30-0KPr;
	Sun, 31 Mar 2024 17:26:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/6] timers: fix text inconsistencies and spelling
Date: Sun, 31 Mar 2024 10:26:52 -0700
Message-ID: <20240331172652.14086-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331172652.14086-1-rdunlap@infradead.org>
References: <20240331172652.14086-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix some text for consistency: s/lvl/level/ in a comment and use
correct/full function names in comments.

Correct spelling errors as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

 kernel/time/timer.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff -- a/kernel/time/timer.c b/kernel/time/timer.c
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -64,15 +64,15 @@ EXPORT_SYMBOL(jiffies_64);
 
 /*
  * The timer wheel has LVL_DEPTH array levels. Each level provides an array of
- * LVL_SIZE buckets. Each level is driven by its own clock and therefor each
+ * LVL_SIZE buckets. Each level is driven by its own clock and therefore each
  * level has a different granularity.
  *
- * The level granularity is:		LVL_CLK_DIV ^ lvl
+ * The level granularity is:		LVL_CLK_DIV ^ level
  * The level clock frequency is:	HZ / (LVL_CLK_DIV ^ level)
  *
  * The array level of a newly armed timer depends on the relative expiry
  * time. The farther the expiry time is away the higher the array level and
- * therefor the granularity becomes.
+ * therefore the granularity becomes.
  *
  * Contrary to the original timer wheel implementation, which aims for 'exact'
  * expiry of the timers, this implementation removes the need for recascading
@@ -207,7 +207,7 @@ EXPORT_SYMBOL(jiffies_64);
  * struct timer_base - Per CPU timer base (number of base depends on config)
  * @lock:		Lock protecting the timer_base
  * @running_timer:	When expiring timers, the lock is dropped. To make
- *			sure not to race agains deleting/modifying a
+ *			sure not to race against deleting/modifying a
  *			currently running timer, the pointer is set to the
  *			timer, which expires at the moment. If no timer is
  *			running, the pointer is NULL.
@@ -737,7 +737,7 @@ static bool timer_is_static_object(void
 }
 
 /*
- * fixup_init is called when:
+ * timer_fixup_init is called when:
  * - an active object is initialized
  */
 static bool timer_fixup_init(void *addr, enum debug_obj_state state)
@@ -761,7 +761,7 @@ static void stub_timer(struct timer_list
 }
 
 /*
- * fixup_activate is called when:
+ * timer_fixup_activate is called when:
  * - an active object is activated
  * - an unknown non-static object is activated
  */
@@ -783,7 +783,7 @@ static bool timer_fixup_activate(void *a
 }
 
 /*
- * fixup_free is called when:
+ * timer_fixup_free is called when:
  * - an active object is freed
  */
 static bool timer_fixup_free(void *addr, enum debug_obj_state state)
@@ -801,7 +801,7 @@ static bool timer_fixup_free(void *addr,
 }
 
 /*
- * fixup_assert_init is called when:
+ * timer_fixup_assert_init is called when:
  * - an untracked/uninit-ed object is found
  */
 static bool timer_fixup_assert_init(void *addr, enum debug_obj_state state)
@@ -914,7 +914,7 @@ static void do_init_timer(struct timer_l
  * @key: lockdep class key of the fake lock used for tracking timer
  *       sync lock dependencies
  *
- * init_timer_key() must be done to a timer prior calling *any* of the
+ * init_timer_key() must be done to a timer prior to calling *any* of the
  * other timer functions.
  */
 void init_timer_key(struct timer_list *timer,
@@ -1417,7 +1417,7 @@ static int __timer_delete(struct timer_l
 	 * If @shutdown is set then the lock has to be taken whether the
 	 * timer is pending or not to protect against a concurrent rearm
 	 * which might hit between the lockless pending check and the lock
-	 * aquisition. By taking the lock it is ensured that such a newly
+	 * acquisition. By taking the lock it is ensured that such a newly
 	 * enqueued timer is dequeued and cannot end up with
 	 * timer->function == NULL in the expiry code.
 	 *
@@ -2306,7 +2306,7 @@ static inline u64 __get_next_timer_inter
 
 		/*
 		 * When timer base is not set idle, undo the effect of
-		 * tmigr_cpu_deactivate() to prevent inconsitent states - active
+		 * tmigr_cpu_deactivate() to prevent inconsistent states - active
 		 * timer base but inactive timer migration hierarchy.
 		 *
 		 * When timer base was already marked idle, nothing will be

