Return-Path: <linux-kernel+bounces-126325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C55893539
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833A31F22D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEAC145B11;
	Sun, 31 Mar 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTzN58Mt"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5231E885
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906016; cv=none; b=c+pjW/uEwSVpckcrqXbLatJU8VGo0vy5rgMtnkaM0lnpCZVG3Yr3+q1jBEVhkbo9bAHwMfXSp1bmEbehCD+t1D+ESy36qY5qXCJEX9r61HthghsA6T3KK2nylNp5vEZ/Xy0UOzeHg1LPd6P2vQfDxy+VVRiKnFTjoG9k9UjjRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906016; c=relaxed/simple;
	bh=DQfFiNWnRFztcAQ8PTYun0dPg3o2/K7nXQiHHNAvFyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n71LnndhRsqE3iEbdqFYsrXpbXfmXLJhm1iNeWl9AzcACeflYGez5i4HnARgwJiGom3GixukkgLvmWl991ybttO0NqiebMSSEkjOhRbds1AP8c6lv46GUyTWzIf00FVv76Y1u/+fO+23cZ0vS+zV2pihYyYJUNeqdc3y/3hBOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VTzN58Mt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=o+6KSe5ULx4/8cOqptk5++I+NpOHNpJW+TZ2As6cizY=; b=VTzN58Mt4iqUcLGsV3B08zPFfF
	tyCaiWCTmNqUuE2Mnftd+BjWzG3zRpkTquo40Qbmhw1v8wLMBLXnk54n2cbHMZ3dwtm+uQ6H7uIgO
	65dKg2K5eguZBhR9MnVHXp+Y2GuhfxVi4/bkqGP3igaZTBqibgbWON9JxN+r0XRkbBlVlxBeRRvnz
	OQBCe8LixIkKrWz/fJyAktQwflxNddczhdK5yY7Mhgxa6Qs6HNhAG4bZ2s+1ekeh7ZMpE4WeyqkHj
	6f5zPWhrY1mp+L4IzQnrZLfWM6EoaoWottX0zQxkgUxURJr2PuTf01zauajt3DaGbeP1zXXqijmAE
	PJSFHxeQ==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxK-00000005z30-130U;
	Sun, 31 Mar 2024 17:26:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/6] time/timecounter: fix inline documentation
Date: Sun, 31 Mar 2024 10:26:47 -0700
Message-ID: <20240331172652.14086-2-rdunlap@infradead.org>
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

Fix kernel-doc warnings, text punctuation, and a kernel-doc marker
(change '%' to '&' to indicate a struct).

timecounter.h:72: warning: No description found for return value of 'cyclecounter_cyc2ns'
timecounter.h:85: warning: Function parameter or member 'tc' not described in 'timecounter_adjtime'
timecounter.h:111: warning: No description found for return value of 'timecounter_read'
timecounter.h:128: warning: No description found for return value of 'timecounter_cyc2time'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

 include/linux/timecounter.h |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff -- a/include/linux/timecounter.h b/include/linux/timecounter.h
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -22,7 +22,7 @@
  *
  * @read:		returns the current cycle value
  * @mask:		bitmask for two's complement
- *			subtraction of non 64 bit counters,
+ *			subtraction of non-64-bit counters,
  *			see CYCLECOUNTER_MASK() helper macro
  * @mult:		cycle to nanosecond multiplier
  * @shift:		cycle to nanosecond divisor (power of two)
@@ -35,7 +35,7 @@ struct cyclecounter {
 };
 
 /**
- * struct timecounter - layer above a %struct cyclecounter which counts nanoseconds
+ * struct timecounter - layer above a &struct cyclecounter which counts nanoseconds
  *	Contains the state needed by timecounter_read() to detect
  *	cycle counter wrap around. Initialize with
  *	timecounter_init(). Also used to convert cycle counts into the
@@ -66,6 +66,8 @@ struct timecounter {
  * @cycles:	Cycles
  * @mask:	bit mask for maintaining the 'frac' field
  * @frac:	pointer to storage for the fractional nanoseconds.
+ *
+ * Returns: cycle counter cycles converted to nanoseconds
  */
 static inline u64 cyclecounter_cyc2ns(const struct cyclecounter *cc,
 				      u64 cycles, u64 mask, u64 *frac)
@@ -79,6 +81,7 @@ static inline u64 cyclecounter_cyc2ns(co
 
 /**
  * timecounter_adjtime - Shifts the time of the clock.
+ * @tc:		The &struct timecounter to adjust
  * @delta:	Desired change in nanoseconds.
  */
 static inline void timecounter_adjtime(struct timecounter *tc, s64 delta)
@@ -107,6 +110,8 @@ extern void timecounter_init(struct time
  *
  * In other words, keeps track of time since the same epoch as
  * the function which generated the initial time stamp.
+ *
+ * Returns: nanoseconds since the initial time stamp
  */
 extern u64 timecounter_read(struct timecounter *tc);
 
@@ -123,6 +128,8 @@ extern u64 timecounter_read(struct timec
  *
  * This allows conversion of cycle counter values which were generated
  * in the past.
+ *
+ * Returns: cycle counter converted to nanoseconds since the initial time stamp
  */
 extern u64 timecounter_cyc2time(const struct timecounter *tc,
 				u64 cycle_tstamp);

