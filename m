Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1E7F201D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjKTWTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjKTWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:19:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C374ACA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:19:34 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc4f777ab9so38675465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700518774; x=1701123574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6XC8XlavK49xNjfUz810sKQmeHvQWvE5qIjS3kpF1wE=;
        b=Mm5lJ0bvDxChRHIn951jLh/fx2lDrdn/3fJ1BotetQ0vSkNo2i/D8qsxVEWl0LfwED
         uEwoNnxwaRZFjmb3y+PrbGY3pXDobRwNUNbJNDgSQ+ZiXS/sQUQOeY2xvQEcFENDJhPy
         kbVi8/VJ8dz8vBQMTXqMIFpIobxtMOAruHJiKtJWWo2oJduKIpuI0iEtSg2J1IpfUz0D
         0eUhnLa4Yhn33355fjyoJQV4XObXSH5gfd730YJzwA2kucmCSnpUl//WOsPZGcIfDXYh
         NGubz5RxoDCNSTTvg7mDaelhDnnoqaaMdNZt7GA2J1rJ6t9cN4zfWFMYneYRiaZtl/CF
         eGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700518774; x=1701123574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XC8XlavK49xNjfUz810sKQmeHvQWvE5qIjS3kpF1wE=;
        b=r3B9OTVJlUwBWTWrpfT5bLn8fAErAy32nE+uE/llHOElz1ygiyuEcrSPUucvdQDxdB
         U6BvRUlvr/jwNIRi2YaAxKXphsgOAYnGVcA6f2jMRTVwi0Z1cJ5LjCmQMDn+UGZcqDpT
         WhqH6bbz2+cRRAfqRGDwNaFdTw/XjMKoQiR7VVrB0CuF8s2ltcvATvT8ijHRLXq3GAe5
         Xw01uA0qACy/jbik/jzw2Kuw31GefJYnYZ8W9RXmmukPZyLyMGgOsb0vccJvvI1oARr0
         zKS5Llg4gAB5qZp3iX9U1X6Zymfduj3/T+1vz1/HOOAG486qzeAZTJLco1ae9JxcH9SZ
         Qykg==
X-Gm-Message-State: AOJu0Ywfsil389fUsKTAAHWWwP+qFd0mI/euV0fqo7CBe/e8BbgW++Dr
        RmTQ6KeEZuwqCXve63PCay0=
X-Google-Smtp-Source: AGHT+IFuEeyNkpbzidUieEr6QpjMxpck9ZE5u1U2WE3sm7A94zjw7799boAgafS9rqFPZH2tFJMgRw==
X-Received: by 2002:a17:902:b486:b0:1ca:e78b:35dc with SMTP id y6-20020a170902b48600b001cae78b35dcmr6445266plr.27.1700518774127;
        Mon, 20 Nov 2023 14:19:34 -0800 (PST)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:75c6:4212:ae99:93b6])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902c18400b001c9c47d6cb9sm3528246pld.99.2023.11.20.14.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:19:33 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: [PATCH 1/3] perf/core: Update perf_adjust_freq_unthr_context()
Date:   Mon, 20 Nov 2023 14:19:30 -0800
Message-ID: <20231120221932.213710-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was unnecessarily disabling and enabling PMUs for each event.  It
should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
at each PMU.  As pmu context has separate active lists for pinned group
and flexible group, factor out a new function to do the job.

Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
even if it needs to unthrottle sampling events.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 68 +++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0367d748fae0..3eb17dc89f5e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -879,6 +879,7 @@ struct perf_event_pmu_context {
 
 	unsigned int			nr_events;
 	unsigned int			nr_cgroups;
+	unsigned int			nr_freq;
 
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3eb26c2c6e65..53e2ad73102d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2275,8 +2275,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu--;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq--;
+		epc->nr_freq--;
+	}
 	if (event->attr.exclusive || !cpc->active_oncpu)
 		cpc->exclusive = 0;
 
@@ -2531,9 +2533,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu++;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq++;
-
+		epc->nr_freq++;
+	}
 	if (event->attr.exclusive)
 		cpc->exclusive = 1;
 
@@ -4096,30 +4099,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	}
 }
 
-/*
- * combine freq adjustment with unthrottling to avoid two passes over the
- * events. At the same time, make sure, having freq events does not change
- * the rate of unthrottling as that would introduce bias.
- */
-static void
-perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
+static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 now, period = TICK_NSEC;
 	s64 delta;
 
-	/*
-	 * only need to iterate over all events iff:
-	 * - context have events in frequency mode (needs freq adjust)
-	 * - there are events to unthrottle on this cpu
-	 */
-	if (!(ctx->nr_freq || unthrottle))
-		return;
-
-	raw_spin_lock(&ctx->lock);
-
-	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+	list_for_each_entry(event, event_list, active_list) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
@@ -4127,8 +4114,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		if (!event_filter_match(event))
 			continue;
 
-		perf_pmu_disable(event->pmu);
-
 		hwc = &event->hw;
 
 		if (hwc->interrupts == MAX_INTERRUPTS) {
@@ -4138,7 +4123,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)
-			goto next;
+			continue;
 
 		/*
 		 * stop the event and update event->count
@@ -4160,8 +4145,39 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 			perf_adjust_period(event, period, delta, false);
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-	next:
-		perf_pmu_enable(event->pmu);
+	}
+}
+
+/*
+ * combine freq adjustment with unthrottling to avoid two passes over the
+ * events. At the same time, make sure, having freq events does not change
+ * the rate of unthrottling as that would introduce bias.
+ */
+static void
+perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	/*
+	 * only need to iterate over all events iff:
+	 * - context have events in frequency mode (needs freq adjust)
+	 * - there are events to unthrottle on this cpu
+	 */
+	if (!(ctx->nr_freq || unthrottle))
+		return;
+
+	raw_spin_lock(&ctx->lock);
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (!(pmu_ctx->nr_freq || unthrottle))
+			continue;
+		if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
+			continue;
+
+		perf_pmu_disable(pmu_ctx->pmu);
+		perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
+		perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
+		perf_pmu_enable(pmu_ctx->pmu);
 	}
 
 	raw_spin_unlock(&ctx->lock);
-- 
2.43.0.rc1.413.gea7ed67945-goog

