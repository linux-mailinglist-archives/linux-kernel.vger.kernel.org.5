Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEC7EB84D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjKNVNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:13:05 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A46D3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:13:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8d9dcdd2bso126727917b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699996381; x=1700601181; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kP7vFMucwkO9DgpHTpA5ugmcWvw1owRDA2lNLDfZSQ=;
        b=pTnaNVkntULJMaYde3U1icGxyOhz8/3y4ftmBt34UBiC1OqHuvGIv/Z2qHSBfOy6za
         tNF8fdPlzGxgV8u7gHpkBLyF42Cd4OEBlT22av8MaWFnTTdcZ9kmyzIMm28W1RIn0lXg
         Qk3HxupPv7+byexmBsmPgDqxQy+HWdf47LVf/nDJoYge4/LIgjO68SyEyyIOG7fGtjTk
         FtATpJqO0ueinNe2DJxDVqn/3ZTuq8ROXy+zWwgtEazlPp7ZezUGcooF/iTrxmV1Oh5F
         KLK5UheXHDKxVTNtGVG2xY3cDAtruZyKmfpC8R7bPGZzbfTnVb/FTZ2kUUgP9juWBPUO
         3orQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996381; x=1700601181;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kP7vFMucwkO9DgpHTpA5ugmcWvw1owRDA2lNLDfZSQ=;
        b=to6CP0gx2CJhNadRAb23Kn/JaERkZ80tzVwdttgn3lRwbgf4KeKrdSZ/qgyYRuwGtN
         Bv5QvRquvHGvcMb4b2s7hMZI/MTNtpxWJymClsSbtZenHzUI7jHLjICAvkk4X2xkGvx2
         ctnPnxLdokRJpRWKgFkZn0Adl/sVTu4xLLmCLfosSRMGUPnV3db+MtKCrBHoq01y8jil
         62RuNUW8GmL8ocUl4YybLJJtvNBqRgRWDMatta3KNblo6kRhZvEnPnrI4d9xzB2kdODH
         rtaRYH2qJymXK0h5mbwgMDFwDQqMe8XxxBuMq8Y6jsq1DcI5TBpAS7jTjUdQz+vzo6dx
         Q7og==
X-Gm-Message-State: AOJu0YzGyyB6//QmY9zzqNmzlYx250ppl/u3l9WYI2l0MCBiwpwrCykt
        EEwb6yBg3TxSsQ/XaeR36278zSE+rmH2
X-Google-Smtp-Source: AGHT+IGZmYT/3dxnbJaR+KEJM8cQwHyZ+q0FuLosgPSaZhyfvwiC48S7AEMtCug4qEUgkvyR5CzYtP2hfGRK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2838:18b7:26f1:2c68])
 (user=irogers job=sendgmr) by 2002:a25:6ad7:0:b0:d9a:50d2:a8be with SMTP id
 f206-20020a256ad7000000b00d9a50d2a8bemr260648ybc.1.1699996380803; Tue, 14 Nov
 2023 13:13:00 -0800 (PST)
Date:   Tue, 14 Nov 2023 13:12:54 -0800
Message-Id: <20231114211254.3137289-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [RFC PATCH v1] perf evsel: Fallback to task-clock when not system wide
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the cycles event isn't available evsel will fallback to the
cpu-clock software event. task-clock is similar to cpu-clock but only
runs when the process is running. Falling back to cpu-clock when not
system wide leads to confusion, by falling back to task-clock it is
hoped the confusion is less.

Update a nearby comment and debug string for the change.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a5da74e3a517..e1175313e4bc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2861,18 +2861,19 @@ bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 	    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
 	    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
 		/*
-		 * If it's cycles then fall back to hrtimer based
-		 * cpu-clock-tick sw counter, which is always available even if
-		 * no PMU support.
+		 * If it's cycles then fall back to hrtimer based cpu-clock sw
+		 * counter, which is always available even if no PMU support.
 		 *
 		 * PPC returns ENXIO until 2.6.37 (behavior changed with commit
 		 * b0a873e).
 		 */
-		scnprintf(msg, msgsize, "%s",
-"The cycles event is not supported, trying to fall back to cpu-clock-ticks");
-
 		evsel->core.attr.type   = PERF_TYPE_SOFTWARE;
-		evsel->core.attr.config = PERF_COUNT_SW_CPU_CLOCK;
+		evsel->core.attr.config = evsel->core.system_wide
+			? PERF_COUNT_SW_CPU_CLOCK
+			: PERF_COUNT_SW_TASK_CLOCK;
+		scnprintf(msg, msgsize,
+			"The cycles event is not supported, trying to fall back to %s",
+			evsel->core.system_wide ? "cpu-clock" : "task-clock");
 
 		zfree(&evsel->name);
 		return true;
-- 
2.43.0.rc0.421.g78406f8d94-goog

