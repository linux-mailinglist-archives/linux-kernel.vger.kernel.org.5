Return-Path: <linux-kernel+bounces-126327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DA389353B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 473551F22F66
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86C145FE0;
	Sun, 31 Mar 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xv1n936/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85135757FB
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906016; cv=none; b=ggJZPXhsScr/0YjkdcwU692SVuwYCeMfrj+ih8zcqCayPHErErOtQ0ncFvkbQ1fQ3dt2L2QUrAP3pzrNYWMvO0QZiBaDNJl9uU17vgK4dp7xG/ORz/Oq4qW+rh5/vVlqYlgoYgIqAhToB46KBZuSyDbDaiI/MIwKNtckbiAgHOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906016; c=relaxed/simple;
	bh=RbzpRVssJBeX2HuBxX3nGF4i51Ut+SCdZJ/kUlWCglo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkDzh2VVncQ5zUmOgN56oeuhEHte8yWjp0VcWtPHTNNu/AR0n36fPyc6bL1k7tZHmKY9rO9gJwLYggJWcalSSzvzTxeguNqSHelJr71QsXncgeDNj68SV9mEK7Co+dNsorH9hV5rjq+59FuHu/Q9a12ejvr+Bjy0Tl1AWr/1u28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xv1n936/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Y6/W+x74asZFeG9k6inSTFn3aKxgMtlMzVYkORw/6C4=; b=xv1n936/+0fKngf0Oh+Dl3GPWQ
	o8lwMxreW68eI6s7KHguX+ZokK+x94Ey5+WQZ/Yk3927qTV6n/CrF4+jBeCoTvj1cYuaRlbxsZ900
	eoelsevhCB+pKiNsEnS4HyH20VMy/rV8T0YVOJBE0y7VRDq7BsT1ce26Lqb0j2ILx0r5Rlr1e9Y4h
	MYlQFCwKH+eqML4xQWRX3k6ja2d2/T18HW3qai5kQZLl9NYkGJ8F1fEKXcvCSLQ1xZb2mNu0DI5x/
	H09Ynnv7MCsH0uZ7cduz8JEDqG6dwQ4fTattFCghhffMAhKX5OoB+G0gecoIoKvMZ+6HrIeEoBUWz
	U9aG3XQQ==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxL-00000005z30-04qI;
	Sun, 31 Mar 2024 17:26:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/6] time/timer: fix kernel-doc format and add Return values
Date: Sun, 31 Mar 2024 10:26:49 -0700
Message-ID: <20240331172652.14086-4-rdunlap@infradead.org>
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

Fix kernel-doc format and warnings:

timer.h:26: warning: Cannot understand  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
 on line 26 - I thought it was a doc line
timer.h:146: warning: No description found for return value of 'timer_pending'
timer.h:180: warning: No description found for return value of 'del_timer_sync'
timer.h:193: warning: No description found for return value of 'del_timer'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

 include/linux/timer.h |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -- a/include/linux/timer.h b/include/linux/timer.h
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -22,7 +22,7 @@
 #define __TIMER_LOCKDEP_MAP_INITIALIZER(_kn)
 #endif
 
-/**
+/*
  * @TIMER_DEFERRABLE: A deferrable timer will work normally when the
  * system is busy, but will not cause a CPU to come out of idle just
  * to service it; instead, the timer will be serviced when the CPU
@@ -140,7 +140,7 @@ static inline void destroy_timer_on_stac
  * or not. Callers must ensure serialization wrt. other operations done
  * to this timer, eg. interrupt contexts, or other CPUs on SMP.
  *
- * return value: 1 if the timer is pending, 0 if not.
+ * Returns: 1 if the timer is pending, 0 if not.
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
@@ -175,6 +175,10 @@ extern int timer_shutdown(struct timer_l
  * See timer_delete_sync() for detailed explanation.
  *
  * Do not use in new code. Use timer_delete_sync() instead.
+ *
+ * Returns:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
 static inline int del_timer_sync(struct timer_list *timer)
 {
@@ -188,6 +192,10 @@ static inline int del_timer_sync(struct
  * See timer_delete() for detailed explanation.
  *
  * Do not use in new code. Use timer_delete() instead.
+ *
+ * Returns:
+ * * %0	- The timer was not pending
+ * * %1	- The timer was pending and deactivated
  */
 static inline int del_timer(struct timer_list *timer)
 {

