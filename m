Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF087782D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjHJVuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHJVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:50:10 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3938ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:50:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so17727117b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691704209; x=1692309009;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igst4mk2Qe0yy+cOTE8q+SB7QjnlDxT/LagI8IxyHvs=;
        b=1Uh56WiLkoyMI5VvuQ64Fkl3EL0jo1oj3OUQZspMOCcGeQn1Z6MqFewMaAPYVc2J7o
         GkjBsp00AuA3CGVqZ2dkDm8HR1hjHNxwwIBiYlZio4VvZH5or4SpIxGnx0Uha/FmP8Xn
         HUPmripMAou5hS/8lKfpSQl1lwYOzrJ5jGysvXq0qeRrlYzUPVbfT+9ALqyXNrkJc56U
         /Ga/aScGDvGubfT8S3612p/aPhIZJ6syAh9UF8v2Nn3m2hjeR9HY1JgH/riCquwasQz3
         DFbCnUVs/8qGv0tFo3GRHE5QWUcSC2rIOCtEU1lGi8vWdyXjeFJqViqVNrWWddBHijKW
         R4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704209; x=1692309009;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igst4mk2Qe0yy+cOTE8q+SB7QjnlDxT/LagI8IxyHvs=;
        b=GScdGwFIUs2Fa78VJL+dfhhrhdfgkKY/x+D1GJrRFMMDCoxR/moooh1+fxajibDN8f
         YEAkIRQdp4LjjlkDjrbboo15IZEjIv8PjGyjbqlgWEtlJPY2BcQ7TnWgXn9nz1p6XyYo
         dT4TkMBE9HMAYuwwnnI7/3DmtknQ+Mb88nIqDPhjLX/onLgtsUmZXXOAkKZTrCEw9vkt
         ax2M2yhEe7HyJ6JzvFRP5tWbBvJ6sn/RV+ucLMwSrTB18eBX/wgWM1ce7vjdM62eBJSq
         2PIhSk0YlzaFOI+PD2FwQbL9tU4GADqF8HiaBa/ddj6rVnPo48XFqdcWhIwIw0igkynD
         QCWg==
X-Gm-Message-State: AOJu0YxwPUfGufLoXfTaU/Nf1+FcSo3qQG2qexctlTujjTPMo2h2Yq83
        Pad39GA4Ci27nEILu3fWS6o9m1yLHtO2
X-Google-Smtp-Source: AGHT+IHqVFGK64ooHjYnqb74yHRXIzY5S8RKU8bRuw3+8hqn+avf1VIEUlEkbcFNHzS4NKdKdZJHa5r2QZM0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a25:e750:0:b0:d0e:e780:81b3 with SMTP id
 e77-20020a25e750000000b00d0ee78081b3mr58676ybh.2.1691704209270; Thu, 10 Aug
 2023 14:50:09 -0700 (PDT)
Date:   Thu, 10 Aug 2023 14:49:51 -0700
In-Reply-To: <20230810214952.2934029-1-irogers@google.com>
Message-Id: <20230810214952.2934029-3-irogers@google.com>
Mime-Version: 1.0
References: <20230810214952.2934029-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v2 2/3] perf pmus: Add scan that ignores duplicates, use for
 perf list
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple PMUs that differ only by suffix, by default
just list the first one and skip all others. As the PMUs are sorted,
the scan routine checks that the PMU names match and the numbers are
consecutive. If "-v" is passed to "perf list" then list all PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      |  8 +++++
 tools/perf/util/pmus.c         | 54 ++++++++++++++++++++++++++++++++--
 tools/perf/util/print-events.h |  1 +
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 7fec2cca759f..8fe4ddf02c14 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool default_skip_duplicate_pmus(void *ps)
+{
+	struct print_state *print_state = ps;
+
+	return !print_state->long_desc;
+}
+
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
@@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
 		.print_end = default_print_end,
 		.print_event = default_print_event,
 		.print_metric = default_print_metric,
+		.skip_duplicate_pmus = default_skip_duplicate_pmus,
 	};
 	const char *cputype = NULL;
 	const char *unit_name = NULL;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3581710667b0..5073843aca19 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+	int last_pmu_name_len = 0;
+	unsigned long last_pmu_num = 0;
+	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
+
+	if (!pmu) {
+		pmu_read_sysfs(/*core_only=*/false);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	} else
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
+
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			unsigned long pmu_num = 0;
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
+
+			if (last_pmu_name_len == pmu_name_len &&
+			    (last_pmu_num + 1 == pmu_num) &&
+			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+				last_pmu_num++;
+				continue;
+			}
+			return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		unsigned long pmu_num = 0;
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
+
+		if (last_pmu_name_len == pmu_name_len &&
+		    (last_pmu_num + 1 == pmu_num) &&
+		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+			last_pmu_num++;
+			continue;
+		}
+		return pmu;
+	}
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
@@ -429,10 +473,16 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	int printed = 0;
 	int len, j;
 	struct sevent *aliases;
+	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+
+	if (print_cb->skip_duplicate_pmus(print_state))
+		scan_fn = perf_pmus__scan_skip_duplicates;
+	else
+		scan_fn = perf_pmus__scan;
 
 	pmu = NULL;
 	len = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = scan_fn(pmu)) != NULL) {
 		list_for_each_entry(event, &pmu->aliases, list)
 			len++;
 		if (pmu->selectable)
@@ -445,7 +495,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	}
 	pmu = NULL;
 	j = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = scan_fn(pmu)) != NULL) {
 		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index d7fab411e75c..bf4290bef0cd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -26,6 +26,7 @@ struct print_callbacks {
 			const char *expr,
 			const char *threshold,
 			const char *unit);
+	bool (*skip_duplicate_pmus)(void *print_state);
 };
 
 /** Print all events, the default when no options are specified. */
-- 
2.41.0.640.ga95def55d0-goog

