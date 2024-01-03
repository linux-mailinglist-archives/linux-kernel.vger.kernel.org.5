Return-Path: <linux-kernel+bounces-15784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96203823214
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A774F1C234E2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A11C28A;
	Wed,  3 Jan 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMrS1hVs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D091BDFD
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f325796097so37397467b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 09:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704301345; x=1704906145; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DZnRxlTdDAoebH3N02PoiIrttaLFmicjC7EGKLpzd7g=;
        b=AMrS1hVsypUT4Ur9rJ4iDeSscL+0S7gzu60dJKIDWV1Pe6GWaCsVj6RY/ubhKUBIBl
         SwdLCHJfbG9KVKMKAwbgcU/Q8T1LEa91xWtBp/3gzUNYHeKXCfDgjdOrffaH5QZwEyRd
         +nX/YqFNo1qOOtB41gvl2kIUUAoAkRhFEwSXmlXHyLo4Lo5E54T3e6U/Al86SkPRGXCh
         D/io7/+Gr6IXAI7XO7us7Ef/wi330nzx8ZuEeXSZGqMnHsYZ+6asrdZlagDFPXlMLaw/
         121Vm5b5adCcIrUbupXHBxQ7Bray5BTI7auO2gvwu9zCs3GFvePsUqiUNdrQNQOkcUSo
         Dc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704301345; x=1704906145;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZnRxlTdDAoebH3N02PoiIrttaLFmicjC7EGKLpzd7g=;
        b=vwe2wjfBfp7PBtF4HmUERxvuALIgIXVlAgSbQeeBDm6rHvKGRFoN1VN/mB59oIT50M
         ToF1eFKj+OoHsr60q3rg/R+Hb3lRYf2NvX65gacgGLb8dR2dmOJF8BTYCqctMdlWlfGd
         MvNwQtKJiAPO6wZouuIdd/3zB+R65whCtjapNgfaWC9PZ8SAC309VCbOq6HL9e8I6e9l
         VcdQZkrmCvJgFMBM+urJXrvsj4KDMEjcL1cNcn4L1THD4yATLXjhgfvnzh+LHQMUD1TF
         rhzHreHt56UxFtL/ypO5QbocPhFW9G/O6TKTdKmTB3W3rl985/MzsZBVuJ8v8yH1N3jM
         2VNg==
X-Gm-Message-State: AOJu0YyiaKRI9yq+laGSMFJoDzBXpzmBoqcWETtGfjUllaKvrZJS5kYI
	eYhAFXBEwBEyTP9czMWoAkyKY34wQ06bogpM8vs=
X-Google-Smtp-Source: AGHT+IGwptcaetFy/hbwadjuFRa4NZpFOy+Sv6NfGbNOUZm9VNYtBhhcQA6COEuTLEhoTUEDYMB4aGRar62h
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f607:7105:a86e:433f])
 (user=irogers job=sendgmr) by 2002:a05:690c:4443:b0:5d3:a348:b0c0 with SMTP
 id gq3-20020a05690c444300b005d3a348b0c0mr10000295ywb.5.1704301345330; Wed, 03
 Jan 2024 09:02:25 -0800 (PST)
Date: Wed,  3 Jan 2024 09:01:58 -0800
Message-Id: <20240103170159.1435753-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH v2 1/2] perf x86 test: Update hybrid expectations
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The legacy events cpu-cycles and instructions have sysfs event
equivalents on x86 (see /sys/devices/cpu_core/events). As sysfs/JSON
events are now higher in priority than legacy events this causes the
hybrid test expectations not to be met. To fix this switch to legacy
events that don't have sysfs versions, namely cpu-cycles becomes
cycles and instructions becomes branches.

Fixes: a24d9d9dc096 ("perf parse-events: Make legacy events lower priority than sysfs/JSON")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/lkml/ZYbm5L7tw7bdpDpE@kernel.org/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/hybrid.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/tests/hybrid.c b/tools/perf/arch/x86/tests/hybrid.c
index eb152770f148..05a5f81e8167 100644
--- a/tools/perf/arch/x86/tests/hybrid.c
+++ b/tools/perf/arch/x86/tests/hybrid.c
@@ -47,7 +47,7 @@ static int test__hybrid_hw_group_event(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	return TEST_OK;
 }
@@ -102,7 +102,7 @@ static int test__hybrid_group_modifier1(struct evlist *evlist)
 	evsel = evsel__next(evsel);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong hybrid type", test_hybrid_type(evsel, PERF_TYPE_RAW));
-	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_INSTRUCTIONS));
+	TEST_ASSERT_VAL("wrong config", test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS));
 	TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
 	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
@@ -171,27 +171,27 @@ struct evlist_test {
 
 static const struct evlist_test test__hybrid_events[] = {
 	{
-		.name  = "cpu_core/cpu-cycles/",
+		.name  = "cpu_core/cycles/",
 		.check = test__hybrid_hw_event_with_pmu,
 		/* 0 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/,cpu_core/instructions/}",
+		.name  = "{cpu_core/cycles/,cpu_core/branches/}",
 		.check = test__hybrid_hw_group_event,
 		/* 1 */
 	},
 	{
-		.name  = "{cpu-clock,cpu_core/cpu-cycles/}",
+		.name  = "{cpu-clock,cpu_core/cycles/}",
 		.check = test__hybrid_sw_hw_group_event,
 		/* 2 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/,cpu-clock}",
+		.name  = "{cpu_core/cycles/,cpu-clock}",
 		.check = test__hybrid_hw_sw_group_event,
 		/* 3 */
 	},
 	{
-		.name  = "{cpu_core/cpu-cycles/k,cpu_core/instructions/u}",
+		.name  = "{cpu_core/cycles/k,cpu_core/branches/u}",
 		.check = test__hybrid_group_modifier1,
 		/* 4 */
 	},
-- 
2.43.0.472.g3155946c3a-goog


