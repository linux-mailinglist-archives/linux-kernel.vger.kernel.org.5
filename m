Return-Path: <linux-kernel+bounces-126326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 642AA89353A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BA11F22DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C46145B3B;
	Sun, 31 Mar 2024 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aFpQS0UT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547D01EA8D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711906016; cv=none; b=GXqdWltEhgubypagV5g5WZUG3chv1b5wNQaPe87cGS1OvhtcS5g+76GJ/bpOva8qbw0f6PtzFrEN9G/PlIqu48oYa3AzQ/dBie8ETA64fh8D+r4WxcemXVfP+lFL3FhkTABg6smcFK+jhRpigScrNGEPZGPQr2RYBYPfUTy/zAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711906016; c=relaxed/simple;
	bh=TV7JArJeGMulN+QQsz02pqS2z0ww4bvfCNp2JuM+1xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9T0pDqJh2ZwYa6HIQSrx6LSZzDDwsDZrV28vDBOv/a1QRa+G64EgqC590EFPpwiG5+4gJ+F/vXzepKZabvGSENkbVjwHVHnWEgUeb1aekA3jcz41Q7eV/76LyVxaSfC0lzDhsTfAwCq3WOihZOJ1EsMrpgHh30pFzSMBrnAxB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aFpQS0UT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qlg3Nt+11yULrnicVlQq2cb2pvFeGjW+6iEj3UlWyVk=; b=aFpQS0UTI//Z3cFIt6OR5GiJ5O
	nJ/TWFsFatfn/a+EAO5BA+hZJF6Pe9yCdU/xm8KphN6s0MEzn1voI2UlY3yJ7TF62YloNytS2+h0z
	1tOqpEFIBX/vrW3JTeNUYu4uy3rJoLlItuGgEBLREXIq2RgCHXWvbyCTJEs3tvnmoC8RjLPx2VxR0
	u2b1Ayr2IIuqN4OqVT+ltcoYH8rTQrqBEyfOpSJDoFE6asnKJSPu8LiDbyQ74xAiJfjNG7/ezUOd9
	Abld6ybcwZdinQb6qy1/CKUcmzvRae6QsW3K6iX/DYelcfo9ynCsrAy1vYF+4QLT3zNoqbcsQnXWk
	/Xr2rD7w==;
Received: from [50.53.2.121] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqyxK-00000005z30-2uVi;
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
Subject: [PATCH 2/6] time/timekeeping: fix kernel-doc warnings and typos
Date: Sun, 31 Mar 2024 10:26:48 -0700
Message-ID: <20240331172652.14086-3-rdunlap@infradead.org>
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

Fix punctuation, spellos, and kernel-doc warnings:

timekeeping.h:79: warning: No description found for return value of 'ktime_get_real'
timekeeping.h:95: warning: No description found for return value of 'ktime_get_boottime'
timekeeping.h:108: warning: No description found for return value of 'ktime_get_clocktai'
timekeeping.h:149: warning: Function parameter or struct member 'mono' not described in 'ktime_mono_to_real'
timekeeping.h:149: warning: No description found for return value of 'ktime_mono_to_real'
timekeeping.h:255: warning: Function parameter or struct member 'cs_id' not described in 'system_time_snapshot'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>

 include/linux/timekeeping.h |   49 +++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff -- a/include/linux/timekeeping.h b/include/linux/timekeeping.h
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -22,14 +22,14 @@ extern int do_sys_settimeofday64(const s
 				 const struct timezone *tz);
 
 /*
- * ktime_get() family: read the current time in a multitude of ways,
+ * ktime_get() family - read the current time in a multitude of ways.
  *
  * The default time reference is CLOCK_MONOTONIC, starting at
  * boot time but not counting the time spent in suspend.
  * For other references, use the functions with "real", "clocktai",
  * "boottime" and "raw" suffixes.
  *
- * To get the time in a different format, use the ones wit
+ * To get the time in a different format, use the ones with
  * "ns", "ts64" and "seconds" suffix.
  *
  * See Documentation/core-api/timekeeping.rst for more details.
@@ -74,6 +74,8 @@ extern u32 ktime_get_resolution_ns(void)
 
 /**
  * ktime_get_real - get the real (wall-) time in ktime_t format
+ *
+ * Returns: real (wall) time in ktime_t format
  */
 static inline ktime_t ktime_get_real(void)
 {
@@ -86,10 +88,12 @@ static inline ktime_t ktime_get_coarse_r
 }
 
 /**
- * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
+ * ktime_get_boottime - Get monotonic time since boot in ktime_t format
  *
  * This is similar to CLOCK_MONTONIC/ktime_get, but also includes the
  * time spent in suspend.
+ *
+ * Returns: monotonic time since boot in ktime_t format
  */
 static inline ktime_t ktime_get_boottime(void)
 {
@@ -102,7 +106,9 @@ static inline ktime_t ktime_get_coarse_b
 }
 
 /**
- * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
+ * ktime_get_clocktai - Get the TAI time of day in ktime_t format
+ *
+ * Returns: the TAI time of day in ktime_t format
  */
 static inline ktime_t ktime_get_clocktai(void)
 {
@@ -144,32 +150,60 @@ static inline u64 ktime_get_coarse_clock
 
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
+ * @mono: monotonic time to convert
+ *
+ * Returns: time converted to realtime clock
  */
 static inline ktime_t ktime_mono_to_real(ktime_t mono)
 {
 	return ktime_mono_to_any(mono, TK_OFFS_REAL);
 }
 
+/**
+ * ktime_get_ns - Get the current time in nanoseconds
+ *
+ * Returns: current time converted to nanoseconds
+ */
 static inline u64 ktime_get_ns(void)
 {
 	return ktime_to_ns(ktime_get());
 }
 
+/**
+ * ktime_get_real_ns - Get the current real/wall time in nanoseconds
+ *
+ * Returns: current real time converted to nanoseconds
+ */
 static inline u64 ktime_get_real_ns(void)
 {
 	return ktime_to_ns(ktime_get_real());
 }
 
+/**
+ * ktime_get_boottime_ns - Get the monotonic time since boot in nanoseconds
+ *
+ * Returns: current boottime converted to nanoseconds
+ */
 static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
 
+/**
+ * ktime_get_clocktai_ns - Get the current TAI time of day in nanoseconds
+ *
+ * Returns: current TAI time converted to nanoseconds
+ */
 static inline u64 ktime_get_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
 }
 
+/**
+ * ktime_get_raw_ns - Get the raw monotonic time in nanoseconds
+ *
+ * Returns: current raw monotonic time converted to nanoseconds
+ */
 static inline u64 ktime_get_raw_ns(void)
 {
 	return ktime_to_ns(ktime_get_raw());
@@ -224,8 +258,8 @@ extern bool timekeeping_rtc_skipresume(v
 
 extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
-/*
- * struct ktime_timestanps - Simultaneous mono/boot/real timestamps
+/**
+ * struct ktime_timestamps - Simultaneous mono/boot/real timestamps
  * @mono:	Monotonic timestamp
  * @boot:	Boottime timestamp
  * @real:	Realtime timestamp
@@ -242,7 +276,8 @@ struct ktime_timestamps {
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
  * @raw:	Monotonic raw system time
- * @clock_was_set_seq:	The sequence number of clock was set events
+ * @cs_id:	Clocksource ID
+ * @clock_was_set_seq:	The sequence number of clock-was-set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
  */
 struct system_time_snapshot {

