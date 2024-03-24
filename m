Return-Path: <linux-kernel+bounces-115614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B8988A43A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF2B2F184
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E9F348F80;
	Mon, 25 Mar 2024 02:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCIYgJtS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2BE130E3F;
	Sun, 24 Mar 2024 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321386; cv=none; b=NU0e/OGicQuZZ3LzTJ0dyjW6VOChz3YOUiAtwcDmJuMMlsfXods3JosRRRrW/1PUjDrfqrdFxjsc7HeQS1KS4RDb2xaP84FJfLL/d/De5qfE6VdAdy2cNPK1XtVay5rGNrw9PSEAaROiGSus5SpJOaJYYzQHQ9LPD+cle8OBWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321386; c=relaxed/simple;
	bh=OrTxKuavkmAwp8h1Jo3aMTmD6H5/LjHaoUEWZ+XZ/aQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ct704qs07dNBUnudzv1MaASDGppHviUbV5MA4SCeK3S1BMe5yjp3L19bWXH9cjklQctlZRMh9DVDtDGeUXzm1jrBfTVqTqH2wm6RovOkMTKy+NGCQmQjkN5E4VK2CFXwO3cd1zQm2OpqmxoRPIhtYLaPoTzoU2bHLFM3m/PzTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCIYgJtS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE603C43601;
	Sun, 24 Mar 2024 23:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321385;
	bh=OrTxKuavkmAwp8h1Jo3aMTmD6H5/LjHaoUEWZ+XZ/aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qCIYgJtSq6R0MN6X29Xm9uVWEvgBy6rO3z1FxDBM+XijDoHK/xJrvBYPX5lvB2qSz
	 Qf9U4OU60Dyj75lVuMRi30BaWr+o+H2hAm9KynWwKqJU7QK+oJL/tdIwACYXBzGSE1
	 NJdjmvyTadiS/bCSiIscKQvkruPf8yQcYsWrU81CUqlE/MXU+o0uLjB+DJgXdC52C4
	 /PA0iCAsv/DeTa9PPVhxs1AYalX01RI+qN4fgYRKSfDlRDVTJCz1oRbUzVGRLiJ3g+
	 N5cCqsAa8/aPsV9zkzhZJE1A9ZOVdXsA2HaOcbAPuu4Dzwlc5gsRtbcuLxeCh6gnFS
	 nEPLrlw6tCR8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 109/638] timekeeping: Fix cross-timestamp interpolation corner case decision
Date: Sun, 24 Mar 2024 18:52:26 -0400
Message-ID: <20240324230116.1348576-110-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 8f35455b62509..4e9f2f88c9d6e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1180,13 +1180,15 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
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
@@ -1246,7 +1248,7 @@ int get_device_system_crosststamp(int (*get_time_fn)
 		 */
 		now = tk_clock_read(&tk->tkr_mono);
 		interval_start = tk->tkr_mono.cycle_last;
-		if (!cycle_between(interval_start, cycles, now)) {
+		if (!timestamp_in_interval(interval_start, now, cycles)) {
 			clock_was_set_seq = tk->clock_was_set_seq;
 			cs_was_changed_seq = tk->cs_was_changed_seq;
 			cycles = interval_start;
@@ -1277,13 +1279,13 @@ int get_device_system_crosststamp(int (*get_time_fn)
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


