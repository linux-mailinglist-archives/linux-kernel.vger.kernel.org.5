Return-Path: <linux-kernel+bounces-115057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18CF888E31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6016DB247F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3CA28702A;
	Mon, 25 Mar 2024 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7auashi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4612888E3;
	Sun, 24 Mar 2024 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324027; cv=none; b=rAEOdaKbtnuhFomRJXTwuOpME1bfGWG2xewsf5cQhYOVlGhp3qKaMMnTkplkCKvT77nINlHyk+4kXcSzvoWymt+uaheVf1hhXke8lrb6SLVIunrfYGEIVlJF5FhnXFQFzjlpsJsk5uYkM10yRlmZb+S6lJWn0eFHHUnEqNNBPJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324027; c=relaxed/simple;
	bh=dyyCUNazY7Cg9l+p9muz7oGAYXN3AL7zZVHcER5BY7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSkeOVGApCf186Q0PPgMAnRnX43yjA3HvJuxPph+/sY1jnYGcFKzNUOhfkmvJDIrDQ1XDbyr/JRKYdLu1x0zl2PmKGcq9ij+hZ0jeAIddOglNCd7YY8jCpEeFjZUeijvVfrj+D4jiNYi7+zK6VBtex2a9+KfBj/7g6u1eQX/dOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7auashi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D354AC433C7;
	Sun, 24 Mar 2024 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324026;
	bh=dyyCUNazY7Cg9l+p9muz7oGAYXN3AL7zZVHcER5BY7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7auashiPodmZHpXURtqMzVd1QqPOk0yd26+z0s1ZFVsbo2HH7B3ztI/hEIzpjwWq
	 4dfBXXSx+IE7bO9L6R2zfrKw/LOf1K+He94L6RGMDR8rDBT8sqYoyXWM8ZuZTqZs3N
	 lXU4VwFA+cXh7iF2YMczzo2LMezAy4wYpXNmqTMcNIqGPv93aVVft5ataQLG0raDCg
	 y5MCgCjH7iTBoWA+/MV6WC7HrZPUVD/hpUQHUM4T6XlrDMUa7XJBUwNoBEDmxyha5c
	 o0hjmmlFpedA7PXJuqiqWm3Xa+yo6YlJ8XYeZ32UGXI1899YarmACKzel2RerCLii4
	 J6wLR+bDicADw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 027/183] timekeeping: Fix cross-timestamp interpolation corner case decision
Date: Sun, 24 Mar 2024 19:44:00 -0400
Message-ID: <20240324234638.1355609-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Peter Hilber <peter.hilber@opensynergy.com>

[ Upstream commit 87a41130881995f82f7adbafbfeddaebfb35f0ef ]

The cycle_between() helper checks if parameter test is in the open interval
(before, after). Colloquially speaking, this also applies to the counter
wrap-around special case before > after. get_device_system_crosststamp()
currently uses cycle_between() at the first call site to decide whether to
interpolate for older counter readings.

get_device_system_crosststamp() has the following problem with
cycle_between() testing against an open interval: Assume that, by chance,
cycles == tk->tkr_mono.cycle_last (in the following, "cycle_last" for
brevity). Then, cycle_between() at the first call site, with effective
argument values cycle_between(cycle_last, cycles, now), returns false,
enabling interpolation. During interpolation,
get_device_system_crosststamp() will then call cycle_between() at the
second call site (if a history_begin was supplied). The effective argument
values are cycle_between(history_begin->cycles, cycles, cycles), since
system_counterval.cycles == interval_start == cycles, per the assumption.
Due to the test against the open interval, cycle_between() returns false
again. This causes get_device_system_crosststamp() to return -EINVAL.

This failure should be avoided, since get_device_system_crosststamp() works
both when cycles follows cycle_last (no interpolation), and when cycles
precedes cycle_last (interpolation). For the case cycles == cycle_last,
interpolation is actually unneeded.

Fix this by changing cycle_between() into timestamp_in_interval(), which
now checks against the closed interval, rather than the open interval.

This changes the get_device_system_crosststamp() behavior for three corner
cases:

1. Bypass interpolation in the case cycles == tk->tkr_mono.cycle_last,
   fixing the problem described above.

2. At the first timestamp_in_interval() call site, cycles == now no longer
   causes failure.

3. At the second timestamp_in_interval() call site, history_begin->cycles
   == system_counterval.cycles no longer causes failure.
   adjust_historical_crosststamp() also works for this corner case,
   where partial_history_cycles == total_history_cycles.

These behavioral changes should not cause any problems.

Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supporting slower devices")
Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231218073849.35294-3-peter.hilber@opensynergy.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/timekeeping.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5ae2b5b5ce4a0..2a43c26e913e9 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1093,13 +1093,15 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
 }
 
 /*
- * cycle_between - true if test occurs chronologically between before and after
+ * timestamp_in_interval - true if ts is chronologically in [start, end]
+ *
+ * True if ts occurs chronologically at or after start, and before or at end.
  */
-static bool cycle_between(u64 before, u64 test, u64 after)
+static bool timestamp_in_interval(u64 start, u64 end, u64 ts)
 {
-	if (test > before && test < after)
+	if (ts >= start && ts <= end)
 		return true;
-	if (before > after && (test > before || test < after))
+	if (start > end && (ts >= start || ts <= end))
 		return true;
 	return false;
 }
@@ -1159,7 +1161,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
@@ -1190,13 +1192,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		bool discontinuity;
 
 		/*
-		 * Check that the counter value occurs after the provided
+		 * Check that the counter value is not before the provided
 		 * history reference and that the history doesn't cross a
 		 * clocksource change
 		 */
 		if (!history_begin ||
-		    !cycle_between(history_begin->cycles,
-				   system_counterval.cycles, cycles) ||
+		    !timestamp_in_interval(history_begin->cycles,
+					   cycles, system_counterval.cycles) ||
 		    history_begin->cs_was_changed_seq != cs_was_changed_seq)
 			return -EINVAL;
 		partial_history_cycles = cycles - system_counterval.cycles;
-- 
2.43.0


