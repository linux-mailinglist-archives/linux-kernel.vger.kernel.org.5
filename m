Return-Path: <linux-kernel+bounces-55971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0158984C44B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947DE1F22CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A83A1CD22;
	Wed,  7 Feb 2024 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAWCn+j+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1151BF2A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282348; cv=none; b=j0/C8pUpUEx5eEBjWzEaaf6xe6FuALyvyynz6tF46dY8FW7vab92WqdM4Eg4T+5uiOtqCkUp6TkzAuIVJumDxNz6dc6ArE5V1RRj1KF8A1lMOxw121w/6QsgHqdvmv2IMuDKWcsCHxLQBKscF6oo4wnw5GNmVEJNyjqN7AP487c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282348; c=relaxed/simple;
	bh=kszq7JTJ0izFmA3dEnHIYYpS4Gc5cJ814paQQQK3LdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa+2p+MwJwGtc2/zVWz01xC5yckUJ4ZBtstuav7RWh+yfs0lDKtREgnEHAbazlqtfLQxPAQ9y4oZN6ScWIMRJ2zq6r4jUATS8+GARa1Y9vRipNa6EcwRSaqhy9lm3xp0uyz5gBdTUmYgfGFKtNwZTj6rdd0SXz2fFxa0NmrBwFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAWCn+j+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1C0C433B2;
	Wed,  7 Feb 2024 05:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707282348;
	bh=kszq7JTJ0izFmA3dEnHIYYpS4Gc5cJ814paQQQK3LdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bAWCn+j+L1BWHH13FMmywdVETL8buIVosxRSzgI11eOwAlxLd44oeJN9G5ySGB0Ac
	 E76K3MNjOIJt8zTzUmgfWDqvwLSG2FPY6UestKKjQZdHS8CWs1drqVdTcb+5jXQddd
	 bryoNNDgf2/GafEo7IfQ5mJv1jFGgj/RMnyanwRG8PSLdUaARFxozQTiug54DCEcDj
	 ejP3QeL1JBjW60YIeh9UaI6NRLGZObI5GjVQ/WqfBHNMX4U6gSNXNOIY1Cd/vLS8Wk
	 7LBO40dkNwb36eltl7FBnMgu4/cbAKOOi4EkUg1uRdNQz9MKd9tomLzU5gowQ/Kzyb
	 uiRukxKTM84Vg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH v3 2/2] perf/core: Reduce PMU access to adjust sample freq
Date: Tue,  6 Feb 2024 21:05:45 -0800
Message-ID: <20240207050545.2727923-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240207050545.2727923-1-namhyung@kernel.org>
References: <20240207050545.2727923-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In perf_adjust_freq_unthr_context(), it first starts the event and then
stop unnecessarily to adjust the sampling frequency if the event is
throttled.

For a throttled non-frequency event, it doesn't have a freq so no need
to adjust.  Just starting the event would be ok.

For a frequency event, whether it's throttled or not, it needs to stop
before adjusting the frequency.  That means it should not start the
even if it was throttled.  I tried to skip calling the stop callback,
but it didn't work well since the event count might not be up to date.
It should call the stop callback with PERF_EF_UPDATE anyway.

However not calling start would prevent unnecessary MSR accesses (which
can be costly) for already stopped events as stop state is saved in the
hw config.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
Ian and Kan, I decided to leave your Reviewed-by here since it's the
basically same.  Please tell me if you don't agree.

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e9ce79c8c145..940c3a5b57b7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4121,7 +4121,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			event->pmu->start(event, 0);
+			if (!event->attr.freq || !event->attr.sample_freq)
+				event->pmu->start(event, 0);
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)
-- 
2.43.0.594.gd9cf4e227d-goog


