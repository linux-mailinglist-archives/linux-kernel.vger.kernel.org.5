Return-Path: <linux-kernel+bounces-24057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6745382B62B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3FF1C23A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D705811F;
	Thu, 11 Jan 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPc4/CVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2165810F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87E1C433A6;
	Thu, 11 Jan 2024 20:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705005830;
	bh=A4VhAo2thc3VPIG5HMtbRNaNrF0RwGaTT512LSk8+14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPc4/CVBLd0WDTsE0CfRKBMLzKaJeYqEHgLAuo4IPCFvh2RmzP4+fv2iLEsKFJC2X
	 ytStGdLBRCGiYpoeIvv6NEr98BoxG3yXGNAoS6TTFIqmLhhwy53zgp2wBUTRxiAsjP
	 bgpqdpDzaeZk6rHBh+vqJsrINIaTU4mBzTZlYCaEoIrH02qIdZ8nSXFsWgaYla1vl0
	 cWb2wCdeaq4nrhRdV2rDB3Dqb3TdhGgr7lLu1KK8+cM3by12769l2pmuSJfb4YwfMT
	 wsn6G07+eRM4zMStXioTAeguASBOxljBw+HoIMY4r6JwRt0X/aadSAoUBF3c/atWC5
	 /IOlL39X2X4uw==
From: namhyung@kernel.org
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v2 2/2] perf/core: Reduce PMU access to adjust sample freq
Date: Thu, 11 Jan 2024 12:43:48 -0800
Message-ID: <20240111204348.669673-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240111204348.669673-1-namhyung@kernel.org>
References: <20240111204348.669673-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

For throttled events, it first starts the event and then stop
unnecessarily.  As it's already stopped, it can directly adjust
the frequency and then move on.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e9ce79c8c145..243cd09ba7fe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4121,10 +4121,15 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			event->pmu->start(event, 0);
-		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
+			if (!event->attr.freq || !event->attr.sample_freq) {
+				delta = 0;
+				goto next;
+			}
+
+			if (event->hw.state & PERF_HES_STOPPED)
+				goto adjust;
+		} else if (!event->attr.freq || !event->attr.sample_freq)
 			continue;
 
 		/*
@@ -4132,6 +4137,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		 */
 		event->pmu->stop(event, PERF_EF_UPDATE);
 
+adjust:
 		now = local64_read(&event->count);
 		delta = now - hwc->freq_count_stamp;
 		hwc->freq_count_stamp = now;
@@ -4146,6 +4152,7 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (delta > 0)
 			perf_adjust_period(event, period, delta, false);
 
+next:
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
 	}
 }
-- 
2.43.0.275.g3460e3d667-goog


